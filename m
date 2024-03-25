Return-Path: <linux-kernel+bounces-116997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EBC88A5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF2E1F39430
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FA4C92;
	Mon, 25 Mar 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgtWZHH7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227AD4A1C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369738; cv=none; b=AisfkUWI8YtBGgArtBd439niSXLCb2EJ+fmqZ9ulFvVmDL26i0R369ioAan6NYED+sIligTMWCqlIeg+DOZOROskgWGx5Laglg9evmbuvGXtEdqnFltE9hh/y2OqRdQJ84x8NXa4OMp34xMzeo2C40/2iTYokQ78+50R22ako14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369738; c=relaxed/simple;
	bh=4aRjekFogW63NJ/saTB+Ui/q79quDnGwh6aOvA8UlGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJhsnEQVCTpfOnRCBuLDWCWJ+CkpGma+SIQoCcAl7N/mHKN+ZFe0oYMcQz+qpwC0Ipg8tZBK1PLfreB7Pb/7CR0T/KUOJw0aon3TPObTqB7YZLU8M8bxhkJHPaXiIdp1wR985c3LJ/nWoZYkl+eU6mr6ODeb22Q0/z+hdLSDrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jgtWZHH7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c01c2e124so1831197a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711369735; x=1711974535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5iWcf+JZDsLUFR0I0zIhJdqU2WN9xV+AKxo3kNhvLA=;
        b=jgtWZHH7nDoerjn69NmX0BZjvDmsFo4vMArMzfEe+CapBtGe8ECN3nGpo5j7AW8f43
         uWkiMTZ8x1CXeM1yEKN54krdYRAbQra2mR6zxOM7HaIzd5ElXxpg60N2S387OWLUMEa6
         oiv5KHv1id5XRbVKDTz/npHR0lGlrZ4DoueV846r431fK4EB1AD3pG8K2ZoCtRtve2O/
         bf/paXkOVLX1n9+r1oXffqAt71EybqtIUjWfU5f/+x7Z9IVZqmWoBX71JQNd9m97gO5b
         2v7vPwl37fv9pH87QvoatNa5Rh3a5GHTiyzdvwSS3ppgO3WhR3F5yBwuzgFPBsKeB7oC
         GfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711369735; x=1711974535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5iWcf+JZDsLUFR0I0zIhJdqU2WN9xV+AKxo3kNhvLA=;
        b=IeXTYUi7WmcNJ8V3WtwG24CvERFu91mGiT+hPmTtTptksW6h3+gc404gHRyL1Fblog
         ACh2FQqhR3vn8yXzSru1AE4Nxp71YdnMohWvA1qxRxd69nl4SXJQrVpnEJOolBYhYIYb
         pKaWzq4Ed3G4qvEcU8UqjOLu7Ev9wLsZj5yopfnII5wkTYnevJeTcUh6X8pSTKI8WRpu
         7cEokPZm1UOzWWxc6Dr4DqViFNLF1a1+HkeIzipXoaUmEHAux/BGWoa9WVS1A7uEVwG6
         qbtblKByJUuWwLB7/hLUg9v+7IJa26mU6hzcko3hIakfF38cp1uBZVkZ52kc0i9FpCt/
         zQUA==
X-Forwarded-Encrypted: i=1; AJvYcCUzqO9pV+St2AUGpMlpMPAV96TNhK45EYGg4XFxxQ/bUig2jQrth3dch7JdGS9gwWP0Ku1jqPD8w9N/NtQDLn3FnkU8P3IVKro40apz
X-Gm-Message-State: AOJu0Yy7L68ycjaBqrX5lu2vmd05LwbQ5dKPEUkXZIHSrA6jgZq0Tife
	0HimycQUQCcqmmfKOkb8JYM45ToKB1vqIKwWM6Gd1Umouo5S3HRZXOT1+7zLc8g=
X-Google-Smtp-Source: AGHT+IFkj0j2GhlW2pPV439N3QcOLRTQjACpF7mNQ6hJa8q6n1DRrMckbturzaEhq4tBC0AGpYFO0w==
X-Received: by 2002:a17:907:6d0b:b0:a49:7078:582a with SMTP id sa11-20020a1709076d0b00b00a497078582amr2657317ejc.35.1711369735408;
        Mon, 25 Mar 2024 05:28:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906504a00b00a4735e440e1sm2994822ejk.97.2024.03.25.05.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:28:54 -0700 (PDT)
Date: Mon, 25 Mar 2024 15:28:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: coolrrsh@gmail.com
Cc: slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
	gregkh@linuxfoundation.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] staging: media: remove duplicates
Message-ID: <f11e0f7d-3521-4f6b-b38f-2e6f3cc59674@moroto.mountain>
References: <20240325033427.4708-1-coolrrsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325033427.4708-1-coolrrsh@gmail.com>

On Mon, Mar 25, 2024 at 09:04:27AM +0530, coolrrsh@gmail.com wrote:
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> The kernel configuration VIDEO_DEV is defined twice in Kconfig.
> Thus, the redundant code is removed.
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> ---
> v1->v2
> modified the subject and commit message
           ^^^^^^^^^^^
You forgot to modify the subject.

regards,
dan carpenter


