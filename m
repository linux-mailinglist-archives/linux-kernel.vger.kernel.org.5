Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806167FC17D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbjK1RzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346550AbjK1Rys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:48 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317EB1707;
        Tue, 28 Nov 2023 09:54:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 90CFA5C00CC;
        Tue, 28 Nov 2023 12:54:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 12:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701194093; x=
        1701280493; bh=gTC80DkbSwec6++klwVY+AjSyF2q8Jrio27MwPjAqCs=; b=C
        aGi8k5sHfniVuQkeLjNo+EwdelKOnWfBnyMb/NMRdFN2srfwApTVGpdTK/n3qohb
        eMw/JDKfn8ZfPFNy3nCGUuarKaN1cjpuIxbTJ/adrtrwGs3rlCv8pL4dHkcsZsjY
        SqSZsBm3a9UO2Vz47jVh/1TuvUgD5kOn6PsJFBFHCyGn6aWwDb/k1sKqF9E7cvn2
        4F60FeOpMXQ2au9hMVsWUDnojnzpa60ZJLi2muhcXN7J99UxGVA7oK1Hy1dTyczu
        WnrHI0Uecqqj4K/WuwloljYHPOb+DmHTlBTFl/XMMUkN73DrxfqXxgxcnc0xMHxx
        naRv7BF5NU0P/VbphyTIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701194093; x=
        1701280493; bh=gTC80DkbSwec6++klwVY+AjSyF2q8Jrio27MwPjAqCs=; b=W
        J3Q6IC/dJzA+vWKAxn4aHyxUbT/H9FEqv/g2vfQYbo/zy1gS5pVTBZF0LYuP18LN
        R6dMSn66K4WVmofy+pKRKy6F18e4UXBpTdm4wO/mlzfL027XpYQx5e4bzUN9x+75
        ENITXXqyEplY3QWT0LJ0cDppvGaKWs5+VMsISd9eJcYZtZcxOI2Cx6Mp5RW7lF9e
        enHuDaCjkAlhIEJob6S/uwr/FbT/5u1WmI/mTXDQmymriX657vRhtMo4z14sM+mO
        uIUtCwcNVvp+pXurm+Y4+73YsXkWM7kPIAsplqsbc2lNNxn9B3zUf/mQqpmctW96
        glw8nkjQd2iACwE17d1HQ==
X-ME-Sender: <xms:bSlmZXrPPg9OnaCbB9vV6xdlnzdGXQH5TM2wD_knaBmFNUHHyC_vhg>
    <xme:bSlmZRoPlERZG1qyogHD3jh0DM7HvscMSFh-OkMSlMdg61zYvrKw7pZIgbUvVVavM
    RnHzMOIxBTCE2V4_w>
X-ME-Received: <xmr:bSlmZUMi9Kfe7wVDHNIQJyHiYW8HqfWMKBlua0dty464FDmvGbo-yXaDhvN27oqOaq1UgFjFNzflreXKFeYH5eC7BFTWBWBPbHb5YMUPYboDFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:bSlmZa40Ys6YEShiJHy4rTmHLl7drkMbF8UUTnCBot5QZNAGLgoyVA>
    <xmx:bSlmZW6G0Mvnu9gXdvlHB1fJXfJN230_hosPrcrCOrscQP9mSZYqGQ>
    <xmx:bSlmZSit3vI8K24uzFDCSx73Rgdc0SBzY0AC_9ArRuu739ery1Opzg>
    <xmx:bSlmZSoSY62OWJ70MT40QjqEiAhZumABMgcvxdSMVu6Uu9d9BqSnpA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:52 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     kuba@kernel.org, steffen.klassert@secunet.com,
        john.fastabend@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>,
        davem@davemloft.net, hawk@kernel.org, daniel@iogearbox.net,
        pabeni@redhat.com, edumazet@google.com, ast@kernel.org,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, devel@linux-ipsec.org
Subject: [PATCH ipsec-next v2 2/6] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date:   Tue, 28 Nov 2023 10:54:22 -0700
Message-ID: <e35bf393128407bf75e9d2fb9dca6c8e31c2a677.1701193577.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701193577.git.dxu@dxuuu.xyz>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
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

This kfunc releases a previously acquired xfrm_state from
bpf_xdp_get_xfrm_state().

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/xfrm/xfrm_state_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 1681825db506..1485b9da9425 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -94,10 +94,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
 	return x;
 }
 
+/* bpf_xdp_xfrm_state_release - Release acquired xfrm_state object
+ *
+ * This must be invoked for referenced PTR_TO_BTF_ID, and the verifier rejects
+ * the program if any references remain in the program in all of the explored
+ * states.
+ *
+ * Parameters:
+ * @x		- Pointer to referenced xfrm_state object, obtained using
+ *		  bpf_xdp_get_xfrm_state.
+ */
+__bpf_kfunc void bpf_xdp_xfrm_state_release(struct xfrm_state *x)
+{
+	xfrm_state_put(x);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(xfrm_state_kfunc_set)
 BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_xdp_xfrm_state_release, KF_RELEASE)
 BTF_SET8_END(xfrm_state_kfunc_set)
 
 static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set = {
-- 
2.42.1

