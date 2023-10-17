Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865B27CC7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjJQPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjJQPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:44:47 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FFEB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:44:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 53FCB3200AC5;
        Tue, 17 Oct 2023 11:44:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 11:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697557480; x=1697643880; bh=WO
        5oCwd0emrb8IPguFXu9R6WNvZlreecdRq2Lp8IU04=; b=SOiTF1mRlvMAzZ1jVp
        9Ko8LKGkXdvaUBlo2QM/9ta3nyXLLYwf5FUubEWn7qf4XG9e9sYu0JPCm3pfR7dS
        X8C65wawMeSAoFw7g1ar/bkL3lKhLe3ROltJRjtbQaWX3/GpMEhC6XDK/Hbua/bx
        KxPpVBMmJlJ1Cdcblv5sXjiT6uVRX7go5j5WP1nhN4kUtIFu5yxLnB6Qh8k2Q0Mq
        OZaqp5LOCz8FfZAgA8TCrrlQECoc2ao3z9+KP/sPKQ8Rxj1EfOyXqVrQhuWFWzWI
        o9oTqDoYi7o2yWb2bxTz6BWU99mJiV5t0u42D1Q72bq3iXjAeQObeySVWB9kHXOn
        pRsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697557480; x=1697643880; bh=WO5oCwd0emrb8
        IPguFXu9R6WNvZlreecdRq2Lp8IU04=; b=tHWhT9ILk8dOCLicGeopxN9IZuLmJ
        tsLO55chUNSCbYIvaqq9QB3GSclT+ChP6pPOKjkP7w93+NYIqREpnGNfYJAWLEkF
        vS/Ln7f89MQsHRsmvOgM+85tuZ/RCMwwNNef0EtP75EIVxV4L+OBGiFUGICSGYMY
        8DyyyQ2S9Ph7171PNxHebMOUxmckXpgguUTZm4vUmhgG5hZRk3Qa+UYPWnD4U8ky
        LZFP/YA3re90XUeqd4cA0ki7F8Kf50AUfY0M4KzAf6hcVzqUmtUp8JRbog+rsJ0p
        cxYXThKNMBhq5G/pxaS+J8kyCL7bg6+f3UxFOISxkn6iA0SLD3ZoGuA5w==
X-ME-Sender: <xms:6KsuZZpc_eD4XZDaFZRaQ_jIG-dspA-827ffkQNeCZd0ppzztMR5Og>
    <xme:6KsuZbrlAJ9uB3zJ_8PN8z9em-jqkPoBFkR_RKqYhNCPdJ3-eFFyOkSV_CFwCYwII
    f6cSWu4XroL_0W9ZFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6KsuZWNEn4zHV-egc_937wqNd2EQiE1EvKI3cFRGU1uyTMKAhTMIKQ>
    <xmx:6KsuZU58aCEjEkYE66RvzYV94mo4lCk45ctMB7CV49okoDB7b8rKYw>
    <xmx:6KsuZY7FVpEXt9SWVfJIQOeR1A6hRxwPZshRhd7gZoJBi9oSFMH_Yw>
    <xmx:6KsuZWmk5xB-nfemiOuqh9VJKIv34ULpBbXd1ZMayYg9a4sk6LSTDA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 77E9DB60089; Tue, 17 Oct 2023 11:44:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <cfc27d6b-a2ae-495d-b819-f3cc35f82844@app.fastmail.com>
In-Reply-To: <ZS6lxxmGDy1eRWoh@yury-ThinkPad>
References: <20231017143408.2876181-1-arnd@kernel.org>
 <ZS6lxxmGDy1eRWoh@yury-ThinkPad>
Date:   Tue, 17 Oct 2023 17:44:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yury Norov" <yury.norov@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Jiri Olsa" <jolsa@kernel.org>, "Song Liu" <songliubraving@fb.com>,
        "Alexei Starovoitov" <ast@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buildid: reduce header file dependencies for module
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023, at 17:29, Yury Norov wrote:
> On Tue, Oct 17, 2023 at 04:33:58PM +0200, Arnd Bergmann wrote:
>> 
>> This is easily avoided by changing linux/buildid.h to no longer depend on
>> linux/mm_types.h, a header that pulls in a huge number of indirect dependencies.
>> 
>> Fixes: b9c957f554442 ("bitmap: move bitmap_*_region() functions to bitmap.h")
>> Fixes: bd7525dacd7e2 ("bpf: Move stack_map_get_build_id into lib")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Yury Norov <yury.norov@gmail.com>
>
> Would you like me to add this into bitmap-for-next?

Yes, I think that would be best to avoid the regression.

Thanks,

     Arnd
