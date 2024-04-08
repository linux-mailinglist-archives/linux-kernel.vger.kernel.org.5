Return-Path: <linux-kernel+bounces-135271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7789BE39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81C01F22AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AB69DF4;
	Mon,  8 Apr 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/1oprHx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEEA1E497;
	Mon,  8 Apr 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576419; cv=none; b=CY3QRNQ3KVVk2d87uzD/PQHrA5xk/qbCHh2DOnbNcRhH8u5PqmMkeKrJeuQ0wS/EV/BSFICdP1VBNvQKjP0q6Q+MD3mmq+vqPQUG8g+KIdGiySIawHqwFR2cz2gmwctHT57fbO5T8iszoAO69pqdgMMZLJ6egkBRatr6p1gyJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576419; c=relaxed/simple;
	bh=rWFRjSTrFEi3sr3QTftz5bcZoSq9cdKy8xG19AUfBpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7k9bSmJpdxwZuxl6dLk//rBgIUAUsdqKckcs9MwgGL5pEdNuwOQk+qr/DLIh6Ta806XPQynsqLWyc2mtVzKIPUQ4ozyylP0UUDJMpQaZzrUOFkRtOh6egSowL8SCC0ehgbzEep0OpTfBw3WD6EGBDaG0X5MtfQGMK34d100Ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/1oprHx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e45b9a5c53so2708175ad.3;
        Mon, 08 Apr 2024 04:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712576417; x=1713181217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8Bi3GrM8szMy/fOrN09Zas7BpLrzN+uFd18xGLTGdw=;
        b=U/1oprHxwvfac4Zg5q7t4Ni3AfNbHOFZEpbVAHlSqTohOBeoB0uZd1slDzP9s+OiQu
         lA5/qLJkqlu1jz72+/3YqoNeSVRU5tPYkP8fQZ04PoDsqJQZm3ZhVWl51McPQF5eZBVs
         7DBBdtkGvo8fMNpGUff4dq8leVlWRZTJ9ZxrQf+0jUwGTwUzeNweiJTDyFkyv8wdP37Y
         UzoYkc/zrENCZdpLyCAZir8nWfFspe8xPf8n2WNpgSh9IfeDHLO4hJnni/ihisxdJwRC
         TG+8ArBncUpGdjMnWl+CCFQvTy8IHIi5gq+iB+p3hOEuLQRmDik6SilsNkh8NONdY9t7
         VORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576417; x=1713181217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o8Bi3GrM8szMy/fOrN09Zas7BpLrzN+uFd18xGLTGdw=;
        b=UdaKECoP9C2qx3NVHMiBfnqkinQNoHVn8sp6nPD+mfDJ9xT97xrWCXD3yYnmmjoJ1N
         b1v7P1SHPuXGLatsvNN8QMTwaZL54bFqLG2W4tcvaIKn9hAeFRqR98pgxvo3hioGM3XX
         M9lJHrngUj8t44UAMiq9z1Ayeb1gYVWdbB+x8vz5aewuOdPKS19QJkrPXFEyHEoIaKoY
         4M1HXqHI13TIP8i4l/jWJcT07wFQXuCFTEJya1uR5kD/h4e8sA9uUmvD08Y6ygs0E1vf
         k8fQMNocC35925qYbaIb+il2wbfP3ChUY03FAc+58rKE51Ro7eEjfZG28PXKC8RHku4w
         dFfA==
X-Forwarded-Encrypted: i=1; AJvYcCVdk6+d5FaKnfZNMPjzAWYoOu/EN8SNGLrD7SddULUjRdJSnB/DJBpQSsEZ/OvwCoOW+mAXKfitkgMu41hXKjWpRYTJNCxkKSQwuB8BrNuM7wQyXWmw90OjpBiKefvg1LovqD6E4vVzdupsXR2t8S/cEwJA0Zdi7UgeyiLpWXVbTSsy8A==
X-Gm-Message-State: AOJu0Yx9I5iccTLx5+6B4gyn7IAAnfqPTpNbjnS+iGhxJBlV8xw5Nv/2
	/uURiuN1YqK3D2X/UKWg6E/TQTH7DVFeGJNvQNEhs4xWcKmoiUrP
X-Google-Smtp-Source: AGHT+IGwQWIqu2bxXFF7QdG5ABpWhh1MQiQODBJT2SoTN/3dDWilIKrLY6SbJvOTCbbTs6SIeQeOBw==
X-Received: by 2002:a17:902:6b02:b0:1e2:3e0a:fc5e with SMTP id o2-20020a1709026b0200b001e23e0afc5emr8424464plk.33.1712576416956;
        Mon, 08 Apr 2024 04:40:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b001e3e081d07esm4439176plb.179.2024.04.08.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:40:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Apr 2024 04:40:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "ricardo.neri-calderon@linux.intel.com" <ricardo.neri-calderon@linux.intel.com>,
	"Neri, Ricardo" <ricardo.neri@intel.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to
 read registers
Message-ID: <48f81be1-b484-45c1-850b-8aa364b8d836@roeck-us.net>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
 <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
 <f4d18a63-c348-4882-897b-dc636feb149b@roeck-us.net>
 <d0b5ae04b4d08e2003114c4d6b6d3a040f585995.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0b5ae04b4d08e2003114c4d6b6d3a040f585995.camel@intel.com>

On Sun, Apr 07, 2024 at 08:39:51AM +0000, Zhang, Rui wrote:
> > I do not think it is appropriate to make a hardware monitoring driver
> > depend on the thermal subsystem.
> > 
> > NAK in the current form.
> > 
> Hi, Guenter,
> 
> Thanks for reviewing.
> 
> We've seen a couple of hwmon drivers depends on or imply THERMAL.
> That's why we think this is an applicable solution.

So far this was - unless someone sneaked something by - for drivers
which registered thermal zones, not for calling code which resides
inside thermal subsystem.

> Using the intel_tcc APIs can effectively reduce the future maintenance
> burden because we don't need to duplicate the model list in multiple
> places.
> 
> or do you have any suggestions?

The exported code should reside outside the thermal subsystem.

Also, as implemented, if INTEL_TCC=n, the returned temperature mask value
is 0x7f, and the offset mask is 0. So the alternative would be to just use
those values unconditionally since apparently that is sufficient.

Thanks,
Guenter

