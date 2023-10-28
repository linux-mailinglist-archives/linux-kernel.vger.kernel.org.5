Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFD7DA439
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 02:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbjJ1AFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ1AFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 20:05:05 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F46ED44
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 17:05:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7a93df91813so80276839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698451500; x=1699056300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1ZRPvQgwbALVr0+P64nebm6iIblXmeq69AStS1VWaw=;
        b=mjQmK2DQ6diuylmEE1eJEMK15k/qI28LuThA5ZSQ8prRQKAmWkv8AZYJ7tw+EOgJk2
         mwKrEiourwsctMpETq7rD4GWWD7QL6uqrXfr81/xkjSdn1bLjanxCgESmLOWnfYw9xPF
         l2jAz4E8bvlqvyiViBxEFw6z7WV+ZakIMKQA2KaUJyuTfjb4ZwyKJuirJzsMCx0obIO8
         DdZREkPb2VNf9SML4/BAdAF0hOWIgBkuahttbM3oZPvY6FBHlmMIfE1MlAL+0DzZXxJD
         ltJktbrH5p5uPYGvWY8V/4MyhfqbXe/Gh7B1iud77uAQ94CJf0aQsoGyKovOwW9QdFI8
         csCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698451500; x=1699056300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1ZRPvQgwbALVr0+P64nebm6iIblXmeq69AStS1VWaw=;
        b=oF8L+WAW8FvablF0L02LS80NKN2n5roTjifNheiNB4PMNh8MlOjNcJtpYGPPTgpce8
         qMQXWTLmHrGLRXvlvD64sc5EnKn3nPkTuGnFy59YLRk9Q+0LHaGOzlB+5jW72jEpS2Pm
         IYCgIEp3aac6LICk9BUJPj9chatGSjcfZepA2SakTWX+KOd0uU+RjCQkNAMbX8zpIP9g
         JjZTkj7Fnn8JxCoEFiR3MFhPCocBhtdKpc+FWZCEYayva6S0DmeISGxayoCAURj7ucLZ
         kTesgrcgh+P/tN/eK8Hz2AJRDSKOKxH+IbT/WcPGrt5tV9eLPZlTvmRXDPLuG2iY0nqx
         5ycA==
X-Gm-Message-State: AOJu0YwoJ8xLzDAbDLLWSDbHeZQ07NkeNkXOj3SPnmEQfGY+4HKaKSd8
        Rlg/yode8TYZAM8EYZHhoTAMovLbi4Q0cNIXlMM=
X-Google-Smtp-Source: AGHT+IEQhjtC7O+s/DxRuwQ2TfLbgF4Z/0LAtzjXV9RUEFKjHPUdVnMwacofE6Y3zWEoKgjZNKEBF1RahQQalNmWvTg=
X-Received: by 2002:a05:6602:2b91:b0:7a6:7bbe:5aa0 with SMTP id
 r17-20020a0566022b9100b007a67bbe5aa0mr5482913iov.0.1698451499461; Fri, 27 Oct
 2023 17:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231025095248.458789-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20231025095248.458789-1-hezhongkun.hzk@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 27 Oct 2023 17:04:48 -0700
Message-ID: <CAKEwX=P+c3kSKx3Ptz2PxHJfGGxyV5uO8gK41kDjkYV9ytcP6w@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: add writeback_time_threshold interface to
 shrink zswap pool
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 25, 2023 at 2:52=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> zswap does not have a suitable method to select objects that have not
> been accessed for a long time, and just shrink the pool when the limit
> is hit. There is a high probability of wasting memory in zswap if the
> limit is too high.
>
> This patch add a new interface writeback_time_threshold to shrink zswap
> pool proactively based on the time threshold in second, e.g.::
>
> echo 600 > /sys/module/zswap/parameters/writeback_time_threshold
>
> If zswap_entrys have not been accessed for more than 600 seconds, they
> will be swapout to swap. if set to 0, all of them will be swapout.
>
> This patch provides more control by specifying the time at which to
> start writing pages out.
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
> v2:
>    - rename sto_time to last_ac_time (suggested by Nhat Pham)
>    - update the access time when a page is read (reported by
>      Yosry Ahmed and Nhat Pham)
>    - add config option (suggested by Yosry Ahmed)
> ---
>  Documentation/admin-guide/mm/zswap.rst |   9 +++
>  mm/Kconfig                             |  11 +++
>  mm/zswap.c                             | 104 +++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index 45b98390e938..7aec245f89b4 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -153,6 +153,15 @@ attribute, e. g.::
>
>  Setting this parameter to 100 will disable the hysteresis.
>
> +When there is a lot of cold memory according to the last accessed time i=
n the
> +zswap, it can be swapout and save memory in userspace proactively. User =
can
> +write writeback time threshold in second to enable it, e.g.::
> +
> +  echo 600 > /sys/module/zswap/parameters/writeback_time_threshold
> +
> +If zswap_entrys have not been accessed for more than 600 seconds, they w=
ill be
> +swapout. if set to 0, all of them will be swapout.

