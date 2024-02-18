Return-Path: <linux-kernel+bounces-70153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AB85940F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830511C20C43
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFF17F0;
	Sun, 18 Feb 2024 02:30:50 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BCE136A;
	Sun, 18 Feb 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223450; cv=none; b=TUolR3YT+nq2fUCQ7J8AnkqYg2+rB5HNaZ9nJM4cxhsxFnXcaRHnUvVmZI5p1QQM4lXE5dPhoWyjW3FQ1Ni1ASHHJznSk3IoX4W0xQxrMuhsinJYmC1+UCvsZrwVIeyDVY3cKhuf7CDBJxDk8IUvVz36iNeDJGaGY1HyM1Vcd6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223450; c=relaxed/simple;
	bh=iuYSgsm82GmOEjBo/CfBN7Oyn3THVKnRtiZmMIR38p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfB4gha62riC0M00PGFDtb+8ykHIUQ2mg7ZdOKhGPAWVak/W2QfZE1Uzp6//z87v7Ib95O4hE0vTYGk9JtwUSzvtKLnMWENeBnba7lCOzjGhgj7hlGu4G7uzFfX0PCTB4b1sBNtLauEeHbkdBbYgowN7j9f6M44dy7A7i0G9FUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.61])
	by gateway (Coremail) with SMTP id _____8CxmejTa9Fl3AwOAA--.18173S3;
	Sun, 18 Feb 2024 10:30:43 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.61])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhPPa9FlJFU6AA--.28623S3;
	Sun, 18 Feb 2024 10:30:41 +0800 (CST)
Message-ID: <0b9c8709-432e-41f4-83f7-9f78ef46ef8f@loongson.cn>
Date: Sun, 18 Feb 2024 10:30:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dt: Update overlay file extension
To: Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Davis <afd@ti.com>,
 Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5ac79104822cdce7a4caab87f14ce02477f85820.1707819511.git.geert+renesas@glider.be>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <5ac79104822cdce7a4caab87f14ce02477f85820.1707819511.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhPPa9FlJFU6AA--.28623S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar43XFWkGFWrKr1kGF47WrX_yoW7Xr47pF
	13JF17XF17Jr17Ww1UJF1UJr1UAr1UJ3WUGr17Jr1ktr4Yyr15Jr1Utwn5JFyUJFy8AryU
	JryUJFyUJr12k3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
	JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2024/2/13 18:24, Geert Uytterhoeven 写道:
> Building DTB overlays from .dts files is no longer supported.
> Update the documentation to reflect this.
>
> Fixes: 81d362732bac05f6 ("kbuild: Disallow DTB overlays to built from .dts named source files")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   Documentation/devicetree/overlay-notes.rst           | 12 ++++++------
>   .../translations/zh_CN/devicetree/overlay-notes.rst  | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
> index e139f22b363e9f36..35e79242af9a928d 100644
> --- a/Documentation/devicetree/overlay-notes.rst
> +++ b/Documentation/devicetree/overlay-notes.rst
> @@ -38,10 +38,10 @@ Lets take an example where we have a foo board with the following base tree::
>   	};
>       ---- foo.dts ---------------------------------------------------------------
>   
> -The overlay bar.dts,
> +The overlay bar.dtso,
>   ::
>   
> -    ---- bar.dts - overlay target location by label ----------------------------
> +    ---- bar.dtso - overlay target location by label ---------------------------
>   	/dts-v1/;
>   	/plugin/;
>   	&ocp {
> @@ -51,7 +51,7 @@ The overlay bar.dts,
>   			... /* various properties and child nodes */
>   		};
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   when loaded (and resolved as described in [1]) should result in foo+bar.dts::
>   
> @@ -88,9 +88,9 @@ in the base DT. In this case, the target path can be provided. The target
>   location by label syntax is preferred because the overlay can be applied to
>   any base DT containing the label, no matter where the label occurs in the DT.
>   
> -The above bar.dts example modified to use target path syntax is::
> +The above bar.dtso example modified to use target path syntax is::
>   
> -    ---- bar.dts - overlay target location by explicit path --------------------
> +    ---- bar.dtso - overlay target location by explicit path -------------------
>   	/dts-v1/;
>   	/plugin/;
>   	&{/ocp} {
> @@ -100,7 +100,7 @@ The above bar.dts example modified to use target path syntax is::
>   			... /* various properties and child nodes */
>   		}
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   
>   Overlay in-kernel API
> diff --git a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> index 43e3c0bc5a9f8235..ba5edd05dc1e7fd2 100644
> --- a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> +++ b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
> @@ -43,10 +43,10 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>   	};
>       ---- foo.dts ---------------------------------------------------------------
>   
> -覆盖bar.dts,
> +覆盖bar.dtso,
>   ::
>   
> -    ---- bar.dts - 按标签覆盖目标位置 ----------------------------
> +    ---- bar.dtso - 按标签覆盖目标位置 ---------------------------
>   	/dts-v1/;
>   	/插件/;
>   	&ocp {
> @@ -56,7 +56,7 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>   			... /* 各种属性和子节点 */
>   		};
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   当加载（并按照[1]中描述的方式解决）时，应该产生foo+bar.dts::
>   
> @@ -90,9 +90,9 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
>   DT中的适当位置。在这种情况下，可以提供目标路径。通过标签的目标位置的语法是比
>   较好的，因为不管标签在DT中出现在哪里，覆盖都可以被应用到任何包含标签的基础DT上。
>   
> -上面的bar.dts例子被修改为使用目标路径语法，即为::
> +上面的bar.dtso例子被修改为使用目标路径语法，即为::
>   
> -    ---- bar.dts - 通过明确的路径覆盖目标位置 --------------------
> +    ---- bar.dtso - 通过明确的路径覆盖目标位置 -------------------
>   	/dts-v1/;
>   	/插件/;
>   	&{/ocp} {
> @@ -102,7 +102,7 @@ DT中的适当位置。在这种情况下，可以提供目标路径。通过标
>   			... /* 各种外围设备和子节点 */
>   		}
>   	};
> -    ---- bar.dts ---------------------------------------------------------------
> +    ---- bar.dtso --------------------------------------------------------------
>   
>   
>   内核中关于覆盖的API


