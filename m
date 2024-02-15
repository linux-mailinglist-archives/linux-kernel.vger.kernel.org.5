Return-Path: <linux-kernel+bounces-66312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886ED855A31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D2C290B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07187BA2D;
	Thu, 15 Feb 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SwQK8Itp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2438F68
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976111; cv=none; b=Saf2p1SxUo7zfIEdVnfTPbE5CDhuJ2m8oMcWM6yRVeTKz7eWHRVGG0n7nv8SGghxC/IRmHjKofV/SjWdx9CGstZOFHtBfBq5zhwipyeunugBdfuMMG/4NL7RSNIYsxun2LCkpde9Npzba9Zc7jn4w9+92Zyk7aB4H8z41xam2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976111; c=relaxed/simple;
	bh=Wy0+n9JgqrY/lECFwTB8y+8bzYPNJDBhqzCYO+LmmYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii7mTnWaeK5IOvvDxafIUh1hif3vc3jvSJ4GC/XbyzbSl+kJKlBpFiebQXTUxf4QkG9q3Z+aKW6ttDmgyez0+3yMED+OvrS1NdcUv7O9D/bxau2cDNbPG6vyIViKSbcr3FzLGl29zmsQ6+otk/q2oMXIAE9RdqeVZEqr6G4o8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SwQK8Itp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5114fa38434so543550e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707976107; x=1708580907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCR9TmSawra5wUvs4oISeBGT3tqyzqaDdzBDeohv99Y=;
        b=SwQK8ItpNEsH1bs+vbCEMNvTKQagz7fZinP0etl/v1SuVNXNLvHE0x+LqDBFq0Pms3
         UWY19UyP+R8zzpkbCo2d/K0QlttHkhfZlLOuCYrG0uVdRZ8D18i0ZfSzMBUxESoiTAVF
         7DuNglli+v1IvatQtgW3EGQ1K0e6hdQWF1vQ1hwAan4oWCeFTE1kqrzPCuEPgUSo9O0G
         NOpUu0sNzLBUlwo1Nj/wykWei7Zs7KODSSbNJuL/6EpMYhGXvNkWH8xGzzFzSeZPKch3
         eKvUmQvAyzGc5C76xRUuBtvV3+srkpjGTjMdyL4LG4uNUO4xC20oPUc9yODyEHRD+wIq
         G27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707976107; x=1708580907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCR9TmSawra5wUvs4oISeBGT3tqyzqaDdzBDeohv99Y=;
        b=YmquXXohOzcuevBGeQwKnqN4S/4BU9RVDr/nqyrWTnf3GZmPY/Zx/jg2/AYNTLleVS
         ElOwe6aOJJ00cOTIWeE5rkC7bWYeQ7fUHfYsY8OoURZ3NvSW/gkwQYWYk3HFDsAaDxvp
         1mBL6Rw6Ux17Dx943V1/iBcSlc6mRcVarkkKm/Xgd1zwqTzPxkUiI9q3ayeMHLzw0qPQ
         WpnmtAe1iZS3fc0DghI+LA+M7ZSyeiUmcv5b9YLp+Iaz3b2k/a7f0NU6ZRIKcQD6wzwK
         7qBWXIMALMjA4zItmmc/vhpT6bfrMQSP/qnLvxzfbC9U8OuapLEloupoFBftvhgAgxGK
         HbIg==
X-Forwarded-Encrypted: i=1; AJvYcCWSKAgFBDepprNQ52fqviFueTkgK08QEKGVxLqq42KmqjugBsEg9ujNQqvYUSMQcs9Y3IEDTA/IuL6TVKki7Ex8FBwzHt05wZ+AEFrw
X-Gm-Message-State: AOJu0Yxc2OaJghgBwQDCAP/QLvBlAFmeGWVMMLbRvCa+KpGZNNFERvkx
	Ezaf8a1GMMEmj7dX72itYOFBSgSHWn9g6ximgoWqEE/pkjw0/bAhXvP5sUQwNPW/wHZ8qLz9+H+
	4ITn+QzbKyNGpISlik26cWpRDX/UbkIdtZzZpgw==
X-Google-Smtp-Source: AGHT+IFXK7zSd2x0PSl1ap8TU3fQMItsMd1vzwFvuhYCp/fEDN7sIyRsPKR8EwxhBD/qfurWwSMNwN2P4fLnuwKJ9SA=
X-Received: by 2002:a05:6512:67:b0:511:82b5:b484 with SMTP id
 i7-20020a056512006700b0051182b5b484mr605399lfo.64.1707976107190; Wed, 14 Feb
 2024 21:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <CAK9=C2Vwtj2gZg-P73yLMxu0rPXQ3YrRRuxq6HcpHMXgs-jHaw@mail.gmail.com> <87bk8ig6t2.ffs@tglx>
In-Reply-To: <87bk8ig6t2.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 15 Feb 2024 11:18:15 +0530
Message-ID: <CAK9=C2WsSSHgDF+7ruxx_QF0Lk+Dsx2F2Y-_NabnxrJ_qWhgGQ@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, "Ahmed S. Darwish" <darwi@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:24=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Anup!
>
> On Sat, Jan 27 2024 at 21:50, Anup Patel wrote:
> >> Changes since v11:
> >>  - Rebased on Linux-6.8-rc1
> >>  - Included kernel/irq related patches from "genirq, irqchip: Convert =
ARM
> >>    MSI handling to per device MSI domains" series by Thomas.
> >>    (PATCH7, PATCH8, PATCH9, PATCH14, PATCH16, PATCH17, PATCH18, PATCH1=
9,
> >>     PATCH20, PATCH21, PATCH22, PATCH23, and PATCH32 of
> >>     https://lore.kernel.org/linux-arm-kernel/20221121135653.208611233@=
linutronix.de/)
> >>  - Updated APLIC MSI-mode driver to use the new WIRED_TO_MSI mechanism=
.
> >>  - Updated IMSIC driver to support per-device MSI domains for PCI and
> >>    platform devices.
> >
> > I have rebased and included 13 patches (which add per-device MSI domain
> > infrastructure) from your series [1]. In this series, the IMSIC driver
> > implements the msi_parent_ops and APLIC driver implements wired-to-msi
> > bridge using your new infrastructure.
> >
> > The remaining 27 patches of your series [1] requires testing on ARM
> > platforms which I don't have. I suggest these remaining patches to
> > go as separate series.
>
> Of course. Darwi (in Cc) is going to work on the ARM parts when he
> returns from vacation. I'm going to apply the infrastructure patches
> (1-13) in the next days so they are out of the way for you and Darwi,
> unless someone has any objections.
>
> Thanks for picking this up and driving it forward!

Thanks Thomas, I will be sending v13 of this series next week.

For the time being, I will carry the 13 infrastructure patches in
this series until they land in upstream Linux so that it is easier
for people to try this series.

Regards,
Anup

