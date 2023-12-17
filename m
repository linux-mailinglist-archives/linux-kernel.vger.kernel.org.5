Return-Path: <linux-kernel+bounces-2712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B89298160E0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592BE1F2298D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740B64B159;
	Sun, 17 Dec 2023 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pU82iBB0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C663A4B140;
	Sun, 17 Dec 2023 17:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA56C433D9;
	Sun, 17 Dec 2023 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833711;
	bh=qi/O3b91lYnNgJ+/9K2p3Y8av0ZfllXz9oYecrH0W70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pU82iBB0nT6NpHJR/H5qaOqAV2CxSyinGNSYiopKSrIsC6oXshoFzPxPEm69lVHjY
	 TR6CIS5ABIuoAhrI90q07jlpwRtOVYfcO4hPo3HYetCV4zhgVYMtkiRZkHCpd9TmZl
	 lmw9HBHZ+LAglcdgaMc98p6SGbmcpRfW7aggX42oo79JTjFy9m/D2y+olWQWDiYCjU
	 qr51Up1zaHZtX51igUyvC+4gDj7bP6b5PEJnS6q16H6OjmXZnsf8Oge1Zpp9lnMNcI
	 EfISHlxN0rnjTOCFuY3gqyBnX5O9VM66qkFNvupy7k8Z23O0cbHb5C0ueVBbvjQGHj
	 jrm/jk+zNx9lA==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
Date: Sun, 17 Dec 2023 11:21:06 -0600
Message-ID: <170283349419.66089.17836984140810815264.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208125730.10323-1-johan+linaro@kernel.org>
References: <20231208125730.10323-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 08 Dec 2023 13:57:30 +0100, Johan Hovold wrote:
> Enabling UCSI on sc8280xp and the Lenovo ThinkPad X13s in particular
> results in a number of errors and timeouts during boot:
> 
> [    9.012421] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-95)
> [   14.047379] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
> [   14.050708] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
> [   20.192382] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
> [   20.192542] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CONNECTOR_STATUS failed (-110)
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: disable UCSI on sc8280xp
      commit: 3581cb91543967ee1a57849116e26036f6240e6d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

