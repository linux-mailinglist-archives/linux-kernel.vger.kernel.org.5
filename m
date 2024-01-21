Return-Path: <linux-kernel+bounces-32163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860A883577C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F911C2102A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B238DDE;
	Sun, 21 Jan 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWjRbmn0"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B83839B;
	Sun, 21 Jan 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866340; cv=none; b=sDdwFwz0ss/VRQRtBNlBMRVPVQ6dzuc+cieXM/jKgXfr8Cql5i7mTb9HScMeBcMwqpf2eBBNT+FfAJiZljlicQCbNMxpuDxpOYRjHc2Y2oczk3X/pS7m2kWElfKhTm/skZKgr2lzI+emFnMW2mwp88Mhnb65Nad4k4IYJyVyNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866340; c=relaxed/simple;
	bh=8C6dTD2/3CCQv2Fn6e1RTQEO7Ad75ZAIQh+QJwALEbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQUyAPrxQq7SCn+IdZAni5261hadHIjgOLwp+KmTgXlnTDmFEM+3Oxnv5oigUhqzuBv+dU7gM4UCdmJd3o3t0769x2VuWKmEeEpmt9Xb/hK036t6XFiB6xou4t80TylTQ7ZW0dczZ1ratY324qOOcXqi/ACDFcIk2iVkdkIXT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWjRbmn0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28b0207c1dso177355766b.3;
        Sun, 21 Jan 2024 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866337; x=1706471137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2dDmna/MWX2vDlMqYwoRWKFxPOqOpE2ADzV3jCsCUQ=;
        b=LWjRbmn0IqmqN4Ht8gZLLIkQVTDuY5W0zpCeQEjgNQYJHb0TeyjnsOsqeGe/aPGGQl
         H5ER6F6s+CQxAdbjEg2S3AXdkZRxuqySjNitSfCwpQ6ASGs2X8RgMRHAlYxw57eR7c5Z
         QHN2qwQgHsISQ462BX/w0M4YRDSrBflkRPRTBMCbWlef98X03fjpnt43ZEqJE9/ImewS
         3UEmOGmfjsozpPCo2fOuwKCeNM7G1ZF91GjUIrgbO6LR14J2v5VxMYWtR6b7Ig0dSUGQ
         sAuNndnWU7o0KAhtE+b+8/IF3bmnP6s0C9NjtKRD2EWtmuvDLWiv7f5v5HktDgzDpZoz
         u8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866337; x=1706471137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2dDmna/MWX2vDlMqYwoRWKFxPOqOpE2ADzV3jCsCUQ=;
        b=C9Nkg91UTtf04qhpc5gZ504DF6mQh/Y4nzpIiIulXJZqOMxpzYn9gPhtvrNVONHAEh
         deZwRL3MMUbALlzGLbyibOamtwHdSvtbUB3/TcRQYJj/tkvSwrwZ+qAlb4bRF90xT5YC
         OCx8hfkBik0AK/xalqZN0+oVXth1F7j7Z0dEiKTHcKToeEFbLa3XXIIaM5EmG8pxJnhU
         knIftaU8PGM2KJtqa/Ph24EYUo/nAjh8hn9Y3ZTtxsv4apvVUxttErORPXp5mSpFy9xT
         lD6rzZpYJXP9bkd/ZckcfcXQaGOtj5LIweKK5em/O7srtz3b73HNkAvNwmgcaYndMzGR
         vO0Q==
X-Gm-Message-State: AOJu0YzQ8jDtbtrxwVfqeD2E5BK72hWlauZL4qLFKKGOBRUHVgFYZeBI
	HIMN/lfmhMAtqVUkRiqAKZ20jVQtMG7wh3bZDfyoZk9r4H/7IH1jDLzzeaQ3mPk=
X-Google-Smtp-Source: AGHT+IF2DAbij4xCHFmYdAAyW4OsdvmNps4QU6Vdn+SiLznAgG58YkVFWmTNlcwIORbXSUyw3NYXyQ==
X-Received: by 2002:a17:906:6c81:b0:a28:e3e9:bc8f with SMTP id s1-20020a1709066c8100b00a28e3e9bc8fmr1875994ejr.32.1705866337163;
        Sun, 21 Jan 2024 11:45:37 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:45:36 -0800 (PST)
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
Subject: [PATCH 5/8] dt-bindings: drm/msm/gpu: Document AON clock for A506/A510
Date: Sun, 21 Jan 2024 20:41:03 +0100
Message-Id: <20240121194221.13513-6-a39.skl@gmail.com>
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

Adreno 506(MSM8953) and Adreno 510(MSM8976) require
Always-on branch clock to be enabled, describe it.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index b019db954793..9e36f54a5caf 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -133,7 +133,7 @@ allOf:
       properties:
         clocks:
           minItems: 2
-          maxItems: 7
+          maxItems: 8
 
         clock-names:
           items:
@@ -148,6 +148,8 @@ allOf:
                 description: GPU Memory Interface clock
               - const: alt_mem_iface
                 description: GPU Alternative Memory Interface clock
+              - const: alwayson
+                description: GPU Always-On clock
               - const: gfx3d
                 description: GPU 3D engine clock
               - const: rbbmtimer
@@ -155,7 +157,7 @@ allOf:
               - const: rbcpr
                 description: GPU RB Core Power Reduction clock
           minItems: 2
-          maxItems: 7
+          maxItems: 8
 
       required:
         - clocks
-- 
2.43.0


