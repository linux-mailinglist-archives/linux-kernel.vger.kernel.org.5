Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1427BB608
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjJFLMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjJFLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:12:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA67C5;
        Fri,  6 Oct 2023 04:12:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 33E1B3200B46;
        Fri,  6 Oct 2023 07:12:15 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1696590734; x=1696677134; bh=qkt+m70PAHdUwl4bbxA9Wg0tllCUmbYfUGV
        1peNteno=; b=hIvK4T7NBaS1Dz9lWQxY6XhaCxH3HKfop/ZhiwgFroEkz5UsF67
        0IFF/LLRwZN/xBewnnys987qhZDH8vrdgQWdZtjox3eYm2zBtbGSD5Nqq9g703Wv
        YMM7TNizUa1Vf3fNEWXzLpgQbWvPdaVBDc4eQKP761nXiF7QIyXueLjmfCPaJrFJ
        zrTO1oro9RWWJWlyw/QlycMye30P/UL8nAARa8b1n0jg6iqkMLmZqoS9nt0Gq4Q9
        qFVDz8slKz3o+MtLC6jZn/+uz8eu7DO7TMICaRydNt36B7OXMApnsHH+9+DR8JdZ
        5xmT5iOke1fadJHxtvlkH8kroZh/2Yq05Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696590734; x=1696677134; bh=qkt+m70PAHdUwl4bbxA9Wg0tllCUmbYfUGV
        1peNteno=; b=hJ2tWgOaqQ1G3IUK6fK+/hNHrQwIpfqVWsTkC4YSuPqkGFcweB7
        kMgbWk4QisAJ0OK4WC46JkZhCiHtWq8e6siGS5wzl+l6rxIzJS2HYs3GFHN4mjkN
        RM/Gj/Af6IXBDWSmyogbttjRRDYKQ8h9552erlqBUuM3sSx8X5YcxM58V3XuZ13I
        tfxwIDpezVGGzmbEysYupKXvk7uanqsBsqqea4ZweRSJj7/Zso3VELRfCCGLYmrw
        KWBAIdrStq4izTFjpkLyNyLuTxtOmrOkWuQtVPViW4t7XVSnp5x6ukFkXa6MSrN5
        WXwVrqlNhXygvFZlmyaytRLbDs3En7VF3fA==
X-ME-Sender: <xms:jusfZZCWiMt1_JCsiYXdMaK4_2b7hLooPK7xkwm6v_DsQaqFDFixrQ>
    <xme:jusfZXiXI1WPmyP7zhaUOkJIbBb7_Fkf6Sf0GD4cDOsPDMXjycG3yyla08KpqX0r-
    W6LfDBnsocbfkFdgbI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffeftdelveejveeikeekgeejgeekfeehhfevleevveektdduiedtjeevteeh
    ueelnecuffhomhgrihhnpehprghlohhsrggrrhhirdhfihdplhhinhhugihtvhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhn
    ugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:jusfZUmmPeQcRyNfk_5vBhfM8hA8Lr0XdqHI0OCZar2xHhVJQfP4QA>
    <xmx:jusfZTzP1G_UzxM9iPigFXx9D42mv36DOydvv-p5fg6dCpLlxt8UxQ>
    <xmx:jusfZeToXx9zCpRJQl2K01VsV5TYLXqtY6dKLgUHpC__buZWPbjNgQ>
    <xmx:jusfZTJ84k51-t8nz5TGYDcG3SRitx2ebXs24hVX_IHShlLOyx8dcQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2F611B6008D; Fri,  6 Oct 2023 07:12:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <721f56db-8e36-44aa-8984-48cdbcdc271d@app.fastmail.com>
In-Reply-To: <20231004161038.2818327-12-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-12-gregory.clement@bootlin.com>
Date:   Fri, 06 Oct 2023 13:11:53 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Clement" <gregory.clement@bootlin.com>,
        "Paul Burton" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 11/11] MAINTAINERS: Add entry for Mobileye MIPS SoCs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023, at 18:10, Gregory CLEMENT wrote:
> Add Vlad, Th=C3=A9o and myself as co-maintainers for the Mobileye MIPS
> SoCs.
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..6aedeab5f07c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14423,6 +14423,18 @@ W:	http://palosaari.fi/linux/
>  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  F:	drivers/media/dvb-frontends/mn88473*
>=20
> +MOBILEYE MIPS SOCS
> +M:	Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> +M:	Gregory CLEMENT <gregory.clement@bootlin.com>
> +M:	Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Is Vladimir's @intel.com address going to stay valid in the
future? I would have assumed that after the spin-out, all
remaining developers working on eyeq would go back to a
mobileye address.

     Arnd
