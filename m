Return-Path: <linux-kernel+bounces-42301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA8383FF51
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432161C23615
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D3524C0;
	Mon, 29 Jan 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7uXVklI"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41351C4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514751; cv=none; b=EE4hszcbu1EzWKzjpg1KWlLsHgqLE4oMH6yLjq1J7/cJEnprSMzlbrrLxN01TvvZGp9VBARzdjHrxd59ASqNEqaEic/e0I9ovsObAjWrRwS/ydXYBu6NvRBJyMX+Z6XkkJj5BG/jZ+1kRtK1VfDp51gyLyl2i7Gan9eY5UTa/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514751; c=relaxed/simple;
	bh=tTQT9Ku7RM1FLsAH3vWmzrAWVFN9wIhJQ1xDZJNKp4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+reR/svefSAclpb2qQA3Aqjy6uBZFvAA0OlBX95CtCUJOzSyMVNGJP4mcJug54DkPjhx1sgpjJhUaShdMgD/scNb5GhqkVeRy+HnDURa+pHXqN1vnKILptlGEaTrgE54ChOm5EkyaSLEtH4tmlAy7udDtGu3Kq9S4WuXGGGCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U7uXVklI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dddee3ba13so741002b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706514749; x=1707119549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKwoviPF9lK3MXodrfrYqIC6rePNJHWY3NWvE/KNFG4=;
        b=U7uXVklI6V+bqjGhgkCveo05yEQd8svuDNluOwLk9kJWyR87Vq9dza+UeLyCi3Y736
         x7mCw6gnmQWuujnQK+ESYbgeg/jDauLzM6sPGoJf884sfSois95itnIJRXW4DeXPL04Z
         plBzn3DZyLDKlU2MnTMGGWcOjX0zRquAPVCgSzJhrxWAhmEr608id+DS/0kqi+dCKDBB
         tiPTHqE0uIRLRCVI/s5nk97ijqEec4igZmYsi93Yt4M92BjWXTBBDC4yiiDvB7DtLuBA
         lRivEjK61IvUSUlYDW0WP9+AHpxMWsWWyiJ81r8sPWTyPssp+4iUADkRateto+HzIHku
         R3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514749; x=1707119549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKwoviPF9lK3MXodrfrYqIC6rePNJHWY3NWvE/KNFG4=;
        b=IM1xypIZFipQ6u69VeG191vhC+c8laE9dbPmxJflWNzz0mFVrUoItqp/uO0yUvh09n
         apPND8KiHCp0DGqVnEM8NJl6Z/7X+oapmf4gr8Bz8yHOPLHDyl5NeyTqx7dqv2saMICr
         X7bUPGE0GpAq2mp2fAfsnkZ7dKlI0ZH1eFG5+wbv+5NFRa2O7iJb8c6cW+soqacEoSIt
         dPRqltgHeHLEGukPHSCFbX5xXn6wiEUzqC/+r79g65BHzVarMDm9UAib86ePlrLCsU5/
         axhY1pfec3eNowv46DOD0njqveKC3Bz2fWls3Il//BMdY4+OB1SYIAXSrr5H8wrOvx8t
         bF0g==
X-Gm-Message-State: AOJu0YywFWCbq+aawxG96xJDAoqhBpRdlUkLrAIF2j9Ke+DuCdRG3/BB
	Hwx0g2xYWHrps7+RzoAX0QQ+Ylegt+1o3m6FF1Vh1+Sj2p4UZhIYKsUDlpJCq6323XiVwgspuE0
	=
X-Google-Smtp-Source: AGHT+IGeqfu9dp2sjT94pd6qtcHQFzY9slmsKzbOpFB8yRIcm2BqugXLuSHM1wzJ+Y/sUQaIjfRiow==
X-Received: by 2002:a62:d159:0:b0:6db:d4f8:bb1d with SMTP id t25-20020a62d159000000b006dbd4f8bb1dmr1559157pfl.2.1706514748782;
        Sun, 28 Jan 2024 23:52:28 -0800 (PST)
Received: from [127.0.1.1] ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b006dddd685bbesm5467329pfl.122.2024.01.28.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:52:28 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 29 Jan 2024 13:22:04 +0530
Subject: [PATCH 1/3] dt-bindings: ufs: qcom: Make reset properties as
 required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-ufs-core-reset-fix-v1-1-7ac628aa735f@linaro.org>
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
In-Reply-To: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Andy Gross <andy.gross@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=tTQT9Ku7RM1FLsAH3vWmzrAWVFN9wIhJQ1xDZJNKp4M=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlt1ku3SWI50z6DJN+7R7fmRweEhh0xY3/ioY31
 p0C1ZBGJuWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbdZLgAKCRBVnxHm/pHO
 9SXMB/4ye39b1v8wXzuxS/o1v4RtjLlLVKqi/NF7kJjRDBql/AeZp2Hf9+s5yn417kUWlbcsLVO
 Hv3+1bV8Qbw+vY5P9VNH9VLyX1ZbqEbk45/TCxNp9Hf++u25PNjappM18E0ZRSOZ6EIFrmMHdXl
 eMcLxBY1kDQjvrbiawIdtPEG7SVhafiLkxL/cnOfCj1bWhvr2n/LljnEtLqsu9eyjHnrXmEjSTI
 FoGhc2e0gJCJADNnkl5dQLibYNJYd+8yNws4LHbb1L3+A0AfU/lTkaSXNsBnqZ86OO+Nsuj2kWn
 OpJjH2fcgHiXyuNP7M6bKXa44uyTFSawclFl3gxssnvZ1wIO
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Apart from the legacy UFS controllers that were not supported in upstream,
rest of the controllers do require reset property to reset the UFS host
controller. So mark them as required.

Even though this is an ABI break, the bindings should reflect the
capabilities of the hardware.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..03dce5e402d1 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -108,6 +108,8 @@ properties:
 required:
   - compatible
   - reg
+  - resets
+  - reset-names
 
 allOf:
   - $ref: ufs-common.yaml

-- 
2.25.1


