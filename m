Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1653A80976A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjLHAn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjLHAnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:43:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527BD10DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:43:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03D2C4339A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701996210;
        bh=HYlD+5N1fSdWbXan4+yka11Es1jGO6Ei+XatWP7GuHM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oARRA2vCGIszR1H8XkHNX1QA0rlV1IEbVB6F79fTLj/4HheOIsWWoVhOZbG7il1A+
         rrcLQNpoT3g+/xPbDLGRatT50pm6Ncq8frjHY/o9L2CqViHrvmBjCZer0EdPeA/2iy
         xdIVULFff9kTTbPFUa2AofVidv4gxFjGcqZWcOX408h+Lzl7d45VNrvBJbMjmFGKXJ
         yeQaTkma3gKGDdiVcYX2IZNphOc3kRy37waOcvG14FuNTEikSm1Vakh0EbFW3wkKc5
         DA0uTVuhCrwRHc4KOkaX589U6CO4Rtp38sNhVdVmGlGBjOvD4PWp2nbWfDCrbecpUr
         RYpxFlw4rTOQg==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2886576cf18so1283468a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:43:30 -0800 (PST)
X-Gm-Message-State: AOJu0Yxk9tiLeaAN71QJwZehTfZhk5p6xkMnwiDstznvBFecMhpPCdMR
        npkibm6FbYCvyPnKmQ3ZdMOxTMliBRMLcCtEvKIaOQ==
X-Google-Smtp-Source: AGHT+IHWWrHsd+E2VgvhwmM/YHfzOb+CQtltYVqJZbBnV6iUx7E1V5q7nkyH26EHjK21y5ATzw4HyaLZe2pKlGNEZ10=
X-Received: by 2002:a17:90a:7c46:b0:286:6cc1:278 with SMTP id
 e6-20020a17090a7c4600b002866cc10278mr3164336pjl.67.1701996210098; Thu, 07 Dec
 2023 16:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-6-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-6-nphamcs@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 7 Dec 2023 16:43:18 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOdrXHU0RBVZwVXk25nDT__fzWrHiRwW8Jf3seLq882iA@mail.gmail.com>
Message-ID: <CAF8kJuOdrXHU0RBVZwVXk25nDT__fzWrHiRwW8Jf3seLq882iA@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] selftests: cgroup: update per-memcg zswap
 writeback selftest
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Thanks for the self test.

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> The memcg-zswap self test is updated to adjust to the behavior change
> implemented by commit 87730b165089 ("zswap: make shrinking memcg-aware"),
> where zswap performs writeback for specific memcg.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 74 ++++++++++++++-------
>  1 file changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index c99d2adaca3f..47fdaa146443 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -50,9 +50,9 @@ static int get_zswap_stored_pages(size_t *value)
>         return read_int("/sys/kernel/debug/zswap/stored_pages", value);
>  }
>
> -static int get_zswap_written_back_pages(size_t *value)
> +static int get_cg_wb_count(const char *cg)
>  {
> -       return read_int("/sys/kernel/debug/zswap/written_back_pages", val=
ue);
> +       return cg_read_key_long(cg, "memory.stat", "zswp_wb");
>  }
>
>  static long get_zswpout(const char *cgroup)
> @@ -73,6 +73,24 @@ static int allocate_bytes(const char *cgroup, void *ar=
g)
>         return 0;
>  }
>
> +static char *setup_test_group_1M(const char *root, const char *name)
> +{
> +       char *group_name =3D cg_name(root, name);
> +
> +       if (!group_name)
> +               return NULL;
> +       if (cg_create(group_name))
> +               goto fail;
> +       if (cg_write(group_name, "memory.max", "1M")) {
> +               cg_destroy(group_name);
> +               goto fail;
> +       }
> +       return group_name;
> +fail:
> +       free(group_name);
> +       return NULL;
> +}
> +
>  /*
>   * Sanity test to check that pages are written into zswap.
>   */
> @@ -117,43 +135,51 @@ static int test_zswap_usage(const char *root)
>
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its mem=
ory
> - * limit in zswap, writeback should not be triggered.
> - *
> - * This was fixed with commit 0bdf0efa180a("zswap: do not shrink if cgro=
up may
> - * not zswap"). Needs to be revised when a per memcg writeback mechanism=
 is
> - * implemented.
> + * limit in zswap, writeback should affect only the zswapped pages of th=
at
> + * memcg.
>   */
>  static int test_no_invasive_cgroup_shrink(const char *root)
>  {
> -       size_t written_back_before, written_back_after;
>         int ret =3D KSFT_FAIL;
> -       char *test_group;
> +       size_t control_allocation_size =3D MB(10);
> +       char *control_allocation, *wb_group =3D NULL, *control_group =3D =
NULL;
>
>         /* Set up */
> -       test_group =3D cg_name(root, "no_shrink_test");
> -       if (!test_group)
> -               goto out;
> -       if (cg_create(test_group))
> +       wb_group =3D setup_test_group_1M(root, "per_memcg_wb_test1");
> +       if (!wb_group)
> +               return KSFT_FAIL;
> +       if (cg_write(wb_group, "memory.zswap.max", "10K"))
>                 goto out;
> -       if (cg_write(test_group, "memory.max", "1M"))
> +       control_group =3D setup_test_group_1M(root, "per_memcg_wb_test2")=
;
> +       if (!control_group)
>                 goto out;
> -       if (cg_write(test_group, "memory.zswap.max", "10K"))
> +
> +       /* Push some test_group2 memory into zswap */
> +       if (cg_enter_current(control_group))
>                 goto out;
> -       if (get_zswap_written_back_pages(&written_back_before))
> +       control_allocation =3D malloc(control_allocation_size);
> +       for (int i =3D 0; i < control_allocation_size; i +=3D 4095)
> +               control_allocation[i] =3D 'a';
> +       if (cg_read_key_long(control_group, "memory.stat", "zswapped") < =
1)
>                 goto out;
>
> -       /* Allocate 10x memory.max to push memory into zswap */
> -       if (cg_run(test_group, allocate_bytes, (void *)MB(10)))
> +       /* Allocate 10x memory.max to push wb_group memory into zswap and=
 trigger wb */
> +       if (cg_run(wb_group, allocate_bytes, (void *)MB(10)))
>                 goto out;
>
> -       /* Verify that no writeback happened because of the memcg allocat=
ion */
> -       if (get_zswap_written_back_pages(&written_back_after))
> -               goto out;
> -       if (written_back_after =3D=3D written_back_before)
> +       /* Verify that only zswapped memory from gwb_group has been writt=
en back */
> +       if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(control_grou=
p) =3D=3D 0)
>                 ret =3D KSFT_PASS;
>  out:
> -       cg_destroy(test_group);
> -       free(test_group);
> +       cg_enter_current(root);
> +       if (control_group) {
> +               cg_destroy(control_group);
> +               free(control_group);
> +       }
> +       cg_destroy(wb_group);
> +       free(wb_group);
> +       if (control_allocation)
> +               free(control_allocation);
>         return ret;
>  }
>
> --
> 2.34.1
>
