Return-Path: <linux-kernel+bounces-97143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA63876607
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E9DB21902
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533340856;
	Fri,  8 Mar 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OmocXzmt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E83FBAD;
	Fri,  8 Mar 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907015; cv=none; b=Nu2btqkKXRHzRqiawqp1x2gBKeUk16JbP+xcFAKXkGVzfJN0TI95y3YlRcXMgfQpACogcczQ8+symLAReajep05OpzcjoBKzdb5JbLi1rcLp+WOU0DKce8iH9UMuAZDpfYhmSTncE7ly4FAOKcp2f+aKNNJ71yvn9X+7DG7P0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907015; c=relaxed/simple;
	bh=XLcTd1jrwQne/noRDe0myK0vDxF9rSMC3JA5FM14s5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UmQyCi0QmMid/X4o5zjDfiHkf3INyKoWpO5N7tY5hmprYdS3gT2iMet7aAoRhSZchYdEeQWpvqkOaKYiLJgHsuagXy3RBs1DxNNQ0HcjPqRWtJb8NL8uVRELozLNZ3w1qFLVa+7oV9Uxio6kzMWy/+Flfd5JGoVvAttzpkHeLMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OmocXzmt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709907012;
	bh=XLcTd1jrwQne/noRDe0myK0vDxF9rSMC3JA5FM14s5Q=;
	h=From:Subject:Date:To:Cc:From;
	b=OmocXzmtuGKY+YVyMZvclR1jb48vjlwF41USSTEdJsSx9zgIEX3w4MsuPZfGK2TXt
	 ss5buoUhhjiOm+UBYN0NNkduKGVKxaIeunUgkMqOO3WMm5WjGR6aDisY+KHAnOMh9a
	 JxMzU53UwYGYuXtNj3fTN7JSlYqzYIi5pGp0fSV5DHPf5BTO14ggmfDLdQyHypUSJG
	 F6U0kzYP/PLLW3cCHk6OGM4FcfrwvQLl4MotECpr0n9xesTc+FQb9m5KYQd+rjosZM
	 VwPG/YvKPXCApqTIKBcBP5TxN86SheBcDzPZ2DcTzyZYMfLVk3goKPAZQ5ahcR+DMo
	 ZMei9xd32G2+w==
Received: from [192.168.1.13] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A835C37820F1;
	Fri,  8 Mar 2024 14:10:10 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/2] docs: *-regressions.rst: Tweaks to the commands
Date: Fri, 08 Mar 2024 09:09:58 -0500
Message-Id: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADYc62UC/x3LQQqAIBBA0avIrBPMJKKrRIvM0WZTMUZE4t0bW
 j4+v0BGJswwqgKMN2U6dkHbKFi3ZU+oKYjBGutMZwbNmF5/XDrSg1m7brFDDM73tgV5TsY/yDL
 NtX5iGZcqXwAAAA==
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

A couple tweaks to the commands in the regression documentation to make
them up-to-date and less confusing.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (2):
      docs: *-regressions.rst: Use collon after regzbot introduced command
      docs: handling-regressions.rst: Update regzbot command fixed-by to fix

 Documentation/admin-guide/reporting-regressions.rst |  2 +-
 Documentation/process/handling-regressions.rst      | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
change-id: 20240308-regzbot-fixes-43a28fd4b621

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


