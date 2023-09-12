Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2755379D746
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjILRJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjILRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:09:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4190810F9;
        Tue, 12 Sep 2023 10:09:39 -0700 (PDT)
Received: from [192.168.0.106] (unknown [186.235.7.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C963E66072FA;
        Tue, 12 Sep 2023 18:09:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694538578;
        bh=xAT9JbuYW6emcmFF+W5rqg4ZaSjjD8QM385HOKSfF2s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kRYt/gRI/hdUZHPqKZKwpqOHmREs13rcuDFHe3fIGcMlQADqID0BeykBLS8uI3Bfq
         BIAyglyc8E9xhISn4AqH6nEDEdhdN9YHyocqq/VIqm7JP8lwmw9TGYi7R2ixMAuYAP
         9hU+h4SMOU2GR5Q8FVKi4Ug0kkOGn7jUhDD0cENC9Oz9SFnolEYjUC6+sN8sKa05Uc
         DFOGdK8InK2Q0fQDqaTLN1ecZYwnMy8DW+fmAVGlgp/55C1fX2bBZd2Mcf+mT8ybqJ
         4K/KEIH58DKXabT/rRRDvE4965O/PqfBaaCSvnFD0ZTHTI12txGCIWngvLX8afao0X
         RaojSupULYKWA==
Message-ID: <a411b3fe-6222-4c86-8d71-afa992ea2f93@collabora.com>
Date:   Tue, 12 Sep 2023 14:09:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: Add overlay for usb host
 mode
Content-Language: en-US
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        daniels@collabora.com, emma@anholt.net, robdclark@gmail.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        David Heidelberg <david.heidelberg@collabora.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911161518.650726-1-vignesh.raman@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20230911161518.650726-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2023 13:15, Vignesh Raman wrote:
> Due to the presence of the fastboot micro cable in the CI farm,
> it causes the hardware to remain in gadget mode instead of host mode.
> So it doesn't find the network, which results in failure to mount root
> fs via NFS.

Just a context for others, this was part of this patch series 
https://lore.kernel.org/r/20230908152225.432139-1-vignesh.raman@collabora.com

> 
> Add an overlay dtso file that sets the dr_mode to host, allowing the
> USB controllers to work in host mode. With commit 15d16d6dadf6
> ("kbuild: Add generic rule to apply fdtoverlay"), overlay target can
> be used to simplify the build of DTB overlays. It uses fdtoverlay to
> merge base device tree with the overlay dtso. apq8016-sbc-usb-host.dtb
> file can be used by drm-ci, mesa-ci.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: David Heidelberg <david.heidelberg@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>


> ---
>   arch/arm64/boot/dts/qcom/Makefile                  | 4 ++++
>   arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso | 8 ++++++++
>   2 files changed, 12 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2cca20563a1d..99190a6ba6ff 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
> +
> +apq8016-sbc-usb-host-dtbs	:= apq8016-sbc.dtb apq8016-sbc-usb-host.dtbo
> +
> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-usb-host.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3-camera-mezzanine.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso b/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
> new file mode 100644
> index 000000000000..a82c26b7eae8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&usb {
> +         dr_mode = "host";
> +};
