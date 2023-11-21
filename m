Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB47F35BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjKUSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKUSNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:13:34 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC5F9;
        Tue, 21 Nov 2023 10:13:31 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7a692658181so211410139f.1;
        Tue, 21 Nov 2023 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700590410; x=1701195210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfSi8jztLL5VwZ61bYYW1EHFvtKUlkZi1z5US+ROIOc=;
        b=jRqpq0wfrJ7p7sW4zDAxGztNHuPZCdcNUEzxg/Wih38y2XhZSsJsn1WNH27xpZEuh3
         ruNA36L+qq5asak7hvYELuxMUq6lx3Zaa7v7WOsOEWAPizAs5kC2irUeoIOqmzymql45
         NrJ7fKXwyTfONGhjKsFg5EmwziDLGcq+bDp5x+Xm2dsi4A0pLpHt6mNdMpKBWLxtQvh3
         p5cE8XkD5Dhs19hE/aEsMMKCTezs/i3dkjrHboVy6iZQ41qwRif44sStH1a51sEFtia2
         5JyIztWKIU8KI5rya55CfLE3CVOIkM3hHEEjXc8lmC6wCjR+It9Krua5GgoC+I0K0lO8
         1D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700590410; x=1701195210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfSi8jztLL5VwZ61bYYW1EHFvtKUlkZi1z5US+ROIOc=;
        b=CFl4XeIuw7zl7FxxRTB8rFSyr3I6oe9kLQO/S3todlmitntwGG65OX3cq/Iy7qX1AT
         keUZSz8CNKIq7mXRyuIH87UmFAkKU59Oc8WN0FE2/HEXGqALi3hEwb5HVbKJnYMCszJg
         hjounyuGKaMX9tgc/md3kCGq3dB9YD8IbjSMdTKtg+zxdyM7o+idWrmVC2xQCmFfL2Aq
         gNoJCQaB8Tp6G4zCAlg2GHCdE13Xe5DYvuk/4EoBUou3gAn+nkOz1L0XCBw1X9AV/qwn
         6nQzQFobhj5bOQhq6FWbhwmTPLKyJuLS+qwYo6erZJIuDfCwMlKusLM1z+Ea99vXo2HM
         BhDg==
X-Gm-Message-State: AOJu0Ywz3rn1hKrUL2p9qzAiXeBEUnTBiCz70vUp8TR/f8hVYcKH07IS
        0p0njsY5n2Q2udi2+U/ryS9DaUNcf6gSgiDq6PQ=
X-Google-Smtp-Source: AGHT+IE0el9x0EDVgFGNwP5uT5x7+URKIXPhd6Cye2tLYqEQFdxy7MOeff1tuDwSmflJakITzTeXS8/l235qxAYe98o=
X-Received: by 2002:a6b:f802:0:b0:7a9:96aa:e019 with SMTP id
 o2-20020a6bf802000000b007a996aae019mr133799ioh.13.1700590410316; Tue, 21 Nov
 2023 10:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
 <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com>
 <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
 <CAKEwX=O5M-vZE5YhYQ5_CbCmXovS1XECO4ROXKWo06K880M1Mg@mail.gmail.com>
 <CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-LUdS+Sx3GA@mail.gmail.com>
 <CAKEwX=NdFjemcmf27PVpgHpVHWQEo19KfApepWJBRYeyVCWvCw@mail.gmail.com>
 <CAF8kJuOCyd5r0LQ3m8fQp0GtxxNUKSmwURJH6V9aApefvX8xCA@mail.gmail.com> <ZVrHXJLxvs4_CUxc@google.com>
