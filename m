Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBF77C208
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjHNVDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjHNVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:02:53 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8EC3;
        Mon, 14 Aug 2023 14:02:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 757A73200920;
        Mon, 14 Aug 2023 17:02:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 17:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692046965; x=1692133365; bh=PK
        wgtqkR2y/xbPvM4PfA1+c92fw2z23WvdUcv3+4Y6A=; b=Vksnh44SXZxKX91cKi
        ZZB0JmenLJqM0l0EmOQ9ye965AMryOOEiBSIZC7Ewlqyq+SKXvZgTIjIlp/T5sGc
        JVfoTKnuWboSv974qal5XQ5p9F+ThdiWJPZutwkp4qvedYIrejHmMQjzCQUFZkxt
        46n+SEo88aKmd3J3AlT8xv+7/D/vG++TVh6iF+A/n5K1yKTXnrYw+andkOeUI35Z
        qhOv7wCUUCUIQ42BetaHUhZf1EMokaTD4z+X1ltHh18TMr8U5hSmGk1T5kFl5paX
        GHfvD+vfVkZs8G1tNpS3QoC6CFzzYjQP+W0fWfGKCoNH4B9/im9f4JQrwK8ONGnr
        gVgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692046965; x=1692133365; bh=PKwgtqkR2y/xb
        PvM4PfA1+c92fw2z23WvdUcv3+4Y6A=; b=g51ohYsBF1oxGw9oHbUkfFQjtr2ow
        AE9TDgZlLnL8FusKBIhMEw/lUbyqapPjR7KPzXczFDgmY4XEASq3nN9QucksGrLG
        VaEf2/LfqdbXYG0hW5+GlNzpDXI75Mq4/zOzKs5xwWSFMq98QLtYKw+ipZUjXSzD
        RL55kk73RE4JYzO8ncuBlxb1YBdQKfQc+aDfVQrZAyZN+K9CoXsRB8Tzo8ECa54G
        1Ox+f0G4yWUQuQsDRLOL2p08UHw56sYGcB2NFJctcPnQuXOfp6NcZvU0/iBHd7h3
        4HO8EvAe7NJC2LhAPY0NDIIctLtaUr/WTcKl3TPbhoHK0KhurqvCpAXmw==
X-ME-Sender: <xms:dZbaZOiYIvJnT0qpkl1KrH1lIasxqseprJGSvC00I7OtpZ76FD1WBQ>
    <xme:dZbaZPCm8ZtPk_OijwGUY4KxPz8l1_tBN9Gjp3SpQ4Be-gwrUDhhtIqAYo7AtQrAp
    9_uxEQ1Ug3KO5Q5quQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddthedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dZbaZGEMgH4ALgY_bQB3Ww5zg-bo48p1Oem-2KG4SGDBDflK1Uzq2w>
    <xmx:dZbaZHTX87NyuY-Cl-M8nI8ABqvr_QUZJJq-DXUPjBr1I5m2Hjao5w>
    <xmx:dZbaZLy4mCWfnjj_B8dipMa4hbDg3fQhuaoEzKurKquScc-Etl41pg>
    <xmx:dZbaZCkIiLQYDVxM_oNacOwAECa8PjXRMA9ZiGl9Cb6mCVhswOPp6g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 69108B6008D; Mon, 14 Aug 2023 17:02:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <b29731ef-0a72-402c-846a-b37d86712641@app.fastmail.com>
In-Reply-To: <9a6b2c18b599e5c2e7cea99fec84a4ecb5092da5.camel@sipsolutions.net>
References: <20230616090343.2454061-1-arnd@kernel.org>
 <9a6b2c18b599e5c2e7cea99fec84a4ecb5092da5.camel@sipsolutions.net>
Date:   Mon, 14 Aug 2023 23:02:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Gregory Greenman" <gregory.greenman@intel.com>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Luca Coelho" <luciano.coelho@intel.com>,
        "Shahar S Matityahu" <shahar.s.matityahu@intel.com>
Cc:     "Mukesh Sisodiya" <mukesh.sisodiya@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: dbg_ini: fix structure packing
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, at 20:28, Johannes Berg wrote:
> On Fri, 2023-06-16 at 11:03 +0200, Arnd Bergmann wrote:
>> 
>> As the original intention was apparently to make the entire structure
>> unaligned, mark the innermost members the same way so the union
>> becomes packed as well.
>
> Hm. Not sure exactly what you mean by that, but shouldn't we make that
> "union { ... } __packed"?

Up to you, the effect is the same, as the other two members are already
packed. I generally try to keep the packing to the members that are
actually unaligned, to make the code more efficient, but in this case
the entire structure is unaligned, so it doesn't matter.

      Arnd
