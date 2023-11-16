Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB77EE1B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbjKPNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbjKPNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:40:37 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C284B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:40:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 028C62B003FD;
        Thu, 16 Nov 2023 08:40:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 16 Nov 2023 08:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1700142028; x=1700149228; bh=bG
        IxYXyIqpwVy5KNp0/Neu8NcBlWmtLuVpGKn7FLZtU=; b=UPKuBEMnG4dw7Ly/WD
        mMC2A/V2z1/vEaQcg5A64GxUF1mmHL+a326KLazJOj7HVnRFKjU9P9qoPhg+PqXa
        /QtjNzlIdIt9LRXw/6cJosk7JsvpqEaelnK9v/AVuS1cCA7yGBC7SjWImqJF2Ebu
        Zjp+inuBCaJLIIRnJ1uaKzedqpGJ/+KGk0jmFEBZhFu5ILXBRIdvKIOGJIP1IMOt
        CbFJ5b5PekDOT5X+VrrQMIoNLaHE1ZLVXZceMa14Fh4WTF4HYiV5M4aOdC3N7RCg
        HpDu32sBIPBcuznQDmQwJ3fcoIaB0vqZ9kbBIaiKb/P2164bbloXuGH6rX4dC+hf
        HsfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700142028; x=1700149228; bh=bGIxYXyIqpwVy
        5KNp0/Neu8NcBlWmtLuVpGKn7FLZtU=; b=09i7T7hxgV7kgBtnme+L86MuuGfu1
        1fKUgkGi4+3QjafcPnlBHck4uobsyg+AVoSPocA0QrvGHBVBOjews4qbYHqqnNSy
        7CELOkVB7SD0TIhtDxbnY9JiXr7rBWgToTW0q25n3thy7TpetzKJc3kfx4jt401M
        6pNom/JNUeQpD5gCy5VQxxSQLXQzpzaK8P53poe1BXW6xNnM3Ywwfm8kuZGoyWY7
        EO2QnW1qMZOscFjU8cm63cCsvduPFHNu9kqAQZU/+psyEP8PfOULHkjwhVVaaiFe
        XiaLF9u5/HOt8d/g3WJWdhuDNlT/hXc5tDw7lz1r7QYz6OBohe/IyN4Cg==
X-ME-Sender: <xms:yxtWZdshl3psfcrvshYqEM7joFDSLlXDHds2eive83kxO85pk1T5Kg>
    <xme:yxtWZWdInmINk8a3jDuvZZkJ_JGYXPTpwgJiTRJjG0BvODtqJsEjxGTUn1endewwA
    uun_p6iaG-IQpT0xeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yxtWZQy2xTqP_ltxvulAGXAt1NMb1TRByh5Ns7KJEMs9uCjVZoiD3A>
    <xmx:yxtWZUO3sCdx7Akdz06hqA-SgRK3cDHQ7l58BsJ4-JrHgukefq-WWg>
    <xmx:yxtWZd_96_Ln1c3CGYPnV0O0PMcXTzHBF5-Qnfe6uAji1nD4Ipw4zw>
    <xmx:zBtWZWO61qdpj4jJ9j2H5fW9dwiFyERJ0Ql8T7wsgm4KSvdWS2uG_yGS4IY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E836B60089; Thu, 16 Nov 2023 08:40:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <bf176e04-88fe-4333-8500-1335ad7a1bdf@app.fastmail.com>
In-Reply-To: <20231116074706.3448008-1-ruanjinjie@huawei.com>
References: <20231116074706.3448008-1-ruanjinjie@huawei.com>
Date:   Thu, 16 Nov 2023 08:39:58 -0500
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Ruan Jinjie" <ruanjinjie@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: Fix 32-bit compatible userspace write size overflow error
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023, at 02:47, Jinjie Ruan wrote:
> For 32-bit compatible userspace program, write with size = -1 return not
> -1 but unexpected other values, which is due to the __access_ok() check is
> not right. The specified "addr + size" is greater than 32-bit limit and
> should return -EFAULT, but TASK_SIZE_MAX still defined as UL(1) << VA_BITS
> in U32 mode, which is much greater than "addr + size" and cannot catch the
> overflow error.

Thank you for the detailed analysis of the change in behavior that
resulted from my patch. As far as I can tell, this is an intentional
change that should have been documented as part of the patch
submission.

> 	    assert(write(fd, wbuf, 3) == 3);
>
> 	    ret = write (fd, wbuf, SIZE_MAX);
> 	    pinfo("ret=%d\n", ret);
> 	    pinfo("size_max=%d\n",SIZE_MAX);
> 	    assert(ret==-1);

I think it is wrong to have an assert() here since the
documentation for write() does not state what happens
when the beginning of the buffer is addressable but the
end is not. We were handling this inconsistently between
architectures before my patch, which ensured we do the
same thing on all compat architectures now.

You can argue that this behavior is inconsistent with
native 32-bit mode, but at the time we decided that this
was not an important distinction.

> Before applying this patch, userspace 32-bit program return 1112 if the
> write size = -1 as below:
> 	/root # ./test
> 	[INFO][test.c][32][main]:ret=-1
> 	[INFO][test.c][33][main]:size_max=-1
> 	[INFO][test.c][36][main]:INFO: end
> 	/root # ./test32
> 	[INFO][test.c][32][main]:ret=1112
> 	[INFO][test.c][33][main]:size_max=-1
> 	test32: test.c:34: main: Assertion `ret==-1' failed.
> 	Aborted

Here, the write() successfully gets 1112 bytes of data,
which matches what you get for any other large size that
does not overflow user address space in the kernel.

> Fixes: 967747bbc084 ("uaccess: remove CONFIG_SET_FS")
> 
>  #define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS_MIN)
>  #define TASK_SIZE_64		(UL(1) << vabits_actual)
> +#ifdef CONFIG_COMPAT
> +#define TASK_SIZE_MAX		(test_thread_flag(TIF_32BIT) ? \
> +				UL(0x100000000) : (UL(1) << VA_BITS))
> +#else
>  #define TASK_SIZE_MAX		(UL(1) << VA_BITS)
> +#endif

This adds back the cost for every user access that I was
trying to save, and it makes arm64 behave differently from
the other architectures.

As far as I can tell, the current behavior was originally
introduced on x86 with commit 9063c61fd5cb ("x86, 64-bit:
Clean up user address masking").

     Arnd
