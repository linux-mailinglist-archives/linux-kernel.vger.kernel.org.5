Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA176976F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjGaNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGaNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:23:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28728EB;
        Mon, 31 Jul 2023 06:23:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 973EF5C00EE;
        Mon, 31 Jul 2023 09:23:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 09:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690809832; x=1690896232; bh=Se
        sJURo2GNIPxlgy2lU8LbgruKBtrrvOanK04f/Dc+s=; b=V/1rdpGPql22nPgVxI
        u5FzGIJAqUQuZ/Mka1qBscZBPK+MRpt0wfyCiNuHXnSxwEsoT/8wewEjeK4iCxhS
        1gssB0DgVUBMmYAh/aMwTvZ/qmTUQwGC9hB1iP3c43+f7i9JVHM7+M3QUdwWQUfT
        daLF6XwGXefoMnoYl+yt351PG4+/FmkaPfJ9bhMJtC94UJpZepVnvNCZjz0Yn1hS
        z2AoFV61CuXUxVFMWxiow+2UZJFK0QCmkSNkcVcsN1TBbfOAldHPkDzEf8pwObfS
        kmGbaYPNFvI6ja0p+XAIg+YojC1wYWw2D7xFYs/0R8sURAudXP3hf+bR20Adz6Gc
        7kIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690809832; x=1690896232; bh=SesJURo2GNIPx
        lgy2lU8LbgruKBtrrvOanK04f/Dc+s=; b=qd8Q2IvEWgefIl0snyxbIWWwf0p1q
        W9Mx8W07ywXgqbh5n5Fb6mlmCA8q+gXW3j/xE3smcdyCBy0JCyeR8egnzC/nvD4f
        4GnYCHK+H3fqJTFuPKZRhj0wiaf5TGKZ7dtDcnXGoDFaT+aJg9X5JLjSyq7PhELA
        aHzdq7+6/iut94tgoQC2JY4nTGWZh4LBF+iGv9gebe/mGjHHI1zGlAD91nYsOCUt
        fz83rd2327tJ1epaEeejCkQV5V+ygsf19Sy3/6j502UA5+KJ86AeA/H4eyiCyp7s
        /s2QSWPsgto9gTyIywFRnb7dQOW3lx2TR2GKflHwduf3UNm3oV+PoOz8g==
X-ME-Sender: <xms:6LXHZGKv4Kri1x0pCHIb7BcvBDfI1yNvQl2oPTv6qPgufTR0AywU3g>
    <xme:6LXHZOLUipGM2VC8tucp9n4aay3R48F8MYPRZaC891Ep6X2-BGac-dAPqwSrVV6ba
    zHLe8ZS8W8ukYSeOF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeegteejkefgtdekteekvdeukedvudegjeehkeeuheegueekieeuffelffdthfeg
    udenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:6LXHZGsIGOdpIibmKb0AtYhv1MDa-Of8I5PRnUcRwQA70kApIbSU0A>
    <xmx:6LXHZLYjU85LO--02hRJksWV7RV_Tgg1S75Ymb6_E-JSBJcbAsQeYg>
    <xmx:6LXHZNZ8h4dUyi5fwXcmZtdJ9Fbe8iZvGppehrJ8ljCaMkNPJrvEDg>
    <xmx:6LXHZLPhVQXXvG8PhHMr2cgtN_Cj1YmpPN0CR5ZOj2F9qOzEiVi7JA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 524C5B6008F; Mon, 31 Jul 2023 09:23:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <0c948578-5cb1-4b4e-8fa6-9de1d658713b@app.fastmail.com>
In-Reply-To: <20230731110239.107086-2-clamor95@gmail.com>
References: <20230731110239.107086-1-clamor95@gmail.com>
 <20230731110239.107086-2-clamor95@gmail.com>
Date:   Mon, 31 Jul 2023 15:23:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Svyatoslav Ryhel" <clamor95@gmail.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Samu Onkalo" <samu.p.onkalo@nokia.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: light: add apds990x binding
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, at 13:02, Svyatoslav Ryhel wrote:

> +---
> +$id: http://devicetree.org/schemas/iio/light/avago,apds990x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Avago APDS990x ambient light and proximity sensor
> +

The APDS990x looks like a wildcard, which is not appropriate for
the "compatible" property in DT, and should be replaced with a list
of specific part numbers to which this applies.

    Arnd
