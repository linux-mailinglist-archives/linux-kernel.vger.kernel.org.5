Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380857FAA55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjK0TgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0TgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:36:10 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A2D5A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:36:16 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1fa619735c1so548625fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1701113775; x=1701718575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1IRooEsUin5INdOJVJKOU/vU4IncgxmhANWRJafAQM=;
        b=TWOnMD37y9p2+P/sqIyWKQWiYJkIJukzkomNRD1fBSCyE3jlpMbjyNsc1oEi6K5MxC
         dZOac7PIDBRwM0KyF5qS6hJie+NZpZ3nGA10ys7UsIE2RavXVLtfuLeqZFV22B3KHCyG
         NBl9b/9KFMo4jaWufNovXL1LNPbO1Yo9ObzQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113775; x=1701718575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1IRooEsUin5INdOJVJKOU/vU4IncgxmhANWRJafAQM=;
        b=vWcPQs2YhiZxaphBUpKkopAkWr6WAnrbqKlREanTSS6sVOnNLYl0+53UVm3Kr7BnQ2
         b0kCifQ7feTkb2yXeZwtnYbk1bmyusG3OWLV88U9VSAEP4JlhKrYJbAuIN45WE0jGF/v
         KTasTvtigsUq/qOjzhec6zb8r99IWsnCHVO5khTzLpRRkEJbsFro+Nz+msPjptKt3/s5
         NrmWw4ruGt31m0Q/A8iYqgzJ0J+GR8G8U7qFW2V27kGo96CVBUvhXdfD26V3Mp5jYaTQ
         o5k6kdYWANFOSpxEFwegB/NfTRrTeWAvd/u4awVxYA3b46OpqnDsmMRJX4RY/71yWErC
         aMLA==
X-Gm-Message-State: AOJu0YxYf5qaauZDYRVeED0zcYv70ZvlLrInptweeBPPIKSfgS70bQ8u
        u/rVtnemDiOMMg1+9G4oHDIGDBP/uBfJ+vw7kGl/F+8AAowHRw==
X-Google-Smtp-Source: AGHT+IEJ3WupWcdW8AN5qBBpFtWvb9iXJuzI4F91nYX9vpETnliJBN68Mz4orAkz85eSDwTlP02vkQ==
X-Received: by 2002:a05:6870:6c0b:b0:1f9:571e:f80f with SMTP id na11-20020a0568706c0b00b001f9571ef80fmr19132032oab.13.1701113775612;
        Mon, 27 Nov 2023 11:36:15 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d6ac2000000b006d81feaab3dsm521897otq.69.2023.11.27.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:36:14 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 27 Nov 2023 13:36:13 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <ZWTvrVH5kSM-o5zE@fedora64.linuxtx.org>
References: <20231126154418.032283745@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc4 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
