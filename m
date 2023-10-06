Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573D27BB747
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJFMDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjJFMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:03:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B10F2;
        Fri,  6 Oct 2023 05:03:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106D5C433C7;
        Fri,  6 Oct 2023 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696593799;
        bh=b/loAVhv+05F1dRd/uZATizDv0mFcEZF9GrpYWKet2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k4fdN0Um6sRBvIDQ8qWQN6Z7nRtwmmETohf5F+jAWNT414i08GKfJlY9lcKW7oeRm
         Jzd92qzYBWCVve/wDtOapmxVinrb8w8qLB+1x2jtqG3iQcpK2Lu3V9DzkyFVau2xfS
         Ro6mnU1c5OKRne361tWc3l1c0LzWfYIaPEIiEYRpmqBsW/ddhZLihyX3ZTEaCD4p0d
         pf0/DnGvjaL4g/eK42bOarsYDSF3iEczLJvILhyH64rKUNTzt2puE4kpIqyl1/GeVx
         BpvbayD0sKiyXAKWF30ww/ngoW+ix3GhUq5l+ycsZ3DpN0z5o+FV4QuJ6IoYMRpFto
         EBwOxJ7yWH8XA==
Message-ID: <fde87d28-ee5d-4e02-b824-27c1cb7c1e38@kernel.org>
Date:   Fri, 6 Oct 2023 15:03:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the ti tree
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc:     "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Yadav, Nitin" <n-yadav@ti.com>
References: <20231005141536.77538147@canb.auug.org.au>
 <f70dec2a-dbdf-479c-af5b-a70db02b27b4@ti.com>
 <2905cfc2-912f-4620-9455-2e91586a2839@kernel.org>
 <20231005132921.2vg6kdcr273bh7et@cabbage>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231005132921.2vg6kdcr273bh7et@cabbage>
Content-Type: text/plain; charset=UTF-8
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



On 05/10/2023 16:29, Nishanth Menon wrote:
> On 16:12-20231005, Roger Quadros wrote:
>> Hi,
>>
>> On 05/10/2023 11:25, Raghavendra, Vignesh wrote:
>>> + Rob and DT list
>>>
>>> Hi Stephen
>>>
>>> On 10/5/2023 8:45 AM, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> [I may have missed this yesterday, sorry]
>>>>
>>>> After merging the ti tree, today's linux-next build (arm64 defconfig)
>>>> produced these warnings:
>>>>
>>>> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #address-cells value
>>>> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #size-cells value
>>>>
>>>> Introduced by commit
>>>>
>>>>   45a0c06571e1 ("arm64: dts: ti: am642-evm: Add overlay for NAND expansion card")
>>>>
>>>
>>> Thanks for the report. I will drop the offending comment.
>>>
>>> Roger,
>>>
>>> Sorry, this would need to be fixed in dtc or need exception from DT
>>> maintainers to ignore the warnings.
>>
>> Please don't drop this patch as the issue is not with the patch but with
>> the dtc tool itself.
>>
>> As this is a DT overlay there is no way to specify address-cells/size-cells
>> of parent here. This will be resolved only after merge with base tree.
>>
>> This will be fixed in next dtc sync.
>> https://www.spinics.net/lists/devicetree-compiler/msg04036.html
>>
>> See further discussion here
>> https://lore.kernel.org/all/CAL_JsqLmv904+_2EOmsQ__y1yLDvsT+_02i85phuh0cpe7X8NQ@mail.gmail.com/
>>
> 
> Roger, build warnings are a strict NO,NO for kernel. Lets bring in the
> series *after* the dtc sync is complete.
> 

Hi Rob,

Following commit from dtc is required to resolve this issue.

afbddcd418fb ("Suppress warnings on overlay fragments")

FYI. Another patch of similar nature is on its way and will also require the
above commit to DTC.
https://lore.kernel.org/all/20231005093739.4071934-3-n-yadav@ti.com/

-- 
cheers,
-roger
