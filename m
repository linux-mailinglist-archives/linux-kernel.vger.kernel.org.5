Return-Path: <linux-kernel+bounces-94082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B58739A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4644A1F24CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60812134CC2;
	Wed,  6 Mar 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgjC564m"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAB12FB31;
	Wed,  6 Mar 2024 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736368; cv=none; b=UZmlK42dY8bALi6VE3kQ1BN1fVpjfJzkhffk6FMuLwRtFbyPcvYwprQM0QRQMsdexx4dndlexBRaJLa+kUVPZAjZrL0PU+Mlmdvc2miG3iaQB8As2dgg28CzOjLWKRw/R0q3JUorFKJYAfbFLHoP5jFlwEir4Zx4se4+Fse+S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736368; c=relaxed/simple;
	bh=COl5M+rVP9u4QPQOiCzll/KMvAZ7JBerPGfF56CFrZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkOYi5cqGeKQ/WSoh34/YIVmtykKbQlDB84uQmI36CB6TaIFeZq7+kZER/DUhaVmUjC2LIbUr6zym14CPJwtE0zUdJCPqEgL1IrgwI4Gj/HXdW/vzN3DETRGhvRh2AQsNq/ltQ7pW0y5KiVqkCJHtg2VgFp5quGv15NMpROI4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgjC564m; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d3fb16f1a9so9612631fa.0;
        Wed, 06 Mar 2024 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736365; x=1710341165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COl5M+rVP9u4QPQOiCzll/KMvAZ7JBerPGfF56CFrZ8=;
        b=kgjC564mlM5R6C3IKYzFwglVzCbeQzLQmePg79e2hBVPBFcu+nwQSIpJrH+ATnxqyl
         t/P1kbUZ8kQCRUs8Qfkq5HbdBqAg+u6WvcHmUSP2Q5aIp70KQ9yWC2DNUVr0FvJxcdgK
         PvCr0TBn9cYPIIedwILQAGp1fYBTGCzWjDPuhaB7Ihwcyp/q3eGD/MefI4Ne4A4WqMbT
         IExIz3rRfdqAZTTy6/a7qpHMQJVmuKwmwIJiKj2BetHVpf2BmSWUhWxuZ6meo5d3seoO
         VXkmQ9Sc53Mmd6xakkhEFuyNIrJPFYxwXXTuIRe8G8wnoMFrzmUGeTVHQ8RLo0kvZGEp
         kjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736365; x=1710341165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COl5M+rVP9u4QPQOiCzll/KMvAZ7JBerPGfF56CFrZ8=;
        b=SLxsRttaWNBgj7nhl2pk+m3lGwFABvyHuo5F3Lqd5xF8vkduhAfIybvhdLd9PjWubS
         iKlUgnzU5CqO53HyfXNQChH/L74NtImuScr9DlFDZ+eojfJlg9Cp+H83znTsAQLN5mZM
         mdIPaWqEjo/iW9gp+Sd2qDaGp0/oB3p7bc+YKqwD1ccVIe7GoLMibI8vSMo8DzGP1iOJ
         1nVN9XXl+B4Xrz5Prpy59NELvUEN3VQwgQ00QgyPqxZiZmkgEUBpyq7OVjYWyOzR+LTI
         qeT0/dSBDqmMJxng//wFg42w+cvtXkelL3O+9s4OFeALTPTPfxJ0HyaFUfIiwWmrgaML
         ib5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbCUxMESeSnWkpPi9aUjdomGCzGaMTexpPPZQf8uOwZ+2LaKHVJ2bu0CRr7cGjKtHnbbicrTgsbAXy5yzxZtsn1j4k6pEc1MS3uN47
X-Gm-Message-State: AOJu0YwuhiXMmrCyvgMlAXnbxe0IAFefTARciK8dkzwPGUpHXzEyTdgs
	LOBX9lxEET2Rmgh4grCXd/+5QsHCBEFjHGzXuSTDYfEdLhV2iJlPBJxDQ2zRKzm8VQ9ygrJ1rvQ
	O5kv7YCCEQRsW7zvgB5zuHd/7lp4HK5z6w4k=
X-Google-Smtp-Source: AGHT+IFgFUrYp4bK4A6/E0QlupuiFelUo2EwC+ZLBLZi5Gow4kzuwrMAmmTkLmxbq3oqhSo67tp7MORcJgvdFFIK1Z4=
X-Received: by 2002:a2e:7006:0:b0:2d2:4477:6359 with SMTP id
 l6-20020a2e7006000000b002d244776359mr1755152ljc.7.1709736364621; Wed, 06 Mar
 2024 06:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229121650.33983-1-thorsten.blum@toblux.com>
 <CAKFNMomtp7ZwB0gmxoemp_ums4rqOSbfF2BMS6kX+LwtKYtvCg@mail.gmail.com>
 <19910196-DFF3-4F94-B6D3-B9BF722DF8B8@toblux.com> <BFEA2A31-3147-49EF-A9BE-592C90E783DD@toblux.com>
 <215C3176-D6E5-47CF-BC48-7A75CF75CE3F@toblux.com>
In-Reply-To: <215C3176-D6E5-47CF-BC48-7A75CF75CE3F@toblux.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 6 Mar 2024 23:45:48 +0900
Message-ID: <CAKFNMo=324Wq9NHPKNXf07w9tpGrE8bp=Rf-AiHqnM7VqbTZPg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Use div64_ul() instead of do_div()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:15=E2=80=AFAM Thorsten Blum wrote:
>
>
> > On Feb 29, 2024, at 21:40, Thorsten Blum <thorsten.blum@toblux.com> wro=
te:
> >
> >> On Feb 29, 2024, at 20:41, Thorsten Blum <thorsten.blum@toblux.com> wr=
ote:
> >>
> >>> On Feb 29, 2024, at 19:45, Ryusuke Konishi <konishi.ryusuke@gmail.com=
> wrote:
> >>>
> >>> All of the fixes in this patch seem to be correct, but this doesn't
> >>> cover nilfs_resize_fs(), nilfs_max_segment_count(), and
> >>> nilfs_sb2_bad_offset(), which also have do_div() that doesn't use the
> >>> return value.
> >>
> >> For nilfs_sb2_bad_offset(), where the dividend is u64 and the divisor =
is u32, we
> >> would need a dedicated function like div64_u32() that doesn't calculat=
e the
> >> remainder, which doesn't seem to exist. What do you think?
> >
> > Never mind, there is div_u64(u64, u32). I'll submit a v2 shortly.
>
> I left nilfs_sb2_bad_offset() unchanged in v2 because div_u64() still cal=
culates
> the remainder.
>
> Thorsten

I got it.

I reviewed and tested the v2 patch and it was fine, so I sent it to
the -mm tree.

Thanks,
Ryusuke Konishi

