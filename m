Return-Path: <linux-kernel+bounces-5940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A98191C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E27285FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F339FE0;
	Tue, 19 Dec 2023 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQElauBz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B739AEB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso59236035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703019335; x=1703624135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80CU+yeod+Yt0peXksdOGK0+bUEHvW9EJ+C21wPANvY=;
        b=lQElauBz522nDpUsXXZ1wByOmJkS3CqhNGcKfTiwPsdwcwHMEFfiDS8iE1JLiYZuRL
         UzwNIh1jEWIDJSv8C/OBGG7p+/KatquGRoNv2Afk0BsQg0N2W2OxHBbvG/NiUTrxVYl7
         Li9RuM8vL4fzUo5B+lchUu3B7d9iySSCOSGmR8a6tEh/RnneQdsIuLe5FgedkU2fnN/T
         aKd+R0bkQhHm/FZmjS9+LUU2LpX4gvd4IQTty9+ZhEz8e7RJn1ghVV/0zJ04/2pMBMTG
         afittzibSQxDVWkQWjoHwFwaYywmc9IrXctQ/H84Vq9yHZZcaqfPxVPd9SfZfAiDPhoq
         OmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019335; x=1703624135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80CU+yeod+Yt0peXksdOGK0+bUEHvW9EJ+C21wPANvY=;
        b=EJc3tDjMiP50VEGP2wdTLHLtMk8cz8pvlONkWLh8QprwFYLl7eXzY7bYYIbtfUl06I
         a1bycM5q+OvNifpQy1kyVoy3Flravyi+9sXXOCEL7QXO3+w6UYWN/mtZnlSACPo20bUj
         vIxRyUKj4N16D59Sw1T7LilyR/ZRd8oBZZRSV3KiHmkVMSV3IMFawxG4GOIUvqZzvHcf
         IYLJppcYlJZC5/e52VBZLVUeBqySA7cv+jqi0r6ZFXjx6dc2cwA8HNOobB47LCiDVXlm
         RUiDJtfzNc3OpNrFuJVNwDN5E9BixUK9e4yuq8iahIbOV/wnNXA6u5PUk4Dqm2CUFDE0
         dj+g==
X-Gm-Message-State: AOJu0Yy9WzURfyT0HN0CokXNGTsy9oBx26Gz2okt9RytnZdCetcx3VgZ
	EqYI+3Avbw/5vUjRKI5EImTKTQ==
X-Google-Smtp-Source: AGHT+IG2dugVLWFhvm2ao0v3lUBqXjvW4cAitD3xDK8EpHvuzvTUVzY5T1+Pd2cLf38ZID5QrW9HRw==
X-Received: by 2002:a05:600c:4f8d:b0:40c:55c4:45f5 with SMTP id n13-20020a05600c4f8d00b0040c55c445f5mr6740557wmq.132.1703019334725;
        Tue, 19 Dec 2023 12:55:34 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c471000b0040c4886f254sm4460701wmo.13.2023.12.19.12.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 12:55:34 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/3] phy: qcom: edp: Add support for DT phy mode
 configuration
Date: Tue, 19 Dec 2023 22:55:21 +0200
Message-Id: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkDgmUC/x2NQQqDMBAAvyJ77kI2OWj7ldLDdrPWBTUhkWIR/
 97gcRiYOaBqMa3w6A4o+rVqaW1Atw5k4vWjaLExeOcDebrjTjo4cg7z9EONGSUtmTd7z4pFR5Y
 tFRz6EFS4F4kMLZWbsf3aPF/n+Qcm8na2dgAAAA==
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=cxCsK5pPL1ouaTVUEaXGUdmvdaQ8uvQZc+vq2k9i0C8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlggM7F52Lzw+szjnLXv9iiHPEH0//KIcZP3WF1
 /Nqreh4KdyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYIDOwAKCRAbX0TJAJUV
 VqOPEAClwnP4muEViar7Pb7gz1K11YvF4s3wy1cyTi7Vldm+EETsNmIs1GVulZ4Lhds7FQ8sdZw
 63s7myZ/N7rSOXn/wKN7cTsS3OVW+xwAtUFwKjQXk38va8EsjFSZZC6ZrmHl2YCWLFG1giptxFT
 13xKGLZc7Exc8d01N055F0h4IqPvXVdHfapdzMnLCiqkgmBOb0pUMSb26Fi2lZn+KnUnE8298Dz
 LbJPUM1Gbq5+x3v4qfe+na5x2UWs8JkXzCrmXsnchxW9cMIa/hnnGtGwcqtfzgdybb8kToId8Xl
 6t3ty5zu7SW2ror7cJJCza7k7aulPQCBdm1KJU472XlJOwnoJ0jGmpbkztHLYPGPAMEgaqHXq7x
 0Dxs3F2XHqnk5LJock2fOIUgfrNP5za9MGveBr8SP5EFoOlr1Fc9mMkU5X9yuPi2WVkzvYfaKNj
 JlV8Mq2fCZwmQ8FzFUM8AFaayfWKwNyCFDd5gqgi1PKqVD/vVoH2ZmIXXmg3tYLqTO3E2ShLunP
 xDnjtPTSCQ7dPxo23OKY4sqFUVoQ+KIED4p8cO7pfO5yc+h9q5BVUZ8JjTGRiyLSu2rIpW9HkKx
 y0yLvKbohlZBvOIrrQDShsbEtzLZ11u3HgPYSSA+Eypizo+UE33ZMG4Xo662ePBSlui/f2+2qQL
 j7a6+1L4F2LdrwA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Until now, all platform that supported both eDP and DP had different
compatibles for each mode. Using different compatibles for basically
the same IP block but for a different configuration is bad way all
around. There is a new compute platform from Qualcomm that supports
both eDP and DP with the same PHY. So instead of following the old
method, we should allow the mode to be configured from devicetree.

There has been an off-list discussion on what would be the right way
to pass on the PHY mode information to the driver and it has been
concluded that phy-cells is the way to go. This means that basically
the controller will pass another value (that is, the PHY type) to
its 'phys' DT property.

For this, we need both the bindings value and the PHY mode value to be
added as well.

The controller part will follow shortly. But for now, lets see where
this is going.

There has been another attempt at this here:
https://lore.kernel.org/all/20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org/

Compared to that version, this one uses the phy-cells method and drops
the X1E80100 support. The X1E80100 support will be a separate patchset.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      dt-bindings: phy: Add PHY_TYPE_EDP definition
      phy: Add PHY Embedded DisplayPort mode
      phy: qcom: edp: Allow PHY mode configuration via devicetree

 drivers/phy/qualcomm/phy-qcom-edp.c | 89 ++++++++++++++++++++++++++++---------
 include/dt-bindings/phy/phy.h       |  1 +
 include/linux/phy/phy.h             |  3 +-
 3 files changed, 70 insertions(+), 23 deletions(-)
---
base-commit: 0e182d9523f6c0af49357fcd812eaa702bd4b403
change-id: 20231219-x1e80100-phy-edp-compatible-refactor-8733eca7ccda

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


