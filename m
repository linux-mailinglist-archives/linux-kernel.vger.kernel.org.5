Return-Path: <linux-kernel+bounces-91455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE28711B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829061F21B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF6017FE;
	Tue,  5 Mar 2024 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="W45G8TcZ"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F568F62;
	Tue,  5 Mar 2024 00:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598519; cv=none; b=f2QWx6sZlU2hWgmLrLJp1dA+WpqIa31Ex8XRWjZ9Kic2fV+KpL+3vo7/8GiHNOLD35ws8zgv3sICxIWXneLu3mOijGUBoVeviUZfGH/LoHL/B554VTEFQOTWKtUgXipwZJCbb0G2VVDDo11Xo1oefk1ykGjEMRmnKz5k860kjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598519; c=relaxed/simple;
	bh=Gku2FZxmw6pABCG6ITNNpu/JYRxaw3ln9KpEjA4RqKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTMv8KjIEFgQHj2jgUr0yeFqcOoH0e2U99IrQXbJZM+c2X2KOc7KEcJ98xaDDirzA7z45wbJk1Omt0LTqKu7OtxJ6CwirSI3RGiK5x9hhwifaOeQSyAwzSJ6z6ZgkG4xsKwZ50fK4QO4cYCnt14MGRpdhzJWyQ7sbm0UMNPCQTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=W45G8TcZ; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 786CDA10;
	Mon,  4 Mar 2024 16:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1709598516;
	bh=2TEBh842bpWvFeRLWwrtU0iI8xSYsMvKaXd0LecDU1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W45G8TcZszuC8qmMK8TMBEFeobo6f/cn6fAeyayR/F2xP5dUnQb8BNvAjNlWt9BXp
	 Y0k7qe+VsbsvmhTAbb/dScBgFgG7XNNkedui+G07APUategnJaJcprV/mH/FXdCvQa
	 0VnP3DOd4x0Qg1l01xtjJSUI6CDL1j/5EejqKRak=
Date: Mon, 4 Mar 2024 16:28:35 -0800
From: Zev Weiss <zev@bewilderbeest.net>
To: baneric926@gmail.com
Cc: jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
	openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Message-ID: <cffada5e-0f7a-415f-9c4b-7c46fac5cd3a@hatter.bewilderbeest.net>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>

On Sat, Mar 02, 2024 at 12:19:07AM PST, Zev Weiss wrote:
>On Mon, Feb 26, 2024 at 04:56:06PM PST, baneric926@gmail.com wrote:

<snip>

>
>>+
>>+	fanin_cnt = of_property_count_u8_elems(child, "tach-ch");
>>+	if (fanin_cnt < 1)
>
>fanin_cnt < 1 || fanin_cnt >= NCT7363_PWM_COUNT
>

Er, off by one -- just '>' rather than '>=' there I realize now.


Zev


