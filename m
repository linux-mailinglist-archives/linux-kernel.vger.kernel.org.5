Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7757D783666
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjHUXgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjHUXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:36:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A281B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:35:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso61115731fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1692660936; x=1693265736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mx9AKTmHyiYkR+pZw1dj3ToXvjTZEUPg3otq/0WD5no=;
        b=2AGnNtqff+ZWmokpQeEa7ADE1+8GuF6+rZiOq5kY6DxPXWWOmIHBSiYOQlSaffyTR1
         RJoEh3DBFSlH+EyzJpFjX8mG01ogvODDFUhh76/2ahZfypnXvyHSD+NDscb0Va6ns81d
         +B1Tc75s6MGilPnKSA/h5CzH8DMDJKvgaQI7AppyUfaDMYm2vKVsJuemuWvwETDTt8L0
         v4FuKtYhjZDTfNhYTSd8Ik8PhUH3V4HM26BdXQtk5T1bkC7atHS9vf7G8rkb/svoPWEz
         RxWhsYbzHF3XdlWMk7BddnJXxg5u6GkbOmSZW2ajVwvw4n0aTW9bLCOpBawa8xRsYwVz
         KWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692660936; x=1693265736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx9AKTmHyiYkR+pZw1dj3ToXvjTZEUPg3otq/0WD5no=;
        b=TKC+0ItMBiQjVfsaAXMy4y9Z3QAeXfjfoysqlnxkOe0MWpx+SbQ9/Mv6zo/dnstdF6
         GaQa33Xba+AtmWW97WaRuHIwcLoKI+qdJlcTsKFHiHkHvxnbqDFTnk8cl4XnWIMA4B9f
         rT8E6b3Nth4RBtOUv9nSKi4S0NAglRczpOQv/QMpUTuhJ1VzzTqN41SvrfsWyqOQqj0I
         kf7u6ObzcZnlLB3wRYcDIHNRSwZwUucNTcqufK3yCxfkTpv8cJGWvmU+ZJXkaVzrzWFo
         ga+jAXx4xiGZoyN/8Faex4d5xxxXucr/m+7kgxL7+Y+PUShC9zx4ZHU911qEWN0+7+7O
         mGKg==
X-Gm-Message-State: AOJu0YxN20MDQ+NewHeHFjsH3ssVb4RFvs4k4hu6JXfCMSVQFxP2pzse
        LOazgKOZsAqcVbwSsi9521vGDwRJCappYklzRTd2KQ==
X-Google-Smtp-Source: AGHT+IFuIpIP+zU9e2puhTm4zRVQTuLSgihXGhhi96HB1MdcB4cr8OyUgqRu+u2wHys26zZcoU3w01BbxCAl03mbruA=
X-Received: by 2002:a2e:8295:0:b0:2b9:f2e8:363 with SMTP id
 y21-20020a2e8295000000b002b9f2e80363mr5611062ljg.51.1692660935632; Mon, 21
 Aug 2023 16:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194122.695845670@linuxfoundation.org>
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 22 Aug 2023 08:35:24 +0900
Message-ID: <CAKL4bV45LpjnrXyNFW=Rgu5R6UmmV1N6B0qM0LfKh5d=FNJeTg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
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

On Tue, Aug 22, 2023 at 4:51=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.47-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.47-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
