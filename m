Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C9A7BF0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441858AbjJJC0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378796AbjJJC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:26:47 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6AF93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:26:46 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd6128352cso683111fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 19:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696904805; x=1697509605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6bZ4QRaLewauuynMhGijeUR1ZbN0za+0iHRlPIpluA=;
        b=PbYDA1r33CRH/QbaF1xn0hq91Rj6kwmpCx4m9clWsPg70adzjBjF5oXriAH0pcv5HG
         NbeHxJSTc7vyje+bve+oPqROFDaRXru5S4W5Xy+mq8jVTHffPKT46XlV+pTNCesGRoY7
         wDLln1x3JH/cdyieWrzPCvtjGkFcy0zRsGd8hejUlyWGXr2VvaaV+GV8dZfLlAHVE+Pz
         O7ZT1pxVZyyL3stlUfqdiOio74YD1i58EOMc0bFMb1mF8fJ8jOOAEa8umBuAtIhLgUKK
         FmOD4eXyITyilRgLZgqqnA2cpw7+aJM2ScOmhAaNTz+XqxqAnyZl1YyRnuh+y3irJUGl
         5mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696904805; x=1697509605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6bZ4QRaLewauuynMhGijeUR1ZbN0za+0iHRlPIpluA=;
        b=o2cz6dWQ9/Jf+wPZ/IhYBN2w8OzPHMvIYl2qW+ie6GmTAzBRyLmLZLw+8Yp4cZk5xC
         VeqDxuoTlHSU5Gzg1w0L3d01KGqZYgdMtbL6Dh81kl89wlAXPxHl5FUZ5/cbjg4+ewoQ
         xqZO9zhu47Cy4/EU6g2W5840WGV+WBDdQaCvNO0Nclbgr+WYPK+g7A2qEqVb77ibubao
         lRVLWekufTl024E9kQGpF4ujTwKYP+DhmBNmMJKwLSKI7OnrAfj5YhhxQxq07sAWE6gm
         QlVo/8yF7LeXSfTL0pKP4iqVlxZgRqoRURcPrhkVzP2EickOHW9pYPaUCkpZm+bGmNpp
         jvdw==
X-Gm-Message-State: AOJu0Yy3BDLtwwpBTPtKBq7i6X2t2YdZ7ZLHorKOXfxWsMb6T1bH+lP7
        arZmr1IoQjw8U9cCNOtr5Q4cfg==
X-Google-Smtp-Source: AGHT+IFNMfNUnQAw7Ukgw85jFGTqS0jfqdmMiuCZUaFcEa86nIOtKLHkoMXr8LRVeXlaGvzRXU8H/A==
X-Received: by 2002:a05:6870:561e:b0:1d5:53c0:c1fe with SMTP id m30-20020a056870561e00b001d553c0c1femr17976060oao.3.1696904805328;
        Mon, 09 Oct 2023 19:26:45 -0700 (PDT)
Received: from [10.84.155.153] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id fe1-20020a056a002f0100b00690c52267easm7041036pfb.40.2023.10.09.19.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 19:26:44 -0700 (PDT)
Message-ID: <822387b7-4895-4e64-5806-0f56b5d6c447@bytedance.com>
Date:   Tue, 10 Oct 2023 10:26:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: add printf attribute to shrinker_debugfs_name_alloc
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lucy Mielke <lucymielke@icloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <ZSBue-3kM6gI6jCr@mainframe>
 <20231009175006.326e61e6c0e46e6ce78699ff@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20231009175006.326e61e6c0e46e6ce78699ff@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/10/10 08:50, Andrew Morton wrote:
> On Fri, 6 Oct 2023 22:30:51 +0200 Lucy Mielke <lucymielke@icloud.com> wrote:
> 
>> This fixes a compiler warning when compiling an allyesconfig with W=1:
>>
>> mm/internal.h:1235:9: error: function might be a candidate for ‘gnu_printf’
>> format attribute [-Werror=suggest-attribute=format]
> 
> Thanks.  I added
> 
> Fixes: c42d50aefd17 ("mm: shrinker: add infrastructure for dynamically allocating shrinker")
> 
> to this.

Thanks.

> 
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1229,8 +1229,8 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
>>   			  int priority);
>>   
>>   #ifdef CONFIG_SHRINKER_DEBUG
>> -static inline int shrinker_debugfs_name_alloc(struct shrinker *shrinker,
>> -					      const char *fmt, va_list ap)
>> +static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
>> +			struct shrinker *shrinker, const char *fmt, va_list ap)
>>   {
>>   	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);

And there is also a warning introduced by c42d50aefd17:

mm/shrinker.c: In function 'shrinker_alloc':
mm/shrinker.c:688:2: error: function 'shrinker_alloc' might be a 
candidate for 'gnu_printf' format attribute 
[-Werror=suggest-attribute=format]
   688 |  err = shrinker_debugfs_name_alloc(shrinker, fmt, ap);
       |  ^~~

This also needs to be fixed:

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index e4f93120e0ab..1a00be90d93a 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -131,6 +131,7 @@ struct shrinker {
   */
  #define SHRINKER_NONSLAB       BIT(4)

+__printf(2, 3)
  struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
  void shrinker_register(struct shrinker *shrinker);
  void shrinker_free(struct shrinker *shrinker);

Other than that, LGTM.

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks,
Qi

>>   
>> -- 
>> 2.42.0
