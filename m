Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7B773B44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjHHPrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjHHPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:46:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DE3C34;
        Tue,  8 Aug 2023 08:41:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4452B5C005A;
        Tue,  8 Aug 2023 03:55:05 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 03:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1691481305; x=
        1691567705; bh=J/IA1zqHqkiiLAD9E9JcF57MbkkOt6dgvLaok0SXp/o=; b=Q
        hCNFgWfjmdIMFirny+vegJe9Ck01gJPMBgR80BP6RGvB/H5YLwr5llmeK29EjUds
        K97Nr5ABiDSzOMF4ROMXyeUEDr7iEu5wZjJ+EzwxQFDIshLH+MLWpy5oEditIXB4
        LzIcncxcFBtTq/JXP4ZIJ7xLJVNoMCTeSkvgAcpokvABIonfCXPT2nd2WmvkExlU
        iI2dhv4IdR0Kcsr9DIV3JpNlwGpyjelcqaVl3MRGYLg49tuVEXuiHiCNzJnxqcLs
        jKKMsB6DoyHDLg9j/vWOfUit0oiY3NMg1DTIkSCXquQtCsV3ms+RJTzuS6FfTyfp
        QZVzwLFXK+m44KGrF4x1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691481305; x=1691567705; bh=J/IA1zqHqkiiL
        AD9E9JcF57MbkkOt6dgvLaok0SXp/o=; b=XfVWeYL2WYtYTHGoCrpemnxP3vLlM
        HtsTFy/FVVE22v0MLwMSucT3QFgAJcsSByQRgQHy2D9r4BnAOzEd/6u+OtZqaqOk
        hhgKAx1K9p1+DhEGUd6GbphQk6DEghT4BLzVvwiZRdIhI+Prl5+CRZtrEesSlcdl
        Pw5ElTvmSuy7MEb6Q5EuIWJ23rGmsZFX431TAL9rP5PyS4eCzFbqLHzGKDSuCrNp
        mSLrze3z6hscieF0S/qa2dhKiZkIQi/nF4rqvZGaTdxhEXnZLW066SMCJd39D2fh
        lu5dluAxhRY432M8xYsIKVFMHDHulzkhIqfNnFXcwyTBCMLUQfmfXNhMQ==
X-ME-Sender: <xms:2PTRZEJb1FjWcaPf2mP6AWtHE11tsyqqJb2s-N-KPOwbnhwvu7hsfA>
    <xme:2PTRZEJDNkF4mzyJiciL7itc9AnNmrXi7EUYDMlrLGOHkq06EF15DihjwTXg9s8sF
    AOOxF4nfUn1uv3uVpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    thhhvgifucfotgeurhhiuggvfdcuoehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
    eqnecuggftrfgrthhtvghrnhepheeitdehfffhudefheefffeivdffjedtfefhueffgfff
    geethfeivdetjefhgeetnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghu
X-ME-Proxy: <xmx:2PTRZEtHwLgD_VGn0dovKlZe1Dd310qFvfvKjxNcBFsID2AXRttmZQ>
    <xmx:2PTRZBYp83GQIz_w26WjxFJrRATNIQORFRU_-wvqLbz-SVhFfd7wdQ>
    <xmx:2PTRZLYG_iu_qwLOETA2hPVnGhDHFa-XVVI_KpPygcxKhWziRyioUA>
    <xmx:2fTRZHEL3a7SIS2OIR9_9n-NCn7oTJgC3SqsUenRaUDqN-rqeTcANw>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88388234007E; Tue,  8 Aug 2023 03:55:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <b84c2fba-1bbe-4842-a861-525784d8a361@app.fastmail.com>
In-Reply-To: <0248d597-b72a-5b7c-63a4-6d72384f9854@kernel.org>
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
 <0248d597-b72a-5b7c-63a4-6d72384f9854@kernel.org>
Date:   Tue, 08 Aug 2023 17:54:41 +1000
From:   "Mathew McBride" <matt@traverse.com.au>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Mark Tomlinson" <mark.tomlinson@alliedtelesis.co.nz>,
        "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: Add driver for EMC181x temperature sensors
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Aug 8, 2023, at 5:38 PM, Krzysztof Kozlowski wrote:
> On 08/08/2023 03:31, Mark Tomlinson wrote:
> > This patch adds a HWMON driver for the EMC1812, EMC1813, EMC1814,
> > EMC1815 and EMC1833 temperature sensor chips from microchip. Does not
> > currently support the alert outputs.
> > 
> > Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> > Co-developed-by: Mathew McBride <matt@traverse.com.au>
> > Signed-off-by: Mathew McBride <matt@traverse.com.au>
> 
> The order of these tags is clearly not correct. It says Mathew is
> sending, but you are not Mathew?

Just to clarify, Mark has developed this version based off something I wrote a while ago:

https://gitlab.com/traversetech/ls1088firmware/traverse-sensors/-/blob/master/emc181x/emc181x.c?ref_type=heads

Hence my copyright is listed in the header.

I advised him to list the authors in that order following the example in the kernel's "submitting patches" guide [2] which provides an example of such a situation:

https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

If I interpreted the guidelines incorrectly, happy to be corrected.

Best Regards,
Matt
