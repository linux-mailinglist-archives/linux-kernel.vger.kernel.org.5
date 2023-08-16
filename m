Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A0B77EAF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbjHPUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbjHPUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:45:32 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8656272B;
        Wed, 16 Aug 2023 13:45:22 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c4de3b9069so2619546fac.0;
        Wed, 16 Aug 2023 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692218722; x=1692823522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OihNe3gAgU6UaDLOV7CSqhDoAHBlHKm5j7T3xEbUV6s=;
        b=K+HcDrh8Zl6lrpqgGYojLDY5ENTzSiSDV4uTNAsv8EwIgpmN6Q0eOP1XVV5+LIYx2d
         MS6zcDKseKnHi/YL2D02PCkP6m0ZYyNJdZ8MLitntotxCR8HL8djdSz+X00tGaq16Lk5
         MuXDYPzi3+sk1WKv3Hsv30Y32LWKu5lrCvBnPbNU63jJhamXVRkpAkvGzHsGJ+fZvOUB
         nup7cfzGEaSGI1bP0fPjVT5QIkiUlS17BUpkDIQ2idyMquFc0KZodkBBsTjyMae5RB9G
         l27n+auedAWF0EIu3ee11cDww8M9HM/5ajRHFSBqUFyuQSclhZ6URTRJRvu1FVkkqVLv
         mg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218722; x=1692823522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OihNe3gAgU6UaDLOV7CSqhDoAHBlHKm5j7T3xEbUV6s=;
        b=d3KX+Ff5p6OlVrvVTZhJQvIwnKDDuLBGkZ1GKZAcI8AlbBqDAq0DMHI4FDQcBx9W7+
         Rk7vZasF0AaAMsupCq2nqE9U/bfLv8i14P1Dz4dWA/My0PyKVNRf/6KAW2y473m3yrzj
         53iUbqHTmlpFUIpe2wQJ8zMzz6ZddqkZrdF2uNaOGyGjv7s4yQ2jnQluT+Fq/fFS/KZr
         XUXGI47t9uZAHkiJGsXb/7PQTzG+O8/Ta8s1DyLki4yYPD+unfQ8lb6rYU55cwTJV6K6
         ZyuyxbBHCO0OstLDyRKdtX14K0xCTCgu7NPuQz07z8KGhCclwVXWzswyQfHNCkaKhuRI
         zNgA==
X-Gm-Message-State: AOJu0YxcvY5fR6qvyby6ICxrWZAZpKRCGghv8bHeuBqDrwzE5WPi091h
        kDkULpjvjpICIemZ6gX4pY9IHPIRMuBCrKH+FL4=
X-Google-Smtp-Source: AGHT+IE5oWZGqIAb9KvivOHM7W0tX/0iOjenVA4a8orIMRD+KMKqP8KP4lxIC6MzwUHWlI4B6j+Y7D0ipQWZubHuTmY=
X-Received: by 2002:a05:6870:c148:b0:19f:2257:6865 with SMTP id
 g8-20020a056870c14800b0019f22576865mr3668346oad.31.1692218721942; Wed, 16 Aug
 2023 13:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230815210747.6c409362@canb.auug.org.au>
In-Reply-To: <20230815210747.6c409362@canb.auug.org.au>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 16 Aug 2023 16:45:11 -0400
Message-ID: <CADnq5_ORv_8Qxj8VfbR-i-EhwpyqzHi7one2ApM7mR2qY5BPMQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 7:07=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced this warning:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'product_name' not=
 found
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'product_name' not=
 found
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1: warning: 'serial_number' no=
t found
>
> Introduced by commit
>
>   7957ec80ef97 ("drm/amdgpu: Add FRU sysfs nodes only if needed")

Fixed in:
https://patchwork.freedesktop.org/patch/552866/

Alex

>
> --
> Cheers,
> Stephen Rothwell