In-Reply-To: <ZVrHXJLxvs4_CUxc@google.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 21 Nov 2023 10:13:19 -0800
Message-ID: <CAKEwX=MR6a-u87p=Oqm+zvwB_1zhrsM_n2=xW1kJz0_AoVwkPA@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
To:     Chris Li <chrisl@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Hugh Dickins <hughd@google.com>, corbet@lwn.net,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 6:41=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Nhat,
>
> On Sun, Nov 19, 2023 at 01:50:17PM -0800, Chris Li wrote:
> > On Sun, Nov 19, 2023 at 11:08=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > > I don't have any major argument against this. It just seems a bit
> > > heavyweight for what we need at the moment (only disabling
> > > swap-to-disk usage).
> >
> > The first milestone we just implement the reserved keywords without
> > the custom swap tier list.
> > That should be very similar to "zswap.writeback". Instead of writing 0
> > to "zswap.writeback".
> > You write "zswap" to "swap.tiers". Writing "none" will disable all
> > swap. Writing "all" will allow all swap devices.
> > I consider this conceptually cleaner than the "zswap.writeback" =3D=3D =
0
> > will also disable other swap types behavior. "disabled zswap writeback
> > =3D=3D disable all swap" feels less natural.
>
> I implement a minimal version of the "swap.tiers" to replace the "zswap.w=
riteback".
> It only implements the ABI level. Under the hook it is using the writebac=
k bool.
>
> This patch builds on top of your V5 patch.
>
> implement memory.swap.tiers on top of memory.zswap.writeback.
>
> "memory.swap.tiers" supports two key words for now:
> all: all swap swap tiers are considered. (previously zswap.writback =3D=
=3D 1)
> zswap: only zswap tier are considered. (previously zswap.writeback =3D=3D=
 0)
>
> Index: linux/mm/memcontrol.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/mm/memcontrol.c
> +++ linux/mm/memcontrol.c
> @@ -7992,6 +7992,32 @@ static int swap_events_show(struct seq_f
>         return 0;
>  }
>
> +static int swap_tiers_show(struct seq_file *m, void *v)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> +
> +       seq_printf(m, "%s\n", READ_ONCE(memcg->zswap_writeback) ? "all" :=
 "zswap");
> +       return 0;
> +}
> +
> +static ssize_t swap_tiers_write(struct kernfs_open_file *of,
> +                               char *buf, size_t nbytes, loff_t off)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> +       int zswap_writeback;
> +
> +       buf =3D strstrip(buf);
> +       if (!strcmp(buf, "all"))
> +               zswap_writeback =3D 1;
> +       else if (!strcmp(buf, "zswap"))
> +               zswap_writeback =3D 0;
> +       else
> +               return -EINVAL;
> +
> +       WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
> +       return nbytes;
> +}
> +
>  static struct cftype swap_files[] =3D {
>         {
>                 .name =3D "swap.current",
> @@ -8021,6 +8047,12 @@ static struct cftype swap_files[] =3D {
>                 .file_offset =3D offsetof(struct mem_cgroup, swap_events_=
file),
>                 .seq_show =3D swap_events_show,
>         },
> +       {
> +               .name =3D "swap.tiers",
> +               .seq_show =3D swap_tiers_show,
> +               .write =3D swap_tiers_write,
> +       },
> +
>         { }     /* terminate */
>  };
>
> @@ -8183,31 +8215,6 @@ static ssize_t zswap_max_write(struct ke
>         return nbytes;
>  }
>
> -static int zswap_writeback_show(struct seq_file *m, void *v)
> -{
> -       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> -
> -       seq_printf(m, "%d\n", READ_ONCE(memcg->zswap_writeback));
> -       return 0;
> -}
> -
> -static ssize_t zswap_writeback_write(struct kernfs_open_file *of,
> -                               char *buf, size_t nbytes, loff_t off)
> -{
> -       struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> -       int zswap_writeback;
> -       ssize_t parse_ret =3D kstrtoint(strstrip(buf), 0, &zswap_writebac=
k);
> -
> -       if (parse_ret)
> -               return parse_ret;
> -
> -       if (zswap_writeback !=3D 0 && zswap_writeback !=3D 1)
> -               return -EINVAL;
> -
> -       WRITE_ONCE(memcg->zswap_writeback, zswap_writeback);
> -       return nbytes;
> -}
> -
>  static struct cftype zswap_files[] =3D {
>         {
>                 .name =3D "zswap.current",
> @@ -8220,11 +8227,6 @@ static struct cftype zswap_files[] =3D {
>                 .seq_show =3D zswap_max_show,
>                 .write =3D zswap_max_write,
>         },
> -       {
> -               .name =3D "zswap.writeback",
> -               .seq_show =3D zswap_writeback_show,
> -               .write =3D zswap_writeback_write,
> -       },
>         { }     /* terminate */
>  };
>  #endif /* CONFIG_MEMCG_KMEM && CONFIG_ZSWAP */

Hi Chris!

Thanks for the patch. Would you mind if I spend some time staring
at the suggestion again and testing it some more?

If everything is good, I'll squash this patch with the original version,
(keeping you as a co-developer of the final patch of course), and
update the documentation before re-sending everything as v6.

Anyway, have a nice Thanksgiving break everyone! Thanks for
taking the time to review my patch and discuss the API with me!
