Return-Path: <linux-kernel+bounces-50095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A053C84742C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5FB1F21DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609214A4DA;
	Fri,  2 Feb 2024 16:05:56 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366351474A6;
	Fri,  2 Feb 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889955; cv=none; b=EMWvAOnmLeZeitLE72gfL2acReTM6+bjxN2QPxnKjZpsXerizN2gTgeH+cxFlu2DPA09GdzE8Pt804zmtsnbLirBz/P/aUJvN6Bj0pLWfXto/qNcQlWbmJApBBaseP1NvUwvQeCYI9IT42alOeZlqciHiIN9AKzH3lRgGq4DfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889955; c=relaxed/simple;
	bh=huJ/Rfg6KdXJHB+0Z8ECd2LJxmRDfJZTc2ymEesl2vg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DKqK+dluZKPCp8hlgM1MrWeCDAXSdUECfAVsW1wAJC3elSADxaZfxw3UjyyUwEs8X/rA3S82XQUltXTjn6LJ/oquTZPio1hHSkES2RtosO3cDctSgj2lKbfRxV13EuwIFdAlWCQlzyUvvCKGINEgH6rptjapM5NmL9TTnsRoTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a370315191dso106742966b.2;
        Fri, 02 Feb 2024 08:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889952; x=1707494752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu462frfQANGewhiNlgpx6hR3E2pyTy5PdFJlf3HJog=;
        b=mwt/WQujM8/KlETmRg6Hm+Nsf7lFeRBn4yu62GaKogu0mwgscw3qw1AHD/fBiCX2Kg
         I+GKUz9imiyDk/Qtmj+zlnmHRmuMWUrtRW061W5hwGt3hmaBnvQ8fF4+8rzng/GmeU+/
         ckuSMwTwzvO0VGqrQw4kZBhkoLGiaYW52lMJdXXJfJexDblkVLu6ay5OazzIWY4PuM5J
         nZ/KRQ7WHT5u1u26f3/SsZvw852ZNiNum6AID0dVrgeZzXvulnpnvlyqDeI9oxGTvldx
         gPusfAHbt7duUbmrHafKfAEyLelb+PG9EFBJCQ95WWWjZrSc7XoEMk+KecCJhxIjJnCG
         G09w==
X-Gm-Message-State: AOJu0YxmbWsdws2KZURUgiiLe9AoQQ3IMcgynD7ElDoI7Fy7I6s1Qg2n
	V5wX/PBsvrXkoL9Z5luyw8Ws1+NPYhF8lwV7JSClh0qAMxfK/miP
X-Google-Smtp-Source: AGHT+IHVsW+CVEna2Q6TLns6X2lxQWbiX8YRFHFnm22qfOt0MmouTGxujVLOCmOB7iHlQ++dXPwOiA==
X-Received: by 2002:a17:906:195a:b0:a36:884b:ed4f with SMTP id b26-20020a170906195a00b00a36884bed4fmr4133864eje.38.1706889951973;
        Fri, 02 Feb 2024 08:05:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbvj5lc3FPaz1DivsiiiE4R60Vw7/9HBDomMBOyD54TGT2wpPpWQXfIkXqJLw1+VXNIDN4MWlEPBSMuzQhbMSt3igODgdQ8n8p4UI2qHxN6Wa70TpeARohpYRP008vq8ZeBr/DXY7eSYBZQI+xq6juhhXGdpzDSQ5zZEsGVnbPJTDXp5eOCqppUPZD1sOApq7wkUvxzRdik3SuVIuDAFeflmuF59GYn2npXFIj3Fhj8CXveWidqDpxTtTL18KeT1h9OKTuGxDJ/mCQCaHU1AKtBo0tTimTf2/L6w/vjwLM/oql/P8UWgOl25H76Y1PS/4MIFzd/RL+h8VcORBwab6mAiET5yLmu1UEat5Rw518myw=
Received: from localhost (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id vh11-20020a170907d38b00b00a36fdfd5f52sm877495ejc.204.2024.02.02.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:05:51 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ocelot: update the MODULE_DESCRIPTION()
Date: Fri,  2 Feb 2024 08:05:37 -0800
Message-Id: <20240202160538.2139629-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 1c870c63d7d2 ("net: fill in MODULE_DESCRIPTION()s for ocelot")
got a suggestion from Vladimir Oltean after it had landed in net-next.

Rewrite the module description according to Vladimir's suggestion.

Fixes: 1c870c63d7d2 ("net: fill in MODULE_DESCRIPTION()s for ocelot")
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/mscc/ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 2194f2a7ab27..ed2fb44500b0 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -3078,5 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
 }
 EXPORT_SYMBOL(ocelot_deinit_port);
 
-MODULE_DESCRIPTION("Microsemi Ocelot (VSC7514) Switch driver");
+MODULE_DESCRIPTION("Microsemi Ocelot switch family library");
 MODULE_LICENSE("Dual MIT/GPL");
-- 
2.34.1


