Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91477F69F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350938AbjHQMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351013AbjHQMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:43:54 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B0430C6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:43:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 838E2580133;
        Thu, 17 Aug 2023 08:43:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 17 Aug 2023 08:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692276225; x=1692283425; bh=yV
        EqWTuuBHvfVKKWuTpdcLKJFe4ZBQt6BukSl2xV4tw=; b=XK3ztn4yhVZU6ek0hh
        s159A2vncJlNdKOwOKv+jfVzoTR0CV6ExX5fyqqiekpE/QUzxwrUZgbIAjQLhSar
        UZ8cSjdce3OJ/ES1FUMLUDeT1ap3WW+giMRlEEYwYyxIIBK8sS2C3r4oFTkVGZK3
        V6rhj1TqMNhgSE/sy6Q8NQXCTG3oXk0SORORIESk5G4g01h38EFThCXY+OtOQYPa
        Q7oYdodW2TJ5BBTRbCpa6SfqXv/NT97XGDcJwclYCNDIxzPgVOdQA+BXOzZjtKSm
        4cpsD4QiMvOV41eKS9lMulxt9gSbVIhghYLwZnC/aH0rWubXp8RHY659fIzzi6Ki
        05+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692276225; x=1692283425; bh=yVEqWTuuBHvfV
        KKWuTpdcLKJFe4ZBQt6BukSl2xV4tw=; b=soYPp0ZhU98gI/7cUtPtbx5swwFGI
        UgNTPZKr76ecjWJVfkzgT9ldQOiqeANF9lqgl2RmfHaSPcBIOEYLfxGuOjEsg5J6
        i3C7WZs/Q/+2aKyQRoyn0kNCpzeCBl5eJ8iaQzuDRLYMXEVwFVMQ3HTraHM+YsCy
        gAMd2DXUMb8/P4PFRTaatlEXdr0X1GGJbSziguZ9p7eXQcowd+VHey8OgobCmYDS
        eTnxYa4ZKdOPakjPzYviYV4j/s86j2HuINrX+64SoK7xMyF3qnqyU8LW/3MAa09f
        gK5F0c/6yahqo2ipH6cQtS06KMHWUEmYxy907ow8DgG9aq/RATfMCDECw==
X-ME-Sender: <xms:ARbeZGoa_fsWZ_-bW9SlrElBtNP3HArFPD6SdJYWxloZNIov7XhQJQ>
    <xme:ARbeZEqXLT5Eyzj8WmVKVIsumh5F7Mk-qX_CYEIjaax9Hpoz43-jFuakNrE-j1YNO
    CI_3pwW5Qb32mhEZpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ARbeZLM-7gpf-pqzncz_Zk3cosZPm9RJkeaPK5CEQO57lHL99C-J_Q>
    <xmx:ARbeZF7wrP__kzgJqma0oVxodSczjF2aoA0Oo4MZcoUaZktq1zT7kw>
    <xmx:ARbeZF6QgpOxy56_RxUa9Xff6x-EPffxiQM7F3hNu3XwkSp2kWo6Ow>
    <xmx:ARbeZFEL4BfbqoapK1a1cC0WnMGh5-g6Hd1Ud5sOcEHf4I4wW4ZvDQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4A488B60089; Thu, 17 Aug 2023 08:43:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <53dc5d0f-8267-480d-a40c-97330e7a290e@app.fastmail.com>
In-Reply-To: <0aa1141e18a84d926e199093204b37ec993f0c87.1692275185.git.christophe.leroy@csgroup.eu>
References: <0aa1141e18a84d926e199093204b37ec993f0c87.1692275185.git.christophe.leroy@csgroup.eu>
Date:   Thu, 17 Aug 2023 14:43:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: Remove init_internal_rtc() to fix no previous
 prototype error
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023, at 14:26, Christophe Leroy wrote:
> A W=1 build of mpc885_ads_defconfig throws the following error:
>
>   CC      arch/powerpc/platforms/8xx/m8xx_setup.o
> arch/powerpc/platforms/8xx/m8xx_setup.c:41:1: error: no previous 
> prototype for 'init_internal_rtc' [-Werror=missing-prototypes]
>    41 | init_internal_rtc(void)
>       | ^~~~~~~~~~~~~~~~~
>
> init_internal_rtc() was introduced by commit df34403dcaac ("[POWERPC]
> 8xx: Add mpc885ads support and common mpc8xx files") as a weak
> function but has never been defined and/or used outside m8xx_setup.c
>
> As it is called only once there, just fold it into its caller and
> remove it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

