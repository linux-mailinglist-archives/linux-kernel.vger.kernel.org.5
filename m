Return-Path: <linux-kernel+bounces-151688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E28AB20B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0DF28133C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7FA131E4F;
	Fri, 19 Apr 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTCtZ/rD"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444912E1E7;
	Fri, 19 Apr 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541007; cv=none; b=AXPXSlZ5XzglfLCGa31YumU3ZqdtvPCydyYQy5tmXKXfR89gNJu3FFgW8Q2dbevV6iaSRAyd4ZhOr5+CyubJr8sKY0GUM/GMKVja4I0Ks/L/9dvZcZT+viSCmM+a1Gq5j4hOaWB70egl8F5JcvPC2kYhZB9WKybb2hRYLHwlDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541007; c=relaxed/simple;
	bh=bXd2cF1r5wGgGn8qjmQ3gV0VuKXhxZccccWQSzrZm9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kg3g7ZZVAskH32H/WEQbaCXJNKCxvd8f195wXQ0q9MCD6KdsP/n8ggHlM3zbR+MY8waPByRDNy0ARBNXxGVZNBhNUpCy6G0+lEKDFThT9fp6P1YDDefMw7GlNYkE054SOnS7vRPD4FzMsdgmSYb5BhE1uvonJdvzIA0Ca82AquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTCtZ/rD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34a7e47d164so287928f8f.3;
        Fri, 19 Apr 2024 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541004; x=1714145804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBCxnbysmOgF/ewLoKlev2MPx9AEH27+l/wXXPvFzlE=;
        b=hTCtZ/rDjFcmpsxKKEFGcRQ8OivwwbPt5Qk0CWkrMgqojFPLVNgxswXfPkbtdX4aVO
         m8vtNjLn87/eA8w0tM63PCTnVc7dSUKmgjvoUkRdjA1hbisDyQwEFVKesUrINn9VU1p4
         Q6z1v3ZM3SFJZ6kS5XpN0gM1S1RwmnvXhTjYu2zG+n57MiUkmlLT9tynEdd9sgAkxD/O
         RWpodTSgNPnyXxvNQvtqjCeUDz4T3oWHHpm8Iz86MFyNQ/1qxLeuI8/xyNqyvS14+SDD
         HsyD5l8oa2dO/L3j3e6NmeFT7W1oSJSr5KInxPuvb4ZQ50sPtqwJQs4xI8avWOPIQWR9
         eNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541004; x=1714145804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBCxnbysmOgF/ewLoKlev2MPx9AEH27+l/wXXPvFzlE=;
        b=miUnJ4lEtQB4gIfY46dwapmecGN1XjuowgDKHker9qGlvc+nA/ulLhd/s3Xfa9J1KZ
         VFUavhfH8sXJlQmZFiQJd0fo8vkVy/IdDMc7DBdiQsInwFvE+9BEh1ObjOjHQsgWzROI
         e/AV7ViMXN2Q8FAcHbIe6VQ3UOQrjzczjT/Xce0vgOONrHWWjyrAvZiP1H24cRhfm7jp
         DlNgn8I8/Dfhn2li4+x1ntL+lOZExLDYYREk2wYWqw2GFC4RR3H5aZjJs+4vN1QjjLdR
         A0KwY8yyZYcDs/8qg/Mo6xQxcRWewLWDFsx65ScYBmkesJleof62rC7d7tAWumlAqTCN
         WjFA==
X-Forwarded-Encrypted: i=1; AJvYcCWKIe16iGbmQV1EiYhjvRJHKguTVyaSl1ZZ3WB4pDmUMP7CI/UOOgQfCJTiDlUWeVzUjj4eor8d9g+YqpRGq6fz3fRILQ6J2B4n9JV5Uxly6qEA55x0aH+xUIMuKDgZAJHi73ej
X-Gm-Message-State: AOJu0YyMLO/Bc/1JsYhmCia3OD2JAo3hqoGyQgRXYk8jRIf5eZVXOfF9
	p0/AsLWVH2CW40y5V32d28FD3qRPt5Ai5uaoZZ2S8xgBC47eIHfm
X-Google-Smtp-Source: AGHT+IEEsUl+sziq8fG2MR4CX89/a844zgARc3ht6bS6rLiL+jkcyfjhn1daKZQG4bY/FTJ6M1A14Q==
X-Received: by 2002:adf:f9ce:0:b0:349:bd11:1bf1 with SMTP id w14-20020adff9ce000000b00349bd111bf1mr1690575wrr.46.1713541003830;
        Fri, 19 Apr 2024 08:36:43 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id u17-20020adfeb51000000b00347321735a6sm4693773wrn.66.2024.04.19.08.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:36:43 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net v2 3/3] net: gro: add flush check in udp_gro_receive_segment
Date: Fri, 19 Apr 2024 17:35:42 +0200
Message-Id: <20240419153542.121087-4-richardbgobert@gmail.com>
In-Reply-To: <20240419153542.121087-1-richardbgobert@gmail.com>
References: <20240419153542.121087-1-richardbgobert@gmail.com>
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

Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
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


