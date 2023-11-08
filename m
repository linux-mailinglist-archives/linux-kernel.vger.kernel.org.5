Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D57D7E54A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjKHLBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjKHLBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:01:02 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D299E1BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:00:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507adc3381cso8746799e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 03:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699441258; x=1700046058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RdWI5Otzj/22CmXWTC0LvstaBILxuomd2KxfErMzrE=;
        b=Dn8YfB6otazAqK+5hS7E9HqmNVRnA9FrMWIjRU5CLMnIwQui7qrYud0SMKBL/1Iskc
         ba+J3Ukz6ZPHiL9RbD5YtRUR+23o+X99Td9p8s1abhP2THoMym68KneROuQ4+GJs33s5
         4l+6/kPbLLnkOWbM3Taxtqe2aLnKgdPaIecN0JS7EGEa+5kog/nBidT4K2+Fk1InR+I5
         13pqIqg5MH1ufZCGqvl6YnoT+QuxrFgcuHsOPcaniy9miIOxJ2L3e3Xty5E9GziommZf
         o3LeHXNePduIuk7Lv3MmzDCjM74R5VSk3eFfcZbGndWwRA2ZzSJhA+sTXFg7H0uVV8Mu
         eFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699441258; x=1700046058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RdWI5Otzj/22CmXWTC0LvstaBILxuomd2KxfErMzrE=;
        b=gDuUjQkELoJAAZUNaSlwhORZ4RmXiWl7H1jL6AT5EBiK4VzMU5pTJx3opxRjNKDvR3
         emd1J5XPCbq2qWIuzsb4wpgR0c6Ddw+IwVNHc4ABZSPj1CTjyPTRx82BJWX7UVTvHqqU
         EJ2MY7Fb4KMtIkSfRgb+h5glWK1DAwmRHzjIqsNQmPAqPTJfG4xmlIovkyyZVSawG01z
         lhZZxo58ep0Sqa88tNr6EOWjtPq5Q0rYQeadW9c3OGjtvgyFmoAZJxD17izjjoMDwbiz
         FlkphOxWGQGWnk4CKYZB7hOoWfz80j0/Gy0gsliJyGHVmiCncekpxuKEog6kw+4P1O9K
         FQFA==
X-Gm-Message-State: AOJu0Yw5dr/O2jTMuM39bAF4/YH9R0XdwXqxFyFAYAlE/jszQ6dU1L94
        K2dAysVM1RIdoLuMneqR7swtRg==
X-Google-Smtp-Source: AGHT+IF/QT7y6mmtdbC3qDd9Bu2J9wX51lY1OjPWxmAl63DpQNTQLt3kUbIV9xOmqprPINgAZ7sbSw==
X-Received: by 2002:a05:6512:3497:b0:500:79f7:1738 with SMTP id v23-20020a056512349700b0050079f71738mr866908lfr.17.1699441257985;
        Wed, 08 Nov 2023 03:00:57 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512061200b00502ae64f46asm631443lfe.126.2023.11.08.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 03:00:57 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, andrii.nakryiko@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
Date:   Wed,  8 Nov 2023 12:00:48 +0100
Message-ID: <20231108110048.1988128-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crossbuilding selftests/bpf for architecture arm64, format specifies
type error show up like.

xskxceiver.c:912:34: error: format specifies type 'int' but the argument
has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
 ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
                                                                ~~
                                                                %llu
                __func__, pkt->pkt_nb, meta->count);
                                       ^~~~~~~~~~~
xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
 the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
 ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
                                    ~~~~             ^~~~

Fixing the issues by casting to (unsigned long long) and changing the
specifiers to be %llx, since with u64s it might be %llx or %lx,
depending on architecture.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/xskxceiver.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 591ca9637b23..1ab9512f5aa2 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -908,8 +908,9 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	struct xdp_info *meta = data - sizeof(struct xdp_info);
 
 	if (meta->count != pkt->pkt_nb) {
-		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
-			       __func__, pkt->pkt_nb, meta->count);
+		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%llx]\n",
+			       __func__, pkt->pkt_nb,
+			       (unsigned long long)meta->count);
 		return false;
 	}
 
@@ -926,11 +927,13 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	if (addr >= umem->num_frames * umem->frame_size ||
 	    addr + len > umem->num_frames * umem->frame_size) {
-		ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
 		return false;
 	}
 	if (!umem->unaligned_mode && addr % umem->frame_size + len > umem->frame_size) {
-		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
 		return false;
 	}
 
@@ -1029,7 +1032,8 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
 			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n", addr);
+			ksft_print_msg("Last completion address: %llx\n",
+				       (unsigned long long)addr);
 			return TEST_FAILURE;
 		}
 
@@ -1513,8 +1517,9 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	}
 
 	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
-		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
-			       __func__, stats.tx_invalid_descs,
+		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%llx] expected [%u]\n",
+			       __func__,
+			       (unsigned long long)stats.tx_invalid_descs,
 			       ifobject->xsk->pkt_stream->nb_pkts);
 		return TEST_FAILURE;
 	}
-- 
2.42.0

