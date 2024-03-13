Return-Path: <linux-kernel+bounces-101229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F293E87A44A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BD11F2243C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3868225DC;
	Wed, 13 Mar 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO11pcjX"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A9225AD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319970; cv=none; b=UHHBRvnLUjcwjds3VEBeJbKK+hbfmxMSyiv06LRNfBQRKwCN9NJbL+JGukpHf25zDQlVab8+pi3mTDHspZkWZry1H41DiSDsFw/p95YjlKJAZ1+RuEJJhK0EekjlbNfsKlA8uoFCcmsXAz2mYuaIufF/Wq0nWgsndMGw9t9J9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319970; c=relaxed/simple;
	bh=oAAfuMysAgf/2POpxw/i0V2U97beoIz8zYh2XeHhPBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bdgc5kHQ7EAAsiwZf20mR0OaRT6aZiq+ItgqC1w8BvE7/BUZx8PEmpRzlBJqxscbewGrMs+RQoEQjrAiKGMKMV54BcyBjEuyWGyOmXw1g/5amkWnU2Nc1XQ7y63fSPMTaW+VDosrK3AfgVWC4f+v0WOhvzKJMegNLwZEhVwApdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO11pcjX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so4454290a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710319968; x=1710924768; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jx0AltY2QNKpaAAdAZ/gjTEC4Fp9z47uP1Pk84TlNLw=;
        b=aO11pcjXZ3jQ1W8jYZT6/xRqOpOj9VOq4n3XaEiA7gKHdeOC7ua/vAApXuxV6r2bCO
         zsE5zIiBbc4TFBACEQUO3CG5rMyyguIpUSf2skUP2uDCHHCoAaUBFb3uB5kX0C3qEq63
         kK/bjHq/W7xGIWNd1CmRJT5v3Wq/qE/C68rccjyMxGj5zSPbd2BGx98Gmv7/s0CjsGu4
         wUBBHT3Tw5Tl88BR0QiOYEbQeOp/80+yCpd0RxhYcl/YOxGKhTP6y4Qkgi+pnSax2UUJ
         hZwrqXt9mkFMMZ/yvgaFnAgOB5glHqIz55yHCWGQ531ORBeqkPJfZTer/D8i/yB0PppV
         mjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710319968; x=1710924768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jx0AltY2QNKpaAAdAZ/gjTEC4Fp9z47uP1Pk84TlNLw=;
        b=KtLnQhxXA6ZkCEAzJEjakEsiGGPRE+E3FGfyodH3CteLBRTsjde/X4UTmACnq8kNiH
         7H0n72l6qk5u1YcbR5iv8s2UduvtYb+9kwHkhtE4hc+ZZtGyh8cIfwI7Z/V6K+kvF1Ue
         Ab1Ya32824hdIlo3zog3dH6GUPGOqGBVTux0YFSzPIDAKkG6G7jG389FYN3JxfJzgKx+
         X6441j3/BOAhywaZyBElyME4IV3Ax2auEJ0mkrjNAJhE7XOImLwOABg7nFGJix7Bx+3N
         9VVP/KUlstDKSXcG5Nck7UnQ0FKu3cznS8gEkgKAT94mJLCsyWvnKyJVc+L6d0FcFt75
         QgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlMgDqDsEK/6IhsfYhzzGpmiNOaw3NJBezt4XjWteLRecWBG9y8a2oL0gInBkZngrf8A8LZMeuHeS4WfGZU/qK7dnLHJk3l4khD7n4
X-Gm-Message-State: AOJu0Yz4KHcwGVC6r7oGQ147w3fwG1B/NoB3rSLlJxfQA4eTrGmikiDs
	A/cFcFeXqRdtWYmvM7wU4Yd12wZJ/zNnrw9Kv6X6UllUHjiWbwR9
X-Google-Smtp-Source: AGHT+IEwYs75iaQ7RhsHEIN/sybdvTkOf+Jn6DErYGQZv1YHreUyygA89jUbcVXZdegh3h1IxBxR5A==
X-Received: by 2002:a05:6a20:9591:b0:1a0:cd54:6d9f with SMTP id iu17-20020a056a20959100b001a0cd546d9fmr11557984pzb.23.1710319967775;
        Wed, 13 Mar 2024 01:52:47 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001ddd0eb63f4sm715917plb.105.2024.03.13.01.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:52:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 14:22:43 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v5] staging: rtl8712: rename tmpVal to avg_val
Message-ID: <ZfFpW9XvHhUkcspq@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename local variable tmpVal back to avg_val in function process_link_qual
to give intuitive meaning to variable and match the common kernel
coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---

Changes in v5: changed variable name pct_val back to avg_val, as agreed by
Julia and Dan
Changes in v4: changed variable name avg_val to pct_val, as suggested by
Dan
Changes in v3: changed variable name tmpVal to avg_val
Changes in v2: added a period in message

 drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 0b13d0a04304..1fabc5137a4c 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, pct_val;
+	u32	last_evm = 0, avg_val;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
@@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
 			sqd->index = 0;
 
 		/* <1> Showed on UI for user, in percentage. */
-		pct_val = sqd->total_val / sqd->total_num;
-		padapter->recvpriv.signal = (u8)pct_val;
+		avg_val = sqd->total_val / sqd->total_num;
+		padapter->recvpriv.signal = (u8)avg_val;
 	}
 }
 
-- 
2.40.1


