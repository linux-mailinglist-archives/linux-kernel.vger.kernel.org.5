Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B380012C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjLABlr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 20:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:41:45 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6810F8;
        Thu, 30 Nov 2023 17:41:51 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id AEF8624E257;
        Fri,  1 Dec 2023 09:41:29 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 09:41:29 +0800
Received: from [192.168.125.136] (113.72.145.176) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 09:41:28 +0800
Message-ID: <95ec1fa5-1ab1-439f-96db-0ae2989915ce@starfivetech.com>
Date:   Fri, 1 Dec 2023 09:41:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mason.huo@starfivetech.com>,
        <leyfoon.tan@starfivetech.com>, <minda.chen@starfivetech.com>
References: <20231130183504.GA487377@bhelgaas>
From:   Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20231130183504.GA487377@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/1 2:35, Bjorn Helgaas wrote:
> On Thu, Nov 30, 2023 at 06:03:55PM +0800, Kevin Xie wrote:
>> On 2023/11/30 7:21, Bjorn Helgaas wrote:
>> > On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
>> >> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
>> >> time between sending the first configuration request to the device and
>> >> exit from a conventional reset (or after link training completes).
>> > 
>> > s/marco/macro/
>> > 
>> > List the first event before the second one, i.e., the delay is from
>> > exit from reset to the config request.
>> 
>> OK，I will use "from A to B" instead of "between A and B".
> 
> That's not my point.
> 
> My point was you said "between B (config request) and A (exit from
> reset)".  "A" happens first, so it should be mentioned first.
> 

Got it.

>> > I assume there are follow-on patches that actually use this?  Can we
>> > make this the first patch in a series so we know we don't have an
>> > unused macro lying around?
>> 
>> Yes, we will use the marco in the next version of our PCIe controller patches.
>> Here is the link of current version patch series:
>> https://lore.kernel.org/lkml/20231115114912.71448-20-minda.chen@starfivetech.com/T/#u 
>> 
>> Do you mean that I should put this patch back to the above series as
>> one of the separate patches?
> 
> Yes, please.  Handling them as a group is less overhead and helps
> avoid merge issues (if they're all in a series there's no possibility
> that the user gets merged before the macro itself).
> 

OK, I will put the patch back with these changes.

> Bjorn
