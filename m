Return-Path: <linux-kernel+bounces-60633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D7C8507C3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 05:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E391F23325
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 04:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54A171AA;
	Sun, 11 Feb 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH16CUPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDEB1102;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707626253; cv=none; b=j0pXIjHqRNRGyVe6JeRAz7N1ljedYCQzg78pdKWi/ZDaa1FsbzQUdhtWscNpwWiyKUDz8AgEGGHHKQ8MehSXkr7u0qXRA5bJ6g+Py1veab/NdcACRjaC+X2Yn+gl+Ua3mGWVnJFppQc6AbyaVTIkhaxOu7QCDgLhbqu/HPYfWnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707626253; c=relaxed/simple;
	bh=p8UKy0GQ+pILMVAt3l0Cq9hdX0ZMkXzGj+SrMELt91k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VbfmFHuRPT0aWBW7PGJlg0o5lzFooVsapSFSr9WS2d41cSNGx+F29JZp7yJXNouuNs11xmVVcHTL3EfeIk3jmAalqm7NeedM2gnktmvo6d3aDg3c61f1FUNe87ZV05BTMgEWa/xr8zVz/9IeGXFSp8TTcb6jKI4Es2ymGqSnQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH16CUPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B65CEC433F1;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707626252;
	bh=p8UKy0GQ+pILMVAt3l0Cq9hdX0ZMkXzGj+SrMELt91k=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QH16CUPGspvI9UIkkFWC8+zI6EraA7XbZX0JqE8wZ/Bkl3m1ktRJ9+j4Pl8FwaX8K
	 VXIVLKkjP105gcC4ggeZEqwi1t96h2psaTMqSXhhOtNcEBSYxdm6BSFfBHO6Zymya9
	 uqQ7zO6pphV4oizpmG433G2KRcRQvtJEF+LXn3e6e8c634ikH/zxTdxqelb9LgN/zj
	 xS0rh0JK9eNX4ekDGgmxdQ8Zub5wio2JU8YbBsmhfEohlk9oZ6JB7j/TdfakocoIwH
	 8CptZ5Bncct+tk6KHKDT/0KTfAPS30pgO6LFCKsB6oH3BFzhuNwe386WrBcB10mode
	 4wde5wEBTddZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EBC4829B;
	Sun, 11 Feb 2024 04:37:32 +0000 (UTC)
From:
 Bjorn Andersson via B4 Relay <devnull+quic_bjorande.quicinc.com@kernel.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sc8280xp: Make pmic thermal-zones
 report temperature
Date: Sat, 10 Feb 2024 20:41:58 -0800
Message-Id: <20240210-sc8280xp-pmic-thermal-v1-0-a1c215a17d10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZQyGUC/x3MTQqAIBBA4avErBsYpSy6SrQwG2ugH9GIILp70
 vJbvPdA4iicoCseiHxJkmPPUGUBbrH7zChTNmjSFWlFmFyrW7oDhk0cngvHza7ox9qwMqamhiG
 3IbKX+//2w/t+FUXF02cAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=p8UKy0GQ+pILMVAt3l0Cq9hdX0ZMkXzGj+SrMELt91k=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBlyFAXCdaUKkvSlYAd8UArJS3UMUBxKul4YaUtl
 v/e5SGNKu6JAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZchQFxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVzhxAAuFeGH9kv7BHw+9K4B68KMl+qBPdajShULMrA8DL
 ZiRtjUGa5CPBdEXQMBSuDvamE8MwgaR6ErYYPISnHyQw50NXKaJxxjcQIs4s5N92dS+sljPh9ay
 7GetTcoYcHvm7JxhPNrNrXrT+bgjFej5d636q5WXgfpTQg6vb1shdbSF2X1cwKgQECNowbVJmUW
 WPqpkWQrpqWA2kAVygcN/UynSJc60s35v3CZ7HwRVL8GGvEgOruHy3atAc6uH4W5TcHVkQE/szv
 QP7WPHDpIyccZ5QUwB6yIb0wFpXbszWdanlHx6ireEa74cu+797l2WTNbZtJkZ66VFjMSRejAMa
 nJx1HTDw1ppvIxDQwt65K371eYHBlV2r7dnSuMoemH/y1+qcmgm7OklK6fga829F+vOW8uWh+sQ
 dKZ4uzvvBg8ySNLoEOSCWlvew92OZOUo7qE2FnYGwCSc2GlgSz/TlgIkB/YpGpeSzR8tywcQPkK
 EOKJ5eVqrqnq5AiZgtO+QxKIJYwrdBbl4DUxVoBorOSxnCXQtmg7in0fL9wWGPkoBfPwyDhTDMl
 6YGWLcbIvrRO7C2x63qXneL1gEgeah4FGAbwo9RQoFyAXqSwuly5fvp/KrtMNHzBGtWATmW2kZE
 W0gmWSaHp5pXIBBELJwz6Wl7c5ByYRJqlYlQguUi4sY8=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Endpoint-Received:
 by B4 Relay for quic_bjorande@quicinc.com/default with auth_id=118
X-Original-From: Bjorn Andersson <quic_bjorande@quicinc.com>
Reply-To: <quic_bjorande@quicinc.com>

The "pm8280-[12]-thermal" thermal zones always report 37C, fix this.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (2):
      arm64: dts: qcom: sc8280xp-crd: Add PMIC die-temp vadc channels
      arm64: dts: qcom: sc8280xp-pmics: Define adc for temp-alarms

 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 37 +-------------------
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi       | 39 +++++++++++++++++++++-
 2 files changed, 39 insertions(+), 37 deletions(-)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20240210-sc8280xp-pmic-thermal-fb56e166507e

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


