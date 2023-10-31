Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421C97DC71B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbjJaHVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjJaHVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:21:00 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ECAC0;
        Tue, 31 Oct 2023 00:20:58 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 3B01542363;
        Tue, 31 Oct 2023 12:20:51 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698736852; bh=PqxIDlMZlqQcrUHtOkXEHC1O2DOStY7qgo4b7QqHNLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BUFsNtKIrTxlRHBs4mnoUliDpX1RSmRU92ssscvzPoGAjsc0Db2DsR4Y7YW15mR/N
         m+fuvh7JKZ7MVp82SCwhMXPNpFopHNjvtUC7k/WxPhH0nvRUtfBwvkjiEtTUqkWRYe
         OPM0g6kujjv36yaK7kgvsO1cVtjXodOO848TqE7vD/aBB5N2Tod4GLdi2A5DycZpfo
         wH4uDec93yhlgnA1Y4Bi2faDt1IAedDEqDPdOFfpGt21V3dAr8nxSAh8V63JeBGjLC
         lHAAIDrkNcRdX0L962JunpvRlLOnOLHJizOe18FOHtYAN7X3yHS2UOZNa9afuN+XAs
         h8B0ToRE4XvkQ==
MIME-Version: 1.0
Date:   Tue, 31 Oct 2023 12:20:49 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: acer-aspire1: Correct audio codec
 definition
In-Reply-To: <3a423cb7-cdf1-433a-a848-8636917640bb@linaro.org>
References: <20231027-aspire1-sound-v1-0-5ff3cf8b5701@trvn.ru>
 <20231027-aspire1-sound-v1-2-5ff3cf8b5701@trvn.ru>
 <3a423cb7-cdf1-433a-a848-8636917640bb@linaro.org>
Message-ID: <eda1c91bd2dce76e633dd82ad3105355@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,DOS_RCVD_IP_TWICE_B,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio писал(а) 31.10.2023 02:48:
> On 27.10.2023 16:42, Nikita Travkin wrote:
>> When initially added, a mistake was made in the definition of the codec.
>>
>> Despite the fact that the DMIC line is connected on the side of the
>> codec chip, and relevant passive components, including 0-ohm resistors
>> connecting the dmics, are present, the dmic line is still cut in
>> another place on the board, which was overlooked.
>>
>> Correct this by replacing the dmic configuration with a comment
>> describing this hardware detail.
>>
>> While at it, also add missing regulators definitions. This is not a
>> functional change as all the relevant regulators were already added via
>> the other rail supplies.
>>
>> Fixes: 4a9f8f8f2ada ("arm64: dts: qcom: Add Acer Aspire 1")
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> index cfde8cd47107..00b442696618 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
>> @@ -209,9 +209,22 @@ alc5682: codec@1a {
>>  		AVDD-supply = <&vreg_l15a_1p8>;
>>  		MICVDD-supply = <&reg_codec_3p3>;
>>  		VBAT-supply = <&reg_codec_3p3>;
>> +		DBVDD-supply = <&vreg_l15a_1p8>;
>> +		LDO1-IN-supply = <&vreg_l15a_1p8>;
>> +
>> +		/*
>> +		 * NOTE: The board has a path from this codec to the
>> +		 * DMIC microphones in the lid, however some of the option
>> +		 * resistors are absent and the microphones are connected
>> +		 * to the SoC instead.
> Would that not also require more DT changes and maybe UCM?

I don't think I had any other descriptions to support the dmic in
the initial set (first audio support for this board is 3/3 here)
and there is no upstream UCM yet - I will probably hold it off until
I get vamacro and dmic on it working.

Nikita

> 
> Konrad
