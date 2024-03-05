Return-Path: <linux-kernel+bounces-92724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4912B8724F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC441C22BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563EFD520;
	Tue,  5 Mar 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MIYQIVo/"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C3D267
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657776; cv=none; b=DJAMY1BcKUo1cPrEmNL5tVNzPYanprfglE1f07C8w85BdM2V9gZDYytk2ywrhRC74A5iKXcRQobbERK7TPO06E5JJmC+gPFnn2/Bx8N2eExzjeNZwuJPWtp5KjDbmDkRjNxHOgdNQryHiMMdGPVlCrsG36+xpRekm0O/sflnZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657776; c=relaxed/simple;
	bh=yByqG0yOrml+y/TQeDgQ4aQadtVY6yvukbinSORigW0=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=KqU2LVsW8HUopF8FD4BAY8kjKZgMEQpon4JpqPWPAqT+Z7QclVD7VrSpWddzGyYmNyHESNQ58jLDc1xlaRHx0BCIUdjXn8b5zYoHkFImUg8qwsumhU2dH8msitCjErUfQEpOf4t7CwPayWYkeEZPjlSHVbJ4LUKgCX1bUVQbhHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MIYQIVo/; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709657766; bh=qBC2AcX0mTtuXWYOBTP2x46Bkvdu0LNhIGH61FR39Gk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=MIYQIVo/5RJr57Cdrc2jPb/DOeHLzBDfGGc/T9zOmQ6T+rkvtMTQcorNqy58WGZqp
	 2sxWYgRCXoAmGmN9AgU03lgUioqKW3l+oucEcGGttQi4DFS17T89J87bsmrc/QAaqA
	 I0iEZZdCq55RwWUonSTp+TpzTzvj1Cb3Q/168nnQ=
Received: from smtpclient.apple ([2001:da8:c800:d084:84f7:c158:bab8:8899])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id E0297E41; Wed, 06 Mar 2024 00:56:02 +0800
X-QQ-mid: xmsmtpt1709657762tosh5bdf9
Message-ID: <tencent_E7385EE2AEC4B486DC343AF1A108DE68370A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4Ag7e/E7T3snRGQVxKSEkcuqqMQynq/q/5fu+wxuD5INq9X5LMOD/
	 iOisb1ByHIywnJVC+Kd0b1r0O3TmDy5XAKC1hxXJpkev9Hz0/9xvjw/fa5MvsyTwUdosdMvgD8Pk
	 H8CaGnw3HKWsFBBNyPVBsWhGhLtsUwm/y3MNvJTDgRhSpCQ4iA8oZcOHKLydxbvZn0m2nDuZlLG7
	 +ybxh4PLRTt65ZmIEschfVgPGHS+AXlfRQTURLoHjyYFrNJBaG6UvCnTfhMtvuSnQ5oxlrpl/Fkh
	 kEZgOUhIkRtx5OskbW+gS0PaEoqu57r/ATPdmXvH9wvwJVpFCvg/hmEZxil1ZLE7yOioE482yQJR
	 0Fl03kFshp9mdC3+3HTxHF1CJzIJ30E1I8lMqSRqCRzoOXGv8OrKBmEEEKI8E7Acy6KGro6FCiRU
	 +o8h8NXAxoxD0syf5//co/SaR57WTem2tpL+XbFemL3vmnMS/bQN2Dvr568ttoUfJPHOrzdLFDfS
	 tDGA680R1dhH2tcgFHCLzOhdT8MJCQeXfChh8U1woQDhtRMWi7zCqSSrimxa8hcmVyQnwdOFp3Ac
	 ocn1XwUbxidrKz7KUQPIzKLD3l7Zh9XPjXwrNxoO+xDfjwsV7zU/o8p1Ue+GWlrLtF9eA0/HXpDJ
	 e43NQ2FI1nCqAhYrcKkrN+/4G5+ocQ/WzbIV6qawCSOMBA/T3DIwscg3wtLSCCTs826onoRK4Q/m
	 d15E53lYgJSbzkGif/+uUeN6C47MA3U52YTZjbr29q1iouLNv04nDl/HwZhx5LvQVUTARPDIECjC
	 +FepNu2qUmpPLT3/oJO0IT6P0fxvpvBBeCDRl8Cy3ViFoBcCbK8sqHmqmaBReJYv+lhk+d7zlgoC
	 armUzv3XqR2zLgEFK/2QoQuGwHpI3MwUdcYUELLNXN9dffza8+zcPp3x5uFt9p328goYhjzsjS+p
	 d46b8vVzAHdIH5yAMHlpfY32k/OGrJ/9CzkcuIRoGl3IK5l/gqx5I32+labTqX5uLPGXiCZFVAKN
	 Cc4za/kQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3 7/7] riscv: config: enable SOC_CANAAN in defconfig
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <2a206c9b-b570-4081-b4e4-d177343482f3@kernel.org>
Date: Wed, 6 Mar 2024 00:55:52 +0800
Cc: linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <0350242B-6F2F-4741-A936-5E578F86924B@cyyself.name>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_E2812086B695A334EE5E8C70C85CA3171F06@qq.com>
 <2a206c9b-b570-4081-b4e4-d177343482f3@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3774.400.31)



