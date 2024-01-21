Return-Path: <linux-kernel+bounces-32161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87642835773
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC08C1C20A77
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354AF383B9;
	Sun, 21 Jan 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqR+VBCt"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2438DF8;
	Sun, 21 Jan 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866315; cv=none; b=oJZqlPP7XcPfbQJOa7G6zK79i+XAsNuo2SpLQ5ZwzwsFkj/+qB5rYl2VzqPAV/IsrNGi3bw05zkVfwOUVx2LyuLDbWU+j9Sq5JnPfqRMcEahDoey5fuIuSS9J1DMk9RQmRKHDrOOlDKs0oF7Z6cm26GgQpHiViPDj3zh6hIlo8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866315; c=relaxed/simple;
	bh=UC94Wx9bEdnTNb8+XYn/4CYrJy/OEJGMp4Nv9V4ecE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hNKpxQyS9BzCWm4nvjXnxzAnw++Io+pe77IEAy6r8PctCPboZUxEsybZu5M3r720PDqu6cmyetqt17auWFX+o2g6ITsXHegBcxAlAVKOvg6kaSyQLhdKTO5ouXoiuiokHsChWuZOVKYy78yMwoEwS70X94pEPcjh1XiNwV4R1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqR+VBCt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-339289fead2so1546311f8f.3;
        Sun, 21 Jan 2024 11:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866312; x=1706471112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1xj7QKpcdq4XanNhyH8PlkFLqxpi5ERSOGj9kIBnKk=;
        b=WqR+VBCtdM0Mbw5yMJccIyzF0opbw5rZzLAuV00bb99lnktHm+S8rY0bFz+75IsBlp
         jZD86bNmRKGqV4Q1WpDViFu1QugnNDO5r/GrVlGtvn3VpHd6FcQvm0yXLO+fk6FPPNRO
         hYehFoMkV9RZYBAoJ3M8q39pfeCGjYR5YVToiUoo6eDUb+k2HOMFJdtaXeB4xlTj8w+6
         KSswO8PA22pf+iHqV5Bxzn0/Y2Mx1YFavYcY0ckAYcWEHHL/tyJNTigSzVa970QHi9lp
         rzAcltd9yCuMQ4g273OIP5o8WPdOE7gVxO9NOF3bbKCpIqZREPkkte3PCYLvvWCmw1AA
         CPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866312; x=1706471112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1xj7QKpcdq4XanNhyH8PlkFLqxpi5ERSOGj9kIBnKk=;
        b=UskzlD4o8u3KBvaZHfmgK8/glmObjhzDMorjJFwjNAMoCare1D43GC636wcHcYfHUp
         kQuCxFY7fHvJR2xg/SSHng1P7XALHuSxZvYlkFkdY6qWA3iMddxhofkxeEEkOCuCaG/c
         nUQ+9Gvfsg6XgySa80XnvVDmWLroyAFhk7ikuCvPL0u2cIhX/mwEoBXimp2R5m9YlHZc
         UoRRM1CLehybzXDWbpVCfdRtLXP9qSfiZvCW4atnFVPgtI3+STd3eH8cJzJiEpAZBgwP
         O9IJRq+S8h3I0MhA2FWnCUCZxUdhIbFG8jT3fTfGauIwKpQeKXOK081o/F9p/suBYLPh
         RA0g==
X-Gm-Message-State: AOJu0Yyd1igAtr4/a+D4d7SNfP3FVK4Pzha1CUIKMBsPxMXOh48Ve1QR
	h+BHW/TCWJ2cBVmg+Xho4Mw0yGRfYU+cT+yIQMyJbMu88iYDGBUn1HRcGkHS+d0=
X-Google-Smtp-Source: AGHT+IFXVwttOkq/35bDzPfwT/wM4HP0z056E5OBcpImQRqU9YowudzK8lxKlAYn532chvCaTf3H8g==
X-Received: by 2002:a05:600c:3c9e:b0:40e:a36d:ccd1 with SMTP id bg30-20020a05600c3c9e00b0040ea36dccd1mr1487870wmb.207.1705866311866;
        Sun, 21 Jan 2024 11:45:11 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:45:11 -0800 (PST)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] dt-bindings: msm: qcom,mdss: Include ommited fam-b compatible
Date: Sun, 21 Jan 2024 20:41:01 +0100
Message-Id: <20240121194221.13513-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121194221.13513-1-a39.skl@gmail.com>
References: <20240121194221.13513-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During conversion 28nm-hpm-fam-b compat got lost, add it.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
index 0999ea07f47b..e4576546bf0d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,mdss.yaml
@@ -127,6 +127,7 @@ patternProperties:
           - qcom,dsi-phy-20nm
           - qcom,dsi-phy-28nm-8226
           - qcom,dsi-phy-28nm-hpm
+          - qcom,dsi-phy-28nm-hpm-fam-b
           - qcom,dsi-phy-28nm-lp
           - qcom,hdmi-phy-8084
           - qcom,hdmi-phy-8660
-- 
2.43.0


