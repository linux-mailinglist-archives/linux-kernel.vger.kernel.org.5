Return-Path: <linux-kernel+bounces-47038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6D844859
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0781F22879
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27823F8F9;
	Wed, 31 Jan 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI+BWxSx"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB093B289;
	Wed, 31 Jan 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731069; cv=none; b=Cb/269v/1Dpy/wyBOqPsczbP2eJWWbbev+FLxi3aHPFZQQvfpsUP2jnwsnZAUA1lGVpq0AztBA9ElZVNsUPP41TsaBRSMIcQrA98TlOJnuVkV8kBreJqt6TTeDrfAfj6ZZQqJNynSB0/3ARSkZAmiutmZojeqASZoAlJLtsi3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731069; c=relaxed/simple;
	bh=MVJHePKLxDNqDklcHUUX9Uxr2v9aXw8DM9bdU2c6/Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq90zAG3SwydRTVF8SRSf8m5P+727aQ28/2JMy4OEQnoMhMj1WWJIAG+75y+aizdNlu7k2JQiPWoOelkGONyEcLKRAokKQCMm/PhBXQhsP7pYxHb/VErQ/QBYGk938LI2wfdzAluDjzklgbdKkVCJZdbXxP0L982/XIMDdX6ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI+BWxSx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so76618b3a.1;
        Wed, 31 Jan 2024 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706731067; x=1707335867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnqmpbTqUddAfoWcTG7qrS7kVFKG9P0JNII8ecH+F3s=;
        b=lI+BWxSxapBNby+WY17UWlGxAOfrQAQZ5lExWRXPUrLCl0afDilZPwr4upNv+lqUoX
         mWPxu9X49F5bihr78xcJzV9G+H4mKRzWz+I0s9ks2Q6k9+w2iCeSBO/LhGT48oTYFPlQ
         fsnt6+LbuENZF4FseYWH1rhC4X8hoFDH+Pt/f7fO4bPJT7o5V4nivH+JUqxTGy9/iJzP
         FV6VyHxGQhM9ywe6059uvYUg9UAItdCQ3Rj+lSAvML+2LNDawd7d9Pz+yO078FHtNcoe
         5oaCAvYlbSqxSpMFw7yRC6ZCsqNer4wqq5mrNKhJRWaVhqcgoeG23lGBRzlW71ckPj5w
         9S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706731067; x=1707335867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnqmpbTqUddAfoWcTG7qrS7kVFKG9P0JNII8ecH+F3s=;
        b=YIKREufuTZZQ0aCG8huiKsjMjcOVnOkAXyo4PnN0yip212nwSkEW1kb0rL7ww++evO
         rrY5RiklQvDyzAWpjWBrVkkQnbDaiHElsyH9NR/DmxnXYEVJeP0MC8/wG0aRiT95xytA
         yT8IN8VKDEnHRXWoX6iBF1lvh46Y8ybqkJ0wBjEt1OAKe8NPCDB5TnWDRQbbqCULcsve
         DqjUFHSQPQOITZqSt08obW71BXfPZeXd3+NBUewD3IQOO1DT8EE2CI4Cm4Q3gfTK6kXQ
         dFMxZtWRSSUMiWH5JnMtzCbJ12jHWdJFPGxFYPHnxdiIvVHieWRxkrGaMZTtpNolexJT
         LxDQ==
X-Gm-Message-State: AOJu0YzX7VnUkxWeTZMIXsU1w3Szbn/xJiAu7Rbqjv2N+65huNqZ/GSZ
	CJtTr8Z5GV6jJUvEAr4GAhY2qNTS7eIYMZ2kpj0rG6TR0vB5rEjU
X-Google-Smtp-Source: AGHT+IHooTv5AALNh/g9cBjTgapZ+Acuo8jYh1H+lWJlEEn3x36khRQ4IGhlPxqARObYThG+Fzm/rw==
X-Received: by 2002:aa7:9e1d:0:b0:6db:d78f:d675 with SMTP id y29-20020aa79e1d000000b006dbd78fd675mr2849835pfq.14.1706731066808;
        Wed, 31 Jan 2024 11:57:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:dd5d:ba2a:a6f9:365f])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006ddb85a61cfsm10215922pff.162.2024.01.31.11.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:57:46 -0800 (PST)
Date: Wed, 31 Jan 2024 11:57:43 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Jeff LaBundy <jeff@labundy.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
	hannah.rossiter@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <ZbqmN47QhI1LhWBT@google.com>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-4-kamel.bouhara@bootlin.com>
 <ZY5An58Rffrcpfpn@nixie71>
 <20240131171441.GA3005@kb-xps>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131171441.GA3005@kb-xps>

On Wed, Jan 31, 2024 at 06:14:41PM +0100, Kamel Bouhara wrote:
> On Thu, Dec 28, 2023 at 09:44:31PM -0600, Jeff LaBundy wrote:

[...]

> > > +	case AXIOM_TARGET_STATE_HOVER:
> > > +	case AXIOM_TARGET_STATE_TOUCHING:
> > > +		target_prev_state->insert = true;
> > > +		update = true;
> > > +		input_mt_slot(input_dev, slot);
> > > +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, slot);
> > > +		input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
> > > +		input_report_abs(input_dev, ABS_X, target->x);
> >
> > You do not need to explicitly report ABS_X and ABS_Y values, as calling
> > input_mt_sync_frame() effectively takes care of this by way of pointer
> > emulation.
> >
> 
> After double checking/testing this, it doesn't seems to
> report ABS_X/Y values anymore, are you sure about this ? Maybe I missed
> some extra flag in input_mt_init_slots() for that ?

You are missing call to input_report_slot_state() before you start
sending position data. You also should not conflate tracking ID and
slot number. I.e. if you touch and release and touch again, you
likely report through the same slot 0, but the tracking ID of the
contact should be different.

Thanks.

-- 
Dmitry

