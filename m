Return-Path: <linux-kernel+bounces-118353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0188B940
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA1C1F3BC54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77BD129E70;
	Tue, 26 Mar 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="YetuRw60"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1D1292D8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426073; cv=none; b=Jp7c6J+YJCwAb65G7jWpi0lrPvwB5VLm9KfJy03ZrvQIQZSSy59WAjBseUxT8pF8KMnBHSjBjUG37j0FT6a2PcCiokOVHU3icdc7eqHucU5NgRj7EaajYmUszcNiAFTgYKgiY5xqcTZF9ByzAnqy5r/YWcAnM07jJrP4XUm61iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426073; c=relaxed/simple;
	bh=R+nLcOTwvgUirVNTt7cUeAOPAWPx06FjNpRRUFDyAgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zgc50K7l0tnNqULH8M6Y2JOLONVlXoBh0bU6d2q7jSYScHWRUV2MNC9Knnhj6x8UBZph/JxiZntbFK1OrLHjEgXnOCrlB6ztaCmGG4rrkYGRG0FvXHfMft64UqzJ4f2ciY4D5G7sepnkGsZIsSJcVrr1QDoafY2tL1pyoXFNYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=YetuRw60; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3662feb90a8so38298195ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1711426070; x=1712030870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZR8vGousVKLTwUEi/21KojnQf3J0MYLn3UhiAu3VJo=;
        b=YetuRw60hxaxKBJTn8/ugVAuzuDY0vHPOhS8oQTB7zX6I6ZPg4goMhotHlmw2Zeroy
         s6p+Gvu7jc392gPrzp76Q7AgYlxi9yQ1K/OECXNY+AtscLJAjBSdMbdBrovPOlcJksPS
         ijWsZ8XKAvyF1fjdcks0VoqhAPgaq5SPNASqgr1gHBs624wN9jwozmYrNnTYtVYqZ+AJ
         /b7xIOV8+OMaytW9iqpxZh9b8YuB0D3241e9SOLESrmI0LCDik7Twqk4XTVF1EHdw45J
         4rRbNLFhFWC19cZFDWObMZsOUZHufrXCL5dmrKuLWltlEOaHiN4tna+L43lkVxNVl+7b
         XlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711426070; x=1712030870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZR8vGousVKLTwUEi/21KojnQf3J0MYLn3UhiAu3VJo=;
        b=KMq6DPHDJkepMV1aE6kZ5xmdQ+Gyc3OhzPCpo9x+DEJ3zl28hGPntdbNN4yJHIeuRV
         hQQY1GFA6uFHgvdTxcaGotSFNgXg1OeXEHCR7k3X6JTaF/y+4XXYCB4WmCETiTMFgiF2
         MOEF+M6DtjJnzTFN8z6XMxad2gJMmEXOWb53sgYoXsHg/94+jxjpEsCZbLlwmCZoh7/N
         PT3LiDWnUGrYZFmrqr0pnFQ+7BYVcEeZVFBf/H9308NkTsENtccNOKC9GvU7y93PpP65
         +xRuTz9AI8F2oOQiDpuyVRbl71HCx+v3tyAbjzNZ7bPoIj+l566Xu8/ad8iRxu76jZOy
         gRtA==
X-Forwarded-Encrypted: i=1; AJvYcCVzkkAv/XvpMyBPloc4Xp2Ii79lr6C8vKFlvOxPNWruVNcZ3M7vZ5JlYRD0twMHdVi39X4aPD67oGohMJTGwQm8EOmEvMj1RPF9Sbfm
X-Gm-Message-State: AOJu0YymC8/dLeZxlMlDhNcdtP4yR+goujGtFKcGToeCmASEoSrRT5ey
	EKe0lyzYrJSj7fknDvtgVmYyzWVtO9Nib+dZ0OVLZASgA/VOfM/zIgcsEB9PipVonVPhXfvJieO
	Sf3bsfXnOpqTE1ONxMK+lnFYg6ZOtxqb/RvQntY2ynhFzBq7v
X-Google-Smtp-Source: AGHT+IGt0bGGYQWpx67EJCwTtVelUSMNY0t2MZE8NdaGGuCuPZUdwQH0ix+HnbyiD5ovliqTKGlpmL5Ocw1jnFJWOTM=
X-Received: by 2002:a92:d782:0:b0:368:9850:82c1 with SMTP id
 d2-20020a92d782000000b00368985082c1mr36365iln.13.1711426070652; Mon, 25 Mar
 2024 21:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321085041.1955293-1-apatel@ventanamicro.com>
In-Reply-To: <20240321085041.1955293-1-apatel@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 26 Mar 2024 09:37:39 +0530
Message-ID: <CAAhSdy1jAjGJR=+ZtfLpfzgctJ4cA==nCXJ0FEDBF_vJLNJBWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM RISC-V APLIC fixes
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 2:20=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> Few fixes for KVM RISC-V in-kernel APLIC emulation which were discovered
> during Linux AIA driver patch reviews.
>
> These patches can also be found in the riscv_kvm_aplic_fixes_v1
> branch at: https://github.com/avpatel/linux.git
>
> Anup Patel (2):
>   RISC-V: KVM: Fix APLIC setipnum_le/be write emulation
>   RISC-V: KVM: Fix APLIC in_clrip[x] read emulation

Queued this series for Linux-6.9 fixes.

Thanks,
Anup

>
>  arch/riscv/kvm/aia_aplic.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>

