Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259676581E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjG0P5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjG0P5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:57:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B39271D;
        Thu, 27 Jul 2023 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Ych+tVfaq8lURql01X7Pyu+gkkWYp8Vi3PZJRR09qUY=; b=qjPVXPywk2HnFAuareb1to1xic
        sbujuS7XKVnikNzWmjZEPKGOkz/OOcos3usvBhn+9zKpONhk9coWwNTJECxjSSVls4J3l4MiC2Gtk
        lGN0ijY+J8oNFISS4rMUgpO4YJ65Egwa/l20yFuuFMzVhKRZegCAKoKevzkkNVtRZKrdjs4bBt19W
        30xfDKQTWiGC2hlwTw55V+gdKWZV+TLqdr17ihVUIkbwG6WS7BwviqlcoDzxLAmD0ZjrHGNv8RWD5
        RUzTShzQHsVjCjXKz/0UalHpTmzFVbspbZcI/LDNr5TIJGBjZqIGM3BCj3NmAIKTD6wHWXw3MIVvS
        u04P5LSQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qP3Mu-00GDAO-12;
        Thu, 27 Jul 2023 15:57:36 +0000
Message-ID: <8ecb57fb-4560-bdfc-9e55-63e3b0937132@infradead.org>
Date:   Thu, 27 Jul 2023 08:57:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 27 (arch/s390/kernel/cert_store.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>
References: <20230727143346.079d4e5a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727143346.079d4e5a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 21:33, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230726:
> 

on s390:

gcc-13.1.0-nolibc/s390-linux/bin/s390-linux-ld: arch/s390/kernel/cert_store.o: in function `check_certificate_hash':
arch/s390/kernel/cert_store.c:267: undefined reference to `sha256'

so config CERT_STORE should select CRYPTO_SHA256 or CRYPTO_SHA256_S390 ?
or both?

-- 
~Randy
