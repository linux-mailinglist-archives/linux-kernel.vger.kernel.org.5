Return-Path: <linux-kernel+bounces-125052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61226891F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FDD1F2FE21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02C85629;
	Fri, 29 Mar 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhU5rtPP"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCF55B1E6;
	Fri, 29 Mar 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717456; cv=none; b=DOWZk0Cmp0iT1BhBHVSQoZQGoQAjQl1/oIGVUE5Mqv+pCkLitgVkZT9b+uojBIM7wLdMDH+AjmKEHnof6LkJM13V5KNZvs5u/eVJ3GmwSrulmMx96VFPRBe5MeSYV+8cqRpLereiGf0YzIQ/Rqf8DJX40YVcdif4ytEoJ1STbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717456; c=relaxed/simple;
	bh=HK+pW1Lv5cKPG7rzuoUit2Wj63jl66zbNwCyYBCxG3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMPtijCeK2Am3ydp20eGFc2wtJNvsFdwUE5uiyMOvXzi35sG/mgM/xYmODoKA90j/G+cEgZyeqKeaZLUSJpee7AGFiabmDb6vg1o+fRSVuzaVwaRPiAkjx8uOK1sVZhY9Dyq5VO2P69gwkLQDUUrQbs7CfNZDC/oPUa3k//4Qgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhU5rtPP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso1548614a91.0;
        Fri, 29 Mar 2024 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711717454; x=1712322254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENCOr2sA1qbshksM0GrDXVMpVc6dVoIzN1WRClTF0qw=;
        b=lhU5rtPPjppdj/CnvUmHEJBRy6uw0Z0Hfzgb9+IQjP+N+VeCGb9EeuV9i8Cac4AvwQ
         4Zof98r6BoPRAczgax4/QfCDNURGRK/8rZ7ckcnqno4OiA40d78iH21tuzDiRZVfkg1B
         1c2LhwcS5X28wQ60N8EmqzxKaKA817jsXcSsqhvSV5J/tD0sLeK2jOx2Y6UQjSuiP5sB
         WPyKpS58x9EuQX9h6jiD/xdCUAJK9/RczQfW79S9G0+GwmzvitqwH9zsNOJRoto+7zxc
         r/WR1/jbjeOwQ8NhBwU6h8HY9SXZGA9k33qABk1ds8NGeUE3A39biCLYPuZHY6UKmRL3
         wGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711717454; x=1712322254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENCOr2sA1qbshksM0GrDXVMpVc6dVoIzN1WRClTF0qw=;
        b=ZUVC6W9mcOEZ4F2Bv0t4vrVlzykK3cHKqjOCIru4n57kQWEe4iHmKktSRDlVQBjxET
         lvnz/W2sSTz3DaoEhYYIyRYEiA0RngTVGHQyR/MKu/3ZBM9hQudVUtwq2rPgQLrsBc8k
         m27fI67nJHM1s3B0OgZ7YcQWNQLUrMpsAoi9GNVY4QPXis4zzYMBb5UuuGfWh0sk+cqk
         STG83pPzyZSKSSdORo1W5vPjbWz23KAtVMnEMSN6Jq9sGg5u4ZVa917B7drqESx9DsY7
         pLBq/ijoULn4YVqCLyfurlj/grZm+18PtZdneWl9Xez0rnyoOuEf6yZ4rUHl1mdod4Rr
         +NAg==
X-Forwarded-Encrypted: i=1; AJvYcCXMLQEOZSvObMipzLE8luxKMHQER3wyG5p7i8BjHc8ygm3UxdWP6jeq+xh+/YBHqodHM1TdUXXR63dUyPxZ3e5+3Q11nePNapG92utVn/G67++VLqCcAfayVVtRipUxKgsrEdD6J5HfY2hUtZ8=
X-Gm-Message-State: AOJu0YzF/aQnzmsbGh64DqDgpzoKYyePP7tQtBeFLbxEDQD8g+QeRsq7
	Qby9Iez/JUr0cHvSCBh25kWzJM0Lu+BU/WP3GQKoTGw1xjbowbaw2r18TAHiJiiUFpM1jCFresS
	gvCR5d/Yv2XOVU1cgZjNXmeFcbmU=
X-Google-Smtp-Source: AGHT+IGbsz/GfbSim5fxK+qHD5P3CZN6CHz4jdK38k7IiMbNqgQTqHeSVSATZ+6GtAVQqObA3FZjqKl+K0pYO5bt840=
X-Received: by 2002:a17:90a:dc05:b0:2a0:4de8:875f with SMTP id
 i5-20020a17090adc0500b002a04de8875fmr2303229pjv.8.1711717454485; Fri, 29 Mar
 2024 06:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com> <20240329121033.401403-1-kernel@valentinobst.de>
In-Reply-To: <20240329121033.401403-1-kernel@valentinobst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Mar 2024 14:03:40 +0100
Message-ID: <CANiq72mkHM3qfq66oDZyZMCuLK8Y1tJxEqFhSYpFWg7ihfcvEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] In-place module initialisation
To: Valentin Obst <kernel@valentinobst.de>
Cc: wedsonaf@gmail.com, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, walmeida@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 1:11=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> I think the idea in [1] was to have this patch being included in the
> stable trees. I got little experience with stable trees but wouldn't the
> easiest way be that you add:
>
>         Cc: stable@vger.kernel.org # 6.8.x: 715dd8950d4e rust: phy: imple=
ment `Send` for `Registration`
>         Cc: stable@vger.kernel.org
>         Fixes: 247b365dc8dc ("rust: add `kernel` crate")
>
> in the sign-off section for this patch? (Or mark the first one for stable
> inclusion as well, [2] has more information on that).

715dd8950d4e is your local hash for 1/5, right? So I would drop the
hash, because it may be confusing.

It may be possible to remove the first line (since 1/5 will only apply
to 6.8.x and it is already the previous patch in the series, while the
`Fixes` tag here may make it clear that 2/5 should still go everywhere
regardless of 1/5), but I guess it does not hurt to be extra clear.

What about:

    Cc: stable@vger.kernel.org # 6.8.x: rust: phy: implement `Send`
for `Registration`
    Cc: stable@vger.kernel.org # 6.1+
    Fixes: 247b365dc8dc ("rust: add `kernel` crate")

Cheers,
Miguel

