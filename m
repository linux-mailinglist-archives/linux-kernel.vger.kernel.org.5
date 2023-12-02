Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAC6801ACB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjLBEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBEv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:51:57 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA45D7E;
        Fri,  1 Dec 2023 20:52:03 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d7fc4661faso907965a34.3;
        Fri, 01 Dec 2023 20:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701492723; x=1702097523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2qcgHioeM3UqyvMPr3V1bhPDDu62MtFokimKSIjeVM=;
        b=kFBFAGKQy5F9PTAVUbxPSdfEPCRkYwNP5fCCpWL7ej23d++3WT/6RrsrYo1Jzdga3e
         ZRuqO6lqNv960aLCX9ff/qlxPP+NsvqvBndSd+waD5yZmht/AaSw3dg8q4U6Ztgw9DAg
         IbFBmFsd4I/G5Cu2wvyLuBGFO+fkFOPkA7aXSa7yhAGATkzbYs3i91J1NSs0T13zrGaX
         LORXb5amt+gyuNeWsN85qdJLpHnTpsE+I5sWc7rz0KV58TJnaY3qnlUcgNHeVr84wjQ+
         IV0URYO9H7NVqwpP8JS9uUGJg+j5O+Vf0fJyY7h5vjG+ATyKt+V/Rqkx6pzJ8KjSlFN4
         W/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701492723; x=1702097523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2qcgHioeM3UqyvMPr3V1bhPDDu62MtFokimKSIjeVM=;
        b=v2okGxnkRzSJjWwsFS1YgrcQSeDC7M8z3dNCYOz3D4oxO0VANvrcqG1Onr7eeCcsnB
         u8b0XCLlxZyIDn4UOgI3iwOdJVYha6ymCAu6Qen5a3UGlIHMnjzDD0/Gw17+NMY7mc2c
         pTHqGVQk5upieAXzYLrcGvMdQN8gKVV1vqFdmwQPHV2GqVTGkxqlraqImBumbnGCjjoR
         8mlBSZopNUOmIGuDCvmChPn1dT4qgKo423vBy3Cu5P+tBBHwA4V9rOL4yH4+G9HAHU8r
         AlYE56xvk1BrXxSefhU95J69WwKZa6RP79+sAB4jUmO4f0rLtQXFb56fYGfvRfsf6XGG
         MMjA==
X-Gm-Message-State: AOJu0Yw/V0fuhpiSpuBcRJandI5WQKYTyWhrDd/V690I3Y0Y5sa2GlEp
        1CLEBJhBmNGW+7sKwukAKlw=
X-Google-Smtp-Source: AGHT+IF/vmaKUNG5qrF+W01y9HhVT669/VcjaRhOtpiHj0vVmlUgHGI3LtGF08hI8ptteTRojtoYrg==
X-Received: by 2002:a05:6830:439e:b0:6d3:127b:6fba with SMTP id s30-20020a056830439e00b006d3127b6fbamr963345otv.9.1701492722863;
        Fri, 01 Dec 2023 20:52:02 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006889511ab14sm3813267pfd.37.2023.12.01.20.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:52:02 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id F1AD010211875; Sat,  2 Dec 2023 11:51:58 +0700 (WIB)
Date:   Sat, 2 Dec 2023 11:51:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux CGroups <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable v4 0/5] mm: memcg: subtree stats flushing and
 thresholds
Message-ID: <ZWq37kuibjnAecxN@archie.me>
References: <20231129032154.3710765-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0SGrbMye1JyaEl8d"
Content-Disposition: inline
In-Reply-To: <20231129032154.3710765-1-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0SGrbMye1JyaEl8d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 03:21:48AM +0000, Yosry Ahmed wrote:
> This series attempts to address shortages in today's approach for memcg
> stats flushing, namely occasionally stale or expensive stat reads. The
> series does so by changing the threshold that we use to decide whether
> to trigger a flush to be per memcg instead of global (patch 3), and then
> changing flushing to be per memcg (i.e. subtree flushes) instead of
> global (patch 5).
>=20
> Patch 3 & 5 are the core of the series, and they include more details
> and testing results. The rest are either cleanups or prep work.
>=20
> This series replaces the "memcg: more sophisticated stats flushing"
> series [1], which also replaces another series, in a long list of
> attempts to improve memcg stats flushing. It is not a new version of
> the same patchset as it is a completely different approach. This is
> based on collected feedback from discussions on lkml in all previous
> attempts. Hopefully, this is the final attempt.
>=20
> There was a reported regression in v2 [2] for will-it-scale::fallocate
> benchmark. I believe this regression should not affect production
> workloads. This specific benchmark is allocating and freeing memory
> (using fallocate/ftruncate) at a rate that is much faster to make actual
> use of the memory. Testing this series on 100+ machines running
> production workloads did not show any practical regressions in page
> fault latency or allocation latency, but it showed great improvements in
> stats read time. I do not have numbers about the exact improvements for
> this series, but combined with another optimization for cgroup v1 [3] we
> see 5-10x improvements. A significant chunk of that is coming from the
> cgroup v1 optimization, but this series also made an improvement as
> reported by Domenico [4].
>=20
> v3 -> v4:
> - Rebased on top of mm-unstable + "workload-specific and memory
>   pressure-driven zswap writeback" series to fix conflicts [5].
>=20
> v3: https://lore.kernel.org/all/20231116022411.2250072-1-yosryahmed@googl=
e.com/
>=20
> [1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@googl=
e.com/
> [2]https://lore.kernel.org/lkml/202310202303.c68e7639-oliver.sang@intel.c=
om/
> [3]https://lore.kernel.org/lkml/20230803185046.1385770-1-yosryahmed@googl=
e.com/
> [4]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPY=
EL7nK77e2A@mail.gmail.com/
> [5]https://lore.kernel.org/all/20231127234600.2971029-1-nphamcs@gmail.com/
>=20
> Yosry Ahmed (5):
>   mm: memcg: change flush_next_time to flush_last_time
>   mm: memcg: move vmstats structs definition above flushing code
>   mm: memcg: make stats flushing threshold per-memcg
>   mm: workingset: move the stats flush into workingset_test_recent()
>   mm: memcg: restore subtree stats flushing
>=20
>  include/linux/memcontrol.h |   8 +-
>  mm/memcontrol.c            | 272 +++++++++++++++++++++----------------
>  mm/vmscan.c                |   2 +-
>  mm/workingset.c            |  42 ++++--
>  4 files changed, 188 insertions(+), 136 deletions(-)
>=20

No regressions when booting the kernel with this series applied.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--0SGrbMye1JyaEl8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWq37gAKCRD2uYlJVVFO
o7N2AQDSNXpD6Axxh/WnApbIhH16SGiyDgp6Uioihd6PwgFtagEAzzRVEaimNHaK
O5VpHq566EuUfCIWVZFuttw0/5KlFgg=
=RYDo
-----END PGP SIGNATURE-----

--0SGrbMye1JyaEl8d--
