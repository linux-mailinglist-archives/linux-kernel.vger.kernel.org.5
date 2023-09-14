Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446797A0A80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjINQM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjINQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:12:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15AE1BE1;
        Thu, 14 Sep 2023 09:12:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6692D5C0129;
        Thu, 14 Sep 2023 12:12:20 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 14 Sep 2023 12:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694707940; x=1694794340; bh=Xi
        qTMf+G8Iz9Kt1AWAyD7uk9c3iPMZoPGJgLyaqb6qE=; b=oPki5SIt24YuSDY/d5
        5pfroamgkkvQnJuupS/qtTCycZHGJfgm+Rb2vrFHqZm+qeJQtSfJftgL1taTDfTC
        qU4KN13e3qz8Nc49Uj2B77tmK7nqUjC+D4cs468Tu20ALTMUu+QkGKARsei/cn3f
        Ix/qKy073jUF+HaiKm6lr0FQCKcdZuAtu5LSOHt7X1ixOjfcpT0lbc7tWd5iFXfA
        k+xUqrbpKtDb4us6vWTd24KYnuUlAZOXLenv8kG7BLC919g226faiJV+EPBMXP23
        6NO+3LcP3cpi2Ac1juvrjIB+okWOSbNc5jdT2/AsgeAFpBTQxcFBHYdxW8B3ngqj
        Su2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694707940; x=1694794340; bh=XiqTMf+G8Iz9K
        t1AWAyD7uk9c3iPMZoPGJgLyaqb6qE=; b=I64Z4tAGR9egiP5LgMRtbzWXcS5B5
        /fib2M8O3suwHu3fnzlvf7gJxna0WEKf/Tdh+TIhcXm0xUjHJFPgm+qEuaW5Dob5
        cVCaDVLyitDnfcHl0QXstNOgt86KgVAVI2wdFbLcu6O4fxiqVebH6vh5Fbrn5az1
        837aYqE2Z+1rNiuN/FAnRauZ8K0AxP5gEgA99beK3IgFRHkaesEVwiG0aFss/C+t
        IliAxaxkia6BDWmcdnS2ibWfr8ov4kTe/23ALGumQ0Ddm7m1J70WlTBgn3F0TRZY
        g1x9vvECUfoOvkw/R9cZtuQZEKFS0AySsjVUUbZpzeoGlPA7EWL2zXhJw==
X-ME-Sender: <xms:4zADZVqzLGck7Jw3IZtS4FNB9lSY2OjrYb6hpeetkkpJLI_K5jnA9A>
    <xme:4zADZXpVGcKNgz-LYvqTlUdsZXKKqoVh9Fzxe0fA7ebFoLhplM4CTgmL16YERcnIj
    LE75XTdxaNvL5TIIIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejtddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepudejhfffvdffieekvdekfeei
    uedtffetleegteffhfekffehieehheevtdehteeinecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:4zADZSNZbfeiJt9mlJSJF6F1Voifxz28Tn6MxObKeHDxS-oDyISJuw>
    <xmx:4zADZQ7Sy2Jbf7NfA4nlzNjfj0JCgreM6P_yqASq1c7quhY8eJ-PZA>
    <xmx:4zADZU7IrDT94V-ilgSeVu_UIE_kl9FW92-sPojBqmhtTzD3XfbxTw>
    <xmx:5DADZfJ7-DbCMojJ61nCSeh51SextikzNfEEVdhI82Q0ePyK5hFrKg>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 096B915A0091; Thu, 14 Sep 2023 12:12:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <e215acd4-52fd-429c-a569-a20ba5a49d7e@app.fastmail.com>
In-Reply-To: <CVIR0BGHX3VS.39FY5QL8KXR0F@suppilovahvero>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
 <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
 <CVIR0BGHX3VS.39FY5QL8KXR0F@suppilovahvero>
Date:   Thu, 14 Sep 2023 18:11:02 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        "Philipp Rudo" <prudo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, "Luca Boccassi" <bluca@debian.org>,
        mjg59@google.com, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, would not be a bad idea to extend CC list to at least Matthew and
> James Bottomley on this patch.

Sure. Added Matthew and James in CC

Also, I already made some minor changes. cmdline is now used from the syscall if there is no .cmdline section included in the UKI. find_section now returns the section_header as an ERR_PTR. You can find them in the uki-v3-wip branch at https://github.com/Cydox/linux/commits/uki-v3-wip
