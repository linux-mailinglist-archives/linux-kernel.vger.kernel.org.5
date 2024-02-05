Return-Path: <linux-kernel+bounces-52999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5C849F56
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE73282DD2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053083D54A;
	Mon,  5 Feb 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcxbQzlO"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF43FE3F;
	Mon,  5 Feb 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149759; cv=none; b=DkMITMDgXLIwyZWy3Sn3wHWL4C0VCe9r024BDVeK9AOWgJT8QwkNdr46t21T1zXmeToWPuGQQJE53nnPcNDJEzSk8mSkp+rIpCl9JBTP/s/9DARGp1lzh03d8WlSeKfMZPLIX1GzQQkOfAVqKmI7rtHPfMFF/Q/lt/VSEtF1Rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149759; c=relaxed/simple;
	bh=kkx/O/ujIQXkPPA0V7iuXOHL13tL22TQ34te1h449oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+bRdvuD47UQ7jywUy2p9/INpQAG16Ixth+27uxwBtr60Q7TpdqkVsSfZoGaTXpnLPN37+1cg9DDaFVMk0rEPw9XpWDZeuU7WXjZc5nNQr4EzRxg21tHQMeJ4hWZsjTx65+VJf6I2VtO0K0Hrje65yiYZDJTUvryyhi/cKnmyCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcxbQzlO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4029470a12.2;
        Mon, 05 Feb 2024 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707149757; x=1707754557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hm4IF6mqVqlMzi3KUMsQtKLW8cec8PhPsOxYQ6v9eU=;
        b=BcxbQzlOuwORyZzeaDEvYR6SGmWCq4MGn7eVLaKhdlscbS37GOX87zCAVN839Wg3ZE
         WPm7x6lJrLKV0638vG7m2gzdRZrOGekYxo+QSTALhvWKPx+38klbytR2Q8T9RZZlwwE4
         vKpaxFKQukxYIUWBBV/d9+eltrJUK+LRm1qq1JKfOiwOkVLKsIYwneBpwZI8kX04aIRh
         EDSnUJu9EAppUz4AYyinHxd3k5vePVFq4WecXfOymASdJGvI3xE9+YYDBwWJTK15RZD3
         DT0mDeoHAzG2JO5h74qew7agnqiiP+6sANOpCIR2n++SQXwnlNAEeAlAApLIpkhkxcmz
         4Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149757; x=1707754557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hm4IF6mqVqlMzi3KUMsQtKLW8cec8PhPsOxYQ6v9eU=;
        b=WGkfpJUjjFeGV4yU9KspyK0apZD9LztPYOgfFhsWP+jTp7tfTawTvckjE3LQ1z9d74
         X4ryG7752fhdGD4u0OlRgSMX86M2WpDzeeNCRZjVOa53DaHmuzdm5djZ6lpcosg3hEaL
         dMaC7AfOBwsUwyTC1VUw103VrbX+7QIIIMf/NFf3aDesTZxMlPKdEuc/YgGpvwVilSvd
         3zszHu/NMBrHGr/CWhzqPIasQCqkZq4KJg74nGTZJz7YgZ9xbCjM0sAyYylvjWSSQzBN
         uf4EoHCu/HVJJG5ZYLAr5qbWKv00NW9NVdGO5/DQxG/IwvJ60wwpxG+yZnpXZ4ULxuy8
         0EIA==
X-Gm-Message-State: AOJu0YxMZiRFuTYNHMH/YI1VnCD0dmXJoqs6K0IHF1kBmeR40zM8wwLn
	2d0ijH1RfsT4OMhdaa6A0ZqSvoCNkDb6WwufR72Gxs7ZLYut/PEP
