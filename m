Return-Path: <linux-kernel+bounces-74134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67A85D052
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B126CB24CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889BC39FEE;
	Wed, 21 Feb 2024 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLDqXc/E"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0179A35
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496198; cv=none; b=tJ7YoMUmP6PG9l9UZs5T7FBoa6CFzldgYg/ZF7A66C1BXDyn2u+WaIGfwK2SKIVTxtje2BawOzKDxFXyvQBQmdohQHI7BIuXz+tuyjFiYfcqfhudYwKRF3wInr4KnueZUHGWO2Z+LMC3d6GIL/If755Lu4G5CD6ELqHINA6siDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496198; c=relaxed/simple;
	bh=lHfFTbKGGvFdck/rmrAXH594b/eXCNIyVcujZgd1IsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6MlVcU5zjQT7bIstzs83IOkxHH7pv54Xlsbmr425RgiD8hw8v3H6DpIZ4gJe4fRkEkq8IW6nDToDcJ+t9JtfxCPNqjj+wWXNayC9xVkW691p157OwfMX8i/uwxNP5WF3X2IAcx8ySX4my4kpn5UB67llRmzS/ac6ATqCcl6Bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VLDqXc/E; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a34c5ca2537so22763366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496195; x=1709100995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBpDJD/8UR0M4A+lAq/lEBCPZtNQVXe2AMZez47aZ5k=;
        b=VLDqXc/E4Z/ffpIEUfFI2GOqqp6Tmltb/q8/Bn2nrUbguo2+fvkTtX9J8Z3FQmDI7Y
         VtMRU52U5f8EddfUagrNtKRTMypERR25m57/aRc8F2lc3wJ1k7msDC3Jbff2tIVvQkx1
         22ZW5+70z3SFaAUDpbf+DsLFLP6u5fSpnGAhNAF90iQzVDkltMQxVX2QYQlnx2ZwtGyH
         nW6ZcTwiJE6yl1tcZQMXwq84mV3afh7/6Qw5GtfckW+46JEL+Bv6hoCpcUFQZ2Ox1YS6
         UkAxycYY+LBqbfgtjvwJir5SZQuHxQuhhSx8wV7DuoeDBpmRZpJWPYkDKf75IUGGMHoO
         t+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496195; x=1709100995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBpDJD/8UR0M4A+lAq/lEBCPZtNQVXe2AMZez47aZ5k=;
        b=xJjjGkf2N+sQfinD76Kt15Hy+AQPPLHW7aPlBMSZldjRAgc0q5DAjpT1MwTk7TOqe2
         5g2+NoGhWDttKv564XgI0QaL1O1XDeABVudweAQtZDvQU2ygGRmSJcUHk5Ro8f79jak7
         CqtFkCfIqb1x3mTN1EhPDGiOmHIpOCATmEs0PGN/TZhGTPb0pArTxskbF8rWLCqOMtFC
         5ipoHsYoYR81UG1aD/ESxFPzhyXHXMcnfTU6BiP7mMgnRpBR4B0T0iILfE7uzQXKNypZ
         1cBfMsaUKo3YO3r3YvWizJxiOCeEoifZ6VUZGpL8BzmTUeGCTC37uCSX0Vv56mAzUYMU
         IQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXVK+p0ir93tGqCdE3Q+unQKIfVwhjGpXGC2bZDkOHUgZVjia3AdmcUqwvC3rV7Hs5pYJ506bNdMZT3oeJkQEJDfoMve2u9mRywW4KE
X-Gm-Message-State: AOJu0Ywrp7v4Fgn7576R5tPVah9KQB1k0a6Go0xvsqcUsDvLxjIRkHmb
	SMqFpUeHALCLZavy8MtRf9zoXnw32ILl8WaFUnzFj8PKbrmVfWmCEVBnKvCaheQ=
X-Google-Smtp-Source: AGHT+IGSjRq7w4HlZKHtJgf/CLxLIPbnicGK4G0VfEkYa35QHuhw5fYTdppYKXMoYhBKVY732t8qKQ==
X-Received: by 2002:a17:906:abcf:b0:a3f:2ffd:c683 with SMTP id kq15-20020a170906abcf00b00a3f2ffdc683mr736205ejb.62.1708496195279;
        Tue, 20 Feb 2024 22:16:35 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hw12-20020a170907a0cc00b00a3d11908bbcsm4534876ejc.203.2024.02.20.22.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:16:34 -0800 (PST)
Date: Wed, 21 Feb 2024 09:16:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: William Zhang <william.zhang@broadcom.com>,
	Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	f.fainelli@gmail.com, kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com, anand.gore@broadcom.com, dregan@mail.com,
	kamal.dasu@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, David Regan <dregan@broadcom.com>,
	linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v5 11/12] mtd: rawnand: brcmnand: exec_op helper
 functions return type fixes
Message-ID: <f6e61482-b51a-4970-9257-8db7975148fa@moroto.mountain>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-12-william.zhang@broadcom.com>
 <20240220110240.1ad5b995@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220110240.1ad5b995@xps-13>

On Tue, Feb 20, 2024 at 11:02:40AM +0100, Miquel Raynal wrote:
> 
> william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:56 -0800:
> 
> > From: David Regan <dregan@broadcom.com>
> > 
> > fix return type for exec_op reset and status detect helper functions
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/102423.html
> > Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
> > Signed-off-by: David Regan <dregan@broadcom.com>
> > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> > Reviewed-by: William Zhang <william.zhang@broadcom.com>
> 
> By the way, a Cc: stable tag might be useful as otherwise you may leak
> an error code in a status value (which is a bug). And move this patch
> first in your series so we're sure it does not conflict with any of the
> other patches and can be backported more easily.

The original commit 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op
implementation") is not in stable so we should be okay on this.

regards,
dan carpenter


