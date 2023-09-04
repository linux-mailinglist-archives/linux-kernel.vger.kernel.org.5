Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB5D791DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjIDToO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjIDToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:44:08 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20CFB4;
        Mon,  4 Sep 2023 12:44:04 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B39993F289;
        Mon,  4 Sep 2023 21:43:56 +0200 (CEST)
Date:   Mon, 04 Sep 2023 21:43:49 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 5/6] arm64: dts: allwinner: h616: Add CPU Operating
 Performance Points table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
Message-Id: <158H0S.OVEJGSQROBDV1@somainline.org>
In-Reply-To: <a6c074ec-81d6-4fde-98c7-fc2750483514@linaro.org>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
        <20230904-cpufreq-h616-v1-5-b8842e525c43@somainline.org>
        <a6c074ec-81d6-4fde-98c7-fc2750483514@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Sep 4 2023 at 09:33:33 PM +02:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 04/09/2023 17:57, Martin Botka wrote:
>>  Add an Operating Performance Points table for the CPU cores to
>>  enable Dynamic Voltage & Frequency Scaling on the H616.
>> 
> 
> ...
> 
>>  diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>  index 063db9634e5f..78e79c591dba 100644
>>  --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>  +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>  @@ -143,6 +143,10 @@ sid: efuse@3006000 {
>>   			ths_calibration: thermal-sensor-calibration@14 {
>>   				reg = <0x14 0x8>;
>>   			};
>>  +
>>  +			cpu_speed_grade: cpu_speed_grade@0 {
> 
> Underscores are no allowed in node names.
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
I actually did. And did rerun it just now to check. No error or warning 
was reported by dtbs_check W=1 for this.
But I will correct it in V2 and look if my setup is doing something 
wrong that its not reporting these issues.
Cheers,
Martin
> 
> Best regards,
> Krzysztof
> 


