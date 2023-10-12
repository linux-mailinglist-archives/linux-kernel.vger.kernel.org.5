Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8A7C7A41
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443065AbjJLXNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443006AbjJLXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:13:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0713BE;
        Thu, 12 Oct 2023 16:13:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so15915675e9.3;
        Thu, 12 Oct 2023 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697152428; x=1697757228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=48dvFZRTefM8O03FzXiZwqBq4Rp1+Jq3fws313orleY=;
        b=BRVEpW1IpP/e2XpHZNezKQUBEp5UoIYqAWy15iKGAOSnuJjekS2rvHsyghNcbmTDn0
         q7S29GW3SCvoxrWfCF6RiEfJkgi3IHoOLaFZ6X2eIRijjQLZkREgGPh8r6EhkUjl4NXk
         9GkEfn1a4AMLKqX0Re5hoLXlOqgxgXisczfbBxxhlSK5rAwZZm8Z4d9PLharpR4r3V/4
         3oDffREU257+QQSZMjB18Q/VUXc2tj5o5VYYShTZrBhu90ySZnLpv+vIur+G7EPtETtw
         IaVbPeYNyvSTFYcQeokb3XjTHXoqr1cOLhaA+Kjy0xQYI2F0NSuUzVNwBjOoISYt5CRY
         Gd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697152428; x=1697757228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48dvFZRTefM8O03FzXiZwqBq4Rp1+Jq3fws313orleY=;
        b=VgANYPGxLIXc0h3ch6Ycd/uKoFeAD5K2Z5aTboXqMUTSUy9SpyOE4PSeya24d25DE9
         W+IpuuKxgV77ZiyoPMVo1+5Q+sUeGOOz1H/QZoz4xaNZzehP0NJJkUVpJF6hBhMMSz0L
         DOP05wNSCSp0MtUd7tuQIZHpI1aQXmrt91QTNsnredbegOihQu7F0/auPR8yQYNCSh+7
         B3OOebHhxTZefhZWCf+jwQeN9xEV1QlLthNvMWBPa75i8HFFobKeqlwrUzsjMjdByvuo
         K00JI3kGhN2m/iAbofaWWSJWLjSV2Tu6AY0kg6ZZZUpTvxRWcJNfV7YnRcap4xcUbcJW
         QzJg==
X-Gm-Message-State: AOJu0YxjLi2j/GLQCqfSQ3hahfuSJcAqKyDSYOO8OiXEYNI7Yet7pBt+
        lQIs8qpWTHweXxywmtpcaPU=
X-Google-Smtp-Source: AGHT+IGBUMaFK3LiMFWR80pLieooWigl/OTlu2OYaxnwSpHw4sL9/u+s4/Uv23lgFjI/WbrN7eyM3Q==
X-Received: by 2002:a1c:f709:0:b0:405:3b1f:9691 with SMTP id v9-20020a1cf709000000b004053b1f9691mr23327485wmh.11.1697152427949;
        Thu, 12 Oct 2023 16:13:47 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id y4-20020a1c4b04000000b004075d5664basm979269wma.8.2023.10.12.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:13:47 -0700 (PDT)
Date:   Fri, 13 Oct 2023 02:13:45 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Rename IFLA_DSA_MASTER to
 IFLA_DSA_CONDUIT
Message-ID: <20231012231345.3thxxxhe7pxs5bib@skbuf>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
 <20231011222026.4181654-3-florian.fainelli@broadcom.com>
 <20231011163003.32036b28@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011163003.32036b28@hermes.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:30:03PM -0700, Stephen Hemminger wrote:
> I don't know if it would be acceptable in the kernel UAPI but what
> we did in DPDK for similar situation to cause warning on use of deprecated value.
> 
> /**
>  *  Macro to mark macros and defines scheduled for removal
>  */
> #if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> #define RTE_PRAGMA(x)  _Pragma(#x)
> #define RTE_PRAGMA_WARNING(w) RTE_PRAGMA(GCC warning #w)
> #define RTE_DEPRECATED(x)  RTE_PRAGMA_WARNING(#x is deprecated)
> #else
> #define RTE_DEPRECATED(x)
> #endif
> 
> ...
> #define RTE_DEV_WHITELISTED \
> 	RTE_DEPRECATED(RTE_DEV_WHITELISTED) RTE_DEV_ALLOWED
> #define RTE_DEV_BLACKLISTED \
> 	RTE_DEPRECATED(RTE_DEV_BLACKLISTED) RTE_DEV_BLOCKED

What precedent exists in terms of intentionally breaking kernel headers?
If none, would this create one?
