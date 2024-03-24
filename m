Return-Path: <linux-kernel+bounces-112852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F42887F04
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D3D1F214FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D70224C2;
	Sun, 24 Mar 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="tFtKub94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psCJmSte"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804A18638;
	Sun, 24 Mar 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314519; cv=none; b=AGPYuoN6MQlZvRZ+1aoWUGXMtxWXza+mKZjbv6vkEyYWRc6EHZDqTv7bOhE/QzlKFEDzUXI1qCGYHraTCNW0+hPyEEIqTs3pkIasOjRu0a7no0sygILRHCd2VO/+oV2ZOjeI6CocpQjHqtCDqd8O92vToDsQEFp0N0jS1ANpjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314519; c=relaxed/simple;
	bh=+9lyVLF+V8/ecFH+GFD1m49SSS72F78oQ4G9EqPglkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLE/jcCBG1fu0pz5/WhxadtVxXMpcjh2XoC1kWUyQqX6w5LIKVjlgAVTDRZX+YShpZV3STxvOPxZn7GKKBHNaLnZ9HIRef15NF2F5zlFEECyKjrPRoOUOyD+ToOSRmqyG263MJLO5Dk7hUfXRCFD1kUb/kcwmIgm2NwX2Rd2BYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=tFtKub94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psCJmSte; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0FB9413800E1;
	Sun, 24 Mar 2024 17:08:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 24 Mar 2024 17:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711314516; x=
	1711400916; bh=IfP08NkGSU5kw3djwr6jz0i5FQEQ+nuYjW7asb0rxPA=; b=t
	FtKub94hR63Ps2KzHc0L757lTsZnpUWLbTmBqEYnH79JM5g8qjvO/yHF8T0pH/1k
	lOfpOrGSoQBBvpWrAuO9w7B5q9LNSlOcDhWwZLOizGuLHpgt0Q4zwoPqrTar44fR
	gfkCYcvayjPflC43CWrskcriZdkKJt4t+FSYPOR775O4yzSW9uVga4/neivwq7dH
	10H+N9zH6Lsp7BOKvcHj5IzVcwzyEmX5pAvXqGAd/Zjx3ixLL7vfrBO8/TRti4DR
	/BRvUhiu9p5B1oJ/2t/JTmW+N4aNfWWbaFg5sUwTEuQTFXIGqbmbgK7TT+nGFtBF
	JO3TdYbTNO4n4ueB1csgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711314516; x=
	1711400916; bh=IfP08NkGSU5kw3djwr6jz0i5FQEQ+nuYjW7asb0rxPA=; b=p
	sCJmSteQgyVdA2nkXKyySBt4gnMv3ILVFN3aKsj9eB8Y4cLhiAZBCiltZyw2fMe4
	qtCknPhMErUOpc765FxpUBL0/uLtNlrNUoWuMp9xtYj9QalQHfUgO1SrgYCn5OtQ
	MDDqxkpe3zrQJkA7u1OjljuB4w1JeY5FKoo018DQlnDhyr+j4UlO4bHT3+IHywjb
	ZAAgB/P+CpAD2pixvMJo3nj9IU/N34DGvVT1wRTayc76o2N0LRhCm2Yt19fAUOE2
	asOiOAOVKJJFnsmkWvyf/UipTVUEGdzmhL5gGnIt4BS5vSRQk3VqnRM1jae2bC3c
	Eh2vGZlHFNu2DAbWKnXcw==
X-ME-Sender: <xms:U5YAZm6vXRl1SMu21oDTGD-i3IXqiLkGuJrLpDWfOZDQi6H5Biz74A>
    <xme:U5YAZv6h3l12vpRcI7KWu7AFgND1xSUgb9M2sknZeTVvKvugAfSxe-Fsm6UK4pdun
    B6sUyZVliwabGcFjhk>
X-ME-Received: <xmr:U5YAZleF3Y7q86RFJxxYv-qcKX0_D9ZQdPSIjFLoy3Tl74gHovTdAUUPG2-7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:U5YAZjJcNX2f-FlyjkuEcm1QdzqUo738g7MZLdRAWVncbCmb6YOMOA>
    <xmx:U5YAZqLx6NZZorJdstS0RzfNzmQtmIH_sETBSydMLN7yeP2bNDqBpw>
    <xmx:U5YAZkwKhYjUbt7QkBEnsTZs70_YxMrhXwkHkaAKFqZWp8LKaoEI9g>
    <xmx:U5YAZuI7k4B3JmQ9DGLneph04VduaJCRg4lVVCuaYu36Mv0SmBBZpQ>
    <xmx:VJYAZlblMDL0eBqxiVNmS3XqBPd6ozMAO3sjusIrgK29HoNEo7u0VA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 17:08:35 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	hmh@hmh.eng.br,
	dmitry.torokhov@gmail.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	njoshi1@lenovo.com,
	vsankar@lenovo.com,
	peter.hutterer@redhat.com
Subject: [PATCH 1/4] Input: Add trackpoint doubletap and system debug info keycodes
Date: Sun, 24 Mar 2024 17:07:58 -0400
Message-ID: <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new input events on Lenovo laptops that need exporting to
user space.

Lenovo trackpoints are adding the ability to generate a doubletap event.
Add a new keycode to allow this to be used by userspace.

Lenovo support is using FN+N with Windows to collect needed details for
support cases. Add a keycode so that we'll be able to provide similar
support on Linux.

Suggested-by: Peter Hutterer <peter.hutterer@redhat.com>

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Nitin Joshi <njoshi1@lenovo.com>
Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>
---
 include/uapi/linux/input-event-codes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 03edf2ccdf6c..bd3baca95749 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -686,6 +686,8 @@
 #define KEY_SIDEVU_SONAR               0x287
 #define KEY_NAV_INFO                   0x288
 #define KEY_BRIGHTNESS_MENU            0x289
+#define KEY_DOUBLECLICK                0x28a
+#define KEY_SYS_DEBUG_INFO             0x28b
 
 /*
  * Some keyboards have keys which do not have a defined meaning, these keys
-- 
2.44.0


