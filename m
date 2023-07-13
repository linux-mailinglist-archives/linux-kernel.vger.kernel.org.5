Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5C752218
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjGMNDK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjGMNDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:03:02 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA11734;
        Thu, 13 Jul 2023 06:03:01 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-98e1fc9d130so21648866b.0;
        Thu, 13 Jul 2023 06:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253380; x=1691845380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+QGNhyP5nUUkdoa2Q3ypYW8B85kMOs/GN5/k9obJ4w=;
        b=hxznlX6i6a7eP5IRrw28+/nsPCH09GHzg5C6AyhVIc5GxmxhuD36QbQhhla2CkHNPY
         HSVBcRdN9InrO70glIurDSUcTgXdpSQwWjslCQmdgphpmd0gm2TPnweReu4Gg3pOSiwT
         9RRF053M1jqZirXskL+AcDj+zpfMBD3TQvSCRjGny6D7GTE3pQDoQZhyn7wU4CvJ/fzM
         MohEHB1aFVihV0jlpaKzGvd0QcbzMsNRwqmtD/Pr43uzJE68fZVWLVlxde4pJ0iU51BL
         APQdN/Z6YUI5yg1IuFgJ5B69sHzP+Az0m6bHcLoqNiaZZv3xSiWJ8dhaAM5QyNUmfyYu
         Khkg==
X-Gm-Message-State: ABy/qLaYMmLjfHPtepVuanfT+/ZpblvBzCBbBmlYx/PsGEV0Q2GjOX+c
        tXxGO22+xjP7htwjg/lba4+ShmgudnShnoPnGEDJBN14
X-Google-Smtp-Source: APBJJlFbSizNulC3QLXI1zrCwJgYGHJAQDZ2r/JIeFkDWT9aEhi0LxMp6j04AaZ7cIxg7Z90XS28DVilzUKVcOVsaMg=
X-Received: by 2002:a17:906:77cd:b0:994:33b2:c32d with SMTP id
 m13-20020a17090677cd00b0099433b2c32dmr1261182ejn.5.1689253379483; Thu, 13 Jul
 2023 06:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230707203731.848188-1-daniel.lezcano@linaro.org>
 <82b2d4dc-4583-925a-9e3c-77ae30d0d261@linaro.org> <CAJZ5v0iUyPjsyfcE6MB1gqeRvb8aM0d6TsrB1Oehw4p58SnFYQ@mail.gmail.com>
 <032bda42-ba99-c207-c30d-a5f69bd10095@linaro.org>
In-Reply-To: <032bda42-ba99-c207-c30d-a5f69bd10095@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jul 2023 15:02:48 +0200
Message-ID: <CAJZ5v0hvbKhqYu6epmr+vQ9xMe0CR3KWESjBRBGzaVxzwCLG3w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] One more step to the thermal zone structure encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 2:24 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/07/2023 13:30, Rafael J. Wysocki wrote:
> > On Thu, Jul 13, 2023 at 11:33 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 07/07/2023 22:37, Daniel Lezcano wrote:
> >>> The series provides more changes to self-encapsulate the thermal zone device
> >>> structure in order to protect wild accesses to the thermal zone device
> >>> internals, especially the trip points and the locks.
> >>>
> >>> The first patch adds a macro to warn at compilation time if the
> >>> thermal_core.h is included in a file not belonging to the thermal core
> >>> code. One warning will happen with the nvidia drivers but this is in
> >>> the way to be solved.
> >>>
> >>> The second patch reorders the headers inclusion in the core code.
> >>>
> >>> The next patches makes the int340x drivers to use the thermal trip
> >>> update above and the different accessors for thermal zone structure.
> >>>
> >>> Daniel Lezcano (4):
> >>>     thermal/core: Hardening the self-encapsulation
> >>>     thermal/core: Reorder the headers inclusion
> >>>     thermal/drivers/int3400: Use thermal zone device wrappers
> >>>     thermal/drivers/int340x: Do not check the thermal zone state
> >>>
> >>>    drivers/thermal/gov_bang_bang.c               |  1 +
> >>>    drivers/thermal/gov_fair_share.c              |  1 +
> >>>    drivers/thermal/gov_power_allocator.c         |  7 +--
> >>>    drivers/thermal/gov_step_wise.c               |  1 +
> >>>    drivers/thermal/gov_user_space.c              |  1 +
> >>>    .../intel/int340x_thermal/int3400_thermal.c   | 44 +++++++++----------
> >>>    drivers/thermal/thermal_acpi.c                |  1 +
> >>>    drivers/thermal/thermal_core.c                |  7 +--
> >>>    drivers/thermal/thermal_core.h                |  4 ++
> >>>    drivers/thermal/thermal_helpers.c             |  1 +
> >>>    drivers/thermal/thermal_hwmon.c               |  1 +
> >>>    drivers/thermal/thermal_netlink.c             |  1 +
> >>>    drivers/thermal/thermal_of.c                  |  1 +
> >>>    drivers/thermal/thermal_sysfs.c               |  1 +
> >>>    drivers/thermal/thermal_trip.c                |  1 +
> >>>    15 files changed, 45 insertions(+), 28 deletions(-)
> >>
> >> Applied
>
> Sorry, I did not think you may wanted pull them in.
>
> I can drop them from the tree if you prefer?

Let me apply them directly.
