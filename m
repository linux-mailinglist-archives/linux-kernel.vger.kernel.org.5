Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A32B7E338E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjKGDHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjKGDHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:07:23 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77751D78
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:07:17 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2e44c7941so3321433b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 19:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1699326436; x=1699931236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtUmnXI5t0ND/jp+Ght3tKSphvzb3bRY83Nh8JP9hmc=;
        b=ZKz8K1iynDJ+8Xzar/0bSev4t6NOanKh1GgjKKtRLIuwQ1yrktiKCrouPn6h3i8C/1
         +w7fvfNyy1Sn6N+QdrIu5BXgXEISzN12y9RNbUupmDGjoqkz5CFhGA3avxf1YGxXd/6m
         O720OsPOafNXm0kdpbKK2mX9ARw4LSix6vKFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699326436; x=1699931236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtUmnXI5t0ND/jp+Ght3tKSphvzb3bRY83Nh8JP9hmc=;
        b=KsXq8PDGkRf37wsQujW16q09QqewGvD4iW0O+Ta5++HjOMonEHSSYdh9m7V/m0BM8j
         PGtbg+i5GAP2LWRHYQ15aCuVltXmRbV4l9A9HLhOtkL2koIKsDEI98gWWr6AKszxFbh5
         hwWm0giybTUuuXhlyvtv6bGhuZos/jtxWkgemOyHOm3Er5Y7Y+KNvieTvYFCmGkbykn+
         /9W/l6FN9iPLtYlVnWMBoVo6tABjS8jlpGCS273hBtdsOkFKP6sx/DEsp2pFcXdFh1O/
         eZq9djfAh/L5zeSOcThFWR3tJkIWTMNc2GK52q3WCTzJvvVZvojbe8Y2PF99yTiQUnTc
         ZG8w==
X-Gm-Message-State: AOJu0YzTRYoQMGsY4p7GidnKiOKhEkoG2B9VFFVigsrGV4MvtwTplLec
        k1K6wRyhKOYDZYsMj+Te2EbA+Q==
X-Google-Smtp-Source: AGHT+IFT6lsP6Br3V1pqr43R6QRdoI3ixaDhJj7yN91h+HiV6lyzbxqu2GrReJ7VMjKl2tZy07S4DQ==
X-Received: by 2002:a05:6808:313:b0:3ad:ff3e:d25c with SMTP id i19-20020a056808031300b003adff3ed25cmr32211896oie.53.1699326436673;
        Mon, 06 Nov 2023 19:07:16 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05680817aa00b003afc33bf048sm1472993oib.2.2023.11.06.19.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 19:07:15 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 6 Nov 2023 21:07:14 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
Message-ID: <ZUmp4oPrMU5qSHSo@fedora64.linuxtx.org>
References: <20231106130305.772449722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:02:54PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
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
