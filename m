Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83706784DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHWAuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHWAut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:50:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F5E63;
        Tue, 22 Aug 2023 17:50:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565403bda57so2909846a12.3;
        Tue, 22 Aug 2023 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692751827; x=1693356627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM43A4/DK/17xUvga8Gmv1Q0UBVziYLS6+8xmcTLaUI=;
        b=CodYmXiWIj+5nfcp0Fcj7nsBX3UzYQo43LtC7Cyn0wioHPrSAgEXdL1Eizd5bFEmK9
         HRW09Ntbny+l4MiMT2PB/KEq10DP6qYr2OP88OA6STJSrTvii/HQuJsvcCNKB7sYPcBe
         ZoZt06eCosFPqKp+/U+iP1I6vLL1fiifEy2ZzFI0f41t6SeK7VP7sO5noevJc1aGOU8U
         YOGZiL1HLpjpmjWHRGoRo1UzQziBkl+vrdRRbZdnibDj8lcl+a3h894tCHriSxlzNxZX
         da38wSrsqFhdnay3MHrsaDXC+CRz3h0Y+EQHKVFWtwq4vKsaap8Yj/LKpJOy89+Wa+XW
         L7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692751827; x=1693356627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM43A4/DK/17xUvga8Gmv1Q0UBVziYLS6+8xmcTLaUI=;
        b=KRwZK1CzKvC/vMozvh3H6zQiuJpQOb4BpMBD26yEPcrKS4o0XGtL07flQEhrBrKNhF
         MLJXuu4NYzEe0Qq4Irm7Te1OhwJ8a12euHdwDWKYgHsTF7ADGm75VeF4hCuwaRZ+EVzR
         phJvABPG+MqqP1j+su387b3V4otg9HnCJkjoyoEVAUhWCE6ej3tuyVlVjvQr4PWefseW
         OTyNX7zdF+RVeQrynMN0AHSpUL+tH5LaDM9QmpZbiw5dm0uQU7ZkYnVmiEGRpYiDVPl4
         r2GMoVHE2+Zuq8i78kNJ6BMXaD/wDkOxzDqpVPbij32uLON/PSG3E028vvN5UDpCFjCr
         n2Qg==
X-Gm-Message-State: AOJu0Yy1gXIMVZSBwBgsbJgNhsasFeZx0Z9SKhi09bQasZBxYGlZvtx2
        VoV45s2MBQlJ/axG+JjGvsQ=
X-Google-Smtp-Source: AGHT+IH5TO05VVkBG2tZH5Ys414AcYHnwfJRxTfvVCLNNLXlabNNJweDWr7XIxo6v4GYqVcbnx0d9Q==
X-Received: by 2002:a17:90a:ca16:b0:263:fc45:4091 with SMTP id x22-20020a17090aca1600b00263fc454091mr8151185pjt.15.1692751826886;
        Tue, 22 Aug 2023 17:50:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fu4-20020a17090ad18400b002694da8a9cdsm8398306pjb.48.2023.08.22.17.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:50:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Aug 2023 17:50:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
Message-ID: <5ffac837-e992-4ed0-b2a3-7324ff1a8489@roeck-us.net>
References: <20230821194128.754601642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:39:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 522 pass: 522 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
