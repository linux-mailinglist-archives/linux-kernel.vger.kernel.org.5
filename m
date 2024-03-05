Return-Path: <linux-kernel+bounces-92226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77704871D16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABD32862E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50954FA7;
	Tue,  5 Mar 2024 11:10:27 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F78352F68;
	Tue,  5 Mar 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637026; cv=none; b=djY4dQree1sAVpjIpD9D/Ic93zyEVzz6sk34S+WqIkGjN4k3YjEadohA/uhbc0aQjBidsHa2EOnzfD4lxJC5TKAwoCH8O1hNQMyIuPCpHtnsK6z1l5OXDVaqSC/fESeHgstZC3pjLP20LjgFzhC7kCUQtts7RCGrwf5LHoHuVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637026; c=relaxed/simple;
	bh=u8BWNCh08meOM1OtGC+9EsEpkY4nW8/MgqKpE/dlJEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4k4VtVrcKiqP80T0EwBAiEZ4anlHwDOBD8qp/jgB6t7/L6UQ/lUA++xB9RV1L1KZqxZo1yNiDW6hoBhjYwrTRyKXUv8iJdd30HD1aKrk+9R2C1RuoeycrOiE5mQJQBRfREit47Gqh3Ky6NScxE50tnM9J2QWNOIKkiny/YL4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so66704031fa.3;
        Tue, 05 Mar 2024 03:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637023; x=1710241823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtISm0Z5C5GSK3a8VloumZ4aA+1uD6WNJU+it6M3HPw=;
        b=W1mlUpH3P4rmcNZMHUguYG04uBOUVySTJxe2/Sy6v/VcKflRmEtaL471JQcQacRE6N
         6+8dVnbHGaQWyfNaW4D6JLk8bJAaiBL1lgXBnNU49AUwaZr2lWa7Pdfxaompo1IT3Ti8
         rDDEdL4t+G9A5+aSt/eZEF0hFN88AXPb2dd4+iJwjZwft6aaamMvylSbpghjtugsa57w
         GjnVFXjAEcOst9E1TFBNT8a/6MhKhHOP2BEZL+hCVlosx9rihLWrIWqN5cRvopIHQKCZ
         FT+4D/4CSIR6wvFFBMyBhHx7FIxgDem/gpLAJsplx1ykDbgdzPccEqbBMSLRsY6wduFl
         btOw==
X-Forwarded-Encrypted: i=1; AJvYcCVTQAa2zpB4HVy8BJPN+3F8kGlZt5kFjbRVoKC2Nz8DXNijN4AzIvWgT65NyKfvod9csZVty5d6F2p+eipRhfWgFmxsPOH9wYF0qQ5JxCsFbgm2IdzToo3p/EeqUFZycF9vdLjNPMXZLtpeFujDFhDv8qiissJKA3T0ZZRErTOY
X-Gm-Message-State: AOJu0YyEsS7qnWmgjvD2vAyrUclnXuuNDGo9ZoornJXNPQwwpLOAv8Hw
	Sw9s0FiLOspvX2yItydf8EyVVxCZOhnXBW4KiS12yfHTDTR6eOMd
X-Google-Smtp-Source: AGHT+IH5VCvu7H5OMAWLBGBYxoUjNSI28uMv6IKIpi5MkPKL0LtsEK8KgyNYwVWHWaEKr+h4MR8kJg==
X-Received: by 2002:a2e:980c:0:b0:2d2:c82c:b822 with SMTP id a12-20020a2e980c000000b002d2c82cb822mr981535ljj.22.1709637023131;
        Tue, 05 Mar 2024 03:10:23 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id i17-20020aa7c9d1000000b00567566227a5sm2016306edt.18.2024.03.05.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 03:10:22 -0800 (PST)
Date: Tue, 5 Mar 2024 03:10:20 -0800
From: Breno Leitao <leitao@debian.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] docs: Makefile: Add dependency to $(YNL_INDEX) for
 targets other than htmldocs
Message-ID: <Zeb9nEgZHJvoyw7o@gmail.com>
References: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e876e3c8-109d-4bc8-9916-05a4bc4ee9ac@gmail.com>

On Tue, Mar 05, 2024 at 01:23:00PM +0900, Akira Yokosawa wrote:
> Commit f061c9f7d058 ("Documentation: Document each netlink family")
> added recipes for YAML -> RST conversion.
> Then commit 7da8bdbf8f5d ("docs: Makefile: Fix make cleandocs by
> deleting generated .rst files") made sure those converted .rst files
> are cleaned by "make cleandocs".
> 
> However, they took care of htmldocs build only.
> 
> If one of other targets such as latexdocs or epubdocs is built
> without building htmldocs, missing .rst files can cause additional
> WARNINGs from sphinx-build as follow:
> 
>     ./Documentation/userspace-api/netlink/specs.rst:18: WARNING: undefined label: 'specs'
>     ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/rt_link'
>     ./Documentation/userspace-api/netlink/netlink-raw.rst:64: WARNING: unknown document: '../../networking/netlink_spec/tc'
>     ./Documentation/userspace-api/netlink/index.rst:21: WARNING: undefined label: 'specs'
> 
> Add dependency to $(YNL_INDEX) for other targets and allow any targets
> to be built cleanly right after "make cleandocs".
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Reviwed-by: Breno Leitao <leitao@debian.org>

