Return-Path: <linux-kernel+bounces-55972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79C84C44F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4FF287FED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CA14AAD;
	Wed,  7 Feb 2024 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ9IJReS"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06051D545;
	Wed,  7 Feb 2024 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282375; cv=none; b=kXrdQsfszERuk+g+0vlpnV3Publ/SOSttYGUnlZm8bu//vy5gJZL0K6lS/nPYqRpSq70GQzM2qV2nAN4/yCLdZ0GqZwC48QoiwogpcrqkhypvelbE/fiIHTm/pOB0DDf42DK75BQ6sgKfMY6geExy4MQvfrp0/mSC2zW6RUeIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282375; c=relaxed/simple;
	bh=HXdEz4neNPqJhUYTMEAFBXSVUZvoKuFo84Dh/ZzTqAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXhkrl5WmpLXrkIldFyTpqJMKvKCY+MxyTGJzjUGCM1f1SNBiv/lUUBnBzKAwSKUlD3umZIkcWakFPDsjrvjKChmarD5xPc4j7KkwC+R9KT8nztCn3PDqIhosUilBxa95WnOQ5j3BW9ugZnoKwxTHZnPSYtoc/htjJznKoViD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ9IJReS; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so108916a12.2;
        Tue, 06 Feb 2024 21:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707282373; x=1707887173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVMfjLEZ6v6vfJyHCcJwKFjXXKGs/vYf8QOmeAWT4Kk=;
        b=RQ9IJReSVpbFg3Slny5HEI63tKzhmj/AXgcduPg+H3FtwVG2aliTcby5demRY6CYGi
         gj4+g8Ck5OtXVWOuBvGYt7mthDI5qol1gKNaJf9h2RjBigG/ZIFPQueNheL0x9BarH3f
         /iQ9Mu7FVc1xDHCAjcT9qMeYkQZDhom/nRdD7HmG1JxAHcOcdG9fq3Ipb1vahDX9lDLx
         cdTDeyR8CLHWDXx5ZvH6Gc/mOzQ70GszNXEE6N58JBcV+vtF13vEPQOLJTl7ZmJygGUL
         gkG+qNrsBqm/vAHq1D0WmSBzJhbMv5I0Nb1HerhUETtJdLAPB4p7zQ50rgvNpAA2eVpl
         nOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707282373; x=1707887173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVMfjLEZ6v6vfJyHCcJwKFjXXKGs/vYf8QOmeAWT4Kk=;
        b=O7Jv7NHG/AyLvSATjWYD8swRWOlKUGzpY+gTBC+7RBS0w01p4i5X7I2rkg9eJuQ8iS
         2VTxtVH45pwbVJMGk3E0IhwvLEfhrJPGF0MLvIIc/YbN/if7y7Gw6Mj8t8LiuEICOdIp
         ssx4dt9VKbmHixcNW7oE03gI19rmIbSLOCfh/5SNDaGI5fLcR5b4d8bSTAvm6GpjSdeB
         WOHyoUluPSal4bVQXYfPXWJATGZ/oQoC6DdA0zGbisPOF0zkrguUVYvkXRm2rKSxwjgV
         6MDd422GeunH9umpzC/l9FOC9VKli4xCVEw9130zulj6MgYUDmKbVhIcl3Ii4wHViUCs
         GXOw==
X-Gm-Message-State: AOJu0YwtTffxVMtWWH1/32xPI1JSaJvxGjHQiHVF2V/y1a4fNMZqgyCc
	h8xQQozqbh9TTt9p7icQRRhxAsRYYQzrYiuooV8i3D2zWoK+6IOh
X-Google-Smtp-Source: AGHT+IF75vPk5H9u81CXwVRaxg/z3Xn2JpVu8mclU+ZqzRWXNul9toIcK5b0po3Fl7zx9byVy7hulQ==
X-Received: by 2002:a17:903:110f:b0:1d9:626b:ae3d with SMTP id n15-20020a170903110f00b001d9626bae3dmr4884505plh.18.1707282372776;
        Tue, 06 Feb 2024 21:06:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVP0blSK2zo8Nb5ishboYD2cyDEMWdaqTZj+W8YHkzf7sBI9H6Xijb6hrwqMfoZ1mwWBFln9En1Bz1jZCvvXWAFmx7mWQo3/JzcHBxVte8s69FKdRvdDpAmsfXyRI/ECockXcZ/FAacYtnHomLPuuJGa0yFVRBcxWoz2oZyMyfVNQMS+h/geN+vSjxoODi+/fmLav/LzPSHfLtlu1M+r8K7pv5z+3Z1AXEWQMX8Vq6yQST2k7eBCMQelOlgW3TjacPRhrgAeNtGK2KVzYZQprrlTHNWjJW8Fc1TpDxB/5w5lren/fYwdBGCe/tQ6HqakGMyZbrQOopumVZBctHWhkpcIwtM31j+tTj02Ed0n4fJzeKTN99H+lX9V4HJOvTnwz3Os4C9fg3Lmptv3dbz8pb8QOag4a1U6iCUOM36tFGacjrftfGMsi/LXg+4K3Tt3DhwY4rKwsaONrwuraibggzd4UeLGQhdS0jCEv3ES13ZdcDE9I56fe2oSazpEgsxzI8vyqsQn9lRf6KYNDida2q3KmP3gClz+YlPlq/vPHLlIpr7byAO+Os97Ux+kJAf0jRUGbWjxXvjqNFNUY/ob+Ls2CtETUIA74q+ZfVkQWo/GlgtRcEwWQAByOJhekdH47uyhElHR//qe48PyDsGxPUM6NnMEKL1DCL29CYvyIve2T9TLqy5h7pddL5rvMP2rtwpFaQX3KjSx5wVZz8xc5XausMaPuxvO5K9LiwGC/tpxIkmPDEgHsVe0PFFO+gTv29idITHDD+GQD4cJuena7fUvL9+cZVbR8ft4f+TG5al8q8EK/CcdZU=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mg5-20020a170903348500b001d7222d8caasm441561plb.50.2024.02.06.21.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 21:06:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Feb 2024 21:06:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
	broonie@kernel.org, naresh.solanki@9elements.com,
	vincent@vtremblay.dev, patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com, bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH v6 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Message-ID: <d0736226-c4f0-4788-bb1a-8e0fb6522d8f@roeck-us.net>
References: <20240206125420.3884300-1-chou.cosmo@gmail.com>
 <20240206125420.3884300-2-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206125420.3884300-2-chou.cosmo@gmail.com>

On Tue, Feb 06, 2024 at 08:54:20PM +0800, Cosmo Chou wrote:
> This driver implements support for temperature monitoring of Astera Labs
> PT5161L series PCIe retimer chips.
> 
> This driver implementation originates from the CSDK available at
> Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> The communication protocol utilized is based on the I2C/SMBus standard.
> 
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Applied.

Thanks,
Guenter

