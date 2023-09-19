Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541507A6969
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjISROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:14:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF4AD;
        Tue, 19 Sep 2023 10:14:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c4194f769fso42845265ad.3;
        Tue, 19 Sep 2023 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695143670; x=1695748470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qilWP4l16Pko8V2zY8Gw+Fh5MGg9mIKSWEZuLvQUUxU=;
        b=g9jbY5BCYmwwVNUnGV8/OnCdacwv646PwYclMM7yqnzVdl9RgznHcRL3I3TpnW42nA
         4ZhAu8nx5phoGMzzYktJnUyZaNZfw4JbiNOFOJCj3DAFGhaCirRporskT6hZ6thtsVz7
         TlWddy89FCyyeaw70n3HiPCFECIquXHKF8dB3enJC9K0am5Xn2Hs4EU1zkwoZHrIVnH1
         pSbqm9ne+ktRKXhmbmixrmBylpAmq6qB0T63Gaw/Pq0nHEupV5qXlxDY7WeJ41cOhheM
         2YywFz6yk9sDcgF3+NUpp4Xi6eYbMQ5q0HkhCWx83HdZ57u9w4rUvGIw9ZjT5bbiuDDb
         GQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143670; x=1695748470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qilWP4l16Pko8V2zY8Gw+Fh5MGg9mIKSWEZuLvQUUxU=;
        b=Juk+K/2v9gPBQ/Xp87UF9yofctuSnKmGvY6u4UgG0kbTIhXoFF94T2aQO7ZG8Fqb5i
         bY1KVE45y+C8xBtkSlBFNWEHNLT5AaWQiXS/jfKq88Xbew/YROLddhPuZ7AzoHDAS31u
         JLKK15V0QuFh1FUcMkhPn6fer2OajrkaAFmncGS7OKSUcWA8X/olRl1jCHoH3Ca6ZNIx
         iORUOF1vhgV2RSBrOA6mf29WRSrceZ7uIYLVHdyOikThYh7KW/DyD1tVTTF0oNd8HMJx
         PQpepe0PkD3WQc5iyjPuDoI3puM5+paFlIG2GpbPzoscI5l8TO3IzvS8sv0cVPywEO9q
         iMUg==
X-Gm-Message-State: AOJu0YyS4faCuIwJjG35FUuNqNCDe0piYd4utFhXZCsonF94ZICnlfiv
        L8Bp6g2PrpSdSowqps3OtXkd9Ztmac+doG653cY=
X-Google-Smtp-Source: AGHT+IHHUaQ/wQAHUHYD4e4oP+9he47YSvDdrnOdpG6XSIk6oKvwiWwLqQknQFLVEBdSb3rmyCX02ogBy5WeRcq4XQc=
X-Received: by 2002:a17:903:18e:b0:1c5:66d4:b302 with SMTP id
 z14-20020a170903018e00b001c566d4b302mr58839plg.16.1695143669921; Tue, 19 Sep
 2023 10:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191113.831992765@linuxfoundation.org>
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 19 Sep 2023 10:14:18 -0700
Message-ID: <CAJq+SaD7MCJCTRGpV_UVhkfixKoQtdGpFjaD03QX4Q7fwZEByQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/511] 5.15.132-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 5.15.132 release.
> There are 511 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
