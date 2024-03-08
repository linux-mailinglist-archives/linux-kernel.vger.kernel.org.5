Return-Path: <linux-kernel+bounces-96691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFA87600A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865ED1C2273C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD43524CF;
	Fri,  8 Mar 2024 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="T/rYEAO+"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BE41C61
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887633; cv=none; b=UDjMSrG/9Qfd1IzjAIfEOVFi9ndqIR3nyPmiGbIq9u9AxHoN6McxPARkIX+Wl+gH3TZc9Id8ml3HUC13G9TNBbjU1eOuRVjZkjyM/lAgVn18UwgifiFNZC2saOsnSl4hZaAAYSCGxWNcF31pfXLaMVfNubJqFC93bsCzC+6mki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887633; c=relaxed/simple;
	bh=GbRfLR3iTJYkf63GczUQDVlGarUSXHOaRpV3s3zBJAg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gn31EreBGTLlOhlZyC+wSs+ZImsQEeBeiuuovTKctJBz/R6Vi38jTA3h9KV532HuAHsqHJKq4/M+nTLOzALth+RR3QZ3rJv/J8bN27ve/OC5OH0zMULxFCMtWINQtZhDVGpqxnlgV+Ct93sI/sQ93W/AdX6WRWK1XasML2Yiwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=T/rYEAO+; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709887622; bh=fhGOKGw4jv0cvWd0cQmBirCVZaqTdDiglrZDF+cwz3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/rYEAO+jqUjlCm1PPaY2v/tq56HH1caOVddB3DlDdt6a7GTZZv35jnQzKSUEA/zp
	 DFmzi241AETb88HTM2E6ktmGJD0wfvRqmB6sIxTkOQtJN3M3+3Z5RrsLxa8M+2p9Lq
	 HBsScO1CDqMPjHJ2g1mhPuMYXJIsduHlHAwuduS4=
Received: from localhost.localdomain ([153.3.156.52])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id BC098AC7; Fri, 08 Mar 2024 16:47:00 +0800
X-QQ-mid: xmsmtpt1709887620tag03cuhh
Message-ID: <tencent_B8826A296A92B68C4B69570CADC250746A09@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeK1zFp7pyx+VZDg7YoSjkZYIc96VltvSPRWobxN8/ywVRZcc/ES
	 5TLFHeXwsGTi5AHSLa/XfBHz7ZMUcFb3A0eWt+Syd7o5cNPlEcuaRXu3RuatPpc02rBDBe4FS2pg
	 +gRnVVRktddLDSr/B6nj0K2DzzA/UqENtvsAzT0QjlsCMCQhTBtpejf3Z5VjTJbZ5kCNZKvL+G+L
	 LCp/+mCVqdKVCqyF+uprSIRx3ve2xqS4dm98j3abCqNihTlFeBr2/KA6eYASKqGJuuqAsM7hvjZn
	 Wwvio+7FOyOnsD0X3j5HKoCNZ5B7as/sTCT0I+ltbJ0m+QyS+uMtGrR+QirYq1N4JNmaJsS5XUVh
	 ZuB3kNywri2DzWJKBfDww7IYug96YULWe321Z/pmIKRGDKb0Cza/e3Xho23obMRfvUev4v/6luuB
	 unc7KwA2Zv0HMlKwisT53BtLeRMgCRGFw8x2ypivbJGH/6IegtSQAvcZcvDYgaQaqxWZmb0W3IG8
	 0m4+Tj3BlvJpB3Twbna9Be6RZdI+1AzUbbUqFUu/dkQH/Wwt9hf5D6kcicdkWYmO7HEHpalcjDQO
	 0j7ho8flcAo+FS6H+0t7tRYCSZuFWhT0NiZnqAmMAx3z3keEAw0hyDrco7xJxcfbIkkSVDS8P2yI
	 He21UT1qYkocRspyoafL6zwf30KgPDYP4jobr8ex7V6kWJL0yDAWXF2v1ByjofME09sKKV57QXsK
	 AhctuRQa6zEyfZAHFcMtG+pjjamjII9L40Q9bDYdNF32PKvNvau+Bml5sHpMOZyJ6Lk7gWoMgnju
	 X0b+b30ZRNCLHPq5REcu459ZVGKFRtGQ44mHGO5qzqKipVAVXkQGrQ/dEguLnjPr1/oEwoIY8mEG
	 agyCc48jM6W7GKp6tx9yAHM9+o2QoV1yKhNmPF9g97Uj6UDXCyVkqwBKD8K+4fW6vgxVwtLsXbmy
	 HB/eYFxMWowrOUF0YwRqmO3ggJIUy+0bLp611aKle0YBeDrZaGMR31jsHFlc9C2hIkg13vloY2kj
	 XAx1AS3YXMtZCk+QeqNckVthHsm3c=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: linke li <lilinke99@qq.com>
To: tglx@linutronix.de
Cc: frederic@kernel.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org
Subject: Re: [PATCH] tick: use READ_ONCE() to read jiffies in concurrent environment
Date: Fri,  8 Mar 2024 16:46:59 +0800
X-OQ-MSGID: <20240308084659.17481-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <877cidu4k7.ffs@tglx>
References: <877cidu4k7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am really sorry for making a confusing commit log.

>
> This patch finds nothing. Explain it correctly why it matters that the
> first read is not marked READ_ONCE(). Is this solving a correctness
> problem or are you adding it just to shut up the KCSAN warning?
>

The first read on jiffies is a racy read, and is expected to be racy.
So Mark data races to pwd->triggered as benign using READ_ONCE. This 
patch aiming at reducing the number of benign races reported by KCSAN
in order to focus future debugging effort on harmful races.


