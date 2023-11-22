Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590757F4F49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbjKVSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbjKVSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:21:13 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD4A2;
        Wed, 22 Nov 2023 10:21:10 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9102758071C;
        Wed, 22 Nov 2023 13:21:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Nov 2023 13:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1700677269; x=
        1700684469; bh=FuK4bS9tTFjezD3GdPwdW0QDdO9NNWltDhOsenLHkyk=; b=B
        +X9C77JGH3b1jTsp6qm22PCvhJHboU5I/AIyQsdtB9+1Qy66Kd6gmgDVGi7QCjg8
        axDkALIr3THvEO4neF5rzKw6uMDZ+HCdRTIk12UDDj3CYdpy8LSBdCoIHGmKS4I+
        e+A2CLmQvixxmunJaeu9vvvDaI+A9jTFxXv3bPqKexp+SGalgRnoFDyS2YOIETkM
        czdl1wVDn0fKAcd6wA5gj/9qr47QVFBYZrdHNQSmv+cfQU2ez7Pni2BB2JRsY6/u
        ZcItv7XBi2p7w1HAlzXDgHWnlZgS98dh3zYYu0sKY4xgzZXzQqk0dtLDXjVUmP/A
        LdqTfaSIc3Zp5/amSXLKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677269; x=
        1700684469; bh=FuK4bS9tTFjezD3GdPwdW0QDdO9NNWltDhOsenLHkyk=; b=X
        xsmaB38ivKpsZWBP+/F0rQNi4Hd/4NUJJFChk5ZSYlKyu92A6/13jn09nEJX652p
        o2uw33xx1iMo81dEUOLGFX+jUzA4dPEmaTRkz/M/YQSCR4+gOmSzHmnoZgQWZ8bH
        9i55uwqFLhi1MPrTAyCpVwiGxha8ysPuonbBcv3OY4GoxCMftxcYP6HBNa9fxuEP
        4SJN2B3dx7471qBk4NH/O9SNYHJY0x6klCWQLW/VKM40OPvD5sQc3jKvBaTY8zr8
        CzKeiHOUwcyduJpvpPAm7I6vLaGRsQD0EkWD9nN4klnnUTi78Avd2HqvxEFkJMkW
        EkGFIbKEWhxuN3SPuB5sg==
X-ME-Sender: <xms:lUZeZbxRLBQ2rStXg-zzyE3ATBwRHZ_ACMXjWrCYVd4iRDssV31miA>
    <xme:lUZeZTTRkxG9H6PKSGOaaT2Tol8ZTtwWGn7iOTbMk_tUospvJPkLabowq30JEuspN
    v0cOosnFe6TkB3yOg>
X-ME-Received: <xmr:lUZeZVUjNTWth-ERQVBEfQFSSwLdbnkLGVXnhkRsWxMne_mLX4NxoAUO3yIXxNB2tLOAeIyPEc4liiIWnQptJDJCqOFXCAMmbSZ_iuV97dFuQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:lUZeZVjVnfIgIby6ZPRyxzUFoN10_RZYyHzQpjBl6sUlRI4GmMFJfw>
    <xmx:lUZeZdCqRFQSKGptDzS3fXIplyqNKN0yLK1LSHxBGOFiez5Rql63Cg>
    <xmx:lUZeZeI2Wusn5oPnUfV_89dAA5tTEd9rpxLN-TvVI_n-e2iNfzrXSg>
    <xmx:lUZeZcV5HpZepT61911RSEfDbgKQhne8tLOl0VebSKwsx6fMKmuaEw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:08 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     shuah@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ast@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable CO-RE relocations
Date:   Wed, 22 Nov 2023 11:20:27 -0700
Message-ID: <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
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

Switching to vmlinux.h definitions seems to make the verifier very
unhappy with bitfield accesses. The error is:

    ; md.u.md2.dir = direction;
    33: (69) r1 = *(u16 *)(r2 +11)
    misaligned stack access off (0x0; 0x0)+-64+11 size 2

It looks like disabling CO-RE relocations seem to make the error go
away.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3065a716544d..ec7e04e012ae 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -6,6 +6,7 @@
  * modify it under the terms of version 2 of the GNU General Public
  * License as published by the Free Software Foundation.
  */
+#define BPF_NO_PRESERVE_ACCESS_INDEX
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-- 
2.42.1

