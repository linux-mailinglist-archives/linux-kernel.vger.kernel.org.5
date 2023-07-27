Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1793765049
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjG0JuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjG0Jt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:49:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA7E35A1;
        Thu, 27 Jul 2023 02:49:29 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36R9aF7A012017;
        Thu, 27 Jul 2023 04:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=jMvL9VlxQ9UJpNngccwFBjpOPFbato9a8JtaOXUwEik=; b=
        d2K2kZvNEQro5YxOswWZ55QDBQjOMqzqdDK74unjANHqaNNfaTlZGZuEC91S2MC4
        wkFrgFF5Hz+y9giIpedlyELjDU46ROa5GVRNS4akzkp80M++X741jJa4MI1YOgFq
        5I/FjHU8V3EbTMe7XvB9G+18WJCEVb8TAQuLM9m7FGDL7hpjBEPQKDJNJkgrahpy
        wX25wEXV0Kg7SLsLU4e//o/Qout4iUaa8fDfOsZ4fwOTpv+57ZEHIGEDXFWuFOyR
        FHWpy79YhE9mlf0bKmpjHgoWCBT9BDdz6gq7UqbbhJIpY19lS+z3V5PQafv4ymfH
        +LUi7pOHpiCPOPDJyGWf9A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s1nm9bshy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:48:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 10:48:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 27 Jul 2023 10:48:05 +0100
Received: from [198.61.65.196] (EDIN4L06LR3.ad.cirrus.com [198.61.65.196])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D3E3111AB;
        Thu, 27 Jul 2023 09:48:04 +0000 (UTC)
Message-ID: <42399566-2d25-e888-7226-05a86767b644@opensource.cirrus.com>
Date:   Thu, 27 Jul 2023 10:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: scan: Create platform device for CS35L56
To:     Hans de Goede <hdegoede@redhat.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <markgross@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <20230726112759.18814-1-rf@opensource.cirrus.com>
 <33cdbf63-8fe4-da7e-5d36-6e63fe303b24@redhat.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <33cdbf63-8fe4-da7e-5d36-6e63fe303b24@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _hjSqRdhx5niJqtXdtAQck9CO9J3Ke7j
X-Proofpoint-GUID: _hjSqRdhx5niJqtXdtAQck9CO9J3Ke7j
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/7/23 15:13, Hans de Goede wrote:
> Hi Richard,
> 
> On 7/26/23 13:27, Richard Fitzgerald wrote:
>> From: Simon Trimmer <simont@opensource.cirrus.com>
>>
>> The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
>> is used in multiples, and can be connected either to I2C or SPI.
>>
>> There will be multiple instances under the same Device() node. Add it
>> to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
>> driver.
>>
>> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I have 1 other serial-multi-instantiate.c patches in my fixes branch (see below) and since this just adds new hw-ids I think this can go upstream through my fixes branch too.
> 
> Rafael, do you agree with me taking this upstream as a 6.5 fix? And if yes may I have your ack for that ?
> 
> About that 1 patch, that adds a new IRQ type: IRQ_RESOURCE_AUTO and I wonder if this patch should not use that same new type right from the start:
> 
> https://git.kernel.org/pub/scm/linux/kernel/agit/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=676b7c5ecab36274442887ceadd6dee8248a244f
> 

Link doesn't work, but I think you mean:
https://lore.kernel.org/platform-driver-x86/b9f81a5b-0511-9950-5a20-9e6cbd92d085@redhat.com/T/#t

I'll send a V2 of this CS35L56 patch to use the new IRQ_RESOURCE_AUTO.
