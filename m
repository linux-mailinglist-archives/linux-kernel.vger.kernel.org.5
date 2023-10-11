Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA87E7C4BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbjJKHZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344185AbjJKHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:25:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E248E8F;
        Wed, 11 Oct 2023 00:25:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BCB445C03D8;
        Wed, 11 Oct 2023 03:25:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 11 Oct 2023 03:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697009116; x=1697095516; bh=kD
        hqZEcn+/X4jJsIF1cxUsHx79+GqJ1Tu21mo+Jtftw=; b=Q9gryz4W/6jNfDE6H7
        11iqTSBnZENqF2lzY3vIXi2SgXn4/LQ5T5qLj8SvhrBukJE0Dd5FEvNd4UazkV6F
        JjXfZgxi1dQV4sWyBxiZUQ2S5mccbkOWN87Gm6UC6TYH4VFRoTHtpVhEaczohFsf
        nubDPMJ/59ecWdOxTfAsAU1fYNFCoS1zgkLeXcWWpPwOUc+tokdCmjy9ruAa5Soc
        mcKjwAez262RypTHxGRTkPKNfNWXgqQ/5xREvFvFHj6uQzup9iCAyX0P0PXapoFo
        4gxiitmVYroLF31Ekn+u8xpNelj//SAcht0QjwdjseShhd1eA0P2GvH3Qcv4luuL
        bcbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697009116; x=1697095516; bh=kDhqZEcn+/X4j
        JsIF1cxUsHx79+GqJ1Tu21mo+Jtftw=; b=l1VMNGC3Xawc4/EzKmRaLvOlwzS8v
        Y/ZFo4xeqwDZ6GojmmeYuH+GV54bjpXXaSij38dArwXCDmx/2PbbGz3QhFl4/D0M
        vU9JJTw94h7tha4wtVh+t36vBxZ9WZhVC3QmBAfMTRPWA3AMvtjnNO3PDH5mENZ0
        qKjS2tN/SL1HX9DzzMNLjD2gFKEW4oNAy6BHfXqKEvUBXW03YbxTfDPv5jX0U5GG
        XPSpOI5OQXankWH+VexLJotMVFw2bCfr+mn+5bJ8GwzjSGqd432LrfL5hZiv0Dy2
        ztd9JLsBysl4I1j9ppqHsi1TJDMgqgD25c1pp3yHoRCbgbsKFOaYebqqA==
X-ME-Sender: <xms:3E0mZVeeQg7hx-juSvPB_Pygh-g8QbrFELUzYHHXYhK_vDamMwqzyg>
    <xme:3E0mZTOxyZ7kGHyBMKdTqUFAvl0QIiZi6ZQgLagQ2khzGMA4L5mn9pPooGf5sDBCh
    EPs2VhNUSITS01jBRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheejgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3E0mZeiceF3iQlQCX7dRwxjbO56tP4PQRQINkGtfP3JrO1UVgz0p4g>
    <xmx:3E0mZe-qFkRyhpmO9Zp80jqr36RLV36iQIXYjJSsjhzVgad0DG9TpQ>
    <xmx:3E0mZRtG0W2ff9wt5MwuYJk7_hnp2ctHkiPPD2-QYerRV1icxW7RWw>
    <xmx:3E0mZSmVUfk720cOQ1DuGqqsOitRehvTGpYCg3VtTyLM3B-0yn3Ifg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23C85B60089; Wed, 11 Oct 2023 03:25:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <d081871c-977c-43e9-afa3-a3c3e5880fea@app.fastmail.com>
In-Reply-To: <87y1g94szz.fsf@kernel.org>
References: <20231010155444.858483-1-arnd@kernel.org>
 <2023101051-unmasked-cleaver-79b3@gregkh> <87y1g94szz.fsf@kernel.org>
Date:   Wed, 11 Oct 2023 09:24:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kalle Valo" <kvalo@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
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

On Wed, Oct 11, 2023, at 07:40, Kalle Valo wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>
> We (the wireless folks) have been talking about dropping legacy drivers
> on and off for several years now. The problem is that we don't know
> which of them work and which not, for example IIRC someone reported
> recently that wl3501 still works.
>
> Personally I would be extremly happy to remove all the ancient drivers
> as that reduces the amount of code for us to maintain but is that the
> right thing to do for the users? I don't have an answer to that,
> comments very welcome.

I had a look at what openwrt enables, to see if any of the drivers
in my RFC patch are actually enabled, if anything supports legacy
embedded devices with these it would be openwrt. The good news here
is that openwrt intentionally leaves WEXT disabled, and none of them
are still in use.

I also did the same thing for the kernel defconfig files, which
has a few hits:

arch/arm/configs/pxa_defconfig:CONFIG_HERMES=m
arch/arm/configs/pxa_defconfig:CONFIG_HOSTAP=m
arch/arm/configs/pxa_defconfig:CONFIG_HOSTAP_CS=m
arch/arm/configs/pxa_defconfig:CONFIG_PCMCIA_HERMES=m
arch/arm/configs/pxa_defconfig:CONFIG_PCMCIA_SPECTRUM=m
arch/loongarch/configs/loongson3_defconfig:CONFIG_HOSTAP=m
arch/loongarch/configs/loongson3_defconfig:CONFIG_USB_NET_RNDIS_WLAN=m
arch/mips/configs/ip22_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/ip27_defconfig:CONFIG_ATMEL=m
arch/mips/configs/ip27_defconfig:CONFIG_HERMES=m
arch/mips/configs/ip27_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/ip27_defconfig:CONFIG_HOSTAP_PCI=m
arch/mips/configs/ip27_defconfig:CONFIG_HOSTAP_PLX=m
arch/mips/configs/ip27_defconfig:CONFIG_NORTEL_HERMES=m
arch/mips/configs/ip27_defconfig:CONFIG_PCI_ATMEL=m
arch/mips/configs/ip27_defconfig:CONFIG_PLX_HERMES=m
arch/mips/configs/ip27_defconfig:CONFIG_TMD_HERMES=m
arch/mips/configs/loongson2k_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/loongson3_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/malta_defconfig:CONFIG_ATMEL=m
arch/mips/configs/malta_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/malta_defconfig:CONFIG_HOSTAP_PCI=m
arch/mips/configs/malta_defconfig:CONFIG_HOSTAP_PLX=m
arch/mips/configs/malta_defconfig:CONFIG_PCI_ATMEL=m
arch/mips/configs/malta_kvm_defconfig:CONFIG_ATMEL=m
arch/mips/configs/malta_kvm_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/malta_kvm_defconfig:CONFIG_HOSTAP_PCI=m
arch/mips/configs/malta_kvm_defconfig:CONFIG_HOSTAP_PLX=m
arch/mips/configs/malta_kvm_defconfig:CONFIG_PCI_ATMEL=m
arch/mips/configs/maltaup_xpa_defconfig:CONFIG_ATMEL=m
arch/mips/configs/maltaup_xpa_defconfig:CONFIG_HOSTAP=m
arch/mips/configs/maltaup_xpa_defconfig:CONFIG_HOSTAP_PCI=m
arch/mips/configs/maltaup_xpa_defconfig:CONFIG_HOSTAP_PLX=m
arch/mips/configs/maltaup_xpa_defconfig:CONFIG_PCI_ATMEL=m

My interpretation here is that these defconfigs just enabled
all drivers that were relevant at the time when the boards
were new. The loongarch defconfig is a bit of an outlier,
as this is a fairly new platform.

Debian on the other just enables every driver, so there
is no good way to know what they actually use.

      Arnd
