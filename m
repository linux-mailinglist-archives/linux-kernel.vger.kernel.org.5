Return-Path: <linux-kernel+bounces-136408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E7189D3BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A651F21B09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5157D413;
	Tue,  9 Apr 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G1reIxae"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19977D3F4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649763; cv=none; b=AFjP1n1YGgZwJikIZUNi8bASSBOgb9q2RkCoSY2nQS98vY4oc2a3lw8fUi6gffBMf3Xq1ctEP5eOcjUKUq30tkaNJnAyy2Rdhdw6dN1zsqcLoiXI4pSp/0XdrTXDia+qDqx5TZnBz4uTBxPJGTgUMjDImGE4T2/XdDYcspi0MFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649763; c=relaxed/simple;
	bh=RMkmPex3frTv0AyXuez6OuNGGaWoHALG4+NitHzLX0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IxrqbW1w56JIhZy0whhlZ2npYqdbAfqUvrRMs1T8LPSpGiq/GRN0pjbwCeOPoLhHvXODggKeXV6vCFPOtoTphZP+LCl+n+s7dyRQJY/BatlyKDWva0OzODxUXXvpQCgD0FDLNVLIuPaOulFHViZd9T1tYFMti/Uc7HC1slArRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G1reIxae; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4397xoOD011668;
	Tue, 9 Apr 2024 08:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=AAyI8Q+pk2JwYrExyFP1SzDHgM54T10yf2PF96bdp/Q=; b=G1
	reIxaeknfGkH6+LRJnfzl8pG7bdHH1qrGUdE/Jr2Fk1nYKsUD+hofb4GOVhnoqOk
	/dXNT4JbISYV5UrolYZ0fiBNUuinFO38qi361NCQF8B2AEKqFNSLOzIF3EDyanwK
	syR+tc4dc1yjVo2FhwTdhkXuutfdGuizMpfTANktvwv2MfDDnMvDiSlKpbkbsR+n
	c2ahtvJHTAx4taKLSCIedzpF5vzT5rF/LyL6goQZph/TfggSnXZy7C5Po8fo0U03
	vFBNUG51ympeYPD5YuZklbON7oOFF9qTvvHqIxPpDG4PBw3g7YBWrvlimczx7HXu
	7f7TJ2nRzuX8JNedE6lg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xctku0nt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:02:37 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43982Z0B032522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 08:02:35 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 01:02:34 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <linux-kernel@vger.kernel.org>, <paulmck@kernel.org>
CC: Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] stop_machine: call rcu_momentary_dyntick_idle() from irq disable path
Date: Tue, 9 Apr 2024 13:32:16 +0530
Message-ID: <1712649736-27058-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zZSWVRbQdnNTK9h2e1ZWDbJBRWmXZSeV
X-Proofpoint-GUID: zZSWVRbQdnNTK9h2e1ZWDbJBRWmXZSeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_04,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxlogscore=751 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090048

rcu_momentary_dyntick_idle() is getting called from all the irq
disable path(also documented in rcu_momentary_dyntick_idle())
however, in multi_cpu_stop() it is not.

"

 * Let the RCU core know that this CPU has gone through the scheduler,
 * which is a quiescent state.  This is called when the need for a
 * quiescent state is urgent, so we burn an atomic operation and full
 * memory barriers to let the RCU core know about it, regardless of what
 * this CPU might (or might not) do in the near future.
 *
 * We inform the RCU core by emulating a zero-duration dyntick-idle period.
 *
 * The caller must have disabled interrupts and must not be idle.

"


Let's fix this as it is possible that during stop_machine() call for
a kprobe registration[1] can get stuck when one cpu(cpu4) calls
rcu_momentary_dyntick_idle() after acking MULTI_STOP_PREPARE state[2]
and other cpus have acked MULTI_STOP_DISABLE_IRQ and waiting for earlier
cpu to reach to next state [3].


