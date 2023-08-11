Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE87A7785B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjHKDBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHKDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:01:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201452D61;
        Thu, 10 Aug 2023 20:01:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so1206854b3a.0;
        Thu, 10 Aug 2023 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722906; x=1692327706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nhz2+yXHajZnOYlDCo8CCrQ4By4cAhwFG/S6tJ/BEs=;
        b=evGBOJY0uH1bC95u2uGOJe4KwOvAB0qQH2qgdiN2nSXzdiiAQPSldBdam/bzX3ueav
         Z0XqCNtP4w5PJBGYe6pfoXzA96Of13ehQ/1kQs1VwIB46DIOc4DD3vEI+Jd72QwqWibs
         MYpX3P/yoZWQ7aAn22yROmYOUR+j4fW3ilUKl9UziADz7GBhDRi2J42oQesJHB/R0YBs
         wJ1wsC5oMMw89UA7ojrlKp13EUqd190ewO5WMPKmaQhVKrVN+dDfbqF/LaPOgS36yN2M
         HxHwwx8Q9rdN0asYJbeJnSOJbSu4I/k320CJiIrK61dOd/D1DS4X0FQqvwtTgig6FQnv
         ZaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722906; x=1692327706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nhz2+yXHajZnOYlDCo8CCrQ4By4cAhwFG/S6tJ/BEs=;
        b=llsBFnDLCzSXSp0A2l7uorpPjuDpxIqN87iFgl7nU14sOqD98wi/uORSiAD0Kh2Hkz
         SZtNvv/FnA6dq2rNGrT6NO0nfn4UF2muqtAL8FNPBb10E6sQDV6h+lHE2Miy2KGRQraw
         ovTdODFQeSxP1km/wsp/wYhTkg9CvseWtO+c8UPHcdXaHlWCk5RkCiNQqcI39uNsUUwR
         6tES3kxdPFl4NTxHuIS2MXkBDt1zpBoXgpW291s1Oednjl200Z+ebSFrSdgaxh4mn+cK
         mc66iQC3H0AZW7CEZNBj3sWCJ3B0IwKDH9lwIew7uZBMpzvMcoekFM9LIv/zkWzvieO4
         MkVw==
X-Gm-Message-State: AOJu0YyBS9lQfkTp0HELwIhncXsA1x8YUY6HRWa+FMuh+8r9a0IAJMbl
        5DP4idU9swCVgM9MwWiooCI=
X-Google-Smtp-Source: AGHT+IFbJCCur/eTwLIV0FphtySrsf5eBsyeTX7ML0N0hb+5GtQWsjuzZzT8GXUEXkID1V1c2AVyuA==
X-Received: by 2002:a05:6a20:3d8c:b0:13d:315f:26b7 with SMTP id s12-20020a056a203d8c00b0013d315f26b7mr1011825pzi.1.1691722906536;
        Thu, 10 Aug 2023 20:01:46 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.gmail.com with ESMTPSA id l5-20020a639845000000b005646868da17sm2281197pgo.72.2023.08.10.20.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:01:45 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     edumazet@google.com, ncardwell@google.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next v4 2/4] net: tcp: allow zero-window ACK update the window
Date:   Fri, 11 Aug 2023 10:55:28 +0800
Message-Id: <20230811025530.3510703-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811025530.3510703-1-imagedong@tencent.com>
References: <20230811025530.3510703-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

Fow now, an ACK can update the window in following case, according to
the tcp_may_update_window():

1. the ACK acknowledged new data
2. the ACK has new data
3. the ACK expand the window and the seq of it is valid

Now, we allow the ACK update the window if the window is 0, and the
seq/ack of it is valid. This is for the case that the receiver replies
an zero-window ACK when it is under memory stress and can't queue the new
data.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2ac059483410..d34d52fdfdb1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3525,7 +3525,7 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 {
 	return	after(ack, tp->snd_una) ||
 		after(ack_seq, tp->snd_wl1) ||
-		(ack_seq == tp->snd_wl1 && nwin > tp->snd_wnd);
+		(ack_seq == tp->snd_wl1 && (nwin > tp->snd_wnd || !nwin));
 }
 
 /* If we update tp->snd_una, also update tp->bytes_acked */
-- 
2.40.1

