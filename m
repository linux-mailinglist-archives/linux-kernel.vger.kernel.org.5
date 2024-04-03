Return-Path: <linux-kernel+bounces-130280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C3897663
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8896CB23362
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D47156642;
	Wed,  3 Apr 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+YDDRVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234915624A;
	Wed,  3 Apr 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164629; cv=none; b=KgjIZ4fJ5xzTpI0gdVuHeKRMpdQWaIUCl8JyLdTL4E/ngHNYuUtIxCYCWKT1rOav0IHYunx0lcf0BXBTND3m+5eRo+xneK/mDJYa1d/OmVnQbkXy5EnvlA6K5H1YAhOOcf7MH9MzvLXymQpk7xlIknBrLoESpQgsiu2rFhyFSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164629; c=relaxed/simple;
	bh=Zn5wn0kqoMoJLsOdJkyiiiLhytKrNfn+abfwEXBjxww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJVfaj37HQP/ndPLaAn7RWjo4/jXNw+tWKYPdZBevUX0M8f5Qmoe9GwdqK1xwYv5uQBl8eYfTU3iJDcjd+Kta3y+YszKtDw9Ysg6QhsKniRC7WqYLdsZ/ukMvgXqfR1NyPloHLpdobFXot1sM6Bnvw38LlyFYll+jEgo6qH+WvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+YDDRVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9188C433F1;
	Wed,  3 Apr 2024 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164629;
	bh=Zn5wn0kqoMoJLsOdJkyiiiLhytKrNfn+abfwEXBjxww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+YDDRVgJXkMkMfs6lex0yPFbZNN25dtT7xmgLE8XtpHcPAPQ7MzQXBH/zMt2E/cT
	 XQZEtNknIUJiaq7khVBmmb0/KQ56ZFcS3M3C3bDYeTI3XU2jrU8uccMew0n36Zdcu7
	 g4G9z9ZfqlvAK66YuwHURsihQf6XkEV5vubU8YdXJiIui9hFJdUSvPRZ6BxQj2cw2l
	 Bk3X7hPE6HjOV5Xv0dv4RACu43ICiT7D0n5y4hPa/TQOunymaDf6tHmzqtAZurZpG5
	 fXJrVSkgLm7vyVW14t6C0zTJtvpxqxiigK4c3vyva6u0DKT4d2J4r8fuu/jXOmeuYP
	 HJO+tYtyYobGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Weiss <luca.weiss@fairphone.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	herve.codina@bootlin.com,
	robh@kernel.org,
	minhuadotchen@gmail.com,
	quic_kriskura@quicinc.com,
	johan+linaro@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 06/28] usb: typec: ucsi: Add qcm6490-pmic-glink as needing PDOS quirk
Date: Wed,  3 Apr 2024 13:16:08 -0400
Message-ID: <20240403171656.335224-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit 88bae831f3810e02c9c951233c7ee662aa13dc2c ]

The QCM6490 Linux Android firmware needs this workaround as well. Add it
to the list.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Link: https://lore.kernel.org/r/20240208-fp5-pmic-glink-v2-2-4837d4abd5a4@fairphone.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index faccc942b381b..932e7bf694473 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -298,6 +298,7 @@ static void pmic_glink_ucsi_destroy(void *data)
 }
 
 static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
+	{ .compatible = "qcom,qcm6490-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
-- 
2.43.0


