Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B567B02AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjI0LWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjI0LWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:22:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144013A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:22:14 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c038a1e2e6so170504331fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695813733; x=1696418533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDHE3JkApzs60E1jlFo1xcOl7e6kV427DVyzUPY1i5Y=;
        b=esFuJVeNmryVgwpxBY9xtj+nQN9392WUx7/AyyrQkqU8LXcEemss/svhq94OGx9+0s
         BFwmpjRVKVnLkmc+psjYmLhntNNT3SR02QIGiTCv2FGAitHiSk12GLwYM355Hw3bZL3a
         RjSb1FQtpNnatJabymshL70mcxxZ4R1Y76yVpPs+JEkMcbsEB48KpJfWjdzCadhQIp7S
         QaU/sPY5NTkY9r2bjG40o9JwQpw62WOvl4Ro62JF4URDc255+JNJa1R59T+0lcSAYc03
         H76oo/esywub9TtLhBkvpf0+BwteZa3S8+REa7tk4O4eSe+CP4nA7YtTQLuh+M87S9TW
         wLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813733; x=1696418533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDHE3JkApzs60E1jlFo1xcOl7e6kV427DVyzUPY1i5Y=;
        b=t5WdESCdImZQJRmQzF9a3eecBm3AGzyCP2Dn9b94hUEef54ZxUqY7/Czse/Hb27FJD
         2SeUQUGgLYhwtpg8xcPs+K/Mjk/uRvQ9g2XQpUf1G+zmJLRLV/RKiXFhcurwo29A8F/n
         x3tnLacPPdjUqvDcPycxlpHNd5dojudJ+w99myT7c+Xxvv3sLRBHNMi3bWE2SfszodrM
         ftXJ69ijdBBnaqDTMnwJnECcxDSsB2BCzibK9NM1IG5BJl59PhAe1igcnGaYn5cLatUW
         ERQA8vAICI7AVOQSUxH2ICaJLtce+5v3mg2JBr29tEWcA5MNAcizzKgS+lMCmOZGlTNm
         W6Dw==
X-Gm-Message-State: AOJu0Yy+tj9Qf2qcrcSxwiXHDvekjKoZtLg8d+KFaRF9vluVarbWOBJH
        RcwgznVkr0GwEltiiiQkZevr74MYbKv4HXfgZSPDCA==
X-Google-Smtp-Source: AGHT+IGpQwFYF0PEauY+MRECcrzbefQymxhY4ZDgqBswbi4amWKv2m9InJqyGtwgC0VlwB6kYKw73xUS3KAyHVZtgN0=
X-Received: by 2002:a2e:7a09:0:b0:2c0:2edb:3b1 with SMTP id
 v9-20020a2e7a09000000b002c02edb03b1mr1625754ljc.37.1695813733051; Wed, 27 Sep
 2023 04:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230922062558.1739642-1-max.kellermann@ionos.com>
 <CAOi1vP80WvQhuXgzhvzupQP=4K2ckgu_WpUCtUSy5M+QdDycqw@mail.gmail.com>
 <CAKPOu+-yUOuVh+3818iJ-GH968EHHQ0Pc3d8Rj4veO3k-xLk+g@mail.gmail.com>
 <CAOi1vP9QdfB0uxd64XcpREWFTqrJm0QNORYzrGvQBLOu4CrDWg@mail.gmail.com>
 <CAKPOu+87ka3z6haYXystbHFCUMRh4mtvOEFmEPsJ_vCW9_81RA@mail.gmail.com> <CAOi1vP85hF6qbch-mpY+NN5bS4p_ta=WG_b=cfKNOJLD9CrNag@mail.gmail.com>
In-Reply-To: <CAOi1vP85hF6qbch-mpY+NN5bS4p_ta=WG_b=cfKNOJLD9CrNag@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 27 Sep 2023 13:22:01 +0200
Message-ID: <CAKPOu+82j52NwUV3JUwwtWjcJsDktoMGnG_Sr5JstrPm8qhicQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/ceph/debugfs: make all files world-readable
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Venky Shankar <vshankar@redhat.com>,
        Gregory Farnum <gfarnum@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:53=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> =
wrote:
> > This "ceph" tool requires installing 90 MB of additional Debian
> > packages, which I just tried on a test cluster, and "ceph fs top"
> > fails with "Error initializing cluster client: ObjectNotFound('RADOS
> > object not found (error calling conf_read_file)')". Okay, so I have to
> > configure something.... but .... I don't get why I would want to do
> > that, when I can get the same information from the kernel without
> > installing or configuring anything. This sounds like overcomplexifying
> > the thing for no reason.
>
> I have relayed my understanding of this feature (or rather how it was
> presented to me).  I see where you are coming from, so adding more
> CephFS folks to chime in.

Let me show these folks how badly "ceph fs stats" performs:

 # time ceph fs perf stats
 {"version": 2, "global_counters": ["cap_hit", "read_latency",
"write_latency"[...]
 real    0m0.502s
 user    0m0.393s
 sys    0m0.053s

Now my debugfs-based solution:

 # time cat /sys/kernel/debug/ceph/*/metrics/latency
 item          total       avg_lat(us)     min_lat(us)     max_lat(us)
    stdev(us)
 [...]
 real    0m0.002s
 user    0m0.002s
 sys    0m0.001s

debugfs is more than 200 times faster. It is so fast, it can hardly be
measured by "time" - and most of these 2ms is the overhead for
executing /bin/cat, not for actually reading the debugfs file.
Our kernel-exporter is a daemon process, it only needs a single
pread() system call in each iteration, it has even less overhead.
Integrating the "ceph" tool instead would require forking the process
each time, starting a new Python VM, and so on...
For obtaining real-time latency statistics, the "ceph" script is the
wrong tool for the job.

Max
