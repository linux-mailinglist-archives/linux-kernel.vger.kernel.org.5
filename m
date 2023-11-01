Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D09E7DE4A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbjKAQfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKAQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:35:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB31101;
        Wed,  1 Nov 2023 09:34:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7DAC82184B;
        Wed,  1 Nov 2023 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698856496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5O9yVzr2Fp86pXITTg5XMjcbZYAb2UKlWEjGDcWW0Q=;
        b=NtrqpV4eaS2cWFNn/HdGMpva2UjRENBzj77si+MHz9/1qQiSc4atEySayNGBnNSEfRR/FO
        re3LZE2XdFx4+mVhuB3k+Pl3aTmb5c0XgLLlhShRPGWxoqmho/RcAONpdsvD1x59pY5he5
        sk4CjMH7S6ZHr6rYXznEQgrOQaNXHNo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B17113460;
        Wed,  1 Nov 2023 16:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KLJuDTB+QmUiRAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 01 Nov 2023 16:34:56 +0000
Date:   Wed, 1 Nov 2023 17:34:54 +0100
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an
 atomic_t value
Message-ID: <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
References: <20231024141834.4073262-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6dp2g4bz4jcl4rk"
Content-Disposition: inline
In-Reply-To: <20231024141834.4073262-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6dp2g4bz4jcl4rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long <longman@redhat.com> =
wrote:
> The nr_deadline_tasks field in cpuset structure was introduced by
> commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> cpuset_mutex, nr_deadline_tasks can be updated under two different
> locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
> a result, data races can happen leading to incorrect nr_deadline_tasks
> value.

The effect is that dl_update_tasks_root_domain() processes tasks
unnecessarily or that it incorrectly skips dl_add_task_root_domain()?

> Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
> the easy way out to avoid this possible race condition is by making
> nr_deadline_tasks an atomic_t value.

If css_set_lock is useless for this fields and it's going to be atomic,
could you please add (presumably) a cleanup that moves dec_dl_tasks_cs()
=66rom under css_set_lock in cgroup_exit() to a (new but specific)
cpuset_cgrp_subsys.exit() handler?

Thanks,
Michal

--z6dp2g4bz4jcl4rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZUJ+LAAKCRAGvrMr/1gc
jgZ4APwOEmqWSHl49Yb8odlBYPzqkB5OTy1xHY0CjMcLKHeN6QD+IpxKJC/9OTpe
rm9cRwaVk5bAFTh8Z83s86WFr73Zgg4=
=1DEk
-----END PGP SIGNATURE-----

--z6dp2g4bz4jcl4rk--
