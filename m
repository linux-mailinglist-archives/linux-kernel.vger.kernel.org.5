Return-Path: <linux-kernel+bounces-90380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8686FE75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8EB281705
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5715225A6;
	Mon,  4 Mar 2024 10:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1vKMRHA"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE5224DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547079; cv=none; b=BpvA1CXhyKyWV3l/pcPB9gqXFCrWO8kjHg/0U6BOuSox7vCngkI99CMhKgGlYyRUAupvGEyKyfCquUOlRq0Nu0fQ480P0iVl9V1WT2QC7yMOk18C/qWCFvWA9WuWRWluJNN1cHgrJBvZZNQtk4d4vqIeYlgdRpjdTDqENI98a5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547079; c=relaxed/simple;
	bh=QsoSw7nIsKdCbrB08TRB5MwF9IW2XROJQ40mzxo9EQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq0JBB5nejxv5aJtf52DRgce+bJBp0gPcVst6FRVTH4eNJdvknV6FsIi8H45++wPeY3HV/oZCqiUchRqXj9/Ji+DREcCbIYRAyC7TYJ19u+O4ZYHQXfNrkbBh5bscz4wGk6sGj4x3ZvSmxpinwyw6vf2m52x6Fm+Phf0xjsBYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1vKMRHA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so2702466f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547076; x=1710151876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apfVynKdMHWt/84gIfAXsivA2/2+KZh2cujSEqljhTk=;
        b=t1vKMRHAekQqK4ihSgzLQ0FhGEG+pptJ/XdfGmAHmEWyO1JrVm+uK1CZMFUrfprRzG
         gf6jEqW78w/oAIFcbCZ+LkFHwxDmwS1r/fMxHXWs8ZH9DgJMXj+Sx1W9L83Y7jkWzHgk
         skMXS2K+FfWGLDswauoZJhbC7Psq5sjmdqXaF8bamDlx9yElMHxKJLqEJmAHaOU2ZN1z
         X7wPUEL+TPmJ+gN78sPaOg5IACtXSGRRLlnB7HEZ+BDm+Yt6eOHIHZxx5GP3g2dowHaP
         pNenXNllbzML3GB8v50NzHdDtVwOnsl3SnlVHJP8EZwa3G8+CZ2BLVmpmTqmmPmpu+Hm
         vEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547076; x=1710151876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apfVynKdMHWt/84gIfAXsivA2/2+KZh2cujSEqljhTk=;
        b=wV2oyOoeTRa8y0vhEGnfpSNv4jnKRnMuDLZ9hI5uguXaX1+zHWbzfIYV1ft7AInGrP
         1GU3lRiE6wgZfnK1F/kkgXvo3VDYFSYf4+UFEOVaK9fXvIkDyaMYBMWhtZBYsq+k+QLk
         K3D0JGLlrowyfZ6CRKwasiNfIEnixkS05abjEpC4UgIfmi3Nq1jzfa59mtsoTBIu0A6H
         zMS6Cdem3Mx9I/ccq7RZGqgy3uQ1UnrVGXnoNm2pGaFC4iaHFDZ7oAXuek10OVVV2l6y
         13+hi9Xe6qCv4dmC+j7Y0kKYAfIGHi+fykf7vwQB3UXq9Zde9UFN9zq8Y+uqC+g8CQEF
         kiKg==
X-Forwarded-Encrypted: i=1; AJvYcCUgV1ZI/ztBP6yAmShCDDfTZEiLt3AkWLPgEJh2bpLmlGNTk3V0WAPXVim6dTc1OqMEtdwQobvwrcKW39CX5planS/9OrQZ390rhPo5
X-Gm-Message-State: AOJu0YxN9Hel/4SEfNcXC8ObJnqrYZMJiJWCCl3Ts8BfS2Lspz9GymNg
	PU135p3JwXxw6CE4VSY7nzhWm8VgNqbEKxfgrE9p9FEL/wPlsKPpkCydAxnHQ3Y=
X-Google-Smtp-Source: AGHT+IHNn7sU3K7fVrmKdjcX18dvKktXyRnPZAwnYOUoT0D0zKIFokCLkKqap2Bkk/sWa6rTyu9UnQ==
X-Received: by 2002:a5d:5ccb:0:b0:33e:1627:4682 with SMTP id cg11-20020a5d5ccb000000b0033e16274682mr5193040wrb.29.1709547076459;
        Mon, 04 Mar 2024 02:11:16 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d58ea000000b0033d4cf751b2sm11722955wrd.33.2024.03.04.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:11:15 -0800 (PST)
Date: Mon, 4 Mar 2024 13:11:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	kernel@collabora.com, kernel-janitors@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
Message-ID: <7a42984f-34cc-494e-b8f3-83596621d31a@moroto.mountain>
References: <20240304090103.818092-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>

On Mon, Mar 04, 2024 at 02:01:03PM +0500, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite. Make its type to be
> int.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Make i int instead of u8

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


