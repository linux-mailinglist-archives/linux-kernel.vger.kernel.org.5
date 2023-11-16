Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3037EE503
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjKPQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKPQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:15:19 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE693D50
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1700151312; bh=nszHQM2D01crUxQ/pqUr37Hl4TAA5ocLSCr1LbLEbbE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cVrV5NIkYja+DMsdvgDcOs/VTn4kZtPQ2pOUuOc5qdHRKsdRBZLcs0c4S4EGlYxu1
         8vQpljer1Nqp5GEn2+UIidTpwzZcx1x3UJVAp0esfbWoGfFS8UhvZAgK3QmfNwRqPI
         gKoM7DnkwP5i7Ut5t+qRr2H36pp6QftcCKHPMC+Q=
Received: from [IPV6:240e:388:8d26:bf00:1bbb:841f:9d6a:e85e] (unknown [IPv6:240e:388:8d26:bf00:1bbb:841f:9d6a:e85e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 8BF0060123;
        Fri, 17 Nov 2023 00:15:12 +0800 (CST)
Message-ID: <696b7c76-6672-4c33-b729-992ccbcf786f@xen0n.name>
Date:   Fri, 17 Nov 2023 00:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Implement stable timer shutdown interface
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231114114656.1003841-1-maobibo@loongson.cn>
 <21c772c3-b1ad-49c4-b6ca-204cb65042de@xen0n.name>
 <762523c4-5452-bfad-e5dc-f3bca035fb69@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <762523c4-5452-bfad-e5dc-f3bca035fb69@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 16:21, maobibo wrote:
>>> arch_cpu_idle_dead is called. Timer interrupt for this processor should
>>> be disabled, else there will be timer interrupt for the dead cpu. Also
>>> this prevents vcpu to schedule out during halt-polling flow when system
>>> is running in vm mode, since there is pending timer interrupt.
>>
>> The logical relationship is a bit unclear, is my paraphrasing correct 
>> in your opinion?
>>
>> "Timer interrupt for this processor should be disabled, else a 
>> pending timer interrupt will prevent the vCPU from scheduling out 
>> during the halt-polling flow when system is running in VM mode"
>>
>> (I don't immediately know what a "schedule out" is. Is that a 
>> translation artifact or some KVM jargon?)
> how about "prevent the vCPU from giving up scheduling"?
That's very easy to understand, so no problem and thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

