Return-Path: <linux-kernel+bounces-160962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA58B452A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9014B1C21B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786D45958;
	Sat, 27 Apr 2024 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4BTyCLN"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720108BFC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714207510; cv=none; b=ZYJkMpxZ5/mRpPhy8ZfaOBv7mN2ag2t/CuiwfqrmvCBa5XoWD12HUSkWqBpYgFKKBojDvBvshJ8ekv4MKPeMqB3QaYnVeLSsmlmFizx//ClpTkavSwJrcSCgwz6LeJabfQERz8loKfrzt+LE523xFvHCOFe2bEA1QIXU6aYBGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714207510; c=relaxed/simple;
	bh=yF+2ANE6qdkqttXSkb1nmNAoTIlP+U26rnn+JAKSYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG09y3ahgGQjbxqtyCiXnR9p4tvYZn4kthNCWU+2kPN8DxxDxt7envldhCUT5As1qx0sbCJBirte2ZhG+Nfl9BktVjh5fvNBPD9SzeZMSgSAoXJDOTX3YnGnfL32rTk1w5MfBsWLenV7LdfMjCbY9iOx1jdoYkD/J1rQH+WXZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N4BTyCLN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e65b29f703so26680545ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714207509; x=1714812309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uhMTax7vcBSN8/vVcReWjI4f74u0LbSaDXTLifTLE9U=;
        b=N4BTyCLNRyUP0GwgsfSPd7Ths/LKq51nFh/JfPpl29GBOs5t3C6127gR35zk817wg2
         abLmtFegUmvIT1Ub04NgM4WkHlW4SxM1NEU+vklHwCI7h77whXPLh5PCrk8xsUb56Pzt
         CvZd5A86uSPCVlX0r0Hr1FFSNoDdNx57k8qUqQKk0pus2UU/y+SH7hZSpP8oqFhyvB3g
         /sD8/sgfrN+M/zwbDAv0yOANjMAs5913oCihqOyHx538EOVZkzz0/oFJzA+Q6dC09b6b
         VymKi7wwEO1RHBIvrO4mj4YdbTEA44hn8nQyylk1IUmfDnMUnQ1ZTCYjm2bO7pDw8G12
         3BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714207509; x=1714812309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhMTax7vcBSN8/vVcReWjI4f74u0LbSaDXTLifTLE9U=;
        b=ck5bypANQpePTJXReSyqda39P9xc8ubT6ld1kiMGBBFj0/YsOXjfCg74r9aObijAoQ
         96c0y4065wsTb/q6Fmend/COerVmaGpDSAl2tjim4WPfhDo9/THsJ6xbA4SHekB9gJwG
         Y8S1nYywcmSnNtblVnw/0d7A1Sfht2c9ug7bFXLpPLgd7dRE8forH1MaKfRpwPZ33C7/
         2HSjDqKH9VZPbLQHREkg0noAsgW6b6hWlgZKGUXkjeN0OpcnBcVre1WjrPF1YyPQcSNe
         8ZAdmxEXfTUgim6WooqGw5fte+XPaP9ecg6xJy3q1vbeEDBALPUHtoMC0HSTzfd7ma4L
         fJGA==
X-Forwarded-Encrypted: i=1; AJvYcCUyqf/qyo34SCQ/m4K0pDbD61AnaNZP5+Q0h3Z6EviQOnapC5eaDbEYnEVZYY76LPHAULCth1jezC3Vw9PG9Jdd+lFAc2EhWseEV2Bd
X-Gm-Message-State: AOJu0YyfVKUW2dz0xKbsoZUYZoo0DoEjJxtf9NYfjdKeF6St6Q3ZDAkY
	i1elsTIt2f+yWbDmsQ+0CnLmgpyy97npr/B4scfHlq686Dug0p/TR9yoUqV9ug==
X-Google-Smtp-Source: AGHT+IHO24pn8Kd+ESNOGCIm0qtKTXYxtVLY6DI4aCEHWLKdIrToyITwwSZLJ0jbeU0Nu9U32rPelA==
X-Received: by 2002:a17:902:ed05:b0:1e2:bf94:487 with SMTP id b5-20020a170902ed0500b001e2bf940487mr4849343pld.57.1714207508549;
        Sat, 27 Apr 2024 01:45:08 -0700 (PDT)
Received: from thinkpad ([120.60.53.237])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001e5cadbdf8csm16723785plg.37.2024.04.27.01.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 01:45:07 -0700 (PDT)
Date: Sat, 27 Apr 2024 14:14:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Aleksandr Mishin <amishin@t-argos.ru>, Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] PCI: dwc: keystone: Fix potential NULL dereference
Message-ID: <20240427084459.GD1981@thinkpad>
References: <20240425092135.13348-1-amishin@t-argos.ru>
 <63b89455-3e30-421a-a082-00d39e836e20@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b89455-3e30-421a-a082-00d39e836e20@intel.com>

On Thu, Apr 25, 2024 at 03:00:14PM +0200, Alexander Lobakin wrote:
> From: Aleksandr Mishin <amishin@t-argos.ru>
> Date: Thu, 25 Apr 2024 12:21:35 +0300
> 
> > In ks_pcie_setup_rc_app_regs() resource_list_first_type() may return
> > NULL which is later dereferenced. Fix this bug by adding NULL check.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Please stop spamming with "potential fixes" made mechanically from
> static analyzer reports without looking into the code flow. These
> patches are mostly incorrect and may hurt.
> Either have a stable repro and then fix the real bug or don't touch
> anything at all.
> 

This patch obviously fixes the potential issue where resource_list_first_type()
may return NULL if the MEM range is not provided in DT.
pci_parse_request_of_pci_ranges() will just emit a warning in that case and this
code path will cause a NULL pointer dereference.

Even though this situation means that the DT is broken, it still makes sense to
have the checks in place.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