> On Mar 5, 2024, at 07:50, Damien Le Moal <dlemoal@kernel.org> wrote:
>=20
> On 3/5/24 06:06, Yangyu Chen wrote:
>> Since K230 has been supported, allow SOC_CANAAN to be selected to =
build dt
>> and drivers for it in defconfig.
>>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>> arch/riscv/configs/defconfig | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/arch/riscv/configs/defconfig =
b/arch/riscv/configs/defconfig
>> index 89a009a580fe..20b557ec28df 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=3Dy
>> CONFIG_ARCH_SUNXI=3Dy
>> CONFIG_ARCH_THEAD=3Dy
>> CONFIG_SOC_VIRT=3Dy
>> +CONFIG_SOC_CANAAN=3Dy
>=20
> Given that the k210 need !MMU, including it like this in the defconfig =
is
> odd... I do not even see how that could work. But that depends on =
patch 5,
> which does not seem OK to me.
>=20

I don=E2=80=99t know why =E2=80=9Cnot seem OK=E2=80=9D here.

I will show the console to tell you what changes in defconfig:

```console
$  linux git:(rv_builtin_dtb_v3) make ARCH=3Driscv =
CROSS_COMPILE=3Driscv64-linux-gnu- defconfig
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
$  linux git:(rv_builtin_dtb_v3) cp .config .config.bak
$  linux git:(rv_builtin_dtb_v3) git checkout k230_dt_initial_v3
Switched to branch 'k230_dt_initial_v3'
$  linux git:(k230_dt_initial_v3) make ARCH=3Driscv =
CROSS_COMPILE=3Driscv64-linux-gnu- defconfig
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
$  linux git:(k230_dt_initial_v3) diff .config .config.bak
301,302d300
< CONFIG_ARCH_CANAAN=3Dy
< CONFIG_SOC_CANAAN=3Dy
2678d2675
< CONFIG_PINCTRL_K210=3Dy
4621d4617
< CONFIG_COMMON_CLK_K210=3Dy
4<
706,4707d4701
< CONFIG_SOC_K210_SYSCTL=3Dy
5334d5327
< CONFIG_ARCH_HAS_RESET_CONTROLLER=3Dy
5336d5328
< CONFIG_RESET_K210=3Dy
$  linux git:(k230_dt_initial_v3) grep -r =
"CONFIG_ARCH_HAS_RESET_CONTROLLER"
kernel/config_data:CONFIG_ARCH_HAS_RESET_CONTROLLER=3Dy
include/config/auto.conf:CONFIG_ARCH_HAS_RESET_CONTROLLER=3Dy
include/generated/autoconf.h:#define CONFIG_ARCH_HAS_RESET_CONTROLLER 1
include/generated/rustc_cfg:--cfg=3DCONFIG_ARCH_HAS_RESET_CONTROLLER
include/generated/rustc_cfg:--cfg=3DCONFIG_ARCH_HAS_RESET_CONTROLLER=3D"y"=

config:CONFIG_ARCH_HAS_RESET_CONTROLLER=3Dy
$  linux git:(k230_dt_initial_v3)
```

As you can see, we only have some drivers enabled for K210 and
CONFIG_ARCH_HAS_RESET_CONTROLLER being enabled. The next grep -r shows =
it
does not change the kernel behavior.

>> CONFIG_SMP=3Dy
>> CONFIG_HOTPLUG_CPU=3Dy
>> CONFIG_PM=3Dy
>=20
> --=20
> Damien Le Moal
> Western Digital Research



