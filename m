Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663B8801443
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379443AbjLAUXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLAUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:23:46 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43F110C2;
        Fri,  1 Dec 2023 12:23:52 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E64F5C01AE;
        Fri,  1 Dec 2023 15:23:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 15:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1701462232; x=1701548632; bh=v+Tu4Bv5Hn
        sux9nKej021Clejo1i0m7B359jEiXfuUk=; b=k+GjMhwb4lBExMqHzvpS1DDiM9
        xJpNzAiHkhGEm9hcPI6CkRPr2uD15m8gOTtr9NdHwNWJ2sY8XK8LDUihwz6v0ZXk
        7396GWvonb1jA1BZYunU93pfw35hvrUAiNCxBc0XfLMalwVm2Q2NGoJdFLQMlVGS
        UhETxmW/EkQ8gM8GS5pCJu6jEDwIffW5czb5dSVD0I9M783LaygiK1AFmYTmWAiG
        xUo1y9LFZuONVGTV9Pdf+EWRSzD7tyB+QtpIzhVfyioI/MgUfjF769j0rSl62Amd
        BRR/0HVWE/MFnRIyNQxLWiTXfEPxJ1FMqoD2QBpNDnOWMGkxc1rFtuH72GZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701462232; x=1701548632; bh=v+Tu4Bv5Hnsux
        9nKej021Clejo1i0m7B359jEiXfuUk=; b=YC5ec4jYHVz5viFxUXWS0vb0RUxYg
        82WHiNgKXbfSwmmryzA2WB8uY5YV0IbhJBhHGMU+jtSOwnskOGE6hG/0cqbCa8zs
        JSXWlo5cWJZY4zaLJ3i2wlAm0tK+ZlC5ORbOorBdBpJ+6Ak5n7Gqj5rpCPLCfk3Q
        P5XR3KE8tnXLhQ5lA7mgz1u9YMDkoDzTkS5ReVYEFglkUeV2KdWGSA6uOla5/CH0
        +LQf6xxrRBnGpNg9fLXeYy2FnV7UFkJVIYZTG7gUjX63m69PD0PHJq/3Z4W6+xBx
        YBIf1z4tqeBu94l1wk0kvbt/4dhKNVHTWR/nAOUg9F3lByp5p3xEhuH2A==
X-ME-Sender: <xms:10BqZU-5DD2Jd3lvUmWPBEI3bJBvidiFx1XQvtY1LvPLNNlLUkWhBA>
    <xme:10BqZcv8sQvMd08J6QouebE7FPpy8n1vryna3ODlnALZ7NEEA2HaVYbPDyYREnj_G
    79-bRGGLpyPiUqceA>
X-ME-Received: <xmr:10BqZaBca_B1Ki24sM4eVqlSipvzFstDXAcxmFMnD5XghUdc-Si78M_8FYxa9s72YvoNPrnkJLBAtCcNmldvMS7QVVinROvAFbCxjr6_QeTEhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:10BqZUecUTuIuTt5Gk6kKmrwLXMse3fbQDzYtiCtuGIV-92H4YFgXw>
    <xmx:10BqZZMY33McqneU-XDqa-Bz1Gv-qxQyD-qIwDJ87T_xj-HBLtKD9w>
    <xmx:10BqZekkfGjNtDwbYzf8ugwXFW5IiuuwLhttwJHY-ABk87PyONQaLg>
    <xmx:2EBqZcpcMkAVoFiHty4ANJSo9ZfI5IiBQZozkxKWmuY6f_tkNfOFNw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:23:50 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        linux-kselftest@vger.kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     devel@linux-ipsec.org
Subject: [PATCH ipsec-next v3 0/9] Add bpf_xdp_get_xfrm_state() kfunc
Date:   Fri,  1 Dec 2023 13:23:11 -0700
Message-ID: <cover.1701462010.git.dxu@dxuuu.xyz>
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
  libbpf: selftests: Add verifier tests for CO-RE bitfield writes
  bpf: selftests: test_tunnel: Setup fresh topology for each subtest
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 128 ++++++++++++++
 tools/lib/bpf/bpf_core_read.h                 |  34 ++++
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

