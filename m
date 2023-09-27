Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E707B0C77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjI0TUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0TUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:20:54 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F008F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:20:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D7375C2829;
        Wed, 27 Sep 2023 15:20:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 15:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695842450; x=1695928850; bh=mw
        sCOzyUhDWawqbAJAfKVb/zikzbOamyubM7u6AZcHI=; b=q1Svk/t52RSbrPKR6a
        vGi6robb+A1yqe7F4TqG2Quf8mYd2t7+rymNuoOZtjG32zlSHhbUXACCgehcX0vP
        AcDPgIdV7TUi4Rc4pY6I8b1mo8uPieRM+2It+al0RTTHbAAgi5e9wKj9oB2xyDpU
        IXf6V5PAF6KrKfj0HyQbcEW45txG2Vjcm6I53oLFV3p0e7J2Ru4W0qJVsM5m/+Hf
        sc9vDOpv1Mf/sM7tmzZwIJLfs/ceCF/4aIBgHBkxxMtINKawaRz1rkpP/IYoBGsr
        oROqrhKdCI0grV+bLam63l8pkLrnDPkkjPxo6bSrAstumQJzkSe/CCzWWRTAN0dC
        njiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695842450; x=1695928850; bh=mwsCOzyUhDWaw
        qbAJAfKVb/zikzbOamyubM7u6AZcHI=; b=NxAVthkw4h9tl8fAnw3BDvu98jBcf
        tiqBDHAIEmV3VQ86kF90xP8HVohZaTQxqG7X3UGE/qNAe45JJrsqMcpt0qL7kyMW
        DKeUd26nPrO6IE29mep8QtcYw3EI/UyXhyuVrnZsUTZsNI6M4D2Q6TnxN8f3x0Gw
        LhMytkNk8y4rJc/dJaKI7YjUenKNdvO7BjZTES93ok+i+9tqQwrXLFU+Yy+eAQq8
        tecbPIaedbddiFAT4RedEG6a4HRaYj6Qsr3vhk7hnvO8uj56HTnUeal09c4oQmQB
        afOi/P7D9TwS7bOnQeh3Cvv8bhXy+TuDjkAfOxCBg8LUbDyetBS/qWF1g==
X-ME-Sender: <xms:kYAUZV0Of4AArJWsDG5h6tr2hlhfyKxRVDmfy5YHmLDIlH6xrwrQCw>
    <xme:kYAUZcHHsggcUyEwowHMmNjQRwqoM95GD2z_GHjwO-_KdK_cmkX3emItB7nWgyU8V
    R7biwrXjFmnEfT9ydo>
X-ME-Received: <xmr:kYAUZV7L4s59yNdxGDkjoSA4tfDyvLHs8jGSA5UN1J8RG7k8hEHhb-9VRQcs_u3H_A1tuwn1mAdvPifoSgsVXis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpehgrghrhihr
    ohhokhgrrhgusehfrghsthhmrghilhdrohhrghenucggtffrrghtthgvrhhnpeeiuddvle
    ektdfhgeetvedvjeegkeeuvddttdejleefvdeuvefhlefgveevieeukeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrh
    gusehfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:kYAUZS130hyf7U3ZUoiEOoBm1VvE5OyN0abRcJXXDihKYNAQD656Cw>
    <xmx:kYAUZYHwbnxJwqbo-KnJGUYd9tu8kDpv_3pnwqF_WmpOCrTIEae-TQ>
    <xmx:kYAUZT_pIr0eIwoy5prR1gL4S7SSgcq5q46F2iLQwiUKQvv7JrGs6Q>
    <xmx:koAUZdQsHZDqh1dg9f0-FC8tQjXZvB4-6JIQXJnghR9WTvLRkaSCLw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 15:20:49 -0400 (EDT)
References: <20230927112635.27637-1-garyrookard@fastmail.org>
 <cb28b28a-64d1-4a38-942a-cac31e0dd48e@kadam.mountain>
User-agent: mu4e 1.10.6; emacs 28.2
From:   garyrookard@fastmail.org
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] staging: rtl8192e: renamed a variable
Date:   Wed, 27 Sep 2023 15:18:24 -0400
In-reply-to: <cb28b28a-64d1-4a38-942a-cac31e0dd48e@kadam.mountain>
Message-ID: <87v8bvjudx.fsf@fastmail.org>
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

Can do, have one already done that way...
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

