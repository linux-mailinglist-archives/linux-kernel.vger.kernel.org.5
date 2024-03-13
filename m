Return-Path: <linux-kernel+bounces-101200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7887A3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982B01F21E79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E6718629;
	Wed, 13 Mar 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwFkvvyK"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38E1756B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317409; cv=none; b=mVJieuv3D+PxGLfq5hDOJUSV596ME8wfSccJ5MP3IbS5ONQXrSuCL+gyBs3l90Zbda4fkjzzWrWRVsCjzIr6457RBm0zErkrojgIB95Tbn6UE+5ABqw9Dn6cCN5idxNeSGjSoN63y1ZkSkqZjwJ3k+D70B2uvZr76RwGbXXAbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317409; c=relaxed/simple;
	bh=1aYyUdHs6ZNxEgcuq5MwJfbs7Xlvs1l7H2OJs44P3yY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C7/ZnJHnGe/Q3TC3ezXIG16ngz8/xAPS7iuINwwIwl/RpQ9s2rvpOBsJV0CJPgv/kR4KQtitX+Iuw3lQivh6PNOD+A+qUSYPzPS+OfMix8o+UzwOyOObUQLf7LA9JUpPnz2fVQZYYnfkf8SrRb8f6GZXX5iLjvm0zUUgy5sOa6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwFkvvyK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd6412da28so5756415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710317407; x=1710922207; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6yCtmQnPN+6brcAwJa8z6E4LEDE9/Vo9fKfAhNa+eE=;
        b=gwFkvvyK6wvFM7sChFqT3lx9YWpl8a5i8CJ/EVzZ5kShLbk8BtsIuki9yJwf9eqZYQ
         aqKCiX4OLvNaxBtrcLE4UiH7mg2lQXTIai6Yw/3M+MhwfRU5wPWrhLTVOm3suF8mLn94
         klWSrLNEsPpvF0v54vxIKTvmlQpHGXBpOGuZ303iBwqu1qGHzQIoNF1M9sorrBU9oY31
         2qJFB1aTVz3DVg+5vur8D9yz0TysWJU9kVXHZKKJ0HvX+ucnzrFLGyhvM975qw0gvzPe
         5ZAXbB7i0yQsKpCQIu/TkVaBAl6xO3CIJj46OTiVWeDnBWYM/Se4hL8Drz5mw4ID3y9L
         tK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710317407; x=1710922207;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6yCtmQnPN+6brcAwJa8z6E4LEDE9/Vo9fKfAhNa+eE=;
        b=URyrHgNYI1Ng+ORt3U9tkoT0/CAhGTP0IZJB9s0JNvlGNwrKuxZNFQmJTqQP1Vebz8
         59RPdKDxTxWdpNx41SEg9WMmqJcQbPtxUS+t9aW+paOWZMNARimH7xE2KZkOzZFvdfd2
         GX5/qbEgIU6QPKDCmxxygreu1DZtgdFIqYHaIuryHRH095U5AHK85uvbZBjwWczhu7lW
         sCXa23o9d0uAR9PYLADgWw3tVpL48gDMaMT0otkXkRrTzUfzasPVGicXBbWkSzOeAnGd
         ZTiWIAlTRObHmA7GdUa1VBr6fPf3xExJmRKDzucwDjHzIimljQwIzM3oN+I4oBseO+09
         XGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfP8WsOy7ia+2levvhf1UfL9LOxZCWDHeKRjN7/KSI7IthaAWtR+iJzONQNGs/VzffXzRFYo0DEqplgP316KZ3LiewmPHP3ikTP3fF
X-Gm-Message-State: AOJu0YzV1SQPvsalOVoKHLUEnRqOYgdbo0Sx5xtXqqJJa3IKOyqff9Xy
	RcyoeV2eJ90twQNAp59K+DIkmZC0aUkh//2GmQJapouBX+PHA2Dr
X-Google-Smtp-Source: AGHT+IFJwo1OVOqPGdb5xr/cgP80uk2tuy0i1wdpm8F5K4+yOVlNna1jWXfKm/E+qOTECQhHzL2lzg==
X-Received: by 2002:a17:902:76c2:b0:1dc:7fb4:20cb with SMTP id j2-20020a17090276c200b001dc7fb420cbmr5568617plt.62.1710317407414;
        Wed, 13 Mar 2024 01:10:07 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d92a58330csm8053473plg.145.2024.03.13.01.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:10:06 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:40:03 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4] staging: rtl8712: rename tmpVal to pct_val
Message-ID: <ZfFfW/Flrlzb0+UI@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rename local variable tmpVal to pct_val in function process_link_qual
to give intuitive meaning to variable and match the common kernel
coding style.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
Changes in v3: changed variable name avg_val to pct_val
Changes in v3: changed variable name tmpVal to avg_val
Changes in v2: added a period in message

 drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 1fabc5137a4c..0b13d0a04304 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, avg_val;
+	u32	last_evm = 0, pct_val;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
@@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
 			sqd->index = 0;
 
 		/* <1> Showed on UI for user, in percentage. */
-		avg_val = sqd->total_val / sqd->total_num;
-		padapter->recvpriv.signal = (u8)avg_val;
+		pct_val = sqd->total_val / sqd->total_num;
+		padapter->recvpriv.signal = (u8)pct_val;
 	}
 }
 
-- 
2.40.1


