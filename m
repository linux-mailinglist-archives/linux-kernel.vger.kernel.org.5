Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B87612E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjGYLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjGYLGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:06:19 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A462B1FF6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:04:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E4EA63200934;
        Tue, 25 Jul 2023 07:04:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Jul 2023 07:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690283066; x=1690369466; bh=xl
        DF8mFO1wJZNZ9a4la++XDvgyFsLfdjgR2/AFsPdEE=; b=OFk/ukB4+sjE46Hgz3
        HaBAQIfszpchX7UNJKNgXuzSY2uBIDkXctJ2wANWAhTomzZdDYv85liStiLNBKS1
        1+jspCZ6qRdo7qmR7cgSHQsSiuXtqNcyyyUmlXL/mn3o5Ex0jKrVzvgFKyJlO6Me
        RBdlsjdDPOAqWX84g30Wz9aJx7uBbOWzT5jQ1bRIl+8dd4l5zc/0iwgQuoYPoYRp
        LJG+NFmYeu8ALViZ6yjttBoHzKoj519CewNZCapWS9k2oI/AqhFHKEGwQgZOzqy5
        nUnqLZF9HlWBrff4uBkv99GahAMN/IYFitu3rfVchYspi08ufApVVmphO2dbE5AN
        ef1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690283066; x=1690369466; bh=xlDF8mFO1wJZN
        Z9a4la++XDvgyFsLfdjgR2/AFsPdEE=; b=UGvN+pGdtDA9rin8RAaOQoQ7U967e
        IY+scAkc1mkI7oNjGgpgFc9D7MQQKCjoAPcW02aAGCXsPsMBziQ+uDewPD9jj5sc
        6d+TPapwja4a/2XXLEVd72LE6fFsYsbsgiaOiT1DQVX9VfV7vAgQfY6wILA48np1
        XOmsfJp6SiNztg7Fx9Svv4Ct4rjbZ71rRtcwnPKf6+3+k5c89o2Y6o4+q29O60aq
        O0bUejDTzbrOavfyVXRdVW+6ckY1bkjybYz/+Q6XvzjmdLQjGOIEOSvyyOY/hzGP
        GULx4p+eMWWWk9uaHMMXS5ZAV4kkq1aYzSdnGx6JeT/bpVX9YYEJJJgkA==
X-ME-Sender: <xms:OKy_ZGTg2zBMrIOf1701A1UOFD0UmAlzwk1Q-wQSp6gmx3bbOeDNww>
    <xme:OKy_ZLx-XjWp0j599S7T_-p7sA_HAlucZ8D7-tJKK1ZpQ-FgE4Xw_pxGJAYt6FqED
    4sjo8AGWZSVP7bn-Ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepffegffdutddvhefffeeltefhjeejgedvleffjeeigeeuteelvdettddulefgudfg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OKy_ZD02yXMUZrqkTHntKgg9_hBJZvSry1nYxOoVcUHCoErEhbnGsQ>
    <xmx:OKy_ZCBShj6x9ww6X-8wfGqLkDP_GIn_HpfngbJ_d9WSuhICZ7Ai4g>
    <xmx:OKy_ZPh7vf5K4PVjJFpO4AIEtWAm3HFI8u4ITuZdQuWsI6ujDEj6RA>
    <xmx:Oqy_ZIbvsqESvYtJjLVzak2nckFiM_eyEvN4AeZjRRm4LZX0uQwn4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B91C3B60089; Tue, 25 Jul 2023 07:04:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-590-ga55e740577-fm-defalarms-20230718.001-ga55e7405
Mime-Version: 1.0
Message-Id: <15856411-660f-4591-92a8-0d4470fc17b9@app.fastmail.com>
In-Reply-To: <20230725105346.1981285-1-u-kumar1@ti.com>
References: <20230725105346.1981285-1-u-kumar1@ti.com>
Date:   Tue, 25 Jul 2023 13:04:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Udit Kumar" <u-kumar1@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Nishanth Menon" <nm@ti.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        onrad.dybcio@linaro.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        "Peng Fan" <peng.fan@nxp.com>,
        "John Garry" <john.garry@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] arm64: defconfig: Enable various configs for TI platforms
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023, at 12:53, Udit Kumar wrote:
> This patch series enables various config options needed by TI Platform.
>
> bloat-o-meter reports after this change
> add/remove: 4/0 grow/shrink: 2/0 up/down: 1592/0 (1592)
> [...]
> Total: Before=27997071, After=27998663, chg +0.01%

This all look good to me, I assume Nishanth or Vignesh will pick
them up into their git tree and send them to soc@kernel.org in
their coming pull requests.

    Arnd
