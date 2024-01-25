Return-Path: <linux-kernel+bounces-38667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6675483C3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D431292B1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D256767;
	Thu, 25 Jan 2024 13:41:16 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B94503F;
	Thu, 25 Jan 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190076; cv=none; b=hdAzTqlzQOefus8LhoPFJ90IOD/ajLc7dPHiK2tPxKeoQkKaDYTsDPhubdD/1D/8n+HlwOy021j9P+xssiUTxIebVVe88nO96ozlQt50tcGLwEFRMPA0LjvhK5V1ON1NQamINJFFwQx2N6o0Udk5VHpWvWavyHYWRQb6ZRIU1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190076; c=relaxed/simple;
	bh=s7thh3IrEnKt/va13x2HmHZo7BtbjpTbPqnPXSHPl2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NYmXzRRLO8D5UFcZu3pHOU9ILoHHw8k55rcikKfryA0ITHaXVaEFyhPVw4E7tjgSGI6wEEsIDaTDPeR49j0uiy/sTwHj+4bObupZzkMR1s1IxxfJAnnoq7n+381Pt8s81v0qpVpHoArl43RJwFl+whdLF1mdkuHVtwdyRc/vjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3150c9568bso162729366b.1;
        Thu, 25 Jan 2024 05:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190072; x=1706794872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xIHT2FEEOX1ZJah2HSsYQgk3eFyVlJ0iWR+awgo71w8=;
        b=d+kyXPbLJWlwEKLPXUsC9qrziYp8r8J9gbr5sRhWIwAkDjcCh68OjtoGsxxq2KbUn0
         J5zRCYkEdNQDlcdesq/4nDCmcDqpyVA99EJSUGdxkOjsMqAr9Yx4EzTGdfXUF+0YXZ2T
         wcEtK7psgiS2QHIHRGjP6p/FGU52nUgnaSu9sQd96esbhoaBQP2uDG62QAo0vwUzzDGy
         In7f7KuoQyPt0OR0FhuiAEDXDFcTWwacecaplP6qaiD+bfoWrhmc5uuevPOkf6g0ZGSy
         mopC7bjvOjEi1OKGNx9iqviXLsJnhzY7zr9HOogTCGazBFjF7tMnkpyZUSF3z+WTBr7s
         DWcQ==
X-Gm-Message-State: AOJu0YyHhizM6iBVZEitfyIBtstWiIaECLS/fbz4LYKBgaj5G3++szJe
	bzWVKWSQmciovMrBoJd+Tj9MbnI2XOV3G2qSUAaM976flCa4CUa4
X-Google-Smtp-Source: AGHT+IFrrc6UlUqnrfe72DtQ5Nit/8WYSmUDgAp71S3LZyV5+TdHGbJ/kzhuo5notPN5hL/jCgl51A==
X-Received: by 2002:a17:906:b78c:b0:a2e:81d4:524e with SMTP id dt12-20020a170906b78c00b00a2e81d4524emr396447ejb.12.1706190072282;
        Thu, 25 Jan 2024 05:41:12 -0800 (PST)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id hu22-20020a170907a09600b00a318b8650bbsm471832ejc.9.2024.01.25.05.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:41:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: pavan.chebbi@broadcom.com,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: gospo@broadcom.com,
	netdev@vger.kernel.org (open list:BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] bnxt_en: Make PTP timestamp HWRM more silent
Date: Thu, 25 Jan 2024 05:41:03 -0800
Message-Id: <20240125134104.2045573-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 056bce63c469 ("bnxt_en: Make PTP TX timestamp HWRM query silent")
changed a netdev_err() to netdev_WARN_ONCE().

netdev_WARN_ONCE() is it generates a kernel WARNING, which is bad, for
the following reasons:

 * You do not a kernel warning if the firmware queries are late
 * In busy networks, timestamp query failures fairly regularly
 * A WARNING message doesn't bring much value, since the code path
is clear.
(This was discussed in-depth in [1])

Transform the netdev_WARN_ONCE() into a netdev_warn_once(), and print a
more well-behaved message, instead of a full WARN().

	bnxt_en 0000:67:00.0 eth0: TS query for TX timer failed rc = fffffff5

[1] Link: https://lore.kernel.org/all/ZbDj%2FFI4EJezcfd1@gmail.com/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index adad188e38b8..cc07660330f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -684,7 +684,7 @@ static void bnxt_stamp_tx_skb(struct bnxt *bp, struct sk_buff *skb)
 		timestamp.hwtstamp = ns_to_ktime(ns);
 		skb_tstamp_tx(ptp->tx_skb, &timestamp);
 	} else {
-		netdev_WARN_ONCE(bp->dev,
+		netdev_warn_once(bp->dev,
 				 "TS query for TX timer failed rc = %x\n", rc);
 	}
 
-- 
2.34.1


