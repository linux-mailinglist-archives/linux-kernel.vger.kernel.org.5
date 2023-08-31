Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC98878F0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbjHaQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243358AbjHaQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:10:09 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A701A3;
        Thu, 31 Aug 2023 09:10:06 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-349a94f3d69so5458885ab.1;
        Thu, 31 Aug 2023 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693498205; x=1694103005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41c/fNK1qQC2XK9KwuU0p8MqEE5Km30gP6fWHcjfMQo=;
        b=TN6J36xxtrovuQiFOCdK8U0oyxsATKW8WNbGxPn65zV+Gkj+1VgOwxJJBK9mGSma5o
         YHbibb0ilD0aI1f7Nd1il6rSsDZqtikkuMMwNeWqXL21n2wkf71lCADyJE6LjrJhakae
         RVmpcbsH0mIva8Ubx2nBbcwouNWYWu4WTgWIVO0N6muDoXV9OTY9wAYUkB4E9+e+pVN+
         LkzAsKgHrcJGpUGKKty75tO9x3vqnUg5s9yXtp0Gc71mj0GfpJEwm7J6ABLsWEKOnTb4
         syCdUiQDXP+BvUkQIihD3+s3Y4nyp22UPPQFUPQm6ZlxV6xcrHL8Da2s+Afvdb3KDGde
         xY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498205; x=1694103005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41c/fNK1qQC2XK9KwuU0p8MqEE5Km30gP6fWHcjfMQo=;
        b=cad3vSQXs1kRc0nnSW4I4ZRK4t8Mq//LyiW1Q5C/2GeEQvpcL2ZkCTfWYqrLs26FZB
         9dHhe4pQU6jPrt7BvL8otn457H37EA7n+oBHJPAxN8KSC01LBQoe7jKeM/haj4jGVg2L
         xRZA8UdfMYF1JXZFzfMhVoush04X5/X3875kA3ZrrJ08jEvlI7CCJPdoRsJhgSbkMfSu
         GMElwl9YpH0hj/IFwENMxfBkLCho78OoGMSNf/AillZA2LfVNp34PYqeh2zPgc+tearN
         InpK85mjy7icZKwaDS8eUKHeJ3Sk+uHDJMmewwtgKXjA/x/wFerjPBf/2v1WwANSsRHc
         1ISw==
X-Gm-Message-State: AOJu0YyF1QNJL6Uiv1cYZWwoRI6DkC8jKz7+pE6iJDSKbxEJ9Zw6mMPg
        CvHOz9V6DAjkYXJ1avO9VkiTkfyDvt8=
X-Google-Smtp-Source: AGHT+IGIk5fg7IzlO0S8uOjOP4VIcjkOGCNo8gyiNl5yp19xKSOvib6enwnc/oDThB57xVEIL0ilLA==
X-Received: by 2002:a05:6e02:f41:b0:348:b07e:fdac with SMTP id y1-20020a056e020f4100b00348b07efdacmr251422ilj.3.1693498205551;
        Thu, 31 Aug 2023 09:10:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f5-20020a056e0204c500b003489ccea184sm514510ils.10.2023.08.31.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:10:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 31 Aug 2023 09:10:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 0/1] 4.19.294-rc1 review
Message-ID: <fbefb0cd-e056-4504-b0b2-ebd778d4996f@roeck-us.net>
References: <20230831110828.433348914@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110828.433348914@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:09:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h: No such file or directory
   12 | #include "platform.h"

"ARM: ep93xx: fix missing-prototype warnings" needs to be reverted in
v4.19.y as well.

Thanks,
Guenter
