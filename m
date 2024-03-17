Return-Path: <linux-kernel+bounces-105445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E087DDF2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3761F21277
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084871C6BF;
	Sun, 17 Mar 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="t/ohHseF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21E91C6A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710689308; cv=none; b=HV+WVUwlUds18/p5V/xtshfv22vI0Xcbelda918+lQ1peL3O77lFusoHptvACG19OlvdQ/H2rJ0Gd9Sir4oZPSmGqwOrs2y2WbA3llQdPFJc+UFat9bSVk7KMiGs2YdCl0LlsGdcigr1l1Xdb/arnXiq25+sPS735q+sJq9L/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710689308; c=relaxed/simple;
	bh=YIaaaBBgvwlXSX20zYsNlwMvqtEmC/57EJQW5lqAUr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUHCj+aIH6hL/ocDNJVTsKQL083Yj+HPSx9Siq7nm+56kM/8PoZQO5BUU1RyVn6QH2Hl1EyAfwTwmM3O8lx7hqGzvuYlcWSFlhkU/els+kX7fDm3DBZEDagedcam8gkY0FFd5jnzzkOXmusc21VoQspZfZjNyCRNxoATy1DmCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=t/ohHseF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4140eb3aeb9so2102275e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710689305; x=1711294105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xwgcjp0weLNxp98CRwtASrSw9liqeX/V6E5QJd63HBY=;
        b=t/ohHseFbgKZq5mJ+QwNKYqQNR8fBfHVh7UIZYSDfMrz3w+BZ/P2nSq+iakUdoAFWN
         xYQqOJPWBnt72iaFc4S3A537TJG1YTNq4n5LHnwo0SbIFnPLEZPLt5pvBd4B2kOP4qMs
         DTOA+btiRvC1AW3DUdb0/wNwQVv+AjUBkDqiC5j261B+CLrP7ORuN4lSC7TG3Yp743Xr
         mQd1WGRgzAFqnnrBvAp1gx9oOcPvL0Vp5nhhYqOaotK01fJTaXDDUW6pxJwLhK8tIVu0
         /kwiKZt8yuazctHDu9YNjtKK66gLo8PNHH6bbVGtLThIMQrECZ+2fC58seqcSioRnZxq
         3EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710689305; x=1711294105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwgcjp0weLNxp98CRwtASrSw9liqeX/V6E5QJd63HBY=;
        b=JmHhHVa6i/fnxAj0S/u4wAKEEq/OhMAaezvjANeTD+wTUHC2rvi1qADCadl4/4HTA8
         J5hlrRemFlf1OlHuwHBMWOPzMd5zcrtLTb0rbpq/MBEd6/2pO64oHd9OJat1P6n63mze
         RPfCyFOlhK+pWRFWSNTcdPhVQc9UsLNI2bgcshTpolMqzhHUS/aQHOkNyRJI5owC1O3K
         AvVUVp09XTPzW4KCIkFndusORdqiTAg7JFkRnwr2QVboSswe5ZSombO0fr7DuolWmY0q
         syjCLGgxmpvpJnGXISECVjsdJrbmgO2MZ8nRj4/QR2HbfPk+P/7AkadqD9uGUPRPs9vr
         5ehQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv+ZsgGJJXoVbJ15PpNeRX224XcnV9EIR1FH2KWzuoYgfgVUrppKE/Z8g+eyq+u/VRHLItyF4BJKGBWPUYKKHWvP+TUwRz4osj7xS5
X-Gm-Message-State: AOJu0YyzXT8kxnPXWyvfuqU37ATNM/RIaF3MyC0A+4sa8LWQVAg+81Vn
	bk+JhmU55SNfOHXSi9c51OOzexxvZLEJUFqON0k4unIhwxBZzoeTHLo2ftQqwQ8=
X-Google-Smtp-Source: AGHT+IGMuH5PGta5RX7cF19pcwqvZj3InDGy1xP8Uiy9LWzR13NMZTSxnRYyZv2KKWCw+F0Uq+m2YQ==
X-Received: by 2002:adf:f884:0:b0:33e:c0c5:1799 with SMTP id u4-20020adff884000000b0033ec0c51799mr7120068wrp.45.1710689304903;
        Sun, 17 Mar 2024 08:28:24 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id az1-20020adfe181000000b0033ed7181fd1sm4763862wrb.62.2024.03.17.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 08:28:24 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ice: Remove newlines in NL_SET_ERR_MSG_MOD
Date: Sun, 17 Mar 2024 16:27:57 +0100
Message-ID: <20240317152756.1666-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warnings reported by newline_in_nl_msg.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 65be56f2af9e..ebece68d1b23 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -464,17 +464,17 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
 		if (ice_is_eswitch_mode_switchdev(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Go to legacy mode before doing reinit\n");
+					   "Go to legacy mode before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		if (ice_is_adq_active(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Turn off ADQ before doing reinit\n");
+					   "Turn off ADQ before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		if (ice_has_vfs(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Remove all VFs before doing reinit\n");
+					   "Remove all VFs before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		ice_unload(pf);
-- 
2.44.0


