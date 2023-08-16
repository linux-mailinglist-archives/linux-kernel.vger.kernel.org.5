Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA877D8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbjHPDUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjHPDUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:20:40 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5052129;
        Tue, 15 Aug 2023 20:20:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RQYL73CScz4f4XWp;
        Wed, 16 Aug 2023 11:20:31 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAH5KaAQNxkadhGAw--.61247S3;
        Wed, 16 Aug 2023 11:20:34 +0800 (CST)
Subject: Re: [PATCH v3 2/2] hexdump: add a new dump prefix DUMP_PREFIX_CUSTOM
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
References: <20230811074922.1388-1-thunder.leizhen@huaweicloud.com>
 <20230811074922.1388-3-thunder.leizhen@huaweicloud.com>
 <ZNuMGyJ2x21RpVyR@alley>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <167a4aee-7a9d-a024-7594-97b84146196c@huaweicloud.com>
Date:   Wed, 16 Aug 2023 11:20:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZNuMGyJ2x21RpVyR@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAH5KaAQNxkadhGAw--.61247S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4rKrW5Aw4DWrWUtry8Grg_yoW7uw13pF
        9xGFy5KFZ7Xw1xWw1xXFWUGr1Yk3yDCFy8Kryqyw18Cay2gF9xJw1kGFW3CFy5CryFv3Zr
        Jr17trn0gr15C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/15 22:30, Petr Mladek wrote:
