Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3527642D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjG0ADW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjG0ADU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:03:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4E212B;
        Wed, 26 Jul 2023 17:03:16 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-348db491d0eso1248745ab.3;
        Wed, 26 Jul 2023 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690416196; x=1691020996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyRkc+BwxPYQKWVJ5OHqVWRTxIHN/8jDOBRCNFouIw8=;
        b=p5tGEaj5K6sEH/7kSN1m/FiFuDEWcPX2MbuJ+ZrXp/O0V+LknB/oO9PhwcxB5Uukbd
         TfbuVUJmdFR2gX8j8wWfy5QFeD0mDwzpxcHBdOYx8oQN0ntchorVSahpqTof+rHoyr9Y
         gSjxa8kpra0fhUR+Ep29mvlLBwQWvLgTxAdQnihseM43ubZvT/pv802mBsQt6gqJanfQ
         j7i2CjYi8BKnXfZQWZPTwZ3rEQO5tLN8vN3iC93S07AcP7N/PEawXQkNantfrH/dHyrl
         I9tUCtLVAUr+aTHPncxQ8FuGXtYD2FnWXJMMfnCXN3foM0Qrr+FEuGlcg8IxlQtdDr3c
         D1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690416196; x=1691020996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyRkc+BwxPYQKWVJ5OHqVWRTxIHN/8jDOBRCNFouIw8=;
        b=HjXB4V67immTRD5HJ7UcUnsE7cBbq/nASwXSvL4NrEgTgniTtoxQedMd9koDqscWV6
         K0FI9sARaKegc5/wP/+Z86cVHhVRvbckywG9v8EbjLQtR/SiCO7kKi7oT9tCP0J/A0hN
         LusTJPYyr92ruXDI3ZXhsjeBlQmoAsdo2E5djr83m5z89boxj7DO5xT02MQCfI9Re/fG
         INNT7TPmxxwuvO/geiSCwSFgnltMQMwhuyKcMrNMi7r4vSA9orQNGirg5Cy+98fHME5P
         rAbGkKnaBow+mDyjcOQX3aBGjuQr9jzeaArMSNpLUpf0h4niKaKuZ8cK305d1LDgiIH+
         Q3Dg==
X-Gm-Message-State: ABy/qLZ4l6Gdg4pG/rV6+0e/sW3wE7RlMm5DSAAMIGWzZloplhJZ4NuT
        e2sQB+jAtIzPsSUicaC9eOY=
X-Google-Smtp-Source: APBJJlH6YYpgcmF9mbkLqCjZPmLJ+edFwQ9O8I9EQJGs+7uhgALL/Yk/LkqQbluAl35dkf4ljNFwkA==
X-Received: by 2002:a92:cd82:0:b0:348:d654:7ff6 with SMTP id r2-20020a92cd82000000b00348d6547ff6mr4041229ilb.4.1690416196362;
        Wed, 26 Jul 2023 17:03:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a4f0e00b00262e485156esm1700596pjh.57.2023.07.26.17.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 17:03:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jul 2023 17:03:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
Message-ID: <736c341d-ccd6-4c1f-9a1c-5c1465fac06e@roeck-us.net>
References: <20230725104514.821564989@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
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

On Tue, Jul 25, 2023 at 12:42:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
