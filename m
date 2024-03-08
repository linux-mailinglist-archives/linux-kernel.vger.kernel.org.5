Return-Path: <linux-kernel+bounces-96792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1AD876186
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9901CB220AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C653E1A;
	Fri,  8 Mar 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CF4sfV40"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C3D54BCB;
	Fri,  8 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892463; cv=none; b=uKUoKeHQRZWdwjbY13nMAEzBhECQAlSDOUOt9U0IH9MvuUx/Q+kkeWwMsn4bBLpBeVDPOIi/ulVN4V38OH8xro5So30ocnuu1InZ1gVRhTAfjYbmCAELfT8/Q0T5gYpIJmSxOpMa3kl8oyBc+FgNByCkNDXZ1b5UrkrSPt21qss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892463; c=relaxed/simple;
	bh=KfBwrEHy4rD3TgkZxTpu4NpzB46Nn8Bk5rUIqZCiyt8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=bkvmcNG6VKSCmVxkckZpnwuNz3z9kxCGSTpZUlNdhK7VXI01wYdIY33HLYavrfNIS8feOGcZowUXr2vxtMpi7issJpN8a4JC5d5wjIv2RkZWcY7QC9G5hDh46+IwZvizzvWeb8gfsyKuwr6vPZvIdXvC9TEaRJPYV97Kay68dEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CF4sfV40; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709892447; bh=DGeQxNXVCp+OKO+A96VQZ6ctFIKvpPbY6cUQov38t7Y=;
	h=From:To:Cc:Subject:Date;
	b=CF4sfV40Sty2PWDUMJTIl0AMofSbHMk6SUCFVijNT5xHHhOM14oZJjudvKvqKmx2X
	 W3dcWD3VrJiR4yqeJgoVXWIbuv6DzI2ukPcoYlgw0ndYinSJG9mZyoQAjL/Dg5Lr7n
	 KzE6St9hMz3ItxU9irGkukP3fDjK4mxTouA4+YPs=
Received: from ubuntu.vimicro.com ([121.225.188.5])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 1D886CA2; Fri, 08 Mar 2024 18:07:24 +0800
X-QQ-mid: xmsmtpt1709892444taknccbx0
Message-ID: <tencent_002E3C6C67928986481018466EEDF8D05706@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jAqqZEB0xTnlxtJ/DAMLnSoztftAha+rM1A6lJXL7t826AF4tNB
	 +Agpdv8mAFFZnSzJjGwk8DVSg5QnLBlPYJCfidEBP1k99ZzwI3CxUsnmgcbBdVmKcmPWxCksZudw
	 XIk5n0CpyYlvDymR6sfWpTiHyBzomgmI9i1iisOyreQcWsmX4EEJlODLJsS3MH51xwOJhR9eWbEL
	 S4T8lx6Zb24/bqgoimCE0oPq5lmF4ngZR8/K9WkAz41I6iUHxJEBg2vNHWiz+WcFKoAkdJsi2Jx9
	 T1s4g1ORxGa6jsQxRa8kWLZTi+KdE1BK7aZko+OPztVJ/cy+/riZ+hxgylBQCaSd+2w9TLE887i2
	 nsGakszuGHi0MlbXwHYaepRfR9gb2T4ycipDaLEC1SqsTpgm6MFNdLxTGny/vkw/6AHMDebpk/Ku
	 6QUVVZDBHbKSgNgNvWj896JNPxF19keG9Uy6Wa4rBepgyVsZNmJB+l68nUvEixtyU20SA7J70nB2
	 hTsav1TzSLE7LfsxzAlY9lhA+IUlMD1Rk0Tii10i27pyuKmZhje+EZtiPq2+b+OBFC48Qn6pTAdL
	 BI7ZBxOWKVjEdi0IJq/J4GQ+wsPAaPIJAyFWbCIGHPXtcgnzQLRdn7ZEphPm6YPfVv6SjNQ8phKN
	 S1vHE6tnjbBX1hoqLrRrg/k8iUziBFvl3aM2eg8CZcWzo8ziuRnmFq5PMBEreOLyy1fZbbhqWbLp
	 DXJt4iDT/WdM2N1S+2Od1F8KbUraDi0FQLypN1MsvZJgm9wHLWVPTvUNVS5QRNVhg0etC9OiVBOc
	 +fDohIRmN/dEtalAM8MK9VxFWJoxYDm+dj/F1HRDisw7swVlofPb6qlC4JJVa6rik8qmVzC9OgRJ
	 Ju0kqyHusnKCjIPePtwtMnOQr4iHNeYj3ceizG8mtUi5/Sxrp8J8a+r3UDoBoA7yTP4+StRW4PK2
	 5kEuMrdZt8/OnWZLaMzI7sot8G/tXrYIu2/sLQBm6HnlnmRtkxm2aNeDHcVbuEqDV9d8RXwWnrO1
	 Rzq5+0mynfPNncMcPU
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: xuhanwu <2433926602@qq.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xu.hanwu@zxelec.com
Subject: [PATCH] ASoC: soc-pcm: add the judgment of unsupported commands for the function soc_pcm_trigger
Date: Fri,  8 Mar 2024 18:07:06 +0800
X-OQ-MSGID: <20240308100706.20984-1-2433926602@qq.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: xuhanwu <xu.hanwu@zxelec.com>

Function soc_pcm_trigger, if the parameter cmd does not support the need to return an error (-EINVAL).

Signed-off-by: xuhanwu <xu.hanwu@zxelec.com>
---
 sound/soc/soc-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 77ee103b7..eba737729 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1173,6 +1173,9 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			if (r < 0)
 				break;
 		}
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	/*
-- 
2.17.1


