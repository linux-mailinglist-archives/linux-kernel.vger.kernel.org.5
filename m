Return-Path: <linux-kernel+bounces-47850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44A78453AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CF91F21060
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAD15B11F;
	Thu,  1 Feb 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB4XJgkB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96315AAAA;
	Thu,  1 Feb 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779258; cv=none; b=ho0lfH+/Nk9Q0HqL/PwSzd7wg3YLlcgAm47IJBb+GAy04aEL75uJAhEU4tLXR+rdoUMnfbK8MY3X8d1Lutypu/bGArAOIqdK8DycqlosfHR4WiZ/34ikU4oBaOhUKfGbqfVl/StWCrk0+Rypdc7nLashswYyMsyeSaLY57CBuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779258; c=relaxed/simple;
	bh=sCaiWCWmqGf3/V5ZUFDXlKQzo8FhGfi5WqkW7hJwd78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H7rbDbdHxlfyGZfsXYROznPutClDivYdaRVZBl85n5B8AzTalH0lcSDSf7b/7WpmKjAUVKHnv6vVt17X7S7dE20NPXz9N2NKk4cHqpLdeFzz61IUoRxcDfWCtw7m1pLwVO3mc1cI15+H/YlW6J/tSznVRq4zAF+BUreVigytsrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB4XJgkB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so928548a12.2;
        Thu, 01 Feb 2024 01:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706779254; x=1707384054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/ebOKDFPhogL3BlSGFeBjFaXltcwuELu3i2egJtBbk=;
        b=gB4XJgkBnELvaxwMrLT5uGPFD7eNVsBneZW0n76ivpZx1SG5q5CvxlK0g6o57b3u45
         +DzKZPk52z46nafKrEXrIG9Pth8fPY03Y1+YWiIIvYz5RfqXI+2P/CvMRwzuotK+6SST
         iEqz03wpzhlVWyJVzuVStCeE0qSQp8c3oIcU9furyaC/I2rbO8sWpu9Oj+heSVMKm7tu
         giq7k96PdhfbM7Ol0wbMe4ugqenEW5/5dpDwfKJgom6+GfjMsFJOELlceaRGsZN7TXB0
         igUO6T+UjfiA2BLmx4rlseyKbyZ5V9cxqKfIdLmIDCVKWLmM1km6ZaYqrGy36oLI+i9R
         z6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779254; x=1707384054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/ebOKDFPhogL3BlSGFeBjFaXltcwuELu3i2egJtBbk=;
        b=AW5GmJrg+raPBHSzggyi6PWmcjdryH0IeEQFABFhAftcw80PL1W5G9WfZKAe+pNk38
         X9YfhhxGT5vbWTDIqtRuVuWL5tIuID+V94ac0IDrFvz5fCEvBuZQ/F8AK3/5LBSY4vyh
         fvMGMo0/cOpMV+u9xxse6f+VyVuJNe2AZMXSmXcA44fwWygQmcqZENwGhhLAyX4Ss+hj
         gxNRmyUm5IRMnQJrYMGU7DwO/M97I44yANI65VHLdspHLExw1FtES6P5iIcmZ+BI3+r7
         9j9HROK9EzvpwwOGOBVhwrQWNiwgkyqB9eANuAEKoi81vLTH0Atde/7xmJTP/mwsQ9Ox
         6XlA==
X-Gm-Message-State: AOJu0Ywf/mpkhIqDLy6U86b1mxUiU+2h3fK6p8QHJyaOciI7PMf02zU/
	u/Jkj9dMwKcGfl52r8GdpyFs/e7K1LmzorGddDXk/jkWEnRyFT9w
X-Google-Smtp-Source: AGHT+IFOD0JWQfGpl8ae3xmeBZXwUQhM3Cgsf9GWj+39JSKfK77Ack67cKVz16UhoCHjmQSzp7RRAQ==
X-Received: by 2002:a05:6402:6d1:b0:55f:b217:4216 with SMTP id n17-20020a05640206d100b0055fb2174216mr1202637edy.7.1706779254448;
        Thu, 01 Feb 2024 01:20:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJC0c437uH8HmE3vKNkvKRalQW/DJC51hYI3VJS5B9TKYY5k6dPtNifzwVjGfM4tExY5996bOmn2SBLIkCFfT4bi4mK1AORhab//3wWNTD+1JPT7b8QN1EpVpRV3Mtf0K1QWDFdEcpPYLVVpmkksBfsjAP8A2StFGSwOIziduTLPJFRbmuP1KMSUFPrWbBZykf5RI/pbJh46ydejxO6LI/inbKQlKt29QKvbCJAjuHJZh9xR+Q/TX5yl4fTDZIoa1nazWmKTjOzHLnJzDlFkNZydraETZkEIxi/6WGUmztcrHGQNalNdBsdgnSrLGs9wYHDT6dUC3rVhZeyOH/JQISgJ2A07aSXzhyUzeWdxAM/X6KQxiF0cX2dIOL1k2FqjUHow==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id a20-20020aa7d754000000b0055efeee7722sm3834832eds.79.2024.02.01.01.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:20:54 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880
Date: Thu,  1 Feb 2024 11:20:31 +0200
Message-Id: <20240201092033.10690-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201092033.10690-1-clamor95@gmail.com>
References: <20240201092033.10690-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Add a compatible for the LG Optimus Vu P895 and Optimus 4X P880.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index fcf956406168..8fb4923517d0 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -64,6 +64,14 @@ properties:
       - items:
           - const: asus,tf700t
           - const: nvidia,tegra30
+      - description: LG Optimus 4X P880
+        items:
+          - const: lg,p880
+          - const: nvidia,tegra30
+      - description: LG Optimus Vu P895
+        items:
+          - const: lg,p895
+          - const: nvidia,tegra30
       - items:
           - const: toradex,apalis_t30-eval
           - const: toradex,apalis_t30
-- 
2.40.1


