Return-Path: <linux-kernel+bounces-37517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094183B136
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535801C225C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF0131749;
	Wed, 24 Jan 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MG2U1rlM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TG60APR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3D131736;
	Wed, 24 Jan 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121323; cv=none; b=iN1royiKBD69R5zH9GJaU+OG1LAcRDMaIsRRPTYvR+mf+lz4xIVwAtAqMc/qTQZQyWaBFdkVs9h2VJpEdsafCBYKMpdF0WLo5ZjGPcC+zvVlS3+0iCYP38JLFnv6sw/noPxRWygvxOLF89bMEBDkAFykcCjukQcDNUWNnhlONoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121323; c=relaxed/simple;
	bh=HV8WbzLtbALjf0RHVLBi+3NjxnPq8PuBiJQdJZPosN8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QOf4x505paHbHx6RgEFX7h78wTZP24UototGfk3y7S2pDGV2sg+k33AiTNWoKHG2+heIg75+KRdO0yIbmrwS6L6EiDJudDL1moQ5FO76jEIDIkUVb6pyEV3GlI2tEpR+GrQSZSkGLZvh8BJVLxpJv4Muk/AsfgDKx/MgJINTHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MG2U1rlM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TG60APR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 18:35:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706121319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlbYUkWbENWNM1uWju8Uka1amvbOMMDwz/0QrtLWLi8=;
	b=MG2U1rlMEuvXWt4SZfdhMqCz/o19pDgWAv2cqiMmArz7qA1+erMzgJSsh5evpgjj1h/dun
	bc/N/d3hgsoUx78khlwQ9Y0U3zed5B3XHQs6aiUPJoGg3qLCMeqQo+BIcP1ZwXFQxES27c
	szPeQO/bbJoVIBl3RgUId74VqjvrhFO2OaXZMQRhcrpeNL0u7TwJbcv8ERNmfI+cDe3MKm
	V2LPaxuRPqpKSPQKTtFY2gcuWsVsaUSSVywBBNTjJLXPkGt/K0cjIGXwhobzLmZ+NiPEPN
	DcMlOjuYOVgG+xnRbx2mTXo9cx+XJczcq9f2c2gqwa4dH6Ea8zrY5Ih62TkmHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706121319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlbYUkWbENWNM1uWju8Uka1amvbOMMDwz/0QrtLWLi8=;
	b=8TG60APR/+sRB6DWiuUgUxnJG4P8er5aHdDbvgFZISMa3UqfCYpsb1txCVncfMET54Bg6n
	8JKxgvWDvvNHS8Bw==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove unneeded forward declaration
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122085716.2999875-4-dawei.li@shingroup.cn>
References: <20240122085716.2999875-4-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170612131900.398.5223210179509173916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9676635685fe348003a29948d9726e5d9e4b4a6e
Gitweb:        https://git.kernel.org/tip/9676635685fe348003a29948d9726e5d9e4b4a6e
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Mon, 22 Jan 2024 16:57:14 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 16:02:48 +01:00

genirq: Remove unneeded forward declaration

The protoype of irq_flow_handler_t is independent of irq_data, so remove
unneeded forward declaration.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122085716.2999875-4-dawei.li@shingroup.cn

---
 include/linux/irqhandler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index c30f454..72dd1eb 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -8,7 +8,7 @@
  */
 
 struct irq_desc;
-struct irq_data;
+
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
 
 #endif

