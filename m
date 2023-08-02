Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2476DB68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHBXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHBXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:18:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A34FB;
        Wed,  2 Aug 2023 16:18:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68783b2e40bso239278b3a.3;
        Wed, 02 Aug 2023 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691018300; x=1691623100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UjwbB9sPQoEFgUq5CG0vkvCG0nOW5HWRrBGVJFd5hE=;
        b=mTSetejehszCzQtBIaKX2HkJxEwkYksCJ4T2eVuhJvH6r+afDMkQZzvISJj0pjDKHy
         laequ8mq7q2UfF+YPBHK4zjYJfX9HuG77QsLgcPWXRSdNDD0jarUuBBUk49aMSBdk5T3
         44E23OmO5T3Xt6SUSLUGlp87SOR2ChMrT8x0irzFNliKV4yyAf8DDkaJCY/im+rXmrJp
         VeH+9yKbyZilHqkctWjSPScgpJUVnYflm8aqtNTcc4KieogeV1CZx1GM1tLMxMNBX6Gx
         2Iv9ELxH63jspqETWQqcFcv1CmL+X8hPbl+zJRYyRjXTJDeYaB62gInO+CMcj6q4+Y4e
         gw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691018300; x=1691623100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UjwbB9sPQoEFgUq5CG0vkvCG0nOW5HWRrBGVJFd5hE=;
        b=VzHmcJMcYFO9pZkyDfAVZiNBemEKMwvTIviqnkuq8tHHV48X5lIyNvrOhVMn4sZqD5
         gtrmtrRy7uUumejN40Qy48qmvBwHEgemIhU5Nv9mNqWb6OQ16JGs3XB0O1psle7Z0z+/
         sQwvrup4AfGJ38MIKbk1HN445uQLAZYWfjFvp7PZ2PCBh/1wbW3zBSiMfZhakwMmzMsj
         USm0Fsqb/TkbEvj2lkoISTbauT88nTlj56keKz1KsJLPcHqnbaMMdoHYpyzajNmwQ6ea
         ccEsVUfsQ5XuoCdXmjLrwaBbYDdy060K7eXsvfsSJEee603oIKuUi/iVl0tGjdWnGO6P
         nCOQ==
X-Gm-Message-State: ABy/qLYCSgBqI/HCebslgcTsx40zd44k/s0O3sBrRQESdIeP+6FvZV0k
        8VCeti9mErmCNGQfW2lQR9k=
X-Google-Smtp-Source: APBJJlHAa8EOqdsjkPYjVKWA25b4kAfM34WNWfs/l7DX/zgHpGX+2PFzdzj0HZYge6VOYrd9KWidAg==
X-Received: by 2002:a05:6a20:9184:b0:130:9af7:bfa with SMTP id v4-20020a056a20918400b001309af70bfamr17588822pzd.60.1691018300522;
        Wed, 02 Aug 2023 16:18:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001b558c37f91sm12909774plg.288.2023.08.02.16.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 16:18:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Aug 2023 16:18:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
Message-ID: <e5e1bccd-8e73-43c6-bc7c-052428e7c3d3@roeck-us.net>
References: <20230802065510.869511253@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
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

On Wed, Aug 02, 2023 at 09:41:55AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Aug 2023 06:54:28 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 521 pass: 519 fail: 2
Failed tests:
	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:rootfs
	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:rootfs

The failed tests crash while attempting to boot from a f2fs root file
system, suggesting that f2fs support may be broken.

Guenter
