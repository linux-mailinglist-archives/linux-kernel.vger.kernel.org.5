Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814247E8007
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjKJSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjKJSCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:55 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F9A753A;
        Fri, 10 Nov 2023 05:49:36 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BB71C3200A2B;
        Fri, 10 Nov 2023 08:49:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 10 Nov 2023 08:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699624172; x=1699710572; bh=gr
        ojPZKgF7i4ycqWyl3K3qTSTs7COURoVDRKuNTUh/M=; b=nh4WX7/90u4Gme0x9f
        1uVVxdYgdkllPoE0w+fySPgMK1A/brPAhRGEvzdJOiAre58FQcJJVnwntB/kc05V
        eWs+EdPSM2+Lz/qojlylNUeTHuJEKb6T46VTozIyiN8tcTUSWSQEedKwKd0BzRVu
        qN5aQP2i1fnl3AXsYVqOQwRUMACE6F2vkqveUoE88YVXpUI0G6Rz0fvhEp+A4WhW
        EQiq7wQ7efxFk3caHmEb0/1usexPcla08oXwhJWnNezebKDTg85DiEFTQZsqi2G3
        NOem1u0/NEuC3W2uC170sYAuo5GGMfIFOqJqvij0zwjBbtVpH0kmHFHiEqfi0MIW
        11Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699624172; x=1699710572; bh=grojPZKgF7i4y
        cqWyl3K3qTSTs7COURoVDRKuNTUh/M=; b=iNLZwafpnPL0lFgVfmEOjglV4izfn
        7OjB/cdtwIolXThMkdjoQLesS7aYCyx9QBay/rlgZvC9rDql+8R8ur4x2YBRQizr
        +P8udFmmZfGrLb2qxKyjz7rGlrIaHHwD+Gt+2TS8CsOLJpuJhizRHjbtt6hk4805
        bzQmm6DCWJSmIEN4+vFIBoc68KrMKOLHVKT3EE2RRGlOfgLXhg3nlYaXu/Amk9q/
        TszC9qs4g4PSVXHr1aRHxG1J1leEmQX/va329eada/7QatpQ/lGcmD5PDgXl8qou
        9LfieCPTrNRoFNljgOj6+1DyCZyZTSu8SGSKgdSx7xspDu1eaAajnWrkA==
X-ME-Sender: <xms:7DROZZ0_hgUG9L4dTBBXenyfWx4sBzXAuBwmIUSK985PlcUXD-J_jg>
    <xme:7DROZQFAAgqfWQ7jUzmqywdH5YmZOdyAmPIHx2EzPCawsT0Ua-aPIGX2MCdHcvgKI
    q59hcQ9XW3pouqH_Do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7DROZZ5-wh6otOKEuk4WIgfKBHPe2YcYLyyykC_5qqtB2AQj_SjXAA>
    <xmx:7DROZW1JHdnintBg4QsvWRFflXTgNHN_Z8s9hG4UjF4tayflPIHgjA>
    <xmx:7DROZcH1LzQgdRlgQoaRgJy-92gyXyBbdwU1VorEHz1ybICdzeiIMw>
    <xmx:7DROZYgLrQQPJDF_WrN2dHalA0rkpc-vr_CPcThEVWYSD2u8Fox7_Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0AEE1B60089; Fri, 10 Nov 2023 08:49:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <13bb798d-0631-4b89-ab28-2c3ef78847d8@app.fastmail.com>
In-Reply-To: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
References: <20231110114400.30882-1-lukas.bulwahn@gmail.com>
Date:   Fri, 10 Nov 2023 14:49:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Helge Deller" <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: drop IA64 reference in VGA_CONSOLE dependency list
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

On Fri, Nov 10, 2023, at 12:44, Lukas Bulwahn wrote:
> Commit e9e3300b6e77 ("vgacon: rework Kconfig dependencies") turns the
> dependencies into a positive list of supported architectures, which
> includes the IA64 architecture, but in the meantime, this architecture is
> removed in commit cf8e8658100d ("arch: Remove Itanium (IA-64)
> architecture").
>
> Drop the reference to IA64 architecture in the dependency list of the
> VGA_CONSOLE config definition.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the cleanup,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I was aware of this one, but decided to keep the vgacon cleanup
in a state that would independently work on ia64.

    Arnd
