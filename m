Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEE7623F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjGYUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjGYUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:51:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F04B6;
        Tue, 25 Jul 2023 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BI6vld8daiZZqGCYXywTiEB06qS0pOcYQzPLq+kIgpA=; b=kBoM0QDDYWvRihqO9OYZiObhMj
        GlyRzTCZ7/WdvW06YOS6WhtEsgXu4P1dKW10wb/QbeKXBO9YvNSYtgD9VbSTzkwB612KtZK3+NKZL
        PUCberLDUcsiNFgFwoVPx1l3HnofLB9hYRk0dGE1wJYC/WBqIRrlZGzJxeCWlpE/oM/6a8jfZLd2g
        A20JUg5vvH4JUfv17i+QZRPSFeyFT74AQc8YT84WpVzZ3L4JbMNVTsJtZRXTSqPKDs3fi93vJfSuq
        p0PQYB8/Rg0lTnL28cf9yteCsl9N6+X6L1vjKxXoTcp+pM4nbyjbr8AEp1iNmusW8JYUFcNJaqS+G
        ryDERQsA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOP0M-008Te2-2y;
        Tue, 25 Jul 2023 20:51:40 +0000
Message-ID: <10fbf60c-f7fe-d2ca-3d16-488453a88889@infradead.org>
Date:   Tue, 25 Jul 2023 13:51:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Documentation: devices.txt: reconcile serial/ucc_uart
 minor numers
Content-Language: en-US
To:     Timur Tabi <timur@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230724063341.28198-1-rdunlap@infradead.org>
 <CAOZdJXVuvVNzbyTLSiqRoSNdU0aprHoxozZzBahFUghqLvL2kw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOZdJXVuvVNzbyTLSiqRoSNdU0aprHoxozZzBahFUghqLvL2kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 13:38, Timur Tabi wrote:
> On Mon, Jul 24, 2023 at 1:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Reconcile devices.txt with serial/ucc_uart.c regarding device number
>> assignments. ucc_uart.c supports 4 ports and uses minor devnums
>> 46-49, so update devices.txt with that info.
>> Then update ucc_uart.c's reference to the location of the devices.txt
>> list in the kernel source tree.
>>
>> Fixes: d7584ed2b994 ("[POWERPC] qe-uart: add support for Freescale QUICCEngine UART")
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Timur Tabi <timur@kernel.org>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: linux-serial@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
> 
> Acked-by: Timur Tabi <timur@kernel.org>
> 
> One thing does concern me.  The UCC UART driver piggy-backs on the CPM
> driver's layout (see cpm_uart.h), but apparently CPM UART supports 6
> devices, not four:
> 
> #define UART_NR        fs_uart_nr
> 
> where fs_uart_nr is defined in enum fs_uart_id.
> 
> Unfortunately, it's been so long since I've touched this code, I'm not
> sure whether this means anything.

If CPM UART code ever worked with > 4 ports, it probably just used minor devnums
that were not allocated to it.

Also, it looks like the CPU UART part of Documentation/admin-guide/devices.txt
needs to be updated:

		 46 = /dev/cucpm0		Callout device for ttyCPM0
		    ...
		 49 = /dev/cucpm5		Callout device for ttyCPM5

The driver must use some tricks to get 6 ports into 4 devnums. :)


-- 
~Randy
