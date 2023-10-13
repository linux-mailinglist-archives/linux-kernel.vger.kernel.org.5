Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE337C88CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjJMPhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:37:10 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA7BB;
        Fri, 13 Oct 2023 08:37:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 70768320099A;
        Fri, 13 Oct 2023 11:37:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 13 Oct 2023 11:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697211425; x=1697297825; bh=26
        NXCBDrkJj89cZAV32XsTyyy8aUMxOJsXi8lmri3vw=; b=jQ5QdFoHU3oMAZHcCw
        iVLFaC2Py9bvZc4DnMI3Ds0BSehahzjwf9nTVcVrXzo0wfaUKxB69BYHq8sYnDwg
        NnfP0WpIfq98c7ymB2i8vIrjP6OxZcq98csXMvdvER5BapZTLFBCYKRa0hxi6Pmm
        gp1ZVPuHdArKD8e72L9AaZztvs+BN/M+G5negRFH6ucn9d5BCG7HffuizFPCoSF/
        UzdQPheEEPcsI9O72Qe4/dlZMNk0hy0YeAupNhEwsw5vCNdbyaB9RZuYbj/Aq8Cp
        EkrDRKE0EfJ54t/3fgeAFjUNFyJWKgv+74K3FEaG/8yA4Jhn4T5tEoBi0QWm0dBD
        o4Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1697211425; x=1697297825; bh=26NXCBDrkJj89
        cZAV32XsTyyy8aUMxOJsXi8lmri3vw=; b=URYipmw6T2mlurfuhM2NBBDoE56gi
        Sts4mxphK+gx2ICELCFlWucVLJX+SPdXEBbNZqBHDWw1RDw6Z04baB0ADo4E5+mZ
        NnjcaYCMf85hXHpHDhQXs6sU1jBvzCx1Uz2kv5FXbdeGQlKM+rXcavV1uW/XFfia
        Zf0HxCie1HozEFFQhLeGHHLZzlv6FomTCKb2dfp9OPtd55l0Kp3Z9HzliGZBgCqy
        ClS/63epQga/Sga/Q0qD6+RM1NtdMm/Ft531OBo47Shw8MpRKbLX9H4fcV1f7lqa
        GCyn6w7kNmN4/Hx9sV6+5EqXW2laYKzvFMG24O2K7IcrtaLsxyLJMd0Xg==
X-ME-Sender: <xms:IWQpZTyr6UxSO-7ZO_medwMS-S_dBtjymsnUOjkzWHabQqU8cnOkgg>
    <xme:IWQpZbTsm9p3KPeCX01HcSN0sap2lG0YMErYouyEJumKY6WSnKElCXwUl180ZzH2x
    _uB_HaqZVZ9cLWYF3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IWQpZdXYXXDF3_FkvDvCsOoTD0_qDGydEUOYy1E9TCYYMrqJ6LGnyg>
    <xmx:IWQpZdgcBAgZTwUxxDNQuzoGjzqyG8AXN1bkUixpEOrf_7-VsNisSA>
    <xmx:IWQpZVAcDj_5hcFhy43cLtpJhGJeqyyR8uns4VG6O38HMuu1aY44Fg>
    <xmx:IWQpZZ5ZnYSkjVgejXsQ1RJ92MsB1Ojkvl1wci8kOYcbjp-Nz_OOCA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F199B60089; Fri, 13 Oct 2023 11:37:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <c8f43e1b-aed1-4b45-ba7c-d896ff66dfa7@app.fastmail.com>
In-Reply-To: <e93e4008-65c5-4f1d-812a-64b48f0513a2@gmail.com>
References: <20231010155444.858483-1-arnd@kernel.org>
 <e93e4008-65c5-4f1d-812a-64b48f0513a2@gmail.com>
Date:   Fri, 13 Oct 2023 17:36:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>, "Kalle Valo" <kvalo@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        "Jakub Kicinski" <kuba@kernel.org>, "Pavel Machek" <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023, at 08:42, Philipp Hortmann wrote:
> On 10/10/23 17:27, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de> While looking at the old drivers 
>> using the obsolete .ndo_do_ioctl() callback, I found a number of network 
>> drivers that are especially obsolete, in particular for 802.11b 
>> (11Mbit/s) or even older wireless networks, using non-busmaster 
>> ISA/PCMCIA style bus interfaces, and using the legacy wireless extension 
>> ioctls rather than the netlink interfaces that were meant to replace 
>> them in 2007. All of these drivers are obsolete or orphaned.
>
> we should take into account how good the wlan connection is.
> This of course leads to tests on real hardware. I do have a vt6655. 
> Please have a look at the test results below. In a nutshell it is a very 
> bumpy connection you get with vt6655. You can have issues to connect on 
> every channel and data is coming in waves. So sometimes you will almost 
> not notice you have a wlan connection and then it takes very long to 
> load the next site. Ping times up to 80 seconds. Packet losses up to 
> 40%. So I assume all users have gone away from this module as it is not 
> comfortable.
>
> Do you think this helps you?
>
> I do have two vt6656 hardware as well. Are you interested in tests?
> I can do a patch to remove vt6655. Do you think it makes sense?
>
> Thanks for your support.

Hi Philipp,

My vague feeling is that bad performance on its own is not
enough justification to remove the driver without some other
reason. From what I can tell in the logs, Malcolm Priestley
made good progress on cleaning up theses driver, converting it
to mac80211 and sending improvements until 2020.

At the moment, I'd suggest focusing on the drivers that
still use wext (git grep -w iw_handler_def drivers), if we
can show that rtl8192e, rtl8712 or ks7010 have been broken
for a while, removing those would help with removing wext
altogether.

     Arnd
