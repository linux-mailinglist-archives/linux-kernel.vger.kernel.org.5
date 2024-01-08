Return-Path: <linux-kernel+bounces-19575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C733C826F05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76213283B12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6242040C0A;
	Mon,  8 Jan 2024 12:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SfAlAja2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC240BF2;
	Mon,  8 Jan 2024 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704718402; bh=CPfVigqtKj9N695Aa1G5su1g8j3lakcRAE4bhJn7SZ0=;
	h=From:To:Cc:Subject:Date;
	b=SfAlAja2Bu9lwctmVzvbERypdiM04AcR8MicQYJVXEE3WEIlYl4F/f8i+IT77FnpY
	 +3cDP00tnyJRzUCvELwwupocQJSxg5FaEyUHCP4zyUIhr7JqSaVV8cMZ2e6HOV1iq/
	 ztW2iIQWhXmYXXiAc5mWpMd7squJ/ueTlKg7nqXM=
Received: from levi-pc.. ([61.186.21.12])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id D5405488; Mon, 08 Jan 2024 20:53:20 +0800
X-QQ-mid: xmsmtpt1704718400ts1lhh214
Message-ID: <tencent_0ED010E11594001F62B9EF66C41B0FABCC05@qq.com>
X-QQ-XMAILINFO: OW8nL0XA5GqleSrjdBA7ntZHzHSgw2nE91fUuaBc1wWL83X5FLNBZiJqwigJDn
	 V0g08mNheRmsg9LS0xDWNFtwIAyTm4n5gPN525VRorjE1SNG+Io3ZcDFr+0uTnAk52JLp7hMYrKt
	 W/v8I3PsGNvfyy3flBzfsPYst8QOW8B8qf67vQ6DYdggOPiGgxjjco1o7GvxClVIFeGyt9b25LZo
	 W6mrvU9jCymCK7uZIm7uxS46KUl9GTHxpA+asInZtmUIYbUOI8Snr6fFo7regHNoILKH4ncGuRU+
	 4TNapv9LkuNDQ8DGrgXpmVVw9n7m32LJAr+SHvrVQ1uUfi51ybipsU96jiF8N8VrzySQtjybiESo
	 j3UzVu+QuTXRMFwNHzmXq4Hx493uYBArRxY6ITwqhjrpHjiRWCLfjcq5cwlG9FFqiZmKbzHro8kD
	 hKQ63uew1zpou1DgJ2si/csONeG6cDXLPg81vxUecfgQ8COYBup1WIDyLC2FIZdSa3eRITkKFLqm
	 Q8CRBudGIY6jBNIclgxjEHHh0je9u3xlfkhR1yP/aSkHyH5MBEOdWlEIHwTT+ZeX5SiQzjJnjG15
	 y8IBjSuEpBD1pgNd6tcHWr1C2oKqVC4ynQ3zIqKb2qxJiWAtT4A9wSf6MiPLpaYqxMERlZmsikDI
	 htRVNnz+sgOHKYXoTYSlrFA17Q7rSo5lcFgQ5Co+5T6+r6Rq8L3S6/ADRUeyqJTSxeTh0Y8loCVw
	 psMAjUf5712p7EawlRha9GlzEYN+ifbEx92JBMM8sKfUx/sh3MHeR7GGA20FPftUPvzD+dwpU8dS
	 pBnoKpbMdVpnOewPOGuqBW7QJZDS3/KDv9uSRfX/RHkNsi9veievjV97gd++HBR8DQp5h/huL5SF
	 ain4xr+tU4QGcQ3hvwucolVWrNeTnS3TuR5XdkHYv+3UgcVdGFxq4pTTl7+bucq44TrvK5H/2klF
	 rvHAbNjyt2Zmy0OMeoEt2DrXYpsDmQ
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Huayu Zhang <932367230@qq.com>
To: tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	zhanghuayu.dev@gmail.com
Subject: add DSD for ThinkBook 16p G4 IRH with Subsystem Id of :
Date: Mon,  8 Jan 2024 20:51:36 +0800
X-OQ-MSGID: <20240108125137.15081-1-932367230@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for missing the info within patch and not familiar with the
mailing system using git. As mentioned in the subject,
the patch is using to fix the sound issue of ThinkBook 16p G4 IRH with
Subsystem Id of : 0x17aa38a9. But this just enable the downside (bass)
speakers. When I tried to adjust the volumn, it atually mapped to the
frequency division (the lower volumn actually set the bass speakers,
and higher volumn map to the louder sound of up facing speakers).
Wondering if this related to ALSA?


