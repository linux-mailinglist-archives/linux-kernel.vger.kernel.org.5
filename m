Return-Path: <linux-kernel+bounces-79798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC5E8626E8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25001F21C44
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F5495EC;
	Sat, 24 Feb 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPMmzZA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C1113FF6;
	Sat, 24 Feb 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802095; cv=none; b=PoMNUxn3y4d5nSMlHo66LMC6QuvaLZfPNG/DQdF6n0PgL/AsFxdwODuSN1fqhG0epb5CH75mO2YEmVEoVR5p0yKBaFBf+W66mukz10oIr9nfDokU222QAidFw70kNFUg8cK6zXqKx4SYjHOrwxIPg4rcUnNfTMnOexBvVgqCyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802095; c=relaxed/simple;
	bh=DE8KrClwq6wxRdpm6x7a+e27Q4gxgHfZ6zudnPnE/z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaXDCJFa63tarodCIo0WevMu0ANMA7jP9/alQy4K8rouU/AP1gddt62n04mWO897EyGhGvdvYA01e6h1SXmkwnZfK9rn7HZhjbvc7cJj9sL4HO6jl2UvK9bAXarUf+97LRi1Wt4AwuxWm1xwowTn9pUWasUuyi458JjKdUgwdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPMmzZA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB13C433F1;
	Sat, 24 Feb 2024 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708802094;
	bh=DE8KrClwq6wxRdpm6x7a+e27Q4gxgHfZ6zudnPnE/z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cPMmzZA9aMdrio3t9Y8uKJrwNTRepXyrtolW+v0KmTiiWsT32GcvH9ZouCdZ7JJp7
	 pjN5OcXwo/xRKtC75napxxFg1VNLHEStC//PR+1YQsnVC8yyrahttCKr2qRWsCNzsp
	 gJ3ru0xcxLiPPTSmJBG1fI4FKoSuqDLyUsE688cPE2HleErbibHX7rh8nnl0PbuQnp
	 8FU41GN249DNRTlbbNCAtrc5eggXPgu2Xy3ZALxMow3n3/Lv0fwR0TLRgr7a/4ZEke
	 nYzWJfIIe8wrE6T9+bJ8NRGd5ZJYV6yARySVG6fIXFvxVc8EKzJ/RBWhCKuWyrPTGZ
	 BJiyJqTH2DxAA==
Date: Sat, 24 Feb 2024 19:14:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
 jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding support for
 PAC193X
Message-ID: <20240224191439.18e32ec2@jic23-huawei>
In-Reply-To: <202402241545.xf7CnlPz-lkp@intel.com>
References: <20240222164206.65700-2-marius.cristea@microchip.com>
	<202402241545.xf7CnlPz-lkp@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2024 15:34:51 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on b1a1eaf6183697b77f7243780a25f35c7c0c8bdf]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC193X/20240223-004332
> base:   b1a1eaf6183697b77f7243780a25f35c7c0c8bdf
> patch link:    https://lore.kernel.org/r/20240222164206.65700-2-marius.cristea%40microchip.com
> patch subject: [PATCH v5 1/2] dt-bindings: iio: adc: adding support for PAC193X
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20240224/202402241545.xf7CnlPz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402241545.xf7CnlPz-lkp@intel.com/
> 
> dtcheck warnings: (new ones prefixed by >>)
> >> Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml:51:9: [warning] wrong indentation: expected 6 but found 8 (indentation)  


>     45	
>     46	patternProperties:
>     47	  "^channel@[1-4]+$":
>     48	    type: object
>     49	    $ref: adc.yaml
>     50	    description:
>   > 51	        Represents the external channels which are connected to the ADC.  
I've fixed this up whilst applying.

>     52	
>     53	    properties:
>     54	      reg:
>     55	        items:
>     56	          minimum: 1
>     57	          maximum: 4
>     58	
>     59	      shunt-resistor-micro-ohms:
>     60	        description:
>     61	          Value in micro Ohms of the shunt resistor connected between
>     62	          the SENSE+ and SENSE- inputs, across which the current is measured.
>     63	          Value is needed to compute the scaling of the measured current.
>     64	
>     65	    required:
>     66	      - reg
>     67	      - shunt-resistor-micro-ohms
>     68	
>     69	    unevaluatedProperties: false
>     70	
>     71	required:
>     72	  - compatible
>     73	  - reg
>     74	  - "#address-cells"
>     75	  - "#size-cells"
>     76	
> 


