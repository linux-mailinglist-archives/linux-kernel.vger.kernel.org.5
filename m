Return-Path: <linux-kernel+bounces-108272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F68808A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC430282F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714010FF;
	Wed, 20 Mar 2024 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AN1Ed0fD"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97180EBE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895295; cv=none; b=CmKgcoTfJSEkcSn0YJilQ46b+BOmFn8u4OiX+LIynehV/2BUZwBQy+GKuzHHxntob5sWY9N4sWPlcdbVBz8q1wlhWJB5bn7C0Zc9eCDCwUF5ca5yHHpt1tOB20w/bD+3DCLJdcvScKQ3EOanvELy6EY2H0yxLV6RZGpzBbeT1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895295; c=relaxed/simple;
	bh=5V1/VssmcY3cCOU4PToAPUGg5p5+EYYrTBDp+PGh2Qs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OoDXEaAaECkIV4CWvaUdkQnIAztUDeo116XaohCrj1MCUbGOhSxdqy4h55eotUPq+OGIFqnVnVaB8K7VqnA36r6lOBEo9XcxNO3LKfuEy79TQvWYNfFxUrBI1zxDgPJemntgs/CL1Q/yYUSiefJg4ocw3RKBbs3iLypzc+54XZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AN1Ed0fD; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710895284; bh=jVXsIxDLw/0EGcYMXHwp/WKStgKTPad0I05nXur1XDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AN1Ed0fD8zXk0FyhAvauXixTnNdlqfvNe5vYYYRePt+QFSUTs5HsdQh4HRDIwM9fH
	 pIXjvV2EiJDPkREnQ18JfXmIAClYXKEDm0LIUIUC7YVzfK8o1lrLfPui1kL/S5SXZ4
	 Nq/5rwX2kpz6HL8w/3HhfW3uR3ZCL+m0bFCjrVGo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 84DAAA74; Wed, 20 Mar 2024 08:33:13 +0800
X-QQ-mid: xmsmtpt1710894793t523ocv8i
Message-ID: <tencent_79DD6EEACCA727D846F212CE8679C998EE06@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNojI959x8ksgENUloCkhtjVpaQmhHzjH9oSX2g0pwB1r35zcsIdM
	 Qiq8TxUimp7zwvupuUyby4rfRIYD/+zTdGLrmJGXqjno860myUxaNriS+psRDZQYgmCex6WQtn1r
	 eOsRok19B0dlGwj0yanPxtGiGYYRGvw7epUo6DgKpzP8dVAsv6yVUpAktNcZ0rTis6E/M9EnsOMG
	 imsPuppp6+q0/DnHVa8pdTHe2d6F6ZHfSeXzXsSX7sSo43WQhV50qr+fVjZiXXi+Ac51YyibVwXs
	 8FM6D2BxVetdgT2AlFnrlkKhTAeihWnRG16U5kJq55o0vph7bRxiEPo/lBHJZQPfX7A8jaiuhNra
	 +TT6BGefCVd097L6b4TZrveC6RXQDwCKZwa/ogyJn7eCAn5/FNfLxCwJb9Ce58qwgj3JbGPWVR+d
	 DWA885yY7w9F+utg/VAvHq+ED+QdQiKd6T6/gbUsXbJ5gspmlJ9a/zPMbLIrN3ZMVCjK9Q8PQsLb
	 /q6ZTbl3wm7yFD96Oazm2jHxYPRxIbW8BrUvpmuhTrif3KCKZRAqfygOJbImuWlKeTJjqRZS5cZm
	 4T6+TyqM5mj7vmRZGAqFEzBCb1jmnZt9J6T/s2fvgeaAHInJ4syh9rbe3nXzEv+JFdGE72zsPF5p
	 SKD8GQKbdXdtWi2ZANtZIPIMpyLMX9aFE4DsS1d8Xu7Zmv4I1gXs2/qsV2pVlrhz4/PpooYw5Kyo
	 vseY7PVhQyRkAwl+QdjD55AJpQw61N1/rAYrUvOm/9LA1svlNNA84gv8Czq9q2BMTQUlbP5ISBLi
	 vl8Oxrzroe1zo+aLk4XWUoI1u8bUihu3p4w1IbqneH+7EiGz+f+f8Qq2XxYTbOwN9PGGwDvxYdvz
	 kAGuowIC3b8oO+qFqrv0KuTEe13hFJJJ4tewbxwkZWOq3kPZ345EUHlLZjyOEXpsRyFKgQxiA7wG
	 E3996MhKk=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
Date: Wed, 20 Mar 2024 08:33:14 +0800
X-OQ-MSGID: <20240320003313.618186-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003dc8e00614076ab6@google.com>
References: <0000000000003dc8e00614076ab6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in check_stack_range_initialized

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dd3b99d1bb9..358a90c88905 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7177,6 +7177,9 @@ static int check_stack_range_initialized(
 		return 0;
 	}
 
+	printk("mio: %d, mao: %d, as: %d, %s\n", min_off, max_off, access_size, __func__);
+	if (!min_off)
+		min_off = 1;
 	for (i = min_off; i < max_off + access_size; i++) {
 		u8 *stype;
 


