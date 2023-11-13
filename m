Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E4A7E9DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjKMOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:00:37 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29301D4C;
        Mon, 13 Nov 2023 06:00:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 951165C0197;
        Mon, 13 Nov 2023 09:00:33 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 09:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699884033; x=1699970433; bh=VHi4AcLP1FDKeL87EkRURIskb7aetmZpaGy
        D5PsyTw4=; b=UKHbwcnuM/BZH8xYYa01WFOkHvkc0Ykh+riEPbcRNA4Ue6MEqgg
        Yngz1rptFsb2T1SGQTDOrhFlGMREQzDv1jsVqwl+fkinpQhPK85oU6SM6w+gRFfK
        4bkEuGB8MBTWMkiGf3QQ1uoAR2fDICfXaQYJJhKtAwb7ZGoJPBKloiC7GK66Uq80
        oaAWWkyERR6iDEZfGMevzJ3akjdRb7SLA21K47fKjkAjlGMaea34fm1HllX6RtKO
        WBrCaFK5d2+ZuSkBs3qj9r3MnD+RLsap2hJriXNDyLaayHsIX0QJABVphYUFatFI
        bvoWpA89qNtFTai+RVKZkf5rboWy86Z5wqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699884033; x=1699970433; bh=VHi4AcLP1FDKeL87EkRURIskb7aetmZpaGy
        D5PsyTw4=; b=h8PcPdtouGcX3pGAqzjnnhYdawg1vKxyv6p7zvDS2vR6ZGJYYJS
        R8ltnI3/eZFkmO6Y1fCJSu00gKLEsVnWwM++O5DkxmNS5CqQ+R85e3wOhUF09lyS
        L7Xn3yJg9bGlntMfayO80f+hWkTKtDfALgJOkh3tWc1M0AhvGE1Bvb8RuSefZd0x
        EshqCGYtPFCUwIng185hZYDNTSMftwDr+W7dFEyH7vbIPnhNn0fWUeCvJGOXgUNL
        ffxN+B0trJz75vaqhCglsfDWv+uL/cRyRj+LGUlKUqxhRZKz+fcm4wxlxCLCC/UB
        RALIp6KbvW9OWlr75Ykx+aqobVXo4KJFbxA==
X-ME-Sender: <xms:_ytSZX4V_aVb4SgcDRcz6_nIDlDLvj203gd2cO4HsyEdwgveWNkpwg>
    <xme:_ytSZc52L2ruNEkwyuss0fZUTcLQEgYc7bRcLMnMBvPlu6Dm1yLh82ESndTU0xI6A
    pn4Mgxi5UkT5ciKOUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:ACxSZecBO_wERmCSDE5ojDm3bJ3MKcmn6Thw91YWL9pT4HLnNjzOLw>
    <xmx:ACxSZYLFrMAC_fSRKepvrcLPfxsjJCvaTilPdg9ywR-sMW5XrChNYA>
    <xmx:ACxSZbKoHk8tD2kOz6crp3vsj0HxmEfEXgqfuo3Fo0IgPVRDmBFVAA>
    <xmx:ASxSZT2pEed5RqwJt1orGOA0hml5A9qyqy_TvRV2Btzr8hQL53ibsQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C1861C6008B; Mon, 13 Nov 2023 09:00:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <b3167aca-032d-4ec4-b438-38416a5d8a10@app.fastmail.com>
In-Reply-To: <abecd774-30a4-f11b-e1f-dcae9f1cf7df@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20231108162039.13737-1-mpearson-lenovo@squebb.ca>
 <8b29ab8-fef4-8a60-e6c5-447f31f144a7@linux.intel.com>
 <14312000-6369-4669-bcc9-4fa2abb5a98f@app.fastmail.com>
 <abecd774-30a4-f11b-e1f-dcae9f1cf7df@linux.intel.com>
Date:   Mon, 13 Nov 2023 09:00:09 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Add support for improved performance mode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo

On Fri, Nov 10, 2023, at 7:37 AM, Ilpo J=C3=A4rvinen wrote:
> On Thu, 9 Nov 2023, Mark Pearson wrote:
>> On Thu, Nov 9, 2023, at 5:10 AM, Ilpo J=C3=A4rvinen wrote:
>> > On Wed, 8 Nov 2023, Mark Pearson wrote:
<snip>
>>=20
>> >
>> > Looking into the driver a bit more, there are a few other defines w=
hich=20
>> > could also move BIT() from the code into defines. Please tell if yo=
u're=20
>> > going to look at those because if not, I might try to make the patc=
hes.
>>=20
>> Happy to look at doing that as I'm playing around with this driver an=
yway.
>
> Okay, thanks.
>
Just a quick note - I pushed v2 for this patch, and I'll tackle the othe=
r BIT changes separately (rather than adding it as part of a series). Lo=
oking through the code I wanted to spend more time on that piece - I'm n=
ot ignoring it :)

Mark
