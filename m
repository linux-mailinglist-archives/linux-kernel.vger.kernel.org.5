Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E081478D1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbjH3CEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbjH3CDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:03:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CCCC9;
        Tue, 29 Aug 2023 19:03:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7927f24140eso165982539f.2;
        Tue, 29 Aug 2023 19:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693361027; x=1693965827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMNQ9Jfk5H6z6bxhcK2xh3Qd/m36ZZ9zApc5wXHqb1g=;
        b=fZy11NzG46N87unG9Sqco3+sgw0pjTi6HTT+7KSNmxPBTJGX4aqjze2sNTSePo+RYT
         C3NDZGR7qv2e8ONRLKCoRBB9Le92avzfeXn0l6Os3AapWFy0Srv8aHlVO1HtX6Hhum+x
         lDa6xqzQ7Ul++Dx1K2/HeRp11MF46LZW5rbijEyFTcJDesRtmf92l930ifhZN7kSHlTH
         TObnpX4mGgTZ0BGIToRmESoHweWqNrGjjM++iKVzSZ/r8wtrWDAG/RQeaHQ+2T1erigs
         j+QzYFops5Ce6gWOg1huf4LVBmPmZc9xT1+RPXlorzb3LxV8sTGDoek+qJL+kJ2LSmD7
         eM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693361027; x=1693965827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMNQ9Jfk5H6z6bxhcK2xh3Qd/m36ZZ9zApc5wXHqb1g=;
        b=D3T9cCbYx7Om7llqB79W2jKryX4J+8PjdiATiXPnuWNHXZrcw7Hr3dAtBQVoWuES5u
         0DVCqgorQoQbKivVbwMm2B1r/brn+o8o6su1ws3bMZI3dz9S0MFkBNZAO6HQgadniBEB
         vbYCT7xFqUlYKk8VXcVIIlkN403U7w+WZq4lWh7/2MtkPZNVYBtqERmEBjivytJcPvDX
         V0QUpME+Q3iekhb3X8AthhkwuQ56cwjZAZHZTK6YG4EyJIHhSs+iC9raIejvVkI+Go0T
         QBTzubXZmlrST7lOoM1BhNLNmilUikfStLxvFneU2bSJiCasGvfbR5tyE3velF0N76PE
         sZTQ==
X-Gm-Message-State: AOJu0Yxz/qGe5H3igg2D8xMKr2PrITRdQvdc7zINHv6UCUR47Zo0wYSv
        Vwk8JT80aAUjrivg5G1BO8c=
X-Google-Smtp-Source: AGHT+IG+tltkoe7RqfgP/13MOOIV4MHC6VU778gu/Jt/HySabHuqeD56STbUYo3oQM1RrY5ogJlcVg==
X-Received: by 2002:a05:6602:474a:b0:795:2274:1f3f with SMTP id dy10-20020a056602474a00b0079522741f3fmr146983iob.3.1693361026938;
        Tue, 29 Aug 2023 19:03:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cw18-20020a05663849d200b0042b149aeccdsm3560022jab.104.2023.08.29.19.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:03:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 19:03:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
Message-ID: <4d88d905-51eb-407c-bf7a-f390c5ab6ed1@roeck-us.net>
References: <20230828101156.480754469@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:11:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 521 pass: 521 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
