Return-Path: <linux-kernel+bounces-127896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA3895279
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D1287661
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7A1763EC;
	Tue,  2 Apr 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7YfhwwN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911F6A03F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059680; cv=none; b=h8SOWC1cKsyx6lYZ4GN/8e04gL1aws5zjabkLf/3xGJ5WORvZQbPLuWiW8r+j/O5zJifknw+GnN9+P7uzimqkGK91l5oJjfQy8NvPn2rJdLI5eyMwfhUwqoY+uVv6gzdBIJlLg2f5wrk8zGvRCpT93Q1HVZpQ/Py4QQUj/5w7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059680; c=relaxed/simple;
	bh=RdYy7z5iachCEuuENa519b3wQiF8DXGK8dF2mdWEPQQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XqC+fnW8eTceI66+hV/wrMxvTzL52Rt1ebR2+gm3WoRvlUwJms1X7rYouDUzSh6lDvXRib58uR0sVCixGaaYiFV6cDVNxRqHZl+l/h0eXmFuVV5pk9Q6XFqzrNVy+l0+M5HCzizKHO49NLKS3sw8sNy+spxTq3gbn0GabahvjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7YfhwwN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4e60a64abcso314258866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712059677; x=1712664477; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m69UUoZHVCQbx+lpC9u1HsJi4g+Q71GhA5bw8lUD+Ps=;
        b=l7YfhwwNEHrWEcidIpLHdehWC07iSzaZA6sGDNWKZ6QneU6Eu45LBBqsTq6YyxPbsj
         X4EMGEhrIkn9A1mACIXc3Tpicrv+zOF/34hZTU5gH9zTJrx90AN4CXyhJoe94hQlNcSA
         qZrs9RTUgqhWhPeW36+GHcuw+ZPBmoQpKffF3XAXyEirtBMkPP15xBZXaquuqXM1uhjc
         SRb/LozScX0FBl5qKu8r9Qhbwm7XCveocrE0L0PWI9hJ0wOYmK9EqEUKnYJamtUGW3Jh
         bVz98hjFFn4wtMNcsUVoVaizEW8DIA8gafzsl6JXzm1JwFKXlsxVcHkj7Rra+VqE4YhV
         MGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712059677; x=1712664477;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m69UUoZHVCQbx+lpC9u1HsJi4g+Q71GhA5bw8lUD+Ps=;
        b=Vmw30/g5WiHvNl8EpAkJxzRuEPqkBsxXhWu1ysEyLYq+tYAk55qkcJkbyNylR2340c
         CudBKOk7qcPAY1BarMQxef64qZKyIjVc/D7SwPPXHCgCv/anyTZvfyZ8pth2hL8o7fl/
         PC8H/0j3Rm6aO1OqpVWjpLDEgqMksT2iKA0l7boZf04hXPWgYD9YvlhQ6egM3DvVRXu/
         pKURKLJvzyQEVmHvBz2nWOnK5j4AhWWBr3YjjGycKJUq7fGKRynOlgDGWiZAwBcjaQ8w
         HZ8SxTBBpmaYDdOGCiiRBDau+L9jymtGXETzDt3oBYIMyyNoRlRZ2OwfvvxF6ID/A12b
         9dZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV96jiD+ntFg/jxZErU2Zzw1cmFcyQslUiba6bNxdueDyItYNEOSatCXHR2ANu8F6aYBlzfbc8LPYIB6vK18LV+QLR5WuFslex6B7nn
X-Gm-Message-State: AOJu0Yxqzi44tRRn+axLMCc/+lMIz4tuRup/Yl3FvY7aemz23SkfrzFz
	l3f81YiaJuwuj2Zm8Jk0wVevkr3mLmjINHbY5Wo6VnXaFISAITe0fGqd3s/SYjE=
X-Google-Smtp-Source: AGHT+IHKukewzmJeKeo/a024DcR5+ftEC1nxaYgSzsfyeI5YLN2EgwKvBiCBODNT3VgQ0pOifNR46Q==
X-Received: by 2002:a17:906:fb86:b0:a4e:8da0:8646 with SMTP id lr6-20020a170906fb8600b00a4e8da08646mr1172255ejb.29.1712059676318;
        Tue, 02 Apr 2024 05:07:56 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709065a8d00b00a4df251a601sm6519384ejq.77.2024.04.02.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:07:55 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v8 0/7] spmi: pmic-arb: Add support for multiple buses
