Return-Path: <linux-kernel+bounces-6483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB9819978
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986AA1C240F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7137B1BDFD;
	Wed, 20 Dec 2023 07:26:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EC18E3C;
	Wed, 20 Dec 2023 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.110.252])
	by gateway (Coremail) with SMTP id _____8CxuegXl4JlIN8CAA--.14484S3;
	Wed, 20 Dec 2023 15:26:15 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.110.252])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3uQUl4JlpbYBAA--.10622S3;
	Wed, 20 Dec 2023 15:26:12 +0800 (CST)
Message-ID: <340cbb78-3e68-4584-8e11-313f7f86fd34@loongson.cn>
Date: Wed, 20 Dec 2023 15:26:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()
Content-Language: en-US
To: "JiaLong.Yang" <jialong.yang@shingroup.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: 2738078698@qq.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202312201105408639401@shingroup.cn>
 <20231220062822.16168-1-jialong.yang@shingroup.cn>
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20231220062822.16168-1-jialong.yang@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx3uQUl4JlpbYBAA--.10622S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWrKr4fArW8JrWfuFyxGryrZrc_yoW8JF15pw
	4Ikr1xJan7Cr1UC348WrW2gF15Ka4xuwsrKrWDZw17XFn3Jr48Arsrtas09F93Zr92yayj
	vFsIgr98ua1jvrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8CksDUUUUU==


在 2023/12/20 14:28, JiaLong.Yang 写道:
> We know the macro DEBUG will make pr_debug() save the formatted
> string into final binary. So the translation is a little wrong.
>
> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>

Acked-by: Yanteng Si <siyanteng@loongson.cn>


BTW, you lost Zenghui's Reviewed-by tag. :)


Thanks,

Yanteng

> ---
>   Documentation/translations/zh_CN/core-api/printk-basics.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/core-api/printk-basics.rst b/Documentation/translations/zh_CN/core-api/printk-basics.rst
> index 59c6efb3fc41..cafa01bccff2 100644
> --- a/Documentation/translations/zh_CN/core-api/printk-basics.rst
> +++ b/Documentation/translations/zh_CN/core-api/printk-basics.rst
> @@ -100,7 +100,7 @@ printk()的用法通常是这样的::
>   
>   为了调试，还有两个有条件编译的宏：
>   pr_debug()和pr_devel()，除非定义了 ``DEBUG`` (或者在pr_debug()的情况下定义了
> -``CONFIG_DYNAMIC_DEBUG`` )，否则它们会被编译。
> +``CONFIG_DYNAMIC_DEBUG`` )，否则它们不会被编译。
>   
>   
>   函数接口


