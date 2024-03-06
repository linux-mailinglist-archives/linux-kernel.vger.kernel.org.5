Return-Path: <linux-kernel+bounces-93370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285F872E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3EAB20F16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68B1BF53;
	Wed,  6 Mar 2024 06:12:56 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7381BF3A;
	Wed,  6 Mar 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709705575; cv=none; b=HiXPfBoPRPk0ADcG4zaHI2nrC1wkSq6liHR3I04hE1qSPTUolkxvuDJc4XfrKxEYKm/Nf+lbm876eko8+guaYCzGVlRMGNJICQQSOPVFkqF9khnJdHNPHhYhuW6qT8rwG3zec8EqT/A1wA2/8ZnHqjvSnCz3Z7fvYLxQ3yamkrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709705575; c=relaxed/simple;
	bh=XB/s6LrajRRxZPmS5K2ul+Jpp/Bn57dJki7p95qfCJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G6g7o3Aghqx6KRo0XgY91qfRS8ghOYrwIIHRHBoOrxoh0x9kbtVaIqCaAQ2AdJL7/YvxFs13EhsGIxEJvvGxkoDzFjF4FzWoSBQu8NKSh+xLrW2orUni0Z+oHWH8Uo1LRcQ48lUWtbOtSDDpMSRvpzDXz2WdNwk5T27HaUM9CQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1709705530tejr8mq9
X-QQ-Originating-IP: 33F7Hi8mkHJ/3GMhdDRcEqGpiRerVDDLcrCN+G+D9ek=
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Mar 2024 14:12:08 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: zT6n3Y95oi0QQ5IUMJfGD5BCp0MrFSEZjYCXXN07Kjl3bKZmTCPMHHTLiXx+0
	Z1YAJaMJZ45EP04YVC/wcllIeJmmC4MgCfzD6MxN6SF8mCzilEbDF/efn4LJdbpT7dWCGJt
	B2bPzhoTAwKQrZlC54zr6tUmQXEgeBjo6aXNnX/QoheTguv1CfScumys3U08NydzAK1QalU
	4VljwBdaiCsS1Vuc6R84+uLE5NyGoiaFlDhNlqcMlXtAB4eRDMoCDrchbrSzUz2+w9y9d2C
	VrgfXN+2/epHpKPNlNqYh4DEKpf7v+alH4T8D6KsW60yrra6GHCHzSK7WbvKrUQH5Z7qkU0
	n7CO57tmqjue9pw2vUY3c3aLYOsjYKfMGtguDyvgs0iEmrAGS+bu3GVr8HkJN0rFULU/90Z
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9495034024272623364
From: "JiaLong.Yang" <jialong.yang@shingroup.cn>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: shenghui.qu@shingroup.cn,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Support uncore NI-700 Performance Monitor
Date: Wed,  6 Mar 2024 14:16:00 +0800
Message-Id: <cover.1709694173.git.jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

1. 
The MAINTAINERS file should be in dt-bindings or drivers?
It's needed by the two subpatchs.
I place it in dt-bindings. So I receive the warning in driver patch.

2.
When using the new macro DEFINE_FREE(), we should ended it without ';'.
So there is one warning asking me to indentation next statement.

3.
If the file vendor-prefixes.yaml should be submit solely?

JiaLong.Yang (3):
  dt-bindings: Add HEXIN Technologies Co., Ltd. vendor prefix
  dt-bindings: perf: Support uncore NI-700 PMU
  perf/hx_arm_ni: Support uncore NI-700 PMU

 .../bindings/perf/hexin,c2000-arm-ni.yaml     |   51 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    6 +
 drivers/perf/Kconfig                          |   11 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/hx_arm_ni.c                      | 1240 +++++++++++++++++
 6 files changed, 1311 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/hexin,
 c2000-arm-ni.yaml
 create mode 100644 drivers/perf/hx_arm_ni.c

-- 
2.25.1


