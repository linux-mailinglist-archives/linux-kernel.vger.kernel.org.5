Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6CC802F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbjLDKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:07:11 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77821B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:07:17 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6E2FA3200A20;
        Mon,  4 Dec 2023 05:07:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Dec 2023 05:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701684435; x=1701770835; bh=UW
        5LflIU/OOxLg59NIfttj1JAi+IfzjY6M3NM0I8O6c=; b=zRcHGkzwjjv/KA6XRf
        pELHpqcJ92QcSfxbZgI1PcV+wKwhs0u48vFVxIb697VtKyKP1aBOM4wxvemgvMPR
        XZ6zeyufig+jxAYyyuaBlXBkj5av+ibnYF44MEDDh000LN4BqUjVB7unSB3nXDf6
        dpMNFf0CgkW/8kMY7u6LwDU3ySJ7ZSV19kVD7vrNrVaLOtDA3Nb4E6IUnCet6vCV
        Tof1IqjhmqY6qxnk4x8CG1XVVrmiU+/eR9OBBETcfy9+LjKmjzGRWMjslpEmPqx7
        qV0pvdVYOlUJ8gw63BbM62FwFOKSn4T4QbhDQ9TUW8xrQfyHi3EE5flq7EnCs0/t
        QITg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701684435; x=1701770835; bh=UW5LflIU/OOxL
        g59NIfttj1JAi+IfzjY6M3NM0I8O6c=; b=U0VTVN00SsxMeiq9fDxZwyh3tHtIq
        XPdATU8p9ZYmfAqdG6gxjhEoqtO+5DYX9oxj+Zgb+VdQ6hOZn+18C4UKKfAttjb3
        DBbRmNiuKiyt5XAhV0HDR59cmb5h/Eom7pqjVSD338L0Dg2kDItcDPJLRgWhQ5yU
        T+Xyz3Gd+J3Qp7TFNOyuRzcA0aNMRhYdwnDHVf8w8jdJlJiK1EZqpUc7Aiz22V95
        ov3hzdh88ZnxW9EPEtLX+q66aqrwiBNVpv2G63IQaS7dQ/BJEXSdrTQPOJ58TAT5
        vnst3yd+HaV3s2YESMZb7yxOLIBL3qhzvot2CIsYXrGm15+ckzjvEYsrQ==
X-ME-Sender: <xms:06RtZcMs9VD6wf3Uq-iPgx-iHdvpxcTn4_UhoDyn9ZR6AambRQh53A>
    <xme:06RtZS9dVWRNpy7w1_xWvz_Nb5WWdwIaNfmlbqr54iLQ-UoZ4PRzJW2qB0_A-jxCR
    MFPKQirDx7c1eVAZ-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:06RtZTQ_xQpY0QbY-RqgLQrTI73q4W-MWl3INxG8Fs52QmqiTQxsGQ>
    <xmx:06RtZUsNmG07zLKcrw1nRl91T8MfyBmfnTZJKQHWzMEbUuHeddD25w>
    <xmx:06RtZUfPFs1jo7K1keKqQJTlee6kWAhBOmsmPcoukHqo-uCI3MMEkw>
    <xmx:06RtZVreu2V14kZpXSd-6umIEEFrmYpQtqRt4t0RR08m3Lnh5p90jA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 36415B60089; Mon,  4 Dec 2023 05:07:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <68e519c6-8360-43c5-9364-69fadd56fa7c@app.fastmail.com>
In-Reply-To: <20231204092443.2462115-1-chentao@kylinos.cn>
References: <20231204092443.2462115-1-chentao@kylinos.cn>
Date:   Mon, 04 Dec 2023 11:06:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kunwu Chan" <chentao@kylinos.cn>, "Lee Jones" <lee@kernel.org>,
        s-anna@ti.com
Cc:     kunwu.chan@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: syscon: Fix null pointer dereference in of_syscon_register
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023, at 10:24, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
>
> Fixes: e15d7f2b81d2 ("mfd: syscon: Use a unique name with regmap_config")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
