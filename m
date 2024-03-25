Return-Path: <linux-kernel+bounces-116433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D3889D40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8DF1F36914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689A1779BB;
	Mon, 25 Mar 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mPosgRRt"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD65390038
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335862; cv=none; b=i+qYs5DUQGdtepwQoaXTrcFsnR83MgC5c0sAmErALCKq22RBWIvmMLkH1BcbYcnBK83kCBb6LKVPN+qXXID4OweY4MX+qbSPshVdqXtYUxZNt3DDYZ1ggTTVkgwXhCOE7uV2zSwrIYc7piHpNOFCmQW4/n/NdZkGRtVS85j7qbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335862; c=relaxed/simple;
	bh=6q3cSj7Dl84jVv87fRaGmOaKhY98faHtxDSaHySMMRs=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=oG3+ynqU/y8xMObETP0B0ccbWURNE0vigcAn7gyse6WbcdTcS/F6Vvk1bJjMjeAxOGq0GHHlfifzmwtti77ZSpD6OgI+jot8P6PkeXKYLqtlPxBPUS2fQhzFIJWwvxorhf5VR/xr7Uc4sZeI54TYqJMdkf5stCCsGQ32VRgKWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mPosgRRt; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711335849; bh=cUaB1Qlwp+5KOdt5XNJfaAEphVdI1Mx9/MaeC4ADKag=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=mPosgRRtgpA46grB/FM+uJxrP2AXHH3RwGnxMyoFDRs9n5VM48uP4Y30Qg0NV/rCU
	 lsgHpo/KVhn0SnYbSwwEmOsfwTN9i9vGAUCklhN8eV1kl7qLjdx3pPGvk5gG61e04R
	 4PaktS14efEwvzdjRTMvEuyrSIBG+9BcP4X1p5bM=
Received: from smtpclient.apple ([2409:8934:1ed6:2f4f:d8d3:a43a:ef25:fb4f])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id E73A14B8; Mon, 25 Mar 2024 10:57:51 +0800
X-QQ-mid: xmsmtpt1711335471td1lycwv1
Message-ID: <tencent_3A313D213A8D897C9D8224DA538EAFB8B608@qq.com>
X-QQ-XMAILINFO: MPaKaX623R7Y3L+KntZXBnA7NdwH6aw/GzZNsK/ATSLO+OirAumPXo7IHX44rn
	 GlUXhRU+dDH0hFDeFjSi3zExYsNQYPEXIt3h0AF/6BhT8G3LJe+/aDv/iQYrLFNcouwOA4GDti1k
	 UdzvNNI/tLPLMeSMm+uanZG1bbJ/6b0mnM2qU0PsDg9HMNTZFncfBVc08RD1KFFwfPgmyDV3Oyk6
	 DTm6R1G2abAsPoKxxC6zq1/nKoVL7jeouOgbTZhTzp8GXa18R4V0K0e2ysXfQC05s116LyxZaNJ3
	 whkyJb/t4U/FzCy+Z6wEYcIHslCq0+z9QrH2A3zzpkYAFo/BpGHMZDBz4C6+NJ5qqTyGB3ANrGI8
	 eUisisKnAFldkFUDkJ2v+MIlnd01tGWRnHhPTFkle102pL+TG9axkqPYsF8oQ6ILmkU4790MYqsw
	 9js3tZtkao92myJvumpfht8GhvBdeSLN12iK1rWdkS0wyQVNWXewjJY3DyDIJ/jNFByDFZ69UDfK
	 fDLEcqb/FWUAVjv+DaCpbjq//miDlHRHGe8AvyELIZH3WJN8SZartS0pgofFSm3O8kXJ4Zx1SSrC
	 urDurZLQaTGLfRHqIXDn6/6No9ZOnX7RElYKFqApALD4oIe9mxBtJGe72j7yvq2zXh2Mhaj4PQkH
	 lPQOjFENbVkZYQpDyMOindBn8L3n4e6HqeG7HkGQqZd9X9XkIUn1vUOY7KiyjaLAGBYNB5lL4xep
	 X76coa3VLbA/Vz8Dcpc3h+tbkrDBNH7FHXND1QuCNeVLmAlHo4p8WuVI+NnqTQ/9+gu3Rbs2NfCO
	 3vdaDQpD8AEl7zHBDcJaPcOsYnGSd4IUQw9noVCRojyeqT0faerlyyW+iH++YNx06HGDXhQaTqjj
	 wofz0R6fnvD7D9jFHDo8ZGyZpLX1hlPofnRE1jNMEfeS3DJ1taZ0V6aaANPUNQ8APY/9On6n+0K/
	 BlChnb3z5IOR3kC5wrr62ihCzdnljsagZB4bjkiRZDlcwfGsWZrQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v6 10/11] riscv: dts: add initial canmv-k230 and k230-evb
 dts
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240325020334.4033-1-dqfext@gmail.com>
Date: Mon, 25 Mar 2024 10:57:40 +0800
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>,
 devicetree@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linus.walleij@linaro.org,
 linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 mturquette@baylibre.com,
 p.zabel@pengutronix.de,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Rob Herring <robh+dt@kernel.org>,
 sboyd@kernel.org
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <ED3A5AAA-6A9F-4DA3-99E8-5F94C542F097@cyyself.name>
References: <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
 <20240325020334.4033-1-dqfext@gmail.com>
To: Qingfang Deng <dqfext@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Thanks. I will add them at next revision.

> On Mar 25, 2024, at 10:03, Qingfang Deng <dqfext@gmail.com> wrote:
> 
> Hi Yangyu,
> 
>> - Support for "zicbom" is tested by hand
> 
> C908 also supports zicbop and zicboz. You may add them as well.