[1]

    [<ffffffdb78c75c54>] __switch_to+0x1e8
    [<ffffffdb78c76520>] __schedule+0x6bc
    [<ffffffdb78c76af0>] preempt_schedule_common+0xb4
    [<ffffffdb78c75e60>] preempt_schedule[jt]+0x20
    [<ffffffdb77dd7bd0>] queue_stop_cpus_work[jt]+0xdc
    [<ffffffdb77dd781c>] stop_machine_cpuslocked+0xdc
    [<ffffffdb78c816f8>] aarch64_insn_patch_text[jt]+0x4c
    [<ffffffdb78c81938>] arch_arm_kprobe+0x40
    [<ffffffdb77de88c0>] arm_kprobe+0x3c
    [<ffffffdb77de84f4>] register_kprobe+0x3fc


[2]
000|check_preemption_disabled(what1 = 0xFFFFFFDB79153D0B, what2 = 0xFFFFFFDB7912A911)
    |  what1 = 0xFFFFFFDB79153D0B
    |  what2 = 0xFFFFFFDB7912A911
-001|__this_cpu_preempt_check(op = ?)
-002|rcu_preempt_need_deferred_qs(inline)
    |  t = 0xFFFFFF8806879F80
    |  pscr_ret__ = 0
-002|rcu_preempt_deferred_qs(inline)
    |  t = 0xFFFFFF8806879F80
    |  flags = 0
-002|rcu_momentary_dyntick_idle()
-003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_PREPARE     ==> This seems to have acked MULTI_STOP_PREPARE
                                             state and calls rcu_momentary_dyntick_idle()
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-004|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6D812F28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-005|smpboot_thread_fn(:data = 0xFFFFFF8805C063C0)
    |  data = 0xFFFFFF8805C063C0
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-006|kthread(_create = 0xFFFFFF8806B7EC00)
    |  _create = 0xFFFFFF8806B7EC00
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C063C0
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806402F00
    |  done = 0xFFFFFFC08005BA98
-007|ret_from_fork(asm)

[3]
000|touch_softlockup_watchdog()                                                    
-001|touch_nmi_watchdog(inline)                                             
-001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  newstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-002|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6D04EF28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-003|smpboot_thread_fn(:data = 0xFFFFFF8805C06230)
    |  data = 0xFFFFFF8805C06230
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-004|kthread(_create = 0xFFFFFF8806469D80)
    |  _create = 0xFFFFFF8806469D80
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C06230
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806401500
    |  done = 0xFFFFFFC08005B888
-005|ret_from_fork(asm)
---|end of frame
 
cpu1:
 
-000|touch_softlockup_watchdog()
-001|touch_nmi_watchdog(inline)
-001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  newstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-002|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6D23FF28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-003|smpboot_thread_fn(:data = 0xFFFFFF8805C06270)
    |  data = 0xFFFFFF8805C06270
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-004|kthread(_create = 0xFFFFFF88066119C0)
    |  _create = 0xFFFFFF88066119C0
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C06270
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806401000
    |  done = 0xFFFFFFC08005BA98
-005|ret_from_fork(asm)
---|end of frame
 
cpu2:
 
-000|touch_softlockup_watchdog()
-001|touch_nmi_watchdog(inline)
-001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  newstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-002|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6D430F28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-003|smpboot_thread_fn(:data = 0xFFFFFF8805C062E0)
    |  data = 0xFFFFFF8805C062E0
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-004|kthread(_create = 0xFFFFFF88067D5B80)
    |  _create = 0xFFFFFF88067D5B80
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C062E0
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806403F00
    |  done = 0xFFFFFFC08005BA98
-005|ret_from_fork(asm)
---|end of frame
 
cpu3:
 
-000|touch_softlockup_watchdog_sched(inline)
    |  __ptr = 18446743916840366040
-000|touch_softlockup_watchdog()
-001|touch_nmi_watchdog(inline)
-001|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  newstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-002|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6D621F28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-003|smpboot_thread_fn(:data = 0xFFFFFF8805C06350)
    |  data = 0xFFFFFF8805C06350
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-004|kthread(_create = 0xFFFFFF88069E7300)
    |  _create = 0xFFFFFF88069E7300
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C06350
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806403300
    |  done = 0xFFFFFFC08005BA98
