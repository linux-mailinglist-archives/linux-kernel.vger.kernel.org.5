Return-Path: <linux-kernel+bounces-153011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DDC8AC78B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CFDB2140B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF555C33;
	Mon, 22 Apr 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNqB2tQl"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327A53380
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775700; cv=none; b=nIDGkCJ3EKm8Vdqw088kNlJUTgWhDiyeN2aXsZpGsdcmz73VMy7CEdfZe6nEEpcJbGlR2baxRH9lkez+DAgawHouG9BJcQKbKyuIjWafKtHCvoXSOv8XPpczAz5xXkT6kAEKsCBhRzLa12D92h/qIXyNHPs4mvZKSj9jsBau/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775700; c=relaxed/simple;
	bh=XWViwFClyPoSqKIp2sLKe4pbbvpkPWu9OeRT9H3W1oY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUKqFVlwlVA5uTKAu8DWcwfTlzBL6T+42wc0tJtGHH11Via2WphgPu3KP8BNkPRyXAXcGX2wHhz3qSokmAecwmiJ2i6LUsgpauRHAW8advzaGV8893uQ4NH+DJhL/XnWHKNXqoqtM6n1TnNcjfzgGM6TzUp9TcPT7Cv4zAbETL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNqB2tQl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a523e27e0so4975955e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713775696; x=1714380496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ebbPMvWBsKZ0ArkpmmdUg6nQqxEpO8djndB+too+HI=;
        b=oNqB2tQlCWeUYVYbJeuFeo3fH1vnpI9dVzc6GOa52p49nsj6zBjDs1PUte5f+k1Cp0
         MNfcCgffBtOueUXUx7KFB6jxL8aY5+ORd3uLs9vgtyT+pz7efNvolorE8w7KE8FXyhsB
         hvFhq7o8GLRUGrvqiUhcsSj1a4cxI3jrbm/SMVahKZVNKbvPDJFdZLHWdwccdfeIvJCX
         xireJMQgwYCIQcfm2IbQiv9OLs8NUmz7KLodnJitYgbRrabjwG3W0+/hSAhytEf8u2F1
         2mawV2E76tJXtYymsjP9/vxwHYhI8NwKN0XnbjViui07pTjCUwIhsLFaJGXpliDWrnvC
         +4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775697; x=1714380497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ebbPMvWBsKZ0ArkpmmdUg6nQqxEpO8djndB+too+HI=;
        b=Rkf6R2Rd8RQAwlw7kNaT2qFF4ODyOFSr9RWHQEIkcF+Xvyu8vQGSd81A86XjBDyWmp
         szdT6oJn7uXTFrN/2bzmQIYDk6OJNG/kun2zhRMEgGqyOIMYl2hHjC2HEjxahxc8+TmJ
         XwPkO29GjbErNU5ahhLZOESBTkWRvpvZFqBwfj+/Ifodh6QemZ2kzF+ZlS1G+XOmlqmt
         yzqNNiq9oMPL27k2Oa7/+IqfYaXGHfB9pIl1YevD384hPP3zzK+DhVUqBlBdS7SdJIiz
         8HCoZ5+iULAexARx4PolQ9Ksb7fbXll6ARGtDpRpo1bVdbzE6KX4PNWc6lePoMosQMxB
         VEQw==
X-Forwarded-Encrypted: i=1; AJvYcCV2JLm7fRwcbBiAGLIyyJXaS6pFjPbxKZ/+qSijuIPXaCpivzw5bRofDNPkbr3RYm/M6rFeznevIXyn5goq6RJOn+cWqnMfsOQpcvd0
X-Gm-Message-State: AOJu0YzREwn4R+fdDFXwcx7X3Xp8xAiPWHBo9amleZzNC485bJOpEFo4
	dW6lWl7zx1dod/UpexSsSuxBrOAhpX3N0HOQnL5hf7Dga1UmOaIcoQDeUkgucoE=
X-Google-Smtp-Source: AGHT+IEDmMXEAsNMGafqsvYXvVxeCD4wbO2HE8DuQ9uEaYuSFLUK6kEssEISQVY+lV3u7ezKifjBQw==
X-Received: by 2002:a05:600c:3ca3:b0:418:c021:33ae with SMTP id bg35-20020a05600c3ca300b00418c02133aemr6984192wmb.19.1713775696453;
        Mon, 22 Apr 2024 01:48:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b00418244d459esm15962650wmo.4.2024.04.22.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:48:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 10:48:12 +0200
Subject: [PATCH v4 1/3] dt-bindings: arm: qcom: Document the HDK8650 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-topic-sm8650-upstream-hdk-v4-1-b33993eaa2e8@linaro.org>
References: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
In-Reply-To: <20240422-topic-sm8650-upstream-hdk-v4-0-b33993eaa2e8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=952;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XWViwFClyPoSqKIp2sLKe4pbbvpkPWu9OeRT9H3W1oY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJiRNMvLqQcadxyVBRIYuqIV5T1b4xUUcpYARAnuY
 rpFC5LmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYkTQAKCRB33NvayMhJ0ZRED/
 4mgSdAzjIwarwx/RN6ijPJgnNDVi3wvjwJJ5waiA7A3ufRBlVar1ndOroawO6Z13kzbEcfP7bPYheW
 PBVpAi4L5BiC6IsYMmVEoRauE5xE3B31aZPukzcfHV71C2Jl65ua+JXg6JRPDw1ln143khGKCkmQES
 H02TJVZx5zVYDvc7ZK70r0kMYj6Z2GwqcLgAPYqLQgGcZjetM437uyXx9SlWwyPzyVwrH/0KqJ+gzD
 Fckt0v+Aux3gBDmglrs8MBTauJht2HiVsws7kRi6yFAKpVZ4rZmZTVd+AoKNyKR0RiWiH70Z5M63U8
 S01ZdeqFNY0xRcnSFVPfOR8tkXu8bJQzSoQfhRVYAHEuwuy2sfKl7zMgVeBI7RjNf+WWtpSTGggK6y
 r6Jlt/4KyrBQzrIDfPp6VJurDXyioZ+PV2REdu7bQG8IYoPY3ei92WGb2/5r4GJRH/UUsjSG8hHw7Y
 T/Ez1v/JkhL9wjMELlMy149YknbbwA4OC+YWmcC/iFBWXo0C2M/sLhij58Us3FzHDkXsM+LIQ0thhM
 N4OdD9jnrXxhDqNH1M0wyrTunxpg2d2rMRolD48W4auzA+s5CCgCwmdzvczC0k0e3bO3Jj7eL9cceo
 J+iQecsNU9qChi/d0Wj4GTFFAmETpojSjvqLeLFG7ar8S5myEnd1e+3D6Bsg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Qualcomm SM8650 based HDK (Hardware Development Kit)
embedded development platform designed by Qualcomm and sold by Lantronix [1].

[1] https://www.lantronix.com/products/snapdragon-8-gen-3-mobile-hardware-development-kit/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 98b4187f2aad..52be11d33935 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1002,6 +1002,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,sm8650-hdk
               - qcom,sm8650-mtp
               - qcom,sm8650-qrd
           - const: qcom,sm8650

-- 
2.34.1