X-Google-Smtp-Source: AGHT+IHeHL0iimBfLevm7FbGyFS3nqf4qM44mMmNhiREIu5/zZShcYDA58urQx4CPF50PmPBxg1cig==
X-Received: by 2002:a05:6a20:da85:b0:19e:4f07:16c3 with SMTP id iy5-20020a056a20da8500b0019e4f0716c3mr11159367pzb.55.1707149756917;
        Mon, 05 Feb 2024 08:15:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXxCoYH6MagcfW/VnubibOm2HpVOJWXyp6tZz0oMCzJHzPCn9+wp03cUGNYwwFSHKW21iCO+jFuGQgE+R4TDIjVyOESeoxWuGrb4fN62X0x5hvQBBSr6fSnABV3pXkIsDJYPStbK8/37vLUcYQx3Qig3icxsgOR1KEaB+G61DSkQRYaI1PZGq6tWFZZ+a7rpAAQIg5/d2Y2qvcFfxMVn19osurq1Eaxf/B+RqF3+T+4uMDDnHKdJGX6/+GVwNFYQaDKf4rxdlAs3ioH6G16eIIfPiBozcCpd1zNYuNx0OXWafaTeOMjQKrY7LI+Lw3Nsda563t4CvGudCNYNc6z6gbNEUM2a5IkRI5jJ+MuqAgySA9hLbl3xLbgzI3z0J+rDHk3Iy7WGPYDJed+2Sd/QC+rEJOmLnGc5E5HDC7JjFhwQpjOWbZibjF6OCT+cbo3rODwS8hU9AcfZlVbRHwdrX+4pv28Cp+A3YbT/O6KMTG7u9HYqzV1TpayyOGhruaUSAeJ0jgigSiYIewhOjXtX7sEXxVEyHL+7lX5QF8ZnxoFS0F+taOKM2vkSz4LWl3tbvkU76/DP+mRkugtDOGVzCHEdVl1Bbgx7lcQiNUfncNWXGOerSnnzZcDOPDRhDRVgv7UcS+l+ojR4NnVB5dwB18qCA1UYMJtczmNBgDVj7UStvHXq2Uhc0x6z16a4VVK7gZs9ACsX0BOXHaj3Rs2/vX6vJM29DFi+lrMqgaK+LgK7RDv2lja26M7uv07rY4Q2P8iMO+aH1IHrXCNHhJlySmwnsW0gWUF4qc=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id by35-20020a056a0205a300b005cf5bf78b74sm120948pgb.17.2024.02.05.08.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:15:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Feb 2024 08:15:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Cosmo Chou <chou.cosmo@gmail.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org,
	naresh.solanki@9elements.com, vincent@vtremblay.dev,
	patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com,
	bhelgaas@google.com, festevam@denx.de,
	alexander.stein@ew.tq-group.com, heiko@sntech.de,
	jernej.skrabec@gmail.com, macromorgan@hotmail.com,
	forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	cosmo.chou@quantatw.com
Subject: Re: [PATCH v5 1/1] hwmon: Add driver for Astera Labs PT5161L retimer
Message-ID: <b932533c-d1fe-46bb-8187-b0560861e982@roeck-us.net>
References: <20240205152013.3833940-1-chou.cosmo@gmail.com>
 <20240205152013.3833940-2-chou.cosmo@gmail.com>
 <99a1a309-41d6-448f-b622-b62dbabb2c52@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a1a309-41d6-448f-b622-b62dbabb2c52@linaro.org>

On Mon, Feb 05, 2024 at 04:26:08PM +0100, Krzysztof Kozlowski wrote:
> On 05/02/2024 16:20, Cosmo Chou wrote:
> > This driver implements support for temperature monitoring of Astera Labs
> > PT5161L series PCIe retimer chips.
> > 
> > This driver implementation originates from the CSDK available at
> > Link: https://github.com/facebook/openbmc/tree/helium/common/recipes-lib/retimer-v2.14
> > The communication protocol utilized is based on the I2C/SMBus standard.
> > 
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
[ ... ]

> > +
> > +static int __init pt5161l_init(void)
> > +{
> > +	pt5161l_debugfs_dir = debugfs_create_dir("pt5161l", NULL);
> 
> Drivers don't need initcalls. For sure any debugfs should not be handled
> here but in probe.
> 

Lots of hwmon drivers have init functions, for basic chip detection of
Super-I/O chips (example: drivers/hwmon/nct6775-platform.c) and to create
a parent debugfs subdirectory for the driver. The probe function then adds
subdirecties per chip instantiation. Example for pmbus, in
drivers/hwmon/pmbus/pmbus_core.c:

static int __init pmbus_core_init(void)
{
        pmbus_debugfs_dir = debugfs_create_dir("pmbus", NULL);
        if (IS_ERR(pmbus_debugfs_dir))
                pmbus_debugfs_dir = NULL;

        return 0;
}

static void __exit pmbus_core_exit(void)
{
        debugfs_remove_recursive(pmbus_debugfs_dir);
}

Are you saying this is all wrong ? What alternative would you suggest ?

Thanks,
Guenter

