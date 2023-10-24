Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194B7D5840
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbjJXQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJXQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:27:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7B5AF;
        Tue, 24 Oct 2023 09:27:50 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457cb7f53afso1795747137.3;
        Tue, 24 Oct 2023 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698164870; x=1698769670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCnp0vx7toGOFpsAGZVfZuo4u/M910K6Gc3WGajgLbQ=;
        b=aXVA5yGonQHmld0rSqmbXsPgWJGiEZeB57iNXQXoE26XSnz5wvsEAsPhh2AApH5WcW
         q9sNXnbBM/NLmXDVfLSsvJ1ct22jun1Xf5XeI2ls5ODL8TwLL14mUpZZlquQsEA4ZGYT
         uPB1464Fc8qjt54Ofbz7/rEdL4Kpxx8k8P83tJ91DhhoHmxVNQid4MsQFxmIL6ET1KYN
         LEAfpvF+XKclFtULHnswiLJCA54ZuwRuxY9DMbqieFLaOwscfe//bUETdS3HLmsemoBH
         R+T0aZ1sJaTtKsXoZvYGh8uIdaJ4ebzD8/AlEyHbC/18KQRCHHcbomsbMeQOqxYWfzI9
         zteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698164870; x=1698769670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCnp0vx7toGOFpsAGZVfZuo4u/M910K6Gc3WGajgLbQ=;
        b=vwWipwdD7Xcxi04Dmz1aUj/vyy6lqp9ffm5bJ2jhMXOhANmKLHVfb3YgcwlTldI1wo
         /9BRwd0ARXdX2pjY9XUp1XAKVNfA+VBzJgy8KXyraQ7efbYnNSGaKlXKHYZ8ZQeTd8Uk
         3aT3KlVAt8/1E3htApvw0JwVX91kFxYs9mlTVfuu1sqwar2RJt9el4xteA90kazYGTxB
         xq1jyXQ/VXFoXh+VRhLVx5pUL//c9R5rZwgv3BR3ePjk3NokFXxIN2b6WMMqPu7JNboc
         8AHBO+TMHFlaHX9PwUDh4+emy/GTCVjWeqGNxk6dVoTtSejg9ZYsCQLoiUXhks5VuSJS
         26LA==
X-Gm-Message-State: AOJu0YwVwcXdYyYSMDfBPihzg6nHQOdH++mxoRhbywKW7J4YywBpfswt
        ZgGsLQI+6lENNImtMltJ8ZFfAClBNujcvCoBit8=
X-Google-Smtp-Source: AGHT+IEWdBOVvs0sG9Sf5N3GrRIlRSzqyBWAo7IXISVNzqsqY6qgzNmvHSqru9Pm6mBc0qNZ5QdV+Nih6OWZkSXUV9Q=
X-Received: by 2002:a05:6102:20db:b0:457:a97d:82f with SMTP id
 i27-20020a05610220db00b00457a97d082fmr11631436vsr.30.1698164869629; Tue, 24
 Oct 2023 09:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231024083327.980887231@linuxfoundation.org>
In-Reply-To: <20231024083327.980887231@linuxfoundation.org>
From:   Slade Watkins <sladewatkinslists@gmail.com>
Date:   Tue, 24 Oct 2023 12:27:38 -0400
Message-ID: <CANV5eWB5Pj-hXr3YthL=6T=-E29oR9FfHEKY0=F8ZdN5EZC6rQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/135] 5.15.137-rc2 review
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
> This is the start of the stable review cycle for the 5.15.137 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Oct 2023 08:32:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.137-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.

Hey Greg,
Tested on my x86_64 test server -- built and ran 5.15.137-rc2 with no
errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade
