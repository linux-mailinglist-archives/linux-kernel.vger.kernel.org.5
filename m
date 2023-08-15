Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFBA77D0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbjHORIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbjHORIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:08:34 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F37BE72;
        Tue, 15 Aug 2023 10:08:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bd6a34474cso20676a34.3;
        Tue, 15 Aug 2023 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692119312; x=1692724112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ho5kGogOP6DWyhDIzrq6p+Riu+RWi3TMu4byewlsQhs=;
        b=mdW/1e/W7XY4CfpHWvJxRbVGz7F3nmV+RJnS/6fY2LnpTN9XlaB4xlMjrOpsFZUA82
         2g1Z284AWx4Bq8+OzEpn/0yHdGdyeF9r9AUcaPQYss0DO8NNFeJIIYC6GjN0+fI7G/Qs
         P78tl5nLN8jgxjZuC4bE3qW+A/CuLGf36t6asVrHksf59ZkQKkUCGOstZLKfQ0WRWim9
         h0TatdokYMetmBGqLPi8h5EbaVvk811PCcI+PRo0MRLn3TTo7/NOw0d7rRxXrFRzUtFd
         6MhPzQInl7i0G8X1/MNwY2nin5vpVU/ty8soI8fQjo1WIl2WnDLaExIheTJtHDXLhi0k
         Vi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119312; x=1692724112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ho5kGogOP6DWyhDIzrq6p+Riu+RWi3TMu4byewlsQhs=;
        b=B8uy8+fQTKt0CcmWhA+GeBCTcXahxB9betZzDBDAAPoZbzfXWOx0dXzCoAZlV4LstR
         sqXT24uX/T1t1NN3RLC/TL4E/yz4L5CjpUrJNNSFBwJsfEJQ40QpLpifnXH3ZTX1Jwh/
         bD8JgPJ4cqBMPV5MZKHtudGAtezOoc1sd1aAHTczFp5aj0GATVu4QyNTrw2G98h1uaWy
         ZvYFcIoD6M4yU5F+TgjhMkeH26orOEwtyYawtQc/UdIYSmjRpkbwb6tIwSm4Rr5TeP4Z
         ZkswPNft8zUqXQb2F0oAixVDQ/Pk9Cb7DagN9uplku9E/sd3GiR81GSfhgGsPYA0ipkQ
         ZI1g==
X-Gm-Message-State: AOJu0Yx0A+jc6DZzdleiz7KBnGGonoFKqmG+J8c3/eKdIsB23EaYTs3m
        r0opBHX6/OMSLLUMb1TMD/9rrIjtjgjwJaqidC8=
X-Google-Smtp-Source: AGHT+IFVeZ8vXYWhnBGyfV/KgjVLfGU5Z7P0BGZng+wE/kkg2N1Gs8oYDpbR6kKYicc5T59IDvb2Q5tOhWhHEnEGf4k=
X-Received: by 2002:a05:6870:70a2:b0:1bf:4a66:d550 with SMTP id
 v34-20020a05687070a200b001bf4a66d550mr14156616oae.52.1692119312436; Tue, 15
 Aug 2023 10:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230813211724.969019629@linuxfoundation.org>
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 15 Aug 2023 10:08:21 -0700
Message-ID: <CAJq+SaBA5tYcz_--oDvR=vG6dM7n_KRDO3hEzhomJmSMAAbGMA@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.4.11 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
