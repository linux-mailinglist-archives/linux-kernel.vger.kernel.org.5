Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240977BFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjHNSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjHNSXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:23:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F328B0;
        Mon, 14 Aug 2023 11:23:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3491568afd4so15070015ab.0;
        Mon, 14 Aug 2023 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037399; x=1692642199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7mGXj27nvKPdrvcjphNzAz8ew1VuijtpTDLahQ3Me0=;
        b=hWMjL1VuMyUFT8geI9ue1b8iwLBkOB3bKjaIkfLh+/InmSXL3pgaU9XPHJP2Z1HXL3
         Jyin0VTpIr80W8UlC/6NLiWP9tS1PuVB09ddv7Gdm9GZtq26cBOjD11CRl2rDKSqlsvA
         2jXuBYnr8hd/XGA4U1wHA8sinqvwe12676xRpme1mmc909XNRHPtzev714jdjhh8/fvi
         gJd30zGBsjnwFy/myaK9LaYJT+5a2NECwRcbmsbbY5n3HLtbPfDKdB0jrFmVjyoTb3/E
         lyQkLa34sTPbO4YceSUDM3DTJdny061s+iA5XzQrTJZ3onJtder7AdVZzeP0boJqkUF9
         EoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037399; x=1692642199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7mGXj27nvKPdrvcjphNzAz8ew1VuijtpTDLahQ3Me0=;
        b=L9jjazdFQ7fm9C82VskYPC8rJ6sHlwCCDRNEPhI272k3g1bl7kSTXa/U3kkYFnaDyD
         gi5GsvH5Wku4Uh6Nvlx4lY54yEeIkFsOjNeYqFaJli3Eke8IxjtgiZEa9j235mx5YUh5
         0Rbs1//7LNyJ3ykehkPxNMPqjXAxo+rFvx9MrdnGIoD1OHPu5T9V1r9Ki6xzY/o/tnRQ
         4rRUNPTdoMuu2HI+nY6Fh24t7VY5ACe3uwwZPD3dOulMXilh9wUuhiymr4ZSFG/Lv4bc
         WNzju3SGL6+fYihiiXgk2c90C+wYuWdXhaT0RNBvpyueRDoZLVoS+fXtepL83Wz1BI5h
         EJ0g==
X-Gm-Message-State: AOJu0YzuVIsGNtNMgiDp2cG5c5KHT78suwuv+I2A4rn5tnmw4n4OkT06
        WeUEI7YhLW7iCt2WGRlx4zU=
X-Google-Smtp-Source: AGHT+IEdztibrkeZFfGiwXGgE6jepWqbfp0eXjJOV+qCac72t6Z/jif5IKBKkhio8ZsAy6iSofsL2w==
X-Received: by 2002:a05:6e02:1110:b0:349:76b0:4dde with SMTP id u16-20020a056e02111000b0034976b04ddemr12506149ilk.11.1692037398971;
        Mon, 14 Aug 2023 11:23:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5-20020a028785000000b0042b144abf71sm3075325jai.179.2023.08.14.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:23:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:23:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/33] 4.19.292-rc1 review
Message-ID: <b2a9b6cf-d9fa-44fe-9b63-52e9e3163669@roeck-us.net>
References: <20230813211703.915807095@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:18:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.292 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 432 pass: 432 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
