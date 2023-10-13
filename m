Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973277C8688
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjJMNPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:15:15 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241E91;
        Fri, 13 Oct 2023 06:15:13 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57b6c7d0cabso1196000eaf.1;
        Fri, 13 Oct 2023 06:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697202913; x=1697807713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HpbMkNgVwi+Ar7A5PPn4ZoDY7T1aQZdxGH1Pe6LwuOg=;
        b=tVBS3XGyok+0AlnVoGJEBPIdovq+Uwi42wxSpF4SaNgpkLJREv1ix/O0JpQ8n6QArb
         S+Gd4KbgLP0aavAmqVPfhVqcBHUC5qa5cFvnmiUKdL5+ir8J8q9lX/YuHqpuY4bqW/3C
         gNSDSNnmj1y991xqX/D8SFJXk9zb5868S7jmzWDhyobmIVBDhfLm1RVffhHUMsRFNBBx
         HXXVxlANDaFeBAxIhYdMaElSNhOyOxvqXHmQkj0XFquqNLSZYe00aq/0G1ZtGxOL/CxS
         Q7zz4XGsef3mGlIv3dvEDmx5MeoDNYThTjZ3O34uTgGJYq4+zflyQtaw9SCwTm+W+3zY
         V+CQ==
X-Gm-Message-State: AOJu0YwabvWTeKUycO4nBAE/hUf+fGTyDkOOkmegw58VMsNyRHP/4poa
        2s8E4fERut5o0dbfWqlZhuk=
X-Google-Smtp-Source: AGHT+IEg6Kcw+cvGLarWGl0qXeTmHCUAvE+CVMn06wg6ZRkiDPiC3S+f9ShipNIic1bHVT6dNi+UWQ==
X-Received: by 2002:a05:6358:91c:b0:134:c8cb:6a00 with SMTP id r28-20020a056358091c00b00134c8cb6a00mr29119217rwi.12.1697202912740;
        Fri, 13 Oct 2023 06:15:12 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id x12-20020aa7956c000000b00688435a9915sm462725pfq.189.2023.10.13.06.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:15:11 -0700 (PDT)
Date:   Fri, 13 Oct 2023 10:15:15 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697202910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HpbMkNgVwi+Ar7A5PPn4ZoDY7T1aQZdxGH1Pe6LwuOg=;
        b=ZWUw5QFSijfsuJuexFehmqTVQLJ9OdzB1dQF4yxqo+7RZeUZQs8NJC+YbXz++hsZpieTpp
        IMV142H+NW349J4Kmx8qT0hTUgtHz3lwCIpCKMx0665D6q5Iomgb+xb84YOLlR3RSOEzeI
        kyV3j4pmVeULqVEMMf9xT0p7v0abUXB0n6hAcx/bj5Dt+orL6betCzRX6d4PGj0miyj6fW
        6m1zgsksiA8Ex1fR/uywRPq9G41c77irb7h+V9Czwv9l9PpX+cHXRRFZPLMWv+wGK1Ibkq
        33PFF8YEnuxbiMbexeMGLTq8g6lAjbdaZJCPWXFF43hVoqDbLgrmllTJqqChJg==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
Message-ID: <chh3jvpgjgfna7esb44u2sg4m52zqjttbnywqjk7gjhtu676bo@7ldjgusg6l2w>
References: <20231012180030.112560642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/12 08:00PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
> Anything received after that time might be too late.

No build errors, dmesg is clean. My system runs fine:

Linux version 6.1.58-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (15), GNU ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMIC Fri Oct 13 10:03:55 -03 2023

AMD Ryzen 7 3800X 8-Core Processor


Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!
