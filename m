Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02A7B0283
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjI0LNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjI0LNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:13:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7101191;
        Wed, 27 Sep 2023 04:13:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3707D3200901;
        Wed, 27 Sep 2023 07:13:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 07:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695813192; x=1695899592; bh=2g
        R1k5tdvr6okGB4cxabccqENyYy1BsDzaxYM7gOAjg=; b=N8L3qu7IGuS3tYz7Sd
        zUVcuPBUDQBsUSKNW6M2EI+2+ZYZ4rY+eoWrM4EuXIOkdGs6e4S2zZh5hrTz90EH
        +CqoPQx6adFOb5hDQW2wiCPxPsyX1RMgWi3lpfnGZkXjx6echYH91u1jnSilnQ49
        AjrpBjcbvh3/GJajom8fda99rDQR5MiAJWldlDXO6T2K3P0So54swYyyCSnuvKGQ
        omaj4B2R8i35SDtUpQHj2cL+GOxABW0INslLNnKBOdcy1254etf1pEZMbvKwP04N
        j63FwMVgYoO6Xsy6OMmpvG0UEF0JIiFc1cSKAh6KR2ZzBEpupB/eVIKqn9Q/9aUs
        wU/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695813192; x=1695899592; bh=2gR1k5tdvr6ok
        GB4cxabccqENyYy1BsDzaxYM7gOAjg=; b=nxUAAk+ScjcqqqPXv9SO/lY9pux8I
        9Tl++nzZx+sE2/NjL/dY42nd6fgqeWLC8DHODHPerNX94N1sQ5OJhHGmy9+SDuE2
        VWN9ZBMaP15qMKPqhhBwUMRbLjwaMWHgornKlFzu83NbP2Tc3QEowDEP9cqt/9bI
        0G3ca9avn/ra/ML5D10E3etkw4Nc8kkvVdG8oLg8tF5LTag3D1S94R2wixC7ux0l
        ik7KYfUewkR98bYPR/DxK1DjwvaCvz2TC9NIyJTxQ6b1/JLdjfmiAAl7vVdrGMaL
        IS+kpP8wht1+rDhpP+yoVnOSq1RTsl8wa53UovEUotP9BIlLD6jD+sItg==
X-ME-Sender: <xms:Rw4UZQ-MPN2gMzJWcxWhp1EM5_9Njs0YdW84NtpPp3qh_kCcnlF0Zw>
    <xme:Rw4UZYs4ZwD8lRKBaaYCh8lhwCv0S8feUDn07H8L-87J7uo_rsp75uyYL0owuLqaO
    s97xIpgGunzHU1Yijk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Rw4UZWBNRIpOghMGTlB9-dPhszFwze7iURBrFQzq1fWV-sCkDnyFWA>
    <xmx:Rw4UZQee_BWXBh7y4nBjgOgDvGBgjHLyGzOju8cMu88vjEVjUvgDFQ>
    <xmx:Rw4UZVNXQU910jnokPJ-52xK3TkdwZry0HMVnHuguS5LSLRZ_3gj2g>
    <xmx:SA4UZZmww0hgkVW4vp3P2AX79m733yxjHUg1LoqydOGtwFpgwyzvdg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1938FB6008D; Wed, 27 Sep 2023 07:13:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <9065720e-5a5c-428a-a28d-a3337ac31f85@app.fastmail.com>
In-Reply-To: <31585f93157c5c4487b53e3bcb6aac9e92e62f92.camel@linux.ibm.com>
References: <20230927072223.2555698-1-arnd@kernel.org>
 <31585f93157c5c4487b53e3bcb6aac9e92e62f92.camel@linux.ibm.com>
Date:   Wed, 27 Sep 2023 13:12:49 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc:     "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Oleksandr Tymoshenko" <ovt@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: rework CONFIG_IMA dependency block
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023, at 12:52, Mimi Zohar wrote:
> On Wed, 2023-09-27 at 09:22 +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Changing the direct dependencies of IMA_BLACKLIST_KEYRING and
>> IMA_LOAD_X509 caused them to no longer depend on IMA, but a
>> a configuration without IMA results in link failures:
>> 
>> arm-linux-gnueabi-ld: security/integrity/iint.o: in function `integrity_load_keys':
>> iint.c:(.init.text+0xd8): undefined reference to `ima_load_x509'
>> 
>> aarch64-linux-ld: security/integrity/digsig_asymmetric.o: in function `asymmetric_verify':
>> digsig_asymmetric.c:(.text+0x104): undefined reference to `ima_blacklist_keyring'
>> 
>> Adding explicit dependencies on IMA would fix this, but a more reliable
>> way to do this is to enclose the entire Kconfig file in an 'if IMA' block.
>> This also allows removing the existing direct dependencies.
>> 
>> Fixes: be210c6d3597f ("ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Oleksandr Tymoshenko's patch to address this, made it into linux-next
> today.
>
> Commit be210c6d3597 ("ima: Finish deprecation of IMA_TRUSTED_KEYRING
> Kconfig") made it last night into linux-next.

No, that is the patch that caused the regression for me, since it
is missing the IMA dependencies.

    Arnd
