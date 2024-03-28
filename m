Return-Path: <linux-kernel+bounces-122705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1AD88FBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768C0299FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2BC657BC;
	Thu, 28 Mar 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="A517Hecg"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3B53E3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618984; cv=none; b=MimDKMj1G5hgHP+WRpwkf5N+M4EM1xjA5svwl6ENW9zKY3p8ohh8c/ysdegCybLqHfTWMrkbO0DJpSYgSLW20o0Zdj/6mSTB0kGLAT6OOGgXfKsK9FdGy/1Nh1dN3mu3lrh5vJPcbh78B789m8MpQ6my8kizfP9mmyfizrwyWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618984; c=relaxed/simple;
	bh=LGEkUHOJ/ZabB/vOZCvlgo1ZTv4zJQZ2hEQTHroQ8lw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=US0zSPQ7h6xKgLJxv0ddWJ+4/9+ff36oom1aDwRNEXfliQmSmMgBreZ20qHMcJrlU9XpnFlZZGMG7KY+yRosivdbbPzuYkUUNNlhwQAcabFg0mZvQ0nMz8CqnatYiiVLLTij4KCW1fPP63q27F2nB752hEoG/FPur4QJtvE2aA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=A517Hecg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so1126785a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711618981; x=1712223781; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8hsC6NRPdxLP7lp60lSArweYtIzuit1meomkaj/K1Q=;
        b=A517Hecg8ITw0yfx99kApqt+m7/6d4suTbkNYg8e5J4q+tW5b1UPuFPxLIBNRXrfdT
         nrSBaNC2eH5arcETlpqVfyqxOmR66VR2jVIcL3nQ70NFYvkSOu7SOjWkRYt6THH/EE41
         TFVOyDwRdZ0qRsIba0gv4vuinG4trJ2o3TnHXkJYRSY6aC21wg25Fho6+q8KqeXgd7UJ
         A4ne8I/YwysPf1SivN6+7AXC8H78U9PQ2rsd5rUtrFz5cdm6ybfLSVlcvxBw9zONkpji
         o33prPxXjkFaCwOkNtA/f/OLve7Qqn6OmkefHR1qpxUdixQVz3/yFDjj6c75UdmYflka
         DDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618981; x=1712223781;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8hsC6NRPdxLP7lp60lSArweYtIzuit1meomkaj/K1Q=;
        b=QJx2gJNDu7U05E1jmkHNTb+4bjryw+CE56O7NCr+bql+GlR80tfTyuroj0bZWHEjB1
         KhDgIjgQm5TbrBSRFgZm8g+ofoF/MUidDMTu5CMeecJU6eOki9/9CDt1InzOh8ugvT1q
         3Vo+otHPaxKM47JJ2yqCWyK3kU+kHTL72AfPiOpLwUJGivHHClo+5/i5xOpl3jR9Yn7X
         3xdCDswz3VgoF5IXSxblOxtC7NWd3jA3NtkZ9yQ8rqugFzZj3LDucYt+W4zSquL+3MXU
         uzbHAdLKaQMb5Jjy+rJndmOwh3CrBTliAJp08rmV6ZzHjPgBTpLvH3RmA4L0eBCY9v2l
         OR3w==
X-Forwarded-Encrypted: i=1; AJvYcCX3VYj6Xdd1QdiGN8xAuabEIZp5ZMKcEoaHP5CJzWInE0DnLNbsQx8FpSeEVLfI8/Nw4Tz6RlM3L5Jamz4FjoJSKDBZNfHb9IeaUk2Z
X-Gm-Message-State: AOJu0YyEM0Qvfo2zBU5sBiCnRk9tWJ8WOY8OJEbRi+JQtASS6JPYR+xC
	lyo6dIRvtjWVLFojj4VtvYMSXcy55raVpiqBjPe4bPVkODDbOE3SOIXFjwI7l50=
X-Google-Smtp-Source: AGHT+IGZx9AnkUFMackC9AU36r/cR4Kcv7nBXW0BJa3Ktjw3YvY08GtNzCtirWitkr3VymvIRKiZQA==
X-Received: by 2002:a05:6402:348d:b0:56c:26aa:f786 with SMTP id v13-20020a056402348d00b0056c26aaf786mr40326edc.10.1711618980811;
        Thu, 28 Mar 2024 02:43:00 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7c302000000b005645961ad39sm631362edq.47.2024.03.28.02.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:43:00 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] DisplayPort support for SM6350/SM7225
Date: Thu, 28 Mar 2024 10:42:43 +0100
Message-Id: <20240328-sm6350-dp-v1-0-215ca2b81c35@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJM7BWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyML3eJcM2NTA92UAl0TQyNjC0NT4yQTEwsloPqCotS0zAqwWdGxtbU
 AQBFn8VsAAAA=
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Add the required changes to support DisplayPort (normally(?) available
via the USB-C connector) on the SM6350/SM7225 SoC.

This has been tested on a Fairphone 4 smartphone with additional changes
not included in this series (mostly just wiring up TCPM and the SBU
mux).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      dt-bindings: display: msm: dp-controller: document SM8250 compatible
      dt-bindings: display: msm: sm6350-mdss: document DP controller subnode
      arm64: dts: qcom: sm6350: Add DisplayPort controller

 .../bindings/display/msm/dp-controller.yaml        |  1 +
 .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 10 +++
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 88 ++++++++++++++++++++++
 3 files changed, 99 insertions(+)
---
base-commit: 871760455183dc66b3e185f8d3ed2184cc9fac25
change-id: 20240328-sm6350-dp-41238153b448

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


