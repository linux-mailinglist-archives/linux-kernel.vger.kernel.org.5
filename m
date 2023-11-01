Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260FD7DE8DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346655AbjKAXaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346379AbjKAXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:30:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065A109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:30:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 669AD5C0342;
        Wed,  1 Nov 2023 19:30:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 19:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm2; t=1698881400; x=
        1698967800; bh=QA9bL4pH17vRRTAjH8QH3efr/t68hoN9FscUUc/pREM=; b=Y
        VjPou3nYJHTRkIB3QraliLL8YMqtO+3SpLc0IToOcC5fdMsCK1LSaegO1oioc0A+
        U3THSWtF8GLGXkk3BzcfBO8ZR3ff2WGMoZ4CnCudKM9fkxBHrdvInLjbaLafb2LJ
        kpOWuiTixDNm/WCYNFpfcw8MNLRKwbOWy57RdRCLBae1RfcutOQfF5zxZrN8YLNy
        KEqws4fSE1qyd9xsQpcNRCg6JFfoqnQMLlrAF6sa7mSSaNSjFzg7/24n0OPrLpDt
        1lguFvDW9yh42vZLIfZhkEZsPdsWROIEAIVxU8mRjRmPvAvNYxW897uee6k/4Hrh
        6ASTTNnhs1Jo2FiHmJp/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1698881400; x=1698967800; bh=Q
        A9bL4pH17vRRTAjH8QH3efr/t68hoN9FscUUc/pREM=; b=tOM5GhEt3HJOShLvE
        wv4t4AD1n1SLPzm4q2zkn68SS4uv9e423eQEyby82JskHWMa7+YeIgt71vgd7SgP
        skGX82/Bifxvo+4/ADoZuyWhRumyx/5o8BSgIm0ONJWMak0Ih//oD95NKVCecTRH
        q7Y25ztr8c8NvR0pffFLeuKNDoAYkqCtTWmg7NE9g8zuBx/rGfzFHdyZ/8+dHFni
        yPNjlelVjWLgOA3BCiwDqg55BTjtRPKFLSY3/R1pFYDkzQNimad2Bd87DeLiVw3q
        Oj+YQULtzweaUctX4MgHvQXjI1whhTUJSSggZhE0h9D7qWPx+V3mJCsyxmwya88H
        oV03g==
X-ME-Sender: <xms:d99CZVgMtgDroGU8_HvUbGs30XbEdkAz1X2NSxnYBQDFRMl2RHm_7g>
    <xme:d99CZaBtsNWTABjCMR_wXDyQRaRs4IQBOm5dt0etjYIP_ZE2m3CFbxobQ80fhF_CT
    h3j7oF6t8K0t0oIVAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeefheelfeetheelvdeiieeffeethfekvdehheduleetveeikeehhfeghfevkeff
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:d99CZVHFfEXQsKkDPmPiMjqHil-MifcE-PYxSFa71vIsDCkh_fm5YQ>
    <xmx:d99CZaQ19hg5ickHo8pxHhPa37FaUiW12e9nCqC4kBs8JH7Lr2H2aA>
    <xmx:d99CZSzzebxDSzJoMU8b-2VlYn82Y68GNsRbSQ3J8C0nWmkly1u6Lg>
    <xmx:eN9CZXrRGNu3eAhtYr0muimvbCtpCUnUYhWieE9wzqRDrncPk5d27A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4A22CB60089; Wed,  1 Nov 2023 19:29:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
Date:   Thu, 02 Nov 2023 00:29:39 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/4] ARM/SoC updates for 6.7
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have close to 1000 commits this time, as usual they are
mostly arm64 DT updates.

Most notably there are two completely new SoC platforms:
a data processing unit from AMD/Pensando and a RISC-V
based high-end design from Sophgo.

The code changes are fairly minimal, most of the driver
updates are are minor cleanups, with firmware drivers
being the main exception that add new features.

The most active contributors by number of patches were

     68 Fabio Estevam
     59 Krzysztof Kozlowski
     37 Uwe Kleine-K=C3=B6nig
     35 Dmitry Baryshkov
     25 Sudeep Holla
     22 Ulf Hansson
     21 Konrad Dybcio
     20 Stephan Gerhold
     19 Geert Uytterhoeven
     16 Luca Weiss
     15 Claudiu Beznea
     14 Thierry Reding
     12 Adam Ford
     11 Chris Morgan
     10 Robert Marko
     10 Alexander Stein
