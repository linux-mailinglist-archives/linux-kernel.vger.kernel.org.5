Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9D7558EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGQArv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGQArt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:47:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCAAF7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:47:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3144098df56so4412361f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 17:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1689554865; x=1692146865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7N1u8eQl3UsRRKVg1OGodBCRp/JnrugXMJVQcwxQKBU=;
        b=UkdkSlCyKNKLHW7JpS70p8fQoVVOAfioMsYBIiQW8id6Ati0A02j2P2Gs2a8vaqyAa
         osQtghP7+VWCByQQ/2bMQGuYDY3V6knsPzrgmkj6i+i+7khqn07O1iIIK3UaKGaNC8gc
         NPsPieZe5J8RdkbdsQp3sDwtG9Y70ZpD9Yp4icudmC4SMRi1tDXetQwLa53lJOVAXEFD
         xMESZ1vM0CEZvvtEpWmIKT3d1lzMju3jlEwj5BlTP2RqjZC4KwWAVKt8GByifOMf6zfB
         efbEUkl4htiBYFH44P5/ScpLRQ0V8kiA+F5rEnPy2kZhyYWiKZmXrkkoQd7qMR5oZbSK
         gwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689554865; x=1692146865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7N1u8eQl3UsRRKVg1OGodBCRp/JnrugXMJVQcwxQKBU=;
        b=EiO7lDKo4JeAZxf2XNUp3mjC56t6+Wm3HtYRt7gU6Ze9hmCQbEdGnN5lRcm32jNacr
         ZV+oe8Pjs/4qEGqvzUn0jawTjWmSARJHNz+sL6BTMJHdkDGuRO4joWWMLnIM1HdZpYf+
         q71GhG8CfGzPm6CmUzhVGZ1E206uWosfKqcudPCEIfW2Eh3ILrzxyl0IyZ5uzv4kcAWL
         0EbGuJM4sW6fq19ZG4nXnfHQzVHEsGzrJOXRUsTrWqWjZ0ljFIPTrzfu0CNgEkYh0meo
         uLYObqfaHB/Cupiqa/hM6CTf25dpNG5QfgU/E1zF4rS/xPK5JQIGZb2kNn1YXbdGxz5s
         U2MA==
X-Gm-Message-State: ABy/qLZWNkDWzG4u5DZB9Is1nto7UXOhZbYKI60PrhYeGrvGnmYuDGe2
        KC6wfOLl/W8gfYrTbTFbHclawAyInkcI9Kznce43PNFyRVkEFWQIjpIRow==
X-Google-Smtp-Source: APBJJlF6Nj8sdVkDih4KkTUgJK3TCwMDEPBZEymJet0/wBV9/AmjuU71YQN7sYDfUbO01zqsPMSWlEmMchfPKumAd5o=
X-Received: by 2002:a5d:6904:0:b0:313:dee2:e052 with SMTP id
 t4-20020a5d6904000000b00313dee2e052mr8787758wru.26.1689554864863; Sun, 16 Jul
 2023 17:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230716194923.861634455@linuxfoundation.org>
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Mon, 17 Jul 2023 09:47:34 +0900
Message-ID: <CAKL4bV4sE0tNw-P+DjpasonZ8aMicxpXpHV59ddfYAGonPbacg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/591] 6.1.39-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Jul 17, 2023 at 5:31=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 591 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.39-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.39-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
