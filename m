Return-Path: <linux-kernel+bounces-13131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D582001F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45442846B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87F125A8;
	Fri, 29 Dec 2023 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx6AV1+J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B411CBC;
	Fri, 29 Dec 2023 15:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FEEC433C7;
	Fri, 29 Dec 2023 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703862505;
	bh=j7gsuymDQRQieUAcePV6o+Ec3rJKy6pr+4987njsHZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lx6AV1+J9Gkp/zp73wFXVjD3LwWp4avtJ4SIsqwo8FJh73dqUZ4ZmiSmVc/hUDUzt
	 RUv4a91dYVAiDO3x3/EsrOfyd9DlPow7c2v1AbmmWO0T/LSAZkJfiO0cCp9UoM5Jkx
	 va/dF1coRc7UIF+vl1QGK9I0OrtiZ8hcIUwuQxYzzpma5Oao7tABhc1tgh6hEy6F94
	 OpLWwJYB0l0TG4kohMcKATC4jts/vBTFqmDhRhYb+JLMtuM5A508JnoyjhLkfYegDp
	 V/VBVCtSIEIm2jEUo5rRLpxeu7V0DGeSo8atVRbHNN5VqOdnOPgsvEMmO8jlp4tMPS
	 zv1Oj9FIMRPqw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5336986cso57677005e9.1;
        Fri, 29 Dec 2023 07:08:25 -0800 (PST)
X-Gm-Message-State: AOJu0YydI5CPcwLFRCCGo/YofA+yHsdtoba03YocdCM7Y9NfU+9fljII
	SgzShUfznhsEqutW77C/jg8EfxDoHW7GbhwJnag=
X-Google-Smtp-Source: AGHT+IG0u18G+4W12HMBhlEcyYtZ+r3vNWHXalMetm4Iq2gz7UCYqiGPF1YQZfh2lHmtJeA8SLGv5Mm1YfwIyrpN+5Q=
X-Received: by 2002:a05:600c:1e01:b0:40d:7d4f:840e with SMTP id
 ay1-20020a05600c1e0100b0040d7d4f840emr428794wmb.83.1703862504064; Fri, 29 Dec
 2023 07:08:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701933946.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1701933946.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 29 Dec 2023 23:08:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4yS5nW9Xg1D+FRRa4jv8vGB9auim74NzTjmkw-CC6yZA@mail.gmail.com>
Message-ID: <CAAhV-H4yS5nW9Xg1D+FRRa4jv8vGB9auim74NzTjmkw-CC6yZA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] dt-bindings: interrupt-controller: Fix some
 loongson,liointc warnings
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, lvjianmin@loongson.cn, 
	WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Rob,

Since this series doesn't touch the driver any more, I suppose that
this series will go through your dt tree?

Huacai

On Thu, Dec 7, 2023 at 3:29=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Hi all:
>
> Some liointc-related DTBS_CHECK warnings were found when trying to
> introduce the Loongson-2K DTS{I} for LoongArch.
> This patch series attempts to fix those warnings.
>
> Of course, these fixes also apply to MIPS Loongson-2K1000.
>
> Thanks.
>
> -----
> V6:
> - Drop the 'parent_int_map' related patches following Rob's comment.
>
> Link to V5:
> https://lore.kernel.org/all/cover.1700449792.git.zhoubinbin@loongson.cn/
>
> V5:
> - Add Reviewed-by tag;
> patch(1/5):
>   - Just drop 'loongson,parent_int_map' instead of marking it as
>     deprecated.
>
> Link to V4:
> https://lore.kernel.org/all/cover.1699521866.git.zhoubinbin@loongson.cn/
>
> V4:
> - Add Acked-by tag;
> patch(2/5):
>   - Just add 'maxitem 2' instead of duplicating the list;
> patch(3/5):
>   - Rewite commit message for 'interrupt-names'.
>
> Link to V3:
> https://lore.kernel.org/all/cover.1698717154.git.zhoubinbin@loongson.cn/
>
> V3:
> patch(1/5):
>   - new patch, 'loongson,parent_int_map' renamed to 'loongson,parent-int-=
map';
> patch(2/5)(3/5):
>   - Separate the change points into separate patches;
> patch(4/5):
>  - new patch, make sure both parent map forms can be parsed;
> patch(5/5):
>  - new patch, fix 'loongson,parent_int_map' references in mips loongson
>    dts{i}.
>
> Link to V2:
> https://lore.kernel.org/all/20230821061315.3416836-1-zhoubinbin@loongson.=
cn/
>
> V2:
> 1. Update commit message;
> 2. "interruprt-names" should be "required", the driver gets the parent
> interrupts through it;
> 3. Add more descriptions to explain the rationale for multiple nodes;
> 4. Rewrite if-else statements.
>
> Link to V1:
> https://lore.kernel.org/all/20230815084713.1627520-1-zhoubinbin@loongson.=
cn/
>
> Binbin Zhou (2):
>   dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check
>     warning for reg-names
>   dt-bindings: interrupt-controller: loongson,liointc: Fix dtbs_check
>     warning for interrupt-names
>
>  .../interrupt-controller/loongson,liointc.yaml | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> --
> 2.39.3
>

