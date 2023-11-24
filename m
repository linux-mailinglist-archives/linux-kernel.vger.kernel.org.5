Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72027F84CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346036AbjKXTjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:39:50 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C27C12B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:39:56 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-462d4a5b889so367091137.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700854795; x=1701459595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFaoM2nPbmC77v3546G+DOzaGeOySECW/jienI0R7po=;
        b=hAzrCabcbfi1UkpCvkuH7hXVt7tjgF/PcHDFTV+d2CMEFykgm9ACSN+M6L+YMDYgJl
         MacB1tzlDNiE4bO9k6e6FNsCifZeJ3kfSQGXLP7MCQ/lnmjmlEdquCWwbIGWVZVIjzH6
         9DYjGncwAgPgiBhQjH4j/29C1o9iKs85hFeS6MgOH8LAn07kgC0Vb8JT12LoXsqAbifF
         Uc8m13VqrRQTdwB40QRl9Yl3EXJSPFwha4DuaOyyqoMY/GYUtZHlsN8tlLR1BVZb81iJ
         aAriv++MkCEZBsBMeljbKP7vBes6bGEvcN5YGsV+46zTxVsU9vCHE+DQ2j4H9DTsMP05
         WrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700854795; x=1701459595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFaoM2nPbmC77v3546G+DOzaGeOySECW/jienI0R7po=;
        b=upNhASaXRXVS8seI3pZYnF5rUo28nmiGAIzF3EmdeXPjHWcQ1JFK6MdGCFcPD4qZ9C
         H2PNVFw75NME9sOhPglHOCtYNqO/X7QrMENLXUR9HnLhPKs/8TNDLFRBYbCracuu2hUz
         Y05NIiFsTBEsGcx48dJEGwz/6+vuQHkQq/YNFq3WNhCEpRhQbxrQ5El9JI2aRH05YUpz
         od2+bH3BKK1i7ANVRi0Zg9ACn1Pajtma55ROZgeMfnjXf0hByCCkp8XCxHv+JMOhxKaT
         GhCoTOpHkl2UqseSGjtYStgpBrt8t0pUcdiXCtk7HbNywKh2YFbe3sTrTy81Yz0HiWCI
         0k+Q==
X-Gm-Message-State: AOJu0Yy8bxqDtiwXilFwTG0gRbiQmKJWGR2+9p9Pm7cSpeLhVUAMG6pZ
        mCcUjURQHkGU3hOadpsUd75Ndi4BMjRNPed9TIi89A==
X-Google-Smtp-Source: AGHT+IGE2G3fpION1Xr2Bdv7ckqaMoBQrZm3R4iwiuD1S/Gq234WQt/q1WgcB8s0vAQggepOJ+sFLXYnm7wW+HS0NTg=
X-Received: by 2002:a67:af01:0:b0:462:ac9d:fffb with SMTP id
 v1-20020a67af01000000b00462ac9dfffbmr4041899vsl.13.1700854795287; Fri, 24 Nov
 2023 11:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20231124171941.909624388@linuxfoundation.org>
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 25 Nov 2023 01:09:43 +0530
Message-ID: <CA+G9fYuVgqVc57YAwfA8MK6_Q86wD=RznCYKHDf_tD3foM9Y5w@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/159] 5.4.262-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        dima@arista.com, linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


As Daniel replied on 4.19 build failures,
Following build warning / errors occurred on arm and arm64 on the
stable-rc linux.5.4.y and linux-4.19.y.

tty/serial: Migrate meson_uart to use has_sysrq
[ Upstream commit dca3ac8d3bc9436eb5fd35b80cdcad762fbfa518 ]

drivers/tty/serial/meson_uart.c: In function 'meson_uart_probe':
drivers/tty/serial/meson_uart.c:728:13: error: 'struct uart_port' has
no member named 'has_sysrq'
  728 |         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
      |             ^~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
