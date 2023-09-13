Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8692979EE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjIMQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:11:31 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293EE54;
        Wed, 13 Sep 2023 09:11:26 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Rm56g4ffDz49Q8K;
        Wed, 13 Sep 2023 19:11:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1694621484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h7a8ucP8OlgMP9E+mR6T6bGim5pEzo2GJ/i2Eh3LWM0=;
        b=dvuZb93e7L3oxNJKpK86FYe3Xqe7STvJcUGiX+Igo/U8tYiTgjBA0Y+F2dkMxFXsWo/URB
        kmPiKE51biJGIjoBc72Kfs5FCZaGA+jnxXJ3ZgrleyLMIw4+nZsIQcxQFKv6d/wJFRlw8l
        8nrWr7ikzP0xxUhOQ9k05xtKjNSc3Hcneb8GK+Dt6ESBSK6nGp6G8J4SoRwdfiAn1q62eS
        B0UUrfp2s1EafjsWJIQpwUz+ySkgZIk2qssn2Mp/mxgfvkGwQ0SG514L6tEvD4v7jGifG6
        sdGZvmdnE+yH/TO78TD/pJ/2MGgMED9soYro+53O0+cA/dF47/Q280kZcLu0CA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1694621484; a=rsa-sha256;
        cv=none;
        b=jw3c6YFGnkevAnDThOYIu3Zo0N4jiwrMZcjTHHYhmsPxLdLkGHLebwr1O/GYMZq1TUcUgw
        DUK0U31dCqX9DLRlnFIzr4zL1aho/6JERXKNlXAHLWfArktmZ2T1tE0bk7v2CB9Np1ICRf
        KePK2sFvnIE7auSMApr8LanjjCjvg3yFbjUmeLAq09Zo4R3yDXw6kslWu/U04q8YI5Pefo
        Hk6XSGs3R04kCtgHTIbGsAwVRq6GljZA6riiSBZA0EaoYmCmOtNnM94fjR9E/LG1cNDrs1
        ZCL0CDyW3FSKN+IP3wifDnCD9NcupJlgIqkJ24F+++undg4ZZr0wssO93Cg/2g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1694621484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h7a8ucP8OlgMP9E+mR6T6bGim5pEzo2GJ/i2Eh3LWM0=;
        b=P90duSPX7iW+S1/qtb3uibnavvblmKeGv0mI0Gy8iTFO0jNYtubY8STk4RTdjdFs7Lwuwk
        GsEz7ukF7u/o5za9pxkN5tFG8UeUYnB5r6Epr7y3bvveeJXn0CTjeOkg6lrXJ4t65MlqJY
        Po3DS9yUDRKwszN9dRW3cJiAfqUv55Ogxs2pmI26+7V1VHkXsy4TfWKovK92GofXmMlvTf
        D0ICv/qSy76MI/1dyIUFWmWNVaCaABlvWwUuFPESddK1EW0r8ZxSRHDPPRL2pe1spuhGj3
        ToZfWIMbzVqNsXQlr7Fxu6AvcdMePHRfdMUEzozkEI5Gu7B71sJZI0cU3M3Hkw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 1805A634C93;
        Wed, 13 Sep 2023 19:11:23 +0300 (EEST)
Date:   Wed, 13 Sep 2023 16:11:22 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kbuild: explain handling optional
 dependencies
Message-ID: <ZQHfKuGcX07/xW2k@valkosipuli.retiisi.eu>
References: <20230913113801.1901152-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913113801.1901152-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:37:52PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This problem frequently comes up in randconfig testing, with
> drivers failing to link because of a dependency on an optional
> feature.
> 
> The Kconfig language for this is very confusing, so try to
> document it in "Kconfig hints" section.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