My original concern with this approach (i.e regarding what value should be
used, and how frequent should userspace trigger this time-based writeback
mechanism) still stands.

If I'm a user of this feature, how would I figure out how long should an ob=
ject
lie dormant in the zswap pool before it is highly likely to be a cold objec=
t?
Users have no clue what the access time stats look like, what is its
distribution,
etc., and will have to somehow guesstimate this based purely on their knowl=
edge
of the program's memory access patterns (which, in many cases, are intentio=
nally
abstracted away).

It's rather hard for users to know what value of cutoff makes sense, withou=
t
extensive experiments on a realistic workload.

If I may ask, how do you use this feature internally? You don't have to
reveal any NDA-breaking details of course, but just a rough idea of
the kind of procedure to determine sensible threshold values will
help your case and the future user of this feature a lot.

> +
>  A debugfs interface is provided for various statistic about pool size, n=
umber
>  of pages stored, same-value filled pages and various counters for the re=
asons
>  pages are rejected.
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..426358d2050b 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -61,6 +61,17 @@ config ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON
>           The cost is that if the page was never dirtied and needs to be
>           swapped out again, it will be re-compressed.
>
> +config ZSWAP_WRITEBACK_TIME_ON
> +        bool "writeback zswap based on the last accessed time"
> +        depends on ZSWAP
> +        default n
> +        help
> +          If selected, the feature for tracking last accessed time  will=
 be
> +          enabled at boot, otherwise it will be disabled.

nit: looks there's a double space between time and will?

> +
> +          The zswap can be swapout and save memory in userspace proactiv=
ely
> +          by writing writeback_time_threshold in second.

I think we should include a bit more details in this config option descript=
ion.
Feel free to just recycle details from the commit log of course, but at lea=
st
there should be something along the line of:

When this is selected, users can proactively trigger writebacks by writing =
a
value to the writeback_time_threshold file. The pages whose last access tim=
e
is older than this value will be written back.

(please beautify that paragraph if you use it).

> +
>  choice
>         prompt "Default compressor"
>         depends on ZSWAP
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0c5ca896edf2..331ee276afbd 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -144,6 +144,19 @@ static bool zswap_exclusive_loads_enabled =3D IS_ENA=
BLED(
>                 CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
>  module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool,=
 0644);
>
> +
> +#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
> +/* zswap writeback time threshold in second */
> +static unsigned int  zswap_writeback_time_thr;
> +static int zswap_writeback_time_thr_param_set(const char *, const struct=
 kernel_param *);
