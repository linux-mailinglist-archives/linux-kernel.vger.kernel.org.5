Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5E17D585D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbjJXQam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjJXQak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:30:40 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4BCD7D;
        Tue, 24 Oct 2023 09:30:38 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b5fe8ab5f9so1855509241.3;
        Tue, 24 Oct 2023 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165037; x=1698769837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJF74bOpCl2cyMohFOvvVhQktn04W/je5xIM2cEgZBk=;
        b=amZYhZBHhcFqzSmk4+++NwMo0hLTtY4imziZ6ZkuwHnkJy41ZySxQm7V1F8KKMis+s
         cZ55ION3NtabQJrSUJ9NEtl84wZnuhagAlHHnnF6MXmg1VfjEn/efq0sZPKO8+2OO1Bl
         Zf+RBebBpQFVDo7rsxNZvQkg8R1ZB7HB6wktG1dgdrngxNXM2dMKszS2xUdyZHKsPIKL
         wwrNjrAMXHGVy3rjN8VSDdGgi7qYi/AlE8/E6zAX8rAtdiGGhu1L5XWqiUbeVfIQZc1B
         lIYmmWfzfDMlXwCJGsVjurUXWk5DaGW5TGCHQsubZtKcUYf7D55rzw3HDpLnp/QwXn/x
         CWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165037; x=1698769837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJF74bOpCl2cyMohFOvvVhQktn04W/je5xIM2cEgZBk=;
        b=pQCrjbiz9XpDl49c5bVqXuGpvGJFqcechH/s/6aQX0kyI8vpu26gz/jMnA0MBCtk6r
         hIvJ7eIFQCctRY6mrt+GFO9BH9v+ln/i73FSNVi+JfXsXs/1zeTv8a06KdLcPLpKh+uE
         Iwe9fcDnlnDvGdU4tMpHv2dNy/1b+lw3f/VDszlEh0moswLN+dXKX7ALDSWvdmCLQqV1
         nMT6pCLn0w1lr7QkHdboPuj6DU8vf5dMW4de5fncig6IhDW7jBO9fDc7XqBR7oBp3dlG
         zlKTlpW8umRhf9Qu5oktaW/VhiP8nZYBi/C9fEoS2kBlxhMwg71vH6U06/Ks1fAYqiea
         ebOw==
X-Gm-Message-State: AOJu0YwsERdH3+CqOwzuZgfEsHd5fFTAY1gKpouKj4Br14CZpvItVk5s
        vRhOYoKsA6/Ij5ZmQ30PgmRhhtn+a9rsmPjD14k=
X-Google-Smtp-Source: AGHT+IHryv0bir0iGIZf1J3sjDMzAN8oqoi2adxMT795NJqXtK6EhKj2ChbM+Z9QzPZPaFLaQLQqwT/Kf9GUuKo5qz8=
X-Received: by 2002:a05:6122:3c56:b0:4a4:d34:421b with SMTP id
 fv22-20020a0561223c5600b004a40d34421bmr13700168vkb.7.1698165037356; Tue, 24
 Oct 2023 09:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231024083326.219645073@linuxfoundation.org>
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
From:   Slade Watkins <sladewatkinslists@gmail.com>
Date:   Tue, 24 Oct 2023 12:30:26 -0400
Message-ID: <CANV5eWDgnrWsmAuJ5mC18PUCacTHqCTSs8pxaqXozg3SeLWEdg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
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
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.199-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.

Hey Greg,
Tested on my x86_64 test server -- built and ran 5.10.199-rc2 with no
errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade
