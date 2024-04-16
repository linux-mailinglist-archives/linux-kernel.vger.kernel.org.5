Return-Path: <linux-kernel+bounces-146102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B48A60BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766EC1F21675
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61BE56A;
	Tue, 16 Apr 2024 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="gbhr6m/R"
Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E5E545
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713233519; cv=none; b=dv41lSg2EZNToGFM3maFVwxoEa24UTr0GfT2xSSlgMh9D4svc8Ay+px2orBG+6aHpSg0pKRsIVyMjbakHxU/T+NH6S3R6j/9M61P3hGZ8fCTDMkxv/zG0avJljPMvMnk3T+fxu5o7djOTSA3lz25JgANXy5jU85GjrvwKv1SiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713233519; c=relaxed/simple;
	bh=EySWZ6JvodAT+tzNLNcvmnw7/Y+NHXsrzgGbLxRPXzM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=Pehc2bMWf1+iOzfMjoQBxFoh3Lnn/Zv/++hkr4BmK+z+mjaNNzcPWO1ulRNHNJbAskR7WNxMvS2T9nhFmXWbR+q6HqqK61M197pKLvcSMN/HGX1z5m8ePgnDmgx6m9EIKlVrOlxWCVYBv+3pTNYZVxrNsvVVK9Eq4wLAtnqE3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=gbhr6m/R; arc=none smtp.client-ip=17.32.222.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SC0007KCJEJNJ20@ma-mailsvcp-mx-lapp01.apple.com> for
 linux-kernel@vger.kernel.org; Mon, 15 Apr 2024 19:11:13 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_01,2024-04-15_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : in-reply-to : references : mime-version :
 reply-to : content-transfer-encoding; s=20180706;
 bh=nngm6XbfyXatgPmHzfYVsTDCjG98BspYNzDPPSld7dg=;
 b=gbhr6m/RUiRpp4vxHjM2vtke+tHGcwvKL5WI+lW4NBWuQxWFm+k9j/cDDzavjHr1uLCu
 t6fmcEkbT9/d6D/NvYZDsC646OJPG0Dyo5pkSENXqaECArz74/LFgapo1JoQs/wkAPa0
 MD4V5YSnS2gQRRym93tigVHHIohox1qeY6um1aKyPuebfhh7zvTfvtblMmXexwMGFLqf
 cjMXfdQwu5odf0DEY6xRC/qFnS0/Yc/Rf24J+2TVZVcCEgq9ji1MygWSzqZ3slkDqcuK
 0z51k/Zz+RFaybt7Hy4VyP2tmErGx2fvpEKZVWPG3e1GkTyFKLsikDfm23zOzEubkXIs qg==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SC000JRMJEK9YH0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Mon, 15 Apr 2024 19:11:08 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SC000W00JDPRP00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 15 Apr 2024 19:11:08 -0700 (PDT)
X-Va-A:
X-Va-T-CD: c84eadf024378b077192ef8893434a32
X-Va-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-Va-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-Va-ID: f5c620bb-5ccb-43de-a622-5e0c3d6a8953
X-Va-CD: 0
X-V-A:
X-V-T-CD: c84eadf024378b077192ef8893434a32
X-V-E-CD: 631f076f6b365e42e06a1df7057e44fb
X-V-R-CD: ce6be43db0cce57f85f587e814b9d60f
X-V-ID: e7395067-f1a5-4f82-b3df-0533498a53b3
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_01,2024-04-15_01,2023-05-22_02
Received: from rn-mailsvcp-relay-lapp04.rno.apple.com ([17.11.155.73])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SC000ZG4JEIMF00@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Mon,
 15 Apr 2024 19:11:07 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: marcan@marcan.st
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
 mark.rutland@arm.com, zayd_qumsieh@apple.com, ih_justin@apple.com,
 Houdek.Ryan@fex-emu.org, broonie@kernel.org, ardb@kernel.org,
 mjguzik@gmail.com, anshuman.khandual@arm.com, oliver.upton@linux.dev,
 miguel.luis@oracle.com, joey.gouly@arm.com, cpaasch@apple.com,
 keescook@chromium.org, samitolvanen@google.com, bhe@redhat.com,
 j.granados@samsung.com, dawei.li@shingroup.cn, akpm@linux-foundation.org,
 revest@chromium.org, david@redhat.com, shr@devkernel.io, andy.chiu@sifive.com,
 josh@joshtriplett.org, oleg@redhat.com, deller@gmx.de, zev@bewilderbeest.net,
 omosnace@redhat.com, ojeda@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Date: Mon, 15 Apr 2024 19:11:00 -0700
Message-id: <20240416021100.87652-1-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: Hector Martin <20240411-tso-v1-0-754f11abfbff@marcan.st>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Reply-to: Zayd Qumsieh <zayd_qumsieh@apple.com>
Content-transfer-encoding: 8bit

The patch looks great! :) I have one minor suggestion, though:

>static __always_inline bool system_has_actlr_state(void)
>{
>	return IS_ENABLED(CONFIG_ARM64_ACTLR_STATE) &&
>		alternative_has_cap_unlikely(ARM64_HAS_TSO_APPLE);
>}

ACTLR_EL1.TSO is not exposed for writing on Virtual Machines on all
versions of MacOS. However, AIDR_EL1 may still advertise TSO, whether
or not ACTLR_EL1.TSO is writable. Could you modify the patch such that
we check the writability of ACTLR_EL1.TSO in system_has_actlr_state
(or once on startup, and cache it, since reading from AIDR_EL1 causes
a trap to Hypervisor.fwk)?

Thanks,
Zayd

