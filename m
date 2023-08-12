Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF920779EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbjHLJnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLJno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:43:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9C19B3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:43:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A17FE5C0086;
        Sat, 12 Aug 2023 05:43:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 05:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691833427; x=1691919827; bh=1P
        UeRr8175rOhPBExu2PJqtkhU1EpmAjlBEOim4uau0=; b=PHb68aK1Fl25SyaU6e
        9ptV1ChlkRM0ww72bFmLmKXfAS+YoauoLCY/+bfotbtlFmcfFYeVgDS78Id8HgDw
        lPpugIN2QMSXQqBXkbxDdWPcSOY91LWLrIIIx+XmyZWF/+AZiuttkiTdu6bAowBu
        cYZzesM3+/scj/tf4un+vFPm8sS7VEvWmBOB7ewvz3uck3K2A6Tzol0OrFRWULAv
        oTzbBcmaBGubO5mC3PRNLq9ymEmChJZ+ZUxwOqXZJU2y52POuhqOGknr2xrna0Zj
        fFRK6Whp+JeLXbu6PeYYjOr717eP2vMGAWqpveg0pife0Mzwm7TfPjzTBBzU2rwV
        wn0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691833427; x=1691919827; bh=1PUeRr8175rOh
        PBExu2PJqtkhU1EpmAjlBEOim4uau0=; b=bDpIzPOSttHsgJ3S7DBMOxmOFs9h+
        cPyN5kPH9I5hu7WaT2GXX2xcVdZmMwsh/xGuyO97QM4/ju8pCJasHEecKyciXijS
        sfo9A07WFI/V0Qr1vrZfpeKyLhW3SBOm1Q3DrbUz0Gqb4dVTIoDYi2Z9eqEL+MBt
        wDl5JCvjSjV9RBrelcQDCF184Wbfvy6vyvTafnmSeHE+nrbYwo0VaBjD/hqmRkXi
        9SpOC9I1sZZ92Z5HGKgizEcd+yc0FYLUue/f2OoTXfLhq2xrxBPJAb7QFLxbC24f
        VOhCnaq2GXVMlJP4zBTuer9/n/scfOP56grE49qc724SBe2MsZIg6mA3A==
X-ME-Sender: <xms:UlTXZBFXPXIOozYcNKHSTPEKksRavC9ap4BYQtlkxaanwAF-LmnPVA>
    <xme:UlTXZGV0-Qk7vfSTbDH2fZ8V7eLFZTkoziW-Pkggyc5BM1FzKx1JEcoEM_lbA5-Qk
    hJ8xQL2FXXWkx5e-jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UlTXZDKlRTh-yAyeFhTPDxx2XkhrYe2Yo-44F6UMbBBXXganXs4RKg>
    <xmx:UlTXZHGuDXNIajOq5g6kPKyziSHakAN6u3dhnobEKRjHiJ9glsIp-A>
    <xmx:UlTXZHWQ_FHvsjbDR_p7VOw9ne1s1Sab3QSx16-4TaSIdhNKPvdxcw>
    <xmx:U1TXZEhX-7foqpJYz0AktZRJCivNSKuaO7m0XvEUBljUVdysVQPFcw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AAE99B60089; Sat, 12 Aug 2023 05:43:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <70b07e66-7916-462c-8b84-b8dbe7ca4ce6@app.fastmail.com>
In-Reply-To: <20230802162926.169184-1-afd@ti.com>
References: <20230802162926.169184-1-afd@ti.com>
Date:   Sat, 12 Aug 2023 11:43:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Davis" <afd@ti.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Tony Lindgren" <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable TI Remoteproc and related configs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023, at 18:29, Andrew Davis wrote:
> This allows us to use the various remote processors on the TI OMAP and
> Keystone family devices using the multi-v7 config, instead of only
> with the OMAP/Keystone specific defconfigs (which we would like to
> move away from needing).
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Applied to soc/defconfig,

      Arnd
