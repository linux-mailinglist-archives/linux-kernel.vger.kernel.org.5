Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B8773D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjHHQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjHHQO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:14:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AFB449B;
        Tue,  8 Aug 2023 08:41:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378EJ5s0100122;
        Tue, 8 Aug 2023 09:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691504345;
        bh=bIH/ji03oG1ftTHsnzYCd9SbhQm9NI9ogdBByjAqw3g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=CljD2Ue4/x/tDJlVbhREoZEp9Y1AwWcmprU86N4lpDflKvfbluba9cJdraFOYMKXF
         xzcMb0sgjcJfES5Iue5IPmjsATi9OMg/mjqwDrW4sPcDVYqH6GqGuoaMdLzJJiLJku
         n28xRCtSygaAGflOXBH7aU8BKDr51e30liNIE2V0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378EJ5Lj032590
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 09:19:05 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 09:19:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 09:19:04 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378EJ4RE001024;
        Tue, 8 Aug 2023 09:19:04 -0500
Message-ID: <8f4b8276-9285-4e90-e4f0-9af4925a8634@ti.com>
Date:   Tue, 8 Aug 2023 09:19:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/13] arm64: dts: ti: k3-am64: Enable OSPI nodes at
 the board level
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230808133457.25060-1-afd@ti.com>
 <20230808133457.25060-8-afd@ti.com>
 <58daf644-7b16-4768-8885-bd60aa6c014f@ti.com>
 <20230808141725.65r25aoot54zcwex@turbojet>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230808141725.65r25aoot54zcwex@turbojet>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 9:17 AM, Nishanth Menon wrote:
> On 09:13-20230808, Andrew Davis wrote:
>> On 8/8/23 8:34 AM, Andrew Davis wrote:
>>> OSPI nodes defined in the top-level AM64 SoC dtsi files are incomplete
>>> and may not be functional unless they are extended with pinmux and
>>> device information.
>>>
>>> As the attached OSPI device is only known about at the board integration
>>> level, these nodes should only be enabled when provided with this
>>> information.
>>>
>>> Disable the OSPI nodes in the dtsi files and only enable the ones that
>>> are actually pinned out on a given board.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>>> ---
>>
>> Oops, I see we have a new AM64 board in -next (tqma64xxl), I can either
>> rebase this again and enable the nodes in there. Or you can skip this
>> and the other AM64 patch in this series and I'll resend them next cycle
>> when that new board is settled.
> 
> we should respin this series taking the new boards into consideration -
> am64 and am62 both have new boards.
> 

No problem, v3 on the way.

Andrew
