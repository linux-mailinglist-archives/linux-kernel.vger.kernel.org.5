Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F9A78C434
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjH2MYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjH2MY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:24:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5019E4C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:24:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977e0fbd742so556015266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1693311842; x=1693916642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1DpgeQF0qAJYwjOQwq1anUEnLtdLD/PWJWKK0I1HOc=;
        b=cA9XmJfcRbpUztCevZFe3yo0E656X8yAIzfKzOCkNBQey6M7j6DitExsyN6z0SyX1+
         M9GeV/m5aK3eGekA2kHNxNqglSbkD5ENHHKUi3wlKg+5nojr1km1OUPSikCmrXGytj0F
         4jyEBFC7wtpyBFC20qwSvZaLuHC6lAFSYC4RPXQFjJ2Xvz+Z0ECLIM4OS2rQpRGX6zKw
         9IAoPjKc49a5Cc53J8pjx3aIH1aw0PqyZwPj67K4XSaPP2aVGvITagZT9uryXSEG/fjr
         DB3kyxxgjD/I3fi+P6b6vSm2kQFbx8Lyo61NitQCnbmZNtyWLvlt3pUba3F2B8DvxXX4
         MV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311842; x=1693916642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1DpgeQF0qAJYwjOQwq1anUEnLtdLD/PWJWKK0I1HOc=;
        b=ePbFB7/4yCsWK5bpPHcjXRtgkqh3vfIXwkH8eUua+3i08RTIGfY97fhYvGVwVYm2OA
         Gurk/nFfskAYzA9vHNR3/SCKRCEBqHwDeDpAL5tuVw2jzsc2GlW9iwwjzQ/fqofGf7Dm
         nQfT4aoUA5Fs1cGpcMlaB+Mg5IPuCJk7qB+bqsKE1VegFimypfZK0dr9H1oN+SB4PEwS
         d1awylZ9PD3P9EG2tOn/3y75q2tJzEvL4QaPsGEXXLSLeSZnuEgq612Tm0ufMiCub05v
         OM65gHTEVH5G0sX68CcMVNBHgp3a4Wo5fc0Y8BGsQw4uexuiT060ys0Rhk5/PzRj3pxQ
         1EyA==
X-Gm-Message-State: AOJu0YzZu2kW4MgT6xBE1nzvn9eJ5k8Ep7ejYvljN9UA954XOEJfKNgM
        w9+rSSMCQIODjNi3jDhXt+vNmXURry1iXUPLaPSdVw==
X-Google-Smtp-Source: AGHT+IHR/4fdDkjCkO44/dq2ZeuQnhrhwd/+5QWGpoWoiT0wRctbDgQt3EbA24iEBZ7SyGgQyWIKrh9PYnmaIRZlQ4c=
X-Received: by 2002:a17:906:cc2:b0:99e:f3b:2f78 with SMTP id
 l2-20020a1709060cc200b0099e0f3b2f78mr22432508ejh.67.1693311842156; Tue, 29
 Aug 2023 05:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101156.480754469@linuxfoundation.org>
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 29 Aug 2023 21:23:51 +0900
Message-ID: <CAKL4bV4_k=G5FbiFxZnw70Vsy6CmCOpH3oUSq5_wRzVqdnz4OA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Aug 28, 2023 at 7:31=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.50-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.50-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
