Return-Path: <linux-kernel+bounces-10459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D081D4A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C5A1F230F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE6D52F;
	Sat, 23 Dec 2023 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IS1BFi1i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22233F4FC
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so2606277f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703342055; x=1703946855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BV1PEntNocE2IBL12A6TgxaD4fskw5gPnZjQ1f85ecE=;
        b=IS1BFi1iiqE7r4gJUnpKdFbmjm5hbXaER8eZhUSYPvlc1rBluum0a0F6gMNSduPudE
         4I8ayQikoLjuXPjk4ewStXdkU0oVgco9EARyukz/tWuOzu6QEkK4B6Z9Dcj8FVbgc0N+
         /WoGZV6bRWbXXWNDqh5c/5uVB/OMJ8gPqFKn1sBLIeGnewGdhI5e/uCXLa/PIR/DRAxo
         42KvbBxsJye9K/2WVVfGx5/8dDwGn1Pi0PPP8PC/oP+rMrlnSg/jwwAKcRghH2ZaP0/n
         EujInoZ60UIqfE4Mwwt7Ctlcuy9IUU+kAw0hvfp0m2N10koJjN0YZtupq8dhSwr27dVy
         5Iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703342055; x=1703946855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV1PEntNocE2IBL12A6TgxaD4fskw5gPnZjQ1f85ecE=;
        b=ggJY+XiqBP4EaYcWwxjCf/K60qjgcNIPKzobvh233Pvx8nWLfdqs3m/1Oeg3hwQX5M
         np1W+waNoTb9vLZfuR9vXQayYgD2+BLY/dbH5B9aTGWgz42d0ZfGCf14LEbFip5jE0av
         6q4zYmQOMqPdXnLQtZ4vmfljWCm5SI+Jcn8SJGohgKzsRia0eVEIDhj4W5HKUjhN7pa1
         YlX/hskhHmzsZLcyrgR1uow3USs+OJf0Yx8krrhBbuY4zNeZYw5luXDmev6zDBDq4QX7
         YCS07zAPvzTSz4SA4MC3y3JfqHfZYrmYp+1kPqBcaDgKPXseynvKonug29C043TjL2P8
         58MA==
X-Gm-Message-State: AOJu0YyasTta+bYqNK7f0XZpKEFKYSlD+hX/EuvB5mTQISNZ80sb28ea
	qogXx0Vi/kLtmhTXP/+PLGUGz6VEC0uGB7b9pLxaAq9kx5itTA==
X-Google-Smtp-Source: AGHT+IESkPfLkYu8vLlwXSJLB7jisOcm59ju+sR9oNFmAVyPfuKc/7s7JLff8bMg5ecCjqFhSGQviWOCuhXT2JCdi84=
X-Received: by 2002:a5d:4609:0:b0:336:6d62:7647 with SMTP id
 t9-20020a5d4609000000b003366d627647mr1642900wrq.5.1703342055201; Sat, 23 Dec
 2023 06:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215235725.1247350-1-tanmay.shah@amd.com> <20231215235725.1247350-3-tanmay.shah@amd.com>
 <6ab19ceb-38ed-4e4c-aabc-a959bc123cf2@amd.com> <e9e9777d-f8c1-48cd-b433-0292c77f6d57@amd.com>
