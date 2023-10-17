Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A907CBA21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjJQF2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjJQF2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:28:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CFF1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:28:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B4F0A5C022F;
        Tue, 17 Oct 2023 01:28:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 01:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1697520497; x=1697606897; bh=wL
        HP+Qz8LerU3OeWBpyC5y5t5EdW0tB4tzStnDJPFtI=; b=M8K0zK+H0tq9hHhm5m
        lyVB8xlP+WOypWt5XdK/WsMgB20W/+vdRYLIk6a9f0WstfXbIzcI3qtuLFTphEwG
        Di5YWQB85/cha9PlMGG1kZJduTrlrHil/m20uXAQhdBEwOXXXbzmKEb6QV3EGLTt
        HzRl32yiPs2rR0z4nMNEql668IZK05HItfN9re7l3Hxd3uXwvopQK58dKxBD1UOL
        zviPXlCLWphrDtZAW0FaicrmAtqeC0f7wAPObyBHOdLxnWmS1dw3/uS/ritgnuHK
        2Xc7csKtJWfJupFl06D8DX4a8cqQR6GQrZSA1EPk4W2EK40z/DHfKuH+vzxmt/48
        Ltqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697520497; x=1697606897; bh=wLHP+Qz8LerU3
        OeWBpyC5y5t5EdW0tB4tzStnDJPFtI=; b=QdG9wYc2YXKhUUrlp7UkAJ3cMP1P9
        HoodHnsLVXQZf3Ws9FQujtIEe1yCuRewRCpWq+/rRK01yXpDu4dto7KMfSN2Tw9l
        dblqRg1Ib/7JIq4UjHBs0tyUHBH8VBgKWWQ+7bf+n7shZ6zk/9T1QeYGNtByCk0y
        vEXivOeyw0OpZip3roucrls8HQEn0UdQZFaXd92Khh7toC1FGhCFTaZtsd1WJz4h
        JTYQ0yw1TGXEkPB54/KDnnC00EJ3paZ7vlPKsl+ov22/nBONgGnzvTFskjejVIog
        lUHO+qD8sPOh5JvBJUEEXONaVmhpJJSycso3dyYy0S/5mCSa6AzyiPKOw==
X-ME-Sender: <xms:cRsuZfYIUD6ckbK2KczAFC1rB2kGsEJ-GkTKEbc-Pa0rx45VZMhgrw>
    <xme:cRsuZebw3k6gvVBs7-HOjZJrPi41S1Y5NQ0ORVw84KICl1KHY1zz_Rhflf8aPY0pg
    TG-7bAKQ4M97kOrd7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cRsuZR-Ow2AWF8nGZxDjFr-c83jg-5uA19kWZzpxgWoH8L7XRFXuQg>
    <xmx:cRsuZVrJahCRdQ6ihfCefuDsG0UhtZFaXGBie8HcIZ2HaQSPrCl1-w>
    <xmx:cRsuZapbmtXkit3UxoAsb43cRQdJrxHlfiZKyLgYF6O_8TryVh8Oaw>
    <xmx:cRsuZXTHLzyo0_GEGq7fJ67Prjs6eU9yhVa7oyohKa7fy8ES7JsrRQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4BB9AB60089; Tue, 17 Oct 2023 01:28:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <f1f8daa4-cfb9-458a-a2ca-10d654ea83fc@app.fastmail.com>
In-Reply-To: <ZS206TuYnhE3PozK@ashyti-mobl2.lan>
References: <20231016201012.1022812-1-arnd@kernel.org>
 <ZS206TuYnhE3PozK@ashyti-mobl2.lan>
Date:   Tue, 17 Oct 2023 07:27:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andi Shyti" <andi.shyti@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Badal Nilawar" <badal.nilawar@intel.com>,
        "Ashutosh Dixit" <ashutosh.dixit@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Matt Roper" <matthew.d.roper@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/mtl: avoid stringop-overflow warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023, at 00:10, Andi Shyti wrote:
> Hi Arnd,
>
>>  static void rc6_res_reg_init(struct intel_rc6 *rc6)
>>  {
>> -	memset(rc6->res_reg, INVALID_MMIO_REG.reg, sizeof(rc6->res_reg));
>
> This is a complex initialization, indeed... how about just
>
>    memset(rc6->res_reg, 0, sizeof(rc6->res_reg));
>
>> +	i915_reg_t res_reg[INTEL_RC6_RES_MAX] = {
>> +		[0 ... INTEL_RC6_RES_MAX - 1] = INVALID_MMIO_REG,
>> +	};
>
> This is basically a
>
>    i915_reg_t res_reg[INTEL_RC6_RES_MAX] = { };
>
> Don't know which one is clearer.

Right, the original code went out of its way to use INVALID_MMIO_REG
instead of assuming it is zero, so I tried to preserve that for
consistency.

    Arnd
