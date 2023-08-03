Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9B76EEAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbjHCPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjHCPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:51:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A22109
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691077904;
        bh=c6hFVhu8IksY+L1isInXQkxJGCppe2/DOz14aNlE2hI=;
        h=Message-ID:Date:MIME-Version:Subject:To:From;
        b=IXf9dSpWEgaubk1xnqZIqvxTWMR7ZKaafC1WM8fNoXvK5VqvNibqM5+6ex+Nm7Sbe
         Iz1OEoe6FgP88VY+3f1+wcw+SDbnWRfkd2czxQp2m814wARjeyOPL7Zri6bNpOAYYq
         J27vatEWiy7E16c0rlaNMNr3L1vElmW/rvTx+4uY=
X-QQ-mid: bizesmtp76t1691077857tu7elv4u
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 23:50:45 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: W+onFc5Tw4PG4OgGzcrbSq3SNJNCAX668+fM7+4uFuHR/EV1k9ENzQro0VfHX
        DeWCrfsc7KHpi/+OcnFfWo9/8Jg6ab3nCPZzuQ7lYU3drXoLLXtOsOSe+Y/I7XABZEUCKBt
        Ny3p06rK1IPLAfc5sbD5QfdCGLg4oLjMqXa3EKrbertkrTHTCvYAIbeM5XNXZfhSqZV9QWQ
        p9MC63uVY6FDL5EySiZUqCFro8JfvusWxRoz1aYqCP+nf7tvd73QLduk4ZYXHjGkzKARhyk
        ZS+7KVAiRsDj/fsUKS4qZRyCQaxB3xYmWtdZs4ing+b+qz281n3GEuz1LQu1GHUA0xanaYm
        3L66NCJ0cmpIhQfrpFoi68oymQMzQ29VcTfWYT3GAZ2N75bhBWfu9aTyqHtqqwq16sYqVKh
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2003181577924122140
Message-ID: <0FF79B770AD31251+44408a50-d082-f3db-a60b-59ed0cb75e42@biqu3d.com>
Date:   Thu, 3 Aug 2023 17:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 5/6] arm64: dts: allwinner: h616: Add BigTreeTech CB1
 SoM & boards support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <85E425AED000D34C+20230802220309.163804-6-martin@biqu3d.com>
 <9f1210b8-1726-a7a3-622b-8fef778cba3e@linaro.org>
From:   Martin Botka <martin@biqu3d.com>
In-Reply-To: <9f1210b8-1726-a7a3-622b-8fef778cba3e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 4:28 PM, Krzysztof Kozlowski wrote:
> On 03/08/2023 00:02, Martin Botka wrote:
>> From: Martin Botka <martin.botka@somainline.org>
>>
>> CB1 is Compute Module style board that plugs into Rpi board style adapter or
>> Manta 3D printer boards (M4P/M8P).
>>
>> The SoM features:
>>    - H616 SoC
>>    - 1GiB of RAM
>>    - AXP313A PMIC
>>    - RTL8189FTV WiFi
> 
> ...
> 
>> +&mmc0 {
>> +	vmmc-supply = <&reg_dldo1>;
>> +	broken-cd;
>> +	bus-width = <4>;
>> +	status = "okay";
>> +};
>> +
>> +&mmc1 {
>> +	vmmc-supply = <&reg_vcc33_wifi>;
>> +	vqmmc-supply = <&reg_vcc_wifi_io>;
>> +	mmc-pwrseq = <&wifi_pwrseq>;
>> +	bus-width = <4>;
>> +	non-removable;
>> +	mmc-ddr-1_8v;
>> +	status = "okay";
>> +
>> +	rtl8189ftv: sdio_wifi@1 {
> 
> No underxcores in node names. Generic node names, so probably "wifi".
Got it.
> 
>> +		reg = <1>;
> 
> Missing compatible?
No it is an explicitly defined SDIO device so we can add ethernet alias 
for it so we can for example set the MAC address of it via u-boot and etc :)

The actual driver for it is out of tree and from the current state of it 
looks like will be for a while.
Orange Pi Zero Plus based on H5 does this exact thing as well for the 
same purpose with the same wifi chip :)

Cheers,
Martin
> 
> 
> 
> Best regards,
> Krzysztof
> 
> 
