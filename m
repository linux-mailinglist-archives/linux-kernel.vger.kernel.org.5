Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE67A9F76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjIUUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIUUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:21:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5711D2B29
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:23:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502e6d632b6so2157129e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1695320597; x=1695925397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnhBiFBKyPiQHRaYS9dfvLmsrYNmtEwUZ70lBW9wVas=;
        b=gpkHPmEPKUqwdZjGfJVSorWzJV9PZSxhBpa9h7qrIP+HHjwaAdsJnz4QUQkGsOzWga
         t5tyD+WwDtt9m3RCtDqr8CQH7I3OSkGdvbYydTrtNrbyVBO/1F7iiCDLIwFVAJUawLTy
         Z9flEdw1fFIN/W3IWglHsUa1g6FFrzc090LLn2NXrY2ooWRuHMJtMLEEechfypjqwao/
         PdPwprGN9fKgZFCEqQ6cgTgh1m9Zl+SZibKFvVU+K9FPTGPWvpXaw99ocssFfiwhTXfP
         TUEPLGkY1sQJAwTbP4WkkZC6K2Pz+ZoP7kEF3udf5SHkLfIiSSsBo1/GX3beY+IGIaR+
         EvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320597; x=1695925397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnhBiFBKyPiQHRaYS9dfvLmsrYNmtEwUZ70lBW9wVas=;
        b=i62pPFRYTPJ1WrZQuxI4PGHSXITCfspOHdowZTFOfp0N4hgpisqeuh4XuENTpvxqVE
         OfW+RsEJON0fuBbBSDHGZL1+15z5N/SRqGb/Zju6mQKD0guQogo70pD6gxjxRTgBpTSi
         3RPqBVW6z1DwM5n4YCkrmJ8NR1c/qq4sorDZzlZ7wj66LVP8kjqRxNHvkq+zHd5rwelL
         X4u99NOkt5lp9iZl59s04g6rZAS6PtrpKUq9E4kNxRhRromdh/xhGOvdwHaGjfsIqz7e
         7zJ/OqCDaJNzM2jDFoH0jDI6MASb+Aelf+Rd6CjRShvZCBQKXKV34haw2YRHLIX690Cm
         Gy+w==
X-Gm-Message-State: AOJu0Yzk170Rg36aZkeqssPAB0Tb003XqO8pFylPmMHmNcFlsL6hxjEF
        taWx94J3Z16Qw/l8d/08Ut1XUO9FwrlNN8JzIofkVFtvxklUOtjwosE=
X-Google-Smtp-Source: AGHT+IFZArCnDCg0IaUGDU5EJzWdv+w4dn7a4FoKjDrxayQwXMP+yWbdPJpvIebBcd22esKd9Y9YYWiI1e6z6nvhVig=
X-Received: by 2002:aa7:c992:0:b0:52f:b00a:99be with SMTP id
 c18-20020aa7c992000000b0052fb00a99bemr4603308edt.33.1695299051958; Thu, 21
 Sep 2023 05:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112835.549467415@linuxfoundation.org>
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 21 Sep 2023 21:24:00 +0900
Message-ID: <CAKL4bV6gnu5Ufjru10sWG-3dew25WKtmtdPXQNfdrgLc0nfX_g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
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
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Wed, Sep 20, 2023 at 8:55=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.55-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.55-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