Date: Tue, 02 Apr 2024 15:07:29 +0300
Message-Id: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAH1C2YC/43OwWrDMAwG4FcpPs9Dlhzb2WnvMXawHbs1tE2w0
 7BR8u5ze1lGwOwi+AX/J91ZCTmFwt4Od5bDkkoarzWYlwPzJ3s9Bp6GmhkCSkDQvEyXxC+381y
 nLXPIvNymacwzN4RWg3Ra947V/pRDTF9P++Oz5lMq85i/n6cW8dj+R10EB+5DpyOB8DoO7+d0t
 Xl8HfORPdgFN5SgFoVccEdOABKqHtSOoi0lWxTVr8DZACGCjDbuKLmhEFqUrNTgjSBvtHHW7Kh
 uS4kW1VWKsOu8lYIsuB2lthS2KFUp50kG23dKDHZH6V+KsG9RulLa9YAGJUrl/1Druv4AyCGlR
 YUCAAA=
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
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=RdYy7z5iachCEuuENa519b3wQiF8DXGK8dF2mdWEPQQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmC/UJKxCvuxK99yI3i9bYhRKNUKoVmH16XdiKc
 Yx2QXkMatWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZgv1CQAKCRAbX0TJAJUV
 VrKjEADJnnbCbiAmLGLCu/YYNS6HVgsakDJBEmQpta9WcQ2seK8Wo5V1pSRzDWhTuNRYDWKL+t7
 +3EA3HJC6a8iQPjbspAI0K1Fe6jOJCzMATd+WX1xvhevZdZuvXQc56thYTLdPphGhg95l3xultN
 q9v42ydzLYkVvAUQ5iA/vlPIvRjBgPctHBxKULKER3MuYLcQ9hJX1574xamT3y0gJSafmDW8FIK
 KHuezQDrSeqBl4on05kEHL9Jy/7rWigX0gXZ+jQM5T6MfRQe5fmlCaBSsSQj8IIX+ZlFeFjXg65
 2mn2aNmDaYh0aonniu2wWVpAVIxSHk5WjgDMnkVrK+5KTXWEfQuG56gMeHST+HMa7qrVQ0mnNkS
 4Mrlq2P+GjDstmEBNJBk1ThyYoOV0kAs2RexUCt1Fv19e3JZCQBZbpmphln6P+joCWks96ZbBKS
 GoWQ3sNKMGKGhsmVveuTUJ2I6Gv5eKeom/sfbepIzedsLSREk/tz6npMZZFc2gwtHTxykNLe8E6
 EA1wZcZw097on8AjRCsF0f6Zp22u66tcQ6A/XzZ/VOpnpNCMTCl4kEGxiNWH2n7XVvKJHpwwgWP
 POYKoZ4utU2QPSxdr6YCHZphQct7mqQDyXgcGMuZASdUt/uJEYak+kx5Q1ovnYDwX7NzxHFAxBo
 rXLq61FEdxc5fvQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset prepares for and adds support for 2 buses, which is supported
in HW starting with version 7. Until now, none of the currently
supported platforms in upstream have used the second bus. The X1E80100
platform, on the other hand, needs the second bus for the USB2.0 to work
as there are 3 SMB2360 PMICs which provide eUSB2 repeaters and they are
all found on the second bus.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v8:
- Added Neil's R-b tag to the 3rd patch
- Fixed compile warnings already existent by adding another patch
- Fixed compile warning about get_core_resources, reported by Neil
- Dropped and moved the spurious core removal changes, as suggested by Neil
- Link to v7: https://lore.kernel.org/r/20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org

Changes in v7:
- This time really collected Krzysztof's R-b tags
- Added Neil's R-b tag to the 4th patch
- Split the multi bus patch into two separate patches, one for adding
  the bus object and one for the secondary bus, as per Neil's suggestion
- Fixed regression for single bus platforms triggered by casting to
  pmic_arb instead of bus in pmic_arb_non_data_cmd_v1
- Fixed bus object allocation by using ctrl drvdata instead
- Prefixed the spmi node property in x1e80100 schema with '^'
- Fixed struct and function documentation warnings reported by Neil

Changes in v6 (resend):
- Collected Krzysztof's R-b tags
- Link to v6: https://lore.kernel.org/r/20240222-spmi-multi-master-support-v6-0-bc34ea9561da@linaro.org

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
Abel Vesa (7):
      dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB schema
      dt-bindings: spmi: Deprecate qcom,bus-id
      spmi: pmic-arb: Fix some compile warnings about members not being described
      spmi: pmic-arb: Make the APID init a version operation
      spmi: pmic-arb: Make core resources acquiring a version operation
      spmi: pmic-arb: Register controller for bus instead of arbiter
      spmi: pmic-arb: Add multi bus support

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |   1 +
 .../bindings/spmi/qcom,x1e80100-spmi-pmic-arb.yaml | 136 +++
 drivers/spmi/spmi-pmic-arb.c                       | 952 +++++++++++++--------
 3 files changed, 723 insertions(+), 366 deletions(-)
---
base-commit: c0b832517f627ead3388c6f0c74e8ac10ad5774b
change-id: 20240207-spmi-multi-master-support-832a704b779b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


