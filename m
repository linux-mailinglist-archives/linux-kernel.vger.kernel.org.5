Return-Path: <linux-kernel+bounces-76635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4955185FA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B91C24A45
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300D1353E2;
	Thu, 22 Feb 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXIpZs7D"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087C3EA77
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609944; cv=none; b=lmWKVuE0xXSY60I8IWnRmw94eI24/zqpv6tzt0GsBjNP59Pzx5ncMWEFSPRsrhpLjjPqFSWMDvhKmYcnqrYfnP8BhfoRd1LObnsNMHUHQ4mDF5ULKY1wXBt2xHoXgtVnuc+O/YpHkSRUvf99wudce7JhW13zSPrLxe3wP+/oDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609944; c=relaxed/simple;
	bh=9rVzNTAAYXnMs7MfpROp5deA4r6Lb7fRQnEpmwvz2mE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xm2tWEUHRUBltJ/T3zWyn8MnAjg3TmvbrS2qS/WN/tijSEMkZ/Vt8GzlUpb3MkN6qARmK0k8x+85Km1ustrf/lCTHRFeOyKp7buO8mVwh22OPwkSZinODhgFfedGz0BS5F7Tt04fHnFCPxBwy8gI7k+Wbn7cVFM7OCOWDZ0FREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXIpZs7D; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a293f2280c7so1137059366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708609940; x=1709214740; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KkwALuuS9M9PSFBFc5tMoPkB9c/kjBr1oSlzVPQUlEY=;
        b=uXIpZs7DKUKEYQkJzFvRgT3R+GAPTYpgTCXxTRj6RnETgY0hb5LrAio2r47fI3Jd3+
         ZFvL00kR3RSERwFPdDrfw+GONx9Up80zeuc8OyW2TUB2c43NB0ymZRb0axmUPZAB9Qsb
         52BC5SOpXx9CzKCr/lLIiJ3TgpY/9YaBP9WjiwZ9eqV68mVCFmd9zqBt6rg2Y4Po/vlh
         R3B3gbBPuv0phoD8VTm482Z1HFkS4rb62X4drRlpy46yHuHXhL1SLjW1oR64diadT4vq
         KjXSwQQgXKhdUqVtuKM1MdtvEIF9fvoiOji+SmPsE65nS/CQ/kOZLaPvDgI4tBZv7Ait
         lIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609940; x=1709214740;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkwALuuS9M9PSFBFc5tMoPkB9c/kjBr1oSlzVPQUlEY=;
        b=vPcKodFGLBFCh7ZJmt3HB2TKLuLspRhR3YmnJ8nnpD/wYOS/BOFZtH5BQaPExjdfPQ
         rsqB4VvU7P9snrXqeGmQSQToJggjlrdPXS1sHxCrdE1gYTfJeG+w4ldKb8V/BdFTPBhs
         lIeSkkZT9XMtjr4lTEJdqsG/FyXyP66ievtEvMzAGAQ1FtqmDZWGzRUluS9cBLNVhIJe
         oxChtAfPKLpJ/SlNMeXzPNUJ1xgdH9kNG3TzENLIPG/JsOC0CRxLen+Ghqe0UZ7i3YBQ
         Ar8J1u6TAbVH3YkP8SV8DlGwKagLlirHuFWXnkK7K580RuTZp4PbNOPjcg56+RziFBR+
         i9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUskpKsNWwQBoWQsvbdja5McZlLvXmOGlwT8DnFscHy9+kW4Qj2worAjNf6ZsuY5l1ADREsf2v/DrmWUIP+WxXNTFi/z9hDqxseIU8D
X-Gm-Message-State: AOJu0YzbjVzirnXlBVtyV04UqpKZeD4uiBpKOxYnDFIxx92SaMjBm9+f
	EEwbgKdWCZY15PLGwo8vMihkDOkf/5GuKJue/2dEhkpsDZz1HTtYOdiewNmbUPg=
X-Google-Smtp-Source: AGHT+IEELfLxUsEw/wegIN32tw4xel6QaTJaQ7ZIgjPnVyn4Lso+bKU8EelVOd8FRy1aWXX1guCfWg==
X-Received: by 2002:a17:906:69b:b0:a3f:6302:1e61 with SMTP id u27-20020a170906069b00b00a3f63021e61mr2427516ejb.73.1708609940572;
        Thu, 22 Feb 2024 05:52:20 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b00a3ecdd0ba23sm3382839ejb.52.2024.02.22.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:52:20 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v6 0/5] spmi: pmic-arb: Add support for multiple buses
