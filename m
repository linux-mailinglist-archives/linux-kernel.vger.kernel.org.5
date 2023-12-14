Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247C9813227
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573290AbjLNNuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573115AbjLNNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:50:40 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5828E;
        Thu, 14 Dec 2023 05:50:46 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BEDob6B066265;
        Thu, 14 Dec 2023 07:50:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702561837;
        bh=1MFgmM+99t7S332JrEimE+YAbkE70zysXns5rbpIq8U=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=Yc12oRuc5GpXnsPSzDReJntbhwMr56bUesxbHSO8ockBZgabQOY2zM7I4L2Jarg35
         VN2QIkO7GXE4sltLnNN5Wej44hREhFk1C4djXoYGlvfhoRC5Hh3nOmFeWpxAlsKDdy
         /aZCk1StG0CzvzVZfKgjGA53ZQ8umMeLRLtZ6sGQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BEDobRA001613
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Dec 2023 07:50:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 07:50:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 07:50:37 -0600
Received: from [10.249.131.186] ([10.249.131.186])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BEDoXZ7088063;
        Thu, 14 Dec 2023 07:50:34 -0600
Message-ID: <0cef8f50-6608-cf3d-ad62-1afd3f5560ea@ti.com>
Date:   Thu, 14 Dec 2023 19:20:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-icssg2: Enable PHY interrupts
 for ICSSG2
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
References: <20231213080216.1710730-1-s-vadapalli@ti.com>
 <20231213123819.tqh3lm2ceir3qjbk@swimmer>
 <6f1c1a59-cec0-46d1-8ecb-a82d9d444ccf@ti.com>
 <20231214121727.ayrbqz2nmeb25rpw@striving>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20231214121727.ayrbqz2nmeb25rpw@striving>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14-12-2023 17:47, Nishanth Menon wrote:

...

>>
>> Yes, you are right! Edge-Triggered interrupts shouldn't be shared. I missed
>> noticing this. Thank you for pointing it out. Since the SoC only supports
>> Edge-Triggered interrupts, I believe that the correct decision would be to use
>> the interrupt for only one of the two PHYs, while leaving the other PHY in
>> polled mode of operation which is the default.
>>
>> Kindly let me know if this is acceptable and I shall update this patch accordingly.
> 
> Sounds like a bug in board design there (due to an choice of IP
> limitation) - I suggest getting it noted in board documentation and
> refer to the errata in the second phy (else folks will wonder why we
> aren't using interrupts on the second phy.

Thank you for your suggestion on the next steps to be taken. I will
ensure that the board documentation is updated. Additionally, in the v3
patch I will add a comment within the "icssg2_phy0" node indicating that
the interrupt mode of operation is only being enabled for "icssg2_phy0"
due to the interrupt being an edge-triggered interrupt which cannot be
shared among both the PHYs. And for that reason "icssg2_phy1" is being
left in the default polled mode of operation.

-- 
Regards,
Siddharth.
