Return-Path: <linux-kernel+bounces-117211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C764F88B463
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DB1B33C37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74654149C4B;
	Mon, 25 Mar 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPRZaFH1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C47F7E4;
	Mon, 25 Mar 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375837; cv=none; b=qaPe2o4hy5pTXphh2coj7dt2m93aD5Bf93+MfSzexZIxfwqyX54Lgo4PqpOVTGxBW0UzSgSE8XkAT+JmbUHyxn6j98FPqAGvoxpEa3HNhfTQOQMPHKftzkKQSOK6/PLdSe8fmMtP4RZHF4E0r3a9PbvLe/bgJdlb+yPSlV9/qjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375837; c=relaxed/simple;
	bh=qPHHhaIGnQXOuUuvqdCt8SN54mCCg4jtSZTAa2BA4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT09zpSWNvtepEyL7WilzYkaiZK/gHBCEDDxW+Ekp2l1aTYt7GPZcwgh2xV+ISwD5g/qj3AOMenaOkIqxdva5zoRv6dOLMrc9hySVHvgv6TtUZotXui9aJIENjwaxKg5SnOzb4DUPNeFha6xKF8fB3YRt7jpdsJtrQPrNsMSzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPRZaFH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B63C433F1;
	Mon, 25 Mar 2024 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375837;
	bh=qPHHhaIGnQXOuUuvqdCt8SN54mCCg4jtSZTAa2BA4Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPRZaFH1917y1f0jzOD45+tV2aWYy2unUzLI4tpIBPt7hZaJukvBBTws+CZ25QmyD
	 yF0+nqt80b0sDPTFldkWvRaicy2bqkhDtVlbO+tC90WQAgJtDOCTAqtSMjB9FgTnPW
	 mMoplbGIxSZblmBHLMQK9NJANL1urUnAlpqyK7OjfCpVredGRHUa15DPYa5EihcqOC
	 VALS0V7PXwo/qC3R0A9NRQM84c4jPCjUzKEu3V6VJ6Q0uAnJ1JaVJbW6NFghhd08Zg
	 gcWjn/xKF1OCOHxa6uL/+VT3Zlt8Jfjlh3nfQNEPAewMey7JVLdMTtkV77qt4/e+0i
	 LAJOE86LNtK2Q==
Date: Mon, 25 Mar 2024 14:10:32 +0000
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240325141032.GO13211@google.com>
References: <20240324201210.232301-1-andreas@kemnade.info>
 <20240324201210.232301-3-andreas@kemnade.info>
 <472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
 <20240325131605.6607b778@aktux>
 <81bf6604-9160-4bae-8da6-7034f8aa3f92@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81bf6604-9160-4bae-8da6-7034f8aa3f92@gmail.com>

On Mon, 25 Mar 2024, Matti Vaittinen wrote:

> Hi Andreas,
> 
> On 3/25/24 14:16, Andreas Kemnade wrote:
> > On Mon, 25 Mar 2024 13:31:15 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > 
> > > On 3/24/24 22:12, Andreas Kemnade wrote:
> > > > Since the chip can power off the system, add the corresponding
> > > > functionality.
> > > > Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> > > > No information source about the magic numbers found.
> > > 
> > > Oh, interesting repository :) Thanks for linking to it! I didn't know
> > > someone had reworked this driver...
> > > 
> > which btw: contains this interesting snippet (output from fdtdump)
> >    bd71828-i2c@4b {
> >                      reg = <0x0000004b>;
> >                      compatible = "rohm,bd71828";
> >                      gpio_int = <0x00000008 0x00000013 0x00000001>;
> >                      gpio_wdogb = <0x00000039 0x00000018 0x00000001>;
> >                      #address-cells = <0x00000001>;
> >                      #size-cells = <0x00000000>;
> >                      pmic@4b {
> >                          compatible = "rohm,bd71828";
> >               	        regulators {
> >                          	BUCK1 {
> >                              		regulator-name = "buck1";
> > 
> > 
> > and to make it work since basically no regulators are registered
> > instead just some regmap_write()s are done to configure something
> > in probe(). It is a pitfall to think that the information below pmic@4b
> > is used, especially since it is not that obvious in the source.

Odd!  Not only did I not receive the original patch, I also did not
receive your response Andreas.  Spam is empty too.

LORE too: https://lore.kernel.org/all/?q=%22mfd:%20rohm-bd71828:%20Add%20power%20off%20functionality%22

-- 
Lee Jones [李琼斯]