In-Reply-To: <e9e9777d-f8c1-48cd-b433-0292c77f6d57@amd.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Sat, 23 Dec 2023 07:34:02 -0700
Message-ID: <CANLsYkxJyKFm4LR_JJx-kQMs=xa1C=SnD1Ha=jGqXM5nfy5dxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] dts: zynqmp: add properties for TCM in remoteproc
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: Michal Simek <michal.simek@amd.com>, andersson@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, ben.levinsky@amd.com, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 07:45, Tanmay Shah <tanmay.shah@amd.com> wrote:
>
>
> On 12/20/23 7:14 AM, Michal Simek wrote:
> >
> > On 12/16/23 00:57, Tanmay Shah wrote:
> > > Add properties as per new bindings in zynqmp remoteproc node
> > > to represent TCM address and size.
> > >
> > > This patch also adds alternative remoteproc node to represent
> > > remoteproc cluster in split mode. By default lockstep mode is
> > > enabled and users should disable it before using split mode
> > > dts. Both device-tree nodes can't be used simultaneously one
> > > of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
> > > remoteproc split mode dts node is enabled and lockstep mode
> > > dts is disabled.
> > >
> > > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > > ---
> > >   .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
> > >   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++++--
> > >   2 files changed, 63 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > > index c8f71a1aec89..495ca94b45db 100644
> > > --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> > > @@ -14,6 +14,14 @@ / {
> > >     compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> > >   };
> > >
> > > +&rproc_split {
> > > +   status = "okay";
> > > +};
> > > +
> > > +&rproc_lockstep {
> > > +   status = "disabled";
> > > +};
> > > +
> > >   &eeprom {
> > >     #address-cells = <1>;
> > >     #size-cells = <1>;
> > > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > > index b61fc99cd911..602e6aba7ac5 100644
> > > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > > @@ -247,19 +247,69 @@ fpga_full: fpga-full {
> > >             ranges;
> > >     };
> > >
> > > -   remoteproc {
> > > +   rproc_lockstep: remoteproc@ffe00000 {
> > >             compatible = "xlnx,zynqmp-r5fss";
> > >             xlnx,cluster-mode = <1>;
> > >
> > > -           r5f-0 {
> > > +           #address-cells = <2>;
> > > +           #size-cells = <2>;
> > > +
> > > +           ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
> > > +                    <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>,
> > > +                    <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> > > +                    <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> > > +
> > > +           r5f@0 {
> > > +                   compatible = "xlnx,zynqmp-r5f";
> > > +                   reg = <0x0 0x0 0x0 0x20000>, <0x0 0x20000 0x0 0x20000>;
> > > +                   reg-names = "atcm", "btcm";
> > > +                   power-domains = <&zynqmp_firmware PD_RPU_0>,
> > > +                                   <&zynqmp_firmware PD_R5_0_ATCM>,
> > > +                                   <&zynqmp_firmware PD_R5_0_BTCM>;
> > > +                   memory-region = <&rproc_0_fw_image>;
> > > +           };
> > > +
> > > +           r5f@1 {
> > > +                   compatible = "xlnx,zynqmp-r5f";
> > > +                   reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> > > +                   reg-names = "atcm", "btcm";
> > > +                   power-domains = <&zynqmp_firmware PD_RPU_1>,
> > > +                                   <&zynqmp_firmware PD_R5_1_ATCM>,
> > > +                                   <&zynqmp_firmware PD_R5_1_BTCM>;
> > > +                   memory-region = <&rproc_1_fw_image>;
> > > +           };
> > > +   };
> > > +
> > > +   rproc_split: remoteproc-split@ffe00000 {
> > > +           status = "disabled";
> > > +           compatible = "xlnx,zynqmp-r5fss";
> > > +           xlnx,cluster-mode = <0>;
> > > +
> > > +           #address-cells = <2>;
> > > +           #size-cells = <2>;
> > > +
> > > +           ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> > > +                    <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> > > +                    <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> > > +                    <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> > > +
> > > +           r5f@0 {
> > >                     compatible = "xlnx,zynqmp-r5f";
> > > -                   power-domains = <&zynqmp_firmware PD_RPU_0>;
> > > +                   reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> > > +                   reg-names = "atcm", "btcm";
> > > +                   power-domains = <&zynqmp_firmware PD_RPU_0>,
> > > +                                   <&zynqmp_firmware PD_R5_0_ATCM>,
> > > +                                   <&zynqmp_firmware PD_R5_0_BTCM>;
> > >                     memory-region = <&rproc_0_fw_image>;
> > >             };
> > >
> > > -           r5f-1 {
> > > +           r5f@1 {
> > >                     compatible = "xlnx,zynqmp-r5f";
> > > -                   power-domains = <&zynqmp_firmware PD_RPU_1>;
> > > +                   reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> > > +                   reg-names = "atcm", "btcm";
> > > +                   power-domains = <&zynqmp_firmware PD_RPU_1>,
> > > +                                   <&zynqmp_firmware PD_R5_1_ATCM>,
> > > +                                   <&zynqmp_firmware PD_R5_1_BTCM>;
> > >                     memory-region = <&rproc_1_fw_image>;
> > >             };
> > >     };
> >
> > Acked-by: Michal Simek <michal.simek@amd.com>
> >
> > Let me know if you want me to take this via my tree.
>
> Hi Michal,
>
> Thanks for reviews. I will ping you once driver changes are approved.

I'll pick this up with the rest of the driver.  It will be easier that way.

>
> Or Mathieu can take this in remoteproc tree, either way is fine.
>
> But I would like to wait till driver changes are approved.
>
> Tanmay
>
> >
> > Thanks,
> > Michal