-005|ret_from_fork(asm)
---|end of frame
 
 
Cpu5:
 
-000|check_preemption_disabled(what1 = ?, what2 = ?)
    |  what1 = ?
    |  what2 = ?
-001|debug_smp_processor_id()
-002|ct_state_inc(inline)
    |  incby = 8
    |  __ptr = 0
-002|rcu_momentary_dyntick_idle()
    |  seq = 0
-003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-004|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6DA03F28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-005|smpboot_thread_fn(:data = 0xFFFFFF8805C06430)
    |  data = 0xFFFFFF8805C06430
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-006|kthread(_create = 0xFFFFFF8806D58180)
    |  _create = 0xFFFFFF8806D58180
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C06430
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806402400
    |  done = 0xFFFFFFC08005BA98
-007|ret_from_fork(asm)
---|end of frame
 
Cpu6:
 
-000|check_preemption_disabled(what1 = ?, what2 = ?)
    |  what1 = ?
    |  what2 = ?
-001|__this_cpu_preempt_check(op = ?)
-002|rcu_preempt_need_deferred_qs(inline)
    |  t = 0xFFFFFF8806E03F00
    |  pscr_ret__ = 0
-002|rcu_preempt_deferred_qs(inline)
    |  t = 0xFFFFFF8806E03F00
    |  flags = 0
-002|rcu_momentary_dyntick_idle()
-003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-004|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6DBF4F28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-005|smpboot_thread_fn(:data = 0xFFFFFF8805C064A0)
    |  data = 0xFFFFFF8805C064A0
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-006|kthread(_create = 0xFFFFFF8806F67D00)
    |  _create = 0xFFFFFF8806F67D00
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C064A0
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806402600
    |  done = 0xFFFFFFC08005BA98
-007|ret_from_fork(asm)
---|end of frame
 
Cpu7:
 
-000|check_preemption_disabled(what1 = ?, what2 = ?)
    |  what1 = ?
    |  what2 = ?
-001|__this_cpu_preempt_check(op = ?)
-002|rcu_preempt_need_deferred_qs(inline)
    |  t = 0xFFFFFF8806E1DE80
    |  pscr_ret__ = 0
-002|rcu_preempt_deferred_qs(inline)
    |  t = 0xFFFFFF8806E1DE80
    |  flags = 0
-002|rcu_momentary_dyntick_idle()
-003|multi_cpu_stop(:data = 0xFFFFFFC084343478)
    |  data = 0xFFFFFFC084343478
    |  msdata = 0x0
    |  curstate = MULTI_STOP_DISABLE_IRQ
    |  flags = 0
    |  is_active = TRUE
    |  cpumask = 0xFFFFFFDB79E37718
    |  err = 0
-004|cpu_stopper_thread(cpu = ?)
    |  cpu = ?
    |  __already_done = FALSE
    |  stopper = 0xFFFFFF8B6DDE5F28
    |  fn = 0xFFFFFFDB77DD74C4
    |  arg = 0xFFFFFFC084343478
    |  done = 0xFFFFFFC0843434A0
    |  ret = ???
-005|smpboot_thread_fn(:data = 0xFFFFFF8805C06510)
    |  data = 0xFFFFFF8805C06510
    |  td = 0x0
    |  ht = 0xFFFFFFDB79EE8B40
-006|kthread(_create = 0xFFFFFF88070FF300)
    |  _create = 0xFFFFFF88070FF300
    |  param = (sched_priority = 0)
    |  create = 0x0
    |  data = 0xFFFFFF8805C06510
    |  threadfn = 0x0
    |  ret = ???
    |  self = 0xFFFFFF8806407D00
    |  done = 0xFFFFFFC08005BA98
-007|ret_from_fork(asm)
---|end of frame


Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..f93e6deb8150 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -250,8 +250,8 @@ static int multi_cpu_stop(void *data)
 			 * be detected and reported on their side.
 			 */
 			touch_nmi_watchdog();
+			rcu_momentary_dyntick_idle();
 		}
-		rcu_momentary_dyntick_idle();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
-- 
2.7.4


