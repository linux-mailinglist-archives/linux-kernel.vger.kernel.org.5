Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117327A334B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjIPW4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjIPWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:55:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468D180;
        Sat, 16 Sep 2023 15:55:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53FDC433C7;
        Sat, 16 Sep 2023 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694904943;
        bh=H0ZrldvnfeVZPHSa0DBgUu2f3ukwWSY37W0/p+0tIhI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ag8IiPH8W7OwjdVeYpesBaJoyAXRmOIXJsXTFpoE84VDbGPNGyQudghhqjzq8K/dZ
         pxIHoAR4vlb8pjKRfMUyQniHI9jjgQiJ5nANkzKYlPwKYHrKVyiRjGStasWKtMM+5B
         YmLkFcNo5/FE+yu1NxYgmrXMQ8DqkR3tR1OxIrmgpfsWFavLSVLJPWjiAYwuaVlh6Q
         qoCOie//ELyq9T+xs7ykm6MQ22C5QzigIEpIl5VRzN9H7V5tZITybEiixX8nkpTGxO
         HFbpAqnyJ7h1Il7U5zqisyM3YazGtwlMbXHciwmks725eksyLHFjYuHlz+ElTZ9h5v
         IAlgLCQukcYjQ==
Message-ID: <c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org>
Date:   Sun, 17 Sep 2023 01:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
 <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
 <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
 <accb4814-4826-ff97-3527-4e3fbadcd4ff@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <accb4814-4826-ff97-3527-4e3fbadcd4ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 16.09.23 23:32, Krzysztof Kozlowski wrote:
> On 16/09/2023 17:13, Georgi Djakov wrote:
>>
>>>
>>> Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
>>> the reasons somewhere on why they are added as =y?
>>>
>>> CONFIG_INTERCONNECT_QCOM=y
>>> CONFIG_INTERCONNECT_QCOM_MSM8916=m
>>> CONFIG_INTERCONNECT_QCOM_MSM8996=m
>>> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>> CONFIG_INTERCONNECT_QCOM_QCM2290=m
>>> CONFIG_INTERCONNECT_QCOM_QCS404=m
>>> CONFIG_INTERCONNECT_QCOM_SA8775P=y
>>> CONFIG_INTERCONNECT_QCOM_SC7180=y
>>> CONFIG_INTERCONNECT_QCOM_SC7280=y
>>> CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>> CONFIG_INTERCONNECT_QCOM_SDM845=y
>>> CONFIG_INTERCONNECT_QCOM_SM8150=m
>>> CONFIG_INTERCONNECT_QCOM_SM8250=m
>>> CONFIG_INTERCONNECT_QCOM_SM8350=m
>>> CONFIG_INTERCONNECT_QCOM_SM8450=y
>>> CONFIG_INTERCONNECT_QCOM_SM8550=y
>>
>> If the device can boot (to console/initramfs) with =m, we go with that.
>> But if something critical like the UART depends on the interconnect
>> provider, then we make it built-in.
>>
>> On SM8550 for example, we have enabled bandwidth scaling support for QUP
>> and that's why it needs to be =y.
>>
>> It looks like on SM4450 this should be =y too.
> 
> I asked why SM4450 has to be =y and there was no answer. The argument
> that SM8450 is a module, is not applicable.

 From the hardware description i see in patch 7, the serial engine depends
on some interconnect provider. But as the serial console driver is only
available as built-in, the interconnect provider also needs be built-in
for the UART device to probe and register the console.

So the answer to your question should be that this is needed by the UART
device (at least).

Such details of course deserve to be mentioned in the commit message of
this patch.

BR,
Georgi

