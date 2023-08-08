Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51077735BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjHHBKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjHHBKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:10:13 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E01989
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:10:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RKZqL4rt6z4f3jq8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:10:06 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgA3xqjtldFkmv3CAA--.2463S3;
        Tue, 08 Aug 2023 09:10:07 +0800 (CST)
Subject: Re: [PATCH 1/2] hexdump: minimize the output width of the offset
To:     Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
 <20230805072116.1260-2-thunder.leizhen@huaweicloud.com>
 <41713c95-51a8-8e2a-9c70-dab10dacf26d@infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <8b7a579e-473d-ea90-58e0-e2f69f9bd002@huaweicloud.com>
Date:   Tue, 8 Aug 2023 09:10:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <41713c95-51a8-8e2a-9c70-dab10dacf26d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgA3xqjtldFkmv3CAA--.2463S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxtFyxZF4fGF4fZr48Crg_yoW5Cr17pr
        98tay5KFWkJryxKr12qr10gr1Yyr17C3W0kFWqka4qva4DWFn3trykKrW3tFy5Gr1jvrsx
        try7tw1F9F17G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/8 6:37, Randy Dunlap wrote:
> Hi--
> 
> On 8/5/23 00:21, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> The offset of case DUMP_PREFIX_OFFSET always starts from 0. Currently,
>> the output width is fixed to 8. But we usually dump only tens or hundreds
>> of bytes, occasionally thousands of bytes. Therefore, the output offset
>> value always has a number of leading zeros, which increases the number of
>> bytes printed and reduces readability. Let's minimize the output width of
>> the offset based on the number of significant bits of its maximum value.
>>
>> Before:
>> dump_size=36:
>> 00000000: c0 ba 8c 80 00 80 ff ff 6c 93 ee 2f ee bf ff ff
>> 00000010: 00 50 1e 98 ff 27 ff ff 01 00 00 00 00 00 00 00
>> 00000020: 80 ca 2f 98
>>
>> After:
>> dump_size=8:
>> 0: c0 ba 89 80 00 80 ff ff
>>
>> dump_size=36:
>> 00: c0 3a 91 80 00 80 ff ff 6c 93 ae 76 30 ce ff ff
>> 10: 00 60 cd 60 7d 4e ff ff 01 00 00 00 00 00 00 00
>> 20: 40 9e 29 40
>>
>> dump_size=300:
>> 000: c0 ba 8d 80 00 80 ff ff 6c 93 ce d4 78 a7 ff ff
>> 010: 00 00 16 18 0c 40 ff ff 01 00 00 00 00 00 00 00
>> 020: 01 00 00 00 00 00 00 00 e8 bc 8d 80 00 80 ff ff
>> ... ...
>> 110: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 120: 00 08 12 01 0c 40 ff ff 00 00 01 00
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  lib/hexdump.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/hexdump.c b/lib/hexdump.c
>> index 06833d404398d74..86cb4cc3eec485a 100644
>> --- a/lib/hexdump.c
>> +++ b/lib/hexdump.c
>> @@ -263,12 +263,21 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>>  		    const void *buf, size_t len, bool ascii)
>>  {
>>  	const u8 *ptr = buf;
>> -	int i, linelen, remaining = len;
>> +	int i, linelen, width = 0, remaining = len;
>>  	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
>>  
>>  	if (rowsize != 16 && rowsize != 32)
>>  		rowsize = 16;
>>  
>> +	if (prefix_type == DUMP_PREFIX_OFFSET) {
>> +		unsigned long tmp = len - 1;	/* offset start from 0, so minus 1 */
>> +
>> +		do {
>> +			width++;
>> +			tmp >>= 4;
>> +		} while (tmp);
>> +	}
>> +
> 
> You could put all of that ^^^ in the case DUMP_PREFIX_OFFSET below.

for (i = 0; i < len; i += rowsize) {

"case DUMP_PREFIX_OFFSET" is in the loop, and moving the code above
to the case DUMP_PREFIX_OFFSET will be calculate multiple times. But
following your prompt, I thought again, I can control it with the
local variable width. I will post v2 right away.

> Otherwise LGTM.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.
> 
>>  	for (i = 0; i < len; i += rowsize) {
>>  		linelen = min(remaining, rowsize);
>>  		remaining -= rowsize;
>> @@ -282,7 +291,7 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>>  			       level, prefix_str, ptr + i, linebuf);
>>  			break;
>>  		case DUMP_PREFIX_OFFSET:
>> -			printk("%s%s%.8x: %s\n", level, prefix_str, i, linebuf);
>> +			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
>>  			break;
>>  		default:
>>  			printk("%s%s%s\n", level, prefix_str, linebuf);
> 

-- 
Regards,
  Zhen Lei

