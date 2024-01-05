Return-Path: <linux-kernel+bounces-17395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FC4824CA0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742B81C2259F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E41FCC;
	Fri,  5 Jan 2024 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCAmIKAf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546401FAD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d4c91a9adcso1385615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 17:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704418674; x=1705023474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogVvwDK/Dgt8I5gOLf0rKs+C40ZFKTDawpNUDK/TtKw=;
        b=nCAmIKAf4W5VQ5WZlzMzbTSXDFyspnQCc2HMRw0jftWtGrTrhlWmKz8W9GBGaKSmPO
         y9YRaJXB3dTzzNpqtYuLTxB0GLPU6lkfE1TarecJfmbQY3uSOVItO2SKRXnhFMt+CVfI
         M+FGV4Sub4v4RIWQOIVw7Xdie1B8AJvIqtRceDqrh+WONlqW9ooI+aWGmekLMyCtXMKO
         2aOOm/tvWvdEwAT5X36CWn35XnMx61Tea9ZwJQ/+F6aXSho4kuRrqHwiO2lKoS8ftExJ
         mym+X41fy4QnJUPK1PDnzn2HdQQLJckM+6rC6EPyJ5Sh3y26C3zeTPju/gkiRWyOp6d/
         ub8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704418674; x=1705023474;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogVvwDK/Dgt8I5gOLf0rKs+C40ZFKTDawpNUDK/TtKw=;
        b=khybHSWxsE4evBiWtiWB70Zyex8BXEYPaVF+9Rpae1x0cDJ1NURcXP6KE8AHhUk4Ig
         AV7mKswaeCraWw8bIZHUOsRaRhTjUy2XXq42ezHAyY16fyIPx01ZJCpocu6wA3t0Kn4M
         5f/u3P+YxgXDqOE/ekLTqsxDze2etKZWHgL8M8AA1CbYQodGuv1Zq4dDbtSuRR12CYun
         pp1d6YJA/bTBlZQQ9n43SxX8P3AomT++Iobn3AOR9+S5VQUEs4rZBLPzJZ3aF9VV8mJk
         g3mB3hvUi9aYRpmebf8tLWvYuMqvoIswyC43HQN0fMEjX8t8BKg9nu076X+Qg3FgL+Md
         X7gw==
X-Gm-Message-State: AOJu0YwOuo8FdneusNJ+01yIPcOktxvXzWlWqXmy5YV0PE8dDyW2Seyh
	sNVnlsP61ngon2jKgVpv8QAN+n+Dh7JtzQ==
X-Google-Smtp-Source: AGHT+IHDVbvAWgoJlpyO71KsCze60J3X7wdM90MBV1iT410hUQh1gPAxB7pvYhlLdwetE0WMN8W3og==
X-Received: by 2002:a05:6a21:3384:b0:196:1899:d756 with SMTP id yy4-20020a056a21338400b001961899d756mr3166699pzb.2.1704418673477;
        Thu, 04 Jan 2024 17:37:53 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:224b:9c3f:543b:97cb])
        by smtp.gmail.com with ESMTPSA id i186-20020a62c1c3000000b006d9a1812e35sm306500pfg.119.2024.01.04.17.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 17:37:53 -0800 (PST)
Date: Fri, 5 Jan 2024 10:37:46 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZZddarpj14gPqg25@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
References: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com>

On Thu, Jan 04, 2024 at 06:48:44PM +0800, Peng Fan (OSS) wrote:
> This patchset is a rework from Oleksii's RFC v5 patchset
> https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/
> 
> This patchset introduces some changes based on RFC v5:
> - introduce helper get_max_msg_size
> - support compatible string
> - iterate the id_table
> - Support multiple configs in one command
> - Added i.MX support
> - Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
>   is almost same as RFCv5 expect multiple configs support.
> - Patch 4 the dt-bindings includes compatible string to support i.MX
> - Rebased on 2023-12-15 linux-next/master

For the record, the translation of pin config types,
pinctrl_scmi_map_pinconf_type(), is finally implemented in patch 4.

Thanks,
-Takahiro Akashi

