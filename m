Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2978FB0E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348861AbjIAJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjIAJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:41:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9482F10D5;
        Fri,  1 Sep 2023 02:41:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4018af1038cso17758045e9.0;
        Fri, 01 Sep 2023 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693561289; x=1694166089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxEtOzBuXpkAxEd5YMJavUAy4d21QZX3bUg6RyTknlQ=;
        b=Q8wbWphdMs5mH2Gsgl9jgk30dT0IefXUTi4Xrzt6jivjUdR1NPFuDvoc10blcEShb7
         TDbxjj+lp5IlrszOdUaJckceOaglIPFMJolavLlchoDQ+WB2FmF9wPN/wo6pEh2dBqkd
         yYWs7WP0AT99vVI7UBdpY4lYMVttBwXPKESJVFqFTN7z0G0GW1QIPVJI8LixLg9zV+0h
         SNrWbmv4taEoDM8Qq09WAEPS1zKUEG/U09c4jCsI6Iy5bk5C+udt7OiimPMXelQrsfNq
         Y7pB5MXnbuBCBbUcepBjLeh7HcQxFHk6h/FCeyOvpfzdDlQTGWXmvHfd3HJcfS3qdoNO
         5egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561289; x=1694166089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxEtOzBuXpkAxEd5YMJavUAy4d21QZX3bUg6RyTknlQ=;
        b=RAibTh8fWK5CgKooYZWXC2bZbjuTUq1KVH9Xf1GWSQ6bpPuJzJYlXfRqNRYslfqb51
         6rfEXkPBNZ3O87Opq+Lul+/KJAWdXSHOqleBraPtbDAd9vPqzsCAYUQyqo1/DmhPaxh4
         ub/wkEP8aCy6H2uXIGvKHkxyDS8bimwg+z7wsm2LxLJ1C3yv1YoqGpSUGgjhLQpzR9IO
         /SmoQ4r7MzcO7N18gRRoxrn0v4OjImE1uqv4dnieMS7PBtjlvt4TDw1K6otIaBVnmIel
         uI73AzdnL+eJrQYq51QLIkIyDQXdOL4QXJjuPCopanFlLHSZxbAPXYzl6R2KEULSApJ1
         ER+w==
X-Gm-Message-State: AOJu0YzhuUH+O/qbBXU2dCkx/f7e5Wv7e70G4OGpy3qtomKkHNtGM4oi
        ncuEkAAziGDvfdaf17q8YMI=
X-Google-Smtp-Source: AGHT+IE9EmYhdCOlENTTPa/wqm+fCsAFERo5S2tTfI27sSovINHc9HJE8L6T57CbZjfYwyKz/oqk6A==
X-Received: by 2002:a05:600c:22d7:b0:400:cc2d:5e00 with SMTP id 23-20020a05600c22d700b00400cc2d5e00mr1374552wmg.7.1693561288969;
        Fri, 01 Sep 2023 02:41:28 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c248b00b003fc01495383sm7468670wms.6.2023.09.01.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:41:28 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:41:27 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/10] 6.1.51-rc1 review
Message-ID: <ZPGxx46/alty9X16@debian>
References: <20230831110831.079963475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 31, 2023 at 01:10:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.51 release.
> There are 10 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230829):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/4888
[2]. https://openqa.qa.codethink.co.uk/tests/4890
[3]. https://openqa.qa.codethink.co.uk/tests/4889

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
