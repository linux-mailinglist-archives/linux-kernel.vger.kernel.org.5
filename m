Return-Path: <linux-kernel+bounces-90106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8A86FA70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9BE2828B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0AF134AE;
	Mon,  4 Mar 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bugxc8gL"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86F13FED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535917; cv=none; b=Pt7ifs+cx+IarSIjn2q6URxuRJvrcHuw2l3FbzTwsmh631g+v1uQojdrIwJI+/VVJ049JMv6Xun64r+NfU4V6xDAdwrWBHgRDmcnepK2njVAngdESYdCl/BNoBJrtoGejslrxcu5Cs74JtaMO8KgoLuJ/XkEzjvefR/VULAiAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535917; c=relaxed/simple;
	bh=hNjxuYC2EJdA/XoKsj5uylY7h9/KQd56NM+y23zLnFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sNgGbYcaJxeB/ohIEQR8YI2Xu1FVpIQUQIWc7JDVJWRglPspKOI27MdrC4pInPpQV3aJzH6KpCec4PVsclM81j2GgYIHbpEJ56HnN2Ni1SgZ15CG8CrjycwZ/RLbuhXYcKue1mdDDOqT/cuuqesYRQhh4WrUJCNczQmF+vzqs98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bugxc8gL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d275e63590so57272901fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709535914; x=1710140714; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZGUpUYM0VesXHneGzkSI0l8X+1IzpaMdy5MewuWCx4=;
        b=Bugxc8gLbcQ2+cvQPJ/1O1DFqxrhaKmlchtewNFn8jQiaN0CIL2aQMwONd4nL0CDHd
         AtqErT4VZ9KMLKWvGoniMCyzFC/iHsDv0HB8rQbxnkuQSzRey00zNq3yyVxZs65MkvJg
         0p1+Wer5sc++3L4wuDunp7alm3GyyPpAJz+h0mVpBLi9/tW1+JHvLZs0lFAsOF1cOKDI
         dfBaakynVSGgcFAhvx4XgPR+mG/ExQsR6AhoecAwgADHSYiINee1qwI4/n1uvWFpCEXb
         SA+dVNFTazGX+fIZemnSY+ixGmgMavjAjcZXuXYKl3JE3Iw1j3rvS2ygQZDv9gN/sNpG
         HzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535914; x=1710140714;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZGUpUYM0VesXHneGzkSI0l8X+1IzpaMdy5MewuWCx4=;
        b=jsgFalayzSWVd/t+5FbDywKIjSDzZDCGrIyK0oxhGUVJ32lfzmERvPBftZNLFIGx3D
         flkbaJ3zbaFHrkDtn7nVdq33bHOAUwCSrQM0csiJ9caAU96P436QkASfkKmZEI4Grkr9
         ChUO9ZflTduSUsdS7ObJPkMYDYcwQs/Yp3/Ib1qJlTdRaGl8SGTlFJTnc0lJdW/VJeIZ
         540RryIDnCBrT6QJ1Z9vL0vQIgkRIhqnigbce+ceuguG4bOMe9z1oxD6V3yn+4fkB07b
         UnLBEYmeUOifEaaw+CfuBuUovoi4CSD3q9zoagjZKfV9D/Rwzii4jWr7p9AO2CJTLIcv
         5bxg==
X-Forwarded-Encrypted: i=1; AJvYcCUNIkf88rP14937ygDYNn2AeRBFtIjkkIZe2n0w9PWMeWMLZKou1frk7AeFLlgCIWkELcPnBR5Ow1BOQzF35KBGKPOxbaFLfaKkRcbL
X-Gm-Message-State: AOJu0YwGnlHv3mSUG0rHqQeKSBOhmNb5qu7wKO0l8Yd4yhRA4Bbhk9AD
	/bjP5aZYlEHHWOUUfhmDVB1yI9vHc9kynOQ5JWtx14lC+jVG/NrUCBthGGqStlz/RpEKGi+A4YV
	1
X-Google-Smtp-Source: AGHT+IFW8Mx8FI4E0PUY4m2TiAQNZqb8odfxy6I3n9gy3/58yevGa3GaBngabXuahye/TfmVqpHMyg==
X-Received: by 2002:a2e:b711:0:b0:2d2:950e:2717 with SMTP id j17-20020a2eb711000000b002d2950e2717mr5298552ljo.35.1709535913963;
        Sun, 03 Mar 2024 23:05:13 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b00412e5e67511sm928473wmq.16.2024.03.03.23.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:05:13 -0800 (PST)
Date: Mon, 4 Mar 2024 10:05:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] pinctrl: core: comment that pinctrl_add_gpio_range() is
 deprecated
Message-ID: <533a7a10-c6eb-4ebe-adf1-f8dc95ae8d33@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pinctrl_add_gpio_range() function is deprecated add a comment so
people don't accidentally use it in new code.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ee56856cb80c..2d4412795ea4 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -412,6 +412,10 @@ static int pinctrl_get_device_gpio_range(struct gpio_chip *gc,
  * @pctldev: pin controller device to add the range to
  * @range: the GPIO range to add
  *
+ * DEPRECATED: Don't use this function in new code.  See section 2 of
+ * Documentation/devicetree/bindings/gpio/gpio.txt on how to bind pinctrl and
+ * gpio drivers.
+ *
  * This adds a range of GPIOs to be handled by a certain pin controller. Call
  * this to register handled ranges after registering your pin controller.
  */
-- 
2.43.0


