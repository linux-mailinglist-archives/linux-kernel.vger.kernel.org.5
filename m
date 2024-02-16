Return-Path: <linux-kernel+bounces-68626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC13857D68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E3C28881F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB765129A6C;
	Fri, 16 Feb 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="G82As20d"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD91292D6;
	Fri, 16 Feb 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089212; cv=none; b=LpkBacXCcODohmJ6/uqxuUixnjqR3pMROqzX2TerQjcBJenjyPAodwTlnVZcbI8wJe5Xltb35xmhx2w307sclN639OIJXSTl9lsrE8rEfCTlnayjtwVJ0+Rmr/bHu47z3ueFKrmEqV/AxyUgchyQrMLiyx51pa+0Q2Zrs9UgehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089212; c=relaxed/simple;
	bh=RfrwlrMiLdeDpDWa6yYuEsg2k4+fP3eIrFX3FgB6HzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZwmjAMF2oux4sqnD1FaRJcIDJ6+m3rEHZM+wws69+MvPW9PqcE+A1ZdaDKF2G8qxmhviYg2bWbxOc9shy8hDFgFSuRteMh8IIxfDRtLne3oxXzWS/F85dI3BNg7zs6wjmSevme3ukhMo7s4xNSCNpWdV21bhKXdNP2W8LPPjb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=G82As20d; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708089191; x=1708693991; i=deller@gmx.de;
	bh=RfrwlrMiLdeDpDWa6yYuEsg2k4+fP3eIrFX3FgB6HzI=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=G82As20dOtzFpVH19131yEHZLVek2C77KIHuQ7gBYIy8b9Kk8PjDX5ZKY0KlAP4u
	 DVkgdAnOk1UDx6FPOQkRUvaz8Je/JEQ+vnd5aScKaFo9YzXlnYQYlZHapEHsiSo6g
	 C7HJeBYz+FPKSXMKT6IZxWg6qQs8qtckn4IsihKE3isjC54tcIMIf7hkWbd0Et/1L
	 81EXEDUJ2Ozfm1a6itNjjw6IlO+faEKREBHdWfDm21hgg3BofW/8PCq+GvUBQnqDn
	 E766sA4SSriniq8I2kWK87Q/SXF3gAGfuWX5hR5Pob/AcG5JR7MlO2C7Tsu77fmud
	 E9qH44HYl6XjFhffPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMuX-1rNPDq0fB3-00MKR0; Fri, 16
 Feb 2024 14:13:11 +0100
Message-ID: <3a0a120e-ac4d-4c1a-a22f-1b0800ecb973@gmx.de>
Date: Fri, 16 Feb 2024 14:29:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc/kprobes: always include asm-generic/kprobes.h
Content-Language: en-US
To: Max Kellermann <max.kellermann@ionos.com>, svens@stackframe.org,
 James.Bottomley@HansenPartnership.com, mcgrof@kernel.org,
 linux-parisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240211230945.297104-1-max.kellermann@ionos.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240211230945.297104-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ckrHekCxADyq41bO85BcniguE/Xexk5wIcXWinJ3cCW0B/QSja8
 oioxcl8bUDzMKt+ZE2Cg5WwPNg6lx+baiOibFNMuMEgk+JnQIvZoLNY6N0qRuGZPHeyzVnf
 LuhppQ8hicZGgzabySSNxLy3wr1Yzyi0P5qquPbj592ggWAC+6CWAA9ivRcfgq5AkQy6+4U
 Wn3ig2uNFsxQcBi76vsNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DFSVkUWosFM=;scRSUk8NUIPNlb5vY6DC8GUCPwN
 jrj4imVmEZfstZkZ/HXBOaCPutKLLdnJxKlHjJVh7HxIDl2anRKY9aULfhyd7SZUTDQO+B7DS
 kp9+fVDUFvAdIo6kZZMr4fEb7LKdpugUjT6SgmOPDmLb6/FpxYPXglX1Xnb3CuaOg6UjbH02u
 N5txv71OhFRWa6QVU4cew/W4AHPq43NHGRSvWNy51t1izTglVHkDS1BNFGvyKW2dqvB95EV0m
 ONbuZpHoIy11DbqE6aCwOcX4GuJjv+xNFpIX+OxFISs4k3ufEyOfkoBx35+9vlbam2qWdYjs/
 NkTHozA5XnOOAjCh/n4A9na8JDPGjATBlm5zf9/n16cg8iKINNAQtx23d64o9lf5b3QabFfKW
 pededWvaqGl5mc3m8d7IDOXl4Poj8dWyeYH7eq6Akn3peJhN7qnUBCfgeXE0f3gBrHlAcXM/g
 y5k46XdYlyVx9MVpgPjdkUIRMDMxdxJkp1TlTJKv9OcObI+bO3aPlQBbM5xJlwfCU6X+xKTsk
 BW8+BbJ7HQoeOdT/vvdMmqtP2Ug5SnOVl2o4YpSWa8OGcS7Q4SiOq0Wj6O3mu4nOvdUifV4GJ
 umq7bzvJDKRvuqGhmtVwBPHRMITiKnLQ+hj3hb7J7gOF/jnvMWAFhfJPcHScCDHFXmWLLxZlB
 3ESxRzZ9iwiEE1iJdwmIHGk0YWl5SxLJ53A2+EMQh6TbRQaAVeRkr0sVs1E+uS+VDbDatf77u
 Tt7mKWbXyGWWtsm8z+cfS13Ixpjx7XdEP0HhkaPHHm0LN0/e1wDJ47EBz8GQUDaG4Nc3DQEKO
 c2bnHqBB0seR5y8hbCUZqs2hti+0yQiPqJ+6TyVQNfMPA=

On 2/12/24 00:09, Max Kellermann wrote:
> The NOKPROBE_SYMBOL macro (and others) were moved to
> asm-generic/kprobes.h in 2017 by commit 7d134b2ce639 ("kprobes: move
> kprobe declarations to asm-generic/kprobes.h"), and this new header
> was included by asm/kprobes.h unconditionally on all architectures.
>
> When kprobe support was added to parisc in 2017 by commit
> 8858ac8e9e9b1 ("parisc: Implement kprobes"), that header was only
> included when CONFIG_KPROBES was enabled.
>
> This can lead to build failures when NOKPROBE_SYMBOL is used, but
> CONFIG_KPROBES is disabled.  This mistake however was never actually
> noticed because linux/kprobes.h also includes asm-generic/kprobes.h
> (though I do not understand why that is, because it also includes
> asm/kprobes.h).
>
> To prevent eventual build failures, I suggest to always include
> asm-generic/kprobes.h on parisc, just like all the other architectures
> do.  This way, including asm/kprobes.h suffices, and nobody (outside
> of arch/) ever needs to explicitly include asm-generic/kprobes.h.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

applied to parisc git tree.

Thanks!
Helge


> ---
>   arch/parisc/include/asm/kprobes.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/asm/kprobes.h b/arch/parisc/include/asm=
/kprobes.h
> index 0a175ac87698..0f42f5c8e3b6 100644
> --- a/arch/parisc/include/asm/kprobes.h
> +++ b/arch/parisc/include/asm/kprobes.h
> @@ -10,9 +10,10 @@
>   #ifndef _PARISC_KPROBES_H
>   #define _PARISC_KPROBES_H
>
> +#include <asm-generic/kprobes.h>
> +
>   #ifdef CONFIG_KPROBES
>
> -#include <asm-generic/kprobes.h>
>   #include <linux/types.h>
>   #include <linux/ptrace.h>
>   #include <linux/notifier.h>


