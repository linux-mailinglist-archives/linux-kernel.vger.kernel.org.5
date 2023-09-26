Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42B7AE511
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjIZFbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIZFbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:31:18 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A49D7;
        Mon, 25 Sep 2023 22:31:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id EF56E320090C;
        Tue, 26 Sep 2023 01:31:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 01:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695706267; x=1695792667; bh=+g
        wuMGgepO2RPz72IJGIp9DWb5TMyaffGVqSG2KwnWw=; b=rGfDUCl1MfIYTh8DZx
        rlgpEsGW5zSjfCuoSSAFLBIx6bpKlQqzDi9qVp43ZJwJ+Cj3ZqWyov/aVyPyEfZF
        mFLV9tJYs5xExuB3uVP5xW1P/VBUGlNbXqORUihFLMDr+hp4RrAM+nSEMwh2o+ab
        odEK/MyzDWT4nrjWZ72vCJ4lhdxVzHZtgRHmXwX4+vUKAqeEuinl0JGbouala0xd
        +4M0fWGZGoL1ngutt/lTwL8bymTeITSqT+QtuHITbFt6kMDoA3HVu2dwUKraAfyO
        680mHK4ObiqP91OL2QqTJseY/Vf3pO3TE1uNYnHQWRVYuq9OEsttX4/F4+QTOuS7
        z11w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695706267; x=1695792667; bh=+gwuMGgepO2RP
        z72IJGIp9DWb5TMyaffGVqSG2KwnWw=; b=RlCrIFkbuj9JYJJPmtXcH2nO9vvqq
        U39v7BZvIqaK+6FWlOlmp2ZXEc0CWyqVFUJkmM2EKjmoImzTzxXkIwHU3LhWjPXi
        qj6apIgqS7yisGYscmcAmcaIljRv48DHTTvbFPVrsfoHsoxmhNRtxkOm9wPn1JhJ
        TTkgZixJPSwiLcjxhfwwtz0fR3c02bEx/ZG0jTDU5hxgRgYJbT4l6SIHQTMDBTiO
        khln79W6z7RkkT0TjyGSBYsiu+U3eg0Ds+2OgISN/681OQnPCYrHCF0fThts4mq2
        MLuhUB2pv8acyUKbKjH32rR8KtPsVATZ54NSnUsC+ESatxXuLzhooqMhA==
X-ME-Sender: <xms:mmwSZTVghbF32WRAKRgAyfWzy4y1GfmjS8JuhNOKHtecWzsBbn3XLA>
    <xme:mmwSZbmwC1nALxp__4Ya1BWxso5fw2MnrvXUqIkjGliS6K-UP_5Wx2JsFet1OUQ1s
    f_1VgqHvR2VJjXNdE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mmwSZfbMrLoKSttKyEJ46uhu8vQqLGpv1Rgql82DMu_5I5kLhz2IYg>
    <xmx:mmwSZeW0Y0fEGyS7H_B5cfErFBpT_gFUO08Mx52R2PQcyTPQ_UqqEA>
    <xmx:mmwSZdmHWY_7cvi7WA1_DzrVCTO0BcEzTvFwUK5EnluvmVQoSki_fg>
    <xmx:m2wSZfk0BYJTUS4OFn-LdMOs-UsqUg5jphgMa2W3YrTiMxIWwGgUtg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A1582B60089; Tue, 26 Sep 2023 01:31:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <acd2ae60-2afb-42f5-8bdc-92eae1f77ddb@app.fastmail.com>
In-Reply-To: <CO1PR11MB50895BBE115A20B1A1EEC603D6FCA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230925155538.526317-1-arnd@kernel.org>
 <CO1PR11MB50895BBE115A20B1A1EEC603D6FCA@CO1PR11MB5089.namprd11.prod.outlook.com>
Date:   Tue, 26 Sep 2023 07:30:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacob Keller" <jacob.e.keller@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "Jiri Pirko" <jiri@resnulli.us>,
        "Hay, Joshua A" <joshua.a.hay@intel.com>,
        "Vadim Fedorenko" <vadim.fedorenko@linux.dev>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ice: require PTP clock for building
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023, at 23:49, Keller, Jacob E wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> I tried rearranging the code to allow building it again, but this was getting
>> too complicated for an outsider, so just enforce the dependency to fix randconfig
>> builds again, until someone wants to clean this up again.
>> 
> https://lore.kernel.org/netdev/20230921000633.1238097-1-jacob.e.keller@intel.com/
>
> My method keeps the PTP dependency optional and instead disables the 
> features that required PTP.
>

Ok, that's clearly better than mine then.

     Arnd
