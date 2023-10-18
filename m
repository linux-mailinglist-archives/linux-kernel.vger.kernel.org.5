Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CE37CE1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbjJRP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjJRP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:56:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9F89F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:56:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DAFC433C8;
        Wed, 18 Oct 2023 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697644617;
        bh=8D6Mjx5HFMPwEn9XL6mieDVD+lT588WBKWdC6XGHrnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=shgO2+N8GgVc7Petwc6ErYY0k2eL+MtZuC9k7+aEL0ZOxi2suAlAWhsZsMBU900jz
         2KgH2DDmgl4RCf+0y6y9cU9xK8X4A6a7NrhDiCGPDOS8aPrnFX7sR1RxM8upleqU7N
         9DuyqJf0/MMNNZGoB/sxkDgMl+Amg88UV27qJmT/hEcLsuY90OKjCs5pPeC4yxzXXd
         yV4bojQ7omxw6PntwDnfjMUFY+SMWcYdwiluu24aSgJ3SXsYPFd/nXWnBB0y7c9fX/
         QVDrRik6h1yixfmqpCYUynWKJJlxiEXoBThf6G2muoyrDGL2BSP0tBaJTy9qBGunEJ
         HPnr93c3VGuqA==
Date:   Wed, 18 Oct 2023 17:56:53 +0200
From:   Simon Horman <horms@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231018155653.GS1940501@kernel.org>
References: <20231017233536.426704-1-florian.fainelli@broadcom.com>
 <20231017233536.426704-3-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017233536.426704-3-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:35:36PM -0700, Florian Fainelli wrote:
> This preserves the existing IFLA_DSA_MASTER which is part of the uAPI
> and creates an alias named IFLA_DSA_CONDUIT.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

...

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index fac351a93aed..30ef80aff033 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1392,7 +1392,9 @@ enum {
>  
>  enum {
>  	IFLA_DSA_UNSPEC,
> -	IFLA_DSA_MASTER,
> +	IFLA_DSA_CONDUIT,
> +	/* Deprecated, use IFLA_DSA_CONDUIT insted */

nit: instead

> +	IFLA_DSA_MASTER = IFLA_DSA_CONDUIT,
>  	__IFLA_DSA_MAX,
>  };
>  

...

