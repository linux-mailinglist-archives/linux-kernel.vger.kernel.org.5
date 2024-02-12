Return-Path: <linux-kernel+bounces-62203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F448851CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B1284A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2B14595D;
	Mon, 12 Feb 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZnwopuP"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A0445018
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763169; cv=none; b=OJMYDTpoBAjJa1TdJRcfBUTPhEDx2pi/uEJ7HpZgw7wFIMwmjiP/MexBfG0Lg9yak+4YenWGISJfbrNGqZwcOjSnccsE4i8YLdwOie0S0OKYZwRcI/1jHyNazF4rlNOVHN0jci7MiCeLOrkAJISe+zeUQauLYHhtM1SdMe2EjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763169; c=relaxed/simple;
	bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y66afeTJzZ0zf03l0/oXlH6STCYi1DPkJ8Ag6TrNdshNuzAepI0yRXfh+QTgumIyGJ8hvVYlovqQSVahuklIHMwJcC3Z355wAqeceILE5Ak/+jlAzPkVqI+LgI+BHsBjUVwXIFJ3F6UYu+OW5dVXkGI8nVfmlCPUm0hnCqS1Cjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZnwopuP; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c0819d4890so16877e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707763166; x=1708367966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
        b=rZnwopuPxaz1NRwgOxXRb3HEErW5l+aank023/5PqrsvlWHjSX4ZRpLumO2bX0B7oj
         AW0BOWxrVJA345klwhGAXEHlyk1JgXLHzfUP16XPhmcDurDzoAxKOjO8eo7S+rc5hJss
         4HsN97plRqzuJXsSBFeFkMADoZuLBfx1Yu090fYV2nRwI1o5Zi6JATngWobKLFK0bBpr
         fXeQT9rUoqn70y0PlgiG91/gK1GbEmtOQqcE1tQaBkHI+iS6q6aycbF+STS/Pzh52Aku
         OFQsvKJjscQxoddZI+HAb2W6u2Fd1KuvLKv+feRIl6C1NPMj8XUzQ9FdWy+H+Ubo9YGA
         6Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763166; x=1708367966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCgT/lIF6+pVrFxFVEXRsHMO2HmD8QWBakVqzWoiQ9M=;
        b=Dwi4M3Y2+uwbFOtdt5T2npW5Pzj9D91XyNfBzuMKWMJ5s9KV06sGc3uylyJXMC67Uy
         k7ahsn0Uje9N3KBc4yzvOIWYnjFChE8qvWttsSzb9IgudRwHqXZD6wQIuj/zLuIkT5UV
         EJxuTYdFe9NWI6WRor2DKvsAjVmUWhtK86/iNjIetoxg+rfCBRDPO5A8JodVvHmRGgJ6
         A8f4sgdj17Ldoj0AfOkQ9lN++jTIkJvvTpH/N9Isbk5Gcb1QGK/hKYU7Mfu/5/LzsOd8
         MxYlwcs1hSHdf264lGJuqhI3rBV5BmL3YQIFhQXis9XXrqfEPB5IbJg/6HZR7SnV8YvI
         GR7w==
X-Forwarded-Encrypted: i=1; AJvYcCXo1A8EiV1Xx7OgMvj9xTJ1TsFmZBx96f4odp73wZeNFr7VccZscJs+SOU+pmQHMq+za9BSiCTL7kl+q9asDvw/DS5j4OunEtQjeXao
X-Gm-Message-State: AOJu0YycSPouwowuBaxheN3Q1qSJRYWlswqFyg2rAlGAYiPIkbLq6iqI
	SFuwphUgDfveV5lGWU3HoaBHzCWzsevhmyvJUkz6D0LdoOovg66bELSsy/tc26DrDn3vWdRztUz
	RqkzRl2vkP8hzfWYn0FKt1Za/frtqnK4sjp7lJQ==
X-Google-Smtp-Source: AGHT+IH0eDVCHbyPL9X/VNVKVFp1oXkZRJlvE5Y3OB8AuOpgh8MtouPlypW8yAb8NtGduUZwTTMV+D64YPCooPEabaU=
X-Received: by 2002:a1f:4c46:0:b0:4c0:3b31:34d3 with SMTP id
 z67-20020a1f4c46000000b004c03b3134d3mr3533056vka.12.1707763166289; Mon, 12
 Feb 2024 10:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209132512.254520-1-max@internet.ru> <68d61c24-b6d3-450a-8976-e87beb9b54e3@kernel.org>
In-Reply-To: <68d61c24-b6d3-450a-8976-e87beb9b54e3@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Feb 2024 00:09:15 +0530
Message-ID: <CA+G9fYsBakUkg11TFrKZtsqZH3K=6_C2YvEmx6NoHVTkUNNf1A@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: ip_local_port_range: define IPPROTO_MPTCP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Maxim Galaganov <max@internet.ru>, Linux Kernel Functional Testing <lkft@linaro.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mat Martineau <martineau@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 19:27, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Maxim, Naresh,
>
> On 09/02/2024 14:25, Maxim Galaganov wrote:
> > Older glibc's netinet/in.h may leave IPPROTO_MPTCP undefined when
> > building ip_local_port_range.c, that leads to "error: use of undeclared
> > identifier 'IPPROTO_MPTCP'".
> >
> > Define IPPROTO_MPTCP in such cases, just like in other MPTCP selftests.
> >
> > Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Closes: https://lore.kernel.org/netdev/CA+G9fYvGO5q4o_Td_kyQgYieXWKw6ktMa-Q0sBu6S-0y3w2aEQ@mail.gmail.com/
> > Signed-off-by: Maxim Galaganov <max@internet.ru>
>
> Thank you both for the fix and the bug report!
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

