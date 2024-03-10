Return-Path: <linux-kernel+bounces-98241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B12877746
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B602815C2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B742D638;
	Sun, 10 Mar 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="4UJqHlKh"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE42C6B8;
	Sun, 10 Mar 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710080055; cv=none; b=fnsTqDskdJwOW5pjU+hxij2kAGYaTQLtZjykicJztlsjXXFQwEagxpLN+41ukfgssrHEOQXizPz2xtjDcxQjQgbv5gzm8ZdJIlCLtjTC3rKFWds+EEFDJdzOkQniXaT+OWAEkSQ1kv7L+hIoDR/9CF+sEoEsZEyIaMDJedxC7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710080055; c=relaxed/simple;
	bh=VT9me4U8T0mG14wxZ1V0il48moXnWd38XMi/P90Ej6g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DNDmeQZr/wEbxszKe8Qy3Kg9y6V6y47Xa58CL3hrwTT0P5VV1qZK8yRBLAPqptqhwwpDdj8w9YDPwZU+KRAzgFY9NYBvD5tL5QyO8t8C2TkU0zvZsW1tAlrzNon0qbautEnhLWKC76Hg8ybwYJi2QVqtULKzWRi9CdU4qQKZ5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=4UJqHlKh; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1710080051; bh=VT9me4U8T0mG14wxZ1V0il48moXnWd38XMi/P90Ej6g=;
	h=From:Subject:Date:To:Cc;
	b=4UJqHlKhr+H80i/JeqDqWVmleiuKO5aqBWrvKxhFv92MO3TEoQRBBWJSQ2nV6ZTZG
	 Ob/w0JLOVd2Ph8vk+TUpY9WeEepVO7xSOUaUtB49/2q95D62todkJEKn/9+T6Drn1c
	 iz/vUgKRjVHidUxmfccr8Ob3gtfu2i7DM7fIkYkk=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/2] Add Samsung Galaxy Note 3 support
Date: Sun, 10 Mar 2024 15:13:35 +0100
Message-Id: <20240310-samsung-hlte-v1-0-e9b55bf98a48@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/A7WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0MD3eLE3OLSvHTdjJySVF1zixTDRCML8ySDRAsloJaCotS0zAqwcdG
 xtbUAZhzRIl4AAAA=
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adam Honse <calcprogrammer1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=656; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=VT9me4U8T0mG14wxZ1V0il48moXnWd38XMi/P90Ej6g=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl7cAZc+SJOXy9NaYjlz2Zq3gHTMNEp8eslZ7j3
 Qa2e6VXlTWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZe3AGQAKCRBy2EO4nU3X
 VtmWD/9gTPIcCe6KEPgfMKOMooo7oKMhHuy3sEWpf1xKunLLgWxu75yhGCyz6rZGLHrsrk7FmUs
 IPArj0ObjgqK8XdPXOebI7QMHSJbwXUZb6SWz5pQaJpyeDB5Z35wvWLEwxg130oI4ks/Z4mDwro
 F0JskvvbbSUs3WtdAAkT0C/QDqqKRP2BKNE1NNx0Hd/F35scyiUMgmO/0/SGYibkhhlMr6niuIr
 pX/jiObtR3UICt0qPV1RK0eIEG6NJ+2JQw4V+pJxGWV0zpi1dspbipVn9pH5TTj4OUT7EgJvB+J
 ubbEhQBMnD8nJzRgabIbmolsloIFFVPiFWq9zyQ65CuCpWeaKu52BmTDe+QW8DGrBIoyX5HEtxW
 raQXD1Pl2Vn71NlCcU3QSHKkTXmKW5wVk/I1k67NCB87DHGbt9jf6KyxV7sLXCJ0fygSu89YLq+
 FGHdkl2rgvf/GVSwn4f6HrfFTgJEZ3lGfXWT1C7kQN/jFMEDwDUm+2QZmaF/sWEJR/plG1+08p6
 ragJl+ByiALZGFCqghbw7h8Hhp+VzC4swSLYiKRw0J/Vn5amYr0Tlew1j4Y6uOe4O+3Tk1j6d+t
 F/lrYXiluamjIN7Pcm1yHIrx4kluUMOuBsqLaUBa4D7uQ/jScYwbUgTw5BYt/nrcJKj9yAPkPys
 UJo87FdUiRC7YEA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Add the dts for "hlte" which is a phablet from 2013.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Adam Honse (1):
      ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3

Luca Weiss (1):
      dt-bindings: arm: qcom: Add Samsung Galaxy Note 3

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 .../boot/dts/qcom/qcom-msm8974-samsung-hlte.dts    | 403 +++++++++++++++++++++
 3 files changed, 405 insertions(+)
---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240310-samsung-hlte-78d1a287b0a8

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


