Return-Path: <linux-kernel+bounces-44349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC330842093
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C9B28D727
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CD60B9A;
	Tue, 30 Jan 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="BlnoyXUn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2I/+iWE"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B760869;
	Tue, 30 Jan 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609061; cv=none; b=goSrOvHZK3xvTqPQhlE2zoA96pPBp4s9RrOC0i88y+U4n7zugGrAPZfhZAM9A8O7e1uzHXjnAI8+EAwKOR0WpZhI9S3fwDdHW9vQHZS3NIIXWiIgrvHxZszbMxd+x9M+L38ZxrokpKOn1+P625tManLLUZJlPmRBQEcM2gMrJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609061; c=relaxed/simple;
	bh=m/LkcmZBG8maNXM0EK5iOQtsBNk2ELexmrMHxsIeoBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8FCY811SD390Cm9haVbAwzdjwR5hFS8kYRFu3DhCjXFrkx1kLnK6PASnxJGiOEN1Hf9igP0QvDVgL6h8ufw/BGMwRAgwU68FmorgzLhhpd46PfunUiesK3oZEshMlqMio10/JgbA1ssDlCq9Gz0L9rMnM/8u32l0L94rCSX57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=BlnoyXUn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2I/+iWE; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 4DA973200B44;
	Tue, 30 Jan 2024 05:04:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 30 Jan 2024 05:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706609057; x=
	1706695457; bh=MOp/NPYsM+2ldtCEODCGojul6SWgm505LlBTScMMddk=; b=B
	lnoyXUnB1EVXKFwwzZevYYGTDkRAco1bAjBdrpyuGemnCRCYTRCwHbfhmqU+LN0p
	kU8BFlr/4CAVwhk5BEpFoJP9r9J7Acv5Nv3lN+M5PLlEIINmbD84eW85WJ7cs5Eu
	NFV3AsMI/+4+fDCXQzUcYCfaaIfyBpESpFddWoqZeu3n+TTr88J/bU+ZcVC99Qir
	p0lQGv11XW79m71IHlHndONB4Uww1XA2QoAuDdHpnx+3JE8CBsPWU6oGFooSNk6Y
	1VIGhJz3ZFklghDBsBKcxXdaQX9j/8HaMBkBZyYHsHj2lV07jL8kKcqCmVwReDgD
	9snneCvz1OR2i/+/dOAyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706609057; x=
	1706695457; bh=MOp/NPYsM+2ldtCEODCGojul6SWgm505LlBTScMMddk=; b=a
	2I/+iWEmMJuG4igywhCqlfSw0tG9cJs00z5KuHQhakW8JFmw0kEzkWa/kcnYi5+r
	WDqCbwIDgWB+QPG5z4cscv8yHNy/UFUmPp5js5vW7SAjUN8C+M2wiiPNCN0JrS6c
	cHzePfquNR408yCW4riQxwmQakoGeC9ywDvaxcnLbTgIddYPRq0NhijaZxp5PckL
	UVIJWARcPQJUm8bytlTEXFpvG6wmcgFs7omwR+mn8+xMcc2wDE5fTHb59g0RNS9o
	tzEyw6xdzO09LkxYpipb4UDR8ijpxNxhUgasUTz0VqQgEXAzKvFeTyihOIhErWMN
	iJWmJb5BAeOXZfgLNPdHQ==
X-ME-Sender: <xms:ocm4Za6nNUN_3c1CF5KNldJKpCPm71cX9OMvqTUAwZrrhhKHRzGvvQ>
    <xme:ocm4ZT7V3JIiRGsJDKMf9VDv6PLybrPX3m80jq1IP_DoINHWtcEK1NT4iAV6Pslsh
    2FZElUJght7WnLZOoc>
X-ME-Received: <xmr:ocm4ZZfXJED85smwRPFrD_xjKUkOyMBTQc9F8ay8AzW5zxZnXlSvNpYlztdw4IvcKBE1LSxjIC4GBhBHMq7Al2AJsdMx8DL8Lx52eAgyVrjD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ocm4ZXLheF95n5djwWER7IOgxcwvsj9RFuvW_XSkMV4H26pTt3NpEQ>
    <xmx:ocm4ZeItYC4f6FlZ3Px5WXxVWM5XKdC98YE3cwe7Q8PjtqGsZ8W3_Q>
    <xmx:ocm4ZYwxa_FpvyCPavxQJKhPlU765Nbvn0Hwq-qsyHNKCCXwK7ZWYA>
    <xmx:ocm4ZVVVWnOOmxd2y46WHz5OnLQ7GaA-AJaJF0OUp6rlplwsQKipoA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 05:04:16 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: adamg@pobox.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: correct documentation of fw_csr_string() kernel API
Date: Tue, 30 Jan 2024 19:04:08 +0900
Message-Id: <20240130100409.30128-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130100409.30128-1-o-takashi@sakamocchi.jp>
References: <20240130100409.30128-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Against its current description, the kernel API can accepts all types of
directory entries.

This commit corrects the documentation.

Cc: stable@vger.kernel.org
Fixes: 3c2c58cb33b3 ("firewire: core: fw_csr_string addendum")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 0547253d16fe..e4cb5106fb7d 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -118,10 +118,9 @@ static int textual_leaf_to_string(const u32 *block, char *buf, size_t size)
  * @buf:	where to put the string
  * @size:	size of @buf, in bytes
  *
- * The string is taken from a minimal ASCII text descriptor leaf after
- * the immediate entry with @key.  The string is zero-terminated.
- * An overlong string is silently truncated such that it and the
- * zero byte fit into @size.
+ * The string is taken from a minimal ASCII text descriptor leaf just after the entry with the
+ * @key. The string is zero-terminated. An overlong string is silently truncated such that it
+ * and the zero byte fit into @size.
  *
  * Returns strlen(buf) or a negative error code.
  */
-- 
2.40.1


