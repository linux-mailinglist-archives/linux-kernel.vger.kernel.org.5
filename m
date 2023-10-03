Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD57B6BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbjJCObr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240160AbjJCObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:31:44 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4732EE;
        Tue,  3 Oct 2023 07:31:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A76633200B2F;
        Tue,  3 Oct 2023 10:31:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 03 Oct 2023 10:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696343500; x=1696429900; bh=dM
        XDSvzT9i1XLEOVuOSArS3v51cWnf3onHEUcNZ+RVs=; b=OgRJ2Bm8qQyKh8j44t
        yi7YTuKzDJ4pL2MV0u5IeNs3aiGmJhLnwJrQQViciE7m3yEGHF2+T8Q4+t8Vqn8c
        bRBqULbygN5ocOYcvkTz0prHjSbcHFEC4W1dQDcGPWrh2686aL7mD1N1szXLk67W
        BSq7+WZ25XxUjJTuiLOkCtu56wCwcIa9LijKsIBGCJAwOdLNifAuXW67qJXTkJPI
        OjpfiNc4mX7CWYhEp8VZB3k00lXLciCkiIXgYIQJ+ZfNtipOHlbsNvK7pL9NtJCQ
        BiaqdmrXJzdDdzXm3XgdBSHSxNjaOhhPFK9HYPLyMAGSdRcpdgD9VdYlhwqF555s
        j8YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696343500; x=1696429900; bh=dMXDSvzT9i1XL
        EOVuOSArS3v51cWnf3onHEUcNZ+RVs=; b=FgHftRoNuPyr1DkdGzJJLF2HYgaYn
        CNXIRMLHdTUxQwfg3jpIN0ymx/+QwBhRHgP1gd7h5OmbgYBUWjKES8BJaOoE6C51
        N3WfSrfiNwSHxfi+OhSVr0aFmd4HtK6OiOgkWpguIbU26QcEPfSk4LNt9tzNA6OI
        pzutsRsHJI4cgXIn/9KHiML8csOfVZg5rstMoouvhjsiecfPc2FUYm1aDaP46v5+
        XTGX0xyer3kzOtpiAE08dLT+nfMpL1wwcsbHI5WnaA3oRJymI2F5LACFlFl+MJyy
        r1iGR1bfjyx+LSFLCuLanUWbogvkmROpBXQggC91a3wqA272z8/DyaLsA==
X-ME-Sender: <xms:yyUcZQOM7Pvp9gRILvcWQj0qwg19ALx5G7cVdHlZ1YcW79ksxSC-0Q>
    <xme:yyUcZW9rPL7fy8GLvDwCo0hWkUT0DwIOU0rpksw3BEnceKXpQptGQYzn88VHoza0h
    x4_B6y5Fi9gUUByvBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yyUcZXTQ84s-8rnuvIVEpvwmfxA4-3Na9MKUAK8HnqMiKuGcU-wDNg>
    <xmx:yyUcZYtl66ss13vLO0Jit0mmQF78UtQR20MK0YRK9NGCa5UfJcjT3A>
    <xmx:yyUcZYfi3BKR3dMknJiTln-dZs_mINKHaIX98_1yOxw0Cyr3MBVmpw>
    <xmx:zCUcZQ5Mhz8pwB3wObSQbs0drADO3cPhmudxzd_vrnIldU_Nu80POw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A68E7B60089; Tue,  3 Oct 2023 10:31:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <e076a52f-8aeb-417a-8093-362d36573f8b@app.fastmail.com>
In-Reply-To: <50f32be6-ccbe-42b7-81bf-7509da400ba6@linaro.org>
References: <20230929102539.42b11f3c@canb.auug.org.au>
 <50f32be6-ccbe-42b7-81bf-7509da400ba6@linaro.org>
Date:   Tue, 03 Oct 2023 16:31:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Olof Johansson" <olof@lixom.net>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the samsung-krzk tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023, at 08:22, Krzysztof Kozlowski wrote:
> On 29/09/2023 02:25, Stephen Rothwell wrote:
>> Hi all,
>> 
>> The following commit is also in the arm-soc-fixes tree as a different
>> commit (but the same patch):
>> 
>>   471eed5ad217 ("arm64: defconfig: enable syscon-poweroff driver")
>> 
>> This is commit
>> 
>>   d75e870c32f6 ("arm64: defconfig: enable syscon-poweroff driver")
>> 
>> in the arm-soc-fixes tree.
>
> Hm, I did not expect this going through arm-soc, but no problem. I
> dropped it now from my tree.

Right, I was a little confused about why you sent the patch to
soc@kernel.org and had to guess between applying to fixes, to
the next branches or ignoring.

I should have asked you for confirmation here, but ended up
just merging it as it seemed harmless enough either way.

     Arnd
