Return-Path: <linux-kernel+bounces-135276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC98B89BE4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395BFB2226B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA146A028;
	Mon,  8 Apr 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k02XDo4E"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9D69DFB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576834; cv=none; b=HcoZ5o0mqDwKlhUYp/uctdhX2Dv1zVbfSityHkvCVpt7XNmuvqY/L7xWUOOKy+CHoqJ38w6JSPZsKH6ND3m4RmSJvAwM0iHMY2FWbK8G59pEG4MOhGnNyxu3jH7odwlWWOicaPROquXZCfrLTRm6LCFEtHbxbyZj8oTraAl99uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576834; c=relaxed/simple;
	bh=OCw+xQuh4YdbSILqfvpnzJNXOmcv3tKcqjIMouYgamo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JUjG33ykFpSMjnZt4gIJJh8/7fwIJJB3FsM/xuGjU1yc0MXD0O1vpxcfUsnyeUpV/jAZoAJ48C/NHrIsSiMDw5XmSAFoNP0qGwWL147pbFQYU6Jb7V0Ce3K68OYM2nseHuMB0l14UqRMnupLOn99/4P8FylN0vDn/9xh/nSw5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k02XDo4E; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516a01c8490so4538035e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712576831; x=1713181631; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4CECCu3MBUSlRHHcQrKbVWoxW8wqkifPadKm6l7qAw=;
        b=k02XDo4EGRAeYDxg7NrtcHNbfO1usQtQMjGGZVcgJsQagqvFg6Q57W4G3AAmbXxATl
         SSh5gZ6QJpldnfhHcPz+tuf0N1Urq7sLSpByNfhoAYkuncc19QvUnYQwvwyu//lsZu6s
         6xF8WYtDLgLlnuL8hSGX/Cx/xYXSljU+qWV2c7dX1aJst42dniaCsNZvhkan7QQzcC+r
         tiXm9WTgZB9uPebmYLtEohJp3d2lV62iCGfFxQLbmIDNBFRS0UWFgG1b5wtk00tRR80R
         oc5cJ25ZQB4V3ON7p3qXn7oecMqp5irfhF92nII2zEvii81iS9vHUJVzqUkdnBEVh2uI
         IrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576831; x=1713181631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4CECCu3MBUSlRHHcQrKbVWoxW8wqkifPadKm6l7qAw=;
        b=I5WKJLFSqeAvippsex/KnJ0vQsrdv2Eb6vW9EI5a9o2E4pbT6T8l9loLM0ZFG9FhPt
         sZCXYYuIZGoCsPAevsQUQqZihLrDgA8fxN36l3gi3PtGyZcIWUirwxl+cPFNQ+1uww9Q
         1X+w35mDZH2tE1xxQQixyQXl4eIxy1lyoutVdDWs7CtBJXj81VyGtXpNrE/OmOPA6ngt
         026VGrV6G5++maoRkdv2z5jXbl+WVNhYR73daxbkvdLMaspnrnt6lMSg+B7jt3P5Bio5
         E7XlwOR6oCU4LaTqOQMzqK4J54xdAb5EVgTwlUgDwlP6nNDwzx6J2bWsxtr1ZttDWvVN
         FIrA==
X-Forwarded-Encrypted: i=1; AJvYcCUziCDTB5AsdytYBmWbtD03iFUhL0urpFbWmJlz+02nVbdmnD5PhqWNrZx0cRR+eCBKeMHXoyy3ER4ctYDzbvaBK3/in2adcKd/9RQk
X-Gm-Message-State: AOJu0YyWYLqjtKY3k4bf33JoEWtwOPW3BuvaipLDOVmNyqILi/w3sbJY
	fy51/SlVMIZHf7w4Mr0KhjiD5jUfCBprVWsG4dLxIV11GT8QGidoQQOVCZ8GKjUxOlCBzgtlRDI
	v
X-Google-Smtp-Source: AGHT+IEV8/IlmWW24mxauQOQbiLMdKecVoMb6PsEktLHW0sazG8snQOU+FF6FDDuL1+km+u43MvsDA==
X-Received: by 2002:a19:a416:0:b0:513:c47e:d811 with SMTP id q22-20020a19a416000000b00513c47ed811mr2880316lfc.33.1712576830717;
        Mon, 08 Apr 2024 04:47:10 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g17-20020a19e051000000b005158ddab172sm1175549lfj.19.2024.04.08.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:47:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] clk: qcom: dispcc: fix DisplayPort link clocks
Date: Mon, 08 Apr 2024 14:47:03 +0300
Message-Id: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfZE2YC/x3MMQqAMAxA0atIZgO1tqJeRRwkjRoULQ2IIN7d4
 viG/x9QTsIKffFA4ktUziOjKgugdToWRgnZYI11xpkWg2gkwhCR9pM2Rc/sg+9sU7sGchYTz3L
 /y2F83w8NdG7WYgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OCw+xQuh4YdbSILqfvpnzJNXOmcv3tKcqjIMouYgamo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE9k9b0mmAcS/8Pu/Mvcy8UXWn7UUtjIBH2yqj
 sc6FktUi+qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhPZPQAKCRCLPIo+Aiko
 1TdVB/48GnfmnOEjLURRPoOvYCacC0pISv+HUdjl9KVcguBdrCBP1vh+uMOnLwGutnsMiKhSVuM
 KBF3dPKy+0QtA1KPIKxFBR1LMMGX4ESGRBNVVyljSbRcyOL6+4ZV7ThHUGMbAbEu33YpOCiHB+g
 8zp/QODqCdyemKVVQuwhaQaKcpYon9kMcd1PzKj2jAgZe644jGWXFtU8XCF3cbuS89OmFwu+H69
 pj4WmlQ8oMU5SANfZMViiv2hO5IDy1ZvJxIWUjsY7qjQmT53ymEAuZtQabqEK1XAkt5WhTvKFaD
 NFRGXeHKEDKfvIwqPTqvseT8ii+QvCSCpqk58qfnIZIoOYuX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On several Qualcomm platforms DisplayPort link clocks used incorrect
frequency tables. Drop frequency tables and use clk_byte2_ops instead of
clk_rcg2_ops.

Note, this was tested on SM8450 only and then extended to other
platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      clk: qcom: dispcc-sm8450: fix DisplayPort clocks
      clk: qcom: dispcc-sm6350: fix DisplayPort clocks
      clk: qcom: dispcc-sm8550: fix DisplayPort clocks
      clk: qcom: dispcc-sm8650: fix DisplayPort clocks

 drivers/clk/qcom/dispcc-sm6350.c | 11 +----------
 drivers/clk/qcom/dispcc-sm8450.c | 20 ++++----------------
 drivers/clk/qcom/dispcc-sm8550.c | 20 ++++----------------
 drivers/clk/qcom/dispcc-sm8650.c | 20 ++++----------------
 4 files changed, 13 insertions(+), 58 deletions(-)
---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240408-dispcc-dp-clocks-5ee5d5926346

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


