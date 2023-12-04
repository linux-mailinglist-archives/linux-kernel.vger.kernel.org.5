Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAC80407E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjLDU5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjLDU4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:56:52 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB009111;
        Mon,  4 Dec 2023 12:56:55 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 80A3B5C00B3;
        Mon,  4 Dec 2023 15:56:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 04 Dec 2023 15:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1701723412; x=1701809812; bh=8GB/ov08iH
        jvBVcUgI6yH23procKO/e3iFK3yc6WqUI=; b=f0qpg284bJpVVw1nPh/TnrCzv3
        Gx2cCAU90XK8Vn4wuO26c1FdbQozmMDNw6d3By+luF4UAEclBr9QqmJJSNmoaWSe
        dghTKz7p5ao5uzWQ90LABJsuJqxZo3vblOBqenXnXYRMo4jsrJLTZbr+BSHN9juk
        F6mO5KJRC9PH2Gh4MgzKMLPE5a9NuWnCXR+aNudgkKzTnk2x2wouNWj0VG6m/1FY
        osZ692+6onWHgaKIiz9zhHUFsVMvyL8aM8JsSIeQywvDstLK10cFYBvUAlEyBfKW
        /nUBBhmdltV/avoZypJk0B8aqj0obuyz2/vM7Nr7G+GbGQDMKFQKHgms/9Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701723412; x=1701809812; bh=8GB/ov08iHjvB
        VcUgI6yH23procKO/e3iFK3yc6WqUI=; b=UKTEbC2c27b9X/4abi4DjkBrcB+03
        f+ducKIrmHS/cNvKIEtaWqz8KYtr3KieTOM9OgrSmNnvQJmqXdsZZoeBQjGnXCJd
        96c+Cv7eCfcgHRQSpbL9VXJxmJMHfVKt3YlEiUBuPYDbW0+w6nKFmC7vOuvPFXBZ
        f8gVpflf98HKM6/DM2zo5bo50SEkHYUieVZqhREYQWLfAjcKUEiOvyrHtva8wHoS
        NhS44dpbEcTSpbZSJGOrIklLC6xAYMy7PKeXNEV3skcX6UOhkmY/Gl7+492d/qPE
        bYeZScmVy5Jq8Hhp27Tqn8H4MWc6R3lZ4CbW/hIpaR2aLQhovy/38e1OQ==
X-ME-Sender: <xms:FD1uZYv_KetGYMWakHdAqH9jCWJN7W-oDkolZy2r5n8K8KFqCcHyVA>
    <xme:FD1uZVfMkkLL-dYVBYDo1Pc1-g3BPwuUqrZ6ALFwPG9BZtRv0JDm5-BQfq7dU1lwh
    5Jzn1ebJBZDqB2X_w>
X-ME-Received: <xmr:FD1uZTyDqwU8yuaaxqSxd5wDctbaAl-A6QyL5nJswiorb5IFYygsL0feLY57BdiyLgXa3nCH6Tx0mgZL_yuVMI1o_8s-QUh99K_8xmhe3-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:FD1uZbM0IsrvwIyX70QLs1E167i6An8PHqCk_KlHVn1jNrPbz1Nzkg>
    <xmx:FD1uZY8GMdeLBalgSYt343IglU5Ep0BSvPQ-Duvj05_hl-Ct1TnfnA>
    <xmx:FD1uZTXhfjqxYahnQxTJDzhD8Mzz1Xl-HcxP6dGo-3HrmdYS8fb8yg>
    <xmx:FD1uZTboSbWyQ3clRaELqJGRcLHUzDhj38AsKU66QLVwO6X9fV8yPw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:56:51 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        llvm@lists.linux.dev, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     devel@linux-ipsec.org
Subject: [PATCH bpf-next v4 00/10] Add bpf_xdp_get_xfrm_state() kfunc
Date:   Mon,  4 Dec 2023 13:56:20 -0700
Message-ID: <cover.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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


Daniel Xu (10):
  xfrm: bpf: Move xfrm_interface_bpf.c to xfrm_bpf.c
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
  bpf: selftests: test_loader: Support __btf_path() annotation
  libbpf: selftests: Add verifier tests for CO-RE bitfield writes
  bpf: selftests: test_tunnel: Setup fresh topology for each subtest
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   7 +-
 net/xfrm/xfrm_bpf.c                           | 232 ++++++++++++++++++
 net/xfrm/xfrm_interface_bpf.c                 | 110 ---------
 net/xfrm/xfrm_policy.c                        |   2 +
 tools/lib/bpf/bpf_core_read.h                 |  32 +++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++-----
 .../bpf/progs/verifier_bitfield_write.c       | 100 ++++++++
 tools/testing/selftests/bpf/test_loader.c     |   7 +
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 -------
 14 files changed, 624 insertions(+), 271 deletions(-)
 create mode 100644 net/xfrm/xfrm_bpf.c
 delete mode 100644 net/xfrm/xfrm_interface_bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bitfield_write.c

-- 
2.42.1

