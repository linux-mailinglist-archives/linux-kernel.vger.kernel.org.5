Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2F379F3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjIMVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjIMVRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:17:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BD419A0;
        Wed, 13 Sep 2023 14:17:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DBB15C00CE;
        Wed, 13 Sep 2023 17:17:10 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 17:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694639830; x=1694726230; bh=2D
        CLnmcqbeJcLbHMyYWTOk/2hFdchUOr/bffN5DYUjA=; b=hFSZISYnmgONLjrajz
        IARN20iioHx4e0z07CKF2J9XCzubhCvQIhC9q/QP6JeC49HsoW97NWA9/sNMiyuz
        ZlJxIWPRBJJ8vyUYaQgt7uQWUHS4nO/qRgm/jzVkzhQxW+iHj008LAtm28OeOVLM
        1puNNss2kerVDrDZM5k/7dlHiAcJ08e7r4eAaRXBjZ7ZCof0yntGR/EZCsq0K9jg
        yqoZfoXvbB8lopqrIKP+vEsxnHe/48P7rpkjOEX1rXyB8PuAzaTdUJIKZ+xJ69ZX
        ooWmjJqi2REjFQ1d5A3tw3RNI3Cg/0Yl0dBv+fHaXFVOubObS7ibjMLLSdDQMHyr
        xT6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694639830; x=1694726230; bh=2DCLnmcqbeJcL
        bHMyYWTOk/2hFdchUOr/bffN5DYUjA=; b=W2wz8OaAcdAPUtH2KSq/xOFW1/O6M
        919yPmbpK0xaB78Dq6YZzFTNCmLa5APlVvBbJTBQJ26KVkae3Ykv0iDgHnGuR8I/
        6iSBMyKcWkApEY0ZCy5OTzP14tOJgvOGmcuHwpaho2gkO75aMq/aC/LOQG2TXeuD
        RInlrAexmOtO0s2ZJ7iDT7NqmTtOI6PUXR44t553heP182OqnFGsa8Bw4WUfKz5z
        39UT38FGKGY0VeyNwyWfKGHWAXaG1imbaQPJv9jw+I5MLQjPZR27KFFgHn9O735B
        zBhgYvCkYj8iFL/nHHqCIeh44zfl6qtH0BOWr/rSvkaw3kRFSZlu7KAzg==
X-ME-Sender: <xms:1CYCZRsNw0g27c-ZCydeQXSsaHxnIfeQqGGXfKI8HSoBJe_kC_nwlg>
    <xme:1CYCZafyrP-Ut2grj8IM0S-rEP9Ka7jjkHgXD2-UVMdqxWh7SSQxSC3JCDdxcuzko
    BhnQLwkgQniuI9gl1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1CYCZUyz-blYP1SIwFwaqd4YBkgr_1EVOzpaXfF1x079PjsmTKmHkw>
    <xmx:1CYCZYMLW_1EdJUsE9KTGrAORDvM-LBRwouaB3rmaKoxPDHX84DQzQ>
    <xmx:1CYCZR9dIx8cINAMoQcNm8uQEGHwRsA3rC49pw7GinQOUUQO_YTdCA>
    <xmx:1iYCZdQG7CHKJQxsYSaNsPJ8ssjOuZFeHddfp4r1ex7dlO_sbu7KAQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B67BB60089; Wed, 13 Sep 2023 17:17:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <c7c6de7b-4adf-4625-8f09-8f419869161d@app.fastmail.com>
In-Reply-To: <ZQIcuVgaDmA+VdV0@fjasle.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
 <ZQISGujwlH00B8KJ@fjasle.eu>
 <b234530c-88fe-4a2a-993c-f1733fe4d0c1@app.fastmail.com>
 <ZQIcuVgaDmA+VdV0@fjasle.eu>
Date:   Wed, 13 Sep 2023 23:16:47 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nicolas Schier" <nicolas@fjasle.eu>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sakari Ailus" <sakari.ailus@iki.fi>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional dependencies
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 22:34, Nicolas Schier wrote:
> On Wed, Sep 13, 2023 at 09:55:36PM +0200 Arnd Bergmann wrote:

>>    config FOO
>> -       bool "Support for foo hardware"
>> +       tristate "Support for foo hardware"
>>         depends on BAR || !BAR
>
> ah, thanks, tristate kconfig symbols are really more interesting.  But I am
> still not sure, whether this works as proposed:
>
> With the 'config FOO' above and
>
>   config BAR
>   	tristate "Support for bar feature"
>
> kconfig allows me to choose between these:
>
> BAR=y  => FOO={N/m/y}
> BAR=m  => FOO={N/m}
> BAR=n  => FOO={N/m/y}
>
> But with
>
>   config FOO
>   	tristate "Support for foo hardware"
>   	depends on !BAR=m
>
> I can choose between:
>
> BAR=y  => FOO={N/m/y}
> BAR=m  => FOO is not selectable
> BAR=n  => FOO={N/m/y}

That is indeed the point: if BAR=m, we want to be able to pick FOO=m
here, otherwise it is impossible to enabled everything as modules.

Another correct way to express the same thing as the first would
be 

config FOO
      tristate "Support for foo hardware"
      depends on !BAR=m || m

which I find even more confusing than the 'BAR || !BAR'
convention, though we have that in a couple of places.

I just found another variant that I had not seen before:

> (Re-checked with BAR=IPV6 and FOO=WIREGUARD; CONFIG_WIREGUARD as 'depends on
> IPV6 || !IPV6' in its kconfig definition, and both are tristate kconfig
> symbols.)
>
> Thus, it seems to me, that the intuitive way is the way forward (and several
> Kconfigs are out-of-date with regard to 'depends on !X=m'.  Or do I still miss
> your point?

I'm not sure what you mean here, but it appears that one of us
is missing the point ;-)

      Arnd
