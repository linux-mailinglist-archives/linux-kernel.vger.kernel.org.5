Return-Path: <linux-kernel+bounces-75570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4185EB33
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD06F1F2312D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0F128380;
	Wed, 21 Feb 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjAlKB0z"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8F12837E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551966; cv=none; b=PAVWxyQbkF1n94yU4O3tJ11KWIqrc3YW1sEvu491/+9Q++w8RLyBnsg+YX6Rz1OgvcG2J+ieUN/5YOwh73eM+cRTeD+TgjIpzWnUEaO14DuDzc1HqfeyYvinyFFJ/XOPBjeAmqFmtVx58gghLQjge1+YLeZasyFHePaWhM8taHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551966; c=relaxed/simple;
	bh=1OjWMBiL7QYaelFcEEUdanllK1rmxw4NgJWvRh4EmE4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QucuoSKH6uEd+prK9ouTi4sTN2scDYIOwdGsxutd7xTQ3yvwnsOfz59/2mTUp4jksSTkMrK2PGz3ocQWuUDUyB8OYDr6+T2EWZArU+scBATbRO58jUjcZXkvuAk/mITjBji96ImFRlQItD21IfD3wJzZn7iyTFoMXELdN+MG+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjAlKB0z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d0a82685dso1432744f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708551963; x=1709156763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbGGBCSsuqXbhNe+nlC65PS6hYW27MmFIRLBgXUBQyU=;
        b=SjAlKB0z+8tVUULZbnrrl8ndvptCg8fDcboPrHd4v6z7xG2vCQpNka2sP8ExWtwMmT
         0j9qXQURv697j9XqBIOSc6VGvsEdwuJk5P+wqD+yDNZa1dUVqkwXc7NynOZY0Y3MPuJu
         78/hgqjoSda2RnVya8lOPReh3C6NdC9jBPEQbmWq/7HOcTGHrphN9nJ9tDD+yQCjwx9F
         Eo0vdD0ID7Tbjn/D50jjMjFpooQhXdLWmy3cX9CX0/9TomYBi+9amS/5qeOkXos5VKYb
         i+eho+E9CkPGC4cNc3hwd8Fum7HLhNWS2QLHbUijUrfx9eGGz/ShBZGc1rh2YvE75olq
         oMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551963; x=1709156763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbGGBCSsuqXbhNe+nlC65PS6hYW27MmFIRLBgXUBQyU=;
        b=VJgwfq8lrL1kjU3BoXhA6uwYE/ybEQgtDiYEjPlxRhZS6AaCVL1S3AkIiFTAZHhgvf
         nhTejrNqxDsTEK7mfM8exFwE0QiEmczf17bt2qGFn2TxFbVbx7Iec9gl42gdOBmkfPpE
         ku1YPXrRM/AFNDLlzEJhnewU+gwEUEbRRVuxLTOksi8+g1f43ypwBgYS3j8XtN/wJqdX
         4F/e1IvCJoM/uu0TJYskldlThGnUA7Q2EoJ0lWj0sIvfgAsOvEY+lMdrJLrBD5+eLSQe
         QF+9U14iI4OwicF317NYszcG2vBxF3NbO875KFTUrYNOk95jU5pzBMWVvUZDTTRClIMd
         Fc1A==
X-Forwarded-Encrypted: i=1; AJvYcCUwVU1XZ64yF8e8N8x0kkYG6vi8UKSqjlEacOYbz4jKKwZw3qCBTtfkSFJIkGSGM8djl5+k3jvnLZ1BrDCSuoy/meG2NyleC0Wk1ATB
X-Gm-Message-State: AOJu0Yx743GsngZA+ORFmsziJHDiIo4LlsZpx9Z/GZdf1eYPQAYIVFtt
	sIapiF8V+2bBRO8YGhjf6Kpz+KAPbDSbMVTkiRJKu+xdD9XHTZFvaHIsbxbpyUk=
X-Google-Smtp-Source: AGHT+IGlPeUKh3rdcoTeCFY3+wnaMUsu6TKE99XJtOo3czufk7zhEnsd5IyIiDKGSO7wvawhwxSM9g==
X-Received: by 2002:a05:6000:79d:b0:33d:7221:97cf with SMTP id bu29-20020a056000079d00b0033d722197cfmr3416180wrb.6.1708551963415;
        Wed, 21 Feb 2024 13:46:03 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d56c6000000b0033d56aa4f45sm9707962wrw.112.2024.02.21.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:46:03 -0800 (PST)
Date: Wed, 21 Feb 2024 22:46:01 +0100
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: rtl8192e: Remove unused variables ntotalfrag
 and Seq_Num
Message-ID: <4a3f2d217631076ee9994b46f8672eceaea8568c.1708461563.git.philipp.g.hortmann@gmail.com>
References: <cover.1708461563.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708461563.git.philipp.g.hortmann@gmail.com>

Remove unused variables ntotalfrag and Seq_Num as they are set and never
evaluated. Remove resulting local variables seq, sc and hdr as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 8 --------
 drivers/staging/rtl8192e/rtllib.h              | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index f1e97da8f077..b54dbc97d4ba 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1346,14 +1346,7 @@ static void _rtl92e_process_phyinfo(struct r8192_priv *priv, u8 *buffer,
 	static u32 slide_beacon_adc_pwdb_index;
 	static u32 slide_beacon_adc_pwdb_statistics;
 	static u32 last_beacon_adc_pwdb;
-	struct ieee80211_hdr_3addr *hdr;
-	u16 sc;
-	unsigned int seq;
 
-	hdr = (struct ieee80211_hdr_3addr *)buffer;
-	sc = le16_to_cpu(hdr->seq_ctrl);
-	seq = WLAN_GET_SEQ_SEQ(sc);
-	curr_st->Seq_Num = seq;
 	if (!prev_st->bIsAMPDU)
 		bcheck = true;
 
@@ -1672,7 +1665,6 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	_rtl92e_translate_rx_signal_stats(dev, skb, stats, pdesc, pDrvInfo);
 	skb_trim(skb, skb->len - S_CRC_LEN);
 
-	stats->ntotalfrag = 1;
 	return true;
 }
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6b33643ddae0..c18169725452 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -496,10 +496,8 @@ struct rtllib_rx_stats {
 	bool  bPacketMatchBSSID;
 	bool  bIsCCK;
 	bool  bPacketToSelf;
-	u16    ntotalfrag;
 	bool   bPacketBeacon;
 	bool   bToSelfBA;
-	u16    Seq_Num;
 };
 
 /* IEEE 802.11 requires that STA supports concurrent reception of at least
-- 
2.43.2


