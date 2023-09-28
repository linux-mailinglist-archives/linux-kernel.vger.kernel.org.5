Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A6C7B248F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjI1SBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1SA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:00:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88A19E;
        Thu, 28 Sep 2023 11:00:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3af3ecdf047so2137829b6e.0;
        Thu, 28 Sep 2023 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695924056; x=1696528856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf7ScwygjQ2jf4AqpxHi4jRt6wSUGgNirGCrHubekSk=;
        b=eBM+HaW+8NHFYnM+pwTN/5C53OeQIaz/kd7BkO1yO9WKSYd7/lVoQJDvbqWw/GITm6
         3U+gx1BIrEy0QUvyjtsOBUXYNm+/YBCFieoKOPzC4tAYLI4/eIitbJddf/MJIoL9tmQQ
         9B+X0pe5tMt0lzN3F10mIbM+crIkrltzQQmQezIhgkHgNqhY5Jp58veDeAgQaUcmH2sk
         a+SyqdBII4qKJ+0myg/nKOtPAFfge4tqrBKgj86lGa86oBiymGqts1ZIFAbf5MhloC6Q
         aclFOpft12afSJxy0Wm+ON1z+mlfyTVPBSPv5YfTd7S9UkvsEhkAIZQR/9C+YgwTpWzy
         IFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695924056; x=1696528856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jf7ScwygjQ2jf4AqpxHi4jRt6wSUGgNirGCrHubekSk=;
        b=i0Dlf51qUoofPTp5QE8CVAqO8PqSPjQQ9+Evw39yHY53U0nlGmJVHtGMxbffMaGDfU
         nJM4xGaM8NjACqoHr5Y/VJocnqDUHIbrgdwJZzmPAMbZ/7UgDqQsRBOTWFdzuwrAjfRQ
         eQ5F623H49ct/lZThvQftkZu+Wkccrmq0WNhyMKzzbkMd15cDKWmtTXHiId1JJVxkilz
         Nv50oFclfPCNjeOjuzoxW8nv9na7ldFLHd4ZWMOAqZXKiuqVuYtgo0LynUh4Tk7zrRcO
         5KRJ8nTWUWwUKg78SEi7kwq10DG4e2DfkIWufjILMbyAevrsd4dS9Vd3Gfgl3Q0T7KAf
         /zQQ==
X-Gm-Message-State: AOJu0Yz7VudPeZyuXfkSBiOMDM124/oSPMvWDkU691akWDrDmAOwQS2i
        oV3glp+o7z/zH9D6dYs5iZBrXxCIaZORfph0cuU=
X-Google-Smtp-Source: AGHT+IGKXt0xSHlAm601LvV0qT4645pgVZtZMWe+PMCSak1LUkBPD86q1BCqTMAlzzAuU4scAQtW/iNbQ4E95L/JjDg=
X-Received: by 2002:a05:6808:b28:b0:3a4:225d:82c0 with SMTP id
 t8-20020a0568080b2800b003a4225d82c0mr1924328oij.31.1695924056416; Thu, 28 Sep
 2023 11:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230926225955.386553-1-mario.limonciello@amd.com>
In-Reply-To: <20230926225955.386553-1-mario.limonciello@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 28 Sep 2023 14:00:45 -0400
Message-ID: <CADnq5_NHQhUZ9DzNtOy67Hx1g2_ZeBfKPC6O22YY_bzSJsMiUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix Navi3x boot and hotplug problems
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>, Jun.ma2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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

On Thu, Sep 28, 2023 at 12:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some OEM systems multiple navi3x dGPUS are triggering RAS errors
> and BACO errors.
>
> These errors come from elements of the OEM system that weren't part of
> original test environment.  This series addresses those problems.
>
> NOTE: Although this series touches two subsystems, I would prefer to
> take this all through DRM because there is a workaround in linux-next
> that I would like to be reverted at the same time as picking up the first
> two patches.

FWIW, the workaround is not in linux-next yet.  At the time I thought
it was already fixed by the fixes in ucsi and power supply when we
first encountered this.

Alex

>
> Mario Limonciello (3):
>   drm/amd: Fix detection of _PR3 on the PCIe root port
>   power: supply: Don't count 'unknown' scope power supplies
>   Revert "drm/amd/pm: workaround for the wrong ac power detection on smu
>     13.0.0"
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>  drivers/power/supply/power_supply_core.c             | 2 +-
>  4 files changed, 5 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>
