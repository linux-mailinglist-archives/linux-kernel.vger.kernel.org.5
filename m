Return-Path: <linux-kernel+bounces-124875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6226B891DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE5B26524
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6D20124D;
	Fri, 29 Mar 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtWzrpf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FE1D2AA9;
	Fri, 29 Mar 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716328; cv=none; b=lAwGpmAuKuFQvMz3l0x2HalI+CIwMrj88sEcEmyw63YMDmHJJqJjfVvgBI6yKkU2v4vz83vdYqQuVXZKe4DLdP4NOfj0Ka7uv8FaHisWM5ESy/J5/KXm5GUIyz3F9g6HQCLr65EeNUcaBFuhNDXaAXKfldoat1IP1jq8QNgsA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716328; c=relaxed/simple;
	bh=/ndiS32DRyHE3+x72pJ8Oco9ucwa/H6pivy8mTQ0AI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPST0EbXgIhjj42Amdz/WHhSo1A/jQczXTdecVIKSoE/BT+B0Rou0rjRXS1x4BOefaU3REUa5jiwAkgZxm0RBVe3M9lyD1YpVnmyqBavDcae8dpjTJeABp/kYvvfT6lfEnHoTfOEJ7Xin7lUbrKmw+bxlDUmU5egEErW0qv8d50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtWzrpf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A278C43394;
	Fri, 29 Mar 2024 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716328;
	bh=/ndiS32DRyHE3+x72pJ8Oco9ucwa/H6pivy8mTQ0AI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtWzrpf/WQWmCthV6uMiNIJRHRhGeyIFWGQW0ajCjS9aXgZkWqpkoiB8+61D9/Qf4
	 bppDL8+ynruduwId72C5MK4gs8b7Sd/KijD+NryBhP5QRMTguL6Hx7NiPazPri8j/u
	 H8DGm/6+Jl189jqeugQq1v3UnG+PWM3OiDFfAPoojFw/a94LXJZVpZmIXkFafPpQtA
	 3qg351+tZdUhkmX2Av0SmerBM3krzvJD6RQIsY+3vVsIPG12RPF1aimbOsbGGMyhSU
	 1bxAY1sx8RICI0NAVU47sKhh3BR01ioMP65SOdGyRVRKxSD6DG49b+WkZ3YjqCsv+6
	 TPmBpHG4iQEMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 66/75] Input: make input_class constant
Date: Fri, 29 Mar 2024 08:42:47 -0400
Message-ID: <20240329124330.3089520-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

[ Upstream commit a4735d40a5da96a637af6e5bf9f6ec8b9d996acd ]

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the input_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Link: https://lore.kernel.org/r/20240305-class_cleanup-input-v1-1-0c3d950c25db@marliere.net
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/input.c | 2 +-
 include/linux/input.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8c5fdb0f858ab..aa4683567d180 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1918,7 +1918,7 @@ static char *input_devnode(const struct device *dev, umode_t *mode)
 	return kasprintf(GFP_KERNEL, "input/%s", dev_name(dev));
 }
 
-struct class input_class = {
+const struct class input_class = {
 	.name		= "input",
 	.devnode	= input_devnode,
 };
diff --git a/include/linux/input.h b/include/linux/input.h
index 49790c1bd2c43..fa656f30081f6 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -514,7 +514,7 @@ void input_enable_softrepeat(struct input_dev *dev, int delay, int period);
 
 bool input_device_enabled(struct input_dev *dev);
 
-extern struct class input_class;
+extern const struct class input_class;
 
 /**
  * struct ff_device - force-feedback part of an input device
-- 
2.43.0