Date: Thu, 22 Feb 2024 15:52:01 +0200
Message-Id: <20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJR12UC/43OwWrDMAwG4FcpPs9DluzY7WnvMXawHbs1tHGw0
 7BR8u5ze8oIhF0Ev+D/pAeroaRQ2enwYCXMqaY8tNC9HZi/2OEceOpbZggoAUHzOt4Sv92vU5u
 2TqHweh/HXCZuCK0G6bQ+Otb6Ywkxfb/sz6+WL6lOufy8Ts3iuf2POgsO3AelI4HwOvYf1zTYk
 t9zObMnO+OKErRHIRfckROAhN0Rug1Fa0ruUdS+AmcDhAgy2rih5IpC2KNko3pvBHmjjbNmQ6k
 1JfYo1ShCpbyVgiy4P9SyLL/Uqumg7wEAAA==
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3091; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=9rVzNTAAYXnMs7MfpROp5deA4r6Lb7fRQnEpmwvz2mE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl11GH+c4If4nAE5FyaKTtc/3NCAvH3/McfFiQ0
 EdOWR2irGGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZddRhwAKCRAbX0TJAJUV
 ViZ0D/4oKGeePCJ4orbhRWOkHQQ3C76zvhHTi62Jnmh/9BH295YEYcH8MfACfkUgDBlS71WKaEq
 cWDTuob8hQ4ZlSjTBmMEG9SKPvSYUIwgOKO2RQZcaJnoCtNcT1hIswNSLS9v3PnO4gjX8XWbXpW
 nGro6zGnkOc+yRDyrBw5I2gG4azgiGVdRPplw9nyj96gnGxBxkE8KFNBA55Kg8C/shBTy9FrYcO
 JrDzlP1ApPjJcknVOqjen+dvQys5DuWeTYk3W0uiXgD8OTrTCC81mO7RZk9FCOk/Ub1ehu/OGJW
 iHDUErCFD91TvYnd/hng5/w6jUPqT+Pq9ltSO8W67gpK8XMsRAaYN5EEb7D6mHoZarJdVbFJqGj
 W+347CHkmCK9OpGTheyBRNVy2+BhGj/kDfeejdR5bqQ6z1mxkswp9/s4HkvOlF6pQgQd4olkul6
 WZ9alv9v3yRRqzGcczy3iD+7r+5WS5tn+/qH19ZMKtpboUW/8PY0LEm6aarESXi/pA5n638rN56
 wRq8U0cxMV8G3P+v/wdgnnpXRp0u9IF2+Fr2jasXGVua5aky9FhmEdNdYpF2mBPfKKJDJhFsw7O
 YJ0S/7DfmcAJpR8UcrvdYzX4KXWom6yWz+goyKx9B3GNT/bAAv+eRrs6GnFWN58vFP0QkOpQT3g
 7VXgTcLlQ8TTVRw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This RFC prepares for and adds support for 2 buses, which is supported
in HW starting with version 7. Until now, none of the currently
supported platforms in upstream have used the second bus. The X1E80100
platform, on the other hand, needs the second bus for the USB2.0 to work
as there are 3 SMB2360 PMICs which provide eUSB2 repeaters and they are
all found on the second bus.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v6:
- Changed the compatible to platform specific (X1E80100) along with the
  schema. Fixed the spmi buses unit addresses and added the empty ranges
  property. Added missing properties to the spmi buses and the
  "unevaluatedProperties: false".
- Deprecated the "qcom,bus-id" in the legacy schema.
- Changed the driver to check for legacy compatible first
- Link to v5: https://lore.kernel.org/r/20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org

Changes in v5:
- Dropped the RFC as there aren't any concerns about the approach anymore
- Dropped the unused dev and res variables from pmic_arb_get_obsrvr_chnls_v2
- Link to v4: https://lore.kernel.org/r/20240220-spmi-multi-master-support-v4-0-dc813c878ba8@linaro.org

Changes in v4:
- Fixed comment above pmic_arb_init_apid_v7 by dropping the extra "bus" word
- Swicthed to devm_platform_ioremap_resource_byname for obsrvr and chnls.
  The core remains with platform_get_resource_byname as we need the core size.
- Dropped comment from probe related to the need of platform_get_resource_byname
  as it not true anymore.
- Dropped the qcom,bus-id optional property.
- Link to v3: https://lore.kernel.org/r/20240214-spmi-multi-master-support-v3-0-0bae0ef04faf@linaro.org

Changes in v3:
- Split the change into 3 separate patches. First 2 patches are moving
  apid init and core resources into version specific ops. Third one is
  adding the support for 2 buses and dedicated compatible.
- Added separate bindings patch
- Link to v2: https://lore.kernel.org/r/20240213-spmi-multi-master-support-v2-1-b3b102326906@linaro.org

Changes in v2:
- Reworked it so that it registers a spmi controller for each bus
  rather than relying on the generic framework to pass on the bus
  (master) id.
- Link to v1: https://lore.kernel.org/r/20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org

---
Abel Vesa (5):
      dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB schema
      dt-bindings: spmi: Deprecate qcom,bus-id
      spmi: pmic-arb: Make the APID init a version operation
      spmi: pmic-arb: Make core resources acquiring a version operation
      spmi: pmic-arb: Add multi bus support

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |   1 +
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml | 136 +++
 drivers/spmi/spmi-pmic-arb.c                       | 948 +++++++++++++--------
 3 files changed, 715 insertions(+), 370 deletions(-)
---
base-commit: 4893c639cc3659cefaa675bf1e59f4e7571afb5c
change-id: 20240207-spmi-multi-master-support-832a704b779b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


