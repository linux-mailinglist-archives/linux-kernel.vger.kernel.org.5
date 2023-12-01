Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2D8015CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441807AbjLAV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjLAV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:59:42 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876AD10FF;
        Fri,  1 Dec 2023 13:59:48 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B415A2B005E2;
        Fri,  1 Dec 2023 16:59:45 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 16:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701467985; x=1701475185; bh=9R
        UywHy5pRnc9jdI4T7duTy4HQrezKiKqmZajvx6reU=; b=jIU4MqrAF5Hs0q5K98
        M9thslGVc3kVtc6S4O3wNX05MTrDRwXqLVAMa4JsD1pg6ph/7avYySJm+Ct1ckdh
        l3jvN8iwLzqY8XR+BxQf3GZoldRTAc7P4B6ZCAV5UHUpdnewrnxAbYfQZG6SgQkP
        h3cvU/7n8Tgitp5wxFzbYQr+f3YFH3Dvs8sZRcxzAIzsI7ikX6CreYtvD2CF13Jd
        pFX7Z2sledvBK0ErKUjTOYtG2VlPjljOKR7XWz+KN9o3o/0YLBSQDP9Qdb250YfG
        hVlqPXMLQ5wJHq312jSflf5X8JqXv4I91ZORcHn1w9sZfuOlEeuxj30FOXCQV712
        R5fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701467985; x=1701475185; bh=9RUywHy5pRnc9
        jdI4T7duTy4HQrezKiKqmZajvx6reU=; b=zIVGbocni2KrrZV4Qf9ijkVktgXu7
        5tcFdv7JeT+OF5ulDfigWgrSMm5EEvv5QUH08JoWyn1bk8BM1AZbWuW8YDZ3SQlp
        HpCX0YvnQbfj1RXqNa/ioZi//RiNCL7ED83FrzqInI8psP7IgaskeVVPvhv53Wdh
        pqQgexV5qqBAKbrw+uEwXnWR0CTEJXBHUDuNZSvFHm8aCn9mlpZXBwtEP8SMDcSv
        D7ahvIdMZ9KpVaPcn/pKIRWzICJnzPiTFVFTHVBRyaU44qLXhjHF1KQYbAmNATdX
        El4Xv/WqUm9yLqoyzit3u7xQwT71fOy8tpFOHKj3UCrHusrCzw9ntn90A==
X-ME-Sender: <xms:UFdqZQtI0s2T5yAn4l8f9dzRI4b-L1p2ysCTLB1VAMFatctVxbkNrg>
    <xme:UFdqZdeqXMuqEIHfFoKVmy8LIVbnMPHwUXbM5lZMETdam5ZqBNucfbrtWMAPW5uCU
    G0gMAEOo2WSH8cBjQM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UFdqZbw_hr8AgfSDlPYsb9L8Oux8q_rKbNiy66Dz26HwAl4M0xKEoQ>
    <xmx:UFdqZTN3nzfEGTdGbzUmP8avJTb7uE5rVeAgzXm5xxrq4HIh5Q7PIA>
    <xmx:UFdqZQ9XRU2F4On96QMppiqhfSN1a-80ofYXcNMTr0f8DG77Ug0fVw>
    <xmx:UVdqZctDuxBGmkSkd6gxMsJDn8U9mfaHwRWSXKg4WjBhluvR-vACWc6FBho>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 182B2B60089; Fri,  1 Dec 2023 16:59:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <3627579b-66dd-42aa-92ab-3d561cdfb2f8@app.fastmail.com>
In-Reply-To: <c902e7e690dcdf57c2e8402e083d27ce84aee21b.camel@redhat.com>
References: <20231201121622.16343-1-pstanner@redhat.com>
 <20231201121622.16343-5-pstanner@redhat.com>
 <619ea619-29e4-42fb-9b27-1d1a32e0ee66@app.fastmail.com>
 <b54e5d57624dae0b045d8ff129ac2a41f72e182d.camel@redhat.com>
 <330df2f8-3796-4f74-8856-06ae1e46ec9b@app.fastmail.com>
 <c902e7e690dcdf57c2e8402e083d27ce84aee21b.camel@redhat.com>
Date:   Fri, 01 Dec 2023 22:59:23 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Stanner" <pstanner@redhat.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Uladzislau Koshchanka" <koshchanka@gmail.com>,
        "Neil Brown" <neilb@suse.de>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "John Sanpe" <sanpeqf@gmail.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Kees Cook" <keescook@chromium.org>,
        "David Gow" <davidgow@google.com>,
        "Yury Norov" <yury.norov@gmail.com>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Danilo Krummrich" <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH v2 4/4] lib, pci: unify generic pci_iounmap()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023, at 22:56, Philipp Stanner wrote:
> On Fri, 2023-12-01 at 22:32 +0100, Arnd Bergmann wrote:
>> On Fri, Dec 1, 2023, at 20:37, Philipp Stanner wrote:
 
>> The best I can think of is to move the lib/iomap.c version
>> of iomem_is_ioport() to include/asm-generic/iomap.h with
>> an #ifndef iomem_is_ioport / #define iomem_is_ioport
>> check around it. This file is only included on parisc, alpha,
>> sh and when CONFIG_GENERIC_IOMAP is set.
>
> My implementation from lib/iomap.c basically just throws away the
> IO_COND macro and does the checks manually:
>
> #if defined(ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT)
> bool iomem_is_ioport(void __iomem *addr)
> {
> 	unsigned long port = (unsigned long __force)addr;
>
> 	if (port > PIO_OFFSET && port < PIO_RESERVED)
> 		return true;
>
> 	return false;
> }
> #endif /* ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT */
>
> So we'd also need PIO_OFFSET and PIO_RESERVED, which are not present in
> asm-generic/iomap.h.
>
> Sure, we could move them there or into a common header. But I'm not
> sure if that is wise, meaning: is it really better than the ugly
> WANTS_GENERIC_IOMEM... macro?
>
> Our entire goal in this series is, after all, to simplify the
> implementation.

Right, in that case it's probably better to leave it in lib/iomap.c,
just keep the ARCH_WANTS_GENERIC_IOMEM_IS_IOPORT definition
in include/asm-generic/iomap.h as well then and keep it out of
the normal asm-generic/io.h path.

      Arnd
