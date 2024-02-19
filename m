Return-Path: <linux-kernel+bounces-71345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3585A3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14296281325
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A083C2E856;
	Mon, 19 Feb 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dt8kmLMu"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DF2D05D;
	Mon, 19 Feb 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346960; cv=none; b=XkaN1SL5mvUmgcxapmOVkLG8EXjxDbYSHXXXeQuNIFdf3369vY9JzJ2fb4xJDu65Fpm9esEdmDuvVbV/AR8XHKn3kDnAus5Te53nFtD0QDxnrkK4W25Qov+JNYtGx3jc9VeZ3BxwRJqMohAwlMuKkfYaOR8JKFEvA8YfPyW5dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346960; c=relaxed/simple;
	bh=06p6ukdvxbrRf6/uOtqeOyeu+dw+dCTpr3YlazzJxlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXhb4mrnNbDFfnbSIOvInBXoxQDu2STrlNwnTJ0CtpdBbnqLALv/kDMReyFi4LXgFrszmG159T0LAaXPo/k340Tu31fofUa5EXMrmci0tiF3TBjeZbCti5OY8KC67f0ZkI+yya6Kq3g3z68dI93/1tyH/V1g1VqeqUVcva/3+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dt8kmLMu; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 336FB40006;
	Mon, 19 Feb 2024 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708346954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJALkusf1cXf4p7M933GGzZIRRakiGBqKNoFoSjNoJY=;
	b=Dt8kmLMuUKWq7J5kXL2nVlaTETvYXuskZRDGfU95wO2IHZ+Ppd4DsAGYhht5GaputNIkF2
	Dr7TOaMh2TErh9ue2Stx5Eh1QhGz5Jc2f8u1eZaBjLKDv+qO3CliZ8t14wCP9Z1pX+UgTg
	nA/jCP9JGV4tiKN3brQhVwVYPcdHOUSrIcUhBO4ec8jqK1FCw4bMIa1HMDEgNKtt45lLGv
	B8RwL5ETqIHOs7pj/TylF4YGPwNUJz/y31jizxHbS5uTsYJkEPm9AHA5L6o2pP2OhodsFQ
	4K3Aapf/caxS3vxsv3DA4bx8CT/8u6DQFJe8zzHOkm3DdbHmsbGHpgp+ekR0VA==
Date: Mon, 19 Feb 2024 13:49:13 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>,
	POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
	"mark.satterthwaite@touchnetix.com" <mark.satterthwaite@touchnetix.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v8 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20240219124913.GA99571@tpx1.home>
References: <20240219101221.129750-1-kamel.bouhara@bootlin.com>
 <20240219101221.129750-4-kamel.bouhara@bootlin.com>
 <e374d585-5acc-bbe0-ee1d-65f7abdb8f8d@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e374d585-5acc-bbe0-ee1d-65f7abdb8f8d@leica-geosystems.com>
X-GND-Sasl: kamel.bouhara@bootlin.com

Le Mon, Feb 19, 2024 at 10:58:22AM +0000, SHUKLA Mamta Ramendra a écrit :
>
>
> Hello Kamel,

Hello,

[...]

> > +
> > +/*
> > + * Support function to axiom_process_u41_report.
> > + * Generates input-subsystem events for every target.
> > + * After calling this function the caller shall issue
> > + * a Sync to the input sub-system.
> > + */
> > +static bool axiom_process_u41_report_target(struct axiom_data *ts,
> > +                                           struct axiom_target_report *target)
> > +{
> > +       struct input_dev *input_dev = ts->input_dev;
> > +       struct axiom_u41_target *target_prev_state;
> > +       enum axiom_target_state current_state;
> > +       int id;
> > +
> > +       /* Verify the target index */
> > +       if (target->index >= AXIOM_U41_MAX_TARGETS) {
> > +               dev_err(ts->dev, "Invalid target index! %u\n", target->index);
> > +               return false;
> > +       }
> > +
> > +       target_prev_state = &ts->targets[target->index];
> > +
> > +       current_state = AXIOM_TARGET_STATE_NOT_PRESENT;
> > +
> > +       if (target->present) {
> > +               if (target->z >= 0)
> > +                       current_state = AXIOM_TARGET_STATE_TOUCHING;
> > +               else if (target->z > AXIOM_PROX_LEVEL && target->z < 0)
> > +                       current_state = AXIOM_TARGET_STATE_HOVER;
> > +               else if (target->z == AXIOM_PROX_LEVEL)
> > +                       current_state = AXIOM_TARGET_STATE_PROX;
> > +       }
> > +
> > +       if (target_prev_state->state == current_state &&
> > +           target_prev_state->x == target->x &&
> > +           target_prev_state->y == target->y &&
> > +           target_prev_state->z == target->z)
> > +               return false;
> > +
> > +       id = target->index;
> > +
> > +       dev_dbg(ts->dev, "U41 Target T%u, slot:%u present:%u, x:%u, y:%u, z:%d\n",
> > +               target->index, slot, target->present,
> > +               target->x, target->y, target->z);
>
> This doesn't compile. You forgot to replace slot  with id.
>
>
> -       dev_dbg(ts->dev, "U41 Target T%u, slot:%u present:%u, x:%u,
> y:%u, z:%d\n",
> -               target->index, slot, target->present,
> +       dev_dbg(ts->dev, "U41 Target T%u, id:%u present:%u, x:%u, y:%u,
> z:%d\n",
> +               target->index, id, target->present,
>

I don't know how I could missed this one :/ !

Fixed thanks !

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

