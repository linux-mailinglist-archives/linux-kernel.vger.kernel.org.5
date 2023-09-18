Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B497A5312
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjIRTZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:25:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FB109;
        Mon, 18 Sep 2023 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=41KJ6LcbdZqGjDW3rkDYYviXldx9YgEr4ngYT/Z6zj4=; b=MR38MTbqx/bZqQzh8zj3D6UTgu
        6NplLBKzC3IV7xy0h4F9CaKjb/a0rHAA+ydyKPTW5+JK5D4q4FIgXZVZKAw7dhHJFgy7W7HYYPU9n
        XUFGxSNzRxCLNhYPCMhLR86qCq9MrAKcgW2a/MGR0eyIk0JEHQVYXK+mtlq19knHg4zIp+J+0Oi+P
        OF05XKlx11z3cnKjGqIaczDWvGiGbeN/7rnzkcyLjpOhocpQRa11/Purm6i671xLRB8DePwyXKz0Z
        HzqqN/Ni4OecVEt5ws5fXxaf5hSKJmyVnR23A0RJ+f+JJuic1FgXmBaUdjMIAYLBKFEs2Io+dL7Ku
        r5OtemMw==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiJsQ-00GBra-05;
        Mon, 18 Sep 2023 19:25:46 +0000
Message-ID: <5baf9fcb-1c53-48b3-8742-ca3c98d82ebc@infradead.org>
Date:   Mon, 18 Sep 2023 12:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Sep 15 (drivers/mfd/cs42l43.o)
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20230915120127.1bc03420@canb.auug.org.au>
 <fb3f00ab-178c-45cf-ba39-baf61bb3f117@infradead.org>
 <20230918144033.GQ13143@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230918144033.GQ13143@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/23 07:40, Lee Jones wrote:
> On Fri, 15 Sep 2023, Randy Dunlap wrote:
> 
>>
>>
>> On 9/14/23 19:01, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20230914:
>>>
>>> The btrfs tree gained a conflist against the mm tree.
>>>
>>> The device-mapper tree gained a build failure so I used the version
>>> from next-20230914.
>>>
>>> The kspp tree lost its build failure.
>>>
>>> Non-merge commits (relative to Linus' tree): 5026
>>>  2501 files changed, 391711 insertions(+), 34318 deletions(-)
>>>
>>> ----------------------------------------------------------------------------
>>>
>>
>> on arm64:
>>
>> aarch64-linux-ld: drivers/mfd/cs42l43.o: in function `cs42l43_boot_work':
>> cs42l43.c:(.text+0x19d4): undefined reference to `devm_regmap_add_irq_chip'
>>
>> Using GCC 13.2.0 from kernel.org crosstools.
>>
>> Full randconfig file is attached.
> 
> Who is the intended consumer of this report?
> 

I Cc-ed the driver maintainers and the subsystem maintainer.
However, I missed Cc-ing the person who git blame identifies
for this patch. (added now)

> Are you planning on following up with a patch?

Sure, I will do that.

thanks.
-- 
~Randy
