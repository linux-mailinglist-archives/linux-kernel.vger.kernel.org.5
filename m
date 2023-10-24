Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206F07D5848
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjJXQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343947AbjJXQ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:29:09 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F8593;
        Tue, 24 Oct 2023 09:29:07 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b64810aebdso1461190241.2;
        Tue, 24 Oct 2023 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698164947; x=1698769747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CpseSac6ZLEUS8u4CyYubu6VEvSZHplqay1pUkSTtM=;
        b=N0oq02SLKcsUZmwuVAlJseU6Ww/jAEVOSd50+AGOf1TzrOaNiuNMhCL+dJ293UGWoK
         0NdVujhn7c4CTUR/ph+Poo+W24zGvYeqrTvVWrqI80Sl6MDpjHvfXArPhtiZ+nB60zl1
         GKkgBp5SqLbb4jrO8XTgMvzBNaZfMACCxYBprr8rNkqOT0x2ENZpTTBdUjMACtZg+DOg
         7QYZJ+earr1pD6edx+vJrZ+p738ritntUX+sHa7IN42nRV2jogqP3FmrhpafXvNK5zqG
         UZkHXgUStqma9MvWV0cM02PXwNQBp+gHL5FlVewlqcbbx5rZ1wST4LSYcsess6CjIWb1
         8pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698164947; x=1698769747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CpseSac6ZLEUS8u4CyYubu6VEvSZHplqay1pUkSTtM=;
        b=wT3KjwY0HZ38FmQDpU6v6oj9MKXnhaRFydvhsXY8eY1c248TUkECA+cj7/TBPQK2We
         sGKYpGm7nKGpTkk2l4AiGZTb9AO7gpsjp7ULBmGSEbM4qiqC9aBoBZRc045zYbwE4XnA
         ld32UD2v9Xccm6LdYfmI0rtRJKqXVNlW1BKhMUSp0nC/efeP5+zT+PesIKg058JdD4X7
         wNNUMUN9FXEl4SFlbAzj/5ZnK9OEiV/2ndwYLudwq5y7BC6krzF27Rw806DJ6oVxMNqB
         R+wq1l9axESSDHaxI07MwcJWD2yTeB2ECywX7P4D3smA9hykYoVmPPfZrVUaewqnqOBk
         DiUw==
X-Gm-Message-State: AOJu0YxjRWTTuRyz1mRDrpyvJDVBo0SL9+ZcMZ0zMOm0iV4uwNCjg1U0
        HwakAcAni7CtVawpvF+gmcG+JRzU3bt6aCNRisY=
X-Google-Smtp-Source: AGHT+IH0SaQWucEcdlzDh6PsUBpAyAUFv/YWuCFINZEJ/h3rMmpMOrQX2ikJhofAdRRbinEG6wa/VQDcBugcL8JJd9o=
X-Received: by 2002:a05:6102:4754:b0:45a:b396:a44 with SMTP id
 ej20-20020a056102475400b0045ab3960a44mr1784185vsb.25.1698164946726; Tue, 24
 Oct 2023 09:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231024083306.700855687@linuxfoundation.org>
In-Reply-To: <20231024083306.700855687@linuxfoundation.org>
From:   Slade Watkins <sladewatkinslists@gmail.com>
Date:   Tue, 24 Oct 2023 12:28:55 -0400
Message-ID: <CANV5eWBr-TLCQ-hWwqgi4MH8RWNuUjAmpAXMK3ujAubHx-CnQw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/120] 5.4.259-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 4:37=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Oct 2023 08:32:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.259-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.

Hey Greg,
Tested on my x86_64 test server -- built and ran 5.4.259-rc2 with no
errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade
