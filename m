Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10597DB7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjJ3KY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjJ3KYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:24:04 -0400
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 03:22:22 PDT
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BBC1FDC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698661160; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=d4CbDmW0lzFZGzkJb9PH0ojbkA0f2VawzUJDlauAvni4yvhNc9DOTv+wVacGgeG8W/
    MgvHfmhLC5vgIyjDyubcB9dor0zShPpPJ7fIQpd0RjAFjTi5ko0smu+dMbBJdaRH86Gl
    VTZMmILuoHtAKo7177spVaPnqlXyRbLdWYNx8tsI+K8x6RMpGsGNSCr6FjnTKtypB/yg
    qFzo8EoNA8dzOMC+gBpHQWLmJYbO+lHo5LELn1Y+szh9EQn8L2BOa4NioZAWzyF+rRGK
    Nh+OHcgxLz5t0+4nKuMcXkbM+ylBQFpoDZkerSQiicKB4mmoV4YmYbzUsqKfrWksYHHJ
    LGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698661160;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jk9VHVG1Y85+swsU8ss+ygDPPDTaFf9QKwd7qXdBves=;
    b=SNmfnrjkqxsqWvAPWo8fuO4LRlWjfICoU9nFD+aAHdqHZxJSfdVDs/tFNW7Br/sW4h
    pqnWqni7+wj8JxMacGC4O8HNHo9b2yJWrjD2a4BefHLp/RxLYRbCC9O42BXlPd18BBTk
    h71dwWXdbE8FgRspDx1OqSgj+wgsM1334tZ8RskW5Bd+mErColZCxdgjnwbdFMRYIuWz
    JeZcUveSsn4olEUtDD02CC0n8iIWGk/5FENx1VVfA2jwjOHtrpB3okKFFo29M19Tb+xP
    esmhCOWpDQWQ3GZ0ENOaAs6ZDfseBiwMrAt4keZAmFjGqPY7mZXgy0A7KSui0uivndeO
    RwSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698661160;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jk9VHVG1Y85+swsU8ss+ygDPPDTaFf9QKwd7qXdBves=;
    b=Z5a0uy8cmCwMtg0A6VcwfGhHSQBKUzcpzwweimmh6I3WvpbZDW20cKttQXkkEuJWRt
    JroPhd/QTjKdU129GpiJ3JqRk0K+AVr/hH9ZsWVDunzPqikZSqGDKWCGEZCiSMn6M17N
    KmYfTJrye9I5oq+/xjpwA7OnAgbszrFbI8EhzaVVXOr1qe0V4ivqyJVQ/syt6b3PFyFL
    7vXNds1Vm7UrchuWUoKrJMxRUAoK/ldB/a1mFX6XO6aar7y+0cWGPY3Xl13Q3ZQqXixn
    OLplRHyp0giP/0AmAStXqwbyr8l6PWzKCx6nzloPMN+JLOtnwgA+nTMGyIGhvq4WlyaJ
    j9pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698661160;
    s=strato-dkim-0003; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=jk9VHVG1Y85+swsU8ss+ygDPPDTaFf9QKwd7qXdBves=;
    b=B57cX/UMpWnZ/25gaPZQHfZejXbhVTSYM7IFJVghMrlklbCnl0E+uBVEa446PEs8c3
    hNfvD63oJdSbq5dGAhCA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9yWsdNeEDyFXR1lg3JD8="
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 49.9.1 AUTH)
    with ESMTPSA id 6b1cadz9UAJITbU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 11:19:18 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     simo@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] crypto: drbg - ensure most preferred type is FIPS health
 checked
Date:   Mon, 30 Oct 2023 11:19:17 +0100
Message-ID: <2739240.yfhAjsIXQE@tauon.chronox.de>
In-Reply-To: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
References: <20231029204823.663930-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 29. Oktober 2023, 21:48:20 CET schrieb Dimitri John Ledkov:

Hi Dimitri,

> drbg supports multiple types of drbg, and multiple parameters of
> each. Health check sanity only checks one drbg of a single type. One
> can enable all three types of drbg. And instead of checking the most
> preferred algorithm (last one wins), it is currently checking first
> one instead.

The purpose of the sanity check is to make sure the various thresholds are 
effective. For this, you need "a" DRBG, no matter which one.
> 
> Update ifdef to ensure that healthcheck prefers HMAC, over HASH, over
> CTR, last one wins, like all other code and functions.

I can see that this patch makes the code more consistent with the rest. Yet, I 
would doubt the "Fixes" indicator below is needed, though.

Anyhow:

Reviewed-by: Stephan Mueller <smueller@chronox.de>

Ciao
Stephan


