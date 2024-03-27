Return-Path: <linux-kernel+bounces-121721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAF88ECF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE3E1F2A57F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC51814EC54;
	Wed, 27 Mar 2024 17:45:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7C14E2FA;
	Wed, 27 Mar 2024 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561528; cv=none; b=k3QikWtBGKPHlqTG1jk00CsHliRPKg2RKWf990Ht11ZBP1FkWmHoW/noJeBaCjdqnseLRGkRc05V3PxVbW9yh5vnJ18BLwE5n0tsbZ8IijSX3y7ShqslsmD00rofAC1BYEmBwghmhvlPNxPBHeDZJOaaflkTVcSKzfjFoMQyJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561528; c=relaxed/simple;
	bh=RnVSD59YYhDiquPHZBqeUmKCnPtQzl1iOsxOnR+gGD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlIUpQv4or67uEqK0u909NsuLZMCWeyfU/bzBtf+/CnjQFVj6HPcTFvmPqQM5ENbGFkmT8f/2txlg9NHm2UTZN9/j3j4khiz57H5KyU4tz0Uw8bc64EgKfBvudWnBF8YPQ7MQNv4GOY3qIK/MvyMc/wo1vBCp4qdqUiRxbkO7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B266C433C7;
	Wed, 27 Mar 2024 17:45:24 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:41 +0100
Subject: [PATCH 06/18] ASoC: rt1308-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-6-86d5002ba6dc@linaro.org>
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RnVSD59YYhDiquPHZBqeUmKCnPtQzl1iOsxOnR+gGD4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsRlUsJoVFHMbWvmig9FH7sOGUyjca3O+TkI
 0tJ+a+BqNqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbEQAKCRDBN2bmhouD
 13JcEACX8uKRocqQsjeeQUak3bmhYYz2LV2f/ss4Lo30G8GkBOnS0DpJMIUrPxSkLEr8CHgHbEZ
 Aj/rDm4n7vH26JJ5xCYwNSV9gi+06QXyIm7TkVSjXZMgu1wbCYChsfRg3JxwS0YMid6AXRGm3OO
 J827AEEBIOy6JT0E6jqJg9CbOZVewNdhCWOHkI/UJG25SXE6eFo4zHWDYKbPyScI7LuSze1RjVR
 yWjO8J4Nnxc6o6BCAm9oKOLwaJGJt6+DsboA1TnXPYCYl4g8YERHIrRG0ZIs7hRHIRG5IqtjTFB
 QRYtDULsGjzio0BgmREAXkOosdmihDgEZZQD6svPyqomDdY0iZMkEydw1FL0D5NTXzRcW5UEG31
 SKO+ILgaqQL/GJbe7G2p+AsfqKd6ibhZK3k71NrW3Fe2mFtwdkxiT5RDwsu2c6z76jQLicqc2Lz
 zK1TfzR2Yh6Bk1ZyS33B+7Odp3tNhFyht3cxy2uIKHPEW6zhx2NmkTmskknvzLb4L83MVOAhYlt
 ZzK9v6W8h1VFj3Vh0/dN8rXiCcEYfLhxQEAnMlWzcyVm3TtQlbHDIGkhSMc7z2Y8drhqHO0oomA
 a/IJyid/FIhAq5nepdp7WdmLOod3evCK5d34od6d4TIpK6KIgJmlTfnWnzE41hbkOV3FKPY//Xc
 uLjNm5LTD1COC1A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1308-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 63d4abf964d4..563df483a466 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -804,7 +804,6 @@ static const struct dev_pm_ops rt1308_pm = {
 static struct sdw_driver rt1308_sdw_driver = {
 	.driver = {
 		.name = "rt1308",
-		.owner = THIS_MODULE,
 		.pm = &rt1308_pm,
 	},
 	.probe = rt1308_sdw_probe,

-- 
2.34.1


