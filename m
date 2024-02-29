Return-Path: <linux-kernel+bounces-86046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288186BEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4491C2292B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D2F36B0A;
	Thu, 29 Feb 2024 02:28:01 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DA168AB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173681; cv=none; b=j8vQ8zuxDbJtGCd5JBMt7YT2/O0HPL3FsAF5+YrP/FjZ4D7UUOdc9fSLOfg1FzHH35BLaA99lvb9co4inbBwyx57xkqezuVhYeUu66SeZVtBkAVaKPTSwJ7ePGlF3KIul3PKqEACo5vn0TSXF2S4mpsGIMJ6jvHd7PtbQ6mS0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173681; c=relaxed/simple;
	bh=X8tVYvUWVwPWvXjSZ7OR7RRWVXQ5R2FhzevYeToQz7w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IC4jML+gwjL/Ls4R7DSHiJfKoiqlbGRk2zWU0nP5q+pKGoc2z4JtVTZJ5xCpV0649XeXMIIaHmE06NtT0ryqhATP+OVpuO/C5i2ZbRZKmkO57V9XLbKiD9Js0faiftizADUWx4YTom+XJMk8H8ZkLmSEC2iNTc7uTs/DP7+nkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp78t1709173594tnnbjmsc
X-QQ-Originating-IP: 5b/G22WXjuRBomPeANlV/+RUg08N1JFgoyc+wAUXL3M=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Feb 2024 10:26:32 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: aBJFcW+uBGYb7MYu3t9R58LypuhxPKLYFfis+igqKlqyR1PWpW/I+28e+/e1X
	wprJhHyY1/RnVLHZuesR2KKsc8Uap5oQs6dBAyFXkT6h5xbqtU+ip2E9wvF14oMP5w+gHwx
	PCI2WXFpRNC1Qbc/kG1sNWttmSsfEWAWbutlhi1oREjfcjcAjExnLmtMD6bGE4B0Lxe7tsx
	QeFaEA+tqjRxedZZ/ABzk3N0uE3zvZUQYwoM1al11KiNBElNTm50Uh8Q8xSoQ0BLAWz5Teo
	2LV2YxNlMaiy762TUC55Rp7EoUCWkg53S3oGU61+M1PevBG/i5CCjUHul6OiNRvOJnuitOS
	3UeQHcRE6u2Si1yKxnlJPU5yHLPWZvngVgm8lmLoSnHOH7Foj8oeqJ5i5pHJ/rVhWS22ykZ
	820yi0ApbEtAYfJJb/jaDg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1125513446898690848
Message-ID: <29BBBFFB3CD52ED1+e0feef57-e609-4e14-acb0-65212a39380b@shingroup.cn>
Date: Thu, 29 Feb 2024 10:26:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/hx_arm_ni: Support uncore ARM NI-700 PMU
Content-Language: en-US
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: shenghui.qu@shingroup.cn, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240131070821.11477-1-jialong.yang@shingroup.cn>
 <fe3e97c0-f641-48d6-9941-837e73ae3cfe@arm.com>
 <7C9733413A0F8F60+0214f04d-173d-4513-ac1e-681c2f2a8de4@shingroup.cn>
 <8daf740f-f16b-49af-8da9-7c7750092539@arm.com>
 <fb75eadf-c029-4da7-bda5-300b7d7f51c1@shingroup.cn>
In-Reply-To: <fb75eadf-c029-4da7-bda5-300b7d7f51c1@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

 From d11d3c01978ef0fd8bfd125189c671c9bcc3c096 Mon Sep 17 00:00:00 2001
From: yjl00405 <jialong.yang@shingroup.cn>
Date: Thu, 29 Feb 2024 09:39:51 +0800
Subject: [PATCH] arm-ni:Some changes.

---
1. Some small mistakes.
2. Have not given 'NI_PMU unit->ns = true'. So no cycles event exists
    in arm_ni_0_cd_0/events.

Test(multiple cores server):
1. hotplug test pass.
    ~ # cat /sys/bus/event_source/devices/arm_ni_0_cd_0/cpumask
    0
    ~ # echo 0 > /sys/devices/system/cpu/cpu0/online
    ~ # cat /sys/bus/event_source/devices/arm_ni_0_cd_0/cpumask
    1
    ~ # # Test cycles event
    ~ # perf stat -e arm_ni_0_cd_0/type=6/ echo
    Performance counter stats for 'system wide':

                397282      arm_ni_0_cd_0/type=6/

          0.000228680 seconds time elapsed
2. Normal event test and overflow interrupt handler test pass.
    ~ # perf stat -e arm_ni_0_cd_0/type=4,nodeid=0,eventid=1/
    Performance counter stats for 'system wide':

                8192    arm_ni_0_cd_0/type=4,nodeid=0,eventid=1/

          0.123881102 seconds time elapsed

    There is no device after the interface. So I use devmem tool give a 
0x80001000
    first time. Then trigger the ovsr. See the counter value 0x80000000. 
Then
    I give 0x80001000 again and exit.

It's very hard to write such code without machine with NI component.
Could we merge our code and push it into community together?

  drivers/perf/arm-ni.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 4a769a421c81..d14ebcbeb598 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -171,7 +171,7 @@ static umode_t arm_ni_event_attr_is_visible(struct 
kobject *kobj,
         eattr = container_of(attr, typeof(*eattr), attr.attr);

         cd_for_each_unit(cd, unit) {
-               if (unit->type == eattr->type && unit->ns)
+               if (unit->type == eattr->type && (unit->ns | unit->type 
== NI_PMU))
                         return attr->mode;
         }

@@ -592,7 +592,7 @@ static int arm_ni_probe(struct platform_device *pdev)
         for (int v = 0; v < cfg.num_components; v++) {
                 reg = readl_relaxed(cfg.base + NI_CHILD_PTR(v));
                 arm_ni_probe_domain(base + reg, &vd);
-               for (int p = 0; p < vd.num_components; v++) {
+               for (int p = 0; p < vd.num_components; p++) {
                         reg = readl_relaxed(vd.base + NI_CHILD_PTR(p));
                         arm_ni_probe_domain(base + reg, &pd);
                         num_cds += pd.num_components;
@@ -612,13 +612,13 @@ static int arm_ni_probe(struct platform_device *pdev)
         for (int v = 0; v < cfg.num_components; v++) {
                 reg = readl_relaxed(cfg.base + NI_CHILD_PTR(v));
                 arm_ni_probe_domain(base + reg, &vd);
-               for (int p = 0; p < pd.num_components; v++) {
+               for (int p = 0; p < pd.num_components; p++) {
                         reg = readl_relaxed(vd.base + NI_CHILD_PTR(p));
                         arm_ni_probe_domain(base + reg, &pd);
                         for (int c = 0; c < vd.num_components; c++) {
                                 int ret;

-                               reg = readl_relaxed(vd.base + 
NI_CHILD_PTR(c));
+                               reg = readl_relaxed(pd.base + 
NI_CHILD_PTR(c));
                                 arm_ni_probe_domain(base + reg, &cd);
                                 ret = arm_ni_init_cd(ni, &cd);
                                 if (ret)
--
2.27.0

