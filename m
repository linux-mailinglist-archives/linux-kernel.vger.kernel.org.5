Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEF7BE928
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377542AbjJISXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbjJISXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:23:31 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137129C;
        Mon,  9 Oct 2023 11:23:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A83B5C02A5;
        Mon,  9 Oct 2023 14:23:29 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Mon, 09 Oct 2023 14:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696875809; x=1696962209; bh=Wc
        d9Ij4JYV1E+nR/hpGySlpt2XMckRY/pSxHN2nuT44=; b=XV7aUMVw6tBmZF3184
        benoVGAqBsGo6v+7HlonfIiZ2GxFf+B7g/2BoXMSSxJxX1Yvb88PYiXT5YaD4yod
        wjnvP9vFBgO/REAxQc3h84AdLI351ANAvIlM59fYsk+8uLEAWze3aXTwUVZdJJQw
        FHJCONrZSeQnPABoXquUds7I+7OlWSnHjUetjPQNgIKT7vAjDuLO9oryuRtqpzDX
        gKX296v1suXSoXehtKhgs1JV7H0t6WVMbz4PRAwoSp/zSxmFhdps3nb/UsbY0xTC
        q8WRta6MXRTD/tO9huHomZj4jCa2Ig8YAIIy/c5h2F0lyoYTHMN9Z916aPjQhH/T
        AFZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696875809; x=1696962209; bh=Wcd9Ij4JYV1E+
        nR/hpGySlpt2XMckRY/pSxHN2nuT44=; b=bFwMxcn/u/mOSCI/OoRvcCkh7yPnT
        PEUWerddl5JyuFUlZuj8wKEfufOjYZXmVZBzpXnkP7aqabXUS/UnyIgO9oA9iwJJ
        wVYnUNF8EIReb2/VPhqb8S3iHcjMVXkMxK/laoO/ajSFqTyU1fJFbpTTfPvVbj1T
        ZsLwdBcafWXJ7vFw3/Yfy8rBieGi9JOrBZ7KIiVGdo8uVNhmczmuWsB0ZxYOFu9B
        MSJB5a1QhfioUudWn7yybpmgV3bPZRPcop8arFqsmN1JmwYNiAav/NnjthnvE1Uq
        3uBjUds8dHkIU+Fw/i2GBKjWB8oHlFhRijfP6ZLqiRsLQwTYOagopq5Sw==
X-ME-Sender: <xms:IUUkZfx61kLuqlmo_Xzt6mxU03h4sdJtBGdE6bwdxFtLLUDD82MeYg>
    <xme:IUUkZXThFlhaKZOfEz0udhCU2YQmizYf74jZHxbMRWlkaUUIR4ju_EsIxKixDVrp5
    7rB5ttvswOf0wmuXPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeetiefhjedvhfeffffhvddvvdffgfetvdetiefghefhheduffeljeeuuddv
    lefgnecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IUUkZZWOnHZ6D_AxNeVCRq48W-cLG71GQCa-yh5fcIdqIfw_-TupmA>
    <xmx:IUUkZZj_ARXhwR4BgEavEGWjgVSLRNF2IFmBYPV6E7RXcBc8zwvDLA>
    <xmx:IUUkZRAo4Gl-XuQUUf5XAr51WrvBtD0DYn9pqbHwCZf_ZN6C3UU0pA>
    <xmx:IUUkZZZJzi5o-nTsyjt6CK0RtWwN_XVrxH_wbLntoKHmaGTZ_IknIg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E93751700089; Mon,  9 Oct 2023 14:23:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
In-Reply-To: <202310090902.10ED782652@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook>
Date:   Mon, 09 Oct 2023 20:23:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, "Chun-Yi Lee" <jlee@suse.com>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org,
        "Iulia Tanasescu" <iulia.tanasescu@nxp.com>,
        "Wenjia Zhang" <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
>> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
>> 
>> Sorry, I have to retract this, something went wrong on my
>> testing and I now see the same problem in some configs regardless
>> of whether the patch is applied or not.
>
> Perhaps turn them into macros instead?

I just tried that and still see the problem even with the macro,
so whatever gcc is doing must be a different issue. Maybe it
has correctly found a codepath that triggers this?

If you are able to help debug the issue better,
see these defconfigs for examples:

https://pastebin.com/raw/pC8Lnrn2
https://pastebin.com/raw/yb965unC

     Arnd
