Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4875D055
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGURGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGURGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:06:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB51210CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:06:03 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MtZlqv15ZztjnMtZlqN0fo; Fri, 21 Jul 2023 19:06:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689959161;
        bh=SofxeuaexXoVGK42MZB8nd198xjokjbrrVTRA9SKYtw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lOexLpZVe1t6hR6kg1Cur8dITSWx7YvByn1H9i2JqkPO6f/6TkvNWHYczWmTe2itl
         O1qUievB28yOYaowg0E52YBjiJo6kTkXrMHtunnpU/Ol4y5z06bp6yrhWaMI126EGS
         pjpI7sw7DiOY15XwZ3ddO971kzEmGpNi31DdkEmSCuTgwI9uvXBdYmcbktK+03ClqH
         zjDrcqmhmCFaWMoO+/8QtG61RWTsUFRhPybVAyqDT+9MCwWcUYxBS6XmlsV1/Ljo0t
         L3ZU7DNtLfFkX+hitNTfLkb29wjWcAM2yNYFJpiosRyK2/lFEW/85BPaAn9Jdokznd
         rxyEk0JPrpvkQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 19:06:01 +0200
X-ME-IP: 86.243.2.178
Message-ID: <4fcb0507-d483-e49c-be9e-389d96187fc5@wanadoo.fr>
Date:   Fri, 21 Jul 2023 19:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] lib/string_helpers: Use passed in GFP_ flags
To:     Andy Shevchenko <andy@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <df051844-0a73-4cf9-9719-a6001f1c9d5c@moroto.mountain>
 <ZLqfizx5Xi9fOF6z@smile.fi.intel.com>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZLqfizx5Xi9fOF6z@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/07/2023 à 17:08, Andy Shevchenko a écrit :
> On Fri, Jul 21, 2023 at 05:57:00PM +0300, Dan Carpenter wrote:
>> This patch doesn't affect runtime because all the callers pass GFP_KERNEL
>> as the allocation flags.  However, it should use the passed in "gfp" as
>> the allocation flags.
> 
> Please, Cc Kees Cook as he stepped in as a maintainer of this in particular.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Hi,
just for the records, see [1].
Another approach was proposed by Michal Hocko in [2].

CJ

[1]: 
https://lore.kernel.org/all/1ec96b6e4f2e35599931d7516c6938c4a8845bf0.1642337606.git.christophe.jaillet@wanadoo.fr/

[2]: https://lore.kernel.org/all/YeWOd2G69LyR3PVZ@dhcp22.suse.cz/

> 
>> Fixes: 0ee931c4e31a ("mm: treewide: remove GFP_TEMPORARY allocation flag")
>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>> ---
>>   lib/string_helpers.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
>> index d3b1dd718daf..be517c25737d 100644
>> --- a/lib/string_helpers.c
>> +++ b/lib/string_helpers.c
>> @@ -668,7 +668,7 @@ char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp)
>>   	char *buffer, *quoted;
>>   	int i, res;
>>   
>> -	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +	buffer = kmalloc(PAGE_SIZE, gfp);
>>   	if (!buffer)
>>   		return NULL;
>>   
>> @@ -704,7 +704,7 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
>>   		return kstrdup("<unknown>", gfp);
>>   
>>   	/* We add 11 spaces for ' (deleted)' to be appended */
>> -	temp = kmalloc(PATH_MAX + 11, GFP_KERNEL);
>> +	temp = kmalloc(PATH_MAX + 11, gfp);
>>   	if (!temp)
>>   		return kstrdup("<no_memory>", gfp);
>>   
>> -- 
>> 2.39.2
>>
> 

