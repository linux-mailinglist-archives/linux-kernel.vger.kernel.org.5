Return-Path: <linux-kernel+bounces-123307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBB5890655
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C44A1C30AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661B42A86;
	Thu, 28 Mar 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV91+89y"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F662C6AD;
	Thu, 28 Mar 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644657; cv=none; b=P9WxAncn8ngjUQCddT+HS8hi6QkCjvRNHGhabYWPutOwL7RD2U5E5biX/K48vAnahZNhgswI3q7rLxivdgtMHNhB9/M7EXZ+iG2lzP0NzIYpEGTY6lIjJXhDbbBayGvhD9FLTj3Y6vfIuoieFb75olnMBmz5/lwHssQEsgvNfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644657; c=relaxed/simple;
	bh=x1AyqEYNuJV2UdALsxFxIpanpDIO/c/Kl2yTynX7pAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBlrTadecfenaaPJBid8K/JgBOWsOJiyCVQVJ99QKAsc5bPhenk/f3rbNYTeiYrV56/Qw/exCwyliMbJH3pWml/w9QMaQ6AyoLzKX19N8Qm27MFeRPKj02kd6ezDKmJ4rr8j2vxq+kagB443F294opsOm/a6y88S6eno945FfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV91+89y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4149529f410so11334285e9.3;
        Thu, 28 Mar 2024 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711644654; x=1712249454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chohju5qcWqn7tKOE6qaWFPc2NP1b0y320pfvMTbTjs=;
        b=QV91+89yY9WR2dZHMJRjfb7acOBcQSYfWUJcjHfF5wTGYrHmso7zcw7KhAzxsooRPt
         U2Aov8jWpjhu371XToCHkEvewv4Olo5HFUtfIgZKLHA5/gtDJXBrglDNgCzLYQ46Lhzi
         wpBzn5hv/M8fBKOLZYXHaehBzmi3n509ys2gQWeWw8uidzipUTpgUfAMq1pLLDAetgUk
         QfGxBQJxGNoB6flbXnD+oD+FIIwIna9A0nuzzUXZJNcLWM4ylJ4MWBiEYAefJyCZjwdg
         XliLw99iQIuCRMvrdmJrT0M/pVkzQuoowXdxBAStxiR7fz5JfgUilljpOVown6L9mDMk
         xC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644654; x=1712249454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chohju5qcWqn7tKOE6qaWFPc2NP1b0y320pfvMTbTjs=;
        b=BUls/s9/3xaLpgxY6ibI3+MhupG0oXaT0n4gEMy3Xh2qWgHOJ0qzS38n8BRCFcjrT1
         MRc2Mck3JzQmPxnqxXGun3MtTNB+SaUh4mu7oHZt+kjnd+1l+he+vClhCHJ6j+FPZD6b
         h9Ln8mUYmonw1jt0bb/DqmW5TbXj2HsYLlkUP1araISEiKztECcwmFDJKdUSeeCYFe1y
         DBBCYwKWWlYzz6CSTvY1rEupbpblBzsAyl64BY5anoN/NOSWbuuETQAC3Z8YzSfJGgKY
         6Q+hAMmv0tDulHQlEjmRGFtqHSoXOaI/KkF2simXhrxtwdVamHYat3Hv1j4UaOIvA+5l
         eR7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZbW/tMkkotyHDO/+6pc5At7FEfkVfYrf5lkwOKmzeYDLTCDGMmR6Qc6fKLwmZf+sq96NKVch/HxwaoJgovn5VwSMk9tjj5RjRZRP9
X-Gm-Message-State: AOJu0YzqrrdUVCaoo3doTFaBxEFe3jNdZ+gK4LV5q3J3Ng66N+ibxnyD
	h0axzOId7+o1PlbHMi03+yg6630QB6wKwplmEaQzA45Ji8i08kVz
X-Google-Smtp-Source: AGHT+IHlPZoWC72x/V2tooq6/pfiy/K3I1AwpGjIRrjYz6bFc1EMb5duZvZ3isfVAtYC/g9ESpWjCg==
X-Received: by 2002:a05:600c:4fd2:b0:412:beee:36b3 with SMTP id o18-20020a05600c4fd200b00412beee36b3mr3655877wmq.7.1711644654068;
        Thu, 28 Mar 2024 09:50:54 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b00414887d9329sm2803754wmb.46.2024.03.28.09.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 09:50:53 -0700 (PDT)
