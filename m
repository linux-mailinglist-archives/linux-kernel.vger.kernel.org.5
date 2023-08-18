Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76F780EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378098AbjHRPTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378124AbjHRPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:19:02 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C83A94
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:19:01 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48b2f5b9b08so366025e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371940; x=1692976740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P97bQdtLkXYaA0AynUq0EZ6/3+YeSQEgYN8aKuKl+vg=;
        b=eDREqNeZMqP1u2k3aQjmOgtgERjfUcyE8LZAyKeRqWnK/1xDu5cpA+ZVXh+8cu3zTn
         FCd736OM6PqJl7Xu60/OQiQMbeiQACHZUtImtYo4qlt+Uq3IrPtNHiaDmr3hk3SrCcWa
         2J6CO3emcC85FVumYIPACECMoirDzxE2zBLMuyPo6ZLDbBJ47jbksTqCP/L7XWN4ZH3G
         dKs5zuSKLcqa015lSQxgJHxuwDwXQO/hACKtM4tlo2YD1qqydywH6frfF+GNasUiYYBp
         097TA9rc6CIKu+hnnXO/kMR8mJRI0KGf8YnbrDbH2q9DSEtp1ikg2ZVcFNm6LzDZP9Ye
         FZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371940; x=1692976740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P97bQdtLkXYaA0AynUq0EZ6/3+YeSQEgYN8aKuKl+vg=;
        b=V1vGl3V7k6TeZZByZU7Jclw61ahPnbs229BraSMBQW3KZyE+oEgHABGE4yOMvjGPOz
         QhVX9rHmR4WP/SOeuGRlqX3GQRvtQ0+de+6M2Awa4Rv3y0B/N+SA5H6OINKeWBw5dDqu
         qyP7m+bzdVAxPc+FNJOIlFlX2tWu5UIdwx/06leEb9mcdHfFI8zAArqE+NcfBZ+WQm1R
         H6k8JT3X9kM0OeW5aEPY0V6xf/7xrSk71mU525Zr4AUa73xY3IsNlMyBmz6BDj0obAVR
         kY8MwW8MOsH1uvSm0kvA7MxGxx0UGWuPV7RcI6JAXe0UuB1wFYamrSXmb0l5Vf8KRgA6
         hyRQ==
X-Gm-Message-State: AOJu0YzA2mUc+vYMNql17GTSSKAc4itsY0ETeLA1artlUcs0U3Oe9wGT
        1tNnq2jaHWZHLKI5XtF545qiGnqPqVnvJaM8ed4=
X-Google-Smtp-Source: AGHT+IEKx0SzvU5D2FqWbPDPAF+5clk1Spq16QV46q2pawqJMTYlEanbi4HUqugEgrWGUM8bZly0MVBM2ssOLxfqwJc=
X-Received: by 2002:a1f:ec43:0:b0:488:24b4:c100 with SMTP id
 k64-20020a1fec43000000b0048824b4c100mr3570843vkh.6.1692371940226; Fri, 18 Aug
 2023 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230723190906.4082646-1-42.hyeyoo@gmail.com> <30b5d85348d84891bf61d7c57370d8b46df8e1a0.camel@linux.ibm.com>
 <CAB=+i9TQsPmdpjJ5g-q6ennSha00EO8GGKGjvg5RE-JH36JZxA@mail.gmail.com> <dcddd1ebfb71fd0451b3e8a4fb63b30d560d401d.camel@linux.ibm.com>
In-Reply-To: <dcddd1ebfb71fd0451b3e8a4fb63b30d560d401d.camel@linux.ibm.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sat, 19 Aug 2023 00:18:48 +0900
Message-ID: <CAB=+i9R9+9qCtOKuFrbaHqFA1xixfnAroaYSKhYUYvWZ=RNWtg@mail.gmail.com>
Subject: Re: [RFC 0/2] An attempt to improve SLUB on NUMA / under memory pressure
To:     jaypatel@linux.ibm.com
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Binder Makin <merimus@google.com>, aneesh.kumar@linux.ibm.com,
        tsahu@linux.ibm.com, piyushs@linux.ibm.com, fengwei.yin@intel.com,
        ying.huang@intel.com, lkp <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 4:11=E2=80=AFPM Jay Patel <jaypatel@linux.ibm.com> =