> +static const struct kernel_param_ops zswap_writeback_param_ops =3D {
> +       .set =3D          zswap_writeback_time_thr_param_set,
> +       .get =3D          param_get_uint,
> +};
> +module_param_cb(writeback_time_threshold, &zswap_writeback_param_ops,
> +                       &zswap_writeback_time_thr, 0644);
> +#endif
> +
>  /* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
>  #define ZSWAP_NR_ZPOOLS 32
>
> @@ -200,6 +213,7 @@ struct zswap_pool {
>   * value - value of the same-value filled pages which have same content
>   * objcg - the obj_cgroup that the compressed memory is charged to
>   * lru - handle to the pool's lru used to evict pages.
> + * last_ac_time - the last accessed time of zswap_entry.
>   */
>  struct zswap_entry {
>         struct rb_node rbnode;
> @@ -213,6 +227,9 @@ struct zswap_entry {
>         };
>         struct obj_cgroup *objcg;
>         struct list_head lru;
> +#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
> +       ktime_t last_ac_time;
> +#endif
>  };
>
>  /*
> @@ -291,6 +308,27 @@ static void zswap_update_total_size(void)
>         zswap_pool_total_size =3D total;
>  }
>
> +#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
> +static void zswap_set_access_time(struct zswap_entry *entry)
> +{
> +       entry->last_ac_time =3D ktime_get_boottime();
> +}
> +
> +static void zswap_clear_access_time(struct zswap_entry *entry)
> +{
> +       entry->last_ac_time =3D 0;
> +}
> +#else
> +static void zswap_set_access_time(struct zswap_entry *entry)
> +{
> +}
> +
> +static void zswap_clear_access_time(struct zswap_entry *entry)
> +{
> +}
> +#endif
> +
> +
>  /*********************************
>  * zswap entry functions
>  **********************************/
> @@ -398,6 +436,7 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>         else {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_del(&entry->lru);
> +               zswap_clear_access_time(entry);
>                 spin_unlock(&entry->pool->lru_lock);
>                 zpool_free(zswap_find_zpool(entry), entry->handle);
>                 zswap_pool_put(entry->pool);
> @@ -712,6 +751,52 @@ static void shrink_worker(struct work_struct *w)
>         zswap_pool_put(pool);
>  }
>
> +#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
> +static bool zswap_reach_timethr(struct zswap_pool *pool)
> +{
> +       struct zswap_entry *entry;
> +       ktime_t expire_time =3D 0;
> +       bool ret =3D false;
> +
> +       spin_lock(&pool->lru_lock);
> +
> +       if (list_empty(&pool->lru))
> +               goto out;
> +
> +       entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru);
> +       expire_time =3D ktime_add(entry->last_ac_time,
> +                       ns_to_ktime(zswap_writeback_time_thr * NSEC_PER_S=
EC));
> +
> +       if (ktime_after(ktime_get_boottime(), expire_time))
> +               ret =3D true;
> +out:
> +       spin_unlock(&pool->lru_lock);
> +       return ret;
> +}
> +
> +static void zswap_reclaim_entry_by_timethr(void)
> +{
> +       struct zswap_pool *pool =3D zswap_pool_current_get();
> +       int ret, failures =3D 0;
> +
> +       if (!pool)
> +               return;
> +
> +       while (zswap_reach_timethr(pool)) {
> +               ret =3D zswap_reclaim_entry(pool);
> +               if (ret) {
> +                       zswap_reject_reclaim_fail++;
> +                       if (ret !=3D -EAGAIN)
> +                               break;
> +                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> +                               break;
> +               }
> +               cond_resched();
> +       }
> +       zswap_pool_put(pool);
> +}
> +#endif
> +
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
>         int i;
> @@ -1040,6 +1125,23 @@ static int zswap_enabled_param_set(const char *val=
,
>         return ret;
>  }
>
> +#ifdef CONFIG_ZSWAP_WRITEBACK_TIME_ON
> +static int zswap_writeback_time_thr_param_set(const char *val,
> +                               const struct kernel_param *kp)
> +{
> +       int ret =3D -ENODEV;
> +
> +       /* if this is load-time (pre-init) param setting, just return. */
> +       if (system_state !=3D SYSTEM_RUNNING)
> +               return ret;
> +
> +       ret =3D param_set_uint(val, kp);
> +       if (!ret)
> +               zswap_reclaim_entry_by_timethr();
> +       return ret;
> +}
> +#endif
> +
>  /*********************************
>  * writeback code
>  **********************************/
> @@ -1372,6 +1474,7 @@ bool zswap_store(struct folio *folio)
>         if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_add(&entry->lru, &entry->pool->lru);
> +               zswap_set_access_time(entry);
>                 spin_unlock(&entry->pool->lru_lock);
>         }
>         spin_unlock(&tree->lock);
> @@ -1484,6 +1587,7 @@ bool zswap_load(struct folio *folio)
>                 folio_mark_dirty(folio);
>         } else if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
> +               zswap_set_access_time(entry);
>                 list_move(&entry->lru, &entry->pool->lru);
>                 spin_unlock(&entry->pool->lru_lock);
>         }
> --
> 2.25.1
>

Do you have any experimental results/benchmarks that show
the wins from this approach?

Writing back cold pages from zswap is a good idea from a
theoretical and philosophical POV, but all sort of things could go
wrong, especially if we write pages that turn out to be needed
later on. Some experimental results would be nice.
