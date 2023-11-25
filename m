Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79227F8F72
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjKYVZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjKYVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:25:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32411F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:26:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfb30ce241so6737895ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1700947560; x=1701552360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZRuUkwAJQSc2B5TiukCCmiozHQbQ8NLMPMFjeYqUcY=;
        b=B0chO/CMMktE/R4qRpcm5Ybi+O2ryhoXTE/0MfvIR+Cu6kZ7aNiaZxejtoZ6hBEslC
         wo8cR61QbSThxOwSDPuwaCN7Ctzw7pYdbmMBs7TGET0woU3yl9OX5BAT3zOxj7gCEMTw
         rgX9e3WdWuq7KXR7Hzq/PFm5uUdTomYrLPLfPgEMZosxUevj+3874/QNhFhefGjZMZjV
         qo6Mv8I4ySVfM/gRFMb/ErXpTN+4Ev7al2OWVF8SozHcxogltG1eHDnMSYYt+DYayISt
         636YjjUh16gDps1kFYEjyu1xi80qscTb9I/KRcfyfp1UZCl++yJHRBJcXaZRvhHW9b5X
         cA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700947560; x=1701552360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZRuUkwAJQSc2B5TiukCCmiozHQbQ8NLMPMFjeYqUcY=;
        b=SdPTBXgUIgB51pwOi8cAfIBAhIMSN8pFEeldffBGumbZsyEBthFG0GvnYazsA5MGdF
         zxKhebSOQPfUbaQVnm7ph7xfkwIV2qUTo8DZ0jbsdyBkkGJ8t4woRD899ToZnq2e5bIN
         z8zi74FyGO3BQ79Kvi1sY5t7OnaagtDgZAlnWR/ZLVjZUcNRsc+hYYVpyuI+YLnU+47O
         jdKTj5q1oHpXMnz68fBOEMqBxbrKACP6TeasKWf9viHDoeNg7i5QU1dpmaKJrvSlXu4H
         QuJG9GR7AEQCEqgOeN4UxOk2FXQmjZCsRTL/ZR0LhXe3FLWyPcQ2Bv4NGMsDA1C6qASa
         XVZg==
X-Gm-Message-State: AOJu0YyC3bxNzB/LkC2ZH90jzdaWhoz4gbMBS9P59hF4+IlZqGH4kQvP
        ngCu7lMtbdevLmn/yMurR4W2zTxCfArl7U98e6VSJQ==
X-Google-Smtp-Source: AGHT+IGTUTKj+kSrY+r7f26g2zZ+p3i6caFNXxcPK1JnynJ+975K68HCL04h7m1UuQQ7vEmVaqfUL4Z+n9UO7j24ESQ=
X-Received: by 2002:a17:902:ea10:b0:1ca:29f:4b06 with SMTP id
 s16-20020a170902ea1000b001ca029f4b06mr10068270plg.2.1700947560518; Sat, 25
 Nov 2023 13:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20231125194417.090791215@linuxfoundation.org>
In-Reply-To: <20231125194417.090791215@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sun, 26 Nov 2023 06:25:49 +0900
Message-ID: <CAKL4bV4DwJ49GLjiP2qE1dhiWtuLn2ybTWju+QFNwQfUckTr9w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/527] 6.6.3-rc3 review
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

On Sun, Nov 26, 2023 at 4:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 527 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.3-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
