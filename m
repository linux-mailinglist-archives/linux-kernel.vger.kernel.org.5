Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BEF776F63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjHJFNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHJFNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:13:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24B0FD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 22:13:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c93638322so103351266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 22:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1691644384; x=1692249184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pih6LQrUi43YvqWBWRmRVXsCD2JQwVMeHQVeBk6LIdA=;
        b=wpSX9t1ypn6ykzidyAWLy5+1M19wIoXXTuVSE6eibqFDmLcZDrTRX35J2ixvVm1pAC
         zIozAX50Q49/ZZ29y/7yBcuCoRkMpWphIODBYbZuQZSW9w1T82gzxcPIH+PW8j3jIskU
         uKfBj725spyQhr+dQYxYTKGYqLvTY9Lwpb5quE7NODIsGkk6eIo3MGKhZnSBJ0WkNjk2
         GSpBkhOUXaFiBWwRg8oL1O5elp7YKNfO2byTEvcnOvQfcMab9Moy9HnkRTlFL6G0F/fQ
         vfXtYG3lg+sHdI76Gj66HxrEx9DW/Fd9qobKNnd6Qzsj45nSsdFq2v7M4jDyRLoaSB3Q
         /ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691644384; x=1692249184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pih6LQrUi43YvqWBWRmRVXsCD2JQwVMeHQVeBk6LIdA=;
        b=C8BTn5N5q6jwgljAJ0/1ZfajJETv3mirg2WavprpKiovrG8hJldVSDwynmUKxXOT33
         sb43Ee+X/IbyXn5GIlErs2PysggBE8h4hXKsneQ5phphTXrH6P2kmQRoWaPag8VcbLba
         on4HwkB7LC0nwEN9HTbYaVR8MRymlaM/jKMzvixAFO6BI+WK+BEU2NZ4vOY4g3a6ReEE
         JtSLK33rXTRJ5KKvkP1z+phorklIZnQ9t5OV58oMVJ/teK/F0l8VXGTJ4ZwAmSLvYohO
         AtwRafnPhkVAUVs2eqiejiyzxmF6m+5x/y3zEJ31pLs4oQsQc/I2UGAPzVDL0tVNXcmi
         mgLg==
X-Gm-Message-State: AOJu0Yz/8xRs/7f99ci0Xp2sVK671bTDsVobQtDxTdnEh4yI0nc1qQ6g
        s1y4JjGOkdcUlGEXC2AXRjPhSfQKcrUBJ36O4MpU7A==
X-Google-Smtp-Source: AGHT+IEzT476nMFdd7oMze+KTEauDI/95cGFT61M2OA3uN2MKjbAjB/QpZvwm8I5fZRM7P4JQbz5EbFgyNlDmJzLP3g=
X-Received: by 2002:a17:906:3196:b0:988:b61e:4219 with SMTP id
 22-20020a170906319600b00988b61e4219mr1253319ejy.29.1691644384092; Wed, 09 Aug
 2023 22:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103636.615294317@linuxfoundation.org>
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 10 Aug 2023 14:12:53 +0900
Message-ID: <CAKL4bV7AtvfB=CT1ie4x3TjE-3jJ0JBi8xPwtkXKgtM84Y1K1w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Wed, Aug 9, 2023 at 7:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.45-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.45-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
