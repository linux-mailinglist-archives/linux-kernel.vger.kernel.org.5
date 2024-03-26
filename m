Return-Path: <linux-kernel+bounces-119846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6C88CDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EF31F689E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C013D28F;
	Tue, 26 Mar 2024 19:56:36 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FC13D28A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482996; cv=none; b=ssm8634WgIClYie2b4xjIjCTxjbyVAjopuZOBC340GYWuqHzpexXkEjTfbBcIaqWUQQNcTMAOXAyNN4l1EmYL/PYqGdPvzVSnIS7OahnQCYPfMwx/h6gXoeYjtznFTtong2Bex/qNPuNKn2ctF36TlbLWfgmQYV/B+S45yanq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482996; c=relaxed/simple;
	bh=S9wAqrcpMxpCNlgH6EbSUXOsKr4YKcDvbq4arTjtQE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9Yvqny8n/nTLIl/uJNqM1K+IaaRyYvO7GXg8MXlwCj88VBM5GQl3kHc9wGhPsMnqAgXsFhneWNHlAoM+bGCMdl2JFvWSci36/S+W1aqw91veUqAcyxFgEOM9eKYEuLiuK4wUyVEE8TmxmGCuCdrLoPBNv7CaV5oKj6LSOXu7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E89B340002;
	Tue, 26 Mar 2024 19:56:24 +0000 (UTC)
Message-ID: <485d2bc5-37f5-42a7-a3f8-bd53641c0d83@ghiti.fr>
Date: Tue, 26 Mar 2024 20:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Mark __se_sys_* functions __used
Content-Language: en-US
To: Sami Tolvanen <samitolvanen@google.com>,
 =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Kees Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240326153712.1839482-2-samitolvanen@google.com>
 <a083fe56-19ba-4c12-8364-944d8bbcc043@ghiti.fr>
 <CABCJKudxjhbLo_2zHBcsPh42vuLUGFj9wUxk+jf5USf2mvUZGg@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CABCJKudxjhbLo_2zHBcsPh42vuLUGFj9wUxk+jf5USf2mvUZGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 26/03/2024 19:55, Sami Tolvanen wrote:
> On Tue, Mar 26, 2024 at 6:43 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Do you have the link of the report? So we can add a Closes tag.
> Sure, this was reported here:
>
> https://lore.kernel.org/lkml/56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org/


For b4:

Closes: 
https://lore.kernel.org/lkml/56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org/

I was expecting the "direct" lkft link though, @Daniel do you have any?

Thanks,

Alex


>
> Sami
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

