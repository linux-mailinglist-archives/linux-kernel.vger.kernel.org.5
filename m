Return-Path: <linux-kernel+bounces-117685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27988B597
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF1BBE58C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF329A0;
	Mon, 25 Mar 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ITb02MdP"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AE8527A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390473; cv=none; b=jl9X2kBjTxkJN2D/xy4JYMuJAXJ4cRU9YIW8e/hrw8zkw5dyziHTre5l/Gd7WRZnVBixwjmpAiRKofLs6UzzWodywoWYk1mtACTkruGQqpl+IASzWL55dlZ+8AMyYwG9c81XBWKE9tq92dXYx4us/iarlisv5Xu0Ke5AjQ/3bEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390473; c=relaxed/simple;
	bh=uoKndnM7WR57Y2jQSczCyTa7WbsIHgrSH56Dgnchj5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuWh71A17rRvnHv2AsvOcjVj/LCZ/z2/W6jvZwmp6KzGLX5zaL5I4vBNaYZ4ZvOmsFuASZSibWPRwsAm9VB+bYxH8u7zoE/3lNdT4PubFoOpwdaJgCsNYxZoy5XffcnMgI1iqEjp5JK++MEMNgT5BFUVWd+1dRPl9NAhB7qh/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ITb02MdP; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e12b6448faso269148241.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711390470; x=1711995270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7mzMb89CzzOzwuDZNRkxn1omr9+Z8w6rZzQ3Cuwg1ck=;
        b=ITb02MdPPreiQiu54hF03ocHBU/92I5/SYRH14Y8rINKORrLSyss6z4k4JpeR8YXLp
         cXp7C2K8sYjSGxchltEhQpRR60qsogqoL+ewPasreu0DMSFEOrNGEDnPlYXqByzxheFp
         0MSgWVtECWI+hHw3XZ2FXOzYhVXSZba18L8majD3IqeeTXOMuev95a9k2okZlRqpzs0L
         //tcwAO+Me1pLnFX3+AtZppLzoofaEQ3i/ylY+j8wxFHG6zKr0B33DnvJ2KVPJD8LbKm
         6u7DOzumT/K6WUex4eYgyBNEsmBC7KWRCDeJemtkd4odWB4hhKc64eR9TW+yfW+XdHG3
         4P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390470; x=1711995270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mzMb89CzzOzwuDZNRkxn1omr9+Z8w6rZzQ3Cuwg1ck=;
        b=xRI4BtEPya3FjW/mjEdbQiWkgDTR4HH9dBc3pIIEsruYR1zu86qQta4gUKRYSSH4dF
         gLBSzJDYon+lsznChS+rzxavxYn2zXpCgKv1fbwGly326LyJXAMEGo7KCD7MrCr8/FdX
         4zPbXL/TnEkTslaIfU9Tc1TY/UZwfsxKuZlmEHdvLmJ++yqL5oveDWbFEGu/EEIvp+BQ
         iLpL0valT6eKlBlSNM2SttxgcKPV6sVJBtxO69U8KmrxFOh4yrhVKt4bi2u0urUNwMS9
         u1hSu2qFCynei9XHJZqr6ZriVxLgkMChSG4yJuufvs6V53kwjscgx6iMb1W5rzEaAigb
         pmnw==
X-Gm-Message-State: AOJu0YyqAEjJUeKIgq1XN4cLbKx59OXr78WF5A2N2CMhhzdK2QkUC4bv
	R7PaMpgSY0tuq5Vimm9Opg+K6AAtdmbGKO3oIYqDs77jYeQg6313jN+Wd1UbCwuZlaWmmszI6Yr
	UbFVLvdQTfWkCmEMV5QVj/RWHT3Dft1PxmvCodw==
X-Google-Smtp-Source: AGHT+IF3AN9BTXq9VUzstwJllYsZ5/APcdgXw84SgQ3iZrX0RZ+0NWOxR5Eb0stGXtrNeh5Ys8hSF6Y4ah54JHuGjPM=
X-Received: by 2002:a05:6122:45a7:b0:4d4:34b2:9a89 with SMTP id
 de39-20020a05612245a700b004d434b29a89mr5359618vkb.8.1711390470191; Mon, 25
 Mar 2024 11:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325120018.1768449-1-sashal@kernel.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 23:44:17 +0530
Message-ID: <CA+G9fYuJZ+uYmm=qytHv-9AggymX6AXuf-10suxXrH1QoJx44A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, Petr Mladek <pmladek@suse.com>, 
	ohn Ogness <john.ogness@linutronix.de>, Francesco Dolcini <francesco@dolcini.it>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 17:30, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

From the previous 6.7.11-rc1 and 6.8.2-rc1 report,
the armv7 and i386 boot failed on v6.8 and v6.7 [1]

Following two patches needed for the boot to pass.
90ad525c2d9a ("printk: Use prb_first_seq() as base for 32bit seq macros")
418ec1961c07 ("printk: Adjust mapping for 32bit seq macros")

Please apply the above two patches on v6.8 and v6.7.

[1]
https://lore.kernel.org/stable/CA+G9fYtBKCPVmRETNpo3OdQbky-XiY6RDQ+Pc2b4Yj1yLe_e0g@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

