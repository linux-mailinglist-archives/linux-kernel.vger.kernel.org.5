Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022C7A52C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjIRTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:12:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140E10E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:12:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31fe3426a61so3983770f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695064364; x=1695669164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/tyJ7h5gd84THXUpDn3bC5d/vZANrGk+ne6Pb/iGd0=;
        b=cAuW4GUWcHd4x7mW7b7KNA+O20crcWOgQgMHQtrm2jASiX8U9HeU/OFQN3KNMYc405
         QBVf6oqwtYtepqnHGAIYuiW70JBc8PyN4qPar1pOYW1xE5QwUmnL1B7J7P+gQg6kNSJu
         MKy7inTs5K2YKVh/pFgNxH5UjUDgQ93OpZPYkc2CcUPINdvxVIIFlfslp1AeyITbvzmo
         iEy4oh339UKrUKU+4sOYqo/3sM5AoqxfkG1r3YtJ56Xl5fFsykFAPg6wFwBQ040cXA7W
         Blm40HN8zXwuNSdWCGXHWYt+PtuKvnApmlHRLBNAzHpWAuFJKz01uV4woRkYdSPojQCB
         E1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064364; x=1695669164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/tyJ7h5gd84THXUpDn3bC5d/vZANrGk+ne6Pb/iGd0=;
        b=aI0fHUvPflx37qGsBTt2vcB2Mm90N2sOgO77kR6cmanI55hsUCfVrncFkJgf/E+k2D
         84j+Ic9fev4kbo7gp9KgeLHs8KFm07ZIteWEurZGazpohL4YZRXBS6/3ddb/113yqZ1j
         mExtXwYMN+pvjU+9IZoOHYHMEt7IGEBoD2V14zbHCjnRcaT4QSOmSD3o1lneQWTnKlET
         Axtmn8v04nUTIlUjNqiUOCga5f6+5oBpEqiYpc2FU+S4sFEWvR8ETMZY6evuX9fNl6cL
         XLWu8hjWrMp9VL/O6UNi211AxYUL9Tbh7fjjoihwrVpkHBDyCO6IxWKPiK+FO79ICO5q
         sabw==
X-Gm-Message-State: AOJu0YxQOoZoBoqZXAGy/Tysry76qnV1Au2XLY/JrUlTShedIw5HiK4f
        l6KxKwWh+CGR+m28k4xJo811Ew9wF7EmYZJUsgOx7Q==
X-Google-Smtp-Source: AGHT+IF7Bks7+fIGeY2oO408299xAYQ7YI6fsDKsoF65p99IrKoxYRSz2PqehP0dbWsJRA52Q6600cYf+8PYROaZKOY=
X-Received: by 2002:a5d:4cc7:0:b0:319:52da:8f0b with SMTP id
 c7-20020a5d4cc7000000b0031952da8f0bmr8164345wrt.17.1695064364448; Mon, 18 Sep
 2023 12:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105845.3199656-1-liushixin2@huawei.com> <20230915105845.3199656-3-liushixin2@huawei.com>
In-Reply-To: <20230915105845.3199656-3-liushixin2@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 18 Sep 2023 12:12:06 -0700
Message-ID: <CAJD7tkY3FjA90v_h8JP3+GxDSLMGL2JpbVsQupMvNXt6-fqUkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: remove unused do_memsw_account in memcg1_stat_format
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 3:05=E2=80=AFAM Liu Shixin <liushixin2@huawei.com> =
wrote:
>
> Since commit b25806dcd3d5("mm: memcontrol: deprecate swapaccounting=3D0 m=
ode")
> do_memsw_account() is synonymous with !cgroup_subsys_on_dfl(memory_cgrp_s=
ubsys),
> It always equals true in memcg1_stat_format(). Remove the unused code.
>
> Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 78ea10c5a636..bb9a617be046 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4112,8 +4112,6 @@ static void memcg1_stat_format(struct mem_cgroup *m=
emcg, struct seq_buf *s)
>         for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>                 unsigned long nr;
>
> -               if (memcg1_stats[i] =3D=3D MEMCG_SWAP && !do_memsw_accoun=
t())
> -                       continue;
>                 nr =3D memcg_page_state_local(memcg, memcg1_stats[i]);
>                 seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
>                            nr * memcg_page_state_unit(memcg1_stats[i]));
> @@ -4136,15 +4134,12 @@ static void memcg1_stat_format(struct mem_cgroup =
*memcg, struct seq_buf *s)
>         }
>         seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
>                        (u64)memory * PAGE_SIZE);
> -       if (do_memsw_account())
> -               seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
> -                              (u64)memsw * PAGE_SIZE);
> +       seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
> +                      (u64)memsw * PAGE_SIZE);
>
>         for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>                 unsigned long nr;
>
> -               if (memcg1_stats[i] =3D=3D MEMCG_SWAP && !do_memsw_accoun=
t())
> -                       continue;
>                 nr =3D memcg_page_state(memcg, memcg1_stats[i]);
>                 seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i]=
,
>                            (u64)nr * memcg_page_state_unit(memcg1_stats[i=
]));
> --
> 2.25.1
>
