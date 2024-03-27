Return-Path: <linux-kernel+bounces-121737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271C88ED23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939DE1C31CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4905153805;
	Wed, 27 Mar 2024 17:46:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955014F9C7;
	Wed, 27 Mar 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561580; cv=none; b=e58ZGukCHlldKBYAAoXZzZThEdH0SCvwSi33NSqQ+s0R4VxaFtqTKpxMI1vkZPqZJab3lVdQTLI2gtAH33q+0iXdEQR2H0aCHuv5FS+goKlUY1uuZ8dCaUrbV65nbPihg0gbMq1oYHDqcUpr6ODUsp+4VzAFo+Ea2Ut6XZsiG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561580; c=relaxed/simple;
	bh=D3KX5SKybNupDTnb5hR1KIxN9EWoGvyKMl8t3n9oZU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WEw0HRGet+GYsotbmyD+UjY32+MKhF/jlAaHVAQ8pB0ve7zrN8iFYCAUyhCp8O8C9XQyxuKTOCdSwDq1hjnw94yVjF+lRJLGnzV3slPae1BgQe+csw9AXdU6Qy8ntkvcZXk0mBbp4AjUjwbXVekITutmTM345H/71l1BeDWW3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53164C43399;
	Wed, 27 Mar 2024 17:46:16 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ran Wang <ran.wang_1@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] usb: typec: nvidia: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:46:09 +0100
Message-Id: <20240327174609.519252-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327174609.519252-1-krzysztof.kozlowski@linaro.org>
References: <20240327174609.519252-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in typec_altmode_register_driver() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/typec/altmodes/nvidia.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/nvidia.c b/drivers/usb/typec/altmodes/nvidia.c
index c36769736405..fe70b36f078f 100644
--- a/drivers/usb/typec/altmodes/nvidia.c
+++ b/drivers/usb/typec/altmodes/nvidia.c
@@ -35,7 +35,6 @@ static struct typec_altmode_driver nvidia_altmode_driver = {
 	.remove = nvidia_altmode_remove,
 	.driver = {
 		.name = "typec_nvidia",
-		.owner = THIS_MODULE,
 	},
 };
 module_typec_altmode_driver(nvidia_altmode_driver);
-- 
2.34.1


