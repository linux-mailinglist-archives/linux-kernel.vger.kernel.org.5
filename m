Return-Path: <linux-kernel+bounces-68074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82668575A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7AD1C21C01
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A113614A99;
	Fri, 16 Feb 2024 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="IGekkKEq"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AB14A81;
	Fri, 16 Feb 2024 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061544; cv=none; b=c4tbHeaPnaoZC0TwyeLOcPU6hyS0L4u3GLyFU1rDjMEjP9LEAz/2WkiJalZ9x/gcMdT6q+1hTPZEpbijwVt45kCP3wm2V5FP3yMr3HchnrDPAUe+G9VKCVF6dwfuwCVKdprwqxePeHsU6wxC9u7ZGtZaG96pfRPa1fEp2lkvJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061544; c=relaxed/simple;
	bh=pvjLrBptRgZtu6rGXWEV4j3B7BGqqXBHy2HA9pkezu0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GywKWkFScxK7gzMnsG1Fikk6DRV1fXvBM86AfJYSAQDUFNPqmQvVwadzJVRJpW09e7uj8uwzTRqTyMsU4osparZfgbE4xnP8ceQqrTGqo+T5G2CNKDQiq4JiB2iwQg9juRQeC5v5D0x8YTDHL1kNbnk/FbrEfN6WKwX9DyE0XkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=IGekkKEq; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708061529;
	bh=Rvc2fug7Uaq7xVmmRaQlwuGeSMbuRAplnzQ8RFybO+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IGekkKEqZSvkfUrhyAbbsENmo7dhUEBui5K9mzYltJbIscCtJ2y75vag2/xLoHZCC
	 E2iqatlNGCMqAWBu3GbU1fsGfSqufTBhq8s4GhEe8NVpYNFZiq2fqh8fYuJnovunZI
	 UlDYYVIqDsH6Xt3mw2nBi1t8F/3ixz1yxXKu0RQU=
Received: from localhost.localdomain ([139.211.125.72])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 7260DA6F; Fri, 16 Feb 2024 13:28:38 +0800
X-QQ-mid: xmsmtpt1708061318tu8npfz2r
Message-ID: <tencent_B08771190400813E0CC41E36A3F540AACA07@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06iqGy2wE/u1l4Yh6I8YTHfADpjwLTLTNdtTagXHK9S1CpiaKQGqV
	 X2ka1d/1xV3NuSj0A7Axu/50vllF0N5IHM1Pk9JnpQSGxQQ/uBwtFPdMFpqqEfpRAAMFw+29eJuC
	 iHd0xfFb/2QJRpDKM612Rau0c2tB3Zq0LYs8m5fJMwSOF6IWnIrdw8AX5Hwni9E3Gd8UJ+pQrdQW
	 Dou4rV7GIGF28LJTNl1lptFlE+J1r+XJWKAZPrBAwjUW3vX67Jy/ciZO1GE6ncm7GzQk4iaRmjCV
	 cAaWaYu0hf0tYVCadC+UfGxQ31dqz4YhYPPMJzbwq1E91ikMGh5CZybWrRURg5YIiMrV9rEhYUmM
	 eajCSWX9PTqsSXZZRBrHPefFN/HTC2RtusYSrga7EYMZk7Kp+ArbY+5/IZm1H73IvFmCir4Y6m/S
	 wz94oo6vXMoEzXgemay/04Gfrw0wMDL0WLDzPP4xJvAhC8iRBRNPUqa0zhz17s8b2E/lDmfkV6OR
	 OZ21xG/m/KsOCBJMHlBfLdIBK933YlJzvR6bte5c4qg6yunNnxJnIeUgdfHivmpSduU5Fd5fYoSG
	 2eo5QE4RACBClImnGxDlSanZTKMigPpJlT6UmfKCfwYk9/n+0L81ONfsHMKeRtUhMGnkAbmQ03AN
	 ZAkUqLf93aj7uALxuH3HFaJ1V+4y81kCosf2cxVHs48Iawlf6NKd/3zdUne/oPYE7H2XnJAutZIi
	 FUKghMfWwS/dUo/cKcEGUFtPwI2N6NGLC4UeurV7wJg4w/5nrLaYlxp3uZ/p/rVtGmouUHQ4fvZO
	 ambAsVaAW2flHz+mLUqvzrX1H5ec4kWkUeMoWKrLa6mxgrsWaj4LQT3kgsvgD+H6w76ypgg+bSln
	 r6Q/r+E9iJ9NpavZGUZdnELssjAHlKbcOxonFnqnXkeJghGf/VackIeIK047+XinQ+MrxmWdKryi
	 S+LMf9w9hWI0DZ4R07cXTb8SEuK61UJIJoewGHG5nL/TvYWt9gVyt8hM2J1kR/u54ZsXBxNt1Q86
	 e5dOSO/5JIt3y1oBnPOJ6ImuZymuw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: "Ran.Park" <ranpark@foxmail.com>
To: ricardo@marliere.net
Cc: akinobu.mita@gmail.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	ranpark@foxmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] Fixed case issue with 'fault-injection' in documentation
Date: Fri, 16 Feb 2024 13:28:38 +0800
X-OQ-MSGID: <20240216052838.4547-1-ranpark@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <piosq44nxwlfeutperrk6d23bx564qlbfirc5xlbouyrunf24r@u6qsgqp47fz6>
References: <piosq44nxwlfeutperrk6d23bx564qlbfirc5xlbouyrunf24r@u6qsgqp47fz6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reply. I'm sorry that I noticed this problem 
while browsing the document. I have not seen any report about this problem 
on lore.kernel.org or other places. Should I mention the situation elsewhere 
and then resend the patch to mention and fix the problem.


