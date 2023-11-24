Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FD47F793D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjKXQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjKXQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:36:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675C1BF8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:35:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DE4C433C8;
        Fri, 24 Nov 2023 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700843758;
        bh=81UaCbvzEewXtgJlUNfRbHsaHofBH6A66ylN8DLvIiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVPeKQw/bPu6BhhgtDIyqtRg38BzBzz66/kYT2nDsJWD0DaHJ28JcTCzNMNxQt5hC
         CJWNgL2YhgfjqPQ3Fv/dNQAXJmvLOIF8AXu1B6JncBeynr7B6w2VVtuqNqSIuA41OL
         UmLuK1+40trdrn5BXlSW7tQuzNEHlwS5zQ38Li4X7+6k5iPTd16tYx2xEmWPiUIAGP
         TjcO3Mfabu9ac5j7sTudN4i3cnrKgSmCMpkDdyAc6WvPJCzcxosWGnHL+Z6/mK2ny6
         H3MN0imC3UZl30O57BsYjh1OTDOvUKEU/o7o2V4qz2Y2On2Z2EPone7/jOZfj2Frh7
         d5mzQxnikU1Fw==
Date:   Fri, 24 Nov 2023 16:35:52 +0000
From:   Simon Horman <horms@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/9] net: pse-pd: Introduce PSE types enumeration
Message-ID: <20231124163552.GR50352@kernel.org>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-3-be48044bf249@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-3-be48044bf249@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 03:01:35PM +0100, Kory Maincent wrote:
> Introduce an enumeration to define PSE types (PoE or PoDL),
> utilizing a bitfield for potential future support of both types.
> Include 'pse_get_types' helper for external access to PSE type info
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

...

> diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h

...

> @@ -133,6 +150,11 @@ static inline int pse_ethtool_set_config(struct pse_control *psec,
>  	return -ENOTSUPP;
>  }
>  
> +static u32 pse_get_types(struct pse_control *psec)

Hi Kory,

a minor nit from my side: as this is a function in a header file,
it should be static inline

> +{
> +	return PSE_UNKNOWN;
> +}

...
