Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3057C033E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjJJSR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:17:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C427794;
        Tue, 10 Oct 2023 11:17:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so3611476a91.0;
        Tue, 10 Oct 2023 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961873; x=1697566673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSVqlZ2QCY+q+P0NY4Jque7YOngdew2/5/sX2viPqJs=;
        b=DxJucWHnrEze/YUkyU3UMC8EmxFna2h2PIgPzIJ658HjX6dgmpSYpM3e0TL758nZTm
         2aM/mNLWsh1pJEYePB61IhsXxcsHHjebg2CL6o1CvvifTB/LEROQHFCPPQaCiFh8S/SP
         40L7mzW+tZlq6sHVwdNVo2POqVcF9xSFktZFt5CePUOZCKWyIL/A49KJqOX2VkMAmXxq
         EyEkUBJX1AEOlLNBbmEhy0dTqrnnM9Cv5hU6Pg2FVcE9SPgN3+ld3/02g6o/zU2zN5PK
         XO9vuFkeMrAthKxvS5X7gsP/n/VFhcybWwY2I0Gs3uq1Eo3QYFQw1ZVfY5hE788pmJ8E
         6r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961873; x=1697566673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSVqlZ2QCY+q+P0NY4Jque7YOngdew2/5/sX2viPqJs=;
        b=BqFNRYTqUH6iU9eDHxMKhsIHvnxkihyEU4eJTm8fxLWs/inApuKLCYqvdRsnsm47IE
         d9LMO/crNzyhJDXROKUYQbS2cnoIGc33p+ckdRR0OL+3eh2YC5QdTG/5g928iTjyCDfM
         iTM+1zWXvZB10orqX6mKz/+x364zPUIlNq1nO+kx/O4tMlTiurweLuf/xMG/xuhl/VOe
         eZHVVl9h0X1gKhDfUIBMPF1WwaV4HfXsdDV+Oj7zhHiTyx+mm5XNfH2ItMOD/5bxhT6/
         7e7PL3rWEMBAuEHzbMS7/3c8mvgCtg0d9D5XCASzH3PCWnMXqXBhnjJvyHC4CaeA5Sgq
         2pQQ==
X-Gm-Message-State: AOJu0YzyRusnRKfwLqCD3uTYH7x6KdxbvxFASRxKQ71IWy8jEB+wnTgJ
        e3MqXglk5ekodwiTW4OWAZs=
X-Google-Smtp-Source: AGHT+IE5LF+MegL0OYswGhEirUxxAiyTuJATRJ3N2ByD8855jj0Pf8wUiUJQ9tgMVpEM2A3U02D6HQ==
X-Received: by 2002:a17:90a:950e:b0:274:8be8:f767 with SMTP id t14-20020a17090a950e00b002748be8f767mr15907087pjo.15.1696961873147;
        Tue, 10 Oct 2023 11:17:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b0026b41363887sm12295693pjb.27.2023.10.10.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:17:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:17:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/91] 4.19.296-rc1 review
Message-ID: <2de5ccb9-39d6-423a-bb4b-bbb094dda746@roeck-us.net>
References: <20231009130111.518916887@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
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

On Mon, Oct 09, 2023 at 03:05:32PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.296 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 441 pass: 441 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
