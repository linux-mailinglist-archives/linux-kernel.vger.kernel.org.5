Return-Path: <linux-kernel+bounces-93603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA078873279
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4543B2CFB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C65D91A;
	Wed,  6 Mar 2024 09:15:12 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E05A783;
	Wed,  6 Mar 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716511; cv=none; b=HLiZbGX10RK/HWM1aLNnfq6FU6z0G6yOo6us1wrG67x0L88KkuCjtih/wMn7xVUEakLRHb7pD9RgGrKW+QuidwOy+fgILwEskoLDM/KuId99fDqgrreg1iAvEp/udQzA6sJykS3SDUHzrfn/pMZTE57hL05n9eODlAEPM0t2nD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716511; c=relaxed/simple;
	bh=2iyDGpmJRgV0/1XqTQsnxpjyhWqdE5k8LQtMLv69+tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlx55IZlsieG4mRi868WX8P5X6A3nYon6PmU1SRx+/zVOF2HMX0NBY/WXxUyxrWljR530gOR8wjFJn1oKQxxVfaBdIZtbTH7iCH9NlI073idye/wMdqfOSskfp/dPhN+bog+clUZSDtZpMPiPpWYRIA5gwv3pShMA01pZoU+j3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8Cx77sbNOhlkAwVAA--.32917S3;
	Wed, 06 Mar 2024 17:15:07 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVMwVNOhlOy1PAA--.17280S3;
	Wed, 06 Mar 2024 17:15:02 +0800 (CST)
Message-ID: <26730f76-871d-4a6d-8b16-ea3e52ef5357@loongson.cn>
Date: Wed, 6 Mar 2024 17:15:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: Add dev-tools/ubsan Chinese translation
Content-Language: en-US
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240302140058.1527765-1-dzm91@hust.edu.cn>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240302140058.1527765-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVMwVNOhlOy1PAA--.17280S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3AFWxGryfZF43AFW3AFWxKrX_yoW7Aryxpr
	9YkrWfGr48tryUJry3GFy5GF1UAF1xu3W7Crn7Gw1Yqr18KrW3tr47t34DKrZrWryUAFy7
	JFnrKF4j934Yk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUUU==