> Added Kees and hardening mailing list into Cc.
> 
> On Fri 2023-08-11 15:49:21, thunder.leizhen@huaweicloud.com wrote:
>> From: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Currently, function print_hex_dump() supports three dump prefixes:
>> DUMP_PREFIX_NONE, DUMP_PREFIX_ADDRESS and DUMP_PREFIX_OFFSET. But for some
>> usage scenarios, they don't work perfectly. For example, dump the content
>> of one task's stack. In order to quickly identify a stack frame,
>> DUMP_PREFIX_ADDRESS is preferred. But without boot option no_hash_pointers
>> , DUMP_PREFIX_ADDRESS just print the 32-bit hash value.
>>
>> dump memory at sp=ffff800080903aa0:
>> 00000000a00a1d32: 80903ac0 ffff8000 8feeae24 ffffc356
>> 000000007993ef27: 9811c000 ffff0d98 8ad2e500 ffff0d98
>> 00000000b1a0b2de: 80903b30 ffff8000 8ff3a618 ffffc356
>> ... ...
>> 00000000a7a9048b: 9810b3c0 ffff0d98 00000000 00000000
>> 0000000011cda415: 80903cb0 ffff8000 00000000 00000000
>> 000000002dbdf9cd: 981f8400 ffff0d98 00000001 00000000
>>
>> On the other hand, printing multiple 64-bit addresses is redundant when
>> the 'sp' value is already printed. Generally, we do not dump more than
>> 64 KiB memory. It is sufficient to print only the lower 16 bits of the
>> address.
>>
>> dump memory at sp=ffff800080883a90:
>> 3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
>> 3aa0: 5833f000 ffff3580 00000001 00000000
>> 3ab0: 40299840 ffff3580 590dfa00 ffff3580
>> 3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
>> 3ad0: 40877180 ffff3580 590dfa00 ffff3580
>> 3ae0: 4090f600 ffff3580 80883cb0 ffff8000
>> 3af0: 00000010 00000000 00000000 00000000
>> 3b00: 4090f700 ffff3580 00000001 00000000
>>
>> Let's add DUMP_PREFIX_CUSTOM, allows users to make some adjustments to
>> their needs.
>>
>> For example:
>> pr_info("dump memory at sp=%px:\n", sp);
>> print_hex_dump(KERN_INFO, "%s%16hx: %s\n",
>>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
>> print_hex_dump(KERN_INFO, "%s%16x: %s\n",
>>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
>> print_hex_dump(KERN_INFO, "%s%px: %s\n",
>>                DUMP_PREFIX_CUSTOM, 16, 1, sp, 16, false);
> 
> IMHO, this is pretty bad interface.
> 
>   + From the user POV:
> 
>     It is far from clear what values will be passed for the given
>     printf format. It can be docummented but...
> 
> 
>   + From the security POV:
> 
>     The compiler could not check if the printk() parameters
>     match the format. I mean if the number of types of
>     the parameters are correct.

Yes, it has these problems. So, back to v2, how about add DUMP_PREFIX_ADDRESS_LOW16?
Or named DUMP_PREFIX_ADDR16 or others. Or change the format of DUMP_PREFIX_ADDRESS
from "%p" to "%px"，Or add DUMP_PREFIX_RAWADDR. Or keep the status quo.

Also, do you have any comments on patch 1/2?

> 
> 
> Best Regards,
> Petr
> 
>> dump memory at sp=ffff80008091baa0:
>>             baa0: c0 ba 91 80 00 80 ff ff d4 38 16 ce fc a7 ff ff
>>         8091baa0: c0 ba 91 80 00 80 ff ff d4 38 16 ce fc a7 ff ff
>> ffff80008091baa0: c0 ba 91 80 00 80 ff ff d4 38 16 ce fc a7 ff ff
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  include/linux/printk.h |  3 ++-
>>  lib/hexdump.c          | 16 ++++++++++++++++
>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index 8ef499ab3c1ed2e..23779dcc4836414 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -704,7 +704,8 @@ extern const struct file_operations kmsg_fops;
>>  enum {
>>  	DUMP_PREFIX_NONE,
>>  	DUMP_PREFIX_ADDRESS,
>> -	DUMP_PREFIX_OFFSET
>> +	DUMP_PREFIX_OFFSET,
>> +	DUMP_PREFIX_CUSTOM
>>  };
>>  extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
>>  			      int groupsize, char *linebuf, size_t linebuflen,
>> diff --git a/lib/hexdump.c b/lib/hexdump.c
>> index 1064706d57c15ed..fa4a44543a946b8 100644
>> --- a/lib/hexdump.c
>> +++ b/lib/hexdump.c
>> @@ -232,6 +232,11 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
>>   * @level: kernel log level (e.g. KERN_DEBUG)
>>   * @prefix_str: string to prefix each line with;
>>   *  caller supplies trailing spaces for alignment if desired
>> + *  OR
>> + *  the custom format string of DUMP_PREFIX_CUSTOM;
>> + *  Corresponding to three parameters in fixed order:
>> + *  <string: level> <pointer: address> <string: converted data>
>> + *  For example: "%s%04hx: %s\n", "%s%.8x: %s\n", "%s%px: %s\n"
>>   * @prefix_type: controls whether prefix of an offset, address, or none
>>   *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
>>   * @rowsize: number of bytes to print per line; must be 16 or 32
>> @@ -257,6 +262,14 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
>>   * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
>>   * Example output using %DUMP_PREFIX_ADDRESS and 4-byte mode:
>>   * ffffffff88089af0: 73727170 77767574 7b7a7978 7f7e7d7c  pqrstuvwxyz{|}~.
>> + *
>> + * E.g.:
>> + *   print_hex_dump(KERN_DEBUG, "%s%04hx: %s\n", DUMP_PREFIX_CUSTOM,
>> + *		    16, 1, frame->data, frame->len, false);
>> + *   %04hx --> Only the lower 16 bits of the address are printed.
>> + *
>> + * Example output using %DUMP_PREFIX_CUSTOM and 1-byte mode:
>> + * 3aa0: c0 3a 8d 80 00 80 ff ff d4 38 16 1d 94 a6 ff ff
>>   */
>>  void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>>  		    int rowsize, int groupsize,
>> @@ -292,6 +305,9 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
>>  			}
>>  			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
>>  			break;
>> +		case DUMP_PREFIX_CUSTOM:
>> +			printk(prefix_str, level, ptr + i, linebuf);
>> +			break;
>>  		default:
>>  			printk("%s%s%s\n", level, prefix_str, linebuf);
>>  			break;
>> -- 
>> 2.34.1
> .
> 

-- 
Regards,
  Zhen Lei

