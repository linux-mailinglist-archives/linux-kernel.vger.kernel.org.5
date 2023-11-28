Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B27FC207
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346660AbjK1Ryt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjK1Ryp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:45 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306541710;
        Tue, 28 Nov 2023 09:54:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 412505C009E;
        Tue, 28 Nov 2023 12:54:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 12:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1701194089; x=1701280489; bh=FjP7ejQHFE
        0z5ThOzRjLFxTQyIGpyVo9B05Q7w9eZpE=; b=FgQ9rBAeNZ0btzk/wx2ncsWp2b
        BPP5CDQ4I/RCQbLrznq924GuHcyGIMqctjjpp6uoWU9q8UjoxE+xxIYQddVUchvY
        6YZjofdT/M6Hq0TuisenRa6IpRtLTo2x1sQ3lOZ/UVn3s8wQ87wTXREV4I0t8HYp
        nTccLEz/aqTV1OJhj4khRZegn3sQsquOXqboNoyBxWrcQjpIvlkOG8/PQqBXoU0o
        s1FK5XUPvg6oK+BmAXg6KzSdknDtAgDz8LSLEYH6dh+/l/VHxnXoMNhOBHOt5ce4
        cHanTViTMcbo/6t9hN4MZxsNc7P13zfoVs/FDgYJZTAlpWEgdUKVia9eouxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701194089; x=1701280489; bh=FjP7ejQHFE0z5
        ThOzRjLFxTQyIGpyVo9B05Q7w9eZpE=; b=wGBILsJv5W9f56TAXM2r7CI+wXMWD
        JvFjad2ohIJAt/u1QplnXAhblqkIdF1VR4O1V6QZLtDF64ItOs3S5QsOj/gVZ3sF
        GfpCk+cTuRpQ5PrsYBTjZOcfFnEKNK4E8mKEJf6SkK0iHC7wweeHiK2xiJqkAhE0
        uIG5GtXnd5mPvDOcR/pG8Dsz/6qiH2FqB7eBrE8vo+omtFPuVKiDNxloJKpe+16A
        tReIJafyFoXBS+bQFZP1vT9hOeZuIg/y6wOZZ6/uUa1/NptiZwA30ahA5Wdapad7
        XInR5E0ftzStOY/gRpYK+aYDgiiwdmurfuH0EijVrX9Ahz0hndEnJvvRA==
X-ME-Sender: <xms:aClmZdV7vjRDSM3dt7DkssVxQwZmtBinoVL74hKtUn-ZPxmyVN-Pdg>
    <xme:aClmZdkzrr52FbHDzFLmL5QeTST_QswrhwZ01orZq8xpiGEPzc8x8GaYRMuvHPfVZ
    nf2hiXEtqAserWoAA>
X-ME-Received: <xmr:aClmZZZhLaSaM1LBCFyRU2Q0gJM4NSy3pDAmY4ZCa2AFWWgO_vTfoeEN4hxqkvDW-VE1ArvBn-w1vfiUdxu1ZiZk5Ox_3cZ1k9A5brf--IoKsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:aClmZQW9Kvw_AMEAedzkZ0LSJsdAnmhXAOHwwaO2vGMj01BwffF50w>
    <xmx:aClmZXm95JbzU-5jv4sLIMJIpKtCv46YIAxoC0HnF0sBIt5kJMCN7A>
    <xmx:aClmZdf-Edw2xh3eU1gk7PujVulbGZjoXOox7RjzA9UR9Jeybkdjjw>
    <xmx:aSlmZQgprf94_masvagbmK85pqD_LJYUEmm7PcBXA-TKlBL4upIzMw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:47 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     netdev@vger.kernel.org, llvm@lists.linux.dev, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        steffen.klassert@secunet.com, antony.antony@secunet.com,
        alexei.starovoitov@gmail.com, yonghong.song@linux.dev,
        eddyz87@gmail.com
Cc:     devel@linux-ipsec.org
Subject: [PATCH ipsec-next v2 0/6] Add bpf_xdp_get_xfrm_state() kfunc
Date:   Tue, 28 Nov 2023 10:54:20 -0700
Message-ID: <cover.1701193577.git.dxu@dxuuu.xyz>
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


Daniel Xu (6):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: Move xfrm tunnel test to test_progs
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 +
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 128 +++++++++++++++
 tools/lib/bpf/bpf_core_read.h                 |  36 ++++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 155 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 138 +++++++++-------
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 -----------
 9 files changed, 412 insertions(+), 150 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.1

