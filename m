Return-Path: <linux-kernel+bounces-95195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC58D874A83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609F31F23924
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87320839F1;
	Thu,  7 Mar 2024 09:16:10 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768E82D7C;
	Thu,  7 Mar 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802970; cv=none; b=gAMWCHEswFOBo+Ff2ylblzztgO0RVmgcOqQ1eaDJhR6wjdQL5v7rrnCnnxbe4yMHawjy53qG2K2LJ+rVikLoQDkJxOWfkblclodRyFZER3w4AxqtvAJ1JUOoFiwkNXT+9BCsriCviyVucMiHoOehdVsU596Xb3+M75i/lHb5ARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802970; c=relaxed/simple;
	bh=wshGL0p8L7sDzxWzl5t2QX+FtffpG/3D6qPk1C9WGG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqSyJr6LO/QV7A+t5GPIiJTZWi4bF23OcfkjOrClYeNfGOdZZJJECM+QUEQxLplx4Z/phKWd7QdoLoZynV/b0sHg/Rx0ugSvMb6pMi3ne+MQxn1UPO+n2KCR3O+bVadySqkGShPNgncOU4YdbQ8J+0lWizTC9yZapPe231pTToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: pFAQhK/U09cP+wiB7l6RG0lxZZjNkZK3B3ZMJcRpEklRHafZn2W7+iU80n+FX2QzAQFb6X7OVe
 8JJdotaedGmw==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 07 Mar 2024 14:46:03 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: broonie@kernel.org
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [PATCH v2 12/14] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
Date: Thu,  7 Mar 2024 14:45:53 +0530
Message-Id: <20240307091553.171178-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a71bda52-524d-4493-aede-786aae7ff468@sirena.org.uk>
References: <a71bda52-524d-4493-aede-786aae7ff468@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
On Thu, 29 Feb 2024 13:58:54 +0000, Mark Brown wrote:
> On Fri, Feb 23, 2024 at 03:06:59PM +0530, Bhargav Raviprakash wrote:
> 
> > +static struct tps6594_regulator_irq_type tps65224_ext_regulator_irq_types[] = {
> > +	{ TPS65224_IRQ_NAME_VCCA_UVOV, "VCCA", "voltage out of range",
> > +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> > +	{ TPS65224_IRQ_NAME_VMON1_UVOV, "VMON1", "voltage out of range",
> > +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> > +	{ TPS65224_IRQ_NAME_VMON2_UVOV, "VMON2", "voltage out of range",
> > +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> > +};
> 
> These should be REGULATOR_EVENT_REGULATION_OUT I think - they look like
> they could be warning on either under or over voltage.

Thanks for the feedback.
In the next version we will use REGULATOR_EVENT_REGULATION_OUT.

Regards,
Bhargav

