Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FEC7642C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjG0ABT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0ABQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:01:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52D11A8;
        Wed, 26 Jul 2023 17:01:15 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8b2886364so2451275ad.0;
        Wed, 26 Jul 2023 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690416075; x=1691020875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krtD8R/lLhBKeI2YQdXqv2MhTFMpAqrYyPfJ6hRaVFU=;
        b=A+kqLljwtj0zb/ddirkKdwi6D3OZloGUPKXuXA0CWzzQfVs3xi5SVjMF2fE10GygDU
         pZjJ067C79pB4DwfAhEndRQ8djouGmGN3VnPnDZK1X0297a0JRPBhd+OoWreME0RQKq0
         an36sir9uzm5yY6wWFB8MO5yYi55vZjgSKcO14jUDfSeFUqjr6PnugP87ewbUkGGIgj7
         QlZPpzzNHC3Z8IzKkHYy9PAmlFT5sCyrlnAgJGhFinLsuLAY+deYkahFb8xQ9sIp2fuI
         sCr0/DKtD1+zGujPlaTgr882U/UICmESb6L4ol7HgTu8yjK4mqNgTRh0FlCIFHkA3LdF
         wCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416075; x=1691020875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krtD8R/lLhBKeI2YQdXqv2MhTFMpAqrYyPfJ6hRaVFU=;
        b=bTsg7rlavocmbK21WJKns18oN/NBqRr9pBJg21OMUQy+YK00B8zDKYJP0v1fYDhNVr
         CnuxBjZeSDYNS6j4GHQmpeemlZ2OVgcoe1LhKRD0Qy+q1HTbyPbtrm4I4tgutuTNEhcU
         yoHY2zpjDb3DyR7TBNRb4J2fEwHjdTQ3YuM2jDUfYw/q0mGlZ8hnBof9SNZ1CnL9ZTaP
         ShLW6mOJ1oLygXuNxyrbi9r3Y0SiTeYamP5zxTWD1gSKMMR8yBAromfzRsopOr0b8ANV
         fq7ePAKasJAx+aAWtnK/E7HjwQuO3OxiiKGBqOmtYDPVXm3nZWsS/w+nJQ637JQ15mYC
         Db/Q==
X-Gm-Message-State: ABy/qLaTOEu5JxFHjXFJsArS8Ij1LVM40bcJ2XzkHPj2v4onU0neOveS
        VeAtXmuke9SGwAK192BCyLg=
X-Google-Smtp-Source: APBJJlFcskRhxR4tDtKALG5JpFr5TJd6jaMbQx/EjxLetEPEFtwwgdRSQV0SceG7NRq+AFk76NPNEw==
X-Received: by 2002:a17:902:dac6:b0:1bb:d280:5e0b with SMTP id q6-20020a170902dac600b001bbd2805e0bmr2378295plx.18.1690416075182;
        Wed, 26 Jul 2023 17:01:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001b8062c1db3sm128454plo.82.2023.07.26.17.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:01:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jul 2023 17:01:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/310] 5.4.251-rc2 review
Message-ID: <88576194-c440-4b8b-8b37-225d5c87171f@roeck-us.net>
References: <20230726045247.338066179@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726045247.338066179@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:54:02AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 310 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Jul 2023 04:51:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
