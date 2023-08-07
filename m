Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E4771C95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHGIuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjHGIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:50:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9F172C;
        Mon,  7 Aug 2023 01:50:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C466C3200488;
        Mon,  7 Aug 2023 04:50:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 07 Aug 2023 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691398231; x=1691484631; bh=YL
        Ri9Jr7Tv7drpzqdM4IzTgfdOzKrx7MwYuIVl7RZW4=; b=hPjxxQkNp7FpX8Qgl8
        JBv9U/y7m4x++q5jrNgWqs9Szm6XSiVECZ9L5dLp1YBp7KG4VfTVvwVbqdqNgH/W
        RwxPmO5FnAu/BGUpqs0BjUVmwwvP3GH0hKQ/PXxzDiRoSIa+ts3bSLJR9QPIuAIy
        E+9uBhUWn0CkdefMuyyF2VxLnNttUaDngPTi6eI2/ScN+2WyCtn306d7bEcc0DnR
        57ByeRsIAEU19Y/hFakR5eMDixp/x82dsZo6EpbfW+h2cmRw63voqOnTTNuRj11H
        P/+tgWn8fK0X80sIXm/Rs8KoUwxF+WmPVnHTZkDOEDCHgOtaZQeS2kk4ZgHi0cow
        Q6iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691398231; x=1691484631; bh=YLRi9Jr7Tv7dr
        pzqdM4IzTgfdOzKrx7MwYuIVl7RZW4=; b=RsaJegANv0MVF6WXY6U0k2E5sh+do
        IQBI9p90JE0Iu200MgXepOQnP5uKV113/Jx8ygsAfWBLeVFSm4WNTEeRHj3kbGkE
        ftNQKs9BNQ4XV5xFvpcDLTko3BZ6L/HxwJgq2IJXu9ZGcmoViXCeyZuSjFDBK67z
        W6SrvIKtcgqlcuKmO9XmSsz/Tfj1rH1SBCJOGvkuZ1ieh2Si8t9y1yCObBn4zSgu
        WexUBqYG5q3m4XfUVXLazACqMrz0+AshNBE8LgwKVEvC6HnxBxboKyIiGseKpHUm
        feFIOtd6ojQQ2LoYwS1mZ+Fg88uqx5YChmDKAw+yZP8sP8WBqphaN7G7Q==
X-ME-Sender: <xms:VrDQZI3hYFMpZ4OeKwGQJ3ghr_GE6cKYXVJUYMFda2ytR9i6OvbhSA>
    <xme:VrDQZDHT1gYje4VHpB1mUiyrYT-tEfN8tz-9q4d3bVRI6FpVDjMdEcBF0w78K71qB
    NmQda5y1oJeS5sWnO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VrDQZA5KwhHBpfE5z8MPfPtMagLuEomZp3P_lpmZA88ou4E9QfpNTA>
    <xmx:VrDQZB2IDcwNKItRqh3_l9cWHIQrn-0Ptg9shErYR60XlpHzuak9mg>
    <xmx:VrDQZLHGDOdN-fq3lY-vxyv11MFTF6AMD77Ma30UbYy1AzH5uekQYw>
    <xmx:V7DQZK2Lz25uHRYtv74YU2tA-YBSCczwXUPjWnGtxjM9y9nA1aNoZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D6936B60089; Mon,  7 Aug 2023 04:50:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <407bac4d-eb57-4984-ac45-aad6b7d72762@app.fastmail.com>
In-Reply-To: <CA+G9fYsnoxm82ik3YNs_qUdZkxkNmVrknhC+ezqSKrEx6WxJ7g@mail.gmail.com>
References: <CA+G9fYsnoxm82ik3YNs_qUdZkxkNmVrknhC+ezqSKrEx6WxJ7g@mail.gmail.com>
Date:   Mon, 07 Aug 2023 10:50:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     "Anders Roxell" <anders.roxell@linaro.org>,
        "Michal Hocko" <mhocko@suse.com>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        "Petr Mladek" <pmladek@suse.com>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: next: arm: kernel/watchdog.c:521:36: error: too many arguments to function
 call, expected 0, have 1
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023, at 10:42, Naresh Kamboju wrote:
> [ resending in plain text mode. sorry ]
>
> While building arm mxs_defconfig with gcc-12 and clang-16 on
> Linux next-20230807 tag the following build regression was found.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>

I sent a patch when I saw this today, and Andrew already had
the same fix.

     Arnd
