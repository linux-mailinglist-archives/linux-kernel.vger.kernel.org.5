Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD847A9F00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjIUUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjIUUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:15:42 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9C561D8;
        Thu, 21 Sep 2023 10:17:44 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bd0a0a6766so740398a34.2;
        Thu, 21 Sep 2023 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316664; x=1695921464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stmDjRqrydw9T+1lCouVY3Uv1f4EVHPERdZg9Bbajbw=;
        b=TrJiUex6TC9T65JbQx7TK2ztMuv1ZhO2S6oS//DqMyrwfE4/+hVn0udX/8YTWhchJi
         ZXf4XOL5Lg2N9MYX4FekYbH8tDv1GLJHBjn6TS6bV6J7VyvNBEQ5cDA9NVT9f6HirGiC
         qznzin6OOAQ2a6/DHcngeNaQ+2yeIZ41gWEVq1cF3Ze7h1ox14TMn6C5Wp3BA083vebf
         0mmJXkf2W7PtjUI8HtvEXzIBKqKXbyG8HCak9G2tCjMG8P8d38LiGqb2x5wb5ezgN9CF
         CSnWURdPMdCVeOXbDAe53NtCWdH5bYHi38C1SwlET9sCBFkwWKxMSV9jO1bvvlEUcFOt
         zQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316664; x=1695921464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stmDjRqrydw9T+1lCouVY3Uv1f4EVHPERdZg9Bbajbw=;
        b=PvgtmCZ6yt1KmtmJKRXyIVdMEHTCizKYB+EgP+2iDxpjxNetuEIRk0AODYoK+NtK3w
         2UdJJXsAn13+WcW9BYZWgUT4qa1J2tzJbzJjlRgmWxsTrFl5QVuhu1CcZS1fGalfBcB3
         ibgzw1c66K35tuZTpGEW/YmoTjCZ79ujVNClSN7I7vyZV/ZXsdEaGGpWb3+XLOitY1AS
         3etyB4m2COxN8/rH1585FyWYNtJmIXIkqiccFXeiXvA8tjdENC3sI1s+Nnn8QeSLwF9E
         ntVAg5kQZW8HIMsbXfdZo6sYYz8HHbv9K843uBZwwsk/M1dpknG1GyNUwcGyetSzt0fE
         64QA==
X-Gm-Message-State: AOJu0Yy0OPFVXm9D3B6T1IKLynAzpoJGw6HJ7GdGa6cOjaKO2d77ylCS
        4J99nRYS9FEP/0J4hWudNhgHuGjBnoE=
X-Google-Smtp-Source: AGHT+IFiHZyMRpdGiZ1E6UXgm573zyR7TWSjF/T7qDc93cQOg6cZFDoXUiDGgaEVHX5802gBYd7LEQ==
X-Received: by 2002:a05:6e02:b24:b0:349:2cd0:4368 with SMTP id e4-20020a056e020b2400b003492cd04368mr7539506ilu.18.1695312190710;
        Thu, 21 Sep 2023 09:03:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9-20020a92da89000000b0034e13ce8ddesm511420iln.21.2023.09.21.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 09:03:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 09:03:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Message-ID: <7d99c7d8-cf39-4ab8-a385-36af98f4a30a@roeck-us.net>
References: <20230920112835.549467415@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:28:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 156 fail: 1
Failed builds:
	powerpc:ppc32_allmodconfig
Qemu test results:
	total: 529 pass: 529 fail: 0

Building powerpc:ppc32_allmodconfig ... failed
--------------
Error log:
drivers/usb/gadget/udc/fsl_qe_udc.c: In function 'ch9getstatus':
drivers/usb/gadget/udc/fsl_qe_udc.c:1964:17: error: ISO C90 forbids mixed declarations and code

Guenter
