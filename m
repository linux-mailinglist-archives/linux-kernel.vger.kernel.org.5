Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F3797FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 03:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjIHBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjIHBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 21:05:54 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC01BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 18:05:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 40C4B5C01C9;
        Thu,  7 Sep 2023 21:05:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Sep 2023 21:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694135150; x=1694221550; bh=WmqyT4IFLv9qj
        H0y30QsEQmethRjFgEsjTygW1IyiXA=; b=DRjkjBnWsc49xHzSgjZXba3yl3ZMr
        r471ebLtFRXd1N7ePXF61uuOV48ajy4sEVwConnQzv+ujXOikP0cijgJTI5T6XJU
        eJk1FuIGK7DzaS+KHENdsDGY+bwJAU6zgitbqPMjJvYQ0Jfxgbb6Zy5Bnfyu205x
        y72zYhq9cPQiEO+Lz8kHXHjE9RI494GB3njvsq3PrtBEuDRpj/5beiqlPqtxqiKL
        ZAVde3y0G0uesbksFpYUIr9wdFw5caeEBUR5BBpR05OR2TGt1x2xyHv5E8gn6TsM
        IdItFlw2ra/rCU0lgQFPHiuUIIfkqzoX9cNOyy6qVmS3Ns9zdyXdS1FEA==
X-ME-Sender: <xms:bXP6ZGo17a6n6-hPbwa3kAekgU6Qw5Zyz5aBmKT9kRMSFY6EaR4Vwg>
    <xme:bXP6ZEoWqwrjhIxqX8NAcrCkHMjRIBb2V3wiGC8vKZgnqzeMZGqQavts9LfblZ_lq
    YI6ZLSHOe-cHprNvKM>
X-ME-Received: <xmr:bXP6ZLNRd_Ctkcs2FPc6qYavojZC6TorceNe-LdqKCT6A3716qDM6WIGJbseeQeCJQ1gwc7xwm9Q_jOK9dOaLIyQUBA27Q2xJ6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:bnP6ZF4HHGZ9dLGvkeIUYJxOiP0pk82kcv5HxaSf5sOLbDVhj6GMHw>
    <xmx:bnP6ZF5beTNRjvACs1BPZdeyFbV0hEF8945hbW2JvFgDsXJmZWwrqw>
    <xmx:bnP6ZFj3UDKkNJsO1GWzl_KuvEGujSKV4AmiLG36Bm2H0lJchrNZwQ>
    <xmx:bnP6ZAbHjtdQRFnkExEFB-YVvSRVlQ2SZOoHAbo0Iki_u-nGq1Bynw>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 21:05:47 -0400 (EDT)
Date:   Fri, 8 Sep 2023 11:05:59 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/52] m68k: atari: Add and use "atari.h"
In-Reply-To: <6ff868a4-d433-6e92-8bf2-573fee19ce2c@gmail.com>
Message-ID: <291d4cb0-e3b8-1e7d-8b34-79aee23865fa@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org> <0778d9dd186928666d760d5523c7d2311f781621.1694093327.git.geert@linux-m68k.org> <142e4eb5-b47e-e27c-1be3-bc6c5df889c0@linux-m68k.org> <6ff868a4-d433-6e92-8bf2-573fee19ce2c@gmail.com>
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

On Fri, 8 Sep 2023, Michael Schmitz wrote:

> 
> atariints.h already has some prototypes, so yes on that account.
> 
> atarihw.h only has inlines, but sound and time related prototypes could 
> be added there, too.
> 
> Geert's intentions might have been avoiding inclusion of all the 
> hardware specific data in those two files, but the only source file to 
> benefit from this is config.c (the other three already include 
> atariints.h and atarihw.h).
> 
> OTOH, considering this patch series adds a lot of other headers that 
> only contain prototypes, it might be better to keep to that pattern 
> everywhere.
> 

I think Geert's intention may have been to avoid adding definitions to the 
asm/foo.h headers shipped with "make headers_install". If that's the 
intention, there would seem to be a mess to be cleaned up, for which I'm 
partly to blame...
