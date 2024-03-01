Return-Path: <linux-kernel+bounces-88132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11386DDBC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583611C22103
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D246A328;
	Fri,  1 Mar 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="IfmzeAjg"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00496A01C;
	Fri,  1 Mar 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283626; cv=none; b=GRMuYsEnHosUhqPB5Mr1gs5pvgSFPXFhZLrvjIQZTHfL4vOfKlmxdVXcE0lOgPIsTZDYe25fTC17oWqAY0QgAh2xKqx/itBsxQFjJTahf0lnMdnremorVPZgMCn8OI0YoLJChD1jWHi057SlNz/refzEQQOlrRHpIOCo8JbFm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283626; c=relaxed/simple;
	bh=SRR5laSaf3dxRN/Qmp9ZYXH6mHJfmvhGvnG0vUjM6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtBknhtEjrnFZGD2yAp05AbCth8xRA5n/pj81Mei2O+fyHtZQr87PzyAJOwftPUDdwzX/6dIMjWfpd/AMo8qFarpYGtRzZ2wlCsXp0eIQU7bUqAITFvhQt6qM8B/qk6WxfKQI9/pGh1FpwBjZKahEmQ1saQn1DH8bndOaOL4VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=IfmzeAjg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B174C2208F;
	Fri,  1 Mar 2024 10:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709283613;
	bh=icnTFb6jMxQwiDQb08/KnNZdQPGMbV7AyxxSbGvlk+M=; h=From:To:Subject;
	b=IfmzeAjgmMw5XKQ2zRa9/jXW8XwinnKdY9CqjERn2OTzr/+2VZRO9qIsf2qjbNVby
	 JK34VWsIVo64KHNBu6UX6qySOznRLLBO2zQ+r3lC8/UgOiMti5VKfc3cDrPXj7Wp0A
	 7t7OaE49VkKb7OGrQfCvfXHBFSp28HpZewQ+685u+HA8cFqcuuQ1Djp/iT1Qt+2aUn
	 2varzrojjMh/KEuDa4YXFyGDv9PObUEaXbsjqIiXDRuFCitB8CAy5zJGynASVel14i
	 oao8XEw953C3QFdU+rl7tNI1hDgalSK/QxC6SpRTdH4oTD4ctf3kZgejrU9Fw2eGeq
	 4MXoySOXra+xA==
Date: Fri, 1 Mar 2024 10:00:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: ti: k3-am62-verdin: replace
 sleep-moci hog with regulator
Message-ID: <20240301090007.GA6605@francesco-nb>
References: <20240301084901.16656-1-eichest@gmail.com>
 <20240301084901.16656-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301084901.16656-2-eichest@gmail.com>

On Fri, Mar 01, 2024 at 09:49:00AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The Verdin family has a signal called sleep-moci which can be used to
> turn off peripherals on the carrier board when the SoM goes into
> suspend. So far we have hogged this signal, which means the peripherals
> are always on and it is not possible to add peripherals that depend on
> the sleep-moci to be on. With this change, we replace the hog with a
> regulator so that peripherals can add their own regulators that use the
> same gpio. Carrier boards that allow peripherals to be powered off in
> suspend can disable this regulator and implement their own regulator to
> control the sleep-moci.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


