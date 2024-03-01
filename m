Return-Path: <linux-kernel+bounces-88858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAD186E79F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCE4B25693
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0412B72;
	Fri,  1 Mar 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3apg4ta"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299628F7;
	Fri,  1 Mar 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315255; cv=none; b=kHME0LNJDpeTe2OplcWv/u2cmpX4P5dQHMDkVojPXJa5q9FPomJe9c3wKZb9waQUZnQ7gfJsi72u23mLa/pzcTkh+ajFc8JD5V90WxYFP9SOQ0Bag77jJoVwDVqNjLsxwWODXhrYkhpa6H9aFHfe52Rt8mj2mFBCUuLY2Kf9F28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315255; c=relaxed/simple;
	bh=rBu4za9dkQ1/IHfuTAb80j6Uu+dFNhsly4bdck6GQao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GKGfbGiMBpeO2VrQkbN7ILhwkTDm3F8hfMlRy8+Sl+cnMrqkBoj8Azw7+RIG6q3H80UIeKRnUfh6VWafK5EH5y8txVtxrGyuiueikLdzCoxwyRHX2RMwJ2oM5umo0uXXK1ATx+VrPBxHz5gu231t4QhdHxH0ppVxQvxkVb/nPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3apg4ta; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412cf3c5cdeso614055e9.2;
        Fri, 01 Mar 2024 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709315252; x=1709920052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIOLWdgzAaFPK3p57G3Eyz2PM0Lv3W1GigncJVvRaHo=;
        b=B3apg4taYbjxMmhQ7zJdWVQ9CI54i3wjoq1V36JYIH0/5rBP5tMTAv6EtWHGimEjuz
         cwtIug2a3kfjoYMZ9rpctvqp4CyrdNPqD8uT/LSdpg/HaWr4MDIlDkyr5Vnwd9IGEyrY
         nTwUU0y1f9rNGOMYgGPH/OosNNrubTDhvGjdQN1BUj5HTCnNK943QtnTEjMGfI6XzLz7
         Uhx4/GpjPpEqdJoAlo67Llh0M/cF6tNM5lbHs17b4+tcWNVXzHf3yFS0dSEostbFQ7QD
         dWS//2Tj1GyggCuAb4if+hoy5/UNQFx1udSwfplJNEtBKjUhsF66a0Yo5nuhsfiKQiHz
         Krig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315252; x=1709920052;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIOLWdgzAaFPK3p57G3Eyz2PM0Lv3W1GigncJVvRaHo=;
        b=YUDWqUd/AJDVbyfhycJuo04Jh+iP/Q5xE0m6TQ3PLY8OWOPmeXWSrLasbGgfx4F4vp
         sRXND1gsNjA8BMQaoQNSLv8eoEkmQHZf8SQfvXo379UYkjKm7SMrWyJaZpYnLTym5r2t
         BMTZMXPJw0Yx+RM+tuT4HWLt65M/db0cKjQ0+rYs2ZcUWLAzBIpYtzsiXPAg0RlnTVdW
         +rJVzp6fNnmjpb//nUMj+iTvwpPS7KmmDl+NnRNZeylrRb12xNRRAKlBS5X8FizKNlyv
         ISWeKYWGDLiXBX4WT3xa2EV6Xoiki5zgDh1+4ZK4v/1Kym6V15rJUEFWNGl8q+9hdIMV
         ARIw==
X-Forwarded-Encrypted: i=1; AJvYcCVAC7ObMKREsAs6XiPR2p+i2j7kp72jBwCrz1IewTqkIi5U85Bezvwn4z4JEQtIE/WIlh3YaRm4POHZjOUG5XLOUW5xcjUCfqTBWbhrKrfGhjUrhYIiSl9wnQ24jkGh2q44yK/UxtXMpg==
X-Gm-Message-State: AOJu0YwjwI/RFsfKVytt+poYTaScfyIkM+Nmao/nEeBR0YxqkINyhlMn
	ObCsD95BaAILXwoTPBXGuTaC4gKXEBSq5pj+WfU6DRg4qwd8nWTx
X-Google-Smtp-Source: AGHT+IG381um8P4nuvp96OOpBf9UflV0B4YB1ehNSZYCaFedYYLCnLHjsDUsueILK3/Atbe8E91cqQ==
X-Received: by 2002:adf:f20d:0:b0:33d:d82c:d5f7 with SMTP id p13-20020adff20d000000b0033dd82cd5f7mr1708354wro.59.1709315251882;
        Fri, 01 Mar 2024 09:47:31 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id ck17-20020a5d5e91000000b0033e05589096sm5285719wrb.89.2024.03.01.09.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:47:31 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v2 0/2] Update st,stih407-thermal device
Date: Fri, 01 Mar 2024 18:47:27 +0100
Message-Id: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK8U4mUC/z3MQQ6DIBCF4auYWZcGUSrtqvdoXACOMolKA4a0M
 dy91KRd/i8v3w4RA2GEW7VDwESR/FpCnCqwTq8TMhpKg+Ci5UJItjkMi56ZsgM3uhtbKQyU9zP
 gSK9DevSlHcXNh/cBp/q7/ozL30g140wZ3kh1RYtdc58WTfPZ+gX6nPMH0LPuvp4AAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

Those two patches update the thermal device by converting the deprecated
txt documentation file to DT schema, and adding a required property in
the device tree where it is needed.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
- [1/2] Change commit log to use imperative
- [1/2] Drop description
- [1/2] Drop 'clocks' description
- [1/2] Add 'reg' property
- [1/2] Add '#thermal-sensor-cells'
- [1/2] Make node name generic in example
- [1/2] Fix YAML style

---
Raphael Gallais-Pou (2):
      dt-bindings: thermal: convert st,stih407-thermal to DT schema
      ARM: dts: st: add thermal property on stih410.dtsi and stih418.dtsi

 .../bindings/thermal/st,stih407-thermal.yaml       | 56 ++++++++++++++++++++++
 .../devicetree/bindings/thermal/st-thermal.txt     | 32 -------------
 arch/arm/boot/dts/st/stih410.dtsi                  |  1 +
 arch/arm/boot/dts/st/stih418.dtsi                  |  1 +
 4 files changed, 58 insertions(+), 32 deletions(-)
---
base-commit: b6d69282db550689ab5980e06eedd23b64584a73
change-id: 20240225-thermal-8cd0ba7f452b

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


