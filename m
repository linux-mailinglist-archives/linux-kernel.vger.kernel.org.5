Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47877C0343
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjJJSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjJJSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:18:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4668B0;
        Tue, 10 Oct 2023 11:18:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c434c33ec0so37336885ad.3;
        Tue, 10 Oct 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961925; x=1697566725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XnyoQ1g3Q1HQw6m09F9jRitIO0RjbfZpnIN7z+4Ea8=;
        b=JcnIql40vRLu+SMjsG3TSTm92lVxX7xMxPO9buFGtd1Qt8TIdrDaDeCLGC83Sv8gB+
         kba/VEUW/zSQYj5YnunbZZkj/HEDsmSbKAAGdN0D2f04BaG7jueU6f9OYxdkES48Dusc
         TaagWP4zCWHV1oT4g6tqZFsO+Pi1sBrhLXnGY5Pq9BiFHMjw98jIfodVovq929bxWEcA
         YKbpNKikl5FTHX5xoE+YOtPXOsW3HkaRQRWxzo5MdkvLAlxGf93xzCM76xBrpdkd0Cmt
         BttPxCBIbBLa5b9kQz4/RKgXdE4nMpxGeFqN6GgqoQCjEtkure6KHk08jrrugQumu7r5
         1SmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961925; x=1697566725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XnyoQ1g3Q1HQw6m09F9jRitIO0RjbfZpnIN7z+4Ea8=;
        b=SznM6c/lnZf0Q9J4ISmr16/MBblHYgo/h4F8iARAgDAW8xF3FW6+/djO+yFbg+jWM4
         c/nsNbcOKJcLcw8ElfQQ1Khk6AwJFUXFeeWJgWeDL+6JG8hywY6WDGwZm+IKa8u2HgsW
         Erea8Hvzv7i9LnSYcousAEOd3YL+fXvCcpuemZUMRYBYVKR3PI4L8a7OhRNVbgACcRDe
         kitADwBKtEPQ3jENKU1FsWUbGru7xfsTNqDoL1k407hk+b1N8x8PIEW9JddF5CUTpXBl
         KPb3nckLc0y944imEnJoFkyM7VRBYT7kFmDUa5KTZP792cYSr32mVBvUXrJI8CuoWsqo
         doCA==
X-Gm-Message-State: AOJu0YyT8UPwNsuaqUqf0bdZdagsBaatkPs9xqAmhVxCloSXrxFlvgS4
        xwzrpUABV+9JjzNti08rTAM=
X-Google-Smtp-Source: AGHT+IH0KmVaMdeP2KJmmw2jzVnlGC/X8o7+CPX68/TYmt/Ud6wSXDoKjFg6GTKhy0WTiTAN96ok5w==
X-Received: by 2002:a17:902:f68b:b0:1c8:a68e:7f1 with SMTP id l11-20020a170902f68b00b001c8a68e07f1mr7081125plg.66.1696961925144;
        Tue, 10 Oct 2023 11:18:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001b8b1f6619asm12121601plr.75.2023.10.10.11.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:18:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 10 Oct 2023 11:18:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
Message-ID: <63a3fdf2-737a-44c6-9a6d-bf5edd8df964@roeck-us.net>
References: <20231009130126.697995596@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
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

On Mon, Oct 09, 2023 at 02:59:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 495 pass: 495 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
