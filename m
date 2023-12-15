Return-Path: <linux-kernel+bounces-1222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B0D814BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A391F24F24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952613716F;
	Fri, 15 Dec 2023 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G7HUNOQF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408B37152
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50c0478f970so808823e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702654745; x=1703259545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1wx0veFfXeSmAfDnA278dNhCsbl17nDzwAO+VoI2w0=;
        b=G7HUNOQFP/1VB+slrezf+z6IgftivVV4MoOHZSHMqgi7Fi7huFg4UCKgVjQ2yVekEq
         +jHLxKh3nevTD7YDOKS/7tmT4TEGlUyfqh484ajd1NCdk9fdDCHt0cGRv9FtusyxrTgS
         kwJ7lChUXJuyUTR+1WkK8JUXUmJvaCuD1Ot/nVHay415nQ/EJrXLNSkFyQ/jodY3rdO/
         Jjmndir2vIEzk0PxNJ6/g+K//GUv012a2Q4L19qKysWay7/gnBW6/f2bafksJrEkf3r+
         yW9tXnY3jwtjfCuAyEAuvFIsxPZfWLLxzDZixLSRdsHNg1K9tJ0TLSH7AniSlOed2cMz
         AXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702654745; x=1703259545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1wx0veFfXeSmAfDnA278dNhCsbl17nDzwAO+VoI2w0=;
        b=O2iycCwWOMe/7k3HdxyrpsNYbpJu+jchTk3/2US7e5mJvqQdfcFwhTWUmJWE+9qbQI
         2kIUNpXwY5yok2n+83fB0ZIXL8V+W8W+KV7Adao3RdKavSFIzK/QSAqxL8lPr3vBlbyY
         KHhmHYs6nErL9/66RwzFt2qNfnPR2qWidKISA2vRbz+Cq4y3pktE8eDpyjpf19hvy7ay
         LeCd67BN+pxncPfRXHfoSOnJTTo1glAFuBGHx1KTlcMpO2ENeZKtZrTeUYRyRWK5KY1j
         dAgFWaFovJ5m1QhU2nN0f9s5Hq7I4BSjUHoqbNeo5LH6FMaVGH5gNRW7VsZcLAtD7qI3
         BnFA==
X-Gm-Message-State: AOJu0YyZ/C/xi6TBmyvjmMB4Fq11HHyNrn78TQJT0jxk6F/ULONI0c2+
	3QiJDOrZncNKYh0y9EmGEou+JvCk+cwSR6Gt+egDOg==
X-Google-Smtp-Source: AGHT+IFVf84s+w2EVCOTCKjPMQKAzPLEu/sj8rErG6Hri/y5+/DExF/6z86r7visnMaLcYRBdFU51p24A+PCS/md29U=
X-Received: by 2002:a05:6512:3b13:b0:50e:1660:bc42 with SMTP id
 f19-20020a0565123b1300b0050e1660bc42mr2166658lfv.50.1702654745275; Fri, 15
 Dec 2023 07:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu> <20231123185821.2272504-4-christoph.muellner@vrull.eu>
In-Reply-To: <20231123185821.2272504-4-christoph.muellner@vrull.eu>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 15 Dec 2023 23:38:53 +0800
Message-ID: <CABgGipW9mJ038R7WYWrFVCOzU6AiRU=B3k81YAO4R8UrGZGhsw@mail.gmail.com>
Subject: Re: [PATCH 3/5] tools: selftests: riscv: Add missing include for
 vector test
To: Christoph Muellner <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Shuah Khan <shuah@kernel.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
	Andrew Jones <ajones@ventanamicro.com>, Evan Green <evan@rivosinc.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 2:58=E2=80=AFAM Christoph Muellner
<christoph.muellner@vrull.eu> wrote:
>
> From: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
>
> GCC raises the following warning:
>   warning: 'status' may be used uninitialized
> The warning comes from the fact, that the signature of waitpid() is
> unknown and therefore the initialization of GCC cannot be guessed.
> Let's add the relevant header to address this warning.
>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>


> ---
>  tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/=
tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
> index 2c0d2b1126c1..1f9969bed235 100644
> --- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
> +++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/wait.h>
> +
>  #define THIS_PROGRAM "./vstate_exec_nolibc"
>
>  int main(int argc, char **argv)
> --
> 2.41.0
>

