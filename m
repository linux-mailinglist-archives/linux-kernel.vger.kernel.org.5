Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471F380DB62
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbjLKUUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344986AbjLKUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:20:27 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591C1E4;
        Mon, 11 Dec 2023 12:20:34 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C34965C03D8;
        Mon, 11 Dec 2023 15:20:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Dec 2023 15:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1702326033; x=
        1702412433; bh=wvipjySugI619NXNdRelseHYrba3lRKAMvJgNzRoOuk=; b=N
        wgRGCpTOXc3wzmvq1QtNsLHZfWBPf8XUYx+Qkn4dGq47VBctPVoT/F209lSG4pPr
        VnxUGr/PjAlURQCr+wPwSOd8P8d1FrksHxWRyMuRfyidNoNgULXnInnSr52RkKVO
        nQnxD5Kmn1kWsVGxUxpxxRG6rf9lqx8h0nFNcqsFrVes1gLahIpfD3OVQK7wm+gc
        4oxAAu5uWFYB/t8m1H8NLEDxWc/ePA0NG+Az6+KV+foxFqDwoiUYLEbP6cLQB0ge
        /GyTAfHPYz5DBj+oQTXYgsxzh1HOzsx8IUBcdFvE2VuZLxE+jtff1SSuJ5Yh17al
        U5/s449iu8dppjsFLoFiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326033; x=
        1702412433; bh=wvipjySugI619NXNdRelseHYrba3lRKAMvJgNzRoOuk=; b=1
        YRYnJbRbgtCn7zOXPOeJ1usXbCfQUyfJyJlmPd4OkwDkFaqGj1Oy5dioSM2MXsx7
        yUfWfXiglNIW5ijmjRkDENJiwEKjUhbRe+uhjO55EU3YCWTgmGUKuAsvsVMPZgX6
        ISL3ijOBTDrRSVGnb8LuBWPyi8ZeHg6DG5u7OLnD5/VvHR51aitYGKMrE8OF66sI
        xuSnVhAU7/ij5lOpAqlfgIetWyp4zsz/jItbP20mfKe/WVdhMCjSdPFwsq9pGyAS
        wW6EmlVZF9y8tDvJPDQWnThDl7rxewP1gsTu+9TgckYwsSYmubn1x18kUyCkSLxR
        5P6mfvFGTMdJhsvLdgJug==
X-ME-Sender: <xms:EW93ZfN1R2dStXm2CDZLvM6zWcA5mV8TzRmOQ6IXaHqgRz33Z-HfmA>
    <xme:EW93ZZ-mX-sRNS8r5Nf9f5zUxPRHEtWRXb0Zd1WDZtNzJzl429qcU6-WVITzzHF8Y
    FQmYOGYBj7oRd3lZw>
X-ME-Received: <xmr:EW93ZeQjYZt2gnXmXDV-InV7y9iifdswRSENFy7qz0z0LfBMREXJkYFBngOD-ChoOaRQSqA6lJvX8RvM9yHEubXyDQe3GGmL1hVN424Q-eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleej
    jeekgfffgefhtddtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:EW93ZTuMroGTfT3fdqBOM-fpOsSfL7GQqsHC6C-ojOhV4cv0OwtZXw>
    <xmx:EW93ZXd79rUGeTPGLotgno63YwBm3BmsWYkUCv_GS87zMbvxjaMOpA>
    <xmx:EW93Zf0XenFcoBD5aLGWqNT2eIMcLjk92ukLj1ZDRW5W9T_a24YreQ>
    <xmx:EW93ZSDHDmyS7os5m2RMhnqTAMz74oeaTZidj2HoAsy-JUr0BovCeA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:32 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>, ast@kernel.org,
        john.fastabend@gmail.com, kuba@kernel.org,
        steffen.klassert@secunet.com, pabeni@redhat.com, hawk@kernel.org,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com, eyal.birger@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, devel@linux-ipsec.org
Subject: [PATCH bpf-next v5 2/9] bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
Date:   Mon, 11 Dec 2023 13:20:06 -0700
Message-ID: <45124c8da4d96f4e87da540dfe41b3fd7aea878e.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
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
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 net/xfrm/xfrm_state_bpf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
index 21630974c27d..b84adec4451c 100644
--- a/net/xfrm/xfrm_state_bpf.c
+++ b/net/xfrm/xfrm_state_bpf.c
@@ -96,10 +96,26 @@ bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts, u32
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

