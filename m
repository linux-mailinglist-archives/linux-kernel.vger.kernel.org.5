Return-Path: <linux-kernel+bounces-119932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711AE88CF12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D430341200
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966D13DDB8;
	Tue, 26 Mar 2024 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="XGYlAMiO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aI0fj5Cl"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376313D510;
	Tue, 26 Mar 2024 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485339; cv=none; b=WI6DgMR5gdvUORMq8ulrdk+Sq/HXPZveVA6MngTJpUoPGzIjk7UX7m9cl1cOghvvB8eSjEkG/yC8JFIEEiWccvj5+LiKkjHQze1emR3DtylDY3ADwKwkhwSbWa5YCaD1KviFmfAjV4ldGVXP4d6qcRNzPxiFuSqowiuqmt2Rzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485339; c=relaxed/simple;
	bh=xixHuBB9noffhm2jhv1K9lQwTkWz2vp8Sl+Mguvz/cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo5v7dTZsiAOJODyP+JU5316ZngZ73e8Btt9L39ozIJO+zb43t+jgAaYG+aWWaK2shUW4XNZORwvZ9mEIPTeblWg/Gb+2TRjNmrQe0Wr5/tcMcBmpnJ5OHbqhCbMClOQkV7w2ea20R54qO47mmV3WZty7H5cXBP8fpRukDF2Vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=XGYlAMiO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aI0fj5Cl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D672B13800CD;
	Tue, 26 Mar 2024 16:35:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Mar 2024 16:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711485336;
	 x=1711571736; bh=8/uARb4oxN4Gs++g1JILLRSCVWyAzodSrqwWbaXbY8s=; b=
	XGYlAMiORBchQc3+ZyyAXjzfRZ48onkJpng6SIzRIE9kU/kZ+qk0uZM2jkZE+Jwf
	mkseYz68PuAHEbHHMSKHIt8VhCnCwYC0W6IEIHOBcd2vIAMwO9bzMlSiXhW9LqLL
	gWY1uuWypKJdlaTnXR7fiASYcTkxTde/sm+tNMUCG91dC+1ACEtznlKBEJX+nrL4
	HWLY43vlM6r15L2K3+fUBiCiW6EWIX83Ds1CzgI1/uzrkmt/ZfQqrW4uSALvMvD8
	WuktG5+9jdaByIspT11iNZo9+toUFUzFN/VSRlYK82OggNXbqhIKnXB2E/24hrDb
	o4B+SahKr5IHGDlupJfsfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711485336; x=
	1711571736; bh=8/uARb4oxN4Gs++g1JILLRSCVWyAzodSrqwWbaXbY8s=; b=a
	I0fj5ClbdG6yixPfdnzlvxqlH+1/+dyIZ9z1NU4BHDipkG+OInTAxYZaPDrXpT8u
	lNOq0mLlhOzk9ZHd16mX9jccovpKdCS0sU3Rqvo7YBrjrGc4e3ZmWMYhnIAceYOw
	XPD3aa3ylGYdTHRpI8eFPY8PRH+EnffyOTR4HZ0rfRfffdCoH8JEdh5oA9JJSbRY
	Lfhg0PRNcxr+4tzN2EBwZ/Wkpkrg952twNJNJPWKKxoxEKAZy7W00GkZLxqsiIZc
	4hmcaza9jJy78/rXV1rZhSGDQi31+hRAeMYi/rwG7XO2WRf5Dg52SfRaXzgQxLpq
	n4wJCWZhXHcQwalA5a9zQ==
X-ME-Sender: <xms:mDEDZgnPibh-dCXmsMBxLC7Jdt2vLeB8_9KCp5BHpeJY_elr7h-k1g>
    <xme:mDEDZv1Y8VRgZGrtzKRf_vNHvbAdlnLduBPztfKd5Txd7NS_-NKWi5DCsNK9cdJ0i
    ncj9mbouEpSNfhPE-Q>
X-ME-Received: <xmr:mDEDZuqJUmfKt5J4aIBbg73sa0mceqOdqC-CvL2vpZcM17-DYd4wdZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
    ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:mDEDZslgqHporsSwprE5xIWk1AFfD3CZWRCDL3SslFOoj5qrQ0Wc-Q>
    <xmx:mDEDZu2PNUTIxKaPJ1d1fePxM33NkIBT2JUU0wt2XcVMiEScZ6dP8Q>
    <xmx:mDEDZjvSf98J8xZZs7vRdJuVxpH2Kxwi5KrCgA8dFKd7nq_1iJ4K7Q>
    <xmx:mDEDZqUWT2s1kF3MIlnazTdvacCWVmMrcFGyC_YxPFBIp5mxu-rdYw>
    <xmx:mDEDZq9HbWYddTTe1f8CrCmCFljTvdBRitQhqnPDoMErcn6uljG1Vw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 16:35:35 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 26 Mar 2024 20:35:33 +0000
Subject: [PATCH v2 1/9] MIPS: asm: Move strings to .rodata.str section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-mips_debug_ll-v2-1-b64abc76f2a1@flygoat.com>
References: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
In-Reply-To: <20240326-mips_debug_ll-v2-0-b64abc76f2a1@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=560;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=xixHuBB9noffhm2jhv1K9lQwTkWz2vp8Sl+Mguvz/cg=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRmw5mTvzVPYF5eYsSec1XgjlXrRL5Ak33SJyS93Dt+W
 wst5bTqKGVhEONgkBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIlYJjL8T2Y65Cw1d4Jzidfd
 pN2ezR5NuSsW//5W/KKM89DDKXu7ehkZdpyU6C1pnDiZ/Yzji1+LtYzPl2iLSc/4Puvywz7ZfdM
 OMQMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Well, they are read only.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 2e99450f4228..05a158a8920c 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -94,7 +94,7 @@ symbol:		.insn
 symbol		=	value
 
 #define TEXT(msg)					\
-		.pushsection .data;			\
+		.pushsection .rodata.str;			\
 8:		.asciiz msg;				\
 		.popsection;
 

-- 
2.34.1


