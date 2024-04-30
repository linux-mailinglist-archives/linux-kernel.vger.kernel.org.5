Return-Path: <linux-kernel+bounces-164183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD98B7A54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1421F23B88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FE17B51D;
	Tue, 30 Apr 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0dYtZZ3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1817A931;
	Tue, 30 Apr 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488020; cv=none; b=tJcfIe3iT+aezY27pOtpTzCGci718c0RKY8AUh4SwmYDl42A6AaR0VeLGT5GzesEUj4whGlke43sc+m0YE1RCKaSihClFC309ZZBgiBxab7p6hjdaLx/lwxAB+NhuiresSQNKa9zJVwN9OPpuMfSqyPehaT1ReG8MKfZSrI/0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488020; c=relaxed/simple;
	bh=LX/cja2FJFFGw7iFNRlpntXAi8MvhPRZ3BEfjetYX9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKBifYl31h1zIAasX1rbAtyojLg5C0l8e1qrW9rr1pnRNFWCar+3IQO/rQim1MzPavxl7QrPlKZdZ+Wyfdz0vUxmGrFrzjn4hXThruLbmUAvCa6EZr9f2JTFxvKlqwJG/vWbasFhmQnuZ5qQ6eMTWU1bIhogQOQEK+2H6o2swOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0dYtZZ3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so53215755e9.0;
        Tue, 30 Apr 2024 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488017; x=1715092817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZxd/DI5QdY6rGwP24LbbxuJiqEuZoi+ZsrSMuiWkrQ=;
        b=c0dYtZZ3BgHiPETbdpKFPEL7FjK5j58ieJ75CDDM1lcJCtgx3f9J8PCMSqrDGRqIl1
         mAm9LVP7QCWrC2JOiFPEuhQrPnnqNR249W9Tu5UPF+7rrAGwaDazoidsUInagmJpwgTv
         +gXHORk8gqBD6NoBGWDRAICkjzP1z9ZTraqjALID+4yaGk16KyHSepNEF5AtXvIgapeB
         yMdz+IUZJfuBnImOYOfDmenlwxxqbFcSKgvW8RSartAijkT8NwMtiHeXywxaSEL5z9oV
         +KDY23FSgR80TbDUAotPqskjGHLnGVebu+MEJpDg0uJgfr5o7F7T80BzQTzjKfZInUHj
         PEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488017; x=1715092817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZxd/DI5QdY6rGwP24LbbxuJiqEuZoi+ZsrSMuiWkrQ=;
        b=vOV9SeVVU8AZVJJQt/uVYnRUxh5q/bCl2yMUG2RNY+OnqpEviMEXu8HkLy41Q3PYAY
         Gpl5bAUajiAVE/Sf1O0jxccPLyP/VIfd2Rqkrm3mjPhk89TshpGV3m4gu7jefBV7gcZR
         T1dBF03SW5i2cpfKwdnaPMxlXsgItPTXfXzvEfgUbK9CBjq/4/YGZ7LVq/mRih4PTwG4
         RHdQOcjAY4gG4+gpZ7szgxLVWBN/qUvATBkIirHN3jD6E01pXtz0T+uY/om70F0P31L7
         FH42I3OLyjYE6RTVS5ffDcVGXa0VlSvZOJRUiS1QB9yF4jNQP0HBCNOoTfOK7+35CzQ8
         fL8g==
X-Forwarded-Encrypted: i=1; AJvYcCWYl7muIuyDnuerJB9PYnWNsZ27ZSOGE8CgHGzYLGrkZAk0rolK1ARftvo+9Pq7qFUbYhnwN+ln2ETki8TYpE9Yn+gMOx2YP6pe9YUzfioC0D0hKbNojDKSykOSKKrPjcPGmksE
X-Gm-Message-State: AOJu0Yw8NxooLfQ2Ph7brPAQ/cZUhoZ859LDxJYRxmxL+9lJXgJ0yBEX
	lXadDeyIgSUPfc/h0g9R4+SU2ywB8eYTvE8Vse7S8zl+mS8G+Drw
X-Google-Smtp-Source: AGHT+IElt5ZeAiVH8HZctTdg1/Kk5OH+JkzF1XzccUyF4Lt231Cmm5evb/2WFVt18/J13+oAtC4k3Q==
X-Received: by 2002:a05:600c:198c:b0:415:540e:74e3 with SMTP id t12-20020a05600c198c00b00415540e74e3mr12217850wmq.40.1714488017142;
        Tue, 30 Apr 2024 07:40:17 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4309000000b0034c78001f6asm10353790wrq.109.2024.04.30.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:40:16 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alobakin@pm.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v4 2/2] net: gro: add flush check in udp_gro_receive_segment
Date: Tue, 30 Apr 2024 16:35:55 +0200
Message-Id: <20240430143555.126083-3-richardbgobert@gmail.com>
In-Reply-To: <20240430143555.126083-1-richardbgobert@gmail.com>
References: <20240430143555.126083-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO-GSO path is supposed to be transparent and as such L3 flush checks are
relevant to all UDP flows merging in GRO. This patch uses the same logic
and code from tcp_gro_receive, terminating merge if flush is non zero.

Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv4/udp_offload.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index fd29d21d579c..8721fe5beca2 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -504,13 +505,22 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			return p;
 		}
 
+		flush = NAPI_GRO_CB(p)->flush;
+
+		if (NAPI_GRO_CB(p)->flush_id != 1 ||
+		    NAPI_GRO_CB(p)->count != 1 ||
+		    !NAPI_GRO_CB(p)->is_atomic)
+			flush |= NAPI_GRO_CB(p)->flush_id;
+		else
+			NAPI_GRO_CB(p)->is_atomic = false;
+
 		/* Terminate the flow on len mismatch or if it grow "too much".
 		 * Under small packet flood GRO count could elsewhere grow a lot
 		 * leading to excessive truesize values.
 		 * On len mismatch merge the first packet shorter than gso_size,
 		 * otherwise complete the GRO packet.
 		 */
-		if (ulen > ntohs(uh2->len)) {
+		if (ulen > ntohs(uh2->len) || flush) {
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
-- 
2.36.1


