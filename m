Return-Path: <linux-kernel+bounces-112401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB40887952
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED58B2159A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2E4778B;
	Sat, 23 Mar 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsub3pJB"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307491EB34;
	Sat, 23 Mar 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210180; cv=none; b=aOUX0C1yxd+DLeLOXTxL5naxBxwB+1btG1Pklj4TRgTECLFIny5ihJC0FqrpP5XQj0DKCQxsENISgTLf43kMgUmOVbf2pcx6g6UhMmXk1UZ5UspTeZl7G+Yiarq8RYUTAIV1iBOaoA4X7jncEtx6dJGizHUrLJtiBDvaFn7A3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210180; c=relaxed/simple;
	bh=m6YKeaBWA9+eTPNBqpCMMtgAOFs8walsrBarhHMj2qU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N3p9c/l9VIu3uhqS2/0nBjlne0T1v+K/cFF9PX/os9wdVTceHetZDPhb2cU9M67EiCtGBXAgmz0XD/e3i9EV1cepNmk49oq391vXRsMEp1ReJ/WvsdooUTRXONqrO0srm3hp+KXlcqpixtxLkFLFvAQfcD3y46mNJhRIi9NGjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rsub3pJB; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a5362ceb7bso213986eaf.1;
        Sat, 23 Mar 2024 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711210178; x=1711814978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UB+KuKZaFZgvy2nchrz2bMbfhDWrexGsWveT9dkxoo=;
        b=Rsub3pJBxeyKV5rBTqkAZIbNJ24EutaJRsfSD5mCS+lDzjclxT9HJdNLzVhOVf7ocZ
         XYQyrNEWGN3rBuTgF1cpBV/NOqYFGaK5MHg+rQYZIW7qMM2KOufp2itwuf62d+Nkxzuf
         9RxM4MJialEDjXwHjFnUrUsu/c9GNeu8RZ1TeB8Z3kn1kUrfhSGXcbmzO6O1VjdMOJTy
         Y+PZ/+1Wd+6SSRB3j8rbdxAWaFijOZF8nNEZqhSjWC1PwseWcIAj3o1r0FLQXzl8JC9T
         Kk0S7ZW30Kcm4inUXb08XtZBPeuJ5IltwlPvymmd5y77G73FvLikp4FqmbwjDGT0Mx9E
         kzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711210178; x=1711814978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UB+KuKZaFZgvy2nchrz2bMbfhDWrexGsWveT9dkxoo=;
        b=L4fyos2aJs44tgliDCKY3DJBcY8v7YwhJhfZVhikJDiD+FwOMdY7tIeDi5gopvPFiY
         WuJoLGZfvZVrSvwfkoVrnFUKtziWQxt703Mjf8XqDaUFc7oxbtvhHrNtBAJ2KbXzclnw
         LYYAjjxtgPHIgoJV09gfVlgsrrR0TfJ0OcHZnAPwXVockYj23aOmLeiqJPjh0A9DOgR+
         98QluwPn4EZee82MM3yuKFruYUl6xMZQcXOnSpInXxl3eKWAWXE2ga39mPwJVp8O3lCU
         S0qNma0ZFDpCwq0a42k0Yfi65nTMzRma888dX98hVIbKHo0HxHN5N54OB3j+p8TnJqOm
         EWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbltGJF6dUtMxQb4QYUR2oXSeobRwgDhHdRdMIUdPuZKNvzWsP6FJMAe7mzlSd/FKKFL40Gra5kzAli3va88O05q1A+Kodz4fKzvqKYFGB4WsI2i8QBPqsmkmxBofoXGE2xD3GrhuRr/0=
X-Gm-Message-State: AOJu0Yyz4Cxtis9ZcRTvmEyLDZqLcLCDmP6yotiQ7Lx5ZCa6LPYg0TTH
	S++eFCmakicOIN7+vAeAsgudTMQtdwWGWmHLLk1yRIVmmc7j1nPR
X-Google-Smtp-Source: AGHT+IGdwsXmXfNfxsZ4yAelTOh54VWGb+rpl+SHlqXRmNqizUUIYJ6ecjBnzA1kVCAFqqxW5YscqA==
X-Received: by 2002:a05:6820:3086:b0:5a4:852f:4c08 with SMTP id eu6-20020a056820308600b005a4852f4c08mr2752535oob.4.1711210178271;
        Sat, 23 Mar 2024 09:09:38 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id a4-20020a4aae44000000b005a4b2172e48sm738541oon.41.2024.03.23.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:09:37 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	robert.marko@sartura.hr,
	ansuelsmth@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH 1/2] dt-bindings: net: ipq4019-mdio: add IPQ9574 compatible
Date: Sat, 23 Mar 2024 11:09:34 -0500
Message-Id: <20240323160935.2848095-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible property specific to IPQ9574. This should be used
along with the IPQ4019 compatible. This second compatible serves the
same purpose as the ipq{5,6,8} compatibles. This is to indicate that
the clocks properties are required.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 0029e197a825..a94480e819ac 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -20,6 +20,7 @@ properties:
           - enum:
               - qcom,ipq6018-mdio
               - qcom,ipq8074-mdio
+              - qcom,ipq9574-mdio
           - const: qcom,ipq4019-mdio
 
   "#address-cells":
@@ -76,6 +77,7 @@ allOf:
               - qcom,ipq5018-mdio
               - qcom,ipq6018-mdio
               - qcom,ipq8074-mdio
+              - qcom,ipq9574-mdio
     then:
       required:
         - clocks
-- 
2.40.1


