Return-Path: <linux-kernel+bounces-82693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E886884E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037A21F247B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647355E42;
	Tue, 27 Feb 2024 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lwP7qncK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0095576D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008936; cv=none; b=tNUgWwfKfdN2VqDuL9NrC9xCaacx4qIoyHevQs6lasfIiM1aTxvwcQDjUY+TdwMMbtmM/2wUmRQTgtqHAq660DdK/dB/2mVswNJxbEO8ELi7rEuPngDXpCHY220PXO5Upr4aANErH6rcM1lhM/X5xJpPfMEODkXlB+x8qcQ2BNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008936; c=relaxed/simple;
	bh=nCBh6jOWfV9raD+ssu2XyS6gZGb2EqbYeymVcuscB9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=soUNjlIV8ZJ+Tvep6ZeIQp74oKOfB5fFDdME//kV8JVu4RWEWgTwFrSd+5Sx1v2FF2EYFB50adpqyHq7G9FE1B9/0dtT3Pqamt8e4clR0As97zBev+psn2DMYr89FL8pGWiD9kO3L5iteW8Ec6KeWE7IoouGUvC3pRJHbu1JVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lwP7qncK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so2310005b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709008934; x=1709613734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBPLuEFjCgyZWSsbmwP+rRr1D5s8089WWtYk3fTyzUA=;
        b=lwP7qncKiFPoRgk1LlamMRS5/GtaR3lzOm/zqC3ouxB2byUYIEZORmbGijGJaitPKu
         Iw+dVkkjKPH4X3ATBFWXFL201s+1EVPLYAwzR1P6YVjEenGIBaWBNk6rjIrrAH/o6aEZ
         DofwNjTfbu+5eXoDNZVc83/QDR/Er1m02FA3VLseQ43LIwWOmGj5ZVO9VHkZWGk6MxoT
         4MjGJSS46vYZt6lyWOlcBBRvR5A6eF5IU4KkvCU/D3nnVJNmCZ+kx3Ef81Z/z/iNlvP/
         U5S3sTWZcgbIV2PKoLGoO8s2e+QcdtwkTitwOlaUO8oPhy+GxMt8GWNRS189ErWzeU18
         Z/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008934; x=1709613734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBPLuEFjCgyZWSsbmwP+rRr1D5s8089WWtYk3fTyzUA=;
        b=X5VZrtqBqo+b1DjC6+6pWsQkx1ZiNUeRiWox/pzbHhN8gSuKeQuxNXvf3Uk4gMKlrk
         /rKDGVwk4gV2X1nzEWUWSCcTbCzIdd/xhrjhaugnew4+1RQ3f5tcBSkxXi+sYsR9Z0mL
         Sq7R19A1odU6KzBtCSvhhsrTd4jHoUgqPK+Ai0x3BNJbj1BbrJDK2NY0pvqkqdfcOzXc
         HR/C/d9g1BqoDZnRcJqXWDYbfXBydHcbOC3rvAsF9wHfQfFoCbovQu+utsgn4W6p39IP
         Q/89X1XSYW4CC0ymanUg8Q/CMbuPywphwIaQQlNH1CfrYJLK2EQqZ62n7ff52ZYg/bSs
         hsNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QCw0J0EUzHhRZAoqF+86Vb1LPsUK0u9KWHuQ8W5OG/uCdGAS17nXGKsNwn5r9N2TWoR/Ca53N9QyW3DdaLnYnfvHCyBQLopSMj00
X-Gm-Message-State: AOJu0YwQHRtpQmDjwbyKOmyd8NkyaQ2eLCItTdd+GLDI9aF8WI+Qh80B
	G28T7EZ1t99hklSPO08uz9eA++epDZwAoqqPbXLYnS4SrOgiwIJYeCPjeRFwCLI=
X-Google-Smtp-Source: AGHT+IFfE/+orl8qcIqjtBTKROJqUolDTTvhmUAxHSyHQEhtytbUiHuAxbMB25q+6vt2nwDo3qSgDg==
X-Received: by 2002:a05:6a20:9f4a:b0:1a0:ed1a:801d with SMTP id ml10-20020a056a209f4a00b001a0ed1a801dmr1594323pzb.13.1709008934280;
        Mon, 26 Feb 2024 20:42:14 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id e30-20020aa798de000000b006e4ecc3e394sm4899782pfm.79.2024.02.26.20.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:42:13 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 11/20] Staging: rtl8192e: Rename variable CcxVerNumBuf
Date: Mon, 26 Feb 2024 20:41:48 -0800
Message-Id: <20240227044157.407379-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227044157.407379-1-tdavies@darkphysics.net>
References: <20240227044157.407379-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CcxVerNumBuf to ccx_ver_num_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: no changes
 drivers/staging/rtl8192e/rtllib_softmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 794c50b2737e..3e26375a5622 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -852,12 +852,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->bss_ccx_ver_number >= 2) {
-		u8 CcxVerNumBuf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
+		u8 ccx_ver_num_buf[] = {0x00, 0x40, 0x96, 0x03, 0x00};
 		struct octet_string osCcxVerNum;
 
-		CcxVerNumBuf[4] = beacon->bss_ccx_ver_number;
-		osCcxVerNum.octet = CcxVerNumBuf;
-		osCcxVerNum.Length = sizeof(CcxVerNumBuf);
+		ccx_ver_num_buf[4] = beacon->bss_ccx_ver_number;
+		osCcxVerNum.octet = ccx_ver_num_buf;
+		osCcxVerNum.Length = sizeof(ccx_ver_num_buf);
 		tag = skb_put(skb, cxvernum_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = osCcxVerNum.Length;
-- 
2.39.2


