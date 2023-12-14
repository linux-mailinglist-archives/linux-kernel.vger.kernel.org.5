Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30A68139EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444234AbjLNSZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjLNSZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:25:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DCB116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:25:15 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so323070266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578314; x=1703183114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWNO9gKTX+H6PtTXgZaijRLRW5/UDeehQa2JwBF5FxI=;
        b=lDWbY1+LsiHa8msQ8uyffT+yPNELyys3+carw10urSvpn9y+z0PHVswVw3cf0M+ZCH
         XuAXQvluxlgeGFEeJ5Y1J42zoxJfKa8UfJfrDWSEJ3s/qqTxaN0FS2t7oQe94BWFBUx1
         2KbTZqZGvWIpRoiRJf0+kxCRh1kVRIxGRdtcwr/ibtUU/ngZJNHj2l4MkUpzqK5C+3Lk
         1sfZ5OefjNUpEigLaA8n8Uh2YcYXYq8J7/gJBCrGbSn03fj0vFTjEVQK6tMMHwaoBD3Q
         AjOFdvEpgQT2Si+a6boOMUYrHo8FR/KqZWxsa0zZRCkNaz+f4HLeOi+jpTzmu7CeVet/
         zf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578314; x=1703183114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWNO9gKTX+H6PtTXgZaijRLRW5/UDeehQa2JwBF5FxI=;
        b=xHWqDriDMCqBv+sPMzzSuai1Xwi0QI7dvad4mNnSLh07O61ICW/o4p4gkrOfj47g35
         g5YTtzyEgIF3Vv6D1Kczp+y78344sozcko4yQ2UrpOlXlJmuyqyYI80QE+K29jq4Xmln
         2V1LZBq5X09L8kGp1lO5yu6OSQvfAa7gsiXOVi37CItuMIiEZYsTUqHb+20jDhmZwW9Y
         Er5JxrGlgeracxzAdjEP7kj+axI8PRPwUUBf9a1UKO+KYvBDKOtsh+O831FDF4RpSrx8
         HPmKlKkrJVdRciNHj9mLFsENqDswPmJjh7GqOFMl4OMHE1oRJndnb7ZK6Xye9UgIlGaS
         JJXA==
X-Gm-Message-State: AOJu0YyXIwXFBDiUtNBT032d1NsAi8kO48qC6Q+sMfekSXUFnINSdsqr
        bejKSI3EJ7b71wH8Gkjjdg74JQR+15BEMobmU6Jd6A==
X-Google-Smtp-Source: AGHT+IF5aVTry2FC8fPpvHagersJX+u6ON5srtl/dhTppR5fbUmyPtKjz52t7C4jg+PxzIo0GY0Gp29Ro3eP/IqhN4k=
X-Received: by 2002:a17:906:53d9:b0:a1d:2205:a484 with SMTP id
 p25-20020a17090653d900b00a1d2205a484mr2669130ejo.113.1702578314287; Thu, 14
 Dec 2023 10:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com> <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
 <8f80fe3e-a8c7-463d-896b-99575c362839@bytedance.com> <CAJD7tkbS_3eEDbfo-w1Z+tuY44YKMYnAqaL0684Y6nh2EmHq+Q@mail.gmail.com>
 <dc84f965-9174-4ce7-aedf-f68d8e8003b4@bytedance.com>
In-Reply-To: <dc84f965-9174-4ce7-aedf-f68d8e8003b4@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 10:24:36 -0800
Message-ID: <CAJD7tkYdisUg+wphANLFcBSLB13jH+NxqFdc-EjKBq0H-=S00Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 6:42=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
[..]
> >>>> -
> >>>>         /* decompress */
> >>>> -       dlen =3D PAGE_SIZE;
> >>>> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >>>> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >>>> +       mutex_lock(acomp_ctx->mutex);
> >>>>
> >>>> +       zpool =3D zswap_find_zpool(entry);
> >>>> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >>>>         if (!zpool_can_sleep_mapped(zpool)) {
> >>>> -               memcpy(tmp, src, entry->length);
> >>>> -               src =3D tmp;
> >>>> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> >>>> +               src =3D acomp_ctx->dstmem;
> >>>
> >>> I don't like that we are now using acomp_ctx->dstmem and
> >>> acomp_ctx->mutex now for purposes other than what the naming suggests=
.
> >>
> >> The "mutex" name is coherent, "dstmem" depends on how we use IMHO.
> >> Change to just "mem"? Or do you have a better name to replace?
> >>
> >>>
> >>> How about removing these two fields from acomp_ctx, and directly usin=
g
> >>> zswap_dstmem and zswap_mutex in both the load and store paths, rename
> >>> them, and add proper comments above their definitions that they are
> >>> for generic percpu buffering on the load and store paths?
> >>
> >> Yes, they are percpu memory and lock, but they are used by per acomp_c=
tx,
> >> and the cpu maybe changing in the middle, so maybe better to keep them=
.
> >
> > I don't mean to remove completely. Keep them as (for example)
> > zswap_mem and zswap_mutex global percpu variables, and not have
> > pointers in acomp_ctx to them. Instead of using acomp_ctx->dstmem
> > today, we directly use the global zswap_mem (same for the mutex).
> >
> > This makes it clear that the buffers are not owned or exclusively used
> > by the acomp_ctx. WDYT?
>
> Does this look good to you?
>
> ```
> int cpu =3D raw_smp_processor_id();
>
> mutex =3D per_cpu(zswap_mutex, cpu);
> mutex_lock(mutex);
>
> dstmem =3D per_cpu(zswap_dstmem, cpu);

Renaming to zswap_buffer or zswap_mem would be better I think, but
yeah what I had in mind is having zswap_mutex and
zswap_[dstmem/mem/buffer] be generic percpu buffers that are used by
store and load paths for different purposes, not directly linked to
acomp_ctx.

> acomp_ctx =3D per_cpu_ptr(pool->acomp_ctx, cpu);
>
> /* compress or decompress */
> ```
>
> Another way I just think of is to make acomp_ctx own its lock and buffer,
> and we could delete these percpu zswap_mutex and zswap_dstmem instead.

You mean have two separate set of percpu buffers for zswap load &
stores paths? This is probably unnecessary.
