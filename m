Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E45C7D6E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344734AbjJYOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjJYOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:00:30 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C2C18A;
        Wed, 25 Oct 2023 07:00:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B90105C03FA;
        Wed, 25 Oct 2023 10:00:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 25 Oct 2023 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698242422; x=1698328822; bh=KI
        5w58UTfABvjvptIvDrQdHkWsalGJQZedeBlycOud4=; b=jkIviQ9qbhFEllr47i
        upP2prLGMngnNzPF2D3xx1Kp7VMPqdBmX8kdZeQ6L3BPIpiveh6M1/YjBa8yyPi4
        Y8AvETg4AwRuq2KWdiM4UO40g2DYRTNsQfzLnteGmHe/sEexC3wsDMe3YT4LHeX+
        5TwtL0cmArv4qkILCKL2+RZKU1wuMNAQ6NvSZ8IuiNhJSBCKfmMZI5ppvoIsAI8Z
        Xpcn+5GdEm0cSwXTLPZglYEj91eT4oHL4BigzhV1nhrv/pL0YAcUFY3KroSEv0uB
        34vcsNsW0NtlqFLyGP4CTCB9X3IRZSWJeo8NqPyeYeyTwlEvIyUTjbIcVZML+kWm
        tzjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698242422; x=1698328822; bh=KI5w58UTfABvj
        vptIvDrQdHkWsalGJQZedeBlycOud4=; b=gOJs7LGImdiOAT4LGQkbRHYtNebd4
        MQ0VH8jbq9fCFG/AVYgUocW8DY1Gjft6GBJ8TUWw7iSaonpCE72LPKuHNPfXeqPC
        NT+ZnAjy3tmyovZLJkhGFOdIDKHy7XYbNLSMMaJIF8o1fO2CMyTzOtcR4SQaEhex
        KevFlXZ7W5v0qHfnVPn95/jNhHWvx+SbXCO1lfxHyPCiZLNhk4XmcVDJNBJnlU1j
        Eqo0N04yNM36bBDuwE78nnNWmi9t/1WtcTwz432gKV0/AVp7WZB7c2fP7uAYhI3R
        v3o3WP79G+IerXIuw8CAjE52yEszmXEYvvq+IdDjaPjloEeGL0EHSRLgA==
X-ME-Sender: <xms:dh85ZRZ7X1C2M74qCikQ0Ckt703A8xOJiS18i0DsPP8EOiCvTSggBg>
    <xme:dh85ZYZIe9XUFQ37oPbKZ-_NGcJ8UHbDd3nUNr1hKGiBBPlNRElckC8TLlnuh4YZR
    drUjta55n-VrPQY54s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dh85ZT-djq942ipU6diXlpgBtGg-Vo03bcbF58nnpesEKO1jvuNSrw>
    <xmx:dh85Zfr59r33lMffZS1JAF4eyxiKuKvunjVgK9ETMV1lDZmb-mK3og>
    <xmx:dh85ZcrPekFXq1OJVKIawG2Q9-ZbaLntwOgruiIyCddjAxDHnSyehQ>
    <xmx:dh85ZXVNOiuo91JkYwkCZpJgW67PW-9t2NdUfz065iGbatzffxh86A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4884AB6008D; Wed, 25 Oct 2023 10:00:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <5e5e3e9b-dc16-428c-bd7f-d723960beb3c@app.fastmail.com>
In-Reply-To: <20231025073802.117625-1-thuth@redhat.com>
References: <20231025073802.117625-1-thuth@redhat.com>
Date:   Wed, 25 Oct 2023 15:59:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Huth" <thuth@redhat.com>,
        "Oleg Nesterov" <oleg@redhat.com>, linux-hexagon@vger.kernel.org,
        "Brian Cain" <bcain@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, "Richard Kuo" <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon: Remove unusable symbols from the ptrace.h uapi
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

On Wed, Oct 25, 2023, at 09:38, Thomas Huth wrote:
> Kernel-internal prototypes, references to current_thread_info()
> and code hidden behind a CONFIG_HEXAGON_ARCH_VERSION switch are
> certainly not usable in userspace, so this should not reside
> in a uapi header. Move the code into an internal version of
> ptrace.h instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I've compile tested it now with a hexagon cross-compiler and the kernel
>  compiles fine with this change, so I think this should be good to go.

I've applied this to the asm-generic tree, thanks for the
patch.

> +++ b/scripts/headers_install.sh
> @@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
>  arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
>  arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>  arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
> -arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
>  arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
>  arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>  arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO

Would you like to send another patch for the other hexagon
file? It looks trivial enough as we can just drop the #if
portion there and keep the #else side.

      Arnd
