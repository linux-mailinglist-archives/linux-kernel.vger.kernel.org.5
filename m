Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD9776468
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjHIPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjHIPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:51:31 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE51718
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:51:29 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1bb782974f4so5443247fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1691596288; x=1692201088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzEMa2xi1YHE1YCoFHllP02NIOrQ2JqY6Z4i2GNEvKA=;
        b=JREU2qwdrGKaOLF7DEkk+0a7FTW3TnWUQZybq26KM5Ttn9XP/o1JZq2j9lATYRiupm
         N8AsPminfb4+emBT3n6alpAYwKyoFVb9H6lI6G9+JhQyGsgftfuiDfiZVV1FNzfV1SbF
         IAmrva3UT1hIBKdTT5VYhFdDJ8nLqvHX8CZFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691596288; x=1692201088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzEMa2xi1YHE1YCoFHllP02NIOrQ2JqY6Z4i2GNEvKA=;
        b=BWTWGi3cs3MbpaWwajSUQ3a8KumgFZslO0KjJfcAYgsE7XKuI5IjG3MmvTnqYAAPGv
         Y5QzqaDc6AVU3k7bYBOHxnrjeQZUXulSDnLHnhr6OXvRuc9zzs0B3z9IXJUa6Esa7hoY
         nwpUDP3ry2Nlv2B3gthjkhYRBO+aVTWf9Pz+Cs6xyGUKkayyNNcv4MMFTyvE5jZfaoyI
         oXCieiGx/9Vkdxa93v92dWYosHrtZgQNwGVQ7NGJmM/XNTwQZTPuQX6ygvalva1nW6pg
         FrvzqlKgmMXNbAQ2S6zV9v3/WceR1Go2Ms2Sr4G5Y78Jz+L4TDyft6joJq/lAYbBy0EX
         6YGw==
X-Gm-Message-State: AOJu0YxVPi9sPDZgxEvE2fSeRJAw9kOzLDY1g2WRs6Ss7GewMMUyXy43
        KiMrrgA7ycutI2SqzaMd8uBvhw==
X-Google-Smtp-Source: AGHT+IEXa9hX+zGrGRLhTmQcnBjAWVIlo+QyRqclBP/uRgPtWl5gGR3XE8xfr3gDFkmGMpxb5iaxZA==
X-Received: by 2002:a05:6870:b293:b0:1bf:2ab5:3ae7 with SMTP id c19-20020a056870b29300b001bf2ab53ae7mr4074035oao.50.1691596288546;
        Wed, 09 Aug 2023 08:51:28 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id xv9-20020a05687121c900b0019e6b96f909sm7230769oab.22.2023.08.09.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 08:51:27 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 9 Aug 2023 10:51:26 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Message-ID: <ZNO1/oJe3OwRG5gb@fedora64.linuxtx.org>
References: <20230809103642.720851262@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:38:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.10 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
