Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A37BEEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379174AbjJIXOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjJIXOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:14:42 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504CB2D69;
        Mon,  9 Oct 2023 16:12:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77412b91c41so292090985a.1;
        Mon, 09 Oct 2023 16:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696893148; x=1697497948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkeLMCni1HNBHZQn/gCPq7DkQ4+vPia3kJm12hspXig=;
        b=NwOdykwl8kPTTDWmdnuF+rtCyb8ISYykAhIgGVLP48K44ZMUlWuNHUbwHWYTfO+Noi
         HcRVl/VLpvGIPbfqGl/aYLRSxFkTtlG0Le/E+GyqpcqUzqSkhmPPJkFfRUi+S1JpM2ht
         MJfy5tEOUp76pTWcEp1P4KQtaQmNFcJ3tu3PyOfUArC24r1JT22B5ruBPSZbF80n8hIH
         TYCcybY9469LmE9/Zif004pEgS+lIfYGISWlk8Phl7Or6c30ruAwkxhEIbyEbzQ6Nzr6
         pautwjD7vB2Bm1GEQB4TjAYfzVDi1wZ8P5Ken7xmmR/sCVlIz4bnW8muDoCbeJc9HfBI
         dxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696893148; x=1697497948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkeLMCni1HNBHZQn/gCPq7DkQ4+vPia3kJm12hspXig=;
        b=xKHEWMpgNmiLfyvdfzdYDNrzfA2V7/lJY/nNRkQed0Xtc6PTTfdgjaJDCB2MkLNXdM
         c1F/d6j576ZQkZtBOyZafxglZm4PPpyP1P1bjOqoUoIQRYi4TeVNe9ex3UC9LUTQMCdh
         rLxzB0cEcF/YEw00tPMWAm8PYVXQuKx8R7gkaeUa/2nKwUx/Kr1TFipz45aDmTCKE/2K
         By/Cg11MV/+wVTBAZwCxeIWKpMidneUbFZdbJr/j9uoUVVe//dI1pIkH+8yeo6vllaP4
         j3kO8F8/o+HioJp38M9vUYPjnygFrmRMC/ppW+Ca1gdwyWxX8ErwEWvTYr7OITpldHJe
         Er8Q==
X-Gm-Message-State: AOJu0YzLB9gp7yu3ekCTn7EMe/pj0AJDMNY7p2q41i+LTcfF8nc4cPrr
        SDM3AOdgGxfaKEjCIv0sPf0=
X-Google-Smtp-Source: AGHT+IGc2aMNQFQLpboYasVnQkU2PgIhkqo9/vLEFaIJRpQrgURxpDUvwvg4Q6XR11bC+jPnJFPtkA==
X-Received: by 2002:a05:620a:51cb:b0:775:7be2:8c8 with SMTP id cx11-20020a05620a51cb00b007757be208c8mr15282943qkb.61.1696893148588;
        Mon, 09 Oct 2023 16:12:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s27-20020a05620a031b00b00767d572d651sm3874915qkm.87.2023.10.09.16.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 16:12:27 -0700 (PDT)
Message-ID: <cfce3793-3e96-4b3b-a9b5-9dbdb32725c2@gmail.com>
Date:   Mon, 9 Oct 2023 16:12:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 15:54, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

