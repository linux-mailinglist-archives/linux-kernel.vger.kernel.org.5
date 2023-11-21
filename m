Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29987F36D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjKUTgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKUTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:36:14 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9DC198;
        Tue, 21 Nov 2023 11:36:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E59E5C09CA;
        Tue, 21 Nov 2023 14:36:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 14:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700595365; x=1700681765; bh=Jf
        CLQ8+7RDc/ys9Dqiv8ksmZfU6vufRcp+bQh8DNeJ0=; b=j59pbpDDMH8vqiwt9P
        nW0aRLGyKi3RX23NeVMCIwVcJ9DUbRD9T/w7kSLj5oa+xi5RiHFMdZZfIs6CTaWf
        acM9LcF+THVCnt6j1IkpCA1pBpGzXENlx4ut0/InWC2QLlxXxZB0u2u0X4+wkiq3
        8Q+f8QisrigiGc9WIw+9HfTYbt9cipfs4kXoCNfGxKKP7L973N5Vty7y1M1OxgRw
        HtRyTszVMWVS6Jk3NtRF5KxOmrKzJnZkFGDJwJZNa9hvnl5HsJL/6WtwLQu4zsOp
        1536tY6PcO15y+7KupCf5CF6qf6DsDcIErCmHggaTFmbO89MKTECdKNq72rMueZB
        6ErA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700595365; x=1700681765; bh=JfCLQ8+7RDc/y
        s9Dqiv8ksmZfU6vufRcp+bQh8DNeJ0=; b=ruprUrYUeyI0kBQftKiG9GF70rm0u
        JSjksjOcdUpA0p5Plg6lcWBMWSsCBho299A7JEE+G5b3/Opwf0XN4c5Xi5JDTiP7
        Xck/y3dJg2nmblO0DzYxRmYSpq7saNLjANYCmFaHtOn74pDi/K9uRhFLvgRiulsa
        Yl64KpvAnjMCjf0GmYZMivb94vP7Cm/j9Z1vpfpCgFgQicSv0lPQxf68fsxdETNa
        s8CRUFR05Rz+g1aU/Zb3rBH2gmqzxFM7z3TFqjrSUyyWkFNJuyWYB48H6gh7bTkM
        tW813/wvnCqGvTzdexbVyCzxIxPZQCpryaICNVWqlLjbQb8ZOfgS2tR7A==
X-ME-Sender: <xms:pQZdZXaBtQ8RxX_fSIgh082j-Y4rwyJ8f_n4qpZQE5Cfb8FjK-OWdg>
    <xme:pQZdZWY_VrcUw8CoKNjN6c82YPzwCadqwFMLvnLp1YxwuajaoQseBlcnOnEjyJmxv
    Y-gRhnZxpkHjlJFGd8>
X-ME-Received: <xmr:pQZdZZ_6FmoEXQKBm7rTEzih32gUK4VONsV-Q0fKcP3VufKHgXu0TexLAjC6wQABDrkwEjeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnuhhk
    vgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtthgvrh
    hnpedvvdegledtheefieejgfevgeefiefhtdevteefteduhfevtdefleethfetgeeluden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvg
    eslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:pQZdZdr7agJcq5g0A0tx7UGjMbFQ_vbA9UwiT24_Opw0ITVgZ8UHog>
    <xmx:pQZdZSrcDptk4QVOBwwEtONXhrz9voRO33Lt2aHUUSHKbmq209Zjhw>
    <xmx:pQZdZTQWwEKFp4pG4yNTYd-F1BWjj6eWMqumep24pWHLY9VPwXIazA>
    <xmx:pQZdZZ2EhdzzvxOaNNpkW8S6NAqCN1-YapE_EqjTc-rv2J7gzDdx-A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 14:36:01 -0500 (EST)
Date:   Wed, 22 Nov 2023 08:35:46 +1300
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 0/2] hid-asus: reset the backlight brightness level on
 resume
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Denis Benato <benato.denis96@gmail.com>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <MRNH4S.965MCNIAPCDV2@ljones.dev>
In-Reply-To: <nycvar.YFH.7.76.2311210951340.29220@cbobk.fhfr.pm>
References: <20231117011556.13067-1-luke@ljones.dev>
        <b4356286-368a-49ec-b1f8-d7e5e4afdc25@gmail.com>
        <nycvar.YFH.7.76.2311210951340.29220@cbobk.fhfr.pm>
X-Mailer: geary/44.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Nov 21 2023 at 09:52:11 AM +01:00:00, Jiri Kosina 
<jikos@kernel.org> wrote:
> On Fri, 17 Nov 2023, Denis Benato wrote:
> 
>>  > From: Denis Benato <benato.denis96@gmail.com>
>> 
>>  I want to express my gratitude toward Luke for his guidance and his 
>> help
>>  in submitting this fix.
>> 
>>  I confirm those patches were sent in my behalf.
> 
> Luke, as you were in the supply chain of the patches, could you please
> provide Signed-off-by: tags so that I can add them into the chain?

Signed-off-by: Luke D. Jones <luke@ljones.dev>


