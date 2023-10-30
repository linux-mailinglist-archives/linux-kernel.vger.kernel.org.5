Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAAD7DB8E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjJ3LUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjJ3LUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:20:44 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417BB3;
        Mon, 30 Oct 2023 04:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698664832; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mm02NCKuU0Thm9w5RBoDg+s36tDjuHMXpViOFYEEnGCOpTftapCaakSlLKpu83Xxhr
    mYOzDqE5zt/r6082tAE92YVJu+eghIPrviwt2Mczeqg0rjlMYQMUgPBpsCPRBnvQ5RdN
    eAsFN/hm/zIT2sgSIvtro+2eC7tpGk6sKoYzLOgLYieeXb8B4xUQgzfRC0ggy86DuYy8
    Z3GYxkbTbxtJfCR9Oz5gS3E9u7CF5PDSYRyofJEA6fN1uBl8GF/MYVQs7jexFlAEL8nm
    C84QZiWoyS5dEiJ6neRHjBWsnqa4/U/PzV7S8x5oARyubab2bh+Y5gBlcnR9z7wjEZ0b
    Tq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698664832;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RKJ07SNymskf0t+1fsv83/i0WSlIOVRZ9TdRpl1TvZY=;
    b=DCDF92/V2tLnAz5TorpoD/eng/Xwnfh9tsDU6lRbY4WwY+qEyeK6R/Vl3/tcYpCBzg
    Z1trDiD+w87dglsoHHnPhp9lCU+qp3DdCUIk+77solrc1T+y+F45d6/2atj4iK+QGjvg
    CMT/+nBW1IdSqV3NLKqf3hwZaiw1Fx1LA8HUzlJ0Vx63wEfu9ryFnQxfYGVdiqBBWOBa
    QkWHVq5k2KOBppxTbW6lRw7hHPYUjUHqhhE50q6eMaZhS5p7HjvmegwULt6Km/U+pBT1
    OyWiBs18L8mFXogn2ZFtao9tuwaKQPiPRJYuiTpy+vxOtX7Sa0Crb0QbT5zJMMjYicrh
    hGLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698664832;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RKJ07SNymskf0t+1fsv83/i0WSlIOVRZ9TdRpl1TvZY=;
    b=KV5VGEJLUr5+xTYo2wk/3Cm84I6My52WBVF+CFrwwc+4GfCSxpB1zpx2vxUn66Y2Cr
    MbJxG44lVzELkNCP/j4oVyLYBhDn4tJH+rsQBpgZNc5ivaKBN4nyRHx9DGWtZBOzUfHS
    XhJ0AZ8ZAgHu05cTqKOs8WIQnBciBJXe7704bNkiA5G9CQFHcl1WrE9IRlaSV7enO+X4
    3q7kSnBhIHV7SyTqGjf98zSI8iUTi6dNd00xckeVUflVAnh0eFxSlabb7n+15GE4MfGH
    V2LcT6kHj6IxYXm5pLnp2nMtvPt4EKcgeF4wYtA4wZEuqUdLQv4mMZa7oZegUBySr/BZ
    qfBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698664832;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=RKJ07SNymskf0t+1fsv83/i0WSlIOVRZ9TdRpl1TvZY=;
    b=GCLMbwHESCbjm7mtI/4BeY6JHr+BAU7Zs5PZ8pHhZTIFJyifQg79xCgjuev7V/Ry57
    2N1UyTl2wFbxUL+UfOBg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWsdNeEDyFXR1lg3JD8="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id 6b1cadz9UBKSU4Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 12:20:28 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     simo@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] crypto: drbg - Remove SHA1 from drbg
Date:   Mon, 30 Oct 2023 12:20:27 +0100
Message-ID: <5821221.9qqs2JS0CK@tauon.chronox.de>
In-Reply-To: <20231029204823.663930-4-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
 <20231029204823.663930-4-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. Oktober 2023, 21:48:23 CET schrieb Dimitri John Ledkov:

Hi Dimitri,

> SP800-90C 3rd draft states that SHA-1 will be removed from all
> specifications, including drbg by end of 2030. Given kernels built
> today will be operating past that date, start complying with upcoming
> requirements.
> 
> No functional change, as SHA-256 / SHA-512 based DRBG have always been
> the preferred ones.

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan


