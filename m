Return-Path: <linux-kernel+bounces-162056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BA8B555B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F71C21E46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F0175BF;
	Mon, 29 Apr 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oh+QzXWO"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B181848E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386636; cv=none; b=bLZQBSlKnLDqrBzytN/cBsPBjc8Y0AHwbSw2c8XGGvRHxQ1HTlBVua1lAAC9AojMxPz2DcqdAlfMoHfWIExwZhHCMf9liq5fNrP8juHhtjzZ5acxEN+vg//EHeCXvJ/X56b2nYBlR/AmkhtZbpyd/PUYJddYaOoBPNdzpi9jWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386636; c=relaxed/simple;
	bh=UbDQchwJ/5MpMWWetkzU6K8E2bg8wM9Cju7lJa1j2uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxyNHk12UYODaCpetcwg3vEkoV4CDXKycj4k4upUOpQ55ilVSL29RkaeYXxdZPjq954kU2eilCQkEN9AJKxmF2ja4mPIOy0up/k/5pIHbt9c2L6x+PzZm+WV+F2FURL4wwOuwpK4fYr48GX4uHQGh94EETR87jLFY8cGEIQyD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oh+QzXWO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57222fc625aso4762336a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714386633; x=1714991433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HfdH1jIH2/B+b7aR8d7pkmFhac9pK2yLLIIWF+ZffE=;
        b=oh+QzXWO7GPG/rrPwOopWYzTXX2K94O0aR2QmPX5hnwa6PAiruuu1LwqbwxyBi2tDl
         c24hTVkZjHtL4x2t4LtP4zHrngUc1P4ZLGduv4q+ZvShcrxwEEJfJDPElZCOXUUFZDC6
         ysrnI/7hMwdig0LCluG1GAKmGXXzzIz8qC7mQbf7MtGtTDJ6qceFduCpbEOUrJANs1W/
         lR4j2xKX2nQITly/Kan9Ay2Y9V8f2n36PQYqaYyzBoF/U/HaimydTYnZa6p5hKGgDGvF
         2GtQEF7Ai9iEwjN/Aw4ER++eGSbs4f76lK2lqC/l6z57Ox2r3Vy32cGLdiazQFcINDme
         MvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714386633; x=1714991433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HfdH1jIH2/B+b7aR8d7pkmFhac9pK2yLLIIWF+ZffE=;
        b=rq3K+QGSKC3/VH0oc+JXdcCAq4WTGp/FT+dj8LsRzZigdzjnQX/CK68Wc/LPqRNKAR
         boWU1RUBLaq65UJqueTlb8f+QDcAN2U25/n3gJxw42P47Z/YcaVUJB6Vtj6q6Kld8US5
         im44akxjYNH5saJCTVyrzrydvtRmh9iABSM1VxPbqB7yQUPI0d5bNXhh6UMspukaQxzD
         uj9r7cJA6bvpFqEwfYTX1/zwjrHGhkMWi6yAPClTfMmymfKaGy1Z2Z0cOaLrwbs7ib4w
         cizhQr8y4KnQeoFUqovwY30mqDqNkJopBib15rzFWiLRWFBujxlRxGOxqhJuseSUJnFs
         Mezw==
X-Forwarded-Encrypted: i=1; AJvYcCWo97D7MUvXn/HXUGKAHniJchgIC102Py+2FxxQ8XbrMNZaVEt+WRMV0Xbv4s5iXRdxf1ZKvfdONkoO/IG7+dkrn2kbWBGubiraNKlG
X-Gm-Message-State: AOJu0YxjIQxywVqtKDgI+xPA1ZolGcsbUFfOTAqNHG0xcAGzAgUn2pnf
	npR6lhIXWdIGcFuUcUGpOYegLBOlxihjteaMnUJwJIPFbvs9U+ogvgdKhvya6AY=
X-Google-Smtp-Source: AGHT+IH20HweA0CE7+18VgLPAHNlNE07Gw2Y/AzjTIzrC+0NFUfK6LbhGiLvlju6wH/4YgzFQT7kww==
X-Received: by 2002:a17:906:eca5:b0:a52:699e:f2b6 with SMTP id qh5-20020a170906eca500b00a52699ef2b6mr7846394ejb.74.1714386632555;
        Mon, 29 Apr 2024 03:30:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bw13-20020a170906c1cd00b00a58de09fd92sm3080025ejb.27.2024.04.29.03.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:30:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:30:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/region: Fix potential invalid pointer dereference
Message-ID: <c6cab703-87df-4152-a5b0-a0ce31e7f057@moroto.mountain>
References: <20240429013154.368118-1-lizhijian@fujitsu.com>
 <18a295a2-b734-45dd-9c95-660a9e1f58e4@moroto.mountain>
 <576dccd9-1f8d-4c69-bc7f-497413b87b9d@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576dccd9-1f8d-4c69-bc7f-497413b87b9d@fujitsu.com>

On Mon, Apr 29, 2024 at 10:25:35AM +0000, Zhijian Li (Fujitsu) wrote:
> >    3084          mutex_lock(&cxlrd->range_lock);
> >    3085          region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> >    3086                                         match_region_by_range);
> >    3087          if (!region_dev) {
> >    3088                  cxlr = construct_region(cxlrd, cxled);
> >    3089                  region_dev = &cxlr->dev;
> >                                       ^^^^^^^^^^^
> > This is not a dereference, it's just pointer math.  In in this case it's
> > the same as saying:
> > 
> > 		region_dev = (void *)cxlr;
> 
> 
> You are right, a equivalent code could be:
> 		region_dev = ((char *)cxlr) + offsetof(struct cxl_region, dev);
> 
> 

Correct.  But offsetof() is zero.  It's the same math that to_cxl_region()
does.

regards,
dan carpenter


