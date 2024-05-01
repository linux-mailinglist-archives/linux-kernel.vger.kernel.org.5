Return-Path: <linux-kernel+bounces-164907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352798B84C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E5C1F26B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78738535D4;
	Wed,  1 May 2024 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp7OIaY7"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202A51C4B;
	Wed,  1 May 2024 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536509; cv=none; b=HCca7XUOh/qUGq4waX4TuwFZ/b+0Uggl8NrHKuxccJzkrT/oZUJfCtZQPGVfSU+iUdRASu0JQow3NGNKijR66W5iloz7YNIz9cWmQ1muQO4yEOxRFLZLAB+u/LfYRex/J4WOMKbPuPmfDFWhobGvxRGB3NFKlaY1VpcDspwBmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536509; c=relaxed/simple;
	bh=l8wNOtYhNTub8tqUC0hD6JfTNva6XfYe64dArOyPXTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvLYJQVw/xjV0g0WtP9V/jxZ+3G66HWuC+dT8KaaXprEdvxKqm2teJeYUO4UPH2KzwSHLbjwNw7h3tiXfG63yjkin3yzSZG7/uHy4dRCneoGgwYxne3YJaUloohTbDbElntqP5jsiPk+dI0lKF3dXpDdSRJPOblATNlQISaM8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp7OIaY7; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c86f066256so1119149b6e.2;
        Tue, 30 Apr 2024 21:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536507; x=1715141307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghcu5svxDDMwf9Ya6V/1d6nG/9vm8dM7H011zLAoFaA=;
        b=bp7OIaY7XwM7bACqznblyRtGy2xMUUz6fsxZmpt5wemymHSYSd2TGKduE42qH7z3G3
         ckIhr5g4jjTZ2v1CoEIKFMhM1xEQ8lsvjNYEbTMOLVPOt312aSEJpjV+6vkSaq7UcCxy
         yYEhkA69q6DRhFxComg/xNpnbb1JlhHRSJwH9mBhjkUYVDvowvmiu9vjptvUxe4RJnUO
         daBNuW6UCO8rCv3XjE2Gsxgc3SuEFFBCl2pRlMrhZ32BaScW+x2sJi9V/XJDK8xJrupf
         NbbHsr4LClQvYNPNxcHt5Ku9XXcd6mRf+phzzM7VYx0TxY0JhUzwVVZXxB3Ce9pfJRT3
         fLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536507; x=1715141307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghcu5svxDDMwf9Ya6V/1d6nG/9vm8dM7H011zLAoFaA=;
        b=kc2CiaQKsZY9Upkzn3iCy6yQEtzUNp+fPtNIbDBGdicc2cdEwSUMqf/iBw2hGzLRNf
         14xvQuMY8z1agzndh3U/8pG0DdunhxRQYkkK8LL1CYkEJ4YG+nq0ZB11HSHFWzH7onxp
         Lj6X3+2mRXUbWhKyMnCm4JHsHpzPkWogf/It1zSCo0DjDP6ylLDbZIhC9DRjgf8faclk
         8KVnkiotpjv1dPIS+F78n4aYbMkwngCbzQWBzRUldl6gL1N3ctMIB9+if/pFjCqxfjQ6
         NXAqSQ0Y3PDdtSmIxA29sagCuoFOxEAVhyXkZPhjTceW7LIMCXqehkzbH7F0tzuAArvi
         0ojA==
X-Forwarded-Encrypted: i=1; AJvYcCVwEc7MQhzLOgl81oCsasubjdNTVrtXtths3FLWS9nzM1Tz3O4aIFA0wpM1TjK5NS29wD1AqWS4DvQP6zzOGv/A312wjIZKCwymgD4ClllbzYkkarEC8TfoZGAHN+cSyj5q0Jy9odG8Gx8=
X-Gm-Message-State: AOJu0YxYrp6GQEMOBKXYoxNH6Ylw1hC+D9tpe5ucnFGA3pnZahj4J8+I
	exm+j6BhJ2IDiunW2/mI6As3dTyz000X2etDsPGYEvCdrOiHZcMB
X-Google-Smtp-Source: AGHT+IGzsSP6HTqUq08TCgftQdBYcecsnJuXxz+gqYPzPUH+wcP5U0uuwhVYuL1b5TbHT7DYBIxszw==
X-Received: by 2002:a05:6808:2381:b0:3c8:2b8e:6982 with SMTP id bp1-20020a056808238100b003c82b8e6982mr1858496oib.18.1714536507521;
        Tue, 30 Apr 2024 21:08:27 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:27 -0700 (PDT)
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
Date: Tue, 30 Apr 2024 23:07:57 -0500
Message-Id: <20240501040800.1542805-16-mr.nuke.me@gmail.com>
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


