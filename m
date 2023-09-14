Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229137A0ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjINUMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjINUMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:12:52 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BA026BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:12:47 -0700 (PDT)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTP
        id gZm7qB8BREoVsgshjq8REV; Thu, 14 Sep 2023 20:12:47 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id gshiq7b0K79vMgshiqYCkU; Thu, 14 Sep 2023 20:12:46 +0000
X-Authority-Analysis: v=2.4 cv=W7Ar6Dak c=1 sm=1 tr=0 ts=6503693e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10
 a=pywrRr8RVoJqelg4EO4A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zWVonpaXdZXHPWvZADwVu4cRo39wCBa6QoaBz1rxDyg=; b=WL/9gyZZ2krLnh7BcBIDVpIcAH
        iyJRAFnQzZE2sG7lnfqsAQ/+Fs1M9vxksuTTzxDgWnvMrMRmZERsu/xMDQ+TDqbC/hKZIUl7Pop2r
        9cqO4Bow9cbk8OdW/MVt6B39GK1Vs5STsIZ2Dsh3smnuy/ivj2i13e+ZIURuV+LvRsgDBOT1EcnwU
        xCZAV/pamPJw/JIHmx90193Y4NbVn1Y2DNtO78QfhKoQqMPA110raaJck5o/5lX+g/xYSmzixtu/c
        3JPGsC2KtFV24Cf2dExmLjB+8JIGqgKr2RPZyCQFO3NzujrPTfnV0YXFfWyfqWl2hpab/4kCxjtZ8
        2mv72oDw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48968 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qgshh-0037CU-1w;
        Thu, 14 Sep 2023 15:12:45 -0500
Message-ID: <42d67413-f11d-f626-ee51-a6e6a74c0651@embeddedor.com>
Date:   Thu, 14 Sep 2023 14:13:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Sep 12 (bcachefs)
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <20230912152645.0868a96a@canb.auug.org.au>
 <202309131803.6A3C1D05A@keescook>
 <20230914193807.ozcmylp6n6dsqkbi@moria.home.lan>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230914193807.ozcmylp6n6dsqkbi@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qgshh-0037CU-1w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:48968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLOEk6z6KywMwodql7oiaadbALycjr5U2kT53JrODeVtXWneZLQJJCYf8XS8VEA/Vr8jbpGtQiv9U2qZQsLtDicAin+qB+qgxc17UH9HbyUGziqyMKkZ
 QgNkaEBUgJaMeeUwMMDyBXRvTGBI5sxxpfqjdcH3+iYqJohIDK3j3O1xveKakK+svCkDzCPNyYf6ePDy0DOjGJz/LFaijtsCMTPB7YN25LYvQT0Ey85xpDmr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 13:38, Kent Overstreet wrote:
> On Wed, Sep 13, 2023 at 06:17:00PM -0700, Kees Cook wrote:
>> On Tue, Sep 12, 2023 at 03:26:45PM +1000, Stephen Rothwell wrote:
>>> New tree: bcachefs
>>
>> Thanks for going through and fixing all the fake flexible array members.
>> It looks much nicer. :)
>>
>> I have some questions about the remaining "markers", for example:
>>
>> $ git grep -A8 '\bkey_start\b' -- fs/bcachefs
>> fs/bcachefs/bcachefs_format.h:  __u8            key_start[0];
>> ...
>> fs/bcachefs/bcachefs_format.h-  __u8            pad[sizeof(struct bkey) - 3];
>> --
>> fs/bcachefs/bkey.c:     u8 *l = k->key_start;
>>
>> Why isn't this just:
>>
>> 			u8 *l = k->pad
>>
>> and you can drop the marker?
> 
> In this case, it's documentation. &k->pad tells us nothing; why is pad
> significant? k->key_start documents the intent better.
> 
>> And some seem entirely unused, like all of "struct bch_reflink_v".
> 
> No, those aren't unused :)
> 
> bcachefs does the "list of variable size items" a lot - see vstructs.h.
> start[] is the type of the item being stored, _data is what we use for
> pointer arithmetic - because we always store sizes in units of u64s, for
> alignment.
> 
>>
>> And some are going to fail at runtime, since they're still zero-sized
>> and being used as an actual array:
>>
>> struct bch_sb_field_journal_seq_blacklist {
>>          struct bch_sb_field     field;
>>
>>          struct journal_seq_blacklist_entry start[0];
>>          __u64                   _data[];
>> };
>> ...
>>                  memmove(&bl->start[i],
>>                          &bl->start[i + 1],
>>                          sizeof(bl->start[0]) * (nr - i));
>>
>> It looks like you just want a type union for the flexible array.
>> This can be done like this:
>>
>> struct bch_sb_field_journal_seq_blacklist {
>>          struct bch_sb_field     field;
>>
>> 	union {
>> 		DECLARE_FLEX_ARRAY(struct journal_seq_blacklist_entry, start);
>> 		DECLARE_FLEX_ARRAY(__u64, _data);
>> 	};
>> };
> 
> Eesh, why though?
> 
> Honestly, I'm not a fan of the change to get rid of zero size arrays,
> this seems to be adding a whole lot of macro layering and indirection
> for nothing.
> 
> The only thing a zero size array could possibly be is a flexible array
> member or a marker, why couldn't we have just kept treating zero size
> arrays like flexible array members?

Because zero-length arrays, when used as fake flexible arrays, make
things like -Warray-bounds (we've been trying to enable this compiler
option, globally) trip; among other things like being prone to result in
undefined behavior bugs when people introduce new members that make the
array end up in the middle of its containing structure.

With C99 flexible-array members, the compiler emits a warning when the
arrays are not at the end of the structure.

The DECLARE_FLEX_ARRAY() (in a union) helper allows for multiple C99
flexible-array members together at the end of a struct.

--
Gustavo
