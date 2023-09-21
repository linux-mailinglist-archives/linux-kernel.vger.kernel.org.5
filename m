Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501F7A9758
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjIURWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjIURW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:28 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D686E9F;
        Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b9e478e122so714481a34.1;
        Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315893; x=1695920693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU8P0CekVto2VQuEEJkIEik99UNqAGFpSJMBei3Lvvc=;
        b=mBNlxGrzE5WDdD9D6dlipNa1+zO/D3p5gHg+73L7UP0rNVM4g1N2kFNCey+Guq4J9O
         bqPWj8Oh3P7DJ7AX8lZZWm+Ll/BGnIJfO0KjbAJ9P4ERoiHChl5+GH9rvj3nBtie0xXM
         0Xze2UfcuGLuWNUm/CGWYGlELi1Pnyu4hRiBSMOgFeWcdVL2IDTRNq4uhV/6lJk/Dbfk
         5NvHDoL0nAXD/hUTLrWt4u3bBvQj/UycTyuCezDy0Z+9zWtKQDs3D1r/hxmp3PjfF3zQ
         B2l7pFLMmKr5fS+7qOqaQTruoER9JcBChhHMT5peJAftH3LCzHVyTIQVsmDmY5CaqYY9
         h0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315893; x=1695920693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU8P0CekVto2VQuEEJkIEik99UNqAGFpSJMBei3Lvvc=;
        b=nKb1b73IcmYKtTI8fDNnMRtP2owFr9sJEevjMmJQjY4uK5K1zhTGX9NswavPsnRRXU
         YfTLdyQjJ548d+Ni6uE1SuWsZcHLE9Blas7jwAshLaWKkUpkKwVzOB4ShE5XOBQIyQmu
         Ya2TLqHtzyCCTd1xIdhzM5egUfScyrVI9+3MSj2rp8tzydMgyzz1N5ZWrmlfmp/4BiVe
         W4NYviWMZ6umt3+9DE7M+PAffMv4zNo/DxRyC2L6cKFEqVX74o6lCjqzmCovcdj98hB3
         V1JtO/Wi0vAVM9ibGN7LRYGqTIuSi9e+WnhQP3kR6cVpSfP44C1ZGQ1fJJ/43dG1AnMd
         UpBQ==
X-Gm-Message-State: AOJu0YyZSIWXLgpJfijMSSZ+mC83mv8u/PAk6aiNky3/QE69C6jn6hdg
        dkjFYfd3uTQu4XmNi6FEcHEmInMmflU=
X-Google-Smtp-Source: AGHT+IHEv/CSaHX/fbLRdTnOGYJa6deCdOKlP7QfQB9TdWWM2iN9gdfnXB5iVytkf1NYOP814o1arA==
X-Received: by 2002:a05:6e02:eec:b0:348:e9e4:4902 with SMTP id j12-20020a056e020eec00b00348e9e44902mr6117606ilk.0.1695312099570;
        Thu, 21 Sep 2023 09:01:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15-20020a92ce8f000000b0034cabf65f2dsm505719ilo.64.2023.09.21.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:01:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 09:01:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/110] 5.15.133-rc1 review
Message-ID: <90acb11f-a4b2-4918-8b39-0bbd2357303c@roeck-us.net>
References: <20230920112830.377666128@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:30:58PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.133 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 157 fail: 3
Failed builds:
	i386:tools/perf
	powerpc:ppc32_allmodconfig
	x86_64:tools/perf
Qemu test results:
	total: 509 pass: 509 fail: 0

perf:

gcc-10: fatal error: no input files

same as the problem in 5.10.y.

powerpc:ppc32_allmodconfig:

Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
drivers/usb/gadget/udc/fsl_qe_udc.c: In function 'ch9getstatus':
drivers/usb/gadget/udc/fsl_qe_udc.c:1961:17: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
 1961 |                 struct qe_ep *target_ep = &udc->eps[pipe];

Guenter
