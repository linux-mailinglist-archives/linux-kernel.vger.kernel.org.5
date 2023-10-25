Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61227D717F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjJYQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJYQMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:12:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC506136;
        Wed, 25 Oct 2023 09:12:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 573BF5C022F;
        Wed, 25 Oct 2023 12:12:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 12:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698250369; x=
        1698336769; bh=hzZnckzsfVdY/d5nAAxnaS/VZqgX4l6X8qsQLMXgz7o=; b=k
        SUpR7nXsLdnBZj+3/LnwISTaSJJaqialZ41pOIpB33smuanqY2izcAgEB9/fiQsp
        4+3yYiNLtHSaIYFDHhPJgJOPf8qUO4k27xfgm31CUKX+L0EGjUCFBJh5sGBPCqzz
        bb4DMCQ8xYjKE5JebX2dHlj9Ox2Kk4ycTj+dKsJWO7Bcl6blzyoX1ByAVyEgNcsz
        wzRdhRv9yMbvpQ12FL4tkbh8KScw3Y28TDdg/sT6LrHzvf21CnMlKf6yT+XRE448
        PRG6pOlCtUP4VVE6gaBcaKjpWs8nqoFj5yDZ2eB6Paiag9x3bhf6EaB19tojQ1Tc
        wU4ubSJ43fMS1lXtMgeBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698250369; x=1698336769; bh=hzZnckzsfVdY/
        d5nAAxnaS/VZqgX4l6X8qsQLMXgz7o=; b=dCNya2qKKdzLspnFePdcw751pGDMG
        UlYrMwNIB4gIgnv3Xz7eVaxaN+Fg8SLcZ/QBtED5tO16HQ8BoTLoav0u1ceJo18O
        6o9GaJ+ns5ZEhveyeLwZCVgIxZEYyle796CqxdvJkp7zAjE2bimBsRA1NvUDVigc
        hiQmTTuWqDgwz0ksx7jQdGORty7cw5KYO1CkeQTN63Y/SxXWShDYSyInAFtWgFvk
        cSsXIhnfo6YbB17F1VIL29kQ6lQlchyLnjUkiEnH3P0MKkMY5plB0a41CILfss/8
        V8SbnJJDAgicfuxwoi86E64Fo7N4b2SDVbAsf0xYJdG+N29tdPwlp1OLg==
X-ME-Sender: <xms:gD45ZcRe13O5wUwMc8-8RBYn7VADT0Yk_Mi8F9-6BTfkQQjcpz5zPQ>
    <xme:gD45ZZyNfW6ZZ1jtNFrWlgKn6faSsVz8YIdBFD5c0bKKEnYdbunCWFnFBJYtkzdPj
    urg57uAjv4x4WGx1cU>
X-ME-Received: <xmr:gD45ZZ3L36OsQ4bRuQ8Kk7ZVCKqgqRAejWtAxucXF2t89DQVwhPWZ9AYx4a06qKzzDAX6f6vebSymqA-1M0y3c6g6Fr-MAM8bYCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeffleegffevleekffekheeigfdtleeuvddtgffhtddvfefgjeehffduueevkedv
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvg
    essggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:gD45ZQAs2PaCTsuG1J_IaF9Iw5lxGylttujSuJ6O8Dkns-j11ThMKA>
    <xmx:gD45ZViA1h1JU86CPz7iP4sk3YPNG16pvI-UIA0FJpcirCXMFNAiRg>
    <xmx:gD45ZcpRqo2LKQPI79EJt1MaLc11MBwOSKxIWBt1COFUbJiaER830Q>
    <xmx:gT45ZQprAFt55ukZEyvkkzpm5SXB2mh1Z3pDmqgxV4UWxy5n_9Bt8g>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 12:12:48 -0400 (EDT)
Date:   Wed, 25 Oct 2023 12:12:47 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: module-signing: adjust guide after sha1 and sha224
 support is gone
Message-ID: <ZTk+fytHiyfbgNFC@farprobe>
References: <20231025104212.12738-1-lukas.bulwahn@gmail.com>
 <CADWks+ZoLs1FUJx0sSg5FBYK5BtD+Po7bRORVT4uBLM6QJxXJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADWks+ZoLs1FUJx0sSg5FBYK5BtD+Po7bRORVT4uBLM6QJxXJQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 13:57:08 +0100, Dimitri John Ledkov wrote:
> Sorry for not patching documentation at the same time as the code
> changes that made documentation out of date.

Should this, perhaps, get a `Fixes` trailer then?

--Ben
