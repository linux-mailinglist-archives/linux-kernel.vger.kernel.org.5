Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EA7DE5D8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbjKASHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjKASHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:07:09 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1256BDB;
        Wed,  1 Nov 2023 11:07:07 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso65502fac.2;
        Wed, 01 Nov 2023 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698862026; x=1699466826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qGAFU8RofTfdc7krIYtNj5TsvDrrANjosLBZsqmPSg=;
        b=cN45A4vQmS7lOpp5j80+Lm7SOSktsXNt6IrX4EKP/86008CuA203zn0hDxLhjotdGE
         eWYv5U466JfuUcToJrcnb98DGXgIfowjt6GJ3Pw8d5Mg2nmz5X/Ff/w722OPkH+dg1nt
         wtWsJ0zzNjZQhZlPSwEdKC3mdUrTIGfKBPaC5EYqbXWMKxeQqLQqGgTOmg1gtdwPNTAy
         vJ6ltOseEvCMq/zJRsegB+p/rwaOM90Ljc2gJSYryq0GvuYlB9r28jTEAHh9A+yxt7Tb
         oDa0fCO34U3NQet27TLWeO9sQofXjoHoY7iQvFNS2nrHKkc1AsC5xyOvgPhO/pn/8KSg
         CUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698862026; x=1699466826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qGAFU8RofTfdc7krIYtNj5TsvDrrANjosLBZsqmPSg=;
        b=eAioFCVPOuM32qoIgRplA1A9cG1rm75vpUGE7nJRf30SNCpTf33XmPCIDYk19TtXnE
         uAo86Qtmn/vX3fqaKqsMlatpqIn9p9KlHgo1CmZ8yU4Mu+szuteaYMs7eFawYRZQ8aKg
         DmkNGqOmSjh2+iYt4RH4q5i2vQf+nNZIKUgjc36gFMmWR3lh0oBHk/dJWBhofw0046Fj
         G+EDhYbTLgqaC9pxgGPNfk9Fppwp3bUNxFOIAli+AIvmHCQ7jAON7uJ+KvltP62p8FB3
         qKWT1PH2VXVpeljlaDavLj87+RaM1ZC88sp7WbunjxSXu6vF7ayB5UVC/WVwzkLMpU/0
         CVCw==
X-Gm-Message-State: AOJu0YxC6HTIKY1roL09NVHqsXslSCRYRH922GvHa2K+LL8xPxeTG2Po
        r+wl9+ECxVqI1QNfIxCPPSc=
X-Google-Smtp-Source: AGHT+IGWuuZ+weVAWlYQ9v9BN9xCErlEHUbLjcz31NIuUgzDdabE1j35Q4hbQlt+6Vz+JaX0CWJ5IA==
X-Received: by 2002:a05:6870:f60c:b0:1d0:e372:6b06 with SMTP id ek12-20020a056870f60c00b001d0e3726b06mr17796629oab.25.1698862026157;
        Wed, 01 Nov 2023 11:07:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ea9-20020a056870070900b001f006088c58sm306891oab.26.2023.11.01.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:07:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 1 Nov 2023 11:07:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/111] 6.5.10-rc2 review
Message-ID: <df19c43b-855b-4699-adc5-197add48beb4@roeck-us.net>
References: <20231101120147.190909952@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101120147.190909952@linuxfoundation.org>
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

On Wed, Nov 01, 2023 at 01:03:25PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Nov 2023 12:01:18 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 530 pass: 530 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
