Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A242F7C8574
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjJMMP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjJMMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:15:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043CBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:15:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1c66876aso327663566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1697199317; x=1697804117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlX2uOgdFdyVvDQRBX2OmgWHNmFmGPEPvcnJT7mREBk=;
        b=TCKh8GeYc8mQrYYxvck8duqj1FzT/q5GwCz8oGB1g/EQq646KVZNbqavlzJrk2WQIR
         2fMliJQbVZoC1i05JByoZGhlP+45e3jtMFoel35VZVwPc3gbJGqWvvkIjJ8n50i0HWPf
         fpYvoMRsQeiNZJPiwWKlmhu13fVTp+RdK3kefAHspTQTouUuIx48kRc3D3uo9eCRvtiG
         SLvPiz4JRlDHO0JDMyILt0VPpx3MK7d9gKx9wpvbQl6O6lTWEtrPPeOM2gx367/gY7Dk
         WpzLFBH2SvjYO2wdYWBCaSk/kE40UZdxMsxY+KA77X5J+VOnlkbVcKBGyfYOACfD6+J6
         5v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199317; x=1697804117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlX2uOgdFdyVvDQRBX2OmgWHNmFmGPEPvcnJT7mREBk=;
        b=M8FPoyTIYAFdf/UGvb/ZKLTpv4t5hfBj4OH/rvWrs4IEMC+USk4usQzcPuu+XqyNA2
         meNJaR5lUc+koxnIF0+Nt7Qqual4z+OVC7ujUwzjsZJJO7ZNaZafxlelH4qyuQrPYZgu
         iFjK2BK5dswdkJHfhuwNl99O5dVLxiWpTms3lEsYTHWTjujpdKVM0oFhhjx89d+kO7TZ
         XegfiU/fD5BwXyBBxP/c7RPde0uCA90HUwZ7TzDBMTW0pseY5YAbYjNUz1F5R79biuQI
         EWp5BWx/phhKxIE2zuAqY/7HAKfROkh6yS6odPj97551dmoDS71ePnRsospW85r0ms4z
         NBqw==
X-Gm-Message-State: AOJu0Yy0Txj0t8cZtVF1oU17RylYZ1dUMn8M+lmMu2+JvX6HsXXHH8cf
        wcx6XVZpOaw5aMjQodWQqRuZp+3/VH1uhXLTIeKifQ==
X-Google-Smtp-Source: AGHT+IGRWZBsduUFUclt/en5C/1EQOPdjADBORz0lK1rGJIlwf8m1tOTRS4Wd7QLErHj1SkQNdMYhS2MZzzxL7gZr+I=
X-Received: by 2002:a17:906:ef8b:b0:9ba:3eed:879f with SMTP id
 ze11-20020a170906ef8b00b009ba3eed879fmr8067947ejb.41.1697199316954; Fri, 13
 Oct 2023 05:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231012180030.112560642@linuxfoundation.org>
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 13 Oct 2023 21:15:05 +0900
Message-ID: <CAKL4bV6LcE2+=Y_jHZ+bLQqZQ0J3v0RMitjcop0z8R8gXbp_xw@mail.gmail.com>
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Fri, Oct 13, 2023 at 3:01=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.58-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.58-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
