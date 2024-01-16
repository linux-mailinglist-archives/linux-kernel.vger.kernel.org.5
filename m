Return-Path: <linux-kernel+bounces-27338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403282EDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159C01F235FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544291B950;
	Tue, 16 Jan 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3Zyu9bI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B401B7FA;
	Tue, 16 Jan 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337bcf021a4so232513f8f.0;
        Tue, 16 Jan 2024 03:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705405226; x=1706010026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YewKcZq9ai29+XsmmSF+19VjOQg1O5xe25ZObecFqLE=;
        b=N3Zyu9bI+zCT95Vu/LB6uD0u68yaR4P2uFFV4diciUnGkfcJB7Dp6/uxV1U4rpZfMV
         6A2htaoXypHxOCoSv4ihRyEGGVGO/PDN9VzrV/ypQaHZu22kKed9ydFDBd0m3cWi2u3k
         3dkL89yPN8syVeVCLOi4Upv+5MvfZMmiztFt1RP1z8sltWAS0QssQdukWPd+M46gU7B8
         SP8mcFNpXHqTb+6pSZP3Ww5oaw/IfKsulsJXj2FavE852e/5bcLAFzWWsUEtDlTSs8xu
         REVKh58EIzeR1wX3eN6NotWSLiUOmLV2B/ed6v+3LFDHgLzNh9bSjPhpcXbxUQcpR5fk
         S49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705405226; x=1706010026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YewKcZq9ai29+XsmmSF+19VjOQg1O5xe25ZObecFqLE=;
        b=eLNYpOyA6Yq5BNULh6LbnWqDBgN+rISnDewYK3nZw20SzCagpptCi/1iA7D6s2PoXn
         yWSVQEaqdrcft/Xwn8j27bE+FR3g5hx/t6UCyN+fudDbKgWuF/oEagW+jwY1bCmUIwcF
         7TvO/HQ2Gyx3NvZUsIr+Fd7l2lVIs6yDg+ChUHs0+u3clYH2gGro7fkhOXQlYQAp9Em+
         MS75PNHSg+SOWn97DxkvOoG4nr1gvwCv5taoLLo7+JVXVujzIvCw+1G9itvbqQVJeJRt
         ad2MzdioOI4N0nPSZDAxuE6NIZCmFXdzYRMNtYsnVSNf+d6DtN7lR6Ek+/Ap8+bp4VQ/
         Ucbg==
X-Gm-Message-State: AOJu0YxBuHdKxYb/DUIFkGnlvO7DSmiltYqVnXmAAhhQUlSQeZphOAsw
	E/NOg2XkL4lcD1moR+mkwfk=
X-Google-Smtp-Source: AGHT+IHH3ucOcfJNtDsU7uoU8keEu9FHuynpSArvy0s7B0SFF8LAXUKnsdfcHR1e5N9g2xT/ItKvhw==
X-Received: by 2002:adf:ce0f:0:b0:337:3f58:e305 with SMTP id p15-20020adfce0f000000b003373f58e305mr4224383wrn.39.1705405226415;
        Tue, 16 Jan 2024 03:40:26 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d6641000000b0033609584b9dsm14446304wrw.74.2024.01.16.03.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:40:26 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Elder <elder@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: ipa: remove the redundant assignment to variable trans_id
Date: Tue, 16 Jan 2024 11:40:25 +0000
Message-Id: <20240116114025.2264839-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable trans_id is being modulo'd by channel->tre_count and
the value is being re-assigned back to trans_id even though the
variable is not used after this operation. The assignment is
redundant. Remove the assignment and just replace it with the modulo
operator.

Cleans up clang scan build warning:
warning: Although the value stored to 'trans_id' is used in the
enclosing expression, the value is never actually read from
'trans_id' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ipa/gsi_trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
index ee6fb00b71eb..f5dafc2f53ab 100644
--- a/drivers/net/ipa/gsi_trans.c
+++ b/drivers/net/ipa/gsi_trans.c
@@ -247,7 +247,7 @@ struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel)
 			return NULL;
 	}
 
-	return &trans_info->trans[trans_id %= channel->tre_count];
+	return &trans_info->trans[trans_id % channel->tre_count];
 }
 
 /* Move a transaction from allocated to committed state */
-- 
2.39.2


