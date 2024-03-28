Return-Path: <linux-kernel+bounces-123747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C979E890D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9AF1F24932
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B07147C93;
	Thu, 28 Mar 2024 22:07:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4B147C83;
	Thu, 28 Mar 2024 22:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663677; cv=none; b=q/fLlMANXciALPAMWXIGhUNt9xIbXNiYcsPULu63zFxpsoQhsybgmRtq7VaJiviNMPjwngZXRvsQYlUoGWVd+x7eaatUXHsBwwhviqEgrVuWqnTb8zaRtA9E50rU3Fj2swEtJPCcXiTG4YCaNIGsBiSJpc3u17M/NCp2Pn6vyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663677; c=relaxed/simple;
	bh=xu2Wy9u6+XPtbKDjfOOEukgr6N7fj3UPGwQYU1Jk5LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgwmsNpaJPWXRoAaFbsargzGZBpVSeLjb3B66oksnPjRzR0oMFpcGrdrIpWHfU5dZWa1U4Sap8Sn5UyIpEsyxljbTrU8UuNbl6TYog9lNbO5isnty+CFg5HK111NK59zFQa6q9ueaq7SeyFkSFd9Kb4Fks+AEZ9735jmqwqTr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE12C433C7;
	Thu, 28 Mar 2024 22:07:56 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:19 +0100
Subject: [PATCH 41/52] USB: serial: spcp8x5: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-41-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=668;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=xu2Wy9u6+XPtbKDjfOOEukgr6N7fj3UPGwQYU1Jk5LY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenenO6qTe3dR0lbh52YwkxgN6sCuNrrd7mCZ
 RF+wb4wZjmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp3gAKCRDBN2bmhouD
 14KrD/96vsgN22Zh1nSOoWs6fNkJ/jZ2sHWataPJSKWC6ZAKzfYKQFFtY5/xtUWfhCQ26gXZh8c
 M2zoKU3aAiV3MqLKSGRQskEhAJ/YEKQSWgKjgl2EW0kxxAS4pkTsLI4hftrhVOUxcggYSZnZLwg
 q0CSbqPobf3oJWlJBKH7qQt5fOclFr2eANi1++E2Oi/3ncWods3gHGBvUDUBhQGG1i09eT4Gsyd
 C+RyaeYPHiqOSTt8XnGdgRRn0Zf+br3VY27+P0Iin2ucOX794jDjlgPHlw1Fh3p+3FWhW+8zanh
 lSiA1qTQ72KvGcaGCgq4cRupduTMK6IXzM0EHMe+1NwHUL0xHCffaNZ0ZJ1HkKcp7Cm0ybN1/fn
 klvnTjWoLkWS6YhBahUUtXyBq6gRgxINsbzljJi+YnzXYuXnIDMLISmblwqtRFLdCY539vjVk+1
 fVv2YNVCT6VfofeGi4BMCfJvm5ZfhOFYHaO80aE8iAEa6QvXJ4RVQqSWUKOsH9NjZpBbnRMH54W
 eE13HMtT//W1y8WmvQvN6mo1aiNY/AE9nfGrDi70VCW9iMhczcZedWu480tN1EuL14zxpTWJxhQ
 2ov2Nm9NddS54beo7haLFMei/r+xYNvFklCrVWUcmCDPWpdBGnNq20VTfE5k5R9O18C/mVK0LtX
 SDgJNElkm41CpjQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/spcp8x5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 09a972a838ee..0d3ac5a56983 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -462,7 +462,6 @@ static int spcp8x5_tiocmget(struct tty_struct *tty)
 
 static struct usb_serial_driver spcp8x5_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"SPCP8x5",
 	},
 	.id_table		= id_table,

-- 
2.34.1


