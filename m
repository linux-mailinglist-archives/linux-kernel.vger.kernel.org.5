Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D372D76EE8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbjHCPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjHCPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:46:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528E2690
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691077561;
        bh=9itqY6Wgw5GgXR3xB++ndoCEbBsHTl393lPDnaxaAjY=;
        h=Message-ID:Date:MIME-Version:Subject:To:From;
        b=iYwfmiuWdcR5dmGtbQHu3EKnLgL9Cmd0zQrOCoBrbzMTUvUwiZR7ttmFkcFAAhvHO
         nuMgvLYMolCryu93G5ZuF/qwIGAqVia8pnJZwwQtg8zYKVXNbBuADp7OWXdXPkPt3m
         Rg2ou1vrmqQ4MBQFZYfL1D44oKziuN2hdetthocE=
X-QQ-mid: bizesmtp74t1691077514tkf8fhcb
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 23:45:02 +0800 (CST)
X-QQ-SSF: 01400000000000402000000A0000000
X-QQ-FEAT: vLOCICHxEeD144kjiyvBVlfmmWfGFzD33ioHK7gbvaMUtB98c2fZL9ALtgsQj
        sPbxdlzg5ZAwV5zhTYQsO5Zu1Rt4NdK2Yk2BMZ3Yzd/unsCdZXyH7QWjoDriVgwnESOe2qL
        X+bDPh1/oCuWw2zO9E9bHHf8b/gX6BKSHQPd7eGFnHS33klwW/Z6XO5lBMfHewUxPkx/Bd+
        1c5D58Nis3gXxBD6PqaybSRR3WIjEw9M4asyIbr6y7rEMi+y4RBjRHYGYvH2r+ROg5EIGvd
        6grOLc5hNf34cZVojQ8AlgqGKJ+nJOqfxHQEHOun+MAc3LScnBcRIQj4V9F33bwvJPGKfB/
        BqWdjNrLdECJuMmFqwqyTqxkDlkfRWRkhE64xwzzcCkal4SOlJoAa/GdHg8bnA4uWRgm0tm
        Fx7jpH0LE5c=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6842329673790885231
Message-ID: <DE358EDBFBB38BFB+37244c66-7f98-7e23-86eb-985c316e57ad@biqu3d.com>
Date:   Thu, 3 Aug 2023 17:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 6/6] arm64: dts: allwinner: h616: Add BigTreeTech Pi
 support
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230802220309.163804-1-martin@biqu3d.com>
 <DFE9B2F1349F69AE+20230802220309.163804-7-martin@biqu3d.com>
 <20230803133913.368d055d@donnerap.manchester.arm.com>
From:   Martin Botka <martin@biqu3d.com>
In-Reply-To: <20230803133913.368d055d@donnerap.manchester.arm.com>
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



On 8/3/23 2:39 PM, Andre Przywara wrote:
> On Thu,  3 Aug 2023 00:02:39 +0200
> Martin Botka <martin@biqu3d.com> wrote:
> 
> Hi,
> 
>> The BigTreeTech Pi is an H616 based board based on CB1.
>> Just in Rpi format board.
>>
>> It features the same internals as BTT CB1 but adds:
>>      - Fan port
>>      - IR receiver
> 
> You would then need to enable the "ir" node, check the X96 Mate .dts.
Got it.
> 
> And I think this "ADXL345 SPI" connector justifies enabling the respective
> SPI node.
Yea the accelerator. Sadly this is bit hard to actually test fully if 
not wired up to a printer. Tho i do have a spare board to serve as fake 
printer. Klipper will not know any better :)
> 
>>      - 24V DC power supply via terminal plugs
>>      - USB to CAN module connector (The actual USB to CAN happens on the external module)
> 
> Still confused how this works. So you would need to connect an USB->CAN
> adapter to one of the USB ports, but how do you feed the CAN signal back
> to the board? Or if this is done via this port, where does it go then? To
> the GPIO header?
OK so its not great but an USB port is also connected to 2x2 pin 
connector and secondary 2x2 pin connector slightly away. The USB to CAN 
module plugs into these 2x2 pin connectors where one serves as USB and 
the other one receives the CAN signal from the module and just wires it 
up to an XH2.54 3 pin connector with CAN+ CAN- and GND.
> 
>> List of currently working things is the same as BTT CB1.
>>
>> Signed-off-by: Martin Botka <martin@biqu3d.com>
>> ---
>>   .../allwinner/sun50i-h616-bigtreetech-pi.dts  | 44 +++++++++++++++++++
> 
> Please wire this up in the Makefile as well, otherwise we will miss out on
> the build testing and DTB checking.
YEP very much my bad on that one. Didnt add the file during git add :)
> 
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>> new file mode 100644
>> index 000000000000..05f39b3606ba
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-h616-bigtreetech-cb1.dtsi"
>> +
>> +/ {
>> +	compatible = "bigtreetech,pi", "allwinner,sun50i-h616";
>> +};
>> +
>> +&ehci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci2 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci2 {
>> +	status = "okay";
>> +};
>> +
>> +&ehci3 {
>> +	status = "okay";
>> +};
>> +
>> +&ohci3 {
>> +	status = "okay";
>> +};
> 
> Oh wow, it really connects all four USB ports directly to the SoC? Nice.
It indeed does :)
> Do you have access to the schematic to check what the power supply
> situation is? Are all ports hardwired to a fixed 5V source?
Correct just fixed 5V. Tho with the changes needed in CB1 DTSI file no 
change will be necessary here for this :)
> 
> And you would of course need to adjust this file according to the
> changes requested in the previous patch, so that you have the UART,
> stdout-path and other moved nodes in here.
Got it will do.

Cheers,
Martin
> 
> Cheers,
> Andre
> 
