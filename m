Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DCC7B1352
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjI1Grb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjI1Gr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:47:29 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE599;
        Wed, 27 Sep 2023 23:47:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C2B123200904;
        Thu, 28 Sep 2023 02:47:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 02:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695883644; x=1695970044; bh=LT
        k6zr/ggRDguEdXkx/8zC60ez8Fjw+YyDIOUcwDxeo=; b=ErRFTJsqk2eAtmLhZs
        qHnNK8Db1Q3eYSf6bG0PXpr3FxwjXinRBokrurLhuF13zUAsSNt7oyy4vKjqpxMb
        O9ID5S3Fk7VfoaaaADO5sZyyxIK0ommc2DU8zHlW7NyRBAvARw8LufAts4QLGmao
        3Dl7IolOiYt+lMRaDu9ir9Nt5TPc2rbVsVliSKJyE4bwHCaGUXfeNxJn9RH3hEnu
        rPuAmHDhbs4rycU3IERJ1jM85oUjzQR4NtCeyJiepVfwo4hdmPvrwPTKZmUiD8QL
        ijdH1wZDuyOawg5U1yl0kZW9wXjzvjNz2NLGQldoylbHtB6rms9L4kKC1I5yBEwn
        0S4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695883644; x=1695970044; bh=LTk6zr/ggRDgu
        EdXkx/8zC60ez8Fjw+YyDIOUcwDxeo=; b=lAotKalVJjVrVZpSiPrlf8z/ZrSkO
        fJOvS1Z4+w6Nd/6Vpd/g5OBs3oex4okMrW7uMgfvpxV4TrwsN3QIqICejpO5y04w
        jeVA9o6weRP94Omf7O86BIxUnEeRlYs1FHijlPL2MlMNZX/z7cpZldo3PzegwGuo
        ZUUWc2gVqfID3YFgo7yxduDK98dyvj2Tq+OAUqcvTASyzU/URasXtEiboNsAaZCa
        oYzZOvSHptCDHpHhKdcAvuQO0rFQiT5+YO3E8TawzAeKmOXzBg0SzxounWu3ATpt
        uoG8wP9kiNJonPyLnyGKxRK6GbZN5nqYdssDNG71Px+o88MY7KX+WQhdw==
X-ME-Sender: <xms:eyEVZVYjuvnXv7CxInx7W9x2b7hSZtLv7n-iVpj_s-Tomns-cquE_A>
    <xme:eyEVZcZrPv_sg4gvwByPOt03MyYWN1bwh8XaoDjcv6SdHu9kNOGVTZ7idazbWMZud
    RXVmppCBKEqDFYLgGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eyEVZX8fUMg54VwptKEAtPCS8AcDHWwPXPmOQ_14AC54D8i0v1xqgw>
    <xmx:eyEVZTrvYLYzhkgmO33pM3vRFhLzSCpMgUc6C2C79mAuXi0HckecPg>
    <xmx:eyEVZQq8789mUmqZ8Q7bMjZUbctqDYAuHCGV4UX1Gdb2I6S78C6JpA>
    <xmx:fCEVZX2A7tMUV2DpjIUM93bibshPmjaS3kOC4hhB8VZ708T15603bg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 40C34B60089; Thu, 28 Sep 2023 02:47:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <a3ee2d1a-4fd8-45e5-966f-c93c2f19d448@app.fastmail.com>
In-Reply-To: <20230928092223.0625c6bf@canb.auug.org.au>
References: <20230928092223.0625c6bf@canb.auug.org.au>
Date:   Thu, 28 Sep 2023 08:47:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Muhammad Usama Anjum" <usama.anjum@collabora.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, at 01:22, Stephen Rothwell wrote:
> Hi all,
>
> After merging the mm tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> fs/proc/task_mmu.c: In function 'pagemap_scan_pmd_entry':
> fs/proc/task_mmu.c:2153:22: error: implicit declaration of function 
> 'pagemap_scan_is_interesting_page'; did you mean 
> 'pagemap_scan_is_interesting_vma'? 
> [-Werror=implicit-function-declaration]
>  2153 |                 if 
> (!pagemap_scan_is_interesting_page(categories, p))
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                      pagemap_scan_is_interesting_vma
>
> Caused by commit
>
>   825ebc8e4bf9 ("fs/proc/task_mmu: hide unused 
> pagemap_scan_backout_range() function")
>
> I applied the following fix patch.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 28 Sep 2023 09:09:26 +1000
> Subject: [PATCH] fix for "fs/proc/task_mmu: hide unused 
> pagemap_scan_backout_range() function"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for the fix. I don't see what happened exactly,
maybe we had two conflicting workarounds for the same problem
applied. The version in linux-next works for me on the randconfig
builds, so folding your patch on top should be fine.

    Arnd
