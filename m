Return-Path: <linux-kernel+bounces-67985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAA28573EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287441F22A54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B696DF9FE;
	Fri, 16 Feb 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YDzA8ziX"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6DDF6B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708052909; cv=none; b=tLjBfizsLX9aFNYGDLr0tKO1JvdYWg+LRi5qsbkJDI+83aSovtILaC+m3DeF7+DT/wtKgu+TpcfHF8xlnLlMWHYAI7ZJOt40qfA1i4vMruq6q+elcZHCWPUssmCxSjjfFyBfsSRysQe2c5hTWx+ndAjWivns/1pZNbJg3iJ468U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708052909; c=relaxed/simple;
	bh=1YttCzjE6mOrF3+LP/4DSNa0r7I7TpydBBW2aaDUmpY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hPVV1KlD17HW/JKPOXEOq1srbb6PJTwCbzUDAQcc6H+xNfVMDFYvT+w2BSDg565xIAwteX9tuOKbt/P6wa0CfZ8/h6uYcTHsVMTpx/MzN+pfRqRwqasnfQjD0YuIDPzI6XuCG4HS7aqyKuTZ5VvKIzTC8Ik7dNZS/mn06zFsOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YDzA8ziX; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708052601; bh=KM/2SxIvi3sdxAANb2LES0IEDaLLu1dAqWsSF6vtL10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDzA8ziXQ7tJYnPHiStukWadpKK1ufZ9K876FV/HHy2Yvs74pdMtNj2mcMdC7IVZF
	 lmMugg9B4IKvKnsE2FxsraUJJ4zccW8mhaaHww9350O/Y5kbRSuEkczQsEwZPrxvKx
	 pl75UihAQPrQ7OY2V5ZQUkAD4F9apIrIRnG8I8TY=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id D334A69; Fri, 16 Feb 2024 11:03:19 +0800
X-QQ-mid: xmsmtpt1708052599tie84jb6e
Message-ID: <tencent_24D4467C09AD6EC92ECD4C9AA7FF46C89206@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaeBpgQMl54R3Z8CrkN+EM7/P2rzUNOfzb2xcjHzAo3snq0OVeUP
	 qacUQTeCfS2Uxi/8Qfv0A9pB8IhEccEyjo3kPI3zFqvfyoLblIyAHqT7nQugG9JaptJeUeP3QTz+
	 vIjk02mhkjDOMD+w+jPq4mrWxFWN4GHJk1VdaAGh01tr4eKYxklt+ZdlAeIOYeTjTdODJopYtxey
	 gZkmKwQQ+1d7pk+qsSbULfqwR5v+oYWiom15ywI/NjjvwvRB0z0UxvS05ii0LA3GRQ5RT0rhLttg
	 pHsIY16Viu8T4nr5bEkch7wUCbUAdBg6cqIj0qz504cTq4caf2hHptQitlQ005tQXlqatQI56iZA
	 pbSjCNXI5zr3CgQ4yAG9xoJZTV9N0htvJqBRXPTMJVSbgkvJnS8jbebb5YTTB0o67P4i67qNluHj
	 uazlJBiMeFDtGudG5ju/Lz8a4YjzvoU8FrLxObnA/HjUcAGb2me3JqImABVXki8f6mYyAS7oQnQz
	 pYNOLij/3mfOCnoECrp9fbyVekX1/1/6yfv6PQDzgZcRoqXijerOnVXuhFL7dAhDaeN+IFcVZ8oV
	 jna347lvNLn328/c8wiJTJrwquxanQ2c9L6qZ4MQ+GX+VJMflosygTnZ8Vvl3F1HB5eyqMrBmDDm
	 y2BSI2whKI/gmgUjI5SpMe7o5Je2Un/zUjH7j83IbSVtbdQuBLed1nAr36Q7LdsFPrjGSfQ8LWvU
	 DtyV8ZwBByMXRnC8Tv0c+fi3SP5h5eLNY/oEmSTyaiFXarDkI1erDYgJXAnGpq3JKiCkkWN0zz22
	 3VbGS3EbiT7/cCX/0XfQDyxTCGb8mpn2GUbsGOJYtSv32mWCiFgK2F1d8F5EbIn06xAEW6l0ari1
	 uCnViqcDdwhCehj5sz0jCZ5t/hRl8BZQ3s5rvFHyQjcz2t9ikvVTg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (2)
Date: Fri, 16 Feb 2024 11:03:19 +0800
X-OQ-MSGID: <20240216030318.910216-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000028b68806103b4266@google.com>
References: <00000000000028b68806103b4266@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in pvr2_context_set_notify

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98b..e93bca93ce4c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr2_context *mp)
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	mp->disconnect_flag = !0;
 }
 
 


