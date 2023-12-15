Return-Path: <linux-kernel+bounces-1051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60878149CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940B0285C21
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EBC2EAEA;
	Fri, 15 Dec 2023 13:57:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739330642;
	Fri, 15 Dec 2023 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57C80E000F;
	Fri, 15 Dec 2023 13:57:03 +0000 (UTC)
Message-ID: <edf7b71a-2f1d-4da9-b257-9700473ebe59@ghiti.fr>
Date: Fri, 15 Dec 2023 14:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] tools: selftests: riscv: Add missing include for
 vector test
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Shuah Khan <shuah@kernel.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andrew Jones <ajones@ventanamicro.com>, Evan Green <evan@rivosinc.com>,
 Xiao Wang <xiao.w.wang@intel.com>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andy Chiu <andy.chiu@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
 <20231123185821.2272504-4-christoph.muellner@vrull.eu>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231123185821.2272504-4-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 23/11/2023 19:58, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
>
> GCC raises the following warning:
>    warning: 'status' may be used uninitialized
> The warning comes from the fact, that the signature of waitpid() is
> unknown and therefore the initialization of GCC cannot be guessed.
> Let's add the relevant header to address this warning.
>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
> index 2c0d2b1126c1..1f9969bed235 100644
> --- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
> +++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
> @@ -1,4 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/wait.h>
> +
>   #define THIS_PROGRAM "./vstate_exec_nolibc"
>   
>   int main(int argc, char **argv)

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