wrote:
>
> On Fri, 2023-08-11 at 03:06 +0900, Hyeonggon Yoo wrote:
> > On Thu, Aug 10, 2023 at 7:56=E2=80=AFPM Jay Patel <jaypatel@linux.ibm.c=
om>
> > wrote:
> > > On Mon, 2023-07-24 at 04:09 +0900, Hyeonggon Yoo wrote:
> > > > Hello folks,
> > > >
> > > > This series is motivated by kernel test bot report [1] on Jay's
> > > > patch
> > > > that modifies slab order. While the patch was not merged and not
> > > > in
> > > > the
> > > > final form, I think it was a good lesson that changing slab order
> > > > has
> > > > more
> > > > impacts on performance than we expected.
> > > >
> > > > While inspecting the report, I found some potential points to
> > > > improve
> > > > SLUB. [2] It's _potential_ because it shows no improvements on
> > > > hackbench.
> > > > but I believe more realistic workloads would benefit from this.
> > > > Due
> > > > to
> > > > lack of resources and lack of my understanding of *realistic*
> > > > workloads,
> > > > I am asking you to help evaluating this together.
> > >
> > > Hi Hyeonggon,
> > > I tried hackbench test on Powerpc machine with 16 cpus but
> > > got ~32% of Regression with patch.
> >
> > Thank you so much for measuring this! That's very helpful.
> > It's interesting because on an AMD machine with 2 NUMA nodes there
> > was
> > not much difference.
> >
> > Does it have more than one socket?
>
> I have tested on single socket system.
> >
> > Could you confirm if the offending patch is patch 1 or 2?
> > If the offending one is patch 2, can you please check how large is L3
> > cache miss rate
> > during hackbench?
> >
> Below regression is cause by Patch 1 "Revert mm, slub: change percpu
> partial accounting from objects to pages"

Fortunately I was able to reproduce the regression (5~10%) on my amd laptop=
 :)
It's interesting and thank you so much for pointing it out!

It only modifies slowpath so the overhead of calculation itself should
be negligible.
And I think it's fair to assume that this is because the freelist is
shortened due to the patch,
because it rounds up the number of slabs:
> nr_slabs =3D DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));

So before the patch more objects were cached than intended.
I'll try to bump up the default value to the point where it does not
use more memory than before.

By the way, what is the optimal default value is very unclear to me.
Obviously 'Good enough value for hackbench' is not a good standard,
because it's quite a synthetic workload.


> Thanks
> Jay Patel
>
> > > Results as
> > >
> > > +-------+----+---------+------------+------------+
> > > >       |    | Normal  | With Patch |            |
> > > +-------+----+---------+------------+------------+
> > > > Amean | 1  | 1.3700  | 2.0353     | ( -32.69%) |
> > > > Amean | 4  | 5.1663  | 7.6563     | (- 32.52%) |
> > > > Amean | 7  | 8.9180  | 13.3353    | ( -33.13%) |
> > > > Amean | 12 | 15.4290 | 23.0757    | ( -33.14%) |
> > > > Amean | 21 | 27.3333 | 40.7823    | ( -32.98%) |
> > > > Amean | 30 | 38.7677 | 58.5300    | ( -33.76%) |
> > > > Amean | 48 | 62.2987 | 92.9850    | ( -33.00%) |
> > > > Amean | 64 | 82.8993 | 123.4717   | ( -32.86%) |
> > > +-------+----+---------+------------+------------+
> > >
> > > Thanks
> > > Jay Patel
