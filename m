Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13983754FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGPQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:32:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33518D;
        Sun, 16 Jul 2023 09:32:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F2A05C0077;
        Sun, 16 Jul 2023 12:32:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 16 Jul 2023 12:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689525165; x=1689611565; bh=A+tvdRKwdX+WeVQUPv6fO8IIiv2UhaqZMsA
        F7ADDL9I=; b=O0mNPHSN+o54d7wQFryJSPOVdUD5SFhQxV/Moxu+y6BjeZbvL2Y
        Cv9h75LVEePVhI/mJ+PKFuR1tAD/pbNHKlb+NqGJBugS5B+sq1Q7l5JiiU3dTsWs
        wW6170Rg4n032B9IlOn/wEd0RAa0hTJUJZ2PvwiEi3FBPlG6/NW4RPGMqJ8BmJAG
        JV+70nR/D6+e8+2LYsHvwTS8Vh/v/1tXNgSTc++UIFQupfc8GHOQVCsKYOefsuJF
        f2+J+EhhdKTwjPQ0cSsnIDomX3sUdRsNQmwmxbiCl5aIlkFrQgb6E+N5Ca9cBTpS
        Q864DAQgvpQHFZ5qBiv9QCumwn+96+Eq/QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689525165; x=1689611565; bh=A+tvdRKwdX+WeVQUPv6fO8IIiv2UhaqZMsA
        F7ADDL9I=; b=OjWm1uesvUzF1BcepDPInpE3Z18QDC+e9qWEMIFepQ0E2FwIrJu
        q6axm8AeKZoqMc2/R0O7uJoaAHm+avxNbp4bCp+e7dHBf830WjRhxd0GFbrGalIP
        ravHEQPhq4JZYv+d4AmyYQm/GDzhSccg8yMn0ECmQz37ZMB/JvhitQmeT+iu7g+5
        EQ0qiFqQN8YhUtHMWr2hL2clqyBv5ssMK9WWrxie6CiFqJoiXC7pgX+zmP9tHhbB
        vYgys1lfOQpFDn087y2tY2H2+RyoNcblp3oMIpCSuYWl/4Nh3mAnjUO+GBC0QiJ/
        lBLaJCJVbQ+mqmdLrlk+ELs3sTLcgNpHkGA==
X-ME-Sender: <xms:rBu0ZDneAMflJT4qF_N6TG8ltoEdsPPlvhKCC5BalnvvpP7UGcXY8g>
    <xme:rBu0ZG3whxW0xo1KYTWIEO6LAPxldfGtys_OHoA7dAIlvrnOSBJEanfo-apqtbAfC
    ilLH0ZgrcHkFw>
X-ME-Received: <xmr:rBu0ZJqkv25NHfFLIPK5exaOrYxvZkGhrtTP9okTKWppso18PN0kpOK5BLF27O1cSYnJpybhGPpkA0iaXrwH5ELym2ylVcdRP1stwILenY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelhe
    ehudduueeggeejgfehueduffehveeukefgkeeufeeltdejteeiuedtkeekleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:rBu0ZLndVuQ_GvIlMAs21rJxMLJjUiYAS9jFYaPZWnhaBvEJI1TDFA>
    <xmx:rBu0ZB1iAFUwyhUn6V3DbkgpQnTH3R2l1wfg3KMlVOIrPyBPCwMVxQ>
    <xmx:rBu0ZKtw8qLlNX7P0w9T28TTwbAcrVvs3SQufd64_pu2ZeCUuTOTQQ>
    <xmx:rRu0ZKLnaCuSqolPZ4AD9KIgIzGxFsQTcD0KjPRaDowi8sKT-qV5sA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 12:32:44 -0400 (EDT)
Date:   Sun, 16 Jul 2023 18:32:42 +0200
From:   Greg KH <greg@kroah.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Backporting commits for generating rpi dtb symbols to stable
Message-ID: <2023071644-earflap-amazingly-3989@gregkh>
References: <20230716162444.zzvkm4rh7s7lu37x@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716162444.zzvkm4rh7s7lu37x@pali>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 06:24:44PM +0200, Pali Rohár wrote:
> Hello,
> 
> I see that raspberry pi bootloader throws ton of warnings when supplied
> DTB file does not contain /__symbols__/ node.
> 
> On RPI 1B rev1 it looks like this:
> 
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> dterror: no symbols found
> 
> Bootloader also propagates these warnings to kernel via dtb property
> chosen/user-warnings and they can be read by simple command:
> 
> $ cat /sys/firmware/devicetree/base/chosen/user-warnings
> ...
> 
> Upstream Linux kernel build process by default does not generate
> /__symbols__/ node for DTB files, but DTB files provided by raspberrypi
> foundation have them for a longer time.
> 
> I wanted to look at this issue, but I figured out that it is already
> solved by just recent Aurelien's patches:
> 
> e925743edc0d ("arm: dts: bcm: Enable device-tree overlay support for RPi devices")
> 3cdba279c5e9 ("arm64: dts: broadcom: Enable device-tree overlay support for RPi devices")
> 
> My testing showed that /__symbols__/ node is required by rpi bootloader
> for overlay support even when overlayed DTB file does not use any DTB
> symbol (and reference everything via full node path). So seems that
> /__symbols__/ node is crucial for rpi bootloader even when symbols from
> them are not used at all.
> 
> So I would like to ask, would you consider backporting these two
> raspberry pi specific patches to stable kernel trees? Upstream kernel
> would get rid of those bootloader warnings and also allow users to use
> overlayed dtbs...

What kernel tree(s) should these be applied to?  What trees did you test
them for?

Also, adding dt-overlay support does not seem like a stable kernel fix,
as this isn't a bugfix from what I can tell, right?

thanks,

greg k-h
