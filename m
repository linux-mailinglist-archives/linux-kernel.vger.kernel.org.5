Return-Path: <linux-kernel+bounces-109834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92D885641
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6ED1C2127A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A641C73;
	Thu, 21 Mar 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT83Ttyj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A612B81;
	Thu, 21 Mar 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012418; cv=none; b=APGqdi39imQx1BZ57f85YSMZGY3d7jFaxyjfaDuUQ73JtjTTiKoDPcUJanJO/TFDlwCyZqsHsbpqHvpOtX1RS5KLCR/aX6oQJ1MVBx9Cv6mMaTR/AitxJ1LZwWvwMY7iU1+rzpEZ9y0WCf4XaVpyhl9a/WM3uyBae7zWoFEziJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012418; c=relaxed/simple;
	bh=0WGf5ZBm03nwzd9rinCCaBGVduGXtNXEkarX6ZlpYsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYivrOH/ocwVsQUo/dWPxIn+jpwgxz6d2NqaIL+nFkrpijIUt9H3ElesOvBMSOCvDUZkpx22Zjgh4dkmb5G8FJ7F6y1wKB4ZaXuOdVf+pYCajF7d6AcxTM1h11Wkx00Z+VnenMv0t/CDU5CrECZz/wa2hkdFsUDG247LGNvQKII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT83Ttyj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e034607879so5476835ad.0;
        Thu, 21 Mar 2024 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711012416; x=1711617216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nes78up99EiE9h0M639AFK21t634+dlUJNnADmOZ5TM=;
        b=UT83TtyjVihMppn+U+hVg3eHjgo2a+DCmTc4K18BMkWkAmxfCFOhHbapSnkVTM5BsV
         bnutWjpU9edei97AJKMDWCmVseBF2vaFvBRDWzFo60PJwVrHcZddwCVk/ONuP9JqHajN
         1brqIan4PJLeLG3vwY7F6qTzXzZz51emvE4CRra/wkt2fHT7AW9Cs0ctYS48M+v/Ta4P
         PFqvAPPVDziYDCI7PAix2rAIa7ZODi75+NksZpm31Gzb+8RH614IOSmzT+BhhWzfr51S
         ZvGe604hrmpjXYf2yya45e5o61aT6dnUqp0x7Ja6tziDfBzM9VFABP8LFVh33BlsjjxH
         eLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711012416; x=1711617216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nes78up99EiE9h0M639AFK21t634+dlUJNnADmOZ5TM=;
        b=F2qHimGZoTz3P5V2//6nwShYxt5G5oN7qPd/1IhZSeLXt2ODSfnHyeU7WTDiOhDN7b
         8zdi8O6E4C/Mt6EsKckSK259l4zVxL3dw41CXlCXxrRKz01Vy00lKXpUnWmPiW/CrnHR
         Ottgjg+qw4P2xh9chEuik/BzaoPYk/TctPXgN9VQgkXQ+FN658uiw3TZPH/kxl0kr5YL
         zdykBFUjRUcXpblq7qUJc7FAb3IYybnJhyYDwbcUbvO/PjRd1ieCjxm02Nq7fRyTAffz
         n0GhPh01xaWmRYhceWQ6rkzNSdCXbRCaG9BoRHeNRO7edle5663R7OlI1nTkU5yn5tVI
         FRjA==
X-Forwarded-Encrypted: i=1; AJvYcCUflFWDiMBH5iIB67nREGoBMgK0Utfu2NubsGIz8N1f4xip+MXSczVXyatVWNv2VSBbhn/wGz5SrAW9pWear3vqjRiIBC7T/Df/HttPMnmAeSJ0MYgEJ6fVKN7YCfQyUtV1nrrwW3Ww8egb54mdt0PBOW/dyQ6GTLDpEzWK2zYkzE1zdII=
X-Gm-Message-State: AOJu0YwKRk5/wiGpzqIt9EG+QJRJ800D0+X+6Dd9iCLlCs0HYBdPdT3i
	7dWAlL4y3VVu41jocZM9WqQj0GSPQheXJ0xM1cP6zxQjDaHqoaHfNrPR3tQOlRwb/YBNDBdR+nj
	OWbyt5CCm+Ags/gKzFpGir1U3D6rttDipznYB8g==
X-Google-Smtp-Source: AGHT+IEc3sbuxLIEXLcNo9hvlvsrCEfAQbe8858Zyh5kZvdTHTT+txNlarkGx3oYaQLqT3cV8SP642r7siWWZIPoOdM=
X-Received: by 2002:a05:6a21:a5a4:b0:1a3:53ae:80c7 with SMTP id
 gd36-20020a056a21a5a400b001a353ae80c7mr10352067pzc.7.1711012052876; Thu, 21
 Mar 2024 02:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313230713.987124-1-benno.lossin@proton.me>
 <Zfh5DYkxNAm-mY_9@boqun-archlinux> <93FD9491-7E2D-4324-8443-0884B7CFC6EF@me.com>
 <ZfkW8rwpdRc_hJBU@Boquns-Mac-mini.home> <3FBC841A-968E-4AC5-83F0-E906C7EE85C3@me.com>
 <6857bb37-c4ee-4817-9b6a-e40e549b6402@proton.me> <F1F3C985-9CAE-4286-B236-4AF6C0918DB5@me.com>
In-Reply-To: <F1F3C985-9CAE-4286-B236-4AF6C0918DB5@me.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 21 Mar 2024 10:07:09 +0100
Message-ID: <CANiq72mAA0d41arVo6q2S6gk2sRMfAyW1FOHhUMytMQeYtNjhQ@mail.gmail.com>
Subject: Re: [PATCH] rust: init: remove impl Zeroable for Infallible
To: Laine Taffin Altman <alexanderaltman@me.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:53=E2=80=AFAM Laine Taffin Altman
<alexanderaltman@me.com> wrote:
>
> I=E2=80=99ll try and do it myself; thank you for sending the first round =
for me and illustrating procedures!  What Reviewed-By=E2=80=99s/Signed-Off-=
By's should I retain?

For the Signed-off-by, only yours is OK. For the Reviewed-by, it
depends on how much you have changed, i.e. whether you consider their
review does not apply anymore -- please see
https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statemen=
t-of-oversight

Cheers,
Miguel

