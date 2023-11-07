Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752F7E3AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjKGLDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjKGLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:03:07 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E92101
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:03:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so3674838a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1699354983; x=1699959783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC3d6wWHpqdfS4D388YBQ7NgpKv2etiMwEuLXnGK4bI=;
        b=1ZC0uft+ctRU6rM3EHXA8X3K6UnHES1uG6TrkJLr5kBltU9yIpq7fwPAGSnra5CjHm
         va3aSQ7prfnxDA8tnQ+Qf/1xRCzOEQTaiSBLRH4QdlyXH9d30s4WiVtuCwwvPR72bqib
         exbh70n3fT8TB5Ov5V2v5UFXFjY+aJmJJETTapSBGvBOaM1vaYCgi/31gr6NdaKz/5v+
         XB1MKWIVdolRXMmdbtQ8G/qAMwJm+gXgpReGT6WiHLAJJg9sKOF020OxvpfnmyUj1WCR
         eE8FQYfvv348Es8JEDE+k7FTCeRWYOdPLq2s72Cg3gH4C6bIV1hSVeqkpqNepchaQInS
         GiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699354983; x=1699959783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC3d6wWHpqdfS4D388YBQ7NgpKv2etiMwEuLXnGK4bI=;
        b=gk5WQ85vm7sM/d4U6RJUaNS6sBqBJY9kqxQl3FDTq4RZ0/WAv/anBSvQkvO/TQAOJb
         pvtYErDlpXkF7srO1LWRoNYNBWc0S9iAneEP6EaEJDW5zjNFUouxll17oybeZenWQ6za
         mJV9qseE/LP82+R5bmqTzHGbwna7lvWsKvHW7dfy+WvSyobA8i/0idWJGK9i8WaWdxtw
         7JwiXhBo262yT6X3ffnZFpQVunGEO5UQR3Flg8NaRNjt+CzgrtoEr26qGMCJsN7Pu5aw
         EHFzAvuus6EpocOxh0DBfqNddV5EqH8SLCcKiVeuLJ/MFyh5NEz6K3diF3kjDupk/RrG
         2FIg==
X-Gm-Message-State: AOJu0YzyehmqVPw0X9CV/mxYaMGmDYbhy+95xmQRc5kFvEAzKZzdiqTo
        615HksiH9AA3Ui53Uv7A6/Kku0D6NV84d+n/HdF5Hw==
X-Google-Smtp-Source: AGHT+IE7iI43DIi/hwt3+oaAr9mreCpy5srt9xD5cwQpQTRLmMVPxEuYq0iKgOPV3XgIuhu7aw/nsI9WwKAbjdKwRrg=
X-Received: by 2002:a05:6a21:7742:b0:181:3dde:deeb with SMTP id
 bc2-20020a056a21774200b001813ddedeebmr18127765pzc.33.1699354982747; Tue, 07
 Nov 2023 03:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20231106130257.903265688@linuxfoundation.org>
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 7 Nov 2023 20:02:51 +0900
Message-ID: <CAKL4bV7DhfiRGXDTtMLvHjEKYApXyOmH+6Uvs5y1SWkJN583DA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Nov 6, 2023 at 10:07=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.1 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


6.6.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
