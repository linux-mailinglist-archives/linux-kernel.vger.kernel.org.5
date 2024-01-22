Return-Path: <linux-kernel+bounces-32744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32272835F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AE01C25B70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1233B199;
	Mon, 22 Jan 2024 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+t94u7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213FF3AC01;
	Mon, 22 Jan 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919012; cv=none; b=Ek9SIFKL4Vivt/7PjQ7fMEHtKun+ww01PpaJZI9E0bfKCyY2PWvDswm6zxs9R2rxCaYJauI66cb5wbESQl5G9T7QIhovWC5ITGOjPymEV+TAf6Gwn0GREFZmhrdt+c+aH6Tp2XQpwoAz7iocdFNoFGIrHsn+l+qE7BOPK24eHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919012; c=relaxed/simple;
	bh=Viq3Gt3uXsNc55QdCbV4jAxAoQZ5O2Q6OyzzTlHeaWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPXvNorX2C8Rtx0sJHAbFOlmQ33xD419JJVrMjVA7FOUZPqw7SgHYtcTbEEnfNZKdu1uNx1id+1YpaawMhDOD+TYV1Dt+LTxnWIEiLUGA+Z2Elq0RHukVUlavvJj8nUguUom126mWYi4BjeZBtztCDme0fy0w2tbQ1yLs3dD0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+t94u7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C17BC433F1;
	Mon, 22 Jan 2024 10:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705919011;
	bh=Viq3Gt3uXsNc55QdCbV4jAxAoQZ5O2Q6OyzzTlHeaWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+t94u7h/GfVo1LTBIJCVvN6iikLSbLbGVeGamUL+rL/RMIxUm8R3yVfWrrl1IM5J
	 2QSttI+mP8qNiZVKFNipPsPb/PblfHJ5xYxUZLDqJPEDlG9LVY5es7fnRT8fuMbdxV
	 F9DMmVUnq9WWBxu0BTWK57GAIu3s8zD72uT+25DbjARpogBy0yBEut5pFMBKZtxwkx
	 YobDbm2sweKOOCXhvSgUixX0S8z+D4cEwwK6Xnv4hTs3Y2BZ6KS5cIGi9Y45Z7aCV+
	 hlAqcIrAvqcKfUbH62PLIZrbh5o4Suxs2rKoItxuOxcPvyoDK2a5lO0QftfmR6CS8j
	 OZhGr7Ic6QDwA==
Message-ID: <5f6debb5-666a-4e19-b483-d85186f3959f@kernel.org>
Date: Mon, 22 Jan 2024 19:23:27 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, cassel@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, michal.simek@amd.com,
 p.zabel@pengutronix.de, gregkh@linuxfoundation.org, piyush.mehta@amd.com,
 mubin.sayyed@amd.com
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, git@amd.com
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/24 20:36, Radhey Shyam Pandey wrote:
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Acked-by from Mubin is missing.

> ---
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml      | 3 ++-
>  .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 ++-
>  Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 3 ++-
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml         | 3 ++-
>  Documentation/devicetree/bindings/usb/microchip,usb5744.yaml   | 3 ++-
>  Documentation/devicetree/bindings/usb/xlnx,usb2.yaml           | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index b29ce598f9aa..9952e0ef7767 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Ceva AHCI SATA Controller
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  description: |
>    The Ceva SATA controller mostly conforms to the AHCI interface with some
> diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
> index b1fd632718d4..bb93baa88879 100644
> --- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
> +++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml
> @@ -12,7 +12,8 @@ description:
>    PS_MODE). Every pin can be configured as input/output.
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> index 49db66801429..1f1b42dde94d 100644
> --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Zynq UltraScale+ MPSoC and Versal reset
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  description: |
>    The Zynq UltraScale+ MPSoC and Versal has several different resets.
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> index bb373eb025a5..00f87a558c7d 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Xilinx SuperSpeed DWC3 USB SoC controller
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> index 6d4cfd943f58..445183d9d6db 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml
> @@ -16,8 +16,9 @@ description:
>    USB 2.0 traffic.
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
>    - Michal Simek <michal.simek@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> index 868dffe314bc..a7f75fe36665 100644
> --- a/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> +++ b/Documentation/devicetree/bindings/usb/xlnx,usb2.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Xilinx udc controller
>  
>  maintainers:
> -  - Piyush Mehta <piyush.mehta@amd.com>
> +  - Mubin Sayyed <mubin.sayyed@amd.com>
> +  - Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  
>  properties:
>    compatible:

-- 
Damien Le Moal
Western Digital Research


