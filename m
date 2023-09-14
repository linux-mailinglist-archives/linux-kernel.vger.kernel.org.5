Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5447A088C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbjINPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjINPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:07:24 -0400
Received: from cmx-torrgo001.bell.net (mta-tor-005.bell.net [209.71.212.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D8B01AE;
        Thu, 14 Sep 2023 08:07:20 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.126.114.79]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64E885070227F671
X-CM-Envelope: MS4xfOdW6gMiowwnIsbJ4YmhvxBQINj7u2mFHK6iDAX8Ved/YOGMGRKR2Fu3eVp8yl39nb8mVNnxo5Os2bJjY794q33ZENShDlJBi1q7n9v7Ti9JpheEsrKx
 IbsTGCIM5AznYeIvoMPpps9728eIHyTUxoQFCP/IGc/RhZJClaZewKlI1e5EtBnx/mzvWMNv0jrioQSDJeOHJeF5JZsWugm8CQ9XCcBy2crLqt9q5jS7umzI
 B6eLLSL142srXECkWFpxIyEx9+dBZuJJSBH9Qr0NeEj5OXBpf7IZks8BVoEbQAZlFHkQZp6OolBvCcmdWar9NgW8ZQ7pjhU3QSGWvf5wZRmzGYECwokEcfA7
 1Slf//Mgw4fjaVxusxhiUl47DtQ/zYItmDADahaN4VfzoQduXx7+DVwTRUa/lMPqp2vZvBil4p08jQaVVVp9pvN3OFvBt50YKEVExomaSLkIdtF4S6k9nwky
 P4Q5XIwzi4/Pq9RG
X-CM-Analysis: v=2.4 cv=UM++oATy c=1 sm=1 tr=0 ts=6503219e
 a=qwLmA0wx3TwW38sY+xTbUA==:117 a=qwLmA0wx3TwW38sY+xTbUA==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=qBU8hJCfZqFirpWte1MA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (142.126.114.79) by cmx-torrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64E885070227F671; Thu, 14 Sep 2023 11:07:10 -0400
Message-ID: <ea24cb95-f129-8297-6779-995decdf7e2b@bell.net>
Date:   Thu, 14 Sep 2023 11:07:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Helge Deller <deller@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
 <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
 <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
 <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
 <040a0941-936b-87ab-aedd-5a933383b500@bell.net>
 <b919c7fd-babb-5557-dd8d-c2b8bb428d54@bell.net>
 <4fee8886-daa3-fb03-f9e7-89358fb5fc38@bell.net>
 <b9ceba24-345e-20dc-783b-3759a9819359@bell.net>
 <10887293-fa2e-83e1-9305-487905a8afd2@kernel.org>
 <3e4040cf-bb54-7652-72cc-0ad2d1288cb8@bell.net>
 <bed98fc9-fb84-4912-6c73-5b7db575c375@kernel.org>
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <bed98fc9-fb84-4912-6c73-5b7db575c375@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-13 10:24 p.m., Damien Le Moal wrote:
> On 9/14/23 09:29, John David Anglin wrote:
>> I think the issue is with the root ST373207LW drive.  The console output indicates that the
>> ROOT drive doesn't exist when the boot fails.
>>
>> Your change only appeared to affect actual SCSI drives.  That's why I tried disabling CDL.
>>> Could you send a full dmesg output for a clean boot and for a failed one so that
>>> I can compare ?
>> I'll try to get this together tomorrow.
> Please try the attached patch. That should address the issue with your drive.
Mainline and v6.5.3 both booted successfully with the attached patch.

Thanks,
Dave

-- 
John David Anglin  dave.anglin@bell.net