> If any comments from RFC v5 are missed, I am sorry in advance.
> 
> This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.
> 
> On ARM-based systems, a separate Cortex-M based System Control Processor
> (SCP) provides control on pins, as well as with power, clocks, reset
> controllers. So implement the driver to support such cases.
> 
> The i.MX95 Example as below:
> 
> Configuration:
> The scmi-pinctrl driver can be configured using DT bindings.
> For example:
> / {
> 	sram0: sram@445b1000 {
> 		compatible = "mmio-sram";
> 		reg = <0x0 0x445b1000 0x0 0x400>;
> 
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		ranges = <0x0 0x0 0x445b1000 0x400>;
> 
> 		scmi_buf0: scmi-sram-section@0 {
> 			compatible = "arm,scmi-shmem";
> 			reg = <0x0 0x80>;
> 		};
> 
> 		scmi_buf1: scmi-sram-section@80 {
> 			compatible = "arm,scmi-shmem";
> 			reg = <0x80 0x80>;
> 		};
> 	};
> 
> 	firmware {
> 		scmi {
> 			compatible = "arm,scmi";
> 			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> 			shmem = <&scmi_buf0>, <&scmi_buf1>;
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			scmi_iomuxc: protocol@19 {
> 				compatible = "fsl,imx95-scmi-pinctrl";
> 				reg = <0x19>;
> 			};
> 		};
> 	};
> };
> 
> &scmi_iomuxc {
> 	pinctrl_tpm3: tpm3grp {
> 		fsl,pins = <
> 			IMX95_PAD_GPIO_IO12__TPM3_CH2		0x51e
> 		>;
> 	};
> };
> 
> This patchset has been tested on i.MX95-19x19-EVK board.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
>  Added comments, and added R-b for Patch 1
>  Moved the compatile string and i.MX patch to the end, marked NOT APPLY
>  Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
>  Addressed the binding doc issue, dropped i.MX content.
>  For the firmware pinctrl scmi driver, addressed the comments from Cristian
>  For the pinctrl scmi driver, addressed comments from Cristian
> 
>  For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
>  string. Maybe the firmware public an protocol attribute to indicate it is 
>  VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
>  current pinctrl-scmi.c not able to support OEM config, should we extend
>  it with some method? Anyway if patch 1-4 is good enough, they could
>  be picked up first.
> 
>  Since I am only able to test the patch on i.MX95 which not support
>  geneirc pinconf, only OEM configs are tested in my side.
> 
> ---
> Oleksii Moisieiev (1):
>       firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
> 
> Peng Fan (5):
>       firmware: arm_scmi: introduce helper get_max_msg_size
>       dt-bindings: firmware: arm,scmi: support pinctrl protocol
>       pinctrl: Implementation of the generic scmi-pinctrl driver
>       [NOT APPLY]firmware: scmi: support compatible string
>       [NOT APPLY] pinctrl: scmi: implement pinctrl_scmi_imx_dt_node_to_map
> 
>  .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
>  MAINTAINERS                                        |   7 +
>  drivers/firmware/arm_scmi/Makefile                 |   1 +
>  drivers/firmware/arm_scmi/bus.c                    |  39 +-
>  drivers/firmware/arm_scmi/common.h                 |   2 +-
>  drivers/firmware/arm_scmi/driver.c                 |  32 +-
>  drivers/firmware/arm_scmi/pinctrl.c                | 930 +++++++++++++++++++++
>  drivers/firmware/arm_scmi/protocols.h              |   3 +
>  drivers/pinctrl/Kconfig                            |  11 +
>  drivers/pinctrl/Makefile                           |   1 +
>  drivers/pinctrl/pinctrl-scmi-imx.c                 | 117 +++
>  drivers/pinctrl/pinctrl-scmi.c                     | 540 ++++++++++++
>  drivers/pinctrl/pinctrl-scmi.h                     |  12 +
>  include/linux/scmi_protocol.h                      |  75 ++
>  14 files changed, 1806 insertions(+), 14 deletions(-)
> ---
> base-commit: 8f266a167d1f0ca34668f05cd8c01bd245c8698b
> change-id: 20231215-pinctrl-scmi-4c5b0374f4c6
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

