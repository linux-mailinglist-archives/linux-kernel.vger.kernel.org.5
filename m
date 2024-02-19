Return-Path: <linux-kernel+bounces-71503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AAC85A648
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A071C21DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB7381CC;
	Mon, 19 Feb 2024 14:46:54 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA8381B1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354014; cv=none; b=mlTu+MDfqB/QPQt3KsBSgUUJQgLY+YYqdv8H+WC2GmAVWCpk9tRRSNSt0P+yYvJexeOl8Pd8AF1tX1YVPlBEiY8B/x+1QgsFC0uYnosGBjFnsGhyE5Vi0IDi35Kr2Iqkj881/RxKZzOHuKFDZa/MdAN7ld6UHXEppPP6t3xCrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354014; c=relaxed/simple;
	bh=kpIRgmjNfP2xfAUjdOKDDAgk+2y6zCPRfbk1io7KGWg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ffGDVzRCtHy/S9AFHLn+kcyoDw8Zjfp/rhfU9X3v0eUBLAUiKxNBd5R5cGCd7MN0+nDwo2DviJBR9DXC/6MTOv9Muya7VBDp8BeiezTaN7QA+C+c/7K2YzMgt4f1IF2fLk0QHp5MSCdFG1vtwqJzTcyoLvcAK3Sz2cVGOwtRU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TdlgF21Gvz1gyfD;
	Mon, 19 Feb 2024 22:44:41 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 516CC18002D;
	Mon, 19 Feb 2024 22:46:48 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 22:46:47 +0800
Subject: Re: next-20240219: arm64: boot failed - gic_of_init
To: Marc Zyngier <maz@kernel.org>
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
	<linux-kernel@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, <lkft-triage@lists.linaro.org>, Linux
 Regressions <regressions@lists.linux.dev>, Catalin Marinas
	<catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYugYiLd7MDn3wCxK+x5Td9WO-VUX2OvOtTN7D1d4GHCfg@mail.gmail.com>
 <86edd84wer.wl-maz@kernel.org> <86cyss4rl7.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <a7d8e529-9a44-3f88-50ef-d87b80515c36@huawei.com>
Date: Mon, 19 Feb 2024 22:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86cyss4rl7.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/2/19 19:32, Marc Zyngier wrote:
> For what it is worth, I've just tested both defconfig and my own
> configuration with both 4k (kvmtool, QEMU+KVM and on SynQuacer) and
> 16k (kvmtool), without any obvious problem.

I had a quick test on top of next-20240219 with defconfig.  I can
reproduce it with QEMU parameter '-cpu max -accel tcg', but things are
fine with '-cpu max,lpa2=off -accel tcg'.

Bisection shows that the problem happens when we start putting the
latest arm64 and kvmarm changes together.  The following hack fixes the
problem for me (but I **only** write it for kernel built with defconfig
with ARM64_4K_PAGES=y atm).

I can investigate it further tomorrow (as it's too late now ;-) ).  Or
maybe Marc or Catalin can help fix it with a proper approach.

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4f7662008ede..babdc3f4721b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2798,6 +2798,7 @@ static const struct arm64_cpu_capabilities 
arm64_features[] = {
| 		.sign = FTR_SIGNED,
| 		.field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
| 		.min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
|+		.max_field_value = BIT(ID_AA64MMFR0_EL1_TGRAN4_WIDTH - 1) - 1,
| #else
| 		.sign = FTR_UNSIGNED,
| 		.field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,

Thanks,
Zenghui

