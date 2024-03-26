Return-Path: <linux-kernel+bounces-119871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DCF88CDF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6741F66BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA113D2B1;
	Tue, 26 Mar 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg/mjcCC"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13613D295;
	Tue, 26 Mar 2024 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483960; cv=none; b=sdwYSLaGmCXVN9a7iEP9JbiOdgof+nMwv9ldyyurEFqiuqPpfI/JqUncEUx15Q5uJoigRnxaVbY3hLN0mUO5RnxhXuU9XgwmuKuJ84QR0A+6Hhs2dGrlE3VNmb7+uMGQxePJjTLvXgwCleu+rzXkNyyg27fgzlfnYXArJlxfEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483960; c=relaxed/simple;
	bh=RKV33t6NM50ofM+TdpIua/TkfTKHK73Iq3XDVFTSM08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YiDeLtV0mlqSgLAYivSCreMGAOrIjzcxwPOEpC7/BVMCyv8YZHts4I7kd8AWAIz+RQoS0rwHeRPQJqCKojuQfZDFx6uwgqqiJ9nRLgW17yOAkI2qXUS2VhnviUXhSsN3/IzoU3KuBBs7xGNaGM5IL8bmW/thPWg/PgkDXIKwrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg/mjcCC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a466e53f8c0so788234966b.1;
        Tue, 26 Mar 2024 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711483956; x=1712088756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUqd/hXXnUj9kaAJZ97jeBbCMUvezK3PPckw8kw8588=;
        b=Tg/mjcCC74ht1i61CgI/dWue5UN1OQEm3s+K2cxA+C084b0p1d+getHgxKA5p8m9jj
         VAPwG9FS7rhG9neGQa24zRSNZOXdsnYQHIjkZyDITUSKyJWVXoOk/VO6aPgY2LI2TPeH
         bw+DWudpSxqu8Lg6hajZredmgfVkhHUXX+WUto6eyeoabIdfg/8aA+aioaoF0yQ/CUWN
         H0E9KYdBmgUvwpebTG17FuE0F7rULrII41rDabeC/3ydRDg/l/Mp9dn21rNCNeWXKEuC
         biofIV6orCvTLx/vADqIPRbzk2aCUUsS8l0H/ShKEOgUzraxdcHUWGwcfI7w7LJfhr0K
         +oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483956; x=1712088756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUqd/hXXnUj9kaAJZ97jeBbCMUvezK3PPckw8kw8588=;
        b=iWrCClzxsMpb2jNsIPqk+HurRvIo8Vjx0c3xAq5f6N5I1anx8U6uemrm/X+FNu8etI
         gc5Kg3Y1ZlrTl4I5+hhzJmuBk9s6q6mJBz3v2yfMRYjfb/AdnJQptZijCW8N3wokxXpY
         ryz7vjGgx4+cOFPyJOBYZr49Tiasp3uGRiZ1Zo2z2DytezWOa84vfpF8shzB7F3S6Ua9
         KnKld7VRc/s3Fo+T3+7Duagl50fnReYaEKzf2ASMfJcNviItstFb5CR7YW8ImhRucVFw
         jjhWZYL2rxJzfCaz/dF0wE5t8gBAGaaCG/so52yNDPUgG4OLxhHHC1XtEVB95/l79p1W
         wrTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTZ5R71tM4NL3x1Q2BO7Nxqs6Tq5dKdCRDQ3BrL3SScV91raumqLnjOhXwp6eaK4vQ4+SsB41cZskNZ9V6asVq1a/3sdc8/moLQhVbJhCJpmr/dnFUeuqKuPktbOpwT+56yv5fyYRNMguCvGnbRsp0lNSbKRD1h8Dq+55mtNMKckHlCKkR+QY=
X-Gm-Message-State: AOJu0YypivZsGQQ4RaVoKGPBPFn9cyQ4v6aNfJ3enUbVKV86JVDg85zl
	afC7vR0Jp5V7P7gs58daOXGxxMkFbsy2JBbR99QxOzensguIEL94gZwI3paD
X-Google-Smtp-Source: AGHT+IHg3ORZ80GhUvJ9XJEF6YPpHT+zBqZGXseRfkvUVWidu77wObbjjRoQtlhIZSCbSWeVSEZbqw==
X-Received: by 2002:a17:907:7d92:b0:a47:5248:68d5 with SMTP id oz18-20020a1709077d9200b00a47524868d5mr7307816ejc.60.1711483956009;
        Tue, 26 Mar 2024 13:12:36 -0700 (PDT)
Received: from localhost.localdomain (byv80.neoplus.adsl.tpnet.pl. [83.30.41.80])
        by smtp.gmail.com with ESMTPSA id du1-20020a17090772c100b00a4da28f42f1sm1714257ejc.177.2024.03.26.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:12:35 -0700 (PDT)
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
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] Split Adreno schemas
Date: Tue, 26 Mar 2024 21:05:57 +0100
Message-Id: <20240326201140.10561-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following recommendation from Dmitry Baryshkov this series split schema
into separate schemas per gpu family, as i don't really understand much
of yamls and dt-schema i decided to send this as RFC and if there
are any changes suggested i will be glad if these can be explained
to me in ELI5 format.

Adam Skladowski (1):
  dt-bindings: display/msm: gpu: Split Adreno schemas into separate
    files

 .../devicetree/bindings/display/msm/gpu.yaml  | 317 ++----------------
 .../bindings/display/msm/qcom,adreno-306.yaml | 115 +++++++
 .../bindings/display/msm/qcom,adreno-330.yaml | 111 ++++++
 .../bindings/display/msm/qcom,adreno-405.yaml | 135 ++++++++
 .../bindings/display/msm/qcom,adreno-506.yaml | 184 ++++++++++
 .../bindings/display/msm/qcom,adreno-530.yaml | 161 +++++++++
 .../bindings/display/msm/qcom,adreno-540.yaml | 154 +++++++++
 .../bindings/display/msm/qcom,adreno-6xx.yaml | 160 +++++++++
 .../display/msm/qcom,adreno-common.yaml       | 112 +++++++
 9 files changed, 1157 insertions(+), 292 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-306.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-330.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-405.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-506.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-530.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-540.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-6xx.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-common.yaml

-- 
2.44.0


