Return-Path: <linux-kernel+bounces-119522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DC888CA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A176A1F67528
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822B1CAA0;
	Tue, 26 Mar 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjnM1/ep"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1271CFBB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472042; cv=none; b=mDFJTSVF33JzLh8npjpdygQd93n55v3Vw2P+/Zs1pO06hRm0jM3jIgLPbzScyRYBtWpW9bPSFaBUbj4q7g+jAoGmrQgjvAFrj/wJ0/716aBICKJi/T26pORVmd9oCRLFLVaoQJ0CbhLoxzfvRk/k9DmpPex5Gjy9nPGRRk60774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472042; c=relaxed/simple;
	bh=+wwoWjN1YwmUOAFeG3ynPy+pz8TjZeWB36Mypw07xro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekjc/KWdAGhyzUS5Y6g8rvs2Yyvd7vV/+C1TwH+FiwVVlVK642V9LoYTHYKrVBN/amReeVPH8hOrNUrBwuNPdWptyPngvGDSolVJnEvptP0COm24NPVnde/1lkcD6fd5L4NVgdXqXSFitEv0+w6oeABDysZgjCe6eBCy67ubdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjnM1/ep; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2980606a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711472040; x=1712076840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t11QCUWfmd+nyP0xdTPwxlB0/6v6Tz8ppRiV86S/Tcw=;
        b=XjnM1/ep2bAMkmAlQf6LHU/BxxAn6fb9/NG+H00c9hPYwUNs0hb9tpEzHewIpN8FgE
         qJnJj+KwKRQy7uPnt3QSzQ40qhSJQFMMEFyRtFBa1aXkzRTekRjHRdfsC3g3Jp+wbI5j
         i81ezwkkUta1n5M/M0504D9W4LRsrqDFUEXh02/5ozEdM5+UQ0h17nHf1I964v8fTBem
         8s1KFIUrKVwHyz8NPUdb8V5vxFg9QK7JjW0WkLklk0YpQsXkX1+/JDsysVGYI9Dfj6/+
         ZJWeg1fLkxkMtGKs+KysmR87V2eg6z/gIjNie1Pq+TH0Dt+fu7HFzCVBYAvWQr/T5mOT
         1KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472040; x=1712076840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t11QCUWfmd+nyP0xdTPwxlB0/6v6Tz8ppRiV86S/Tcw=;
        b=nk/aXCM1Ge9x8NSnUs4ctj+BngNa9yEl+8Aa6xFm0vXgLd8PqcpbIgct6Mqg0Ob3ll
         jaBB8GYD8XBpPbyuTsxemtMT1mDBpbtgHufd96w8nR6jwGWK4xRBsC6a7BwSdWhzCaPG
         /fKZmki4/8rCp2+/kWRqDPyX5nlmLBbLV/11efs5iatAmmS23FQoblc3E53fH6vc4oj0
         h3YWt/BKBf26lVVA9GCTLjrtGCIQd/16F/oTbKAMM7bPUbvD2jDH2WDs6DNge8r2KWMT
         L8lF1inCXL3ahPVvoIMxULUkB0zZrrtf7jOHv/qtYjeMGDl7ajPwctC1XmdZbMCoFW7g
         XJyw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ86vksbTEz1Pa+FLKiq3RAV0PycupTOj+4XSOvpsaHJ02waPZX2n2xMrF1EOEsE8TGpQkxv6kakUkvpU8E6CJgeZzserQc56dZNNL
X-Gm-Message-State: AOJu0Yxo4aZABi30y8X6bsRVoSBTKMvCq2P0xHO16xPr/hKWiawMASdN
	mU85FYQfDHir0jTI3cG9UHPTnJfWyU8ONofyfBrmqGqT00ko8xfjIL7Wf2fd02j1JYgkF/UsMlI
	DSIAriAxW23bKlfnxOFs7UHu5DOM=
X-Google-Smtp-Source: AGHT+IFtWAEzhIPMNoFBSEntuEwU3Hqapb1b1h4hN9tob/9RjINt3JfIqdvs1LLqudNz8iSJVELcF2O02oRH6GLLlsM=
X-Received: by 2002:a17:90b:193:b0:2a0:5b4b:f5e2 with SMTP id
 t19-20020a17090b019300b002a05b4bf5e2mr362318pjs.33.1711472039726; Tue, 26 Mar
 2024 09:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143750.2292945-1-sunil.khatri@amd.com>
In-Reply-To: <20240326143750.2292945-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 12:53:48 -0400
Message-ID: <CADnq5_Nm6gyMf1mhGiyVDe6n69yabdf8EN5t=OmzJ7oBVZmEtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add support of bios dump in devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:38=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com=
> wrote:
>
> dump the bios binary in the devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 44c5da8aa9ce..f33963d777eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -132,6 +132,26 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset,=
 size_t count,
>         drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fa=
ult_info->addr);
>         drm_printf(&p, "Protection fault status register: 0x%x\n\n", faul=
t_info->status);
>
> +       /* Dump BIOS */
> +       if (coredump->adev->bios && coredump->adev->bios_size) {
> +               int i =3D 0;
> +
> +               drm_printf(&p, "BIOS Binary dump\n");
> +               drm_printf(&p, "Valid BIOS  Size:%d bytes type:%s\n",
> +                          coredump->adev->bios_size,
> +                          coredump->adev->is_atom_fw ?
> +                          "Atom bios":"Non Atom Bios");
> +
> +               while (i < coredump->adev->bios_size) {
> +                       /* Printing 15 bytes in a line */
> +                       if (i % 15 =3D=3D 0)
> +                               drm_printf(&p, "\n");
> +                       drm_printf(&p, "0x%x \t", coredump->adev->bios[i]=
);
> +                       i++;
> +               }
> +               drm_printf(&p, "\n");
> +       }

I don't think it's too useful to dump this as text.  I was hoping it
could be a binary.  I guess, we can just get this from debugfs if we
need it if a binary is not possible.

Alex


> +
>         /* Add ring buffer information */
>         drm_printf(&p, "Ring buffer information\n");
>         for (int i =3D 0; i < coredump->adev->num_rings; i++) {
> --
> 2.34.1
>

