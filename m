Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C647A155D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjIOF1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOF1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:27:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9C2703;
        Thu, 14 Sep 2023 22:27:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 44C215C00E5;
        Fri, 15 Sep 2023 01:27:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 15 Sep 2023 01:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694755643; x=1694842043; bh=uk+zZQK32Ze8zRmWK4g24/QPhrsLc5fFOPu
        w49X6jUI=; b=wOoItRBszXtVLD9L/kCOxDSff282pNjsOD89SWRXTbkgvY+1OKJ
        mF+bWkoTTaVg7YwSoLYVZCf7UaWMceAAEwmEHGpZI1IFh8n61Ar/xoZg+8hBI6aS
        Wz+sH+HRBjCj5faM5ClRT5jT5mxnKIhwraQB4RPPpMsqGjcxfApsSc9+l1PMOd2q
        75mEtliBlaEBq9rjwF7AkddPDZHSrQjvwuWJCDObhLG807UeSakLsULaaXHJlSDi
        Qocpi6sEYCclItgy1xX/YD8dw1fZv6NdObag4RboYDF3PhXSJh7zYqYW1UFaB71m
        n3GDTsMdNDedLPkqtIYZs9N/66g9y+fb4sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694755643; x=1694842043; bh=uk+zZQK32Ze8zRmWK4g24/QPhrsLc5fFOPu
        w49X6jUI=; b=SCC+1ZmD3VI9gvTFjGGgbfTmVdz73pHYdpLFjJzh08zOKCNgYh8
        kq31+VnfevkcUsx9cuFdWnYdnqjykKkFxdtJImg+8nKMh5FsHm6Cz4exgq2R61oB
        TZbR1f9D1khugXPg00pYDVTo35BKiBnUVK2sYY9UD45bsrsoV05teyWhN1yc+Shh
        IZJRhorG3EYzMbmKIwsQneUpG6NEQcnpJQDbUqcSvkaCP62XFh0+56TvOxp8Cf5M
        wvvAJkUDCvM0S62LUCiPcrDjtNV5OtQoog1lx5YFvral9bGQ211xIPso/PtW04XZ
        ItuN3bvLUlFrDkduNy49zM8jg9ICRG87A3Q==
X-ME-Sender: <xms:OesDZTqFi0gTMDBTIWyhL_VVSHYZQRapDCADLZL6p1lFq4aHrW5mXQ>
    <xme:OesDZdrxh6I7k94qnu0WCuBy2x_g7ss1BK1KHYnpS3lkPaL5U86kAqBdo2AtLzVtt
    JMzh_oudhKVeCjTz6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OesDZQMuhE_gU3KYarGZCfoeF5rZQmTAUS8m35B1Qf53F4uor2dO5A>
    <xmx:OesDZW61ReYh80Ej4m-o70mLgB2AtTlTijvHzQdoFnHGqLsi0JU-gw>
    <xmx:OesDZS7YWo69zkeAjnV50mlZGEbqO8why3itOLGWa-Rors8X36rr7A>
    <xmx:O-sDZbENC5ZN6-oLcSe17Px6xBzwBl5vFMYhaz7W3aK9vLJKOL1qSg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C439BB60089; Fri, 15 Sep 2023 01:27:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <763b1599-06b7-490e-9cbf-eb07f1deedb3@app.fastmail.com>
In-Reply-To: <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <874jjwx44g.fsf@intel.com>
 <b2723c56-e2b0-4871-afbc-73cf6335ddca@app.fastmail.com>
 <CAK7LNAR9Jt0FQNRidcxY-OxMh7N238Xs33Tyj+dpTZ5wGow0wQ@mail.gmail.com>
Date:   Fri, 15 Sep 2023 07:26:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>
Cc:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sakari Ailus" <sakari.ailus@iki.fi>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023, at 19:23, Masahiro Yamada wrote:
> On Thu, Sep 14, 2023 at 11:57=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> On Thu, Sep 14, 2023, at 15:42, Jani Nikula wrote:
>
> It is unclear why WIREGUARD must be entirely disabled
> just because of the optional feature being modular.

I don't think anyone is asking for that, and the current
"depends on IPV6 || !IPV6" seems fine here, and is consistent
with dozens of other symbols.

> My preference is to use IS_REACHABLE(CONFIG_IPV6)
> instead of IS_ENABLED(CONFIG_IPV6)
> under drivers/net/wireguard, then
> get rid of "depends on IPV6 || !IPV6)

My feeling is that this would be significantly worse from a
usability point of view even if it made it a little easier
for maintainers:

When a user selects both IPV6 and WIREGUARD, they expect
to be able to use them together, and a normal user setting
WIREGUARD=3Dy would have a hard time figuring out why that
leads it becoming IPv4-only.

> If you want to make it clearer on the Kconfig level,
> perhaps the following is also possible.
>
>
> config WIREGUARD
>        tristate "WireGuard"
>
> config WIREGUARD_IPV6
>        def_bool y
>        depends on WIREGUARD
>        depends on IPV6 >=3D WIREGUARD
>
> config IPV6
>        tristate "IPV6"

That has the same downside, with the added problem
of also confusing kernel developers with the '>=3D'
Kconfig syntax, which IMHO makes no sense unless one
knows way too much about Kconfig internals.

      Arnd
