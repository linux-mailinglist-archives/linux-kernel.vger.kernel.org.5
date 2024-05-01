Return-Path: <linux-kernel+bounces-164898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C608B84A6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483B528356B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1BB4AEF6;
	Wed,  1 May 2024 04:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp7h8ruc"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDA433CB;
	Wed,  1 May 2024 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536494; cv=none; b=N9GqG/FqQoce5vwV60h4+ggh6193ITR+evfFwASvY0vUSBoIL1GPhbTbKc6g8UAwD4N1Cll9XKyelgXky8RAqpbDYFjIkqYgmqRp9tEz2tSQxyzGOrFPiRVnzHP1AvK64k5fL2wvxkmY3gB5xv9ycu/eB91Vx5W2S8Td7bVnmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536494; c=relaxed/simple;
	bh=l8wNOtYhNTub8tqUC0hD6JfTNva6XfYe64dArOyPXTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkZhSpNayp8DdJPw0gz7H9ln1qfAE75OWZoRhjW59XJpqMaKx0HRpJ5sjKLhciPBWq8VZlvwuKlpMeS4A1qD8PCexUU1fqYcF4LpJt/uAoJzRMB8HgNolAw7nn3F1hSrotVzfREMGQD83j2BpXZ5HXGpWzPwekVRTbDpGLxZMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp7h8ruc; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c750fd1202so3717089b6e.2;
        Tue, 30 Apr 2024 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536492; x=1715141292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghcu5svxDDMwf9Ya6V/1d6nG/9vm8dM7H011zLAoFaA=;
        b=mp7h8ruc2G8+KmHuNWHATB7aKmhcJNzgql1ob3o48MArIROiGGPvswpJ6E/6SfO9wD
         B49J5SXW9MBF1f9TiaUK9Mc1Dq1bcnPJqACS77TUBJtaxjWrZvRvA08LQNL8IAb1SLQ/
         ohVOjYh2C77Cl5KutYvL6z6YAzptvBHOzGeXPQaApqzKAtUV83yM3YG4axSxWVPVnvd0
         WMYsqX2Yx2re1Bx5QeP/A0D14rpVpySNy/QxaGNJpOV6vnanSgy9FMEb6BIgZxf1bfMj
         Mk48ZEAdlcM4zPLgkIed5YO4EUcelTje+zipiZ/uEVf9ExyZ3r4x6hyg6VGJzNd4j5f4
         swEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536492; x=1715141292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghcu5svxDDMwf9Ya6V/1d6nG/9vm8dM7H011zLAoFaA=;
        b=FAUNLXxVbaSh2elZfcf3OUH7KQ6EVJF+lWmxXBPN0FAbzLtLxaj76zb9A62E38ueIs
         /sbf2Ezb4VXZsXrNQjC4/h9PC41p1Y5AJyorUbdEox5qoWHzpm2idp4ByK1O26aUiFJc
         NTnttVXsTp1tQJS8sYuxBB4iZZ6pdRep+BN4NbPDin/61KguVmsp4f2CNmZKDaSKLTdm
         zQbGvhOG8OidsF+cAPwMGhdH+tzscexPQlx7dHFGkcICvjB2ZuyItZK9MIlWsJMXXL03
         8gQqyxEVpoQ+3neXZLGUxvlvBitbfGfuiMtb+CYUo7B+Ufo1khD4dJG2tAX73Q/N/HUc
         gzbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH8zGdwaBZLoEWDTcpsuHqqdUe+IfWjmSWv6bO2hJrWgBgaTqcYTliOK/Gv7zSVxs2/XZFjNfBE8vSOXar4CIkM3LPTzYxmJReo9+kTOTrBgyw6ieQ2vtI7tAQE+yDo0Lj01WBb4aSaag=
X-Gm-Message-State: AOJu0YxBa53fOHDz1GDPSH8C5wBUkuCtPurOly0k0JDsBoI74k2dbjdd
	ZVMCWF28ZD6Jr7ny1MZPi/wnJL9G3UUdCr3MJ80z6Q5RHTq/q31sKRViJtabat8=
X-Google-Smtp-Source: AGHT+IE0E0/DvAkXZtkuPvqDWjEfhTKVpwqRMdFGJ93BhhRobghlUJxth/c+MqrZ9nW0kZnouPr8mA==
X-Received: by 2002:a05:6808:5c6:b0:3c8:5c8e:72db with SMTP id d6-20020a05680805c600b003c85c8e72dbmr1526720oij.56.1714536492481;
        Tue, 30 Apr 2024 21:08:12 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:12 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 6/8] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
Date: Tue, 30 Apr 2024 23:07:48 -0500
Message-Id: <20240501040800.1542805-7-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires the
same parameters as IPQ6018. Add a new compatible string for this PHY.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 634cec5d57ea..8a8e23282d1c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq9574-qmp-gen3x2-pcie-phy
 
   reg:
     items:
-- 
2.40.1


