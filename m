Return-Path: <linux-kernel+bounces-3851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39CC8173F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FDA1F23493
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999A200C0;
	Mon, 18 Dec 2023 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+8+vqN2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E01D132
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso3688840a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702910599; x=1703515399; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpcDXuZ7x+uQPs/Zkfwlb0u5vgMUhOXsRaEqBjvJ8Fc=;
        b=M+8+vqN2x0BcK2rtvXS62uPGNTlycoyvw5SvLE2MDrtXeW0IgozlhgVxlAXqigAksL
         rTaP/nW0z5VLBuqgThTLec2iEWZ1azWmAhY4MjaNYxPdJuZh+2q1dJ66rGLCsHNGX66A
         +yxfqqs3xGOldFoV+Ej3WTFilRdd8fyY1iyWvoIDW4iQ9GJriQHtXw2jdoitmN7/Yge6
         ekr2ntFf12hvfbZebm75fjzOjA/ukjXvgnDFabB44UDjS05PEGVAhfvveDoDujGuqjW6
         bmUHjv4GrEmWLVE/F8e0i6AWf3RE/YJybHdnG48eyaO2iVDt7/nBJ8ZUa/gnOePbfobv
         ef9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910599; x=1703515399;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpcDXuZ7x+uQPs/Zkfwlb0u5vgMUhOXsRaEqBjvJ8Fc=;
        b=nOc1SxI+mDpKOUftTDwQcBBZC9RyWBhbgLJ3yWj1XK2IiFIhbcte9SHyWp1t1i5Ese
         lbBcoxB/jyH0gD/IzvSynuYmk6QS4YAs5VAT7ZgJ9jNDEhH2sat8YtTWu96Ukcii5RyE
         93K/ZQnGEy03651vcO8sOsUjhoWldNvtHisaBFYaBdU5vd8Z5DM76YdPJz2LpHqfEzSB
         XcD1/wtr068iCay4ilde0EgmpyZbMhmnFjzQ5dOJIusCmJWedtJdmhZ1papyDZrio5kZ
         J0/0sV+yQoAk4xBThHzJYPhP3Hy6i4agFZc//4iyJOcP9dDOtOkfos9/3ztu0sBbv3ru
         JmzA==
X-Gm-Message-State: AOJu0YwLlGZMwisWw2IPODwbvec+dIfBwqBh44kMEVU/tjdyEtuBp2z5
	6aUFK7cBsaHV3WcF6Ii+OhM3gzUddpAZ7Lk8lyk=
X-Google-Smtp-Source: AGHT+IGpTImty6GlvzmW0cAb0Ssk5uBNlkyY5DRsY8SQOKihdU79s6cZZtXHwqkWxQLysArNIsysPg==
X-Received: by 2002:aa7:c049:0:b0:54c:4837:93fc with SMTP id k9-20020aa7c049000000b0054c483793fcmr9295964edo.67.1702910599165;
        Mon, 18 Dec 2023 06:43:19 -0800 (PST)
Received: from [10.167.154.1] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056402207200b00542db304680sm10548764edb.63.2023.12.18.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:43:18 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 18 Dec 2023 15:43:14 +0100
Subject: [PATCH] MAINTAINERS: Add missing drivers/interconnect/qcom/ under
 Qualcomm support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231218-topic-mntr_icc-v1-1-807541882edc@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIFagGUC/x2NQQqDQAwAvyI5N2AigvQrpZTdNNaAXSWrpSD+v
 aHHGRjmgKpuWuHaHOD6sWpLCaBLAzKl8lK0ZzBwyx0xDbgtqwm+y+YPE8FuYMrU9qTKEFFOVTF
 7KjJFVvZ5Drm6jvb9X2738/wBGiHWqnUAAAA=
To: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702910597; l=823;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hlE7KkvP3L8y9wotwENJSdBnrN2A0h2rbnugWJ3iAWU=;
 b=opCTsI52L4f0Ye3LIffhMCRnP6zzIUqrAesWYsN15OIMRpnQtRYEaE4bmau2UpHqmvgEPtIx5
 Ucinuxp+VBXBu00o4FFj6OGKawp41Cija1HZEWgdHbqN949e/S8AnSM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Turns out this entry is missing, resulting in patch workflow tools not
picking up Bjorn's or my email.. Add it to avoid such issues.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d984bd745e93..290246284ade 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2568,6 +2568,7 @@ F:	drivers/extcon/extcon-qcom*
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 F:	drivers/i2c/busses/i2c-qup.c
 F:	drivers/iommu/msm*
+F:	drivers/interconnect/qcom/
 F:	drivers/mfd/ssbi.c
 F:	drivers/mmc/host/mmci_qcom*
 F:	drivers/mmc/host/sdhci-msm.c

---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231218-topic-mntr_icc-3821b1051ee2

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


