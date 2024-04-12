Return-Path: <linux-kernel+bounces-142040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7118A26A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1D51C23BCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063238DE4;
	Fri, 12 Apr 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsgW0fsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE644C7E;
	Fri, 12 Apr 2024 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903355; cv=none; b=JzUfY1ybtDbVMxn1Rh90Srj8S+SNbu3W+OfKoD88bL4HEX/5W1jmeq2srmUOsUuFcUzdBqqj+3KZ/ms3JNydNQ1wUp5VkIAbmtRjIJKB+3tQ2liovlZrpQSQL0EKAxR+jclF3axKbMc3FLlioGG7sivfA0axVgjNR3QW5Uq//CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903355; c=relaxed/simple;
	bh=d5QRertNS3HSMLaP6SRWFuj1TVwW5cpv1ssIL8H8T7M=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=k4bGHzCARjlD1O/7ecDHAi8H8+O7rjlk1fx7evjVomEn1Whu98O/0tuD007wBl+gR38L0gNI5mtaiFjVgqbpXwCDTw5zjXVOF/bXgdeP3jiSeF1QXwhii4F8enRp4Ihmj1qUmuObSS2puZ8YoejyRZh+dYQc3/+1Ga0SLoO375I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsgW0fsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9D6C2BD11;
	Fri, 12 Apr 2024 06:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712903354;
	bh=d5QRertNS3HSMLaP6SRWFuj1TVwW5cpv1ssIL8H8T7M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YsgW0fsnBpJFEsAIZalNhOzAWiHbxytTW8nkJWIr61oI9tGblYa7OCQNBM46miQ0a
	 C7mNlRfWzRmK0aooV6JjMNULzQCyLApmhRaJfKZSbe8l3XcjP6rMRQsaqRJezpTizb
	 5WYrtKl5e0SkODNMolAEUX+XimPSKaI0sNeTkGnkU9WGYr/X77et4+Zp2kAIu7Zv4C
	 ZPyFm8H+ew58CylLKby2isfIyQCNPRLXWl9HTpyCizYf4aLBhAfUfagvBMTmUGuRR5
	 4neIVSNhYA2WUvCdmLR2UsN5CPfdo5EA05dFz5gmITpDzYkxJmJnfOHtmXogITH4A1
	 kINczIbio2l4w==
Message-ID: <880867999e534110ee3d6ad39564a328.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240412061040epcms5p32581354cacdacda8a1bfd7b1a79e8020@epcms5p3>
References: <27c15251bd98f27ff4e21236adcc98d7.sboyd@kernel.org> <20240205111155.3939125-1-onkarnath.1@samsung.com> <CGME20240205111208epcas5p4775d540854dd8778388065a574b7862b@epcms5p3> <20240412061040epcms5p32581354cacdacda8a1bfd7b1a79e8020@epcms5p3>
Subject: Re: [PATCH 1/1] clk: imgtec: use %pe for better readability of errors while printing
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com <mturquette@baylibre.com>, paulburton@kernel.org <paulburton@kernel.org>, linux-mips@vger.kernel.org <linux-mips@vger.kernel.org>, linux-clk@vger.kernel.org <linux-clk@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, Rohit Thapliyal <r.thapliyal@samsung.com>, Maninder Singh <maninder1.s@samsung.com>
To: Onkarnath <onkarnath.1@samsung.com>
Date: Thu, 11 Apr 2024 23:29:12 -0700
User-Agent: alot/0.10

Quoting Onkarnath (2024-04-11 23:10:40)
>=20
> for the next set of patches we will be keeping one SOB.
>=20
>=20
> If required i can mail version 2 for the same.

Yes, resend the patch.

