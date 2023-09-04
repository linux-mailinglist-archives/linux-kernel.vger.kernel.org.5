Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC437915C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbjIDKjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjIDKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:39:50 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70161B5;
        Mon,  4 Sep 2023 03:39:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrJdE4N_1693823980;
Received: from 30.240.117.141(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrJdE4N_1693823980)
          by smtp.aliyun-inc.com;
          Mon, 04 Sep 2023 18:39:42 +0800
Message-ID: <e8dbdc1e-1c58-4aac-9f34-10bd55ab5fe7@linux.alibaba.com>
Date:   Mon, 4 Sep 2023 18:39:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
To:     "Luck, Tony" <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
 <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
 <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
 <20230830221814.GB30121@willie-the-truck>
 <d1c8c0fa-815f-6804-e4e5-89a5259e4bb1@linux.alibaba.com>
 <SJ1PR11MB6083A4F9312C34F69DBA8EEDFCE5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083A4F9312C34F69DBA8EEDFCE5A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/1 00:56, Luck, Tony wrote:
>> + @Tony for ERST
>> I found that after /dev/mcelog driver deprecated, both x86 and ARM64 platform does not
>> support to collect MCE record of previous boot in persistent storage via APEI ERST.
>> I propose to add a mechanism to do it for rasdaemon. Do you have any suggestion?
> 
> APEI ERST stored records should be available in /sys/fs/pstore after the system reboots.
> 
> Can rasdaemon collect them from there?

I am afraid not yet. I will give it a shot and try to send a patch set.

> 
> -Tony

Thank you.

Best Regards,
Shuai
