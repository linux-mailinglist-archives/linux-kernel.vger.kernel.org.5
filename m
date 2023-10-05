Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E97BA6BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJEQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjJEQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:55 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6065B2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:36:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c4b9e09521so765992a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1696523770; x=1697128570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYHj3JFmAZKHkL+wnxS109TagHXpAewcZFhlnZKyAfc=;
        b=JJTVJJHW5p7Pu59TFtLDMU6/XqrU+Eq9Y6zB8uHLHqubOUDW8Xump9BxEul2aKdODk
         JRcGJJ7pHYvxMp0q8d5Mzmzt9xx+RgE3Ut5oxsHSFAWhw4Rs4pu/WNLJK8j66MdhqpZG
         PdGDOyPLDiOBigUjkQWWHsZ65BF7uBD4ZQvgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523770; x=1697128570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYHj3JFmAZKHkL+wnxS109TagHXpAewcZFhlnZKyAfc=;
        b=DtKgcn1Wp3yyd4wbEFhi02yU5PnzpjMmgMAXdFebPFe7UR4g8jyHoDaoRM/8v6A1s9
         +CJ61IlhGWosTZ8Jem/fSmadn4L44r0cyAdeGmMwvLhiW+5dNTDxO3/CJHEWA1Xprb21
         xaAJiewhlCEN/CeXx33kxvkhKKHUB/H/xFm1u8ZOp9lHzws0U++72hoDoLZNJgy7Jnc3
         zNvWTohB7DcnYhgwmMVGFukNnIN0WdtHsqbpU3B2DGxy6FpBT1DJVkR6AEidlDm4Zn7g
         4qQYBa0rG7IkmhV8u+gyhcq9UjqhuVmP0CbO2nRuhVww96L/cygdc+mjaiISro2IcHfi
         RLIQ==
X-Gm-Message-State: AOJu0YwU14D+9jC2d79/2owD76/RTEO2RkuFULXD2K10QUz1ynTtshSW
        15Odj5GPkSlH4/lDYOCy9Sj+cg==
X-Google-Smtp-Source: AGHT+IF1vZ6WboGp9C0l3uWZGG1N65oSqv2B+LlOIp2OMdFj2L2Gs4NqCVYwe07cua6EJsyW/v3WUg==
X-Received: by 2002:a05:6830:22e6:b0:6bc:fdc8:d600 with SMTP id t6-20020a05683022e600b006bcfdc8d600mr5849783otc.25.1696523770407;
        Thu, 05 Oct 2023 09:36:10 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id q23-20020a9d6657000000b006b9734b9fafsm304356otm.13.2023.10.05.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:36:09 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 5 Oct 2023 11:36:08 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
Message-ID: <ZR7l+IbugqOLaQtV@fedora64.linuxtx.org>
References: <20231004175229.211487444@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 07:52:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
