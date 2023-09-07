Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC84797F42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjIGXhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjIGXhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:37:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB531BC6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:37:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E4CC5C01BA;
        Thu,  7 Sep 2023 19:37:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Sep 2023 19:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694129825; x=1694216225; bh=XTtOj1phX1oc3
        nOxB5P9Xam0a+SUp0ixshRnNwtj29g=; b=HA95W2kXef4fcqozH7ZQyTE6NJNKH
        /MzXOmjB4ymc/2ONGMAawakp8KJe0vsRaHwUe4BtJjDe9sWbDIuaEKA2XAhS09pm
        6yOTE1lxTApvGkNEzQJv7XHtaWdkgY2+zpPYV6iPbFVa6EJMzr2OUw6dE2OFVxGS
        kOEiw4xbSQ39bAdY5cJfTGnLWblw78z95tY0dDTSa9pJFV8Fzri3DOsiiTbyT1ma
        lZIqKT+DWDg4jbUrIt8tcnIb2rxdvE2ec0AfD2DobWhw6rGWSvXVs6Oz88Dl3OR8
        H2vAawJGWop+8WfDZopdDk48OqDDjRVMOMHTeVL0t8qnMl5/60VUwYbNw==
X-ME-Sender: <xms:oF76ZJmL9EKmCd4di2Rg8dmrsugPqzX5pqpVb7DxjNXIHeXOPDXrLw>
    <xme:oF76ZE0Cjd4GO4btiwfIFyEh3oOY4UsyQ295F6qAg6V9po_I74-T4I7aL8F2W-AVD
    IU53cPhM0sHpL2PB3s>
X-ME-Received: <xmr:oF76ZPqAd070QEbtS4XLeZGAuJpeRsBiDbR8rddMKH8Ho57RH_VZmGF3P242fS9IicmLT8Is_Byej5IXC11hdxCrl54xb5tlpq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:oF76ZJnyHb69j_uh76vcO0Wm3_hgMTc3VgY7qTj6utR-YAsExxU-dQ>
    <xmx:oF76ZH2FBWrJM4XrGcXNa09GEymiFuYVPoORmhoCnnJUygzlPuzCSQ>
    <xmx:oF76ZIvAahBodzmOOKkSQWXim23VXEP6TlV-_eBch1sHBADGoJlzQw>
    <xmx:oV76ZMm5H3nvbijrSnaDhaqzL7J_0dvT58Kw7o_TWe5bPhcS6bLWzA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 19:37:02 -0400 (EDT)
Date:   Fri, 8 Sep 2023 09:37:12 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/52] m68k: apollo: Replace set but not used variable
 by READ_ONCE()
In-Reply-To: <5406d0829d8204841c8cb8d265ca91a52cd22d2d.1694093327.git.geert@linux-m68k.org>
Message-ID: <6e46156f-5a81-d245-63cd-8091605deee1@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org> <5406d0829d8204841c8cb8d265ca91a52cd22d2d.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:

> --- a/arch/m68k/apollo/config.c
> +++ b/arch/m68k/apollo/config.c
> @@ -146,13 +146,11 @@ void __init config_apollo(void)
>  
>  irqreturn_t dn_timer_int(int irq, void *dev_id)
>  {
> -	volatile unsigned char x;
> -
>  	legacy_timer_tick(1);
>  	timer_heartbeat();
>  
> -	x = *(volatile unsigned char *)(apollo_timer + 3);
> -	x = *(volatile unsigned char *)(apollo_timer + 5);
> +	READ_ONCE(*(volatile unsigned char *)(apollo_timer + 3));
> +	READ_ONCE(*(volatile unsigned char *)(apollo_timer + 5));
>  
>  	return IRQ_HANDLED;
>  }
> 

I believe the volatile cast is redundant here, as READ_ONCE does that.
Perhaps the remaining cast could be deduplicated like so:

-	volatile unsigned char x;
+	unsigned char *at = (unsigned char *)apollo_timer;

  	legacy_timer_tick(1);
  	timer_heartbeat();

-	x = *(volatile unsigned char *)(apollo_timer + 3);
-	x = *(volatile unsigned char *)(apollo_timer + 5);
+	READ_ONCE(*(at + 3));
+	READ_ONCE(*(at + 5));
