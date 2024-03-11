Return-Path: <linux-kernel+bounces-98900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044048780D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1B71F220B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5F3DB8C;
	Mon, 11 Mar 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycc5yl7m"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822D3D3BC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164747; cv=none; b=mv/PFE8AuvUEgICi0BOvI4oDsXcVOl+e3oTWTlftGJKnk35lmogK1ziiLY+uYHCcXTgW0rjd+8GwHBx+nOemb9KTsoICXPELfnqwAlkXMf2D5kbAtP2ElQ8V9VrzvqjLFLM/YWxGxwv5pzqogUjKhYrHJ/FJXmjFKp+jRYZHWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164747; c=relaxed/simple;
	bh=2rrzPqkrjgWCQYKn2ILmStPNQpOGa0V13tk49G8e/R0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XzNJCMtBvizrxz8MkCvSz4dsc91liN/f+B1PwuXQp/gF8ny78CH74Pxyaqp5uFSYMmsG8R26CEN9xxUpuOcwV2+x2lGyZyDDNLveIAnbk5Dz/hGl35/TGWsGn+/pcyyxpHAMLlhaMz35FeGbWRohrpAr6Ol99DFd0/luIUP22o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycc5yl7m; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso3744388e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710164745; x=1710769545; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BE7Hdm8gFkauiUDN4V0wRVBSytuZIdkLYWEr/2RSfnk=;
        b=Ycc5yl7mJNeIEwN2ry0QibxEpQsaOLJISBnc1DcZG1pzss9urARdKdXwqGazGFAv5o
         pXT7G4T8wl34+rLTxQ87eP8bGLSkdNCYLP45rR2K46+5UnfhINzo5MD1inlp8bdP8K1b
         rMczRdY9gxQI3Dl0mXPVXJr5w2t6Tq6kfMLcQYihxuSlqUs30sRTiuQ/pZwErYKh+gsU
         icUIP+YFYw/mUHJifwAzE4sd6VypYpk6O3+Qsj6VzHbM13IEjeCpyhr6/D2l/twuLfYo
         vv/AF7bPEnJtw2FQrFwm2cDpUzddiotUVLjAVNKQHDbXVjhnFMXSVqtdZUjftlafLK07
         FUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710164745; x=1710769545;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BE7Hdm8gFkauiUDN4V0wRVBSytuZIdkLYWEr/2RSfnk=;
        b=FQSUhyXir2nIiddrzqNnk7Xgw0mDWmQ/A2IoQSQH3YQq86DNe8H/sYPapgAOdWl8bG
         1LlbYhZXDz8gpzn+bXxWP74yZ5/MxSxLFM35bGT33mwTeJP2u5MhY5uL43FOpKRaAkfh
         M+/ZmWkw0nVA5EZcXG3nUAo2UVmFyFWeLv0r5j6DxBMdYzKACZpt5KSzmVGFiOWQ3VJP
         afiINIu2xgau5ynMM0yhL9+tSsVSCNYdGs94vCi1Gole8fIaw1UacCo2MEHnSFXNhaR5
         QkjfuS6JwjlDLlEbYoTxydEcLgrF+t7xflOXZVeAYVXGKv2fX1DUO9t1wnN5heyCnO2Q
         KnAg==
X-Forwarded-Encrypted: i=1; AJvYcCX8TAwDGt8kG/y6PRYUQZ6vV0/zzNLa7HlLr3Ifvn41Y9xyBrmXSDvj7dR354cA9SBqshrzcC3DS5FBHJkkV+mecE6uRqZ7VCkXQscM
X-Gm-Message-State: AOJu0Yyhu3GklshJN3lXeaO89/tBXbrHR0/zEHmTwTrwINmkRnkrOYV0
	AwhYJGBggS5G640Xa7WxAUjPBPQEfShm5OiQirYl4sBccF2xVI96wnei/4HZHNj2fA==
X-Google-Smtp-Source: AGHT+IEbNZtmkUjJIkytLL9HCTN+M1rBvIgb6FokHboOUqK3133d8V/mkBGqOpoWqXri8zY0e22iOw==
X-Received: by 2002:a05:6512:ac7:b0:513:49f7:70f with SMTP id n7-20020a0565120ac700b0051349f7070fmr5816606lfu.57.1710164744380;
        Mon, 11 Mar 2024 06:45:44 -0700 (PDT)
Received: from MOLeToid ([102.244.155.48])
        by smtp.gmail.com with ESMTPSA id v15-20020a170906564f00b00a44bc99cd89sm2890384ejr.42.2024.03.11.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:45:44 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:45:41 +0100
From: "Felix N. Kimbu" <felixkimbu1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: cfg80211: Remove parentheses prism2_get_station
Message-ID: <Ze8LBf6xSjCRt4rd@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove unnecessary parentheses around 'wlandev->msdstate != WLAN_MSD_RUNNING'
in static int prism2_get_station(...)

This change ensures adherence to coding style guidelines.

Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..7451fd2bb580 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
+	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
 		return -EOPNOTSUPP;
 
 	/* build request message */
-- 
2.34.1


