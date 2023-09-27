Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9317B0C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjI0T1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0T1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:27:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147588F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:27:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 815ED5C2870;
        Wed, 27 Sep 2023 15:27:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 15:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695842822; x=1695929222; bh=ts
        90YHb/UaoHFjOysxvIPXihv4YjnfJXAbM5VWK5Xn8=; b=u/LotQs6nK0oJTv88m
        CVRuvzao2gf8Xai+cyoXc3D4gUNL8D1MKrJcClrOV7aOEMfes83JeGoB1+Ba2sZv
        2bvROOIrflzJnbjJD41mKyd2doBifbaNoJTLDrxvSZ0VOTyQmNyebv9MZwSvvLxs
        sXwEhvKxC21e9rpRXJ1WyPyGokJzkvUQgfn1IDlrruZm8weh11bp59SUlRo/D0qz
        bh6WN3a8RT2qzvD8W3EFDbQkBpLhZDpfEvcwCWIB42GMqZ68zQMeiIOBM11V68sT
        pBsg8jZe3Zg97DbMaB7NtlXuRfYjeiHa80TWWMvG6aUA/wjNJH3S1ISFjsNosLUm
        eduw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695842822; x=1695929222; bh=ts90YHb/UaoHF
        jOysxvIPXihv4YjnfJXAbM5VWK5Xn8=; b=DaIK4/ohHVAu0Pxxt6pOtYkXckHNx
        nlJfu+NAC0m7E0L536vs7SlXOMY47XZqpSspLNGIIn6N9+3bOoa9FyIgfkOWmZU5
        YK34uSd6uC2uyqYRo0X7s/zvIN4SCRRPhF+tXLYj+zsGSizHVFcb//cArS+6tAcv
        zgocvcSFUwJ2oF3tSNvcwDzbTXHHjIAoe/xjryuwqh0DtAd4u+f5K/mT1ZqqQqTA
        8Og4qiAODfJtoFqK0L/WS40DOWY70kcx8LYJ7AWA6xgTUJmyOJKm9IQZrqDIUFcP
        RhOXL+RciHl9uoQYPzZ0d3jeSnzB0vYkG/PZRNSwbi5DE3A7jHRuoysdg==
X-ME-Sender: <xms:BoIUZWpH2Oq-LXZRkwxzTE_TTL2KjK1KPBvIEAYcmxgf8oiFNHJffQ>
    <xme:BoIUZUrA7VeX5V0POSPmgnu15oH41CnuWYoEUX_X9ljKxeyOjEqk2tznmVV252y7s
    _f_Rmyv0Ri55zaogTg>
X-ME-Received: <xmr:BoIUZbOzlXJKkmdY9mu_m26nDHuqRXssU3KWBOn8uoJz9m6luxR90q0z2l4Q8fehrDQIfxh_jHbBPPRWb4gJhIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpehgrghrhihr
    ohhokhgrrhgusehfrghsthhmrghilhdrohhrghenucggtffrrghtthgvrhhnpeeiuddvle
    ektdfhgeetvedvjeegkeeuvddttdejleefvdeuvefhlefgveevieeukeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrh
    gusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:BoIUZV7BF3Ej7DPJXuw1qVgpWj3uxrlOOda8qAXuVQB2LuAy64836Q>
    <xmx:BoIUZV6Nw4Ee_jQhiXcUDPHaIIYE4Ix2gcuXsQsOzRwCVxL_brluhQ>
    <xmx:BoIUZVhB1EiiijRf3LJ2DnkTU56TcxXdOQ6JtV6t_Ih7WMzpZJv9HQ>
    <xmx:BoIUZVGoY7yH6m3d01sRU27ZjiZm2n5PcHeCR73v8-PwVAQI-3TmVg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 15:27:01 -0400 (EDT)
References: <20230927112635.27637-1-garyrookard@fastmail.org>
 <cb28b28a-64d1-4a38-942a-cac31e0dd48e@kadam.mountain>
User-agent: mu4e 1.10.6; emacs 28.2
From:   garyrookard@fastmail.org
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] staging: rtl8192e: renamed a variable
Date:   Wed, 27 Sep 2023 15:25:11 -0400
In-reply-to: <cb28b28a-64d1-4a38-942a-cac31e0dd48e@kadam.mountain>
Message-ID: <87r0mjju3k.fsf@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, already have one done that way.
Dan Carpenter <dan.carpenter@linaro.org> writes:

> On Wed, Sep 27, 2023 at 07:26:32AM -0400, Gary Rookard wrote:
>> Hi!,
>> 
>> This patch series renames the same mixed case variable in (3) different
>> files of staging/rtl8192e.
>> 1) rtllib.h
>> 2) rtl819x_HTProc.c
>> 3) rtllib_module.c
>> 
>
> You need to do this all in one patch, otherwise the kernel can't compile
> if we only apply 1 or just 1 and 2.
>
> regards,
> dan carpenter

