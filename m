Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEECD78D1E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbjH3CCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbjH3CCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:02:08 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D386CD7;
        Tue, 29 Aug 2023 19:02:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7926a450a0aso164954039f.3;
        Tue, 29 Aug 2023 19:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693360923; x=1693965723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VzaCa6AYBSBoE/Kttz1x5kMRIdSD5l8LHkogURtv0zk=;
        b=jT63mr4U0eJFe6RyhvUJEwUxL10RJsrZzCYXen1cuuoSRCM091y3JxmaMP8cXvkvX8
         bkVtbJWC3RUpVr3ZELbeqzVeD1MCkO0eSmmGnQ6zVExXIS7uTfJoiqwIY7P20Vaq3GCb
         yHvULllHjXcmYFdO1Z7hWHcd/fBI0bT5oM4xq40QQz4XZJWTCRzuCal1OoN6v1we+KBm
         ktXLQ/djhgkgXVM6C5i5Ji2vMlFaQ5nXlfq0DPrzpIk5PJngJ1mYrhfN7gHjkTChdEa2
         GP8F90bpQCBYQGtt/6HXQcwFEJRxw3jKYBonqTktRztPWYqDFJ86sDtDgJ3DWBwOMBSe
         rreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693360923; x=1693965723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzaCa6AYBSBoE/Kttz1x5kMRIdSD5l8LHkogURtv0zk=;
        b=BTi101jZrgm7aMzmHjfjXARHu7VfkOHMuo2En0Kn0McarZC80tEf8/FrH3Q/O02bVh
         A11dZmgSbgp2V6zoAvOVQauMfXU2iqdJht/1XDKwLgAObgmS0s+NBjsgSjdyJXzu3rUk
         +HzxEwVud9ONggPGMd9CN70kVKw5DjDiTmqDkS8qezbiPb4inv6kB6orGQxp82L0oRSR
         Jt38Jxd7qGr57wg5pijlTr+tps5Gev3a9HDX+lLNnR1OxCNqHywjrb5C/mmWjKqHpj2U
         SEvyO00/hDmtBOiC1O22l8aeEa82DAOddZE95wDtIIsQhlVn2CpXIakhuaTOMDgkS58Q
         3iwQ==
X-Gm-Message-State: AOJu0YzqeM6s4ynwdYjO/erojdTz80t86c8x95nKOfwimUCL9LKuublN
        3g81O1usaR9hVAK3AabqrN79waXJvPk=
X-Google-Smtp-Source: AGHT+IHyb7Gsd4x3gdyIIKw65Mk9SF6V6Ao7oPxVn5+vnoaq6hc6nBOJeeGBgUlBPcUDX+Ki6C03ow==
X-Received: by 2002:a6b:e513:0:b0:791:3db9:c97b with SMTP id y19-20020a6be513000000b007913db9c97bmr1107620ioc.17.1693360923624;
        Tue, 29 Aug 2023 19:02:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y17-20020a02a391000000b0042b48e5da4bsm3396429jak.134.2023.08.29.19.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:02:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 19:02:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/158] 5.4.255-rc1 review
Message-ID: <7df7ee08-71b7-4542-a3c5-195bf39916be@roeck-us.net>
References: <20230828101157.322319621@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:11:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.255 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 152 fail: 2
Failed builds:
	mips:mtx1_defconfig
	mips:db1xxx_defconfig
Qemu test results:
	total: 455 pass: 455 fail: 0

Same mips build failures as with v4.14.y..v5.10.y. Not new, so

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
