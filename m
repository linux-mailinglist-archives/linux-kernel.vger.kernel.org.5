Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BA7FFF28
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377204AbjK3XBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjK3XBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:01:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C481B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:01:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ce28faa92dso13867095ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1701385270; x=1701990070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1cVYcm/OeSo6BOhKq2FohPdg3opafKLsK7d+uEW++g=;
        b=WAffCfHa43AJ8WcUhhvn2rNO2KY6+broUV6nm2v/W+u7Rt5bDgD9AkOA5aHjZZndUx
         hwS4VJJX0MDP3vRLidy7CvPLLwr6NRih43ZpYgBxF5W4TO4Ho869fpT2Tfdxua2i6NAo
         FwT8FyjW11seaPSccJfkfCS9LgiFmiNmtEvUxpnmRGqZjW0pVkIyp3IuIuonraNUNrSW
         GA/j8ozz1iFjra8N7Z7BTd6BopAPZsNZEZs0OyEBW1X2/k1Q2alMyaHM6KiJ2Knp+JnS
         CI3KrXnP2yAgENAYNL0y3z+KWbfC2ddDQK5S1AF11TI4eTqHunXDvnKaXGWnJmBxtZjO
         xtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701385270; x=1701990070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1cVYcm/OeSo6BOhKq2FohPdg3opafKLsK7d+uEW++g=;
        b=Tvs+7qOFazGXwnB6t6KxDnWwZN8D98DfgBJvSDtPusPPKs9g8KRtEbjsIcT5feE8dZ
         0gtADCUWsLZkcGUGcitvWCpm+0vJdxkquggPDrJmvt2bWk/m0SnsIDUNxphq37QInY8C
         Ta0WFaIlyYogWKIsiwpMlK7nS0PIJZBzix+qorlmRPdzqqt2PNcCkfyDYx1lF306s8QV
         4yz6CrPhp/n9j929a2fHKdoeeZtFd/I/2Zgy6firodzZW1cetLVzJTICl2v7ORFX0yKg
         yWOrLi5FPvnKyYAq2fA1SN0ewmsJQUcTcaPmiVI0LVZd35gmx3xmH6S+Wgkehxb8g2J6
         Iyyg==
X-Gm-Message-State: AOJu0Yw+yV1kULI54BLUqijeGcDF366TN5fhUA3Py/78pIvrRR5bzqM4
        83TtsSwYAZIlc7cp4/uvgVAl/WYpW5Ef0dOFXwV3eg==
X-Google-Smtp-Source: AGHT+IEdrStr8HreR71H8RgH+eVepHBA/3COgP49K7ESslFvasx7ODg2jWp1x8fYZmT0haRhQ9m/vFdzQPvWb1TtQsQ=
X-Received: by 2002:a17:90a:1dd:b0:285:9940:1bac with SMTP id
 29-20020a17090a01dd00b0028599401bacmr22407438pjd.2.1701385270090; Thu, 30 Nov
 2023 15:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20231130162140.298098091@linuxfoundation.org>
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Fri, 1 Dec 2023 08:00:59 +0900
Message-ID: <CAKL4bV5f+0Pbc5wLab96mqHfhHxv2rKDh+yiz196cSSvw9TU+w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
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

On Fri, Dec 1, 2023 at 1:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
