Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AACE7854AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjHWJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjHWJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:48:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218135AB;
        Wed, 23 Aug 2023 02:32:34 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692783152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VeSfpItWWsiVPOaQx4i05Q+Bqd8SVCg59nQ18ddVsVo=;
        b=ekHI7Co+RWBHRJJHfoWyYKP9Eel4H1x4kP37l/BTSwrcdeFWIM4u1tYbggZqUKDxGp/RUa
        UKT4EnDUZoI//MnXdllsisH7xt6GA/Pro8BUiBPm0xpEqqvo409OoqxgH8l7qETYQS16qb
        Y7OtbktXMX09AKYIe5+JR3I+tAt2vrbIxoSZgGmVyh2d5Gqe09y/F2RYwxhqv8oJSxM+BK
        XQa7lvicGZqzPJBRhQCowDuo14Xu59F6RZqyqJ6QOWe7nZYLKm+uGGWEsn/hSkI9Ly9XFA
        Ntwl6+nE/tFcefMVxCDFeVNFU3dTklzl4YSo2gl5YwaunI5zeF9dD4aMBi7jhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692783152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VeSfpItWWsiVPOaQx4i05Q+Bqd8SVCg59nQ18ddVsVo=;
        b=aXA8rtnXAT1bzQcH3hFLNBGbvDyd3DfK6dgkDLAkjqj2ThD3DwzotDpDthTHGfXhieIfPe
        1KBDh04J9EeDpeBA==
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] net: dsa: use capital "OR" for multiple
 licenses in SPDX
In-Reply-To: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
References: <20230823085632.116725-1-krzysztof.kozlowski@linaro.org>
Date:   Wed, 23 Aug 2023 11:32:30 +0200
Message-ID: <87h6oq9k9d.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed Aug 23 2023, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

Side note: The SPDX spec in section D.2 says: "License expression
operators (AND, OR and WITH) should be matched in a case-sensitive
manner.". Should is not must. So I assume checkpatch and spdxcheck
should handle both cases. Especially because:

|linux (git)-[master] % git grep 'SPDX' | grep ' or ' | wc -l
|370

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmTl0i8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgp+2D/40M9rak5oGE+1/bC962iDJpViQkwyy
GqbD0/9G2bne6M+ljD9TvkoQMbF9mky0ARjtDe//lVH/x5m9X6cPhcXH0/lRPpbr
XWAHlq2YykEVyXxlGWS0Wb+4asB89GP2wRiJINd8ysKIzkHE66hPLjpviMudA0v2
qkyx+HsLGdAgf6Vuyc0fn218eYo800gyg6RBD7BlfZv+5KKyfFErOYXw1ULRsgxw
+BfJ/ZVwm8gLp/DhKSh0noa6q4jDtlYfYKaTbO/wxUHTjYq5UAF7HqrER69Vo4HO
uWOsnP/QjXZUgL3bVdmUCy5zC4V6XEE72yOpfn0G93i7exMrT4LUMrvbX9dgYBPG
UjGeruYuaPN9XBMfTsIMl5YpHOjuHCXHsWgk0Sxg5b8oH6c3PZ2DTS1rF5B8hpvK
5QtAUGG6UyoWVeJawnl5+Cvotzp2zzJNXGHc9oPBudCgcF0TKwJkPFhz0grMbnlH
7Ch0DFmC3TXRiW9CY9Qhjuo5iOKcF4v9PqyIwAc8lUipK1kzHDexQd31Bj1F3lS9
tGEojJuAG63InJrz760//Ikx/WzoCRsbNYVO7R+DMcBBqCbZvO0njbkTrNEWVOVP
2RV9kLShAFxSlwfuIlryxC0pepuKSj1GjfOL/leDeBsE1IWmYInJss4sMGEsaJPa
2vZBVbAuA7ZwDw==
=IxXf
-----END PGP SIGNATURE-----
--=-=-=--
