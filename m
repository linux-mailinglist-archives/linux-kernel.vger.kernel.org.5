Return-Path: <linux-kernel+bounces-46084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F5B843A11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7CE1F2F486
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E164CC8;
	Wed, 31 Jan 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fg9tabzF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294D66B5F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691324; cv=none; b=bnHemfV2mBv58Wi3yEbY2fRsd6o4eWgSxbkIPNv1oeAPBAYpxbxxOmziZaLoMcbPHu0j0IWFuunrOhQ1Fx2foJqoaz/zCFpfRGr4bYvFpkWXvF3eRzf1UJJ00ilSOujn434K28YnKL5+NTyRjWlD+89hqKgCmJGV5ZRdYlLcIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691324; c=relaxed/simple;
	bh=1zAz2+MFVhaNzjF0CUHFlp2iK4QKE8zWsjZLLf44jk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddQ0/Gn/Hr/4WrutzFOsXJ5jbnJMlYv1Zw69tQxH0rSmcd4mjxlX//XN9N74zPwNpIMCnXESbpEdYggc7ow3afx3vOkGR6ukHSIIpLg93CHJkovEug+ZjS2BZZkxQZAkiiWp9PgTpNcNxUFiJ8vA77CKAEhKzX01xA2P2OckXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Fg9tabzF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ae51f8111so2505249f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706691321; x=1707296121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zAz2+MFVhaNzjF0CUHFlp2iK4QKE8zWsjZLLf44jk4=;
        b=Fg9tabzFtad5EwKggaEcDrs2/ZmYJgVp0eQLjYfftJD/GGN9DqbBjrSzWpf9P0vuel
         2H2p4iUBl+z7ZcoiyXgY7tKPHl2wEELXSPz9QHhIR1yFzwOJddRcaFbdrH4IaUAA+x3e
         71xBT/WyuXGZEfWjbJmE9Bb/PyQjzA6cq1Gl9D7u7xn3+g3OkDk21bE7j4UCzXisM7z0
         1d9Qr5ohvYSOSrALiOIFqu2OzFRpVRkz7mLfMphGo0aZO4bQCgOfazaHSFShW0yx4+Sl
         9M33WfiHHlZGjo2YfomsK2Tb7PZfGfCmkk7jAM0hhMnao5/V5+4C0vYQGdYf6ursuSWA
         uNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691321; x=1707296121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zAz2+MFVhaNzjF0CUHFlp2iK4QKE8zWsjZLLf44jk4=;
        b=vR7ofJvm3PsSZypaSHwl6xdxI3gVNjFpY9tZp/kPMFn1LXl31EbIDR4sOiYDlh7Yyn
         OsrDcyyw/FT4Me4y9oiwFZYFz8Q0wAwMwpA/b5AZ9kxGSUQkWKQWGJpaXY66nQ2mxhcE
         xDNYm+Z/eZjkHqRR8596sfC3S6llUs85XyPmXmsgyboKPa5z8dY9/Q+dL9Upk+Mbz+Qq
         t2YFLFARME/P+cEhRZn3m+uY6QMFVjji8l3N+yrrnF5pe+xaD7tePcscfzCjgG63PGLB
         o39kz4IJcQgrqsbUREECyJuIGm0Sybtlhn7PjwG+RkCZ7iYaQmApvYhO+Fu9LOVtOdKQ
         4kjQ==
X-Gm-Message-State: AOJu0YyWWbfE02/Iql9l5QULnm9sWkwHJbRoKUuhX28SIIZX+fYNBWz/
	0cxjC9GO4ijyGfd7YcrzPp7t2rSNm+0O2F7mOqEC3t5FaJW4/ZXUixsodE/2VapP8fo6HmkNAo9
	lOuAqaQ==
X-Google-Smtp-Source: AGHT+IEDaB/xrJB9e/nbcOYh/jzhcipifSUQvbsXwmciEyC3bvRWprUeAzSWNd6QobawgPm3fQCCjQ==
X-Received: by 2002:adf:ffc8:0:b0:33b:290:253 with SMTP id x8-20020adfffc8000000b0033b02900253mr711420wrs.59.1706691321011;
        Wed, 31 Jan 2024 00:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVijmjMIBMPrVUDqpjOW8DpKrsuG/p+eiyjvljc+dEmxB6q2VcNXli1GoNTXWTgsQuSMqmzskCR7aGyn4nRAwYXYG/UmYNOWWOF1uwNI61zppf43lGmYYizGcUNUFCZZQNUGCpi7w4ZtgCB0WBCIqRnfLxpSC7406NOM6iHs7q8O8FAcRbp9PGzvBG0YR8wPtWvmVSfJPd2E13lM01BVx/i0geEPVTkXUA85quOLBts/lbIapx0m+Jo+E9NT+8V7zgl1CDqyXsAmJTXcg8qrf6IjK7V6+Bm05MpE4tIP18QxWOvc6hJnHXPaG/FBv9hHppA6A2RVm0KvkfqxOQuL2hN0bjIcYdO2SCRlhD74ep7iaQ/4VlTQOZdnqM7BYSCfXvf0IC11iSL8TmQkogGy7tRWyt308LRGyblF0Yop5iZy4AyE/JLjXz8YbuWg/lkm1NH80kP
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ay12-20020a5d6f0c000000b0033ad47d7b86sm12915043wrb.27.2024.01.31.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:55:20 -0800 (PST)
Date: Wed, 31 Jan 2024 09:55:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: karthiksundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH] ice: Add get/set hw address for VF representor ports
Message-ID: <ZboK9aHNTngj71ue@nanopsycho>
References: <20240131080847.30614-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131080847.30614-1-ksundara@redhat.com>

Wed, Jan 31, 2024 at 09:08:47AM CET, ksundara@redhat.com wrote:
>Changing the mac address of the VF representor ports are not
>available via devlink. Add the function handlers to set and get
>the HW address for the VF representor ports.

Wait a sec. The API is there to change the mac of the actual VF. Not the
representor. Apparently your patch is not doing that, changing mac of
the representor.

NAK.

Fix this to change the VF mac address or drop the patch entirely.
Thanks!

pw-bot: cr

