Return-Path: <linux-kernel+bounces-61727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23D8515B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398B11F217A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D43D39B;
	Mon, 12 Feb 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gQ+gKrP4"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AB3D0A9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745444; cv=none; b=f1weOdUeK2nNjxRlJLhPxKPrpUSlmO3khOexWPIUeDutDXb0YU2Cc47VMTzQ8AnpYGcfNG68/jh8507DH84c3UPTBS8hDUzkv/c10MQXQpsDA2MKHsAslz8wWUyQYgyEz++IqRL5ey1KbtAmxwfXVHrvsiBXoyPRt22iqwzmQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745444; c=relaxed/simple;
	bh=B4yt/3c18pH1ffL1g+M5DkAR20GAl3UBFB3rTEBPRIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqZhL+mM9y00vj2AFbl955XD9sYVL+ysftMD22HO6FM08Bh+L5QyoHd4gXjJzhBLpTdMFqGFzjPHBcItICxXLaiEh7QKoR2sKjw2EG2Rx14GPqAYnM6tX6t2PEwxrsXu1SRJcvXRmhN6WvKMWRcevokpEcvQdGCU0/nGQha50Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gQ+gKrP4; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2185739b64cso2157385fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707745440; x=1708350240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lxjh2nYflElEAJrdIUMq3Id0Sceurf4l3jYjbgjuJqQ=;
        b=gQ+gKrP4p5VBADptaVMYCktRPxhYp3OVowds79ysa3QhkhmWOSHYX1ohUem0qVzEEd
         ds90tKh7HRWBu53KUaIzVkYK5kWo+XcCs6+GH5kO0wyMlATax8sR3ha8Gn+od6j743YR
         pJgsQ9Sfszw+TreZ4iC4quEGDHOfWKqP6uOUUlDzAa2GMdtjCATPNZ+SkyX/0Odd/cZ2
         t4KGmPH764/SqrnMV5E+KM1GmDe66N68Skzx9UmG5ruLhlVSYpJPYQC9lKXpTRSJYLvN
         /2WUkt672h5KFpKX0+tmPqAGXLlspxrqDLprk3TD5WWpQMt39p2TLhp3vskMKNCynMeL
         labw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745440; x=1708350240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxjh2nYflElEAJrdIUMq3Id0Sceurf4l3jYjbgjuJqQ=;
        b=BzLDElNjRT+F+hPwgOTCwVRk+tatbUBpQ6Ru7aMJ1/Mxk+3oiz20s1rB2MC9TRz1gp
         VwhGohR+WbdWUfSWfSoZo6fnoFrM6sH8MYS9xXgJmVACP0zoUYEc2OtD1OsZ4bKIAjcD
         5ugQVuyOfxqQzHj2py2PQNOYc0fz1idYIHmHG4YVlHkkcYY9NUUlkXk7F1wXbdM3iGdJ
         M3KFahawYfTSH4V5o6P21m22dybqVRfGg/aK2/dcythw5EA4UOyox+sppznZeUS/CnLZ
         ZTWa9wrsWgJ2VeOL4g58qL2MEaQwgYWPOVkhtbf4a28LtJl3xT3PwJ6N5eWpWUdEb128
         w++g==
X-Gm-Message-State: AOJu0YwzWjLANk3R+kxckOGHyb5g7UWFrkccuu2nTiyT0R9a/u9CS25E
	8EEFfRMC0QxnKSv8nrPK63ddzdHM0jNA5zBn4BgSQ5j+fvbTneJJaPbB6RMyzYr4L7vJE2tNlsF
	O
X-Google-Smtp-Source: AGHT+IERc38GiMok/nQ6Rr78ypiB7l2ODyZK6ToRnzZO4gdy6yrCuL2f7Ll2ZkXTckymQay7YmfN+w==
X-Received: by 2002:a05:6870:56a1:b0:214:e52c:ae30 with SMTP id p33-20020a05687056a100b00214e52cae30mr7203556oao.54.1707745440268;
        Mon, 12 Feb 2024 05:44:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id j25-20020a9d7d99000000b006e2e57a9f19sm62103otn.19.2024.02.12.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:43:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZWbG-00Gwj0-Q6;
	Mon, 12 Feb 2024 09:43:58 -0400
Date: Mon, 12 Feb 2024 09:43:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/35] Fast kernel headers: reduce header dependencies
Message-ID: <20240212134358.GB765010@ziepe.ca>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>

On Mon, Feb 12, 2024 at 12:14:43AM +0100, Max Kellermann wrote:
> This patch set aims to reduce the dependencies between headers, in
> order to have cleaner code and speed up the build.  It continues
> previous efforts by other developers.

May I suggest if you are going to do this work you talk to the Intel
0-day folks about getting your git tree linked into automatic testing
so you can post patches that don't immediately trigger a 0-day report?

I've found this invaluable for my own work.

Thanks,
Jason

