Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F7776723
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjHISZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjHISY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:24:59 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31DF1BCF;
        Wed,  9 Aug 2023 11:24:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C83A5C0069;
        Wed,  9 Aug 2023 14:24:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 09 Aug 2023 14:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691605494; x=1691691894; bh=hB
        sRqPsdDyKhBWx869nPPrv7yqHSzjT8V/8SgiQ7D3k=; b=gdrzpKYpBd0IjkR7x4
        FysFuHh2rJMWsseUxCHohxKjODlWUnUy+xSGCho/5LmbKi4n6yPrUuXk9TA/s4gQ
        FVTXeyNIW2n3qTCFSgw4UkN8eH4syZwM+hR0Hyx+EVcNTz03EDzK/p5Fho4LEpr5
        w4u1meLp47qXO8cxcVqcr6SKeEarteECB04il1mpjPznIeqbSuGkIgQ5S7/clObI
        NMSur8HXCgfIWB/0Iw5dGh+xlELcIWJgDapqwbzmmB3R0Uum3ixBLkjY8CcsgOMe
        xUBd8/4xc/3tlMPSvsSqMusOraUyqq/QeGW604fCmJNxGyB7KWe5NwNjsDOHv3bz
        FwWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691605494; x=1691691894; bh=hBsRqPsdDyKhB
        Wx869nPPrv7yqHSzjT8V/8SgiQ7D3k=; b=ZhdSS16o6u/8hEv8wV/Czd+XPRMkM
        Y10HEEe//DcvI6L2A1DYxDMoC9ZiHd/Q2aOuKjRZSsJOtOE/e3FcJuhvGhOsYIMZ
        SnGplUCMJUMJgAoonBfyx+GneCPJdvLRnKbftGJdhbvzldCFdWpJQLE3j2qaLKC+
        09IIRynlbNeQVDzchyTg75hwfZL9QQX5Y5xBFqPDx8x62JCZKZhpQvFqJ/wWakml
        OPlIuKg1zRpOWynMeQnrD0eNbQ2lGdxXRD6xoVCx/T6XSQawgpNpCooZjYoj4g0s
        84lbCxQy28SVL8wM1ZLv65kvffLjNBKCWOGK+9pVfn/+X4ML6ceoZgOOA==
X-ME-Sender: <xms:9dnTZB9VcLzE1qw3rBnBe4nWPHtlPmurmPE_j9KjzFS-wQpSSnwyXQ>
    <xme:9dnTZFs02MrhEiQeG9f_2clS12zhYBPElcGJIWvriKT_AhJhw42KZUCjoa8OddTVL
    To9-zNex9nixVuZe40>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleeggdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:9dnTZPBkXML9WVuCCAUu77SYKQ-xH4M1Ux20ZvIbKyGwEXYcLLM7JQ>
    <xmx:9dnTZFcGKjbwZeO49TELBm2r3fJmunN3vQdamHaoFevvWindOLV5GQ>
    <xmx:9dnTZGOhDlgao8OgGmtjkgHfl_ICZFRk-QhMC-9y7C4sVppYozHOCQ>
    <xmx:9tnTZAu0xKXoOd6mU2anH1qjeSuQgUTaskkzHnsI34a_Jw2Kz0tLnQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A0CC3B6008D; Wed,  9 Aug 2023 14:24:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <106a93ae-90f1-45fb-ae0a-034eb2d6faea@app.fastmail.com>
In-Reply-To: <202308100045.WeVD1ttk-lkp@intel.com>
References: <20230801105932.3738430-1-arnd@kernel.org>
 <202308100045.WeVD1ttk-lkp@intel.com>
Date:   Wed, 09 Aug 2023 20:24:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Valentin Caron" <valentin.caron@foss.st.com>,
        "Antonio Borneo" <antonio.borneo@foss.st.com>,
        "Amelie DELAUNAY" <amelie.delaunay@foss.st.com>,
        "Christophe Guibout" <christophe.guibout@foss.st.com>,
        "Gabriel Fernandez" <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: stm32: remove incorrect #ifdef check
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

On Wed, Aug 9, 2023, at 18:36, kernel test robot wrote:
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202308100045.WeVD1ttk-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/rtc/rtc-stm32.c:903:12: warning: 'stm32_rtc_resume' defined but not used [-Wunused-function]
>      903 | static int stm32_rtc_resume(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~
>>> drivers/rtc/rtc-stm32.c:893:12: warning: 'stm32_rtc_suspend' defined but not used [-Wunused-function]
>      893 | static int stm32_rtc_suspend(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~

This is the warning you get if my patch is applied but the
fb9a7e5360dc8 ("rtc: stm32: change PM callbacks to "_noirq()"")
commit is not. If that patch is applied, mine is needed to address
the other warning.

      Arnd
