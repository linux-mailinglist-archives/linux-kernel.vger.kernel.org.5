Return-Path: <linux-kernel+bounces-166264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA78B9843
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910C01F2147C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C856B7C;
	Thu,  2 May 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="lfmm31AC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4dY1gmm"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6C4F88C;
	Thu,  2 May 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643980; cv=none; b=Tit8rGqiYVmb+gKGjmvXqf8dwHZGpK//TTTh+VH0MIYB2V8GOih6db3VqR6BBHG2L+rSqCVaOESZ4C+nVtnRxFvqrUBIndW334FiIKslQFRW/ZWWRBfwZV0qcc0NcFaO7aPgwutYyTVyNmTlt753rcCDrqz8NPqUmanT+ZfYS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643980; c=relaxed/simple;
	bh=QL9nuqQoyyNsWN3gxQVMz1nurlN4CBrHLvpqKsCC2dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ou+uBcT20kEYq8JV9xzi9o4sXb8De6669eAIh5StrQh5w8UbGe/63qwQV1djchRuxuJ0ZOWnzyU5YTxHlysQPQiTBQSWDEb98LfmeUBrTEni0gPTB6dCeFZowFvUewUbYm7F/4Nrg3+5Qtc1A4N7rC3P4WJVYnRz2kUpGQZBP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=lfmm31AC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4dY1gmm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 709B91140169;
	Thu,  2 May 2024 05:59:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 02 May 2024 05:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714643977;
	 x=1714730377; bh=0pbruEW72n0bzaIHzN28DENnlP2MFUGMO7lTKWW+W5A=; b=
	lfmm31ACJ2DVi1t2IrrXmX7QBOeCSxA+envPgYI1oMOXCd50KlijnsOpWZMlfWWW
	6TnpPvCzNDWbph1Eh8rdl6yb+710Le1vlMymdNLG3uEltgOETzmWMVwBu7zKe18c
	2Wp0r5r+Hr+UN4kj18LUaRxKDuh5VcTIpiasvxDpC5dBxg3MYxlPYGW0lQ6mCHu9
	XNPC7mJjOkmqYlhyEsk/bOfwzQDTlry9kEBKWJ6ktw2mlicThV2EmWMDUP+S0Z3d
	lXdICdOfUvXfbYlu/ShRVD7UKl3I6l7DKEtaRCNAz6b+VAZMY9s1M5Vt3mWcJn/o
	ggdBAJc7J5FsQHVS65XJcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714643977; x=
	1714730377; bh=0pbruEW72n0bzaIHzN28DENnlP2MFUGMO7lTKWW+W5A=; b=B
	4dY1gmmw5p0+6wocyTFOICLRPIo/nhpDqT5IVWDuVJr77dwGOjZ5EKQiLaHSNIHF
	e13n0nQRhoNi+YrBB+WHLX5esap2EJfSyh9erkX+Sr28v/sF63SC+c2T5Fsdrfjr
	0ZdR64l4cMMQ3IPIREKHkMQc5DBFeZzMHvqHkeUuqtPFWaxDvwsE96/98OUXZlJd
	XN08wZC30o2INAli/2PJ4gWaH7utRrff5TrgAdnQZtv9MOGR7bGgHafKBbxBZ2fj
	t9jjw66mweIEWg+MdbgW0EF9TwO4hoX03Q2WOAu4AnKUyJ53BENwBBBsqzX443eb
	5HJArH3TN1J7naYG7oG0w==
X-ME-Sender: <xms:CWQzZqEuYEEVDzCAhLq7DqJIe_56xJY98wsfecmQDS1eHcpk5qtU-Q>
    <xme:CWQzZrWcOiKfdrQ2jtXIrJ_HxW0YTA-_fnzlRLtguZRbgz_dOrHJMTDMziTeUE-eg
    Z7mSgxxsfq0ecuyTMQ>
X-ME-Received: <xmr:CWQzZkKv-599J2IEWEYMnQRyb4FRvHPfDpXDGiY3tvJ2Ykttwh5c4Z4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepveevteehgefggeejkeejtddtteeuleduheevjefgjeetvdfh
    udegtefglefhveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:CWQzZkFXWk9oJyxDOhsg5JWERLDUQgVEu2WamsDTzDN9NVpeQa0a6w>
    <xmx:CWQzZgVRC_789l5NWBq1BDXaCqCvqEo_lDLtLS9-NNiPO1VgVLbHJQ>
    <xmx:CWQzZnOZHt3tKgxq-IVHYjhlDwGwfNavXUwC0GLvbBe9opT33u3B5A>
    <xmx:CWQzZn05hkbihdFHQHdUJk1SAesuapKTAn0UW14omLe2WYd63JZafg>
    <xmx:CWQzZqf0_t6YL8WBym1gRq4fWMJnckWxb4rHkxNNMd-8dvXK0-iRr7Hx>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 05:59:36 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 May 2024 10:59:28 +0100
Subject: [PATCH v3 1/9] MIPS: asm: Move strings to .rodata.str section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240502-mips_debug_ll-v3-1-3b61f30e484c@flygoat.com>
References: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
In-Reply-To: <20240502-mips_debug_ll-v3-0-3b61f30e484c@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=661;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=QL9nuqQoyyNsWN3gxQVMz1nurlN4CBrHLvpqKsCC2dU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTjFPbg6bk1VW6lXAr3r8qy6v4qj/+15bPAca7q/DXlp
 5t3TVnQUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNRTmRkaDHddCU8yMZxd/3P
 gvhV4Vv3LHgtcIQ7v3VD1saehdd1pRkZJmms4dv56PusdM6ol9PcmqtV2fn++Xb/5p32eduVeDk
 FdgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Well, they are read only.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v3: Fix an indentation error (philmd)
---
 arch/mips/include/asm/asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 2e99450f4228..0c87a7de2a7d 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -94,7 +94,7 @@ symbol:		.insn
 symbol		=	value
 
 #define TEXT(msg)					\
-		.pushsection .data;			\
+		.pushsection .rodata.str;		\
 8:		.asciiz msg;				\
 		.popsection;
 

-- 
2.34.1


