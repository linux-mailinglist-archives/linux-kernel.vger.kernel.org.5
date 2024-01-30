Return-Path: <linux-kernel+bounces-44899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7418428C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F041C232D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE586AD3;
	Tue, 30 Jan 2024 16:06:10 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C76BB25;
	Tue, 30 Jan 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630770; cv=none; b=B8tvADWiXKnq7Uz/6kHsP2QpzuLsPwps7me0l5XWgzFjeGkhud3MLss5YgwaOHXJyLuaH/4jSHiK7rAISXDOJNu1M9QomMQMD55ZHRKtQdCz0P2C3lkCMjNuDBTp97B82rbWia4yZP9QrRWX1PU/q6sMlDaDxknKoAyV3RdYCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630770; c=relaxed/simple;
	bh=H16eLQlz15glhHn83S28O2LCWxrtu1PELdKLN4q9zoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbtyq8Wzrp8zaWIbcLw8PJ4jnS/PTcUzQY/KvgOTEVI9aXFV3ptEoy3lYv9Dh5kzQJref9b5OPj4dHB1AMbq9p98AYOpvfkB0REzkzHUM8Kv9x7QhyiDfoGrAQfppjQrt+4nZOWdA2K8x2Wqu/FcpwfWB0kMvmVvz7R1QEpD0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a359e6fde44so298483666b.3;
        Tue, 30 Jan 2024 08:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630767; x=1707235567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LbX2mdHtCqh+Dk4WrTnZLdkeXAyj+cWIMg/K56AOg8=;
        b=jYApe5eAhL4c4TpkrbPHS2UWMI9UOQkglWszV/Da2+HzNtSsNXdwVbW4xyTJgov7iI
         gaLPvu6g1eI3U/lAcNwvfOblWvZTYl91pl8YzYEHPF9rHfNl0iGa9bIi9nbHvfcStkiP
         1Fo8hZ2L4CDTSq+gz9hh80JW3+qbIKK8+ytMR4ia+aSXfs49pbUQzlRmaw9Q5aqOb7M4
         uAy4Jlqwfi+rC3Tx4HwYUXxamXMd77dSDnyb/fTAPvshoDprbJW1SOwUnHeYNewVxfrg
         vpV73mrQylz2ANCj0l2ZieaDGcmPI632yDzHwZZgBqq8z2KTVFh7hkqFddzj2diNyAVw
         pH+w==
X-Gm-Message-State: AOJu0Yza9p4aMHEpohCiC1oFLH4YzuMJOGa0rrai2fEkrRL+P1FTxJRn
	HJcUlXeZJh6skUScKm0EbJKjBarjoJnmUT5BH65+/yVJIiALCcY2
X-Google-Smtp-Source: AGHT+IFw9mPfX0TBsU15eBWunTInbBhoRK8tZLLd6sLDnMPemtqwf7MlCh5KbtnhYDfv7AHMVWNzmg==
X-Received: by 2002:a17:906:298d:b0:a30:69d4:3047 with SMTP id x13-20020a170906298d00b00a3069d43047mr7458405eje.8.1706630766846;
        Tue, 30 Jan 2024 08:06:06 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id ps10-20020a170906bf4a00b00a355fbe55d0sm3666832ejb.30.2024.01.30.08.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:06:06 -0800 (PST)
Date: Tue, 30 Jan 2024 08:06:04 -0800
From: Breno Leitao <leitao@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Message-ID: <ZbkebMW+xLqNhsoB@gmail.com>
References: <20231121114831.3033560-1-leitao@debian.org>
 <874jevjgvo.fsf@intel.com>
 <87jznqewa7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jznqewa7.fsf@meer.lwn.net>

On Tue, Jan 30, 2024 at 07:22:08AM -0700, Jonathan Corbet wrote:
> Jani Nikula <jani.nikula@linux.intel.com> writes:
> 
> > On Tue, 21 Nov 2023, Breno Leitao <leitao@debian.org> wrote:
> >> This is a simple script that parses the Netlink YAML spec files
> >> (Documentation/netlink/specs/), and generates RST files to be rendered
> >> in the Network -> Netlink Specification documentation page.
> >
> > First of all, my boilerplate complaint: All extra processing for Sphinx
> > should really be done using Sphinx extensions instead of adding Makefile
> > hacks. I don't think it's sustainable to keep adding this stuff. We
> > chose Sphinx because it is extensible, and to avoid the Rube Goldberg
> > machine that the previous documentation build system was.
> 
> So I feel like we've (me included) have kind of sent Breno around in
> circles on this one.  This *was* implemented as an extension once:
> 
>   https://lore.kernel.org/netdev/20231103135622.250314-1-leitao@debian.org/
> 
> At that time it seemed too complex, and I thought that an external
> script would lead to a simpler implementation overall.  Perhaps I was
> wrong.

I think you are correct. I personally _think_ that the external script
is better, mainly because it is self contained, thus, easier to
maintain.

