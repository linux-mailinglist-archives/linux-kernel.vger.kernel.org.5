Return-Path: <linux-kernel+bounces-127496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80E894C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB4D1F22714
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096638FBC;
	Tue,  2 Apr 2024 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PNXG7AFq"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574B3C471
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042228; cv=none; b=MTEwZcwGZe8l2mumgkZl+GMgwAwK0olIjpX4T0aLqspkkxjFOWw67cLqELrkAFXb6cp/YA3ePE4q7KVZ5hH2HzK7srknyDk1IZ8XpYzcI9OWmN5XG5tPvp9b4Hm7Cy1Hm6Q9hYrMIpFcKNSwA1XIA0uO2S3TefIk5zTbnLG++Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042228; c=relaxed/simple;
	bh=pLsV4oROMsd6VBylKnlLYA5MZGx6pisJRIyR418l0aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGO7Ge7eorEH2nU727YII4SECfIZtQHUKOUdrdsID9fmQeYVoRpmPS0V9ge53zeJ+i8PT2zFfgUWWRH773sHhLOG0Oxd2h3ThyWaWUV2DyHnRR5bw2cjS2FXtztwQ1uixU0AO+gkyxjeqISKTTJLnzO0j5dLf8rQOeL3nro7l+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PNXG7AFq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01A8520012;
	Tue,  2 Apr 2024 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712042218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLsV4oROMsd6VBylKnlLYA5MZGx6pisJRIyR418l0aQ=;
	b=PNXG7AFq3w5pa84SDY8AX4Yq3NadlOf3I9ZuZGEhPzvo+EPtU9fGkx8T1qznwjSuNpmPza
	L3DTTyTNpr8sc7lStLSe4lMlyTkDzkbequ6EflzgbHRSB1S0d15WZhGf+/sImpCxJthlMi
	Nyq0uPhe2XtBZOAIZtGjioejMDEQVCA03uAsA97eAiBXK1X8vKzu4iPGh3YuJfczbmdOuB
	A1tI09aYpO5HrDh0ZOPu40MOqNRN5zDzSenTkhmia+nb0fmK/A0CryTStV4O352Yu5/ZPZ
	GJ+6rRuifWDM5iVZBehLIoUifMgG4UMd/otn+SGvRPO3kx3SbFPfcYZlNwULMw==
Date: Tue, 2 Apr 2024 09:16:57 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Michael Walle
 <mwalle@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvmem: layouts: onie-tlv: drop driver owner
 initialization
Message-ID: <20240402091657.355d9563@xps-13>
In-Reply-To: <20240329-module-owner-nvmem-v1-2-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
	<20240329-module-owner-nvmem-v1-2-d700685f08e1@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Fri, 29 Mar 2024 17:13:36 +0100:

> Core in nvmem_layout_driver_register() already sets the .owner, so
> driver does not need to.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

