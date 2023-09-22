Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD027AB461
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjIVPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjIVPAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:00:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBCA1A6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:00:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77acb04309dso85744839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695394842; x=1695999642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYn6LvwErM+FWcs1ijUw0l4OdU4J9KJ6IGyuBDg5TUM=;
        b=nvLbHRZ6HX0KEiCK6ljjoii4i8lRgR2XWob3X20fw9qoVQ26w1w8wXl8mQyKsxjhYm
         ZIyhTtiVG+nkTILeUFZYteVbJ4CSUNjzh4HQdZ//MaUTXrBVuHGg6onE5kpwN5DIx7ix
         RmCBLILoMoyLFbym5jRagLB0Ad4Zo7WNrUGXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394842; x=1695999642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYn6LvwErM+FWcs1ijUw0l4OdU4J9KJ6IGyuBDg5TUM=;
        b=Q7pCWqFWi4V7byymS5H/1fBaIBNP66arolN4Zs62P8Fmi+NxlRZ4/QtkKnb/maz68X
         jKbYVRuDG4hQnoXa2JVk2PjFqX2oMT6yZA98ytbFJqkyTOimxkwx9YcCGILOduxxWHJC
         9gABG0SsbSClsl457QoyZ3z9ptbPego6cSBg54HcweWBnouK6sCfAmozrknYPhIZJLSI
         prMOHzD5Zxbm3cQs0FhXj9nI8fI2yDjIxxyIupSW6lD4exZaY7oorbR/onDXk4Sjg4RM
         MOHYdxYS2nQfglS0DiqooOK3GU4/Nr+8KbIY81art62248rz7kNczyDmBrsBqLWoDhix
         ieLA==
X-Gm-Message-State: AOJu0YzrYUTKMl02gShYQo78Aogr84sWIgZ6/A2zwoNzBqpj5i64mCkt
        JRs3pE3IC4HVx9gAj8xROYPv/YcrXf7UF3nSdKaMOQ==
X-Google-Smtp-Source: AGHT+IFbEGFXJmNzYcTCklkiBTGe0RHiphpx+QFahlodchm827xZVeRdpbGcmTnbPC8j2gcUb6dS/KP3T2t9n71A9EY=
X-Received: by 2002:a6b:e419:0:b0:799:178c:7be5 with SMTP id
 u25-20020a6be419000000b00799178c7be5mr9412049iog.17.1695394842589; Fri, 22
 Sep 2023 08:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230920112835.549467415@linuxfoundation.org> <79a96d41-1b79-51b4-fda0-743b853213b9@nvidia.com>
 <7e0355bd-64cd-f6c2-b720-e4643579078c@nvidia.com> <53c9f81e-55b9-b8bb-7821-cb124780d4c0@roeck-us.net>
In-Reply-To: <53c9f81e-55b9-b8bb-7821-cb124780d4c0@roeck-us.net>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 22 Sep 2023 08:00:31 -0700
Message-ID: <CAJs_Fx6-AWA1fxgV1u=ycn2YXm3D0GnGQeC1UR8QwVXFKDGJqw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 7:52=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On 9/22/23 05:31, Jon Hunter wrote:
> >
> > On 22/09/2023 10:45, Jon Hunter wrote:
> >> Hi Greg,
> >>
> >> On 20/09/2023 12:28, Greg Kroah-Hartman wrote:
> >>> This is the start of the stable review cycle for the 6.1.55 release.
> >>> There are 139 patches in this series, all will be posted as a respons=
e
> >>> to this one.  If anyone has any issues with these being applied, plea=
se
> >>> let me know.
> >>>
> >>> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> >>> Anything received after that time might be too late.
> >>>
> >>> The whole patch series can be found in one patch at:
> >>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.55-rc1.gz
> >>> or in the git tree and branch at:
> >>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> >>> and the diffstat can be found below.
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >>
> >> I am seeing some suspend failures with this update ...
> >>
> >> Test results for stable-v6.1:
> >>      11 builds:    11 pass, 0 fail
> >>      28 boots:    28 pass, 0 fail
> >>      130 tests:    124 pass, 6 fail
> >>
> >> Linux version:    6.1.55-rc1-gd5ace918366e
> >> Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
> >>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
> >>                  tegra20-ventana, tegra210-p2371-2180,
> >>                  tegra210-p3450-0000, tegra30-cardhu-a04
> >>
> >> Test failures:    tegra124-jetson-tk1: pm-system-suspend.sh
> >>                  tegra186-p2771-0000: pm-system-suspend.sh
> >>                  tegra20-ventana: pm-system-suspend.sh
> >>                  tegra30-cardhu-a04: pm-system-suspend.sh
> >>
> >> Bisect is underway.
> >
> >
> > Bisect for this issue is also pointing to ...
> >
> > Rob Clark <robdclark@chromium.org>
> >       interconnect: Fix locking for runpm vs reclaim
> >
> > Looks like all the Tegra issues are related to this.
> >
>
> This isn't surprising because upstream commit 136191703038 ("interconnect=
: Teach
> lockdep about icc_bw_lock order") silently fixes it without Fixes: tag. I=
f you
> look into that patch you'll see that the the missing call to mutex_unlock=
() is
> added to icc_sync_state().

Oh, indeed, it looks like that hunk ended up in the wrong commit, and
I didn't notice because both were merged at the same time

BR,
-R

> Guenter
>
