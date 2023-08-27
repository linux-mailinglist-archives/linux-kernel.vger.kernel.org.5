Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2F789D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjH0LUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjH0LUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:20:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA1B2;
        Sun, 27 Aug 2023 04:20:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a85b9c6ccdso1861190b6e.0;
        Sun, 27 Aug 2023 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693135220; x=1693740020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv597mlsug4SmA/Tg5j+d6idJJ4cgoPP0yO3s5S0vDA=;
        b=a7X9lbxQYcfOD8c2Cal8oivOl3+DD6yn+TBrgCL+tYAjJRLfPhZveQAb1MJldaFJit
         nKD1hkYqM4ygW6SDxNVynIt93rfDcM7dd8s4xU/B5KcaLmZG7XADdqUqwBBobcr/9lGX
         YJziWGcPBqRMTCt5Ss7kYrjTiFGFpFl1j3wmPAHq1N5hu8rewDJktrIrj3ph4L50XChT
         BDUJFu9HDIz5/FK23eUzAsWvBHIo62lltDNPBeQaQa9N+7cZp48skQB6n/ToAfj3o5Hb
         dSlT48+ysnqVLmtCZMDXbqCp3NF6YTZ+h8Ge5MlIPbaSBgMUme9mtjywgrfsTTxJdHoq
         HjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693135220; x=1693740020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv597mlsug4SmA/Tg5j+d6idJJ4cgoPP0yO3s5S0vDA=;
        b=CtFLwLy0AS0W8B+agM8wOksuoltuDteuSTVEOtjGjXIloevdpCKJE7x8IiL+pjIdKd
         WlyuIz/NW1kYHFdpdC3kbjQn2BFeytGrMSv267Lui8bOikvROeK8TSmfovxlsxkJihXH
         A90kM8Xi5BjG9N4Se+k8h3KgoS9ghfJIJeZ771c2f10kTx7oW29pBFobPE+ZxwkTXgJi
         9lSNOJjd1ZKIYPbtSZgZKb5nK2d8aQmQqVz+JH6XJoODubbfreX7MDnwua+Di4zui7Ed
         m2eEFdTsmCocy+wOhT+dQBJzUAVUE5y8RAKJkQew0aV2w2h6lXMFtZNj2Rd8G9izmqAO
         uoiA==
X-Gm-Message-State: AOJu0YykpLXQqpB9TZxqSMssaP0QZJJcLU1asFEAUHu8CIt9tVVZg5xX
        X6pYSfsRB0NzxVaXdDP+e0I=
X-Google-Smtp-Source: AGHT+IE/P+lp1Up6uIvkAFLA3lSkwCRWlf3cFXoGyIt1jVKHktOU3d1sEf8Qj4Ob5WBe9EcSJqgp4A==
X-Received: by 2002:a05:6808:2a46:b0:3a7:c2e8:5e7c with SMTP id fa6-20020a0568082a4600b003a7c2e85e7cmr7428805oib.43.1693135220320;
        Sun, 27 Aug 2023 04:20:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7824c000000b0068bc6a75848sm4646380pfn.156.2023.08.27.04.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:20:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 27 Aug 2023 04:20:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 0/4] 6.1.49-rc1 review
Message-ID: <b240c664-db51-4d5a-b307-0fa47dcb7168@roeck-us.net>
References: <20230826154625.450325166@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826154625.450325166@linuxfoundation.org>
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

On Sat, Aug 26, 2023 at 05:47:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.49 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 28 Aug 2023 15:46:14 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 521 pass: 521 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
