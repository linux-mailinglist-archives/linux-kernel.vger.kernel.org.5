Return-Path: <linux-kernel+bounces-143792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3774B8A3D84
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D5E2823C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8012146430;
	Sat, 13 Apr 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5pGf375"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056D45C1C;
	Sat, 13 Apr 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022768; cv=none; b=rh61/xBRhxzQQoiDU65342776J/CfTHEHkVuUXfPfxCNzT+vp/2t4p/PO3x8O7Mn3iTVXZraS8JO9mH1v753arWM3mYqNP2CSkUBP/A3h8Op5wUcq7qIVuA3pE2AaPltAr6/GZZ+wiOxaqCRz0Ksp6JTna5Sieg6ImwXJHcSEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022768; c=relaxed/simple;
	bh=jL7uU696zbopMOteh9u4d9k59fFxvMnfP1MVAqxOv94=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ej4FzS05aTZbhf/7MN66c5sZdWg5stoTTKrXT+/vv+Iq2+R3LtM6NYMugAto0EWFysOV2a49PzRdA1Q0HHbe1OpAIdHECsipoNY0b04gnZxkBVukYzRinkwJpkUFujulSisnaKBYB7Nr3lgv/fQzquTANJS+6k1fr/R9qG4XsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5pGf375; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5200afe39eso219524966b.1;
        Sat, 13 Apr 2024 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713022766; x=1713627566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HNEWJOBlR0y7Hhtt6axRN9X/exAZdSvN2lHOcVrlbOk=;
        b=f5pGf375+79N2BHEX1fQKFTM60UI/1ZOoyjwEGlSmdDfMBMa3mKsex/Uul3sQKO/DO
         Nq2I3sIxxKOjeEvUXYe6SUo8RCN/ejQTPyfNiDEWd4bs1K2G+ymRoN4VaYCbGdS7LmXe
         kK0I0SxR9P1CXDIAbQN52sUbBteR4hgejOVuvmCdRZPm5KNK0ecQ/9qulcj8rxYrC59q
         HU85di/6k2LvdfcGe0EVXgDhSAFE0DI/1RFM7kuSSZqUf/6pPAB8iUtTUFB0jEyRt83R
         lV9DMkuwoXV/4fU3kS25Cw+DvLsAkGVxQi/e8t8n7FaCz1+01VIkmOzKNFvz68+J7i+n
         TgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022766; x=1713627566;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNEWJOBlR0y7Hhtt6axRN9X/exAZdSvN2lHOcVrlbOk=;
        b=uPkAV2SzsEYL4Jb4M4V9OgJh+zSbKztfUXtt1HAoo8AxSWkAjXVSGWE7CUNpFsYIe9
         +KG6qHsHk8jpAT38M2aRSlObbAXH5JbW2EEsNdL2OzBtNqB4Gqx9vJc66aYMbLFdFLsk
         yWOyI4mJyLqsSnY50bU6NRmXoTIZn3vg+vQB+1o36qS69K/7j19rJoRsPv1q4wY1Rt5d
         X58gzDGtgRBxAHibAwqfUB14lDbFpEDZBcWChuBOJ037CclV9PnOso1AVDczrd/JbCcG
         DufKZslCiqQpYkRzxyVkIpmX5YY89wR0DbnizN/f2pj9HNNtnLav/gq/+sOyRjvnlW0K
         YTJg==
X-Forwarded-Encrypted: i=1; AJvYcCVn9RTmtZGJ24UrFUHkrwfYDxDHBcsXIVV+pQo/q44JDoX9IV5cpcP+SWVFhqx6bo4/n2hZDrybfXojmZvdrB+w4QeTdQEL7E/NoSs+aQmUarzY1pmQ/kDS6S6g2MqvXj5Ki78qmNpEew==
X-Gm-Message-State: AOJu0Yx4pW/SQGMBGLcAAjZdDeAR+cOuGk+XTxkNwMargUL8KitTG1fP
	tu+vDFcvWF2kdgtn7Z2p13lzj52dPC9pBrEmX2bCvjv2daqcKxwM
X-Google-Smtp-Source: AGHT+IHqgFh+uk15K0EwlCSK5KyFNaBttoC/3mMIKlGeivBdJuPR/0PC//p06HrA73var6K2Mhrrtg==
X-Received: by 2002:a17:906:34d1:b0:a52:2e08:207e with SMTP id h17-20020a17090634d100b00a522e08207emr3722414ejb.77.1713022765539;
        Sat, 13 Apr 2024 08:39:25 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170906c80a00b00a51b5282837sm3131680ejb.15.2024.04.13.08.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 08:39:25 -0700 (PDT)
Message-ID: <521d4229-7490-4494-8191-cd5f3119249e@gmail.com>
Date: Sat, 13 Apr 2024 17:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/3] dt-bindings: display: add #sound-dai-cells property to
 rockchip inno hdmi
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, markyao0591@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Content-Language: en-US
In-Reply-To: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Rockchip inno HDMI controller can take one I2S input and transmit it
over the HDMI output. Add #sound-dai-cells (= 0) to the binding for it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rockchip,inno-hdmi.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
index be78dcfa1c76..5b87b0f1963e 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
@@ -37,6 +37,9 @@ properties:
   power-domains:
     maxItems: 1

+  "#sound-dai-cells":
+    const: 0
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

@@ -66,6 +69,7 @@ required:
   - ports

 allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
   - if:
       properties:
         compatible:
@@ -106,6 +110,7 @@ examples:
       clock-names = "pclk";
       pinctrl-names = "default";
       pinctrl-0 = <&hdmi_ctl>;
+      #sound-dai-cells = <0>;

       ports {
         #address-cells = <1>;
--
2.39.2


