Return-Path: <linux-kernel+bounces-141563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016A8A2002
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FDB1F25491
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754541805A;
	Thu, 11 Apr 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="3Ul7+m29"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649C17BD5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866597; cv=none; b=XazBtP16CLlHPf2BQv2pKMahNT8YsDXN0IxqjS3BZXnpQarj8nWW1QOcI+nIF0ETQZvGN770xkbVGbPttKpuyo8fiCvVUMrm7PO0io5p+5ZePQzuz3VEVZQ1uIWf8yqPzm7CppcXnGwfkA/+5FNAWacxpZber3dxLFfiZ4GkBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866597; c=relaxed/simple;
	bh=FigJPmeeol9aTT8r85nc2virpzTGMjItOeicZjOZH+E=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=RzihqNIptsOpzbWk3PZDiDzAsjrkcdn2TuZj4asJj3fSY8sAmCc+lFZS7GCYrW5l0FleMfVJ+bNw67PG0vXmg5cm0EVzv8KTKtv2TcvkjtyoV56luqjRFrY5E+B3jqW5cAAGBEncJdfaD4jq1Wfb76uJlGlyBq563Y/cU+BjZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=3Ul7+m29; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3ff14f249so1776395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1712866595; x=1713471395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI1lrr2uhxwJR+eCQKQup9QfuAe/qWYI7Ljrnyz9U00=;
        b=3Ul7+m299p0PqqNmFeoRnx57/6NSLuBQBefAd0mBuWNXvrS6+NdjRv/mdc4iZve0aU
         RPtlLMFkB2yKoY4DCEYSUlD6aKYyurMGdccerptNqD1eBi0NhJDSEN9benvZcWghNGYi
         iDUEOsZXlIdHOSUULFRbADQCF4Ac9TGKE+kWCnDZ62+Ct+Mktf2heRKEqLV4ctfgun6S
         tpyA4Zbeir3M1itx29XGHIbafgmeNRukYkJulXqcnX0PUwiRzRed/bFDx1/Kk1p61RwW
         SDToXYK0Ci38Gswaff15gCNbi3ZXwyl0kOm1lytJ0vJIWsXsU/bLWvXilH0jprMSYUHE
         RgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866595; x=1713471395;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI1lrr2uhxwJR+eCQKQup9QfuAe/qWYI7Ljrnyz9U00=;
        b=VuYXt2HdatscXM36NLlc+v3HnRloRAubTpR9KCak/YXXhVmGTArhqdtk/dLIX/M+E6
         DBsOhwRQgN7rUDG8FiUeu+YHEg1rn+bY04uPIvWSJx7iku0nv212C1B7J3rH6JtUAdpG
         7J92fDmyAFNepx7bszKyczq3y9qXfcfaUXhngLG14/JmKgMqEMmOKb9xAP+TxZPxOftB
         6IWMdTetPjSTnb0rlR0p51KYG6/Yhuq+jtVgiMh558GhVKBCSsUpTuykz7huiKF+g5oA
         CV72A3yeAZXKpndwYmN/bgR6uX79i/LHRvLVIMTCilPlpXQq7ztDa7ZdFb2Mbl3yC0Kn
         dKUg==
X-Forwarded-Encrypted: i=1; AJvYcCXkmTX3oH0VSRDBT44F8ab/bs6HkgKQu8YA50zTe6wFKKBtS7EsRZaseYDpBQgaDjNLOZY5MhKBPbCcQA8RxnJVwzJdzXhfFP/Lr3Mh
X-Gm-Message-State: AOJu0YwYQ4booz8tspTn3mFr0KcpdLcITfGFTIJLTxN6xo8iF8GANSBk
	Ay56BSFTBDywzRlesQz5Hr0g3Mo8bYRuZOKypJpL7jLaZwedptogib03GP3gCS8=
X-Google-Smtp-Source: AGHT+IFccneSwJaJyGfCasupHSlPcb2gw+0X/vWttGvs1X1hMf9iaiQzERVC7/I+eNsLdsBCcZbteg==
X-Received: by 2002:a17:902:e80d:b0:1e2:abc5:e28b with SMTP id u13-20020a170902e80d00b001e2abc5e28bmr1009284plg.19.1712866595166;
        Thu, 11 Apr 2024 13:16:35 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ab8400b001e512537a5fsm1576849plr.9.2024.04.11.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:16:33 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:16:33 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2024 13:16:31 PDT (-0700)
Subject:     Re: linux-next: manual merge of the riscv-dt tree with the risc-v tree
In-Reply-To: <20240411094901.2130c36e@canb.auug.org.au>
CC: Conor Dooley <conor.dooley@microchip.com>, Paul Walmsley <paul@pwsan.com>,
  linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, masahiroy@kernel.org, cyy@cyyself.name
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-ec3820b2-2b47-4d5d-af2b-8d0f349336de@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 10 Apr 2024 16:49:01 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the riscv-dt tree got a conflict in:
>
>   arch/riscv/Makefile
>
> between commit:
>
>   3b938e231b66 ("riscv: merge two if-blocks for KBUILD_IMAGE")
>
> from the risc-v tree and commit:
>
>   ef10bdf9c3e6 ("riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210")
>
> from the riscv-dt tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/riscv/Makefile
> index 7c60bbe1f785,fa6c389c3986..000000000000
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@@ -143,15 -133,7 +143,15 @@@ boot		:= arch/riscv/boo
>   ifeq ($(CONFIG_XIP_KERNEL),y)
>   KBUILD_IMAGE := $(boot)/xipImage
>   else
> - ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> ++ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
>  +KBUILD_IMAGE := $(boot)/loader.bin
>  +else
>  +ifeq ($(CONFIG_EFI_ZBOOT),)
>   KBUILD_IMAGE	:= $(boot)/Image.gz
>  +else
>  +KBUILD_IMAGE := $(boot)/vmlinuz.efi
>  +endif
>  +endif
>   endif
>   
>   libs-y += arch/riscv/lib/

Thanks.  I guess I should have looked a bit closer before Acking, but 
I'm not sure this one warrants a shared tag or anything -- it's just 
some Makefile refactoring that happens to step on each other.

