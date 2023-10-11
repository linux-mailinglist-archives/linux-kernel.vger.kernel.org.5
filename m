Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947517C4E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbjJKJCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345910AbjJKJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:02:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D986E10EC;
        Wed, 11 Oct 2023 02:01:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 74E315C0286;
        Wed, 11 Oct 2023 05:01:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 05:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697014907; x=1697101307; bh=DE
        xhJxe6pAvV5eiD/1fwWplvOVteEj7vs73QB2WI/+8=; b=cGAQWZnu0g1DKpMsdQ
        nwOEGFS/BLPM92HbcGgu7MQ9JHtP6bD0YjbJ+0sKHLKR5nnPPTQMEZFeaJtqSfTT
        CT6t5BfH67Mk5GjgXaSeJfZUbcqy93H/bgS6uuEiOYd2b1oAKhwI+iRmHvhS0CDa
        Bpdho81qZDtTuMK8n639b6GK8U1OujeOqf/wLkxj7I9SfWI4D7TgmzzYdil0fxX/
        je/43bHzgJROy6ZELUx8czqbM0fhpcqhRK2L7n9WXsd5qHs7/K/havp3dfvryYT2
        fAKctxjk6Fkp6FSLGceZ7mYO94VKDqRGAqlPqcWZ+D4FIxQclNkNNRjbIZ5pYY5j
        s6jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697014907; x=1697101307; bh=DExhJxe6pAvV5
        eiD/1fwWplvOVteEj7vs73QB2WI/+8=; b=mkiW3Emb3vdKnJhx8bwy1ZihSQQq5
        weJSue0zdVPKOYp+zbo07jpwpfsgdMXsXTL1G5GiO8FdIYYycdkfVJl6823/uvJL
        DmGZSrI9W4BxVKbwuWKHcmu6jfbY7VIqvGOOyya5XmkRLL+A3Z+KYer5/4p05hga
        dTqUXWAfICNO4a2UBjF/UKeGiXOSQMG13/lFoCbjlCdRF6mkpBVe64CIsMAUwJre
        /NvHX6+RvX5k08u6UD9HuXfqNs2dYU0lpKyI5me4gldF7a9EdjHyLw8nj8shaPkN
        l4005mZh+rO6o9hr24wTV2rC4VpCLZFZBWwQd8VZ49kKhppmoXKFVmTGQ==
X-ME-Sender: <xms:emQmZX7arryhpAE7MpSUqgHmfJELkAPTSDSR7EXG7nLaRLcgpIcA8w>
    <xme:emQmZc5X3mZ1PfyCiipbsxv6oe4ASx9IukAhPSsewSEOC22hhTciit5rOLQBRU9i5
    Q7l0a8YW5HJ4e5Siz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfegfeef
    heenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:emQmZefO1hwrftI7xsKAB1Rej1Kq5sNhezSDoh8HzoAq0qF6gj4HnA>
    <xmx:emQmZYIOMZnyDA_UM5JV4wdz0g9u2rox0vFXQsDagmTv49e97s2csA>
    <xmx:emQmZbK9B6Woc8ZHsNwvLTLHRfJEc6E4PYLC5G3xXVIxAlzHUTAMhQ>
    <xmx:e2QmZYAggTvDdM3nzrT7LybqMgVeindjS90MzkORb3LS2gPJ19C4Vw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EC58B60089; Wed, 11 Oct 2023 05:01:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <f5243ad9-0e7d-4a2f-b944-a45c41330aaf@app.fastmail.com>
In-Reply-To: <87r0m14khb.fsf@kernel.org>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
 <d081871c-977c-43e9-afa3-a3c3e5880fea@app.fastmail.com>
 <87r0m14khb.fsf@kernel.org>
Date:   Wed, 11 Oct 2023 11:01:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kalle Valo" <kvalo@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-wireless@vger.kernel.org,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Pavel Machek" <pavel@ucw.cz>, "Jakub Kicinski" <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023, at 10:44, Kalle Valo wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>> On Wed, Oct 11, 2023, at 07:40, Kalle Valo wrote:
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>>
>>> We (the wireless folks) have been talking about dropping legacy drivers
>>> on and off for several years now. The problem is that we don't know
>>> which of them work and which not, for example IIRC someone reported
>>> recently that wl3501 still works.
>>>
>>> Personally I would be extremly happy to remove all the ancient drivers
>>> as that reduces the amount of code for us to maintain but is that the
>>> right thing to do for the users? I don't have an answer to that,
>>> comments very welcome.
>>
>> I had a look at what openwrt enables, to see if any of the drivers
>> in my RFC patch are actually enabled, if anything supports legacy
>> embedded devices with these it would be openwrt. The good news here
>> is that openwrt intentionally leaves WEXT disabled, and none of them
>> are still in use.
>
> I don't think openwrt is a good metric in this case. These drivers are
> for 20+ years old hardware, most likely running on really old x86
> laptops. So the chances of them running openwrt on those laptops is low
> and I would expect them to run more traditional distros like debian or
> ubuntu. But of course this is just guessing.

OpenWRT is clearly not a good metric for laptops, but it's a good
indicator for embedded systems, in particular those with wireless
access points, and it does enable a lot of them
(atheros, broadcom, intel, marvell, ralink, realtek, mt76, wlcore,
rsi ...) depending on the platform.

I can also see that it used to enable airo, p54, hermes, adm8211,
zd1211, ipw2x00 and libertas but stopped this a year ago, see
https://github.com/openwrt/openwrt/commit/a06e023b4e12

     Arnd
