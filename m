Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6CC80408B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346202AbjLDU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjLDU5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:57:16 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A2010F7;
        Mon,  4 Dec 2023 12:57:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BEB83580A68;
        Mon,  4 Dec 2023 15:57:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Dec 2023 15:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1701723425; x=
        1701730625; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=A
        gScb7V5WIAslO1HjIrDWIOvb5iJD0GhTZulvOD+5k76bLl/jucRiHMlIu7WfI6De
        bPnTmR7sjhdFLDd2SvI1DdTJs3gRwJAUVW46A1cR7J5HdEG1behaz28XyUgTdD6c
        tvDfCWxGOmOR2ekl8i+yJSBo0pMHeYNns26q32sfztNUFmiR5KFsi5DiRuqBPGPB
        iL0RsqdaY8j4BrXJx1k8hrD7HeoyabdYFdvXn0ulv4HBWlr2kie4HDCPg77lQul0
        nYMzk4BAj7f7mDC3cB9Z5RKHIkh52ziYDGnuUUK5vKB7TBJBICk4x/Gn6Tk836wi
        ukQtLkXsYC0DQ4G2to9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723425; x=
        1701730625; bh=mulrQKzv1eO6blHCVRuuCfG2CgE/rU/CR7wkoBWNDIE=; b=F
        1MPREaGpmSLEewYF+SIQtBc2H3li+0vIj2Y3sRjnMdlfM7ps+UHfEyd2TG8ayUKX
        tPdozUI7cRf7ULWMvF86ox011b26p9y1v56szjGo0tsXZg+kItWKq22If5q8tysv
        wIHZWEADuEa8jcLn4Zpvs9VaTGQgxZSAFQM8dEdzxImnD/ZvZwwWvmTa021AKX7F
        6FMckoe1ba9JDZ2sCKY2+0UBDsfFgfuF71eW0gEFUSgnS7X95YGbNobFOdDUOx7c
        wi2g/BbWzzBeJbTysRYj50KGK1ANeFn1q+GWQBH5qDrUunc9BAYInzWOkLM/c8UB
        34OEgpMS9jZKFQcFwq5/g==
X-ME-Sender: <xms:IT1uZQJv05Y4n80fbX2ZJvf710c9nrGR_EIlxUxYJNJCRKHFFHASPQ>
    <xme:IT1uZQIskIf3UbTVVK8AqmJtPeBBuHFnIHJBTErUeGqZQqEXcYiz_PO41edO2BsIr
    uS3eNsfqVBNdmFtkA>
X-ME-Received: <xmr:IT1uZQvhJIXezOlMkJj6Hp_pbGEwsdaPVg_JTKV56nyIFtaP40FADPKSxt7rZDKzhnh3KUe9Y85mp10ZNKN1Dw64eGNN-XPxIzO7huksrbY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:IT1uZdYf6xd-JUkg5f1o_dLsEbicbZ7mUyLT1YVDf-eH8Y0BmBaT4A>
    <xmx:IT1uZXaWQpe6LMJ3sgLh4FdpQW_n_gZDe5FHhsy064MUJayq1MKlCA>
    <xmx:IT1uZZCwNsSURoqL3T7wrnon24y5JQDnMav1KwMVJegVRLXadTDnvQ>
    <xmx:IT1uZRb2jWrzvuEd27XSj3_NUD7vT9gaGXhcHDdNXBZcqUVmz14HqA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:57:03 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     daniel@iogearbox.net, shuah@kernel.org, andrii@kernel.org,
        ast@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com
Cc:     martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 07/10] bpf: selftests: test_tunnel: Setup fresh topology for each subtest
Date:   Mon,  4 Dec 2023 13:56:27 -0700
Message-ID: <5292165f1f64883b5fc6354a9a24fb8074e3c2c6.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helps with determinism b/c individual setup/teardown prevents
leaking state between different subtests.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index d149ab98798d..b57d48219d0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -535,23 +535,20 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
+			config_device();				\
 			test_ ## name(__VA_ARGS__);			\
+			cleanup();					\
 		}							\
 	})
 
 static void *test_tunnel_run_tests(void *arg)
 {
-	cleanup();
-	config_device();
-
 	RUN_TEST(vxlan_tunnel);
 	RUN_TEST(ip6vxlan_tunnel);
 	RUN_TEST(ipip_tunnel, NONE);
 	RUN_TEST(ipip_tunnel, FOU);
 	RUN_TEST(ipip_tunnel, GUE);
 
-	cleanup();
-
 	return NULL;
 }
 
-- 
2.42.1

