Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376B57C5661
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjJKOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJKOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:06:15 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385DBA7;
        Wed, 11 Oct 2023 07:06:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 780935C0418;
        Wed, 11 Oct 2023 10:06:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 10:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697033170; x=1697119570; bh=Mq
        P27hLs84B1d5SWU+1RVfvQUaw2zlqyPIX0397Jqkc=; b=FphjZ5yJDqwRLHEKOD
        6+MstyCCd7J7CAVK/r5DkCLgzPjjHRRGBZzyQok9a3wZbpFEoE6n2ZRCC48UsnsP
        2uphIUPeX5ZfrIr0RZRpROszIcqKFk/fP1FQfScda/6722MsfvTK5IWcWccAfdec
        2ZWIpCRL/AGDve6LpdQIPZ0F+HW1mwss1Pn7IpPUHEy9g84nmbfoSWk0UswfcmOW
        oosGeMr6R7t6MpffxcxnylzE/Ia/ZFIR4aUlfn8bIXoa4KSspYkuxv4MUvZiUkWy
        Ex28EkTECM7tscSXGGK+eEzg/PPu2/aptZdc6loFMR2MLQPfJR5/SKQlqjfzXeZ7
        OuWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697033170; x=1697119570; bh=MqP27hLs84B1d
        5SWU+1RVfvQUaw2zlqyPIX0397Jqkc=; b=ouY87AmWoncBViJ0tHfeXCMQOavQe
        d66cZxGBH0wrpt4l7EeEakaPu1WvmOwKYaekPvr04gBj6o8Q76MjnrkmmFj6t4Nd
        z6fqGfnPF+D7M1qKwlSD0QiXJw/yZ2hPH0an0yVinbaHAomma9ufH8Upltuf6Mei
        820kb7MP2ro6wn4xdzj96RuP3PZCCwx2LrL1XEXqpT6HlENdwwgS1TkPJ0QVHYsl
        x3cRFaNQB2D8MbDsZBlJJ3vLdppbe/VTm/dsHiC38gErcr88U2TJg2GoZ7N8JBEK
        GF/T4/pq3MPczeoVuI4N5fDdqNbqMQPQ6ldK4sf+yYwwHrbbp/DzJSYfQ==
X-ME-Sender: <xms:z6smZUrG4Iq8tNJG6JPzqD3wuKJvf1i16dhAKPmNhVKjJmYNzuEjPQ>
    <xme:z6smZaoFCVRVCtTOfRCjz3ahoMO82vjThfsnoh0_6UH3I00muyUDbramo-AnDlK0e
    YIloM_yy13NDS830wc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0KsmZZN9Bn9eT7r5VNLHvY3XbCu_TZ1D39XAmJqf621VcNKdI6waMQ>
    <xmx:0KsmZb71_GywYZWG_ZnynaNfjXgPiYbVN1phwNgVKSMh-5KTkjXN9Q>
    <xmx:0KsmZT4a6Td4EOmOwAInAUPEvOGDh0VCDw-XZqjrFLiou5VXzKVRhw>
    <xmx:0qsmZXgtcbHblQ7yVbBY_-dZPmPXqNGJdx-CW70EmPRUS7YPRoQMGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E3F84B6008D; Wed, 11 Oct 2023 10:06:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <dccc0487-f254-4429-a6ab-fed037daae50@app.fastmail.com>
In-Reply-To: <20231011135905.hveat7viflqluccw@bogus>
References: <20231011131431.2559029-1-arnd@kernel.org>
 <20231011135905.hveat7viflqluccw@bogus>
Date:   Wed, 11 Oct 2023 16:05:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Sudeep Holla" <sudeep.holla@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Yang Yang" <yang.yang29@zte.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: rexport of_find_next_cache_node()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023, at 15:59, Sudeep Holla wrote:
> On Wed, Oct 11, 2023 at 03:14:08PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This function is now called from a cpufreq driver, but that breaks the
>> build when the caller is in a loadable module, because of a missing
>> export:
>> 
>> ERROR: modpost: "of_find_next_cache_node" [drivers/cpufreq/qcom-cpufreq-nvmem.ko] undefined!
>> 
>> Export this as a GPL-only symbol, like the other related functions in
>> this file.
>> 
>> Fixes: 7683a63c08ff5 ("cpufreq: qcom-nvmem: create L2 cache device")
>> Fixes: a3e31b4588443 ("of: Move definition of of_find_next_cache_node into common code.")
>
> I am bit confused as I see commit a3e31b4588443 didn't drop the export.
> So how is this change fixing that commit ?

My mistake, I was looking for the commit that initially introduced
the function, but didn't notice that this just moved it from powerpc.

I could have used "Fixes: e523f723d69cd ("powerpc: Add
of_find_next_cache_node()")", but it's probably best to just
leave that line out entirely.

    Arnd
