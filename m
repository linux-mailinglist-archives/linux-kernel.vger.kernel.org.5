Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92877DE35B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjKAO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjKAO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:57:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A5FC;
        Wed,  1 Nov 2023 07:57:37 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ef370c2e1aso4418191fac.2;
        Wed, 01 Nov 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698850655; x=1699455455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0SsjUbKqrLXwVrRZWhYjp20BgDkLo5Efc4GdwHjgsE=;
        b=DczJItZqDX1AGfcq1buTlM05s7IIVPte0R0RGA1rSu7gdH7vnsvDsNEC67iRpHD0cX
         mvGNWTE80foP++TlnXvcY+qv4GAm6MXix0KOrWA3EbJIz2mYF1yHOHMjFwkRpGGYjHrk
         oBCscetNJBdaYfJArCYYnX+vRqr8sUnW6rtPPV19mQZuopYK0IWLhjLyH2IIi5lred5o
         4Y6JjjcJr+T5Et2F0fx9or366zQZuBEwkkoXBboEDjD1QmKlxn3E4lha7qefFRgeICKj
         cPqcPYatD2GHPWw0CYWjC9bWVYBoNurkYQ5diMPluNZk0kn2p0M6zi3aKpP34KXsvFyi
         /Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698850655; x=1699455455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0SsjUbKqrLXwVrRZWhYjp20BgDkLo5Efc4GdwHjgsE=;
        b=vRlLsnpl5eH4pb46m45qYE+fLBL759z5c0wJoRkUa7ndauErd0uWCpjv1IoRFv9b1W
         z3WT9jZGwoVmgS02GYPzjMnDK/TIHdbXWta9kqGnOGX80H9pUL8dduIS2XDv2JmFlkW8
         F74aRqVWbesDQ2WXfYnZ4H23lpVbV7lExsM9b7saaHYviWoHiNS3zaXiFQUpb/hzrZ6m
         gE0kKtmsnTXdytT4VitVNgVmMJporjWxWrnsWi6KBiowRdgKJ+CWG1NQLk35wA3TCi8t
         dXE68Vz9nB7X28dVkL2jVG4gLjZxQsmSeD31ozg+zQJbCf3YSfaJHpEuKXmdRGLXIC5P
         +SjA==
X-Gm-Message-State: AOJu0Yzrj01pEsjh4p8bSxSSJEvO3VmCYw4KxAtuj1S1WmSLi9VNS60m
        GOnfn/kQPaAbLutJoIoGNPU=
X-Google-Smtp-Source: AGHT+IExZAyNU+7ZyeX8jdCMON9WDnbnuyvAYzflVYrli9zHL9lKASscJ8JjLdkOqzBhBFxbo8vj/w==
X-Received: by 2002:a05:6870:9d98:b0:1e9:c2b7:2c99 with SMTP id pv24-20020a0568709d9800b001e9c2b72c99mr21241281oab.33.1698850655241;
        Wed, 01 Nov 2023 07:57:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ji21-20020a0568707b5500b001efa91630f6sm262387oab.6.2023.11.01.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 07:57:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Nov 2023 07:57:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
Message-ID: <fd7e4e09-bad9-496e-99f5-2bb029e1f304@roeck-us.net>
References: <20231031165918.608547597@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 06:00:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
