Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB14778FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjHKM6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjHKM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:58:10 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EDE26A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691758685;
        bh=HPUvEzcNloXxW0EXzgIMCogy7LI23HnLARfpislCw8U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=coTGeQcj1udphA98Uk7bffA6b/6hFmBUEQcsUXYL/We56lT/qL4A/ZTAPksIXheii
         9/9XhOUUfAXv/vg+QAV2jvSszZZ71lP1n4pynBtMVO9MRFm1KrnNKfhMxIUys6BjBw
         ZXYGgG+n5ZO7pPsAwAd4PGWD26jLE9fYMJlXVIHU=
Received: from [172.25.21.182] ([175.152.51.41])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id E7BB8095; Fri, 11 Aug 2023 20:57:59 +0800
X-QQ-mid: xmsmtpt1691758679trl8xio5e
Message-ID: <tencent_3C08D6938E6BD58AACCF018E0A7F3B848807@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNouiCZ5ZwiItY+Fiy4VqVTVZC5dwBQK/A5YrJnzPHmE4YcF4+hrM
         Bh86DGVSoYHPZS9mqfmHrlyM3i9S4Qkyxz/yX+FsXU3ioalr92RoRI+D12T9vaAUm/ZHTiV+2jye
         C+imFIwFjS3iWovhIVo2AOy1+K1NFBUC1xkzNsTQ61f3q/lv0Diq4KeMznR2lFv5+pB1oFbEucgY
         8q/t+7WX6IvsqIuwHaSw3n0yz6OFFEPc44jwLe7THCGdc/jvwjmTGR0d0HXJcVq+az+UlXPn/jgI
         SLqi3ZGb/9NFtd1TWvd9lBfz6Qa53WsPPUb7pxwzmnLHv59Phsr+3AYVCWKVb35ZV6FCGKvKFjsM
         EWKCq7ciP/vGkW+NmqVkLaduR5/smXKwDZJ4FLOL+PcS5z/CAIJd/UBwrtZshKGisBA8EAzcu9nu
         CzawduYDkD7W2YRoo/uTSMk9NTmcjRhaqOxsB3IUi/WWCy5jE9w2fs5yFO8Sg6OhVJai8ZxrYFHp
         mHNKtBTPRX0kdYjsYhUXARxWurVcqWLCPnu3Tsg7GDTzXFNt7oK6EnYPW4EDhHiUuepgxEWXe7f7
         vS8xw7KC6XopbptZ4qjtFWKrD3lf9aIOuBag6/7npEsKnZd9qVQXJZSdgnnzY7ZH+ZeKWRtVWDui
         UIwieatu06np2dVD+b6y/HeQlZB/pAxjg2DvSpTt2VLvIWGRkaZgVcGSCeecs9ihYVWDaJJXK/BG
         8oDhBVbHbNTUCg+ywQgh3gHpbU8j2axuwE0sEDfwREd2Gu8+8VDFdX2XIKNQFM1heEqiIwvkSmrh
         KiyzrmCB+pGqHA/SUNno4fLMrnKjZ+Ob1oG76STRSqqJd7YpvFcS86eVak1Mu3LqFOJz2vRQaJv6
         6XyO4VzW414FdxhAaOQrcAPYqjPIrYc4WWWkc5kYntybqcnGslJBqic4WQA8KEeTI8nQHfWE1DuG
         TRZDRX9isUIWuP6qzPc5QVRWlPCZEBE8lvgjAidAA=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
Subject: Re: [patch V3a 30/40] x86/cpu: Provide an AMD/HYGON specific topology
 parser
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.418143974@linutronix.de> <87il9xjk95.ffs@tglx>
From:   Pu Wen <pu_wen@foxmail.com>
X-OQ-MSGID: <f224c3c7-99e6-a717-0822-6bee79ff5423@foxmail.com>
Date:   Fri, 11 Aug 2023 20:58:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <87il9xjk95.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/3 3:51, Thomas Gleixner wrote:
> +	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
> +		if (tscan->c->x86 == 0x15)
> +			tscan->c->topo.cu_id = leaf.cuid;
> +
> +		cacheinfo_amd_init_llc_id(tscan->c, leaf.nodeid);
> +	} else {
> +		/*
> +		 * Package ID is ApicId[6..] on Hygon CPUs. See commit
> +		 * e0ceeae708ce for explanation. The topology info is
> +		 * screwed up: The package shift is always 6 and the node
> +		 * ID is bit [4:5]. Don't touch the latter without
> +		 * confirmation from the Hygon developers.
> +		 */
> +		topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6, tscan->dom_ncpus[TOPO_CORE_DOMAIN]);

Hygon updated CPUs will not always shift 6, and shift 6 is not good for 
running guests.
So suggest to modify like this:
     if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <= 
0x3)
         topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6, 
tscan->dom_ncpus[TOPO_CORE_DOMAIN]);

-- 
Regards,
Pu Wen

> +		cacheinfo_hygon_init_llc_id(tscan->c);
> +	}
> +	return true;
> +}
> +

