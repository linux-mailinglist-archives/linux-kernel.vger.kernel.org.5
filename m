Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7497C955C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjJNQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:26:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D04AB
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=In/qR0xPHX0R3ydjLmk4c6FPRcFQxtnno1hT+OX9s8w=; b=B3pZWy6FGwF8vOYjYih4ciOB1b
        DTC+ShtekHkbehPWeUg6yaF32FZUkscZ/758qpw/8IpN0dPQb0/TVyET0hVH+Kz/oafjYSRRJ8fQ1
        mcd+W2lyhDfECt7A5Uz0g5/Bn/T548vPQSNCSpRKvD/2lliSOZoTVbOxWZ+pCZrsOJZaf6tnlsOQ7
        mHKbQrcc5LNsAADZs0sUzPxmybgdfJ80bCnvNY0zEvOhtJvmHzYfsB9REjo1ulp809MOwoyi1Rjqv
        AmInhnbsOXHhLVwb3xV2aVP/yRqs3pW6YrREHPNNcYxfyuD5/weR54F6ZWbyOtEXYeQMffMdFnHn+
        4BBzQOgg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qrhTE-005ZLx-3A;
        Sat, 14 Oct 2023 16:26:33 +0000
Message-ID: <7ce37af9-229f-445b-9505-10f5b0c60c89@infradead.org>
Date:   Sat, 14 Oct 2023 09:26:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
 <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
 <ZSq3iuuGy7zSl4sz@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZSq3iuuGy7zSl4sz@casper.infradead.org>
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



On 10/14/23 08:45, Matthew Wilcox wrote:
> On Sat, Oct 14, 2023 at 08:31:35AM -0700, Randy Dunlap wrote:
>>>  	/*
>>> -	 * The caller from rmap relay on disabled preemption becase they never
>>> +	 * The caller from rmap relay on disabled preemption because they never
>>>  	 * update their counter from in-interrupt context. For these two
>>
>> I don't know what that (partial) sentence is trying to say...
>> Maybe someone else does.
> 
> s/relay/rely/

Duh. Thanks.

So either:

+	 * The callers from rmap rely on disabled preemption because they never
or
+	 * The caller from rmap relies on disabled preemption because they never

but the entire paragraph still needs some care IMO.

-- 
~Randy
