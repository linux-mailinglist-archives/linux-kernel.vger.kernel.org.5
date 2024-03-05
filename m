Return-Path: <linux-kernel+bounces-91872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8A8717B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92492280D36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF427FBD1;
	Tue,  5 Mar 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaOdjqdK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16047F7CB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626341; cv=none; b=pw9/UV9jRn0h2wPnaEvRXeh2o4oWE7isk8/FsK2owMQXo2eUkuY1ht0ZLumgLKLhNW6vxM/hWrcNTexPbl2VaGDjyW7MkSNIWyLxonmwMi2grQ3gZfjbunWSHS/dDfa5Q5tTQNfoYQbq3GquGDkdjtTfM8pR43o35fFoes99mv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626341; c=relaxed/simple;
	bh=utYDuw34nGuToY7y1IT+NIEhf3NsXvVlpcJR4JW2mxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YB3MX+QcjmXaEgNDWcMDqNZMV7zyPm/rWksgYQ1J1Qfkb3hHKi69YQoxpKKLmSJ1aYCNNl8zGC3A0ZN7K+R+q+VWrKlq0AEbDQ4eV0m4Q7XlHf/uGClqYigzUvBx9jgrK68pWAhlOKt57egj8OGxD2y9rUXfNi4Yvs6x8jxvJz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaOdjqdK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso8065320a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709626338; x=1710231138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGEzMDVs2SuhSNZcHsDkwLnjMMEuR/jN0H7FBJN5bdE=;
        b=xaOdjqdKeSrEDN5EsXI1rOFIuFmaVVGeb8MFUy3rcMTOTyplJ/ijHe5Bc00gnDrrcb
         PSixhRLrJjvKGOVnD8KKI5V26V9l+afRUZ3RCYREe1a3kHRw0I8htCOyAxwHdY81ri5J
         fTBDp5X8q00Tn3N6aE9kSHifuSxLJbZ2zq8JKAcYrxNcwCjQMjtP9/PH6KBL9Y1gMGh2
         /oUL7NS1QTUdvpIi2AtrlhrgUn4v2JukZl84O5D91fiRkgrZ/cgD+8jpi2/T6w72EmrF
         hycW8Awu2BIA7zeS+tJnUEHdugc3JDLRI4BCQfEKJFJfBG0ujoT0McYQvE9HXV6e3oFg
         7LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626338; x=1710231138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGEzMDVs2SuhSNZcHsDkwLnjMMEuR/jN0H7FBJN5bdE=;
        b=rri2ouWvgZ4AoKWSDOr7KYVDW45WjYnzGa13ksrHWaBrBKB7zL3L/sQ/6vnpBNjyVK
         fackcc+jp5v8vW+GMU2H6gmvrE0VMx1FXptIUAL8TL+dXOlrV5q0p+l8xlKZoX1vxWwe
         fv13SBHKu3CWGBai8A24sW3yTmFBgWCRmnqTTogQPL2L7lYXZt3L7wZlwo1ADaJkfouh
         HQ4WlxOT/EfrYjNxvfvyzg9gyr/Uyf82RH8Fwh45wz7znhccEkK2smiX71uPvdYXMaZ2
         XXqD+TIcB7dFU0JiXfZ47BuzMgs3CaLJ3S/mygQ4h0tregZLN9uFQ6LGANbY8yIMxCIw
         d1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkd8sOQxxtBYhfEohruQD6Rdrj063BXNyi5O4H8bM7ZNr5L+t8Fdpa3CUBUXY0Aplb9n1hsvosFV0ElJ+5C6cV7HDet8o15D1+2XWB
X-Gm-Message-State: AOJu0YxptqgAW5WFvLbFnVoL2EBI2Epigv8EYXogOgXiLYSRE5hW4wD/
	t32I3eDkPvIx9Oy/UMJXNjwlu8gP1qE05/AU4a6dROlfy4PbeRz/6P7a09ndN5I=
X-Google-Smtp-Source: AGHT+IGPoDsTMtd30w/DOshzWoUEHpx/Q/pa5sDpp/arpdkYcoyWSkhqspl63v7mKF9KA18tbb+Y6g==
X-Received: by 2002:a50:c88c:0:b0:566:44ca:9f5c with SMTP id d12-20020a50c88c000000b0056644ca9f5cmr6893675edh.8.1709626338138;
        Tue, 05 Mar 2024 00:12:18 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b005672a346a8fsm2761557edb.57.2024.03.05.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:12:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 05 Mar 2024 09:11:58 +0100
Subject: [PATCH v2 3/7] backlight: bd6107: Handle deferred probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-backlight-probe-v2-3-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=utYDuw34nGuToY7y1IT+NIEhf3NsXvVlpcJR4JW2mxc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBl5tPX0BTP6R7BZf+T2A19wNFHqlTtCuGUa2M9E
 W+LsqYM6eyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZebT1wAKCRDBN2bmhouD
 17l9D/9V3Rtsc9kSl3ihhdhQ3TA7WjcTHaWmAnmked6/2v/yRSimxEfAaz+db9sq1EZ23XaHlA6
 ICFtKCF/SvSGy80HnJvGKX1Th7Eem6h1onaS0Zip0WVVyrRzkoIKYfLbHRge29FExq6ycEcDF7O
 5bu0FL7MaiwjmEbP7Kyb57n+Vp0V/FUbVMJz4dk4QrVSkZyJfUa9PGjURWJN7QZxVgFp2ntwxNT
 tcnLYB6kr4o9/xezchi5rX1z+tRx5cHZZyr2KTDqRL50k6xeE6lL3WYyfQNyNaObvGZeuAn9rbA
 TOqHm44+n4QD1zGM2jG+9qTb3MCttYy3J3ix6WXhUl2VOzA3IUYARp7Gy09+r3EH2JDwWAHWkf6
 OrNM3MxYy9jAmkXNxPkcOoHxm0Mynoz5IQlX9kwcwruj1Eu7Y+rSgjrd9hg+fgc2CuNsb/VPkR5
 Pb2gsGKYCLQSj3akNr6JTu7T9ch2H+scaP40a169Nc5mjwqXNWTqx5vw17OjuUy3+xYkFmS1QFc
 tnLVTBhUXjpum518RA9w30D1JkVK5K82wlOAKZdiwgZ16oREN6NXUIOMZwXW9zsQu4X+ZL8SqXP
 IOa1VEKXQ+H9MIVu0sgGul2COHGnhRJgbOc1dJZrgbXQ7WS6XOhzflJhcl/ct4yrxqnepmw2Dxh
 MgoyRlqN12K8NdQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Don't pollute dmesg on deferred probe and simplify the code with
dev_err_probe().

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/bd6107.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index c95a12bf0ce2..b1e7126380ef 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -119,7 +119,6 @@ static int bd6107_probe(struct i2c_client *client)
 	struct backlight_device *backlight;
 	struct backlight_properties props;
 	struct bd6107 *bd;
-	int ret;
 
 	if (pdata == NULL) {
 		dev_err(&client->dev, "No platform data\n");
@@ -147,11 +146,9 @@ static int bd6107_probe(struct i2c_client *client)
 	 * the reset.
 	 */
 	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(bd->reset)) {
-		dev_err(&client->dev, "unable to request reset GPIO\n");
-		ret = PTR_ERR(bd->reset);
-		return ret;
-	}
+	if (IS_ERR(bd->reset))
+		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
+				     "unable to request reset GPIO\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;

-- 
2.34.1


