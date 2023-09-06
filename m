Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84AE794208
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjIFRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:30:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB8A199F;
        Wed,  6 Sep 2023 10:30:43 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso563955ad.0;
        Wed, 06 Sep 2023 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694021442; x=1694626242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdFFIRXVw4asO0rRRfkbifUfRAANRxtyam8HgnhO5TU=;
        b=gcB2dztdNQdLyALSwa6INxCYzinWbZ4hSHEeDTpJh9cjuoPFq8x74Tw/leAv7glvfB
         Oir9lQ81cgO1pZkW9YPilY1evMKn37AMTV3g7bqC69DVZS9rFSE4pza9T1iIH+6QFg+Y
         DRizwIgxlUC/etkbR5yyk7YvnhwRXa5B02Rl0j+GLNUPqr/hZW2XOBEtJDcNc49oBshi
         +VhpT5KZwPXu5HtHQD2Qo6SZjuMsBNmzCiBE/x+sz2rCuCtuN9S7NtGbB/rrDt4A9slY
         LNc8Qr1Ar7YKuQ2CwhW75bXW+d8P4lXXb8Dtmb1Qpkf7W+VUSFlP5+OCWjGIbKSRu++B
         ioIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694021442; x=1694626242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdFFIRXVw4asO0rRRfkbifUfRAANRxtyam8HgnhO5TU=;
        b=lXUdy/ez1drViyXZro7+0nQgOgy4n+YONCgLDt4MG/jpArjtw6NWpfMT7vRyIzWIde
         3NUhLQ1nEe4UwHwvyI9pXyy8D1GTby7vzJh3lhoup+2yZOJdiZdGSpLfPx5AeKXxMhMK
         fC+xE7JpR0WgJoi/0M7cJBJTzZZMzULdS5sGddfRI8bnXiNPBgbA+UXvhG7blZHUdFbA
         uvvgknhkUqNo1VXArJlTO5I7k7/Y++Rmuyg5+VJCxbju5GKnE8AvSIcGIntCzNZ02GtZ
         X5OSy3LHXF1btiR/pVcYudIQKQNzC6KJNb19tdEV9/dZpIARukP5ZdQaXReY/E4uVKHp
         1C9g==
X-Gm-Message-State: AOJu0YwaiGWFHPcEThklS8Uchqlfr6uyWulb9TYVGzFwTOWkAkSOqWOO
        ER+r/AaBku6rMR3RHPouP9c=
X-Google-Smtp-Source: AGHT+IE2VjplLtclOfxZAuJPA3ldL1BglB9zV3kfKp4UCm8i5PdJ340U5moc50cE7BX5EnMVGdHqYA==
X-Received: by 2002:a17:90a:7a8f:b0:26c:f871:e6b1 with SMTP id q15-20020a17090a7a8f00b0026cf871e6b1mr12085090pjf.22.1694021442398;
        Wed, 06 Sep 2023 10:30:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090ad50a00b002682523653asm40955pju.49.2023.09.06.10.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:30:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Sep 2023 10:30:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
Message-ID: <0bf59003-ec01-47e6-ad61-b0ccb356bf45@roeck-us.net>
References: <20230904182947.899158313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
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

On Mon, Sep 04, 2023 at 07:29:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 524 pass: 524 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
