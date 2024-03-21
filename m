Return-Path: <linux-kernel+bounces-109596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C030B881B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2B11C215E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D8B28E7;
	Thu, 21 Mar 2024 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g5yhSfSV"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9728365
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710988763; cv=none; b=o8+9AfD8l1gh6sGDkFrt+vtQpxpunV66H3LtxmY8YZy0wvBWmV1nAxitvivf150ueoFPkEv7T0T3PPtjsCqBehlOjcud+DQtoaHe067eiHLhms7vTiJu5yvZbfSEtDX4ajwfxfyPNpiG97Yw+A41UE7x6OH7Gz5s3bxUaoEK9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710988763; c=relaxed/simple;
	bh=XDBXDzscTceh6iGJFO3Wkn7NTtEpOzbh5e5PC6PUMD8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RLpAKLrzD/AIKWCjvmZ7ufqrRn9wrEC0HTr8NMiY9yUSJ8DoLz1ziKhoLFzvjg0X/vdshMbgD3iewsB4CtmtrCjHX7dowVZ36y8wkVl/djlMcEFJeERFc28tcAMC+dvI7vvbn9z2gVTVjOyCVCLelfEV4t0hjvJywb9l66V9ccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g5yhSfSV; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710988756; bh=e17/HbRHtDX40mFVgDNLzqWxNBHtg3feQtuFXQYcyoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5yhSfSV5YhlztVdkUH/WYdK/KwB28CaktcHEEQIrZMvxdj8Os65VnsO4SiSJUWT+
	 pwjAL7cGJfv9U1oFNy9fxoPUjp1FszbaicYJOmm2Pb/MctzlGQiXJjufVqdu67IWzl
	 u7shUBiW/HZ9SaXe0j4yvZwVMs32BoaSGSkniEPk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 9CEBD8F0; Thu, 21 Mar 2024 10:39:14 +0800
X-QQ-mid: xmsmtpt1710988754t89d5x5wx
Message-ID: <tencent_53C96CD89554EA8AEF32CD2C784E6D202F0A@qq.com>
X-QQ-XMAILINFO: MPEorwW6cFo95aJmjSOzmykdZCLOWgeU6aY4HFsfjM9UnN+b/YRMYfXOkQNJ13
	 6tdhSjIZgo20WPqJjAtUcSa2cHXliPRhSGIHR7TMRQEiFcsNtbWsjpSdvb+m3J4wJR83SxTwxX9Z
	 /e2Sq50nj1mkKFeyqIs6VQnRotO9AfjCPyA3CLKrj2w2M2yIsXnx6hApZNS7GltDUTj25ZasEPbp
	 BIAn4JL5jabXorS/zEyNevp3mcsWA1wzXqE0XSrLYSlZ9p7S1nQL0YulukCARKpKqGNlY5A0cwvR
	 HijXUP4WpoUmV16skMU0nxy/r3c3HlGGe5YrYeCmbVs5MdQJDISlu+xm9qhqLdXnDGTejaeVe6Hb
	 M9Bj3oN4UPnPEcSV5seaCsGFKOviDx1scVuNMrMsMGvofDjTYoDryWIc5BENjAVVrUbuFLVz/zfN
	 3y2+IvoxRfNdM968Ugjq+HrW6XYVD2VvbQCObTua8Dgm+45JwCKpqOASDifpoiYCkSjx0nSHffNX
	 UglzriFg9Nzz1rbp8fjkZemH/M6Xo+07ynHHmluiYPhEZG1/2/GBL0b3m4WDe2zSep6zBhf6zboC
	 0Eu/mPsEPHCC9hDOb9ieXJ4r8TqDHu8i2saE4FCBH9ezTTtG+r5mijQTuXq69csHcivkp9LWt29n
	 xzcmod9tTyc9xPodNsYTWrsL11ODEUm26WGWHksIGcWqoNbuW+ArfIjI7te0kWRIz4/UFhH1+wBH
	 jsOjOEdZEd6SBoe3MhrFAPF6ZkvDpkuLaSUjFY0PQ7i/kd5+/5ltZUIg8d3hI3/cY0Uk0IzweZHR
	 7QFYA1e1TSOnW30/QU8MeMSkOIrMlooWzHw3dhuoULYXDi9BUrCgPJB7qXGBugE0ZeCoqbBJNaEV
	 K3Se+A2HRh2f9u8l0nxni6jPJ+IgGhj6+oThyn7XwrLcohXUI5TFti+tB6RDaAIHUVi3C99rqcR6
	 iNUJC3luGdi2WSXzyWLDvYlan/e9f90cetfhwsI6ML3DpI2a0iig==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
Date: Thu, 21 Mar 2024 10:39:15 +0800
X-OQ-MSGID: <20240321023914.1849391-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004e41110614187d35@google.com>
References: <0000000000004e41110614187d35@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in htc_issue_send

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..9edc72601bf2 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -295,6 +295,10 @@ int htc_connect_service(struct htc_target *target,
 	}
 
 	*conn_rsp_epid = target->conn_rsp_epid;
+	if (*conn_rsp_epid < 0 || *conn_rsp_epid > ENDPOINT_MAX) {
+		ret = -EINVAL;
+		goto err;
+	}
 	return 0;
 err:
 	kfree_skb(skb);


