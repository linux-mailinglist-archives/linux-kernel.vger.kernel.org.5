Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37377941FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbjIFRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjIFRYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:24:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDB199B;
        Wed,  6 Sep 2023 10:24:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68e369ba5f8so67907b3a.2;
        Wed, 06 Sep 2023 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694021067; x=1694625867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qccLOFn0NebA/jrIta/G+mGqQIcHSVpro0Pr6B+XGoU=;
        b=oU83NZNYn7G2wxtS/ZmM2dkflhnkU1ZkdCP123f9iLFkVkWKRDEEpj0Qmvp99dOPnH
         v9OWqMO67X4l2GQnKZN+RMboM7ecxNzDlxWos1ypuMuzqEKflDHyejdfD1oNxQoRKxAW
         LVZ8RiBAw5XDwi3XRQrw/xDKeKven/HIcd8HoHqGI9sCyjfgiSZQrDdRYN8j9OSgV6Gd
         3fwM0TRMsoPkZ6uXhuQ+5np53f0MaPpngQItC80FYEB34Ds+3jV6sQjRb1wSY/x9EaUW
         /iLhK+CuhFNtIkDYhKbfQwz/M1/aOr9LBQWv6d7hoYYlpdUbiRbdD1xUNOd80n1QdZE+
         P12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694021067; x=1694625867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qccLOFn0NebA/jrIta/G+mGqQIcHSVpro0Pr6B+XGoU=;
        b=Nslybtl4SyEzMXSL2q3FjyrkvpmISh3GxOEWGYObBCQ7Gi8Vtm+vDtE2ksoIzTrtxP
         Cl564UUTAFFD+eYn7xcDCR9qCBwEg+xoQ8x1IQXIR3VfMB09uQxBVuRU+gh81oDxH/y+
         BQ4k+UmP2mmwaeleTkMeQdeJM9OPbrC/EBsLq2B+F77EduhUPQosvegCUBi+AyaGA8Pf
         66absuhwmaM0dJix3wYCaYrM7btdfNu90v8o3AHZlQFMOqR6NcUKTDkFOEI8Fy2CDcGe
         cXPvDoYO7PybYl80ynVERadtymk/7tBl3KYkmluKM/EpkaXm6LsdUFJr6algwM2G9Eec
         kIGA==
X-Gm-Message-State: AOJu0YxQ0XY6Yx5QNcz/6xvcCMf52YdRZlGJtbBv1ZtKcVJCKPQI6aUO
        jjE4hgaB/bVNDtowZFLgN34=
X-Google-Smtp-Source: AGHT+IHLPR0x8+QIk/pp2xjdgCSZFCLEoKwDAzs9xmdnRDM4BBGqiSDZNbnV8oeToyc0zaCR0qsepw==
X-Received: by 2002:a05:6a00:1a93:b0:68a:69ba:6789 with SMTP id e19-20020a056a001a9300b0068a69ba6789mr16298253pfv.16.1694021066935;
        Wed, 06 Sep 2023 10:24:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020aa78c0b000000b0068a538cc7adsm11077577pfd.52.2023.09.06.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:24:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Sep 2023 10:24:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
Message-ID: <4e5bda1a-67e7-48dd-a7b0-2b4a6ff02431@roeck-us.net>
References: <20230904182945.178705038@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
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

On Mon, Sep 04, 2023 at 07:30:31PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 160 fail: 0
Qemu test results:
	total: 503 pass: 503 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
