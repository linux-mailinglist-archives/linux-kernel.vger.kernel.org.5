Return-Path: <linux-kernel+bounces-28315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE182FCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38B5B25C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E963A1D9;
	Tue, 16 Jan 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc80Ilmc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231742031D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705441169; cv=none; b=GNfNTRy+a56EHrzDTe/ChheRDz8ZMdurygL0i58Hvys2n6mfDvebw6t7H18JmX1IPh2BIw1VCByPGVjoEecibrlF3myfDefd20kSU/lMzpToN4X2BSfIni9D8VtvAtKXz8Q/0SkA9a0eCdREmQAB8YXqfAY7n9Rbd2sqRdppM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705441169; c=relaxed/simple;
	bh=zZoAMhSNnLaP8BjduYu5bdBbD/Mt3VUCcdoe1rW7jfA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GC1MRtcEuMi/0NMuzNQmAr08dH0jHyeQA2b+t7ZihNinsD62FwdIL/Dtt1VgIopQbCohDX3O96vWzzpjbPHHhG1IQ3oJuXcos2FDfuKxkf5Vza4Z+eGoO/OSxhSPjY9iBKPkfky2VCavbbPdYXhzkko4TBl0pUN8TO+HnAtekM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc80Ilmc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5f56912daso5042515ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705441167; x=1706045967; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1vNJBlEh8DhYGD6roTSgxFREzSSomsGca9zVOoxkHA=;
        b=gc80IlmcStaFnSwod0PPETx7oyNvF22aWiH9Ydx01wX3TMKWKB2A9MmMEWAshXF0d2
         tPL/wlpiXS+eq7T9syl8yC8Sl7gQT8s5Wpj6MtVTtacBeiNC5hg027w8fCEgAROnHFEL
         Za1hiW2QQ9ukb/31SWMQOk8cMd+xaEbeeULWJs0yJMJK8RyDIXItu8TezR9Qqeou2hSc
         9C3HNVsKCTFMdOjsOWyS/XsBKURIul6qSjTZyuiFwcKhe98zJRmSEhowcD0ZG7k4FVoS
         XOdR3MrnZpd0mYs2Wa/pANaJdEb242tsDlx0MSTFK2xJR5McMjt7dKPrfF1D73wWyEVF
         kyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705441167; x=1706045967;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1vNJBlEh8DhYGD6roTSgxFREzSSomsGca9zVOoxkHA=;
        b=mSo7hDlv6hKj2nQtpObVX5krEnoJBbc6wGdjQ1e5iQ3FH2A1Sq2SBbhlOjSck2rDoY
         8IHZpj3hdrwtxzgTgucGaNVfG/ojIVrLyVZ8igF6d8lJRCmvabyLggBBPs0vMkxxXh4v
         YE3n2rLtuBWsB+FIikXfsnXIakz4fpVpzezj/ZpDyeELx5w+DgdXIN/Rz7JdDRieJog+
         sfqZInr3MtyO8yxJdRR8uoy0Tjr6n62b8qoNakpWktssD1Nyyj46/iFAR9UiLFa+hi/p
         6mJdb2g0DL+QVMEhYTR5h7cjpo2CUsiA94wsIuftovltf7rjz5aq8Z0hvowIuvu93nF3
         HT0Q==
X-Gm-Message-State: AOJu0YyQNthEHD78qvaqe4NbcZ79ES1PJ71XFKXVEH7BL9WgRbHrftyp
	y5zsmBd7V06T3zzY+iwfx1w=
X-Google-Smtp-Source: AGHT+IFtB06t8e2Z2ul6N1BmmHOA/WphDQZ/RnQiKeBm58pTznSISZi7C3iWQOJdEw0Ok48Blqm8ug==
X-Received: by 2002:a17:902:ea10:b0:1d3:f285:ab4 with SMTP id s16-20020a170902ea1000b001d3f2850ab4mr9385379plg.121.1705441167438;
        Tue, 16 Jan 2024 13:39:27 -0800 (PST)
Received: from LAPTOP-7VGLEE77 (19.216.252.27.dyn.cust.vf.net.nz. [27.252.216.19])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902a70900b001d49f61cb64sm9643014plq.262.2024.01.16.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 13:39:27 -0800 (PST)
Date: Wed, 17 Jan 2024 10:38:13 +1300
From: Hoorad Farrokh <hourrad.f@gmail.com>
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: prism2mgmt: Fixed a parentheses coding style
Message-ID: <ooj7nta3skljhnpwtz3wk37uztyayaewfoz2k2b7bnfivnoqtr@ymml6q24k5y2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixed a coding style problem.

Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index d5737166564e..a1adf69ba9f9 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -1288,8 +1288,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 
 		/* Set the driver state */
 		/* Do we want the prism2 header? */
-		if ((msg->prismheader.status ==
-		     P80211ENUM_msgitem_status_data_ok) &&
+		if (msg->prismheader.status ==
+		     P80211ENUM_msgitem_status_data_ok &&
 		    (msg->prismheader.data == P80211ENUM_truth_true)) {
 			hw->sniffhdr = 0;
 			wlandev->netdev->type = ARPHRD_IEEE80211_PRISM;
-- 
2.42.0


