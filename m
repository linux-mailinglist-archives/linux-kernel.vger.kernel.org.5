Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C597A407E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjIRFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbjIRFeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:34:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13975124
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:34:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so5039830a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1695015277; x=1695620077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAs0kcdMl/DoP/iL5tBvKuG9qrkDrcB6k4947uVL0cQ=;
        b=uOyQim9VOwPYXvBu/iCkVEVuDRVuBKZZCv+zIT3nfc9HcLkfdPb92sbkcd1zFaebkO
         UMBfk0GwvHxuIIWID14xsPdvGo+RcNQJDOWJAXDCY6bw0xnoqDpqIRN6sUztX/5bPTkE
         oyl4/+6PxhmcsfkUV1QjPGECocPJIACFH67d/s2ZiuVBRCIACkOfzZKApqmpVoGqYrQA
         GDE6VeqsiRlzkQg2aCwWRPjkqn+D34ReUSjmlynAQHA9OiSnRNRv3jWifxrbsy5PsBlO
         eYmHLJ2zRleZTAkhjn2f7mo8easiIh5Zq3xoBhZw2b4PS3PlrOs5A1BDdyaM0/YqED3D
         sEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695015277; x=1695620077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAs0kcdMl/DoP/iL5tBvKuG9qrkDrcB6k4947uVL0cQ=;
        b=opKrsyCYgKGEnoa3Ht+eUaxLsgClQjla8aZrYkU8GZOkSbVL/znaq7yKtMblDOzXoI
         kcOxpkgG/Fzs08Z3qG6UhJW4sAP5HJ+oj//+rdNEh+MjlOxqwmS1kugWtvrVdi8dtbeX
         8GTIZrtJx5xOz1m1FkyS7lYupkjwRsSunQXKqGuDS+Fp+LZxmFp2HK+cJ6LIRNaZzjmi
         R/zlemjyqFS+5qJ/ZvQhKK0W9apVZEHvZ/GnemaCR6YG+4TkXPW05vjMb0V+JfjvYd1r
         +rBeGvo2f1xi/Z4nQbBxDo/cgipIASLAVSdJiwkYt2iDrjNIOHSzmpv+aSDjFiTYp0PD
         vZTw==
X-Gm-Message-State: AOJu0Yx0BtVT1ZmzXOfrgs7H+aD3TG0LAfJ9oHz+zH1cDkci8z0uT90b
        6WplSgOf7dM7+dFCH3rt4wfsroDSI3AEaNSvgaJX1A==
X-Google-Smtp-Source: AGHT+IHbQfrgDKC8eysrPXQk3qAY1NMSiNM+gX4sza0ZICIOgDc2Kb0HSY3yfpRZ3jeGXHl9hu5DnhCmo6Ef6NXxbOc=
X-Received: by 2002:aa7:dd14:0:b0:52f:3051:f7dd with SMTP id
 i20-20020aa7dd14000000b0052f3051f7ddmr6172159edv.35.1695015277156; Sun, 17
 Sep 2023 22:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230917191040.964416434@linuxfoundation.org>
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Mon, 18 Sep 2023 14:34:26 +0900
Message-ID: <CAKL4bV7k_Hi0rugjnx1Gf6Bqae93c=28nwhN1XfP7arqkLKqNQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
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

On Mon, Sep 18, 2023 at 5:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.54-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.54-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