Message-ID: <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
Date: Thu, 28 Mar 2024 17:50:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325100359.17001-1-brgl@bgdev.pl>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240325100359.17001-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 11:03 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> SCM calls that take memory buffers as arguments require that they be
> page-aligned, physically continuous and non-cachable. The same
> requirements apply to the buffer used to pass additional arguments to SCM
> calls that take more than 4.
> 
> To that end drivers typically use dma_alloc_coherent() to allocate memory
> of suitable format which is slow and inefficient space-wise.
> 
> SHM Bridge is a safety mechanism that - once enabled - will only allow
> passing buffers to the TrustZone that have been explicitly marked as
> shared. It improves the overall system safety with SCM calls and is
> required by the upcoming scminvoke functionality.
> 
> The end goal of this series is to enable SHM bridge support for those
> architectures that support it but to that end we first need to unify the
> way memory for SCM calls is allocated. This in itself is beneficial as
> the current approach of using dma_alloc_coherent() in most places is quite
> slow.
> 
> First let's add a new TZ Memory allocator that allows users to create
> dynamic memory pools of format suitable for sharing with the TrustZone.
> Make it ready for implementing multiple build-time modes.
> 
> Convert all relevant drivers to using it. Add separate pools for SCM core
> and for qseecom.
> 
> Finally add support for SHM bridge and make it the default mode of
> operation with the generic allocator as fallback for the platforms that
> don't support SHM bridge.
> 
> Tested on db410c, RB5, sm8550-qrd. Previous iteration tested also on
> sa8775p-ride and lenovo X13s (please do retest on those platforms if you
> can).

Not sure in which version things changed (I haven't really kept up with
that, sorry), but this version (with the generic allocator selected in
the config) fails reading EFI vars on my Surface Pro X (sc8180x):

[    2.381020] BUG: scheduling while atomic: mount/258/0x00000002
[    2.383356] Modules linked in:
[    2.385669] Preemption disabled at:
[    2.385672] [<ffff800080f7868c>] qcom_tzmem_alloc+0x7c/0x224
[    2.390325] CPU: 1 PID: 258 Comm: mount Not tainted 6.8.0-1-surface-dev #2
[    2.392632] Hardware name: Microsoft Corporation Surface Pro X/Surface Pro X, BIOS 7.620.140 08/11/2023
[    2.394955] Call trace:
[    2.397269]  dump_backtrace+0x94/0x114
[    2.399583]  show_stack+0x18/0x24
[    2.401883]  dump_stack_lvl+0x48/0x60
[    2.404181]  dump_stack+0x18/0x24
[    2.406476]  __schedule_bug+0x84/0xa0
[    2.408770]  __schedule+0x6f4/0x7fc
[    2.411051]  schedule+0x30/0xf0
[    2.413323]  synchronize_rcu_expedited+0x158/0x1ec
[    2.415594]  lru_cache_disable+0x28/0x74
[    2.417853]  __alloc_contig_migrate_range+0x68/0x210
[    2.420122]  alloc_contig_range+0x140/0x280
[    2.422384]  cma_alloc+0x128/0x404
[    2.424643]  cma_alloc_aligned+0x44/0x6c
[    2.426881]  dma_alloc_contiguous+0x30/0x44
[    2.429111]  __dma_direct_alloc_pages.isra.0+0x60/0x20c
[    2.431343]  dma_direct_alloc+0x6c/0x2ec
[    2.433569]  dma_alloc_attrs+0x80/0xf4
[    2.435786]  qcom_tzmem_pool_add_memory+0x8c/0x178
[    2.438008]  qcom_tzmem_alloc+0xe8/0x224
[    2.440232]  qsee_uefi_get_next_variable+0x78/0x2cc
[    2.442443]  qcuefi_get_next_variable+0x50/0x94
[    2.444643]  efivar_get_next_variable+0x20/0x2c
[    2.446832]  efivar_init+0x8c/0x29c
[    2.449009]  efivarfs_fill_super+0xd4/0xec
[    2.451182]  get_tree_single+0x74/0xbc
[    2.453349]  efivarfs_get_tree+0x18/0x24
[    2.455513]  vfs_get_tree+0x28/0xe8
[    2.457680]  vfs_cmd_create+0x5c/0xf4
[    2.459840]  __do_sys_fsconfig+0x458/0x598
[    2.461993]  __arm64_sys_fsconfig+0x24/0x30
[    2.464143]  invoke_syscall+0x48/0x110
[    2.466281]  el0_svc_common.constprop.0+0x40/0xe0
[    2.468415]  do_el0_svc+0x1c/0x28
[    2.470546]  el0_svc+0x34/0xb4
[    2.472669]  el0t_64_sync_handler+0x120/0x12c
[    2.474793]  el0t_64_sync+0x190/0x194

