Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE37FCE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376949AbjK2FkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2FkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:40:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1301998
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Pmk0+/LrT8ycjMNq0a8cSGnwxWFEDbzU3lsQse706OI=; b=RWYTHLa8sXVCfhSfDy1U/juJrq
        V2yQqWMiD7G/BGKwlMbQTuMlnweUse41jdIelzoND0p1CiE/b+ylZminicOMyBtOhC85tX16QRuml
        Ye8ELnIaVD70Ycw/725jApcyDGY1F6+tCKdx5MF1LINDq2QLleUvhl3wGPCo1zru7NFzZPwLyEHHp
        EeIYebULStINrgwL/vJFQszrzZbDxgzKS342FJP7DCvUmCrMkgRTes3NF+CZR3acN9zQrQbJaTgZV
        rCDpvdIL5KdPqtBjtCaY0THle1y9I6YbzM7GBgTJ+PIOtgdY63mPBG+ovmetXwP8SPeCa/tm1pphh
        EJhoOhaw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8DIz-0077Nv-1i;
        Wed, 29 Nov 2023 05:40:13 +0000
Message-ID: <5e000502-d400-420c-a9f8-40e202a95271@infradead.org>
Date:   Tue, 28 Nov 2023 21:40:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: kstrtox: fix typo in comment
Content-Language: en-US
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <ZWWkeVTvDBQDA_SF@monster.localdomain>
 <d9ac4b6c-e473-4c00-b016-a9cebdb59325@infradead.org>
 <20231129054834.2ffbe481@posteo.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231129054834.2ffbe481@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 20:48, Wilken Gottwalt wrote:
> On Tue, 28 Nov 2023 08:26:03 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 11/28/23 00:27, Wilken Gottwalt wrote:
>>> Delete one of the double f's in "iff".
>>>
>>> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
>>
>> Nope, see:
>>   https://en.wikipedia.org/wiki/If_and_only_if
> 
> Oh, interesting. Never thought of this. Though, now I wonder: How often do such
> "fixes" happen?

I think that I have seen 2 other patches for "iff", but I probably have missed some.



>>> ---
>>>  lib/kstrtox.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
>>> index d586e6af5e5a..b0a9fdce15b3 100644
>>> --- a/lib/kstrtox.c
>>> +++ b/lib/kstrtox.c
>>> @@ -340,7 +340,7 @@ EXPORT_SYMBOL(kstrtos8);
>>>   * @s: input string
>>>   * @res: result
>>>   *
>>> - * This routine returns 0 iff the first character is one of 'YyTt1NnFf0', or
>>> + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
>>>   * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
>>>   * pointed to by res is updated upon finding a match.
>>>   */
>>
> 

-- 
~Randy
