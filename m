Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB1788C91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbjHYPhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbjHYPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:37:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4197A10C3;
        Fri, 25 Aug 2023 08:37:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a410316a2so902714b3a.0;
        Fri, 25 Aug 2023 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977858; x=1693582658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+saBHYK+xhBpnjSnJ33QCnhXDW63MFo57oZwPs45eo=;
        b=SFewzDuqul+WkUO3DOSumcOuLxkTx9ljg/4eRbxd8u26cqvLb5PzxpYIh7umhQ40MY
         1HVAjUgCGGbPOtBOS3qOBiOqns8klVbhWTGyeD+YGb8VWdFmHd/LC70gUlX95YpsOEqF
         A5MMDbgcVvCZNCHF8xvNhGfI0Cat3NMtvOQG9IXr1+qqEuJIQNEmJvXmUIBHEJym1aR7
         /dgzOLhNzjFgmG84z+d2e16siDCyRIO5PFu+AGyGtu54dtfU40MVz8LH32HYV/0CxQ5j
         EqSt3ZbApBLXNpNUjed6oB21DVHHvtV4Q3BbYRIlTTk5U9bbPXqKNsvJxxLawW3P5nqk
         7bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977858; x=1693582658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+saBHYK+xhBpnjSnJ33QCnhXDW63MFo57oZwPs45eo=;
        b=VzngRLID3f1b5v607Ij0D/6N2vtkTDVNli1mj7kK6CmOMCLp4o7U7sKnXTU5vR3Dxg
         +JFrTe5SvvyHXhWwmgmBt5MPtx3PJHuZ3QW+K0ChodN0E4OLtnJ2YdgCOYUzk4yHX1rL
         Tmc5zOUwB0+lK63V60mbnhdbfeCHao8rP+8SZKHwR2InjCHfU7bHGHdVKBts8SkcLhES
         ojdVCu6CYerD2Gg+b4ouksmTeXsjXHp7tA4J8SqLyayru3zRPOSSwKHFOGL1uAXqK8K2
         ADPCXltYt/zvmbQsHlyBZrwcjfgXt9cfB0ki81Pyj8hQNadq1Wof7LvWgvWPV5zBJ8iN
         J7zQ==
X-Gm-Message-State: AOJu0Ywm6uBdKDW7uNp7Ab6Qboiuc5zs5N3B1dP4xtV2SZKE0JNDakOQ
        A+PdjAh2ONfCKNI2Mla/BQw=
X-Google-Smtp-Source: AGHT+IHIcpWzIAbpWHjgF/1AlkdUYfEc+qeKCCfqVXekZK/bA3hhdjFFMu4sjsYr4aB45ClFqBsoRQ==
X-Received: by 2002:a05:6a20:3246:b0:14c:1db8:5c5 with SMTP id hm6-20020a056a20324600b0014c1db805c5mr3314671pzc.27.1692977858565;
        Fri, 25 Aug 2023 08:37:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ff0f00b001b801044466sm1856594plj.114.2023.08.25.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:37:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 08:37:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <cb6af915-a92d-428d-89a6-44406660c312@roeck-us.net>
References: <20230824170617.074557800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
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

On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 487 pass: 469 fail: 18
Failed tests:
	<all riscv32>

As already reported, all riscv32 boot tests fail. The failure
is no longer seen after reverting the riscv specific patches.

Guenter
