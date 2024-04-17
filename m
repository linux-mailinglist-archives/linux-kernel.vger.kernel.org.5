Return-Path: <linux-kernel+bounces-149013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C88A8A75
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8285B26DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC6B146D59;
	Wed, 17 Apr 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwgsgcoK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B7171678;
	Wed, 17 Apr 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376275; cv=none; b=VMHNbZf1wBO9EDoIjTotXuGFOfk5nnDyBmbqOFdMnTDVXgSDJqPs2NKbsC0b0Ut4OcMXkcJbHuQnRkyB7+iT3nnxmUOmJbiE8M6JKpNuz9FXRPC2rdXnHJREVSaCXuIPpwvcII56qsIyTpClVLmz6kLKwk0CnWICGFHysJs7K3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376275; c=relaxed/simple;
	bh=jfbqZBhQwdfbJjm2u3os2gYoQzVOvcpFVFeob+6Huh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBnw+RDE3LLrtK90iIz/lkkXgUrzCCN6qt4zdR3NRhxZS5sqOMIoR7rDsMZOwy8C5uvUcF99lz9rzi5jIEheb/wK7WpX9pfCWAezE+PWiLANt1m/SCF26knbU/MJ1iAeobEzBcQz3/M2NfED6rTToKh1PjLDaVTTuFxZupmrxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwgsgcoK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418cdc52627so238475e9.0;
        Wed, 17 Apr 2024 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713376271; x=1713981071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qVNaml9URaHp31c9KJm3syS03yWvEA9+eMiOQdyd5w8=;
        b=HwgsgcoKEz7ALHSr0mYH7uJBo5eO2L3ihhRr+b14TWQLs1u+/LBNdS7GzqZE0VWhV7
         loC9mpGpEtPciSL9VQLS4eDeJ48SkZ7X6uHrRgxYqey4vwh6F0Ql1En5UTpnb54GMWj5
         2g7QcbmIRRWGxKqm/GURimKjWiocpWufIHNsASeQs+dlqDgGkLMAJzpHFfwemqVCdTMj
         H1ii5yHDU/KkvzNGBN8U+MQ0ujoWHCq3JG6cpBpGz9h8LiqoSXNaJSk4n4wQP06Bj/Rx
         PsJOiBcf8F8Y7erI2XYHIv5OWhQBdx37/YzIiufEwbFUSJkv8qquwj9ZnXWljzOsSDmi
         z+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713376271; x=1713981071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVNaml9URaHp31c9KJm3syS03yWvEA9+eMiOQdyd5w8=;
        b=RT4R0BEP4WOpelCYodYmutorB9nKTLM1CSB9fJQq1uPE60ZR/Gkxpg+rsk52sMZWSd
         ljRjCtOQz8Wf9Rw+16YYzwbuofYaY5ook3RHY2yVS2v+tAkJEYpnNbB88VFVzqLKYf5A
         9GdOv0+3132SKcixssnwW6B4VUng12TcKwUj+cmrwURW2LQbfngdzoqTZSOMTR79vkAO
         b78XVbHPsQpnL542fUJa5sq8oFb/JAXMNC2sQDZKMtnC/fTIW1bIVLKcGJk3n+JF1BXU
         t3PrmgM8if8AB5fTQtdPt9K0TCq49ULAhLV92PGiciW0xl6z0ZhYlOZaA6g/qr22Zubx
         LAZA==
X-Forwarded-Encrypted: i=1; AJvYcCVlnLoOIhnjBe12y0wHz3tJ2xBEsUawZXi4emHAFAczkAm3R29EBa65NaLyw4jIC8FBcUUkj0jHh+pUBnJebo5pqO/IM/QBIxO7BBZVGvEMunKSyYQivH8d0mYjbln9yEEbo+42UNq1
X-Gm-Message-State: AOJu0Yx2PbhhK8q6PZwiXMbNanuSSB3GzZPOpDQGVhNIBY8QMql2Onb6
	MRKxlkmkei1WTE+Plvh6ic7sPd8LHX1KYPU7g2o22sTtUmNF3gzYPUzN7rllRhc=
X-Google-Smtp-Source: AGHT+IGcJJTynUREi6vtwF/8AEFhUQVGY9oq+V1ujfNF1XPbjEQ+5JuCU+zzogD96nWIP5hinIH2sw==
X-Received: by 2002:a05:600c:3595:b0:418:93d1:ef15 with SMTP id p21-20020a05600c359500b0041893d1ef15mr239395wmq.10.1713376271208;
        Wed, 17 Apr 2024 10:51:11 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b00418916f5848sm3569866wmo.43.2024.04.17.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:51:10 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: David Flemstrom <david.flemstrom@gmail.com>,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (aquacomputer_d5next) Support for Octo flow sensor and pulses
Date: Wed, 17 Apr 2024 19:50:34 +0200
Message-ID: <20240417175037.32499-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the flow sensor and flow sensor pulses
of the Aquacomputer Octo fan controller.

Aleksa Savic (2):
  hwmon: (aquacomputer_d5next) Add support for Octo flow sensor
  hwmon: (aquacomputer_d5next) Add support for Octo flow sensor pulses

 Documentation/hwmon/aquacomputer_d5next.rst |  9 ++--
 drivers/hwmon/aquacomputer_d5next.c         | 51 ++++++++++++++-------
 2 files changed, 39 insertions(+), 21 deletions(-)

-- 
2.44.0


