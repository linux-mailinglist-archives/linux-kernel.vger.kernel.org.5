Return-Path: <linux-kernel+bounces-18522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B943825EB3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF491F24787
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C0F4439;
	Sat,  6 Jan 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFBgWamQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1787440D
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41362C433D9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704526102;
	bh=lhf3MLOvX3QLGLPvF4jkBHul2Uw+I6bWhrUpHadrfCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HFBgWamQpSOQNEiltrpowIF30Z181pHv1+B0+tJjm5USv88gjnyzU6wrpFkC8LnY3
	 0nY7R9fuKhKif8eEfhF5UJ0hdbq9r0jze6bI9mqwRftYmzpI/fnZdvBqDQksvf0llP
	 V0UhFb3xh9R/P44YO/EfQDdhPoFKaQfYM+G8VtJNNVGhL0a17SRL1xGC9VkQLXyeHW
	 wyuR0s5RPqPN54z53nLwoGhAhyDL4h/7f7FbnHwuAMzTwIC11Zf3aBgqxm+S4PAc+z
	 kPgvWx9tERGcEu2WkCMunKDz+T1hFAsa2OermmPMHria0ZxTdC0G2q5oGFVhg0fKAH
	 1KPCe8HDbx4Ew==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e67e37661so370630e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 23:28:22 -0800 (PST)
X-Gm-Message-State: AOJu0Yymoxq2HGd+UUmxML/Kkd5DULImEHCfQR6YAUTWD+l4Q4EQJj3Y
	04i13FHHDxrn2YmhMzGWEwDT2psavZKttWfXFd4=
X-Google-Smtp-Source: AGHT+IGlVypcm0Z7RU4BmHn/uLgMYyoQ4TNagnEGxOuCUk4gjZwYe7bEkPVC962xqRuEbgODKVgJ9S9iGqbA6g1BrGQ=
X-Received: by 2002:a05:6512:31ca:b0:50e:74c6:8961 with SMTP id
 j10-20020a05651231ca00b0050e74c68961mr252997lfe.100.1704526100239; Fri, 05
 Jan 2024 23:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222024628.3138406-1-gaosong@loongson.cn> <16576063-1df9-5aa4-1aaa-1a99c4a660cb@loongson.cn>
In-Reply-To: <16576063-1df9-5aa4-1aaa-1a99c4a660cb@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jan 2024 15:28:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7YhSMJNOiyCFmmpn+rmE69X3RPhUDTxSw3nFmeE6R+-Q@mail.gmail.com>
Message-ID: <CAAhV-H7YhSMJNOiyCFmmpn+rmE69X3RPhUDTxSw3nFmeE6R+-Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] LoongArch: defconfig: Enable Generic PCIE by default
To: gaosong <gaosong@loongson.cn>
Cc: kernel@xen0n.name, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	raven@themaw.net, davem@davemloft.net, svenjoac@gmx.de, 
	anthony.l.nguyen@intel.com, richard.henderson@linaro.org, 
	peter.maydell@linaro.org, philmd@linaro.org, maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Sat, Jan 6, 2024 at 3:23=E2=80=AFPM gaosong <gaosong@loongson.cn> wrote:
>
> Ping!
>
> =E5=9C=A8 2023/12/22 =E4=B8=8A=E5=8D=8810:46, Song Gao =E5=86=99=E9=81=93=
:
> > Enable generic PCIe by default in the LoongArch defconfig.
> > QEMU requires this configuration when booting the kernel with FDT.
> >
> > Signed-off-by: Song Gao <gaosong@loongson.cn>
> > ---
> >   arch/loongarch/configs/loongson3_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarc=
h/configs/loongson3_defconfig
> > index 33795e4a5bd6..6350be7e8ec8 100644
> > --- a/arch/loongarch/configs/loongson3_defconfig
> > +++ b/arch/loongarch/configs/loongson3_defconfig
> > @@ -348,6 +348,7 @@ CONFIG_NET_9P=3Dy
> >   CONFIG_NET_9P_VIRTIO=3Dy
> >   CONFIG_CEPH_LIB=3Dm
> >   CONFIG_PCIEPORTBUS=3Dy
> > +CONFIG_PCI_HOST_GENERIC=3Dy
> >   CONFIG_HOTPLUG_PCI_PCIE=3Dy
> >   CONFIG_PCIEAER=3Dy
> >   # CONFIG_PCIEASPM is not set
>
>

