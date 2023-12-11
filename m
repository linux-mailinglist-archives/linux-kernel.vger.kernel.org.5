Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5F80DB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbjLKUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344816AbjLKUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:20:26 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE4C4;
        Mon, 11 Dec 2023 12:20:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 57F015C03B9;
        Mon, 11 Dec 2023 15:20:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Dec 2023 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1702326029; x=1702412429; bh=1LpLS1VeE5
        3pmJfvPFkbIaa6I4cSdrZgdy4B9FeKti0=; b=BHKcWMQaz4kdz0P9KrZj9tMljJ
        RpPJGDUGJr9DZLXC1QaVVSNcPPkPUSc99kZzUGHVbUavFvpgjxLKmqyAVc2qqkoJ
        XJw1QqiffmqvjmsMXGz2A445jgl8izocAknqfYfCKvLV831miPjNlzJaPvW7Uri0
        S+8kUU9qzr2eDkyI8tUYdiacKAKgA00/ds1wjgvL34j1/kgsySaFLviiOAbD6g44
        gZcEHV/OAi8iEsuDvimEZ63SZ6zHWamTjdxRX/LryDd8bRfsqAR3370Wfy8YGSkM
        5MU6VP0jS3BhAMK9TyaiOHG8jDru8zdlUly2y55rQSYo1D4l3+ExBVXgiOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1702326029; x=1702412429; bh=1LpLS1VeE53pm
        JfvPFkbIaa6I4cSdrZgdy4B9FeKti0=; b=z1V0zJn54JcQuSexGk6Ou7cLDXtLl
        eMmFguAAi68QbXZndhoi3zh+CcmjtgLv1xIvUZ7KguND97iJovL+k02LPd6i2JDV
        vmmazbhQm4bBycdu5vLL+g0kWStyOBKVLugzOMtjAM0kJelwmXQr1WDz9GV0M/EY
        U2yTdbn1UhymLWLSwI8201Fl9vXrxmc7MR8aKOPzpdWgapSCXuEpQevLb9mZDv6k
        PWVHdegp3v3e+ktQCG2p0fBIAQupDE6QmTEY4fRmjAastKcZyfXkNS7HuTEqXZPb
        XGC25ULvds3uqAvv40pYmZZ+n62NvAX0Be5rju9lFQaIKY04i4xSVewkA==
X-ME-Sender: <xms:DG93ZRtsaSCBRiTcLfKEycUOhm4idynzG28hntarWAnSni4LybHjXQ>
    <xme:DG93Zadl3d4bXAGrv9yBuIyO_mTbDkvj03ppP97LLut4n-57fkkewnUNq6Bg6VmBc
    0FxfMn3A9mX15gHfA>
X-ME-Received: <xmr:DG93ZUyq7EyuEr0yWtEm5M7WdHRxXMFlOBzHzsXu-GPyGyfA4pRQAcybCWBpM4ZKFsn20aq3FAECWrZYdIbDBGSqdg1Id7aqtaHpkK0hfhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:DG93ZYM2uIzV1Cn0VOboDaxh4IG6I4wlBujeANcxdMdsd2PcJVMICw>
    <xmx:DG93ZR-scIL8PLX32brlGjX3lwErkzRm42AIsaTbc0Oe66cHSjnq2Q>
    <xmx:DG93ZYW_F9Tuu2gjAx-g6RhDd8ipjexYD2h3mCruna9xZz2DvS2xpg>
    <xmx:DW93ZS2EZi5D85RdITfcjF2rnz7hYVaL6V_bCx0AuNuLCxESXThqkA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:27 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        llvm@lists.linux.dev, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com, eyal.birger@gmail.com
Cc:     devel@linux-ipsec.org
Subject: [PATCH bpf-next v5 0/9] Add bpf_xdp_get_xfrm_state() kfunc
Date:   Mon, 11 Dec 2023 13:20:04 -0700
Message-ID: <cover.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
xfrm_state_put(). The intent is to support software RSS (via XDP) for
the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
on (hopefully) reproducible AWS testbeds indicate that single tunnel
pcpu ipsec can reach line rate on 100G ENA nics.

Note this patchset only tests/shows generic xfrm_state access. The
"secret sauce" (if you can really even call it that) involves accessing
a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
available here [1].

[0]: https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/03/
[1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406

Changes from v4:
* Fixup commit message for selftest
* Set opts->error -ENOENT for !x
* Revert single file xfrm + bpf

Changes from v3:
* Place all xfrm bpf integrations in xfrm_bpf.c
* Avoid using nval as a temporary
* Rebase to bpf-next
* Remove extraneous __failure_unpriv annotation for verifier tests

Changes from v2:
* Fix/simplify BPF_CORE_WRITE_BITFIELD() algorithm
* Added verifier tests for bitfield writes
* Fix state leakage across test_tunnel subtests

Changes from v1:
* Move xfrm tunnel tests to test_progs
* Fix writing to opts->error when opts is invalid
* Use __bpf_kfunc_start_defs()
* Remove unused vxlanhdr definition
* Add and use BPF_CORE_WRITE_BITFIELD() macro
* Make series bisect clean

Changes from RFCv2:
* Rebased to ipsec-next
* Fix netns leak

Changes from RFCv1:
* Add Antony's commit tags
* Add KF_ACQUIRE and KF_RELEASE semantics


Daniel Xu (9):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
  bpf: selftests: test_loader: Support __btf_path() annotation
  bpf: selftests: Add verifier tests for CO-RE bitfield writes
  bpf: selftests: test_tunnel: Setup fresh topology for each subtest
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 130 ++++++++++++++
 tools/lib/bpf/bpf_core_read.h                 |  32 ++++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++-------
 .../bpf/progs/verifier_bitfield_write.c       | 100 +++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   7 +
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 ----------
 13 files changed, 522 insertions(+), 155 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

-- 
2.42.1

