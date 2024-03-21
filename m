Return-Path: <linux-kernel+bounces-110559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 019BD886096
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1EC285AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BC134406;
	Thu, 21 Mar 2024 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXzXOXro"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF4F507;
	Thu, 21 Mar 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046041; cv=none; b=NMVyv2ImIW4Tdp0hcUNZ1ADlIagNeZHafCVpkz7jZJ1vSNrj1KogTSgbMMh85LEjYAzDcl1/OAv+YeFvX4VTVz+oKZzgmV60dsPQ1He4VAUKVxGxc/yviE/cJvjC3ozVPXPJjRtTfp8z5H6K7oSCtrG8oUtMIDjnSDUxlrPS0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046041; c=relaxed/simple;
	bh=XyfvC45Hq8rQR0jaGmIpTTfQmoa0l/L9Ck4VEjoX+a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bS3bwqD50jM84Set24aIzjdjs4VfY+LFKTAvLlVv1ltoDOjHf6oNVha8DMG8JqUT8BEGOjeYYdMoURoqXfwwctqunLPrzUt1xw1yxxyAMRvDirGl/pu06X/nKqZ0yneXb7qQEX68RnkVvQM2Zl4JO1GMyEFgGcM7rSMtG5sb7mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXzXOXro; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44665605f3so160409166b.2;
        Thu, 21 Mar 2024 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046038; x=1711650838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZuoVCX61syxaPen/YIQ3N2kA3L9vWu+IMtehP15nIU=;
        b=fXzXOXroDT1iAhWTKcN9xohWQfStuuygcRm218UGv19hXkZHCcnt1+ETTNqNAl3osp
         Za2mnhUlnwCQ62wYkhgxmEwoAsEgR1Vc9XI4s2yw6MOxJKRL5+rV2B8uKJm4wLSO8r47
         PnLvjqRN6nm6lOj+YbNXjdFKFlLCLxn7HEacyaN0PteGXjtwZFGcZ1r7Zu2qVHaRx9LN
         XldChi0BwtMsr3MWi+FdCvBhg51jkXaThf4tFcjR+1VkBT3ec0mhMYdMGsMiehM1Ce58
         nCUQTz5hMG0+8lapN6vrnK6m/6sdYp2mlBXmANmg528mmILXBcF+3V7wD41fTKthDuTv
         iN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046038; x=1711650838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZuoVCX61syxaPen/YIQ3N2kA3L9vWu+IMtehP15nIU=;
        b=XUOTaBpxl/ZrA0Y4Yn4l4AXus0phzmwioex2RSiwKoS2sStL9XKw7k9Gvl2WH4vKP2
         i/8aV5CZpN1utdM8iKR5OcuHw2Nthe3Wiz7mTpglVeF+h1z2locawzzRPqBusS2mcla4
         p0Q7RbnBbe/TzQT7YTvRkYuQVwfyymrzcMEj+3QPyA5GMoWiv2t99QyjdlB0U6Q4BrDj
         bwh/HGWag2QZpXAq3on07NYvQf0oaf6EO2JE+ec9U4XKWPvd19eVL2LOEJmcyJ5Mt4kv
         cPlttKwPNsL1YP+DxtWKi99aK/qOMFTm5w41Af15TmeSV9t4QyonvC5U+/v9IoUZP+5E
         OkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7LbRm8040bIJl+JgVl5zHmRt7BynCdR8eh1/T07xf7ftN9EWmmGoxYOmEEtYhysv5L/wQhWQtJOM5kGPEi5uf/MzIRE/5x46hHu+WbdY1GpTJ7joqXjB2AkFEsubwU3RilmSaJnqLAA==
X-Gm-Message-State: AOJu0Yzm0rNaeq/6+rMNSoiEzBdDMzOdqOe+N/5Sy4gaGKveR2JXrK9X
	hQ0vai9llihyZxMqePW7RCt9zZQ5SWasdhbUARP6aoFInK6qI+v1
X-Google-Smtp-Source: AGHT+IEMIuNslpUSngsmxCerf+UiWD4QhVheoSzkTeWK8d2KCZfk9gy7Rk5Cay/4zAUC5W7X1XJHcw==
X-Received: by 2002:a17:906:f242:b0:a46:65fd:969d with SMTP id gy2-20020a170906f24200b00a4665fd969dmr135002ejb.71.1711046038033;
        Thu, 21 Mar 2024 11:33:58 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id hg18-20020a1709072cd200b00a4661caeed7sm191511ejc.48.2024.03.21.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:33:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:33:48 +0100
Subject: [PATCH 1/2] dt-bindings: iio: health: maxim,max30102: add max30101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-max30101-v1-1-00b83e966824@gmail.com>
References: <20240321-max30101-v1-0-00b83e966824@gmail.com>
In-Reply-To: <20240321-max30101-v1-0-00b83e966824@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046035; l=1302;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=XyfvC45Hq8rQR0jaGmIpTTfQmoa0l/L9Ck4VEjoX+a4=;
 b=LHPgNRfm6c9Xciish0ZkIqUN+vHg5hFP3R1hwBPOBZKucCw6OcUafJF8vv3+pL3XSi7XDL9HJ
 cALCsXLBm7OBGni5ZWoVIp4gkEPxBL0gLF391yEvbFgvO8XN7glHU5C
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Maxim max30101 irs the replacement for the max30105, which is no
longer recommended for future designs.

The max30101 does not require new properties, and it can be described
with the existing ones for the max30105.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
index c13c10c8d65d..0e455809340f 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/health/maxim,max30102.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Maxim MAX30102 heart rate and pulse oximeter and MAX30105 particle-sensor
+title: Maxim MAX30101/2 heart rate and pulse oximeter and MAX30105 particle-sensor
 
 maintainers:
   - Matt Ranostay <matt.ranostay@konsulko.com>
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - maxim,max30101
       - maxim,max30102
       - maxim,max30105
 

-- 
2.40.1


