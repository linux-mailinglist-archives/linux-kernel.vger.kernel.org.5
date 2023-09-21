Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5821E7A9978
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjIUSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjIUSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:14:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3266A86E4D;
        Thu, 21 Sep 2023 10:38:14 -0700 (PDT)
Received: from [192.168.1.23] (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AE526607310;
        Thu, 21 Sep 2023 15:01:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695304911;
        bh=3yyWULKsjhkzzVa9p1IJTEYYL2jBpe+zpuFtKjH7+oA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CBPEGhhBs5OUcu324ztmJ3Bu8KarI6VTr6bI9r1B88hlpXMeZjnm31An8Bio6kRY+
         Y+O1+bnmOkyn2FnXfheLP7AHHE5GBRu2po/2TCKYriru/oB+Nojv7NmLASCw73KDwg
         AZZORMaV9fK4Pl2Izg/7ZpOQs6RLN9zkuxZ3sHCKA894PTaKjk0HB3Gtr6C5FNkwsl
         QEOqhXe3+SOu6EDutNnDpSVdwhS2p/r5iEi/eggAQ2copuyibLFH4qwooOSoy9+7FF
         nX5MmRECQ2VscvwQTGh2N/Ta7ihDbaK2xCMQt2Pmv/cHsIy2Mxw+rQv+nzU/ZjtBQA
         zNzzWT6eGtLMA==
Message-ID: <29e47c3e-e10d-9268-93c7-133c959c5a82@collabora.com>
Date:   Thu, 21 Sep 2023 19:31:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: apq8016-sbc: Add overlay for usb host
 mode
Content-Language: en-US
To:     Helen Koike <helen.koike@collabora.com>,
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
 <a411b3fe-6222-4c86-8d71-afa992ea2f93@collabora.com>
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <a411b3fe-6222-4c86-8d71-afa992ea2f93@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainers,

On 12/09/23 22:39, Helen Koike wrote:
> 
> 
> On 11/09/2023 13:15, Vignesh Raman wrote:
>> Due to the presence of the fastboot micro cable in the CI farm,
>> it causes the hardware to remain in gadget mode instead of host mode.
>> So it doesn't find the network, which results in failure to mount root
>> fs via NFS.
> 
> Just a context for others, this was part of this patch series 
> https://lore.kernel.org/r/20230908152225.432139-1-vignesh.raman@collabora.com
> 
>>
>> Add an overlay dtso file that sets the dr_mode to host, allowing the
>> USB controllers to work in host mode. With commit 15d16d6dadf6
>> ("kbuild: Add generic rule to apply fdtoverlay"), overlay target can
>> be used to simplify the build of DTB overlays. It uses fdtoverlay to
>> merge base device tree with the overlay dtso. apq8016-sbc-usb-host.dtb
>> file can be used by drm-ci, mesa-ci.
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> Signed-off-by: David Heidelberg <david.heidelberg@collabora.com>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> 
> Acked-by: Helen Koike <helen.koike@collabora.com>
> 
> 
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile                  | 4 ++++
>>   arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso | 8 ++++++++
>>   2 files changed, 12 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index 2cca20563a1d..99190a6ba6ff 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -1,5 +1,9 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8016-sbc.dtb
>> +
>> +apq8016-sbc-usb-host-dtbs    := apq8016-sbc.dtb 
>> apq8016-sbc-usb-host.dtbo
>> +
>> +dtb-$(CONFIG_ARCH_QCOM)    += apq8016-sbc-usb-host.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8016-sbc-d3-camera-mezzanine.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8039-t2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += 
>> apq8094-sony-xperia-kitakami-karin_windy.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso 
>> b/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
>> new file mode 100644
>> index 000000000000..a82c26b7eae8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&usb {
>> +         dr_mode = "host";
>> +};

Please could you review this patch. Thanks.

Regards,
Vignesh
