Return-Path: <linux-kernel+bounces-71915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EC85AC7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08EE1C22C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF7D535DB;
	Mon, 19 Feb 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="aDrdE7gw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CB4524D2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372227; cv=none; b=N2QjF7sar0izAL7kaIpdlo4NQsUJGKveTwQQRNf9Y1pbcIviLrMRV4WgpcD+LuqmtRasTWuB1H0ONgjsZl8utFYzVjQVxdD6K8j0OGFCDDqAH26KIgpRrHwEMBzuX1hsNVk5GAHjX4sNmo4ZWGq1TFHmrtOTdyTAYfgrNxxRjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372227; c=relaxed/simple;
	bh=LiKnCuiFv4ZGVKFoQmuhLed1FCIaI4vC5l4DjjzaUko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e9u5TsIm/TPbEuS9ev1vg02RZpc9hVP6wThIR9D4SlK+BdhIx030YdWGEUBvuk6WstFGUX1uLtGI0yBlGrr7T37wlXxeUQp4mNlkrQl5lOohdbvuXOcft4BPOjINA4TXP/QWhXbys7ODXQC1OzgoAqWbSXqLlqlWzMAF6bUA5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=aDrdE7gw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d911c2103aso25081975ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372226; x=1708977026;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPnohsyalrO5Wvk5DDRYJ56mkpStoIFPuT0hLH9ce5k=;
        b=rc1J1veDD6U7dJJevqSRMuvFt+EBJyCrJmi2WCpy7V4AXvvo9POTe60yL/pr0zKy1x
         +G1LMDgEoV1PvXLFnavnrykAXDe00mncPtgnZ4Zrj5dMUILMmV4lJNVjJdjEDQJmK5Ml
         /d+VI4Qx3YQ14KL9K+ELADRsKq/ecXU1SaLlGvAIKmXNKzdDiFq660AzMFFukG7O2k+P
         NMzdJx8kJ3XO25hixfEHMFd7PDkJ/wwDQmqDXFtBi4WZsIdr3jD8uL8UIW7TIH1PENkW
         Yn0N2/Lqk1oKvRv1vk3KmhhGt9LpSL/X8cOtaSt9ykoSkU2+BWcbWhXn4/avnp2j4f75
         qsOw==
X-Gm-Message-State: AOJu0YxoYxsLCgY8rTugRaJ7mGxStKegh9f3XVzk975wu2emPAiHRSPR
	siivkXfXBV4hxY3o4QIVHUe46/pjSKcZyvBTBRPRICxNzLWq08KadIwjYiw89Dp8jA==
X-Google-Smtp-Source: AGHT+IGuB3T/7gbNhli+QDzh/8Cpo5ciyJbOhazEx+jLXa86OFyAbk3EoSJ0MRhCUC7PSeefeERLtQ==
X-Received: by 2002:a17:902:bb91:b0:1d9:a2d3:8127 with SMTP id m17-20020a170902bb9100b001d9a2d38127mr11741705pls.52.1708372225754;
        Mon, 19 Feb 2024 11:50:25 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id mq6-20020a170902fd4600b001d96a0cddccsm4783155plb.296.2024.02.19.11.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:50:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708372224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iPnohsyalrO5Wvk5DDRYJ56mkpStoIFPuT0hLH9ce5k=;
	b=aDrdE7gw13dURu1guwsNvvNN6fhLFosBTOO2nGZlH1KJxN/co7DE9B0lAv5tA3ig0WqmPS
	S/lxW6WlE1JoRQpAuyqXZPIMvOnfykcQwslRu6mlLy9/i4AYPLYYrT2RhUtwNjOiW7+cYT
	ZZfQmK4Ryx4PiQCM/+6v4+eebXbaDh4gadCd1KS3Runk9gcQuWVFS41xN1r+QgA5oojGaX
	4b/DNLB8OU7p3DQ12/NlbP6kGvpS2npyNWSDXWo9P7A11ik6Gb2TBbfIVEbpkcKZduaOxO
	XFoj8SYCzXbj8EJp81APrMjRs8bGlTKhX4ifcsGR0iLa+zX73K7bahqO4sfbPA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:51:10 -0300
Subject: [PATCH] mfd: core: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-mfd-v1-1-e4eef5ed2da8@marliere.net>
X-B4-Tracking: v=1; b=H4sIAC2x02UC/x2M7QpAMBhGb0XvbysWNW5F0j6e8RajLVJy75afp
 845DyVERqK+eCji4sR7yFCXBdlFhxmCXWaSlWwqWXfCZclisit0OA+xeSeUaq3RRhp4UA6PCM/
 3Px3G9/0ATEQulGQAAAA=
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=LiKnCuiFv4ZGVKFoQmuhLed1FCIaI4vC5l4DjjzaUko=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07Ev9GZnvhbEi7lWNyyAs0PhDJUw4FswgdwV3
 AmmkuvP4/qJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOxLwAKCRDJC4p8Y4ZY
 ppg5D/9TV51WNCTqRKl9C3ZH+d1d8Wg+AqLI9mAO4sTmN9VLesb0NYn2IwS3ZopOdg543243O+S
 g1UD86z8fwSK2xKzkbRtdBgj2DkafBr6yTzZUzc5zSp1FpY2FCHdSLQh777iR/C6yYrBYRtMC7Q
 i39WlLdvpKkGyHAll+squXs3nBTdcxKM7Agnp5tbsdgJ95xGEytEuRovrCKPt6bEXXij2rQNaAe
 2EkwRZr7t4Fu57lW8nppm++QCmZMFzqKMLPCu5GafrhVvu7ZrxqCDwSiUZ2Ihj5cnew8vp8NgkL
 uQIPQVqhzmAbzqwqe9KF8ml3D735AnY+JzJtmLp2ZfmfSU5rClYNxvGrgTKn7rHz7Jbp8PlSNpr
 7mK34c+owIQsSzyXrTkF7dQm3GxCeyQSJLnmdrdZVC3nEzmKRIp+Cnoo0QRbdbTuZtQnbUQtxdA
 L8Z8vOzKTPru9ybneIspS8eM9rxqLlkptzQEeXp2s9elU0P+SK1Z6f83WUp3fsgKpE/Ddl8N6/n
 AGL6cVwuLwGh/V+mFBLLYgHk7XrIFifCfaaNH388jDUkPnUtLGPe4qZhhqjjGHgoOVnv3GvwO0Q
 nwv5BlV6tNXHKG7TOjO6KWaH/xqDnUV9Y3mSoNHcNXKsDZbiVfK7M85QXO5SdUoxsX9wU4zIu5z
 Wp/qSz9EvgSSONg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the mfd_dev_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 2b85509a90fc..6ad5c93027af 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -29,7 +29,7 @@ struct mfd_of_node_entry {
 	struct device_node *np;
 };
 
-static struct device_type mfd_dev_type = {
+static const struct device_type mfd_dev_type = {
 	.name	= "mfd_device",
 };
 

---
base-commit: d5132d176d6f21742ac67fd311ccc61fe830e999
change-id: 20240219-device_cleanup-mfd-885cbab2befe

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


