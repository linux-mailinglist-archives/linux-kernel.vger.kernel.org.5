Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4463580BE62
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjLJXx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJXxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:53:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C7B3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 15:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OqOsAQlCUU3b1jlzmSKyf3jiSbRl+v1EWFrOILE3yBM=; b=kAsEooYQtHYNYZwolRcmL4jfNF
        DJotnHddX00NQRT9jglHJAlGidJl+1BtdOTOwc0puBReIwWFUeacs4czTBB9thxdbrPkZsg+r6e0D
        bz4UDJ85JdG8WFnsaZhqcD/wmjn00oyaAoTI7Yc6OMrkSftAaVlmdRw6UbIzQ8qRPD4/31ytzlOWW
        Wq6PmAx7S+XOv5aXd/epw0U2x9WTTuy1tAQAuc5aP1J66HAo2neB5al0RS4y7bbV2HJCpqCZK0dmZ
        O0f4I9lI1xIORrkzCjBM3wEJitzPswNDVeu/IYfUAQo6AtK3Rl1FMyWeJxsdl9meNcsF4MdhKzLj9
        mlg6usnw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rCTcV-003eOj-1A;
        Sun, 10 Dec 2023 23:53:59 +0000
Message-ID: <f4a56419-088f-42e7-bf50-4afbe7c8f571@infradead.org>
Date:   Sun, 10 Dec 2023 15:53:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: fix typos/spellos etc.
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
References: <20231210063839.29967-1-rdunlap@infradead.org>
 <ZXYp60O0qxvPmuHu@casper.infradead.org>
 <20231210145601.177b543ca2ed28b9551575ff@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231210145601.177b543ca2ed28b9551575ff@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/23 14:56, Andrew Morton wrote:
> On Sun, 10 Dec 2023 21:13:15 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Sat, Dec 09, 2023 at 10:38:39PM -0800, Randy Dunlap wrote:
>>> - * mas_topiary_node() - Dispose of a singe node
>>> + * mas_topiary_node() - Dispose of a single node
>>
>> That's all well and good, but how do we dispose of singed nodes now?
> 
> Lol, this is my all-time favorite typo!
> 
> 
> hp2:/usr/src/mm> git log | grep Singed-off-by | wc -l
> 59
> 
> (sounds painful)
> 
> hp2:/usr/src/linux-6.7-rc4> grep -ri singe .
> 

Current linux-next shows:

$ git grep -iw  singe
arch/x86/events/intel/pt.c:      * In case of singe-entry ToPA, always put the self-referencing END
arch/x86/kvm/vmx/vmx.c:  * evmcs in singe VM shares same assist page.
drivers/input/misc/yealink.c:           /* Combine up to <len> consecutive LCD bytes in a singe request
drivers/net/ethernet/brocade/bna/bfa_defs_status.h: * NOTE: The error msgs are auto generated from the comments. Only singe line
kernel/trace/trace_events_filter.c: * struct prog_entry - a singe entry in the filter program
lib/maple_tree.c: * mas_topiary_node() - Dispose of a singe node
lib/maple_tree.c:       /* New root needs a singe node */
sound/core/seq/seq_queue.c:/* enqueue a event to singe queue */
sound/pci/rme9652/hdspm.c:      /* Changing between Singe, Double and Quad speed is not

but there is also "unsinged", "assinged", & "singel" if the -w is omitted.

And somehow the two Chinese translations of submitting-patches.rst contain
Singed-off-by.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html
