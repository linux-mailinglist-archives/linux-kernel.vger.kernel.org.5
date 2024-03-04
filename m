Return-Path: <linux-kernel+bounces-91120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB768709CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327ECB2D3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1348879DDC;
	Mon,  4 Mar 2024 18:38:53 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268B78B4A;
	Mon,  4 Mar 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577532; cv=none; b=BQylPT6B/OiFrx1gWfQa6tTj+m0E3x8+kVu9ghc/Se5TD+rnTl3fApG3F+AVIA/BpPTwNuaY7gl8XxrhE8BLd9pz5KmizDDZknJQKmD+RkvbKjKnUJJmNUEs5h6YslwSmkTsNZVu5ZJbNYLquQ4IstYxwxEBJ4ebMMtV5UPmqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577532; c=relaxed/simple;
	bh=G3E1d+84x8xXVqhy+1WXOgtV5Tf07lUnzqrmHl07wKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/LvCyNE8mCo0CMJXh75SEB+R+pccr3vKwt9esJTx9+PNr6DDMdkGH24lzYky3KfnlfDeBz3tIkNih8RF71f3+Y5uLacpG/DSIO9uISTX3TRXPQ1fDq3o/7AjLfFPGKmjoc4NmhRdxz36s+Y5Qdk7CHX6qwjRTBMXgaNT1Clcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so789868466b.0;
        Mon, 04 Mar 2024 10:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577529; x=1710182329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fnoi1H+j4clEhXj1HIttNv5q1C/92NCaQWwcE97Vd+Y=;
        b=kOy+SvuE/2SshULcfMdUOO5YKPOmtGdAfqBUbyQKcqfiP5pWwH+/b908aSs/val+0E
         iQLZLL3c6R9jo2pv10fvJWn60WasDmtqokT0N03im4GwPeQxjncAcyjmVsfjkQgABrDI
         imAZUOrGSeOU0y2YssK0mzcMcpSkjTYi9hh0NXl7+1uQCBqA2HVVq4+XyDVHN1VYK0RO
         V2VemY4Mdb8Uvwm1tJlK0tBWRkzq72AiMkqfx+BVWOALYDRkMwXXkfHRoX74WgdrB2Vo
         41isCIJiKLDb1w0DSF6GTDV444XK+PHW+m/RbrdwCSUDyukm45wBEdWhU15YcvLWla38
         4eSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ305vgFsrrW8rOuBEiDmYgbaUA8qtV3DygxHNQmLAr/jsPYfsdntrMGgiuN62G+MkZqkWygVnhLEkqmYfY/wMEBdwpleAt04BIf7R
X-Gm-Message-State: AOJu0YxFTFABzkTAACxrzjBrY7q21EsDDbuljFTB9BROvn1ojArt940g
	OUl3upSAm8TeZDiJVFyO1g3zfwwIUQxKj9whBDM2NFK3SKjcmokr
X-Google-Smtp-Source: AGHT+IEjDKoxs7M4FkK6BsyvwavYoCjPmPWQ55cq7nluhEoUfuXQXBx1OfwbtCY9VBKuh4doC+3shw==
X-Received: by 2002:a17:906:cc93:b0:a43:3f37:4d94 with SMTP id oq19-20020a170906cc9300b00a433f374d94mr6649732ejb.16.1709577529141;
        Mon, 04 Mar 2024 10:38:49 -0800 (PST)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id tb25-20020a1709078b9900b00a4557115465sm1285404ejc.13.2024.03.04.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:38:48 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 2/2] net: tap: Remove generic .ndo_get_stats64
Date: Mon,  4 Mar 2024 10:38:08 -0800
Message-ID: <20240304183810.1474883-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304183810.1474883-1-leitao@debian.org>
References: <20240304183810.1474883-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/tun.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 6c594a3c2c37..8d258e263f54 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1338,7 +1338,6 @@ static const struct net_device_ops tap_netdev_ops = {
 	.ndo_select_queue	= tun_select_queue,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_set_rx_headroom	= tun_set_headroom,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_bpf		= tun_xdp,
 	.ndo_xdp_xmit		= tun_xdp_xmit,
 	.ndo_change_carrier	= tun_net_change_carrier,
-- 
2.43.0


