Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B173B7941FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbjIFRY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjIFRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:24:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21EC19B6;
        Wed,  6 Sep 2023 10:24:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68e26165676so888670b3a.0;
        Wed, 06 Sep 2023 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694021086; x=1694625886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rP07r7ZTWJgGRXxlI2x1G0RKq1bDbhNUk6IPeI6iQ/0=;
        b=B/mQobqPOaFN1pmvasN9g2c94EmHhIU5xdc6/BXfbpd0mnT8lMWh8T/oENiv0rT8aJ
         ox5q3fM1qVVbqN0TN7UR898jlrE1T8Y12Pj5fCan5rSWWVRJeSmQqjSFVmLbLk4qv7CR
         ryaqe4VDttd1qky08nX5EYUh24s1mAHwKovYL5dMcVlkzJGQgaVS+tif4HYg7vp9cJk/
         buF39DVZrCw6AqriOgQqETomhwny3CHdB3WVDfJPXIPvcpHeWpPQgWc5IztLIH1wZkJg
         wOY85CTHhWIpRKXQpd0FlVvZ+crgYJRjUcFtBbHv6/GKymUQ70kW714Q4NbyMAMHxO8G
         nLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694021086; x=1694625886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rP07r7ZTWJgGRXxlI2x1G0RKq1bDbhNUk6IPeI6iQ/0=;
        b=dWpkUJHSi9/427tI8PJO0pGYDxpfYw72cmA9AvEW2ZEEmtl97DJZONV1ftCbiOmKIp
         eA00sOtPQR80cGwEGjlYU9U/i6O1GxfiVLXTI2RBbI8tDDriYGJgkITeb+sMHz1T3c+S
         5hhYmwqbLA1xB93tGGHanzUaHf3ord6jJP8hj4aJzu3c0tHVeUzT5OUQXpuFYMkbj4gM
         zYl5SfjodOyD0CbJfdBMYcKIfdRnCJy4d6x803UMgs9s8kzyDKJQWlZToyykcucFm0Oy
         QxGQ2a5b/sEw73B9nE36tz6RutNEwG8iFszuo3sL5rbXWiyAGpMPMXRvIIUL6BRx7Eeu
         1c1g==
X-Gm-Message-State: AOJu0YxDeeGSr8ZMrYPi6g7ttqMbLjjp/v+t42UHhhvFo5NM16CSQaPY
        2wiODe+fFQ0nC7tbhJPiA3Q=
X-Google-Smtp-Source: AGHT+IG9slQd52ZN23wso0dgHQ+v2qjo0+1OTbRqycbV/U7jJMnbbha0SCi6FsdN02O0kCVPsGUpIQ==
X-Received: by 2002:a05:6a00:1785:b0:68c:3ed9:d39c with SMTP id s5-20020a056a00178500b0068c3ed9d39cmr359339pfg.13.1694021086353;
        Wed, 06 Sep 2023 10:24:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78097000000b0063f0068cf6csm11079717pff.198.2023.09.06.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:24:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Sep 2023 10:24:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
Message-ID: <bae0bda4-fa91-4f6f-ac7b-bd0fddb2db75@roeck-us.net>
References: <20230904182946.999390199@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:30:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 523 pass: 523 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
