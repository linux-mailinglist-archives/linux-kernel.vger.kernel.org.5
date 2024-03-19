Return-Path: <linux-kernel+bounces-106864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4687F4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655E1B21665
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32107EA4;
	Tue, 19 Mar 2024 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="h3O++LR0"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8713386;
	Tue, 19 Mar 2024 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808550; cv=none; b=hN4xNOXD286O8Go9n1gcIl8E3iHwKTBse3f8iVIjbh+0ZIMC7/FktejoejUc38ci4Xk7quTITdV7AkhlPGIaat3yYxzScLNUd2qBcZBUvW1qmaxspkO1AWjK1lmXXVnCyTDrNfJe+UR25iU8N9gOgdcOOtYf/q43pygXmoTPOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808550; c=relaxed/simple;
	bh=JU1WrOgOLqarLmwt6jYWlaVvFMHVFfDyG9zmPuptmRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAnKorb8KiIbrPjdoCbzxABrJ3+fge+pO8/9uP6eWnzQCUxFRssRtxvPrxpigVSWv/gXDdM+SeYENjQuVV8Fp74/NffOODMWz5qS/plskA7yNDlw4zhez1zDtwhqVdlRCV6ob4dICVUjyz5ZThpN2tDPFIYzcHxGJb4wgJ0Lb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=h3O++LR0; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3335D21F0;
	Mon, 18 Mar 2024 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1710808542;
	bh=JU1WrOgOLqarLmwt6jYWlaVvFMHVFfDyG9zmPuptmRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3O++LR0nVfYayQXHwhjqSaFJOeRS5w4DLYMojOoaYwjCC9wW43IgXW35qSByR1Xv
	 68snXFKLkAWdSYYyf1ndvDTWMm+5eacAwiiv+z5Ntad1lgfS6y9rChthY5ycVvQVCv
	 Jnxdo1sfKB96FkIZxuYwL/3ayXPhU74ls917m86U=
Date: Mon, 18 Mar 2024 17:35:40 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Ban Feng <baneric926@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
	openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Message-ID: <6ee65d2c-708d-4e57-97a9-a1343367cf18@hatter.bewilderbeest.net>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <a90ed00c-f836-4fb6-8191-9974937e3eb7@hatter.bewilderbeest.net>
 <CALz278Zgfgob573vgWz4PgC7vb=i8xt3kC1hSjo_cQi00B0XAg@mail.gmail.com>
 <cd63bec7-01c6-466e-b772-3a3d3d90a7d5@hatter.bewilderbeest.net>
 <37e11daa-c24e-45b2-a22d-769693fd2038@roeck-us.net>
 <a93e2971-cafc-480b-b439-f42ed0838660@hatter.bewilderbeest.net>
 <CALz278b7BeGoYunqh1Rs91N81sEnU_RDox3urqTb9CFX0ic5_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALz278b7BeGoYunqh1Rs91N81sEnU_RDox3urqTb9CFX0ic5_g@mail.gmail.com>

On Sun, Mar 17, 2024 at 06:02:42PM PDT, Ban Feng wrote:
>HI Guenter and Zev,
>
>If there's no concern about supporting nct7362 in nct7363 driver,
>I'll add it to the of_device_id and i2c_device_id table in v5.
>
>Thanks,
>Ban
>

That sounds good to me, thanks.


Zev


