Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB2760DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGYJGm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjGYJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:06:39 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698B29B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:06:38 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-583d63ca1e9so29375387b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690275997; x=1690880797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke/nyKRStFvVZneO5nE6RIQDFpH9Z/vnZAMFeZPsEiA=;
        b=TieZfeJWUo3Dm/xxU37zYKNgwAJVnhSMXHi8Thfev3R7ZjhlUyiRbVolnpRs6c0dba
         4hUI9TMzmbClKTzZqBlcripjBDt4s2AyDZnzniPiZqLDXTtvp7VMSrR5vjSI1KuvTwSD
         QJ86vhOeJclk9hVi0qGZe9Zm8sl3QaXx8aeH11wTY5VUGa8QxL3kYNQYU1gywkTDGJuS
         HYmnlBSaCjFVRM20jgmRm8WjQjTEmJQKFiMfyKfgffWwI0dqcKzX4EhKfHQxs+TaAKvS
         fhyy1Qlt3lVvVzkFw3It+T94z6XIdErz+s0rxgmrLcMb518vJWFQuquEBjHFSu0x97W3
         UC0g==
X-Gm-Message-State: ABy/qLbacAcmtEaCYt6uFGjoj4TJcpnCks3XdMLIzcPXtd7/+dog0rK7
        SKtMziiVhfQj0qOJc6oD6SnZv7BBqDCycw==
X-Google-Smtp-Source: APBJJlGJ0Yyrr1gog2l6X4lbBDvNtJ8DGnS8rqXgpkYgen55fu35RHcK9+APFY3Ub7mvyYcZgsnFrg==
X-Received: by 2002:a81:74d6:0:b0:565:9a3d:a3f9 with SMTP id p205-20020a8174d6000000b005659a3da3f9mr9633633ywc.9.1690275997431;
        Tue, 25 Jul 2023 02:06:37 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id w184-20020a817bc1000000b0057682d3f95fsm3429636ywc.136.2023.07.25.02.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 02:06:36 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-cf284f4d7afso5867448276.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:06:36 -0700 (PDT)
X-Received: by 2002:a25:d06:0:b0:d0d:65cf:bcdd with SMTP id
 6-20020a250d06000000b00d0d65cfbcddmr5201669ybn.51.1690275996395; Tue, 25 Jul
 2023 02:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <202307251518.4JYwdU5r-lkp@intel.com>
In-Reply-To: <202307251518.4JYwdU5r-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 11:06:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWj=FLmkazPbYKPevDrcym2_HDb_U7Mb9YE9ovrP0jJfA@mail.gmail.com>
Message-ID: <CAMuHMdWj=FLmkazPbYKPevDrcym2_HDb_U7Mb9YE9ovrP0jJfA@mail.gmail.com>
Subject: Re: drivers/base/regmap/regcache-maple.c:114:23: warning:
 'upper_index' is used uninitialized
To:     kernel test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robot,

On Tue, Jul 25, 2023 at 10:17 AM kernel test robot <lkp@intel.com> wrote:
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
> commit: f033c26de5a5734625d2dd1dc196745fae186f1b regmap: Add maple tree based register cache
> date:   4 months ago
> config: arc-randconfig-r001-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251518.4JYwdU5r-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251518.4JYwdU5r-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307251518.4JYwdU5r-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop':
> >> drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index' is used uninitialized [-Wuninitialized]
>      114 |         unsigned long upper_index, upper_last;
>          |                       ^~~~~~~~~~~
> >> drivers/base/regmap/regcache-maple.c:114:36: warning: 'upper_last' is used uninitialized [-Wuninitialized]
>      114 |         unsigned long upper_index, upper_last;
>          |                                    ^~~~~~~~~~
>    drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
>      113 |         unsigned long lower_index, lower_last;
>          |                       ^~~~~~~~~~~
>    drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
>      113 |         unsigned long lower_index, lower_last;
>          |                                    ^~~~~~~~~~

These are false positives...

>
>
> vim +/upper_index +114 drivers/base/regmap/regcache-maple.c
>
>    106
>    107  static int regcache_maple_drop(struct regmap *map, unsigned int min,
>    108                                 unsigned int max)
>    109  {
>    110          struct maple_tree *mt = map->cache;
>    111          MA_STATE(mas, mt, min, max);
>    112          unsigned long *entry, *lower, *upper;
>    113          unsigned long lower_index, lower_last;
>  > 114          unsigned long upper_index, upper_last;
>    115          int ret;
>    116
>    117          lower = NULL;
>    118          upper = NULL;
>    119
>    120          mas_lock(&mas);
>    121
>    122          mas_for_each(&mas, entry, max) {
>    123                  /*
>    124                   * This is safe because the regmap lock means the
>    125                   * Maple lock is redundant, but we need to take it due
>    126                   * to lockdep asserts in the maple tree code.
>    127                   */
>    128                  mas_unlock(&mas);
>    129
>    130                  /* Do we need to save any of this entry? */
>    131                  if (mas.index < min) {
>    132                          lower_index = mas.index;
>    133                          lower_last = min -1;
>    134
>    135                          lower = kmemdup(entry, ((min - mas.index) *
>    136                                                  sizeof(unsigned long)),
>    137                                          GFP_KERNEL);

 lower{,_index,_last} and ...

>    138                          if (!lower) {
>    139                                  ret = -ENOMEM;
>    140                                  goto out;
>    141                          }
>    142                  }
>    143
>    144                  if (mas.last > max) {
>    145                          upper_index = max + 1;
>    146                          upper_last = mas.last;
>    147
>    148                          upper = kmemdup(&entry[max + 1],
>    149                                          ((mas.last - max) *
>    150                                           sizeof(unsigned long)),
>    151                                          GFP_KERNEL);

upper{,_index,_last} are always initialized together, ...

>    152                          if (!upper) {
>    153                                  ret = -ENOMEM;
>    154                                  goto out;
>    155                          }
>    156                  }
>    157
>    158                  kfree(entry);
>    159                  mas_lock(&mas);
>    160                  mas_erase(&mas);
>    161
>    162                  /* Insert new nodes with the saved data */
>    163                  if (lower) {

but these gatekeepers...

>    164                          mas_set_range(&mas, lower_index, lower_last);
>    165                          ret = mas_store_gfp(&mas, lower, GFP_KERNEL);
>    166                          if (ret != 0)
>    167                                  goto out;
>    168                          lower = NULL;
>    169                  }
>    170
>    171                  if (upper) {

check only one of them (which are preinitialized at lines 117/118).

>    172                          mas_set_range(&mas, upper_index, upper_last);
>    173                          ret = mas_store_gfp(&mas, upper, GFP_KERNEL);
>    174                          if (ret != 0)
>    175                                  goto out;
>    176                          upper = NULL;
>    177                  }
>    178          }
>    179
>    180  out:
>    181          mas_unlock(&mas);
>    182          kfree(lower);
>    183          kfree(upper);
>    184
>    185          return ret;
>    186  }
>    187

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
