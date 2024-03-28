Return-Path: <linux-kernel+bounces-123727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC689890D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 544B8B23E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A2143866;
	Thu, 28 Mar 2024 22:07:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0612142E9A;
	Thu, 28 Mar 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663638; cv=none; b=jap6XlUOs6b11RJuZoQVGlfcY/ErvkkB4pOvNzrgybuVME0LvoxPXWC4OUeT7futEgnPsymSgoJE2WnHqWZ26x2ZmxbLdGZdH9+lNXbyiwJ5PaDg1OU/xfYRWLjMv96y1EWJ+RqkEz/hYo+aPLjzqxbl54dUa9TZyJjA+jWGIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663638; c=relaxed/simple;
	bh=kJwqN/B5veAWi5YByji0S5l/WZBRtVtHv9QCCLIe2eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lccX/A/rGNvwnCR9+OMx/+uLbp94Pn+mN9w67qQCDWmAIFsyARAf3yi55058XFvJDg0I4iMaS9HvqM7cY9/z2Bv9EDkOnKStWaip0XmSxJAHRR0HhIWtaYpQqg2sHaMYd9m11HxnwpGO/A6nr5Z9t34n7P7TVGIwq313H9MiHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9E4C433C7;
	Thu, 28 Mar 2024 22:07:16 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:00 +0100
Subject: [PATCH 22/52] USB: serial: keyspan_pda: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-22-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kJwqN/B5veAWi5YByji0S5l/WZBRtVtHv9QCCLIe2eM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenO42jSl3rC+kmzQm2zOeueBUbqWhkXDtfJH
 2ZSUCtTj5WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpzgAKCRDBN2bmhouD
 10VgD/9ogxbvfRz2uGx0FXUUQ8ryspQkraSv13gh8FjV0MjdDYl0ppnQuQcKWG6l+RVlSNt+N42
 u4kF+HUjOL+JFmohV3kqeTCAuj9uoqm2Po6O1009P0dSL4J3UGQ3lC6xEYJqSjyvDytIRqz8OBw
 Xkd0TV3wVf2xpcmBpVHpRlJ+myuVIPrmOEwyP4TTfqp2RBBbROFa3N0bSzdvb7yru6uwC2a01Oa
 KiBLTc4q9EQ8nyHzuDO5clfkBCPG/u31N54cE7peeuwi0NQeTj4H9csXasTvAAc6pm9H+5gV4ob
 jWoDTmURKWDyWfivuOMXYi2rBQJwCRwQvAQzYnLSDdUXrhrh+dfzZfZVe2kvwlREpqaBiEjs7Mg
 dFIwn212rn/VtGGwHquYoRzSyPem72aR1NMpWnhTuZ9LmvnUrgjXXAwRx5gns/+OiLRea/cKACL
 cdE+PHQFStwKTI8OW0Xk2ezOw9+ThwuNmXP525nG3H9obtAV5O/mzxGsEDedcoJDfej5aGRrlKY
 Qod2d9z2Hent1J0kn1n0Dvus4UJyqFAybmeYxI8ZIF98s3ZKYEwVTpqp/O+QjOXqmq8Rt9Yh0eF
 PXluJZpBDU7667ePU3GbsLFlkhvY/4el4ih8uNUp5IRXAMQ6MBKOYBB4i3F9rQwW/QM2kVqBokv
 XliOKLff4ubQ9Vg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/keyspan_pda.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 0eef358b314a..e98b479593d3 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -676,7 +676,6 @@ static void keyspan_pda_port_remove(struct usb_serial_port *port)
 
 static struct usb_serial_driver keyspan_pda_fake_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"keyspan_pda_pre",
 	},
 	.description =		"Keyspan PDA - (prerenumeration)",
@@ -687,7 +686,6 @@ static struct usb_serial_driver keyspan_pda_fake_device = {
 
 static struct usb_serial_driver keyspan_pda_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"keyspan_pda",
 	},
 	.description =		"Keyspan PDA",

-- 
2.34.1