and subsequently

[    2.477613] DEBUG_LOCKS_WARN_ON(val > preempt_count())
[    2.477618] WARNING: CPU: 4 PID: 258 at kernel/sched/core.c:5889 preempt_count_sub+0x90/0xd4
[    2.478682] Modules linked in:
[    2.479214] CPU: 4 PID: 258 Comm: mount Tainted: G        W          6.8.0-1-surface-dev #2
[    2.479752] Hardware name: Microsoft Corporation Surface Pro X/Surface Pro X, BIOS 7.620.140 08/11/2023
[    2.480296] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.480839] pc : preempt_count_sub+0x90/0xd4
[    2.481380] lr : preempt_count_sub+0x90/0xd4
[    2.481917] sp : ffff8000857cbb00
[    2.482450] x29: ffff8000857cbb00 x28: ffff8000806b759c x27: 8000000000000005
[    2.482988] x26: 0000000000000000 x25: ffff0000802cbaa0 x24: ffff0000809228b0
[    2.483525] x23: 0000000000000000 x22: ffff800082b462f0 x21: 0000000000001000
[    2.484062] x20: ffff80008363d000 x19: ffff000080922880 x18: fffffffffffc9660
[    2.484600] x17: 0000000000000020 x16: 0000000000000000 x15: 0000000000000038
[    2.485137] x14: 0000000000000000 x13: ffff800082649258 x12: 00000000000006db
[    2.485674] x11: 0000000000000249 x10: ffff8000826fc930 x9 : ffff800082649258
[    2.486207] x8 : 00000000ffffdfff x7 : ffff8000826f9258 x6 : 0000000000000249
[    2.486738] x5 : 0000000000000000 x4 : 40000000ffffe249 x3 : 0000000000000000
[    2.487267] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000841fa300
[    2.487792] Call trace:
[    2.488311]  preempt_count_sub+0x90/0xd4
[    2.488831]  _raw_spin_unlock_irqrestore+0x1c/0x44
[    2.489352]  qcom_tzmem_alloc+0x1cc/0x224
[    2.489873]  qsee_uefi_get_next_variable+0x78/0x2cc
[    2.490390]  qcuefi_get_next_variable+0x50/0x94
[    2.490907]  efivar_get_next_variable+0x20/0x2c
[    2.491420]  efivar_init+0x8c/0x29c
[    2.491931]  efivarfs_fill_super+0xd4/0xec
[    2.492440]  get_tree_single+0x74/0xbc
[    2.492948]  efivarfs_get_tree+0x18/0x24
[    2.493453]  vfs_get_tree+0x28/0xe8
[    2.493957]  vfs_cmd_create+0x5c/0xf4
[    2.494459]  __do_sys_fsconfig+0x458/0x598
[    2.494963]  __arm64_sys_fsconfig+0x24/0x30
[    2.495468]  invoke_syscall+0x48/0x110
[    2.495972]  el0_svc_common.constprop.0+0x40/0xe0
[    2.496475]  do_el0_svc+0x1c/0x28
[    2.496976]  el0_svc+0x34/0xb4
[    2.497475]  el0t_64_sync_handler+0x120/0x12c
[    2.497975]  el0t_64_sync+0x190/0x194
[    2.498466] ---[ end trace 0000000000000000 ]---
[    2.507347] qcom_scm firmware:scm: qseecom: scm call failed with error -22
[    2.507813] efivars: get_next_variable: status=8000000000000007

If I understand correctly, it enters an atomic section in
qcom_tzmem_alloc() and then tries to schedule somewhere down the line.
So this shouldn't be qseecom specific.

I should probably also say that I'm currently testing this on a patched
v6.8 kernel, so there's a chance that it's my fault. However, as far as
I understand, it enters an atomic section in qcom_tzmem_alloc() and then
later tries to expand the pool memory with dma_alloc_coherent(). Which
AFAIK is allowed to sleep with GFP_KERNEL (and I guess that that's the
issue here).

I've also tried the shmem allocator option, but that seems to get stuck
quite early at boot, before I even have usb-serial access to get any
logs. If I can find some more time, I'll try to see if I can get some
useful output for that.

Best regards,
Max