在 2024/3/2 22:00, Dongliang Mu 写道:
> Translate dev-tools/ubsan.rst into Chinese, add it into
> zh_CN/dev-tools/index.rst.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   .../translations/zh_CN/dev-tools/index.rst    |  2 +-
>   .../translations/zh_CN/dev-tools/ubsan.rst    | 91 +++++++++++++++++++
>   2 files changed, 92 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/dev-tools/ubsan.rst
>
> diff --git a/Documentation/translations/zh_CN/dev-tools/index.rst b/Documentation/translations/zh_CN/dev-tools/index.rst
> index c2db3e566b1b..c4463f0750f0 100644
> --- a/Documentation/translations/zh_CN/dev-tools/index.rst
> +++ b/Documentation/translations/zh_CN/dev-tools/index.rst
> @@ -22,13 +22,13 @@ Documentation/translations/zh_CN/dev-tools/testing-overview.rst
>      sparse
>      gcov
>      kasan
> +   ubsan
>      gdb-kernel-debugging
>
>   Todolist:
>
>    - coccinelle
>    - kcov
> - - ubsan
>    - kmemleak
>    - kcsan
>    - kfence
> diff --git a/Documentation/translations/zh_CN/dev-tools/ubsan.rst b/Documentation/translations/zh_CN/dev-tools/ubsan.rst
> new file mode 100644
> index 000000000000..2487696b3772
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/dev-tools/ubsan.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/dev-tools/ubsan.rst
> +:Translator: Dongliang Mu <dzm91@hust.edu.cn>
> +
> +未定义行为消毒剂 - UBSAN
> +====================================
> +
> +UBSAN是一种动态未定义行为检查工具。
> +
> +UBSAN使用编译时插桩捕捉未定义行为。编译器在可能导致未定义行为的操作前插入特定
> +检测代码。如果检查失败，即检测到未定义行为，__ubsan_handle_* 函数将被调用打印
> +错误信息。
> +
> +GCC自4.9.x [1_] （详见 ``-fsanitize=undefined`` 选项及其子选项）版本后引入这
> +一特性。GCC 5.x 版本实现了更多检查器 [2_]。
> +
> +报告样例
> +--------------
> +
> +::
> +
> +	 ================================================================================
> +	 UBSAN: Undefined behaviour in ../include/linux/bitops.h:110:33
> +	 shift exponent 32 is to large for 32-bit type 'unsigned int'
> +	 CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.0-rc1+ #26
> +	  0000000000000000 ffffffff82403cc8 ffffffff815e6cd6 0000000000000001
> +	  ffffffff82403cf8 ffffffff82403ce0 ffffffff8163a5ed 0000000000000020
> +	  ffffffff82403d78 ffffffff8163ac2b ffffffff815f0001 0000000000000002
> +	 Call Trace:
> +	  [<ffffffff815e6cd6>] dump_stack+0x45/0x5f
> +	  [<ffffffff8163a5ed>] ubsan_epilogue+0xd/0x40
> +	  [<ffffffff8163ac2b>] __ubsan_handle_shift_out_of_bounds+0xeb/0x130
> +	  [<ffffffff815f0001>] ? radix_tree_gang_lookup_slot+0x51/0x150
> +	  [<ffffffff8173c586>] _mix_pool_bytes+0x1e6/0x480
> +	  [<ffffffff83105653>] ? dmi_walk_early+0x48/0x5c
> +	  [<ffffffff8173c881>] add_device_randomness+0x61/0x130
> +	  [<ffffffff83105b35>] ? dmi_save_one_device+0xaa/0xaa
> +	  [<ffffffff83105653>] dmi_walk_early+0x48/0x5c
> +	  [<ffffffff831066ae>] dmi_scan_machine+0x278/0x4b4
> +	  [<ffffffff8111d58a>] ? vprintk_default+0x1a/0x20
> +	  [<ffffffff830ad120>] ? early_idt_handler_array+0x120/0x120
> +	  [<ffffffff830b2240>] setup_arch+0x405/0xc2c
> +	  [<ffffffff830ad120>] ? early_idt_handler_array+0x120/0x120
> +	  [<ffffffff830ae053>] start_kernel+0x83/0x49a
> +	  [<ffffffff830ad120>] ? early_idt_handler_array+0x120/0x120
> +	  [<ffffffff830ad386>] x86_64_start_reservations+0x2a/0x2c
> +	  [<ffffffff830ad4f3>] x86_64_start_kernel+0x16b/0x17a
> +	 ================================================================================
> +
> +用法
> +-----
> +
> +使用如下内核配置启用UBSAN::
> +
> +	CONFIG_UBSAN=y
> +
> +使用如下内核配置检查整个内核::
> +
> +        CONFIG_UBSAN_SANITIZE_ALL=y
> +
> +为了在特定文件或目录启动代码插桩，需要在相应的内核Makefile中添加一行类似内容:
> +
> +- 单文件（如main.o）::
> +
> +    UBSAN_SANITIZE_main.o := y
> +
> +- 一个目录中的所有文件::
> +
> +    UBSAN_SANITIZE := y
> +
> +即使设置了``CONFIG_UBSAN_SANITIZE_ALL=y``，为了避免文件被插桩，可使用::
> +
> +  UBSAN_SANITIZE_main.o := n
> +
> +与::
> +
> +  UBSAN_SANITIZE := n
> +
> +未对齐的内存访问检测可通过开启独立选项 - CONFIG_UBSAN_ALIGNMENT 检测。
> +该选项在支持未对齐访问的架构上(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y)
> +默认为关闭。该选项仍可通过内核配置启用，但它将产生大量的UBSAN报告。
> +
> +参考文献
> +----------
> +
> +.. _1: https://gcc.gnu.org/onlinedocs/gcc-4.9.0/gcc/Debugging-Options.html
> +.. _2: https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
> +.. _3: https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html
> --
> 2.39.2
>
>


