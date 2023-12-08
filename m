Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2880A4F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573885AbjLHOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573881AbjLHOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:01:50 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9510F1;
        Fri,  8 Dec 2023 06:01:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DE795C0216;
        Fri,  8 Dec 2023 09:01:56 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 08 Dec 2023 09:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1702044116; x=1702130516; bh=Z9ynEAkrg/+eMjxJPXx+Xw+8bmkv5ohlA9d
        VsbXtH/c=; b=JTdvDXVsGI1aATkJ95b7NdQSr8RyzlHSjUmzJDwADM27Ix9wWDQ
        nODEztUbbKodHdkZjx+tvveHPHUmTmd9D8+IsD1wX1WsN4s/UdOQ2ziud7IHG7Dh
        A5IRrgaJTOjpjMdzO2eSJG7O0UdKAVSDaD8sqvbb6WkHjz1TdiMnbswyvc9wEJl9
        4V2gfV/rKjPXyKsjFoNdbzhCgD4cnN6ROUWVZLl0jHVclTWdtGsUcpVSz7LXyZT5
        RG8qK10QABkcihw0YJRY63ajQc6fGIwROBwRYUe0MzhhjcYBDvBw2h3docaxcrhT
        boTo6znW3hEDgf4VueeoSwGq/5Zub2Aiu4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1702044116; x=1702130516; bh=Z9ynEAkrg/+eMjxJPXx+Xw+8bmkv5ohlA9d
        VsbXtH/c=; b=Van1R8yjlEa3hlztojgbbKQ8czE2TDrRNFaJOl304wVxZUvmMfI
        yFNw197FG5QthWnMeEo1PloZ/xmsSczo8WZzunz9MlA+j3OHCYmySLHRnUnkokkG
        T0zZBH8abXAjq1FZitK1BclsKYwCbU/AnMbxHQow9ncWghvdziRMqm7rB8Rujgdi
        OZK8+dnYn3OakR7BC3e96i1cVO70IXiFG7i/Vg0jlp9cjYxlV3NS3OeaIba3u8+m
        m7Y+C+jT89HaWua6W+VrdVMmy3oAJj+n7F3sODuRVbU4ci/1YguW58znPbAk5EBM
        YJM1fHO0pXscN7gHOOy3g+hG8M4pAXTddCQ==
X-ME-Sender: <xms:0yFzZSlmX6U9eSI96D8ZUnknwuSiDAnZ6VK7-QFhgdYduQgRSMjF-A>
    <xme:0yFzZZ1xKSOwQNHyYSbjhE0HPtWsBWpZ0p8xvEWbtj63b9bTwREV_CJTbb2l996mm
    PJb6gPj1M2zieWFLg4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:0yFzZQrG1A4Iaw4pwozPzMAqVg3bY9DE9NEDprQZi9szCTp-wC9WRw>
    <xmx:0yFzZWm6oPzA1Dw2CX6B-PR_4AqV-UwhQPIpHMJdLx31wZDT9zjebg>
    <xmx:0yFzZQ15-RqH6NccG3kPpdZU0F8aFW2l5iktN7o20j-92wl1fdakPA>
    <xmx:1CFzZdza-o9BYzQzbf3KgGNrVOwa_9PMiFlORCbQWLLJ1pFquI6dNA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B1281C6008B; Fri,  8 Dec 2023 09:01:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <1c4ac4ba-5648-4404-8253-30ea19796762@app.fastmail.com>
In-Reply-To: <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
References: <20231206162003.92010-1-vishnuocv@gmail.com>
 <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
Date:   Fri, 08 Dec 2023 09:01:35 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Vishnu Sankar" <vishnuocv@gmail.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "markgross@kernel.org" <markgross@kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: fix for incorrect fan reporting on
 some ThinkPad systems
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ilpo

On Fri, Dec 8, 2023, at 5:53 AM, Ilpo J=C3=A4rvinen wrote:
> On Thu, 7 Dec 2023, Vishnu Sankar wrote:
>
> Hi Vishnu,
>
> Thanks for the patch.
>
>> Some ThinkPad systems ECFW use non-standard addresses for fan control
>> and reporting. This patch adds support for such ECFW so that it can r=
eport
>> the correct fan values.
>> Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
>>=20
>> Co-developed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
>
> If Mark wrote any lines, his Signed-off-by is also required before you=
rs,
> as per Documentation/process/5.Posting.rst, this is a hard requirement=
.=20
>
> If he only helped towards the right direction/solution but provided no=20
> code, I recommend using Suggested-by tag instead.
>
Ah - I didn't know that. Thanks for the clarification.

I should probably be a Suggested-by here. I've been helping Vishnu with =
the process but he's been doing all the hard work and writing of code.

Mark
