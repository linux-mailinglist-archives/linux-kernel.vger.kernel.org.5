Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F88018CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441945AbjLBAQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBAQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:16:01 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D7DD;
        Fri,  1 Dec 2023 16:16:08 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C5D75C01D5;
        Fri,  1 Dec 2023 19:16:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 01 Dec 2023 19:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1701476167; x=1701562567; bh=NnvmqJQAxazHvzMLPYJJMCWR3fPVZJKgp3P
        iGTQFF9M=; b=GnkBaMMh4C6+HCWh8gY282XFYkUbCQKqHStiMvQKIbmzT1hstvE
        kKIkOnm4nmyyjDCRtMwmNzLUgYtn4Mo6kJHPFPweAeuAi4Nu/pWxgGu4bjJD/bIm
        N2ellqNdcMk6JilhPiPREjR2EbA26NOnogWh9WKPSqOGjH/0S6Pi4SiKbbcTQCjw
        eAzYKwle2XIV8dzjnLE8kn4pvf7VMNsF4rAbd9mmz5CHIwwINmwguVvOaDQBZzHK
        +l3ZOr2f6jWzkObSx/eA3ceBV+VRStx2qrbiH1zKZ62kNvtT5D45N44Fy5INL45l
        aGM/0HGXZBaTfwXeUVBwMcUpAbEF8yYiNLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701476167; x=1701562567; bh=NnvmqJQAxazHvzMLPYJJMCWR3fPVZJKgp3P
        iGTQFF9M=; b=njnExw1aJ9gx5YelQLM8f2uDV52Uhf3pJ0EDd9aCnL0k3c/4F59
        n1h+Q97jaQFTYxabcrbyEd9I2Xp+g7gcgm8pXYz8Zm4NW95OjVmGYx4FA9MWGDwh
        jOyMRdjXCghnzStcHG5Zh/BHQZ2TalLty2ps4LNcUZGVEtoky/YP09+aA9S2iSIr
        J6Hl4YUTjTw62tJwB+c90eDZsxrPSaMEyk1CVla8TNmiiLLKV5d+P62lgkxn/ljv
        W90Hu5FKtWecRA7ChWSOxDn6BoMqlZVzECtfUU7dr10y7LglMBAYz1UQm2u15Kf7
        5SXqqiAjk3QCl0mRYUZa0shmWmuj4wFWemQ==
X-ME-Sender: <xms:RndqZZcUs9Ut9E0-UXE-lSJtYqMciKOb6ZXqXpb22Y_XuYwvHg1rTw>
    <xme:RndqZXOK6RYeQb3CeCSwetUsbeKH7axhT0NmBqnTvZmGRDhjJCkef6U6HV9xa4oMr
    d2_vqjFpLQp9Waq_w>
X-ME-Received: <xmr:RndqZSidN-cuQ8SBE41aPZLxpHbrLp2M3tY7d9lLhqahBfpc3gMkzxB-CEEPtQb7Zxi9RkateJPvEbEKGCAsFrBT0vy7VcKTfgLJ5wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejtddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefggfdvfffhiedvieeuuddvudfffffggeeugedtkeehffeh
    jefgheejiedtledtfeenucffohhmrghinhepihgvthhfrdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    gihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:RndqZS9Goz_m3esZoI2St0pdbueUBF9fkKjs6dW3ZYSbEP_w0SmKSg>
    <xmx:RndqZVvgKntjyFjfkGZLTk85Votr_fMzTTe0PAVH9MSqqZZjH8KxOQ>
    <xmx:RndqZRHlnTXnweupWcL2F1CSYQjr7k_98XKqqrwEJ8CqDZBBSKpgrQ>
    <xmx:R3dqZbJQYvkKaQ-SCgWvg3gUZHKTLltPC7K7TmQhMG80Cliuk2BhHg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 19:16:05 -0500 (EST)
Date:   Fri, 1 Dec 2023 17:16:04 -0700
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        antony.antony@secunet.com, Yonghong Song <yonghong.song@linux.dev>,
        Eddy Z <eddyz87@gmail.com>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v3 0/9] Add bpf_xdp_get_xfrm_state() kfunc
Message-ID: <dkzlpw6sj7we5xteyvbwxufqzg6axwlrvb4arq23ecaiy5ayok@jg52fqjr4ftf>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
 <CAADnVQKWrvec6ap_7O0Z5uAJe-pdrhuJk8LRkmWvGMM4iF9Frg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKWrvec6ap_7O0Z5uAJe-pdrhuJk8LRkmWvGMM4iF9Frg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 04:10:18PM -0800, Alexei Starovoitov wrote:
> On Fri, Dec 1, 2023 at 12:23 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
> > bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
> > xfrm_state_put(). The intent is to support software RSS (via XDP) for
> > the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
> > on (hopefully) reproducible AWS testbeds indicate that single tunnel
> > pcpu ipsec can reach line rate on 100G ENA nics.
> >
> > Note this patchset only tests/shows generic xfrm_state access. The
> > "secret sauce" (if you can really even call it that) involves accessing
> > a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
> > available here [1].
> >
> > [0]: https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/03/
> > [1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406
> >
> > Changes from v2:
> > * Fix/simplify BPF_CORE_WRITE_BITFIELD() algorithm
> > * Added verifier tests for bitfield writes
> > * Fix state leakage across test_tunnel subtests
> >
> > Changes from v1:
> > * Move xfrm tunnel tests to test_progs
> > * Fix writing to opts->error when opts is invalid
> > * Use __bpf_kfunc_start_defs()
> > * Remove unused vxlanhdr definition
> > * Add and use BPF_CORE_WRITE_BITFIELD() macro
> > * Make series bisect clean
> >
> > Changes from RFCv2:
> > * Rebased to ipsec-next
> > * Fix netns leak
> >
> > Changes from RFCv1:
> > * Add Antony's commit tags
> > * Add KF_ACQUIRE and KF_RELEASE semantics
> >
> > Daniel Xu (9):
> >   bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
> >   bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
> >   libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
> >   bpf: selftests: test_loader: Support __btf_path() annotation
> >   libbpf: selftests: Add verifier tests for CO-RE bitfield writes
> >   bpf: selftests: test_tunnel: Setup fresh topology for each subtest
> >   bpf: selftests: test_tunnel: Use vmlinux.h declarations
> >   bpf: selftests: Move xfrm tunnel test to test_progs
> >   bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
> >
> >  include/net/xfrm.h                            |   9 +
> >  net/xfrm/Makefile                             |   1 +
> >  net/xfrm/xfrm_policy.c                        |   2 +
> >  net/xfrm/xfrm_state_bpf.c                     | 128 ++++++++++++++
> >  tools/lib/bpf/bpf_core_read.h                 |  34 ++++
> >  .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++++++++-
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
> >  .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
> >  .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++-------
> >  .../bpf/progs/verifier_bitfield_write.c       | 100 +++++++++++
> >  tools/testing/selftests/bpf/test_loader.c     |   7 +
> >  tools/testing/selftests/bpf/test_tunnel.sh    |  92 ----------
> >  13 files changed, 522 insertions(+), 155 deletions(-)
> 
> I really think this should go via bpf-next tree.
> The bpf changes are much bigger than ipsec.

Ack. Ended up picking up a lot of stuff along the way.
