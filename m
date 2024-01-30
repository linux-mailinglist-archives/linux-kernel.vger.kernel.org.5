Return-Path: <linux-kernel+bounces-44256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3AB841F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56910B281D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383C59B4E;
	Tue, 30 Jan 2024 09:27:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09A57891;
	Tue, 30 Jan 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606876; cv=none; b=oZgReyCPQcdqKQcxR9pSS37YgQh1hQqIf9nghKeX50WgeINV6rjos60RHojcoKHDpHrT1sVGrwR1YfhpqBKkGfoVAMZZUm8F84LtfdlHVWtp3y6scW+2A0QW4Gnba2ROgzdHyKgqDjnV5y9SeAKjWh7Qxb/eUFmggReKNmokGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606876; c=relaxed/simple;
	bh=cQyNKX5SJGiHTCO+KmEdO+MwVWTOKOVYyLhPuY+O8bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PerSJ6mUZkwDjqEZSmkDGRIqBex0nPo8JtpkGN085RstRIwHvv0VHkanuMwWjrh9Y2D4E6WDrWih9Eey9MNS8OKmxohH+i36JxOEikT9JhCLIPQN1qrUgYSZCVBtt3o/T5hc+ppBcnybpoZuOoYlUvIZerJXqr+yZT97qae+NDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8CxrusYwbhlN0oIAA--.25346S3;
	Tue, 30 Jan 2024 17:27:52 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs8WwbhlWL8nAA--.23412S3;
	Tue, 30 Jan 2024 17:27:51 +0800 (CST)
Message-ID: <e45bd402-0c39-4075-a730-1dd5f4fc2208@loongson.cn>
Date: Tue, 30 Jan 2024 17:27:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/doc: Update EM API em_pd_energy to em_cpu_energy
To: Chenggang Wang <wangchenggang@vivo.com>, Jonathan Corbet
 <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Pierre Gondois <Pierre.Gondois@arm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <TY0PR06MB5470E30E86989E8CD84FCE0DC47D2@TY0PR06MB5470.apcprd06.prod.outlook.com>
 <1706585531-24072-1-git-send-email-wangchenggang@vivo.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <1706585531-24072-1-git-send-email-wangchenggang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs8WwbhlWL8nAA--.23412S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFyfWF4DuFW3ZF4UtF1xXrc_yoW5Xr1xpF
	ykKr4xtF1fAFn8KryxAw1UXrWrXw4fCayUGFs8t3saqrs5ArW0yw13t343Grs7ZrySyFZr
	XryYg3s2yw12vwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU7PrcDUUUU

Hi Chenggang,

在 2024/1/30 11:32, Chenggang Wang 写道:
> The em_pd_energy function name is obsolete and non-existent now.
> ---

It is not a complete patch, at least it is missing a Signed of by; Then, 
could you please explain

the reason for sending again in a short period of time? Perhaps this 
email should be used as

patch v2. see .../Documentation/translations/zh_CN/process/5.Posting.rst


You can also execute this command:

  $:./scripts/checkpatch.pl

Then silence all warnings and errors.


Thanks,

Yanteng

>   Documentation/scheduler/sched-energy.rst                    | 2 +-
>   Documentation/translations/zh_CN/scheduler/sched-energy.rst | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
> index 70e2921..84b37a2 100644
> --- a/Documentation/scheduler/sched-energy.rst
> +++ b/Documentation/scheduler/sched-energy.rst
> @@ -141,7 +141,7 @@ in its previous activation.
>   find_energy_efficient_cpu() uses compute_energy() to estimate what will be the
>   energy consumed by the system if the waking task was migrated. compute_energy()
>   looks at the current utilization landscape of the CPUs and adjusts it to
> -'simulate' the task migration. The EM framework provides the em_pd_energy() API
> +'simulate' the task migration. The EM framework provides the em_cpu_energy() API
>   which computes the expected energy consumption of each performance domain for
>   the given utilization landscape.
>   
> diff --git a/Documentation/translations/zh_CN/scheduler/sched-energy.rst b/Documentation/translations/zh_CN/scheduler/sched-energy.rst
> index fdbf6cf..03dedc6 100644
> --- a/Documentation/translations/zh_CN/scheduler/sched-energy.rst
> +++ b/Documentation/translations/zh_CN/scheduler/sched-energy.rst
> @@ -119,7 +119,7 @@ EAS覆盖了CFS的任务唤醒平衡代码。在唤醒平衡时，它使用平
>   
>   如果唤醒的任务被迁移，find_energy_efficient_cpu()使用compute_energy()来估算
>   系统将消耗多少能量。compute_energy()检查各CPU当前的利用率情况，并尝试调整来
> -“模拟”任务迁移。EM框架提供了API em_pd_energy()计算每个性能域在给定的利用率条件
> +“模拟”任务迁移。EM框架提供了API em_cpu_energy()计算每个性能域在给定的利用率条件
>   下的预期能量消耗。
>   
>   下面详细介绍一个优化能量消耗的任务放置决策的例子。


