Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324F680F23D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346694AbjLLQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjLLQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:17:39 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD5101
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:17:18 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGH0on098793;
        Tue, 12 Dec 2023 10:17:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702397820;
        bh=4/CmJKXHRUcQwEQw43y5vU5FwPq4HJBz4hZnV6bU5eM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LljHGwNzU6UeSA0CzouFnPLSymbhD6LfuIBiRzgqJUA1kJrenGBxB63KOAIR09uP8
         zhwItUq56a+ipqtRWLgMTxF3X+agHg8VAxFrM1kCINrjKWwrabe5g6dgC//746Vl/e
         vDDDIo0J8+zF6Ko2ymD08JAJ1Af1kuXRPyO0Mgqk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCGH0pO060266
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Dec 2023 10:17:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 10:17:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 10:17:00 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCGGxxS068641;
        Tue, 12 Dec 2023 10:17:00 -0600
Message-ID: <6c331be3-350d-4840-acbd-144a65efa954@ti.com>
Date:   Tue, 12 Dec 2023 10:16:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add JTAG ID for J722S
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
References: <20231211132600.25289-1-vaishnav.a@ti.com>
 <81f90d13-da10-4a68-a0e7-95212f40b3e8@ti.com>
 <20231212154238.3sn5fxpestaqacrc@defog>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20231212154238.3sn5fxpestaqacrc@defog>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 9:42 AM, Nishanth Menon wrote:
> On 09:19-20231212, Andrew Davis wrote:
>> On 12/11/23 7:26 AM, Vaishnav Achath wrote:
>>> Add JTAG ID info for the J722S SoC family to enable SoC detection.
>>>
>>> More details about this SoC can be found in the TRM:
>>> 	https://www.ti.com/lit/zip/sprujb3
>>>
>>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>>> ---
>>
>> Simple enough,
>>
>> Reviewed-by: Andrew Davis <afd@ti.com>
>>
>> Although I do question our use of the J7x names. All of our parts here
>> also have a "Sitara AMxx" branding. For instance here we could call
>> this new device by its "AM67" name, then J784S4 renamed as AM69, etc.
>> Then we would have a consistent naming (internally we will have to deal
>> with the part name madness, but why expose that externally if we don't
>> have to).
> 
> J722S is a new die and the core part, what rebranding/spins happens to it is
> subject to mktg group, not going to hold this series with that.
> 

Never said to hold the series (I even gave my R-B), just a suggestion for
later. Or more important when we add the DTB and other names to be consistent
and use the correct part names and not always use the parent/die/family name.

Andrew
