Return-Path: <linux-kernel+bounces-18521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D72825EB2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0AF284F98
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495FC5253;
	Sat,  6 Jan 2024 07:23:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C2846B4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.239])
	by gateway (Coremail) with SMTP id _____8AxDOvl_5hlT5YCAA--.9126S3;
	Sat, 06 Jan 2024 15:23:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxid3i_5hlhVcEAA--.11456S3;
	Sat, 06 Jan 2024 15:23:16 +0800 (CST)
Subject: Re: [PATCH 1/1] LoongArch: defconfig: Enable Generic PCIE by default
From: gaosong <gaosong@loongson.cn>
To: chenhuacai@kernel.org, kernel@xen0n.name
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 raven@themaw.net, davem@davemloft.net, svenjoac@gmx.de,
 anthony.l.nguyen@intel.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, philmd@linaro.org, maobibo@loongson.cn
References: <20231222024628.3138406-1-gaosong@loongson.cn>
Message-ID: <16576063-1df9-5aa4-1aaa-1a99c4a660cb@loongson.cn>
Date: Sat, 6 Jan 2024 15:23:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222024628.3138406-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:AQAAf8Cxid3i_5hlhVcEAA--.11456S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4kKr45GFyfuFyftr47GFX_yoWfJFc_JF
	W2kw4UCr48AFWkW39Fqw4rGa1DC3WxC3Z8JFnrZr1xXa1aqr43tw4DX3W7C3Z093yDWrZx
	ZaykAF9xCr18tosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Ping!

ÔÚ 2023/12/22 ÉÏÎç10:46, Song Gao Ð´µÀ:
> Enable generic PCIe by default in the LoongArch defconfig.
> QEMU requires this configuration when booting the kernel with FDT.
>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   arch/loongarch/configs/loongson3_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
> index 33795e4a5bd6..6350be7e8ec8 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -348,6 +348,7 @@ CONFIG_NET_9P=y
>   CONFIG_NET_9P_VIRTIO=y
>   CONFIG_CEPH_LIB=m
>   CONFIG_PCIEPORTBUS=y
> +CONFIG_PCI_HOST_GENERIC=y
>   CONFIG_HOTPLUG_PCI_PCIE=y
>   CONFIG_PCIEAER=y
>   # CONFIG_PCIEASPM is not set


