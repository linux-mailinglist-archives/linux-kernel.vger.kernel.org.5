Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9A7BB65E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjJFLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjJFLVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:21:33 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CA7CF;
        Fri,  6 Oct 2023 04:21:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4ED2F3200B33;
        Fri,  6 Oct 2023 07:21:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 06 Oct 2023 07:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696591289; x=1696677689; bh=Cy
        R7lG6QBSFjZPPbdn0j8Q5f00NRMzSXiPPzTGPt6T0=; b=S7hajgv8lmj7j5dno/
        xH8mtRw4bNVv0Q2hPCWNljZfo025DESDGcIA26gt6lAjKQuDHOreUf/I/dcmmLyS
        UXyJ0wgm2KOlPvbZXvexxewMzfQ0c0fxVMdU/LU0jodOoJKuQY8JXYci4+X8fZfK
        jr7nmquSU2cuOm7kG7b3lObu02ksOtJ5n6j41Laj3BMeth4i4cFMaBGut3WK5C3P
        qa7UGo8mfaUDqY02ZCew0HA260E2o5yFK+vWk5oE3Y753LI2K/uQPb7ltk6VulBO
        mhvZVQ1u5CcrJhc2EHP9phFFDA+Z3RotSIwxLa3SOdtUUKgk3A5m5xjD1WZA+VF7
        G3Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696591289; x=1696677689; bh=CyR7lG6QBSFjZ
        PPbdn0j8Q5f00NRMzSXiPPzTGPt6T0=; b=J3PSvSIXOkGxsWeqFxO79occYSORj
        Xdb7ZArV29KAUI7NpFLVqOJMu8Adn0AI/udEMkbbgOunzU3U5DfVXE1vJxmRLfok
        5MVtscw7oPKPpZ9wr/kKC/dOfAHzAzO2FFC0i8TR880IX0jALKkwstgc1f3gk8Oh
        f6/0LmYQfqLOfNpiTj0CDsKoKRamU1ajuo9n8ondXI1kQnXScMwRKotNWpI2p9ab
        jthW8UqSzxdl63UYprK7KueKpnhOoRhupP7oMgjJFkTx3LqLaKsboQK9s4z/MWwI
        xfC1IQzGqnO3xuMBrU1MMD25QY9IMqKkOcbzwKf0PFidhm0uH8yxvzg0g==
X-ME-Sender: <xms:ue0fZZ9mNLdflD4eE1wFW1jAUnSzs6GawvPBWzv5SaHYGlVnIuLAbw>
    <xme:ue0fZdunDNp48IvWvFu7yXipNb009L23w_cc8hnOQCaT4yl3qYOuyM5VgQIKVZzz0
    Nk6R4hBtz2xiTc5GMU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ue0fZXCSdtVGkWjcgETBdpr4YVBYWPSy72Q3QgAC-77bbZ058yZXRQ>
    <xmx:ue0fZddlMM9ikEpCjKszuFQhJaz8w48GZzdMJqO9eiCSza_Qa_q1cg>
    <xmx:ue0fZeNKkkNRh31d8uj31WRJbrwEhfqN9gGrPZLFQ_zTigEISyFTKg>
    <xmx:ue0fZfFb_etiEcMUcSYDBqt8a9q_fXh5nxh-P2TWDgsz9JbF85ZLUQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 80D1FB60089; Fri,  6 Oct 2023 07:21:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <52274cef-5334-4e97-a0c2-de7577e3e326@app.fastmail.com>
In-Reply-To: <20231004161038.2818327-4-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-4-gregory.clement@bootlin.com>
Date:   Fri, 06 Oct 2023 13:21:08 +0200
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
Subject: Re: [PATCH 03/11] MIPS: support RAM beyond 32-bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023, at 18:10, Gregory CLEMENT wrote:
> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>
> Support platforms where RAM is mapped beyond 32-bit.
>
> The kernel parameter ddr32_alias allows to setup the alias to point
> outside the first 4 GB of memory.
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

This needs a better explanation, and probably a rewrite.
Having to pass the memory address on the command line does
not sound like an appropriate way to boot the kernel, so
I think either this needs to be detected from the running kernel
itself, or passed through DT.

      Arnd
