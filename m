Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB07E2C91
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjKFTBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjKFTBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:01:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF1183;
        Mon,  6 Nov 2023 11:01:18 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so4608023a12.0;
        Mon, 06 Nov 2023 11:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699297278; x=1699902078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnqhWQVVoM13n/6TUxEaGzq6E1f+94dxT1yUPj1Hc6A=;
        b=dkNkb3W3kjrgw3PB4yO8ycuwbRo0WTtmEC/4LK1twBRNzU1+CuL7Cz5n83EIHF66Y8
         s7SLoX25/R6esjQwnBhmsVbl5hOSdy3KaFIIjklRlfWCNvj1JGuJKU4IrNdVVjAHs/vN
         F+uSrXtW/BSjtyU2d9WlEkuxcbLEnLgt13US1XEA+Z2kaZUwySI9gIRE11KCkm+FJbSO
         ZF/Qs9He0R9pjY+Pm8BzGJW/EZaPFK4OkYS9/NyrwW3bIhRKmGxMA6h4RU+rqFpNiDba
         xVT9gC/WIsv4x4BpFpwjmBlnm5w/Iy/idlQKkXTqn08ifjoQ6Y2tjX4r/InkJ1nWBdEZ
         MA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699297278; x=1699902078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnqhWQVVoM13n/6TUxEaGzq6E1f+94dxT1yUPj1Hc6A=;
        b=YDLCam7+3woBQRxUybbHKyoe+Aq7R42sw2zVL2nWykc52sBEu4F9a5tJg8vtp0TLS2
         qKqbHn2KtoZI4NkZ8VkgDfJbJQ2aLllve+PJzQDkLOqmTLuLeYaQdPN5Q8qtL5hPMPIN
         +/How09xCYvMNHCQtjBIaI0kW4KQM7YgHBYafsWl1QK41xDjdKqzLpHNmuv3K3R1zrc3
         srXDIClnwyVXsVbdW2oQbYSvRdv1A6TG2WiHMiyIgG7TF95JYifwzprEb63X6aYgbB0K
         x+fXbtw505PVwviTGmj1Q8cD+K4GH6oHCHM4YyuXPhMN7Y0QWTfnmA282rmKNTUcJvem
         +Xaw==
X-Gm-Message-State: AOJu0Yy5x8hQ58AAxA1k2VaXjjTOJbyuA6XDZZqGPUH6SB9/oz+S0Nyv
        BLmY7sV9e2eW/Uusvo2lFk6B/ZE+QzgL4NVah9A=
X-Google-Smtp-Source: AGHT+IHOMzZhwZUzQo3gVEguGmnOtkoq11bSZEx+5KCfLgJQeTbR+2oEYbr1d2ZSVvImy9vDPVQ1PLhH9xiUGNVdTaw=
X-Received: by 2002:a17:90a:d913:b0:280:735:bece with SMTP id
 c19-20020a17090ad91300b002800735becemr521126pjv.16.1699297277791; Mon, 06 Nov
 2023 11:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20231106130257.903265688@linuxfoundation.org>
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 6 Nov 2023 11:01:06 -0800
Message-ID: <CAJq+SaB81+eq01-NGH_LqMCKAew7m-WE_05=qQ11RZT7fSD67Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/30] 6.6.1-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks,
Allen
