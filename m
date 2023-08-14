Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E1177BFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjHNSX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHNSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:23:53 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642D10E3;
        Mon, 14 Aug 2023 11:23:52 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-790aeee9928so130885139f.2;
        Mon, 14 Aug 2023 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037432; x=1692642232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWupG9DwQIYj9GGXdsQX071mDyjhufKSfGQxxSZ5484=;
        b=Svr2mtHiul4UwhULRwpJDSx/BAztyHSmfrQOurRbrFGIJI28Rr2Y61qsO9Ilsd4qza
         U2VUYuOQ3Q+yRLXLiIyxsLSnN8fS7YOfbHABM9hqvnVmnz75AEhN0zoHeP6ZYTRfCcmE
         45/5cpsYLGinQWRkxytySUYxLsfbXfnvtsCn/6EUpzJ6FynhT6cMh4D12FGIhX1C9TSu
         ifoikaSss2pW0xvcnhce7lxZEA+hH8BNfS8TJVPt8RjFTcqvEvVMMRR21Hav/fuz4J9f
         56G8Vcxg/QOpPFgjKLMSEIRLrzfwuVWX9BmFt1w/Ua+sYnZUcPZSUdKs7Hj+qAX/p1Bd
         FXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037432; x=1692642232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWupG9DwQIYj9GGXdsQX071mDyjhufKSfGQxxSZ5484=;
        b=Ea8JS8Ed2HK+H9c93EaTXrkogcgq0d1r9SWJoHB9P7R/KKhVVg5ZeLE8g9U/gMdYAx
         c5No0l4p2ViKzwPoXROIUm0azwT0xZO2OP3pysY8Jd+kemEa/aNE2jlPSbxF7lt7Y28n
         2yxfKvD+fZCADp16eGdJ9vTzru7LOCz7NARSXmuPOpGUSXvu5S6LWvjd0ARxnIZtUkGj
         /G7oZyQG9y8I8TIbcpFQC99ywnRCDLle0Vsjm8Loo5w17FpSTQi3Nz5V1QPX01lUlovr
         LJIR6rzA0Bx9zhoZ1y1t6IIT/6ZbG2JiDJmWduqPPjK8y+JFMXuNkx9oFabKkK/MNoRE
         PJEw==
X-Gm-Message-State: AOJu0Yz3EcP0lIrfWS60SA/u7XMRA0kUKQck1S3xkf3KvyJAUSgl5Pjl
        KYdSYhqi+3MNvmU9Z5GfzA8=
X-Google-Smtp-Source: AGHT+IEdL2mP0rO43JPP2eVbfSl6k8D1NAAP65CGIi9xuwSPGh9JxpetdwgDmh8FsBIJJmcqjTF1mQ==
X-Received: by 2002:a05:6e02:881:b0:348:b910:313d with SMTP id z1-20020a056e02088100b00348b910313dmr13371040ils.14.1692037432043;
        Mon, 14 Aug 2023 11:23:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w12-20020a92c88c000000b00348fae8a5b5sm3394747ilo.42.2023.08.14.11.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:23:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:23:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 00/39] 5.4.254-rc1 review
Message-ID: <87e99247-e4a8-4ca0-87d1-780ad7186d99@roeck-us.net>
References: <20230813211704.796906808@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:19:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.254 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
