Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB077B4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjHNIty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjHNItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:49:32 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB41996;
        Mon, 14 Aug 2023 01:49:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 42ED85C0113;
        Mon, 14 Aug 2023 04:48:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 04:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692002938; x=1692089338; bh=+3
        8f974ozKkBT9tcgLskyLKWI6WqBjgFXMu9A+bbIEo=; b=B22MYGgwXdnEmy8M2d
        zWLg6JuwwXV2G2YCaDTI7uKoerGnU+ZxNpSwWdlycgF/6eoXy2EqWXKldGCVBTzw
        0YhpXs914ahvndhEQKzLCA9StBhITBc8f2MlP6t1fnaxMppSHapgepaoze26bKIu
        EgRcxzcVM3gpsx5ZMCcdCFk/jOE38kYXzpNPOu+Z1Sfab1IhXiSDy4rtf1qIdNor
        VfsHox8IszRpqKd/2DjKeQYx9cLGqfknt2V9PgKtp4hW0ApuQPc9wQ+LD9kt6X/P
        TtemuXAF+2Cv6oIw/a/J5fpNpSmiY5Y05YK1hXIQHZRsW/h2R3ihVP/1UpM/gKXh
        NUhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692002938; x=1692089338; bh=+38f974ozKkBT
        9tcgLskyLKWI6WqBjgFXMu9A+bbIEo=; b=FMMKiKQ3eTY8Exyaqh5kjBDFVCvc3
        4kyc/RmzH4rIYlAUAD4AtkPpebSrQA4smGzrRDpJNJ5XycLp/cNRFwFrPf5sDQ4T
        YiUWvwYxyjQpcECQDbD9jRjMGCdyMYLSZ6TDO82RRkNpl4e6fVO3tb0e3GZYjnca
        rKHi7rCqAFnJ1BuD2P4kgk+eAa9/RwGn/zD37oQ/TcEzqjK8uhw6lTPRk2eNa1i1
        Z+LB7FdbIYMhj9ual7ct/O3KovznklwIW2PwmFEI8eIiASnlsWV8QNlfMXQMDb7S
        kTCsZ3Kn2lXYD+ip+OwEuMeZstUVEmqLwsKXFXVapMLCrC5Ex7llty0dQ==
X-ME-Sender: <xms:eerZZL8aRC20yjBBS2npS-JtXIbOZlFAVUXY494CC2Qz99ZuEfzQWg>
    <xme:eerZZHsZEQjLbG3HRhrBRCfPqIlxXwe2wUaCNn2phtL62vNTpmFHLqtluDc2jWP8Q
    WlAwP53GjV1bRfBnBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eerZZJCz8OpEvWKVptFhKM3SgsMeuN-h73T80NLy3ycUpGWQkwxpvA>
    <xmx:eerZZHdAc_fB5_SFyja4iqbTx3yHVUGx6u1QBzviW7niPRiIQ5tLOA>
    <xmx:eerZZAMh9cP0idKfjIj0Eb17NGyvegpH1tXmLB5OQZQvvZkgXVczEA>
    <xmx:eurZZHf4r8y8ShWkGtHBA1Fx9n3Vb0fh4nlniZDTYOyY1koBgk8T9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B01E4B60089; Mon, 14 Aug 2023 04:48:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <1834eee9-3fbd-4bea-9e22-960ca993303c@app.fastmail.com>
In-Reply-To: <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
References: <20230814073924.1066390-1-arnd@kernel.org>
 <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
Date:   Mon, 14 Aug 2023 10:48:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "xingtong.wu" <xingtong_wu@163.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Hans de Goede" <hdegoede@redhat.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "xingtong.wu" <XingTong.Wu@siemens.com>
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, at 10:27, xingtong.wu wrote:

>>  
>>  config SIEMENS_SIMATIC_IPC_WDT
>>  	tristate "Siemens Simatic IPC Watchdog"
>> -	depends on SIEMENS_SIMATIC_IPC
>> +	depends on SIEMENS_SIMATIC_IPC && PCI
>
> The SIEMENS_SIMATIC_IPC_WDT does not depends on PCI directly,
> it should depends on P2SB, then P2SB depends on PCI
>
>>  	default y
>>  	select WATCHDOG_CORE
>>  	select P2SB
>
> You can replace the "select" to "depends on" instead.

That would also work, but it's generally best not to mix
'depends on' and 'select' for the same symbol. Changing
all three 'select P2SB' to 'depends on P2SB', or removing
the prompt to turn P2SB itself into a hidden symbol is
probably a good follow-up patch, but I'd keep that separate
from the regression fix.

     Arnd
