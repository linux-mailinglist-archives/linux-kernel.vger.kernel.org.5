Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A17D5FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjJYCCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYCCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:02:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5F10D7;
        Tue, 24 Oct 2023 19:02:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a398f411fso4712942276.3;
        Tue, 24 Oct 2023 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698199369; x=1698804169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzyWXBCmC4hzArGvKMooFXAHa8LrB8TP9psqece/XB0=;
        b=G1Q3XJ0jx0FSzeuMoaHwO0F5EWii4c8N+DRbYJ+IOkg2AITSToaV+k+K3mcYb13Wx+
         lxVemfbKeoqBRQas6tNj84TCd3fsbirM3h/kMvfg+QsGMHQB0phNg1aenaK8TpLvW2MX
         vNHG2uFytfLyJOwpJ+lNtoZ27BLywzdjuXLTOIr8ex6Z4YL6MKg6rjlYXgxfU6dpl8Fw
         MZ5Qq9qjJYBYPV564eLO/ELuCyo7ZF5Sm58CFXxqHZzeXBDUt0vZbcl1PUZcmOxiIRpG
         ff0NmkpWCB+e0ddsBPOAinZUiXfCKsb5RUUZb7yTsdsr4KsDN0jqwmLwjIR0lO1Kkw7o
         obkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698199369; x=1698804169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzyWXBCmC4hzArGvKMooFXAHa8LrB8TP9psqece/XB0=;
        b=D3gUAnasC202Pp19JBslzYRH5XCxihRha+XyfH6NDU7KUn4QDl0W83DvazePLJ71DA
         W2bwPehKHhxaS3rN3r+5Um7gPvPiPC/zMMAEemvVi5VVaI/CuOGg+MMj980pQvhclV3g
         yqK8XsmNH4pmeVX5wY2w90LznMcXUdrObQevTkyuKWD6A2bCW1QRJXgwUe4EO00z0wKZ
         fPd5WdV+RkbxW6820113fZqIJ8GLntlBAXaECzYVgIivGTZszxS3KDSiapbVspnkX+xW
         l+MZt7YdPVmt0c+scL5JI+paApVRyK2F/yJmBhYTwMkwch+iLM8v7qbozZXVYvUSwVNM
         RQqw==
X-Gm-Message-State: AOJu0YyJIA0FdZeQrY9BS2ll6p3NywYbXAYqu5fdzp9Cc4k7NXwGuNZJ
        UyV9VE7HnQKM158jLMmbZto=
X-Google-Smtp-Source: AGHT+IH0ytejPRDM/KrWMr6ZjDK3z09hNvU4eo70YB+WQSeAks7/x7cG6b6uIarfWfY+P2kZ76zxPA==
X-Received: by 2002:a5b:9d2:0:b0:da0:5585:c00a with SMTP id y18-20020a5b09d2000000b00da05585c00amr2663910ybq.52.1698199368679;
        Tue, 24 Oct 2023 19:02:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w31-20020a25ac1f000000b00d9ab86bdaffsm4054992ybi.12.2023.10.24.19.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 19:02:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Oct 2023 19:02:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/65] 4.14.328-rc2 review
Message-ID: <d06ceb71-52d9-4f03-ae46-4373d6175241@roeck-us.net>
References: <20231024083251.452724764@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083251.452724764@linuxfoundation.org>
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

On Tue, Oct 24, 2023 at 10:36:27AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.328 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:31 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
