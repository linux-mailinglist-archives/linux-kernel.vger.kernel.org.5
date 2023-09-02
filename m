Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF107904F8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbjIBEVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbjIBEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:21:02 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941E1704;
        Fri,  1 Sep 2023 21:20:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-792975085b2so98914739f.1;
        Fri, 01 Sep 2023 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628459; x=1694233259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hEjY9vj5E7uMkH5SH9VhgI6wy3KF5lzRxFg6Q1w1GA=;
        b=cslQOB2exznmbXSnyjbBtL1t07fK3jOINg2CgIb5yeH6/WUZqjF6yTL/HLORb99xhg
         TOA32o8mMQQOHyShnL55UUYQo21hG0VSFh1HaKMLMNNtkOGeyZaJQtT34gtCFaATqZQr
         2krs2W9udXHwYVoIa/doUiem6lV0gjaGzFmOW5QksPtU47tgf9SBRCBTAUG+8lJXW3YU
         407YuHmleg/2E8GrA5ikvJi6S8L/RWiXOw6PBq3XKmDUNo/0c6rI58yLTl1oPSZP3xBr
         BXA7Ar4kbKZlDhRqqQVXRw65vyLe4i0Tsokx5gS7UJXWOJ1cvlLonVYnhhFIOJH14cpU
         DR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628459; x=1694233259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hEjY9vj5E7uMkH5SH9VhgI6wy3KF5lzRxFg6Q1w1GA=;
        b=J7Gd+HYgoLqqZ5IIbtPEicsnCUmxx1EQnJPlDZH+B1Tv2Ih7VIUKWRZKQi/ZC2xi6J
         blog7+MZzcRM9X5owSn47O17L0zBF/F+586JJea+Dz0YUr4N18UEaPLUsx1eP6XDxO/j
         3HB7muYo6yKgALuXPH1BXQtjNczdIQrzkaB2Kf386xPvXd6pDpDAbylP+soXntiE2ze4
         wnh8En6zmnT1Oph/qUMDpYXeq8ouooOkdy4vQlt9n9b0k3aZMlei/bFMIJcPWN2rO73j
         kQB6kLKdMTwa4/XkuRztl/4YIlfC5wLpTiGJ7HJFqlOPaVwIyZP+duoPXw6EjzzJKXex
         mbeg==
X-Gm-Message-State: AOJu0Yz/dJFcCYFH184JFKwy/W+jToNZbO/DWa73ETxIYk6kmj7FqV8l
        l/iiVVwCKK9cyS205nIWVvw=
X-Google-Smtp-Source: AGHT+IH74zWwDIm0Q2OgSJlKWeZM4fba5zvlPeF5Ox1th7OCd0uzHDYgWyALsE45xB3K4A58kKybjg==
X-Received: by 2002:a6b:7b09:0:b0:795:1c0b:d31c with SMTP id l9-20020a6b7b09000000b007951c0bd31cmr4657585iop.21.1693628458873;
        Fri, 01 Sep 2023 21:20:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d9b08000000b00786fe5039b8sm1556644ion.46.2023.09.01.21.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:20:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:20:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 0/9] 5.15.130-rc1 review
Message-ID: <1fefc96c-08b0-4ccd-9167-d5d7d4b77f9f@roeck-us.net>
References: <20230831110830.039135096@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110830.039135096@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:10:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.130 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 501 pass: 501 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
