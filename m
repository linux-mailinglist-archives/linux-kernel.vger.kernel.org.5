Return-Path: <linux-kernel+bounces-140264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F98A10EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB71C236F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A01474D7;
	Thu, 11 Apr 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aREPE02u"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A2146D79;
	Thu, 11 Apr 2024 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831930; cv=none; b=c4K4SoifsI0TT1/MDKe756llmhYQkxNvocmXHkFwF8bWcFNoEJTlmGZrV9H4d3jw1NtFcLtmg6ypN5G5CQFkKbAYfY4+xlLfcjKi7+heV8FJJeYaHanly5c7OGTMF1T+w+NOCG0zTkP8/mgB1Cs1eKrXbtlsfPiUl/c+bjHFzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831930; c=relaxed/simple;
	bh=S3EnvtuyYtFeIGGg+yieue5MCm9+2L7bEad8M+DUDzU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=o18Sm2L3E3dL51aaTPhbs2UTfbX+Jb3sIigSFWfh5TmKvyRjDZLrQwHNtbQnJ1o+Zw31ZVa253qExRe8Aoq4dWyd3Cw5YJyvdGBirxLcgRkCG5Uw3nur96b9Hx8y4wVww/kJJHW7/PFTgRaERxg0N4BG8fMiIk84l1sSppEMeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aREPE02u; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b16b614d7so23206126d6.0;
        Thu, 11 Apr 2024 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712831928; x=1713436728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S3EnvtuyYtFeIGGg+yieue5MCm9+2L7bEad8M+DUDzU=;
        b=aREPE02uXScs3bpNOcInvqBj/kzBHtrobIAhR/wKZ1O/V9begT/Qyqw3iO07lIDR7i
         o0KLsuf1l7Avc/TiGJDwKjPbfBfarBZAW8GnZ1m2c6rhn4fz5dD9kZf5PBGGFE30TTqq
         tvcW2ZW4iYax0N+gSXFNeYfvT/xRAD5UP2rNvK6wersSZ9Bx49bbE+xYz2uvbQj24iF7
         L6LV11O0cRFWC3UX2b3uBWTOA6Ankt9faRwxbii+vy+Tzhj8tjRWhNQTQal/IL2rPdA8
         b80lAjSgKmqxH5WmiK5SZzGswAK5woGS82BBeHEdqXqDKCqbiqFrZqiPZDwbMQ5Uc+Qv
         xsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712831928; x=1713436728;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3EnvtuyYtFeIGGg+yieue5MCm9+2L7bEad8M+DUDzU=;
        b=sKxiQsZlkjJqEUkgt88Nv8oHi9eyxRE67S/SY1aXkZ0Mu715r1FdDBgfBjf3o2lNmT
         YDY0/sBj5GsLkMTHJdTMLoaVzAzE2xKC9NAM8xqKdxnndn4sX8PQ1JY4ONYjZREuh3qa
         2mN5abTd3RhHDhx5SWyds6To2UI8YZW17Kmme5EdQpGu8jSYhgntWG/t3C3zC1inPXbS
         0UflcHYxyUU1xteuS/nvDhzQF2Q0Js1DEg3Ay0RgJHqDAhZ8T4IPMPmFSktHMkmC5TEU
         fbhZ2VJ86WaqdWASPk7eE0+ilUak5WrcL2b80TjLoO/DhncS7TK+h2lgOF/iqQHf92Bk
         SUVA==
X-Gm-Message-State: AOJu0YzRa59mdaWr71MIL9eTuoKze12Wc2R1ALGoPkN9gRO37irzl6gT
	BlUTI4r72gaVNN6/aMJ/L6RGM92CUPRnOoedPSjrD3uVkOB6qYKhC0yKMc3cmthLUS16+Ml4St+
	b/lb/+SA/hhVuBrlV/EGHuLWUmBsz7ly4
X-Google-Smtp-Source: AGHT+IGKyCB41Zdd3jYn8ZbHw+oT56fA4l4siWPS9idn7ExPoMq2Uw2PmVhl4wp4X67csv9pKVVIhL9A1JXBo3tTNOY=
X-Received: by 2002:ad4:5b8d:0:b0:69b:2446:2f03 with SMTP id
 13-20020ad45b8d000000b0069b24462f03mr4570250qvp.28.1712831927708; Thu, 11 Apr
 2024 03:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Thu, 11 Apr 2024 11:38:36 +0100
Message-ID: <CAK2bqV+kpG5cm5py24TusikZYO=_vWg7CVEN3oTywVhnq1mhjQ@mail.gmail.com>
Subject: RE: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Linux Stable <stable@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The SCSI sg driver oopsed on my 6.8.4 kernel, and I noticed that a
patch (presumably) to fix this was pulled from 6.8.5. However, I also
noticed this email:

>> Reverted this patch and I couldn't see the reposted warning.
>> scsi: sg: Avoid sg device teardown race
>> [ Upstream commit 27f58c04a8f438078583041468ec60597841284d ]
>
> Fix is here:
>
> https://git.kernel.org/mkp/scsi/c/d4e655c49f47

Is this unsuitable for 6.8.6 please?

Thanks,
Chris

