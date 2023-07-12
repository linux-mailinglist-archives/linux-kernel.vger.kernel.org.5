Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB217514D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGLX4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjGLX4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:56:41 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EDA1BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:56:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VnEWYjT_1689206197;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnEWYjT_1689206197)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 07:56:37 +0800
Message-ID: <a76b6126-be35-cf24-752c-545168ce5174@linux.alibaba.com>
Date:   Thu, 13 Jul 2023 07:56:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] erofs: DEFLATE compression support
To:     Randy Dunlap <rdunlap@infradead.org>, linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230712233026.118706-1-hsiangkao@linux.alibaba.com>
 <20230712233347.122544-1-hsiangkao@linux.alibaba.com>
 <e3a637af-ed6f-cd18-9423-bdb34ae60f3b@infradead.org>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <e3a637af-ed6f-cd18-9423-bdb34ae60f3b@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 2023/7/13 07:46, Randy Dunlap wrote:
> Hi--
> 
> On 7/12/23 16:33, Gao Xiang wrote:
>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>> index f259d92c9720..d7b5327215f0 100644
>> --- a/fs/erofs/Kconfig
>> +++ b/fs/erofs/Kconfig
>> @@ -99,6 +99,21 @@ config EROFS_FS_ZIP_LZMA
>>   
>>   	  If unsure, say N.
>>   
>> +config EROFS_FS_ZIP_DEFLATE
>> +	bool "EROFS DEFLATE compressed data support"
>> +	depends on EROFS_FS_ZIP
>> +	select ZLIB_INFLATE
>> +	help
>> +	  Saying Y here includes support for reading EROFS file systems
>> +	  containing DEFLATE compressed data.  It gives better compression
>> +	  ratios than the default LZ4 format, whileas it costs more CPU
> 
> 	                                      while
> or	  although
> or	  but

Thanks for pointing out, let me fix in the next version!

Thanks,
Gao Xiang
