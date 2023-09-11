Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE279B148
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376503AbjIKWTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjIKMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:39:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CACCEB;
        Mon, 11 Sep 2023 05:39:09 -0700 (PDT)
Received: from [192.168.1.23] (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7697366072FE;
        Mon, 11 Sep 2023 13:39:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694435947;
        bh=MvnxIayMmPEsq2MzqcxVyvlilHrYAvXUGbuaSX/LxBs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LZ1l9Qf8rixIpz+94pqn/E7NIehaqLf/Jh8WJCYZmTcCqgTQa2ONJuqnA67jpdhKT
         X21KmOmasjXROM25ITuqounnLMzzSCjVDiqgkRV15kt1le7Q9n+vNhRFom03J7M9Zl
         dez0ecWl/mjrXet7A1BYTCEJOzEqwiiN/nTjyI6asZvlUm/uQIxpTaiZ5ofEePomjR
         +WL4/ZD/aGiRPfDFYvuWIeQ60STYhgwtQo/TZTdpNn6vdUJmPVUoilr+Wjx/dnSWng
         vV844qIYFJT5iAViLP2AG/G58VNVknnvHlDgnJQ6FRYCESGBwRdR1iSZJqVm7+wFf/
         YTI7qV/10AamQ==
Message-ID: <ca518c28-1375-9eaf-ffd4-bedf06810000@collabora.com>
Date:   Mon, 11 Sep 2023 18:08:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/9] arm64: dts: qcom: apq8016-sbc: Add overlay for usb
 host mode
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        angelogioacchino.delregno@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
 <20230908152225.432139-3-vignesh.raman@collabora.com>
 <ca53e4cd-1c89-482d-9662-19926efb5b47@linaro.org>
From:   Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <ca53e4cd-1c89-482d-9662-19926efb5b47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 11/09/23 17:20, Konrad Dybcio wrote:
> On 8.09.2023 17:22, Vignesh Raman wrote:
>> Due to the presence of the fastboot micro cable in the CI farm,
>> it causes the hardware to remain in gadget mode instead of host mode.
>> So it doesn't find the network, which results in failure to mount root
>> fs via NFS.
>>
>> Add an overlay dtso file that sets the dr_mode to host, allowing
>> the USB controllers to work in host mode. This dtso file will be used
>> in drm-ci, mesa-ci.
>>
>> Overlay DT file uses the sugar syntax [suggested by Dmitry Baryshkov and Maxime Ripard]
>>
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> Signed-off-by: David Heidelberg <david.heidelberg@collabora.com>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
> For such a small change, maybe you can just use sed in your
> scripts to alter this?

This was the initial idea 
https://patchwork.kernel.org/project/linux-mediatek/patch/20230825122435.316272-3-vignesh.raman@collabora.com/

Since there was a review comment that CI should not make changes to the 
source tree before building, we went with DT overlay.

Regards,
Vignesh
