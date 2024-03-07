Return-Path: <linux-kernel+bounces-95732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AFA8751DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE5C1F2637A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D212E1D2;
	Thu,  7 Mar 2024 14:27:35 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A612D775
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821655; cv=none; b=t93GosW12cEnppaAiw+HaQSK15uYVgFeYV+LX0FutrhTf5eHUr/Z00MRZKwR+lbPXNbgXWUcAv0uF0to6wx6htQb0/ap5p48hM/MTnd6+mHf/BzDMZ7vDooXPwhQCHUCrRJMWJpxDVWVb8obQqWXB5G8y2y+ntXOFHW/paHCdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821655; c=relaxed/simple;
	bh=wE/0lOTfGFzUn6G1MEw6iK6h6UCVuBRvP8Ecw6IOUQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWmNzoOD4JhTwOHEylSsz6KcokGSqAYonZFwm/z/yZNvTnC1HpTYvHarYkxAU6L3yQeeKXmZJcIG9IPH91Ukrji+76daFlcDc9x1E5uWg3p+xTe0YDig7GnklJCNi628rudS3pgx285EG8yN2+avRaCa7DHBmtMv1TVhInHbPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-21fb368b468so473266fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821653; x=1710426453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz2eNH3ByABvVgHFT0hkzZRhLZmSUzNFJzczzdfYHaw=;
        b=bavhgl0o1OgGUNANA689ek+EFwOk41Gyxv8uJjJPDZ8XDYCYHIapEvILqSpoxiVrMI
         3TfQQtQfjHPJQ3pqVLMrLdxXGFIOIzCKPe4ffYqvxPCgxI41tjDJlxZDi/SITRGm5Et/
         AqvqoEsudwebVKdNZtN68BZ5SZaoE3SAxNh3dWh6rptbZ9roiQOHOvGEFzlMbBorJhNW
         JWQ96wCo5P6/VkcSR8KPivLzqabt9MD9IB3mwStvzScmf3fyVzoZPZHkOqfz61EcaG14
         wqSjSkftpFIZXdYXiizFpR5ekJjFLivFqfX7SVYRTZARHt+PnmSQIYpn2x6KPSZSqWzw
         rPlA==
X-Forwarded-Encrypted: i=1; AJvYcCUtPwi22Nu0A4BaqElGZbhkeHhLUUOcCP+YWEH/Xy5Q7LOPOshyBj2aQtn3sEIS2enxxZF8cI9bHNe/ZLq0yhnZ/pOSrwcGu3JXPGUp
X-Gm-Message-State: AOJu0YwhtYZyMp8s3qQEbR0K1MyH789foU+eiuUrtijVP6TFIIj7sxGH
	AVbnLmM9+ZLs7vfgmvY5HxNaRSDJKRwmoiCSAn8FtoHlDyM2bQDO5eoonVrpqVRo7DTOgJYPBDR
	Wnw4GX2alsAUSkuDMS/6uYa1zE6U=
X-Google-Smtp-Source: AGHT+IGqfSUTe7mCD0pnZ/JliykSKoembhWqBxpNjNgmBqhFl8UiprBe2mqJOT+9O7kdEW/FaIX7LFRTHGa5Bc1mBEU=
X-Received: by 2002:a05:6870:3123:b0:21f:d2e1:c93c with SMTP id
 v35-20020a056870312300b0021fd2e1c93cmr8436495oaa.45.1709821653127; Thu, 07
 Mar 2024 06:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
In-Reply-To: <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 7 Mar 2024 09:27:21 -0500
Message-ID: <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown timeout
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, maxg@mellanox.com, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:29=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com> =
wrote:

> > Some words are alarming in routine kernel messages.
> > "timeout" is one of them...
> >
> > Here NVME is routinely setting a timeout value,
> > rather than reporting that a timeout has occurred.
>
> No.
> see the original commit message
>
> "When an NVMe controller reports RTD3 Entry Latency larger than the
> value of shutdown_timeout module parameter, we update the
> shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
> informational debug level instead of a warning level for it."
>
> So this is not a routine flow. This informs users about using a
> different value than the module param they set.

I have machines in automated testing.
Those machines have zero module params.
This message appears in their dmesg 100% of the time,
and our dmesg scanner complains about them 100% of the time.

Is this a bug in the NVME hardware or software?

If yes, I'll be happy to help  debug it.

If no, then exactly what action is the informed user supposed to take
upon seeing this message?

If none, then the message serves no purpose and should be deleted entirely.

thank you,

Len Brown, Intel

