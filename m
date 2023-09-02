Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DCC7904F0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbjIBESh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjIBESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:18:35 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0510FE;
        Fri,  1 Sep 2023 21:18:31 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34bbc5eb310so8976395ab.2;
        Fri, 01 Sep 2023 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628311; x=1694233111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3ZAPzm/byo8bzgvBVYJx7YzDC8YUFaNQJpcKMLs7GI=;
        b=YpIrUDI6TtsK63PcK1i2WKGw3v9DaoZQcV+a0IU+cO8PkMUTs1xRdIfIddX5+wJR3s
         APE1k1Kqs3YosL/kgevoLx+66hvQEhyGAMdRVz541qVTDV/IOt1zxwj2LDWtqcFzhUDV
         bsGfYDEfGEgEY+Uyq9c6/yqU01lDnQrrDJFlP94OiZQPhoX2FNGLF1fTtmTgjb87r5LW
         e/WmRHsV+EZilGWjBJRWQd6kJzczbuiCpOubqWqIxHKazSx31xl+ttEjdTZCq0y5lgi5
         A641QE+ZAkAlpzFBR9NfK9+HyeajlYOYy8WDUxYqK53Bti0EnuRQjwvU8soq4AjDhxXV
         uStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628311; x=1694233111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3ZAPzm/byo8bzgvBVYJx7YzDC8YUFaNQJpcKMLs7GI=;
        b=jolgnkVyJMPTMiYN8QMFKbUxOT32xetpIE7WUjbCX6QyimpB4d2B/x6/yI/ghWRV1W
         X2y8QMya/GQxXvVAZfm0Ba6Ygfuoh6YHNRcGDlCA4TawU6o198Ws+zJC3u9PFKMcKUiP
         eFfyuQ22D06GUzcxcBXvArc1/fVT+FyiFZ+NVDwWpthYPB6PSEpA37PP6a3J+o5G6ay0
         gfRdD2nZdNkJhRg4LFNOt2YWxmBRCKH2BKi7XYrMTfpUti50nCJveKhCNuR/7o7rv3ZP
         Mmd4tQ1oy8/csTehJ1mjoHcvDTt6pftc3AD+AC3aC5jeWHQOJusch/u+yvxMAGTPY+lt
         SfaA==
X-Gm-Message-State: AOJu0YwJ0UXIWfhyY/UKpgLb25GlBz6IlGiyC0O7pVQNH6OnFvKLkqp1
        +eXlfexdupHadpzXGaeFPtl9SKvb2AY=
X-Google-Smtp-Source: AGHT+IF2S0GeWeACLiKFPmwSv2CL9gN/paNG2t2aH21/luSmnw8w31dIwOrbMXIGpPKbBUXzg5iVyQ==
X-Received: by 2002:a05:6e02:1b82:b0:349:92d4:bfed with SMTP id h2-20020a056e021b8200b0034992d4bfedmr5608533ili.18.1693628311338;
        Fri, 01 Sep 2023 21:18:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fh2-20020a056638628200b004302760aa6bsm1552793jab.4.2023.09.01.21.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:18:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:18:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/11] 5.10.194-rc1 review
Message-ID: <604baaf6-fd80-4ea5-a52d-27d2f4df50d8@roeck-us.net>
References: <20230831110830.455765526@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110830.455765526@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:09:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.194 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 487 pass: 487 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
