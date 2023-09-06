Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE63794231
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbjIFRtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbjIFRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:49:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF8D19A5;
        Wed,  6 Sep 2023 10:49:00 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf55a81eeaso668915ad.0;
        Wed, 06 Sep 2023 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022539; x=1694627339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EiLEqOiUuFsG5pLs9DQeYVreWHkGWHR7/Vi/UE5qiQY=;
        b=Sq3MPUpiUFrWDPvgumF2urJ0rxaB7gxTiL2/8xIYmxuKNjQrab606a6R5D1EvuoVhG
         wkEMFxyYDYKS2ykLICrbU+ypSTYcuWkWiGZ5LX/NDJTaI9/k9ZylMFa5OTDyd8JusMBB
         6KgtMJ0vNGtgYNCVuQv9x+yZ6CGnGX62i/LGVSkMsx1SeDY3Cqyt92irM57zNoqGcvsh
         W1PXRj51YV5rHOwS5kNeYaMaB8qzKlkQMiGuz3cYMtPEHLw8nOPUdYNT/ddTnXBXk3/x
         ScwpC3Wg5Pt10zG1uIgR1anxv1XfBa8z37sF6G+SjpEBJy28mjtMjoL/tHLie5Ti2Mpl
         2cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022539; x=1694627339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiLEqOiUuFsG5pLs9DQeYVreWHkGWHR7/Vi/UE5qiQY=;
        b=NDENH32hAPMOp5yLmGiGtB0s3VUpteZwH4EVXHJpYWtnn0YRtHK6ccrj4FgTaGFt6l
         WAwnBGY1Lyj3gPeS/uZY7dcmz8KZjaPb6gsvF3KUwle/DWKrV9KLyD54ohZNqw8oPt2O
         fpG3IbKrlrZfiTxpARaxZb+9CcIdKh1yWONrNE0sK4X67mc1NiFTtDVS5fyJbmjVcZZO
         FbKyAQ+eh++4O5Js0uzLjyeiwtVMKZ3DmcDoktGizU93rHw7RgduOs6MCS/za4yqs1Jj
         hpqhmSWTvw7wgDYU0OsKHGkI3r+s6M5tCgNywQ9KH3sz+/u7MulFZCvDQ9yzeb2mEZyt
         4rhA==
X-Gm-Message-State: AOJu0YyNQU5otJwO3QCoLqw9vN2l5kasO5V2VBeSqLHXjOANlorgfYSJ
        kbfnvg1HCNy1yMOJ/HVSBCubw1YksoZ+AYbI6UI=
X-Google-Smtp-Source: AGHT+IEmKaf0FLqA6/LpyRqv2kGRO3n0XGn+C8UOUCXtgGAJCZHSs9vWekKIk4GT/fkG5UY5pvPReM7MtqrUUUPzh4E=
X-Received: by 2002:a17:902:ce90:b0:1c0:98fe:3677 with SMTP id
 f16-20020a170902ce9000b001c098fe3677mr16562580plg.56.1694022539570; Wed, 06
 Sep 2023 10:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230904182945.178705038@linuxfoundation.org> <a3a98d35-bc3b-2619-c616-c8e74b57ea9b@w6rz.net>
In-Reply-To: <a3a98d35-bc3b-2619-c616-c8e74b57ea9b@w6rz.net>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 6 Sep 2023 10:48:48 -0700
Message-ID: <CAJq+SaA2M=7gg5UikGrHrjb-h=7u0xBcQsJXODrzFvAPU5uY3g@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is the start of the stable review cycle for the 5.15.131 release.
> > There are 28 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.131-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
