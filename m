Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974027DABA5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjJ2HzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2HzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:55:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDA0C6;
        Sun, 29 Oct 2023 00:55:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B41935C00A0;
        Sun, 29 Oct 2023 03:54:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 29 Oct 2023 03:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698566098; x=1698652498; bh=/m50Y+rbYOe+/u+NuOlj6FwAWgg2Uvh6yTt
        Rk1Qprf8=; b=EkqDhVDJACNoU6wRzn66rAYv9DyqsUYEhPTmL/uTwO0gIhkg7Es
        VeNWJFRvbWHXo7KcMh0pbKzXrfPCl5XBhYTEtxeh+iY5VvYoJdadY16dJjl4pirl
        IiPP6o/hf4rZYavLMvBsiNcjX3ktJf442RyndcJANTxkH7e79FdHla4gzktrkC4i
        AMkms1rbmiqIDggDDEoDWImdzrF+W9xMjzXXKtwwQgA/zVd5dcAx2WIrgWl+IlMX
        GPCmLLi29uc85N4NxqsLvp5vOMVVIOa/Boap/geI9ufVKKjY+kCCVOdxztdGnjBm
        gIxXsJerURGMi/gZf0ipzg6OpwCK+lqV1HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698566098; x=1698652498; bh=/m50Y+rbYOe+/u+NuOlj6FwAWgg2Uvh6yTt
        Rk1Qprf8=; b=sizkkXF5DAuqb1Ca8YPHfuL4KHPCud1Q+ztptWBTUIXjBcywI4s
        biuKzELoLUxaIqF3PuLVklvlz20mgsK1LU0N9UI6+QXo2376zCIUR9EptHjDNLsx
        4eZCMzA+dGb1MBDM11SckZ4ysGDRyQ0m9DbGWn7tODf9uZEbJZ3GEY29Gf9Ezusd
        akiKWRFRqSUZ28m5DEuNjueeFHq6dKG/9AFussgbil41ISBUeYhSYmHMG0LDU1yF
        tAvuoOd2TMoDiyJREqgdvjuC4Z893R6DVmzk3dNs9CPy0HgbEUvSUj5FeefVHdgg
        NBJhpqJ3Scj+hgqL3Pa9Jgb4sO++EX8Lw6A==
X-ME-Sender: <xms:0g8-Zd4yL4AyyjAGdFTKoWmhzGW76z9N3m3QAMIAULyJsIeV33e-Kw>
    <xme:0g8-Za44aqwDsAP9_GmBpEVrBTmt5_0zGQFSriP_TKb7rEIkMG8mR2jhhlyX7HX6U
    CwSkmeGmxK8>
X-ME-Received: <xmr:0g8-ZUfO7vNnZEoiMRjASwBdvmAi3IdUFJQNzLnULA6VpVg1HHpz5BCYAngIuLIS3QJE9qlCbxtBBmjT4G-vy4bmwMN02AAntI3bZQiFSL_VA9vwqRwyzApa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epjeegkedvhfekueejgeefieejtdevledvtdelieevveekffejfedtvdehkeefjeeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:0g8-ZWIKWWogw_SlOaeWI-djtMLIfBNtxO3hx0M3ifVdOZsiIvLn5g>
    <xmx:0g8-ZRI82RECc4j7oEy2vxtZhyMWpv7kyzHPprq_QPz4-QFrQIMGdA>
    <xmx:0g8-Zfxb9UKxB0op8Zb7n4sjszIkETWPgJSzqwDZXUB8_0iiI4lq5Q>
    <xmx:0g8-ZYX5tNKDA9QkgJvGKtGSZzyC2JgdXRnY52cVOf31Hi2UmRa0bw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 03:54:56 -0400 (EDT)
Message-ID: <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
Date:   Sun, 29 Oct 2023 15:54:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill O'Donnell <bodonnel@redhat.com>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
Subject: Re: [GIT PULL for v6.7] autofs updates
In-Reply-To: <20231027-vfs-autofs-018bbf11ed67@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/23 22:33, Christian Brauner wrote:
> Hey Linus,
>
> /* Summary */
> This ports autofs to the new mount api. The patchset has existed for
> quite a while but never made it upstream. Ian picked it back up.
>
> This also fixes a bug where fs_param_is_fd() was passed a garbage
> param->dirfd but it expected it to be set to the fd that was used to set
> param->file otherwise result->uint_32 contains nonsense. So make sure
> it's set.
>
> One less filesystem using the old mount api. We're getting there, albeit
> rather slow. The last remaining major filesystem that hasn't converted
> is btrfs. Patches exist - I even wrote them - but so far they haven't
> made it upstream.

Yes, looks like about 39 still to be converted.


Just for information, excluding btrfs, what would you like to see as the

priority for conversion (in case me or any of my colleagues get a chance

to spend a bit more time on it)?


Ian

