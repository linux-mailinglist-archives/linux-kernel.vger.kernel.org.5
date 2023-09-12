Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8579D9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbjILTjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjILTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:39:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74180115;
        Tue, 12 Sep 2023 12:39:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DEFD1320094B;
        Tue, 12 Sep 2023 15:39:33 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 12 Sep 2023 15:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694547573; x=1694633973; bh=WZ
        CYP04/rhzJgnLDaE8CVzEzQ+KEpBf0K8M9Awn51FM=; b=gzusCR1YNNT7KRI9Vc
        sF4bCGobnkVW0Acata+GcerwRPUYPPia8ymGuTtX/A7/uG7CQssVqM9sRGc02ulR
        VMasWRSt9xyKGxJBa7A7zktZRP5Iiuzn0nvxjItkRJscqxMfiIpSvePW1qULzCOz
        ZyAcXmcImHGsAbkLtMfIrHuQnoq2rAS85bLI2NP/2ZS3zvV6fJ8SVB/r0n8GTzrc
        Go1mga9SQrsBW6tH1o9dk8X1wtzq3GxCfrwZU0POZkMfres7fvN4agAE/Bfy15aD
        U4qvQeAL+m6/uryW9DPOlQJoWRsT06IpVnpOdMc8HLA2mQzv8dRcti1LcPHXXW00
        hN1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694547573; x=1694633973; bh=WZCYP04/rhzJg
        nLDaE8CVzEzQ+KEpBf0K8M9Awn51FM=; b=W8bVmm6YVwzExgShMlOZOEl48v/1M
        6gnGKe0/ANZKa3+2VhqvMHvU/oarCM9YBzjBVmB3jl5vV/bK1yW7sonkKJl1jznp
        IXS4qVFvzWwHUVaS1lvdTTpTIqmy/RBBPk7GMx3IT6306iFfNJgeOvU13SxC5yAw
        UH+yMESmV6EW/vuUF7LkdK8ULnKWtLANeVFgn7qdF4YJFoTu2fAAZk3rrBalFjRT
        leO1xWmiXAea3SlgPVemDD26oVzS5O3Tyq7Z/SM5ie7huSJyCJy3wh+VftwyT7oC
        2/uLgj1A3nc2Oi/gXh8x/xujrAuAbgENs/WLZ7809UH6BSp8NwbxEXKOA==
X-ME-Sender: <xms:dL4AZVher48N1bwWnh44_w4_3KpCy--tISESEqV6B1igZ_pIHyp8qw>
    <xme:dL4AZaBXhE0Idd8WDRp85m7yHAtQ1WlKmZiJ3YG0f5w1kIbFW5vc-3252Vz2KDL-U
    ThLoWDdPfb7kn-diEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvfevufgtsehttder
    tderredtnecuhfhrohhmpedflfgrnhcujfgvnhgurhhikhcuhfgrrhhrfdcuoehkvghrnh
    gvlhesjhhfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeffffeufefhiedvfeehgeev
    ffffffduvdduhfefjeekgeeviefhuddvgeekvddvhfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesjhhfrghrrhdrtggt
X-ME-Proxy: <xmx:dL4AZVFn82aDVZ3ec_r23wCGXtAec5wyd6MXdhNyEOVjNz-E2kB0mg>
    <xmx:dL4AZaQvBUb3aEIKN55pUPxd2xpJZ1Xzc-L5n1aEhggcXvUT-8GDuA>
    <xmx:dL4AZSxldthPWcFEYAAjSeSC1n9rp2hsvfKpkrHtGs68R0b-IkA5kA>
    <xmx:db4AZXqaMMtlSs20nFdfLY2_No1tbW5xWYyyLUMeMHlCyt6QXqVNtQ>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D09215A0091; Tue, 12 Sep 2023 15:39:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <3cb7629f-9dd9-430a-86a0-5acb32882018@app.fastmail.com>
In-Reply-To: <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <1d974586-1bf7-42e8-9dae-e5e41a3dbc9f@app.fastmail.com>
 <CVGVCYUGNKAI.1WYRZGI9HYDMC@suppilovahvero>
 <9580df76-c143-4077-8a39-b1fcc0ed37bd@app.fastmail.com>
 <CVH4GZXQFZ1F.2V5BIZNSKQ1FA@suppilovahvero>
 <5a67051d-eb21-4a96-acc4-40f829a59e23@app.fastmail.com>
 <CVH6NGLENMPH.271W6X80061M@suppilovahvero>
Date:   Tue, 12 Sep 2023 21:38:59 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, lennart@poettering.net,
        "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> These are sort of "tautological" arguments. There must be some
> objective reasons why this architecture was chosen instead of
> other (i.e. using what already pre-exists).

You mean like your argument that the same can already be achieved with the normal EFI stub and builin initrd/cmdline? ;)

I think only reasons #4 and the last paragraph in me response relate to it being pre-existing. The other reasons are actual limitations with the normal EFI stub setup. Doesn't mean that they can't be overcome, but UKIs work.

I'm not sure what the initial reasons where for coming up with this architecture were, I was not involved.

What I can tell you is that right now it is a format that has practical advantages and that there are generic mainstream distros looking to adopt it. So having the capability to kexec them is gonna come in handy.
