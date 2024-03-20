Return-Path: <linux-kernel+bounces-108437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D25C880A84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1DD6B21EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5114284;
	Wed, 20 Mar 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3+JZmgx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F212E52
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710910918; cv=none; b=jNyogYTNUuhvTMasNvWpxKGfTn0Ysa2exUFW2DbazTCMv2piWDtPQ29vhPmeV1mRwLvoru8J8mnptKiXoliVsNSsAUWf6F9pUeOiWruIj3GqQWj0HC7PNHcwgw04C5ys9LLOFgariBQKubnbLdSywqO5bKpnHxrLYWnflsj2nKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710910918; c=relaxed/simple;
	bh=OY1yJiqGKNtzEHd+k+wwWigcHefXcqgg1Yu1bcQ78IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn0/cMZEZnTrXDO2V5qJdoL67avQkbrZUsCA/DO0292K6sBGHgBHH5AUbzls7FKB/Gl3yscFtIs3lbmiX19Eo/FJMYRpczFm2wW1jPZuwX+d8eDsQv7H8T1dVI0g8waYEZIqoN+T5tMpIu6U3bcVzW2gjLExx4hxCpz9agctVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c3+JZmgx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-414676fe047so9031035e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710910914; x=1711515714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0B7vWKH9/N5Rr83D0ntmMC2zkFMIdP3Ld+bd82Q6BI=;
        b=c3+JZmgxwOpNCkx47skUtLAwUXGnq6vf4ArrYKzGWhKlt3en5hwR53PjNQby5GVOJ9
         BwYfmrS4CIygYv3hlFcUJzpNnTfXIc4vUi8srVQBpuGR6rJQPIHpaFarNYdsi9z96zfk
         59pjkesvZXaqkJRhFA2wmRFOLkRxRoyZjr3Jxv+b0XeXr0DEaJTU9PzidsreC+yetJjG
         JAfM6d90M1AuTHnL98Ix7p2/VSlnaKfYwvRPLsYAeyyFtNQwICOOHNbVhDWBck8CdfgO
         rvoOHKU3M4/FA7NiDDbbatjWqzJ3yOKMtOaXdxDG2K3f8eCce6lNUcP6sEVeywJ9x2VC
         wuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710910914; x=1711515714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0B7vWKH9/N5Rr83D0ntmMC2zkFMIdP3Ld+bd82Q6BI=;
        b=qoajvC6oFIbFx7H1zq/ALHExERH7RNmLV1LrS3eaLAdueOZ+qtvI77S7nlWVzAakOG
         cWHJt68TU80uPMToz8nWFMoUgUWa7Q6Mw2lU5c8CHcUSrbjZGFQj3U8VTlg8eo3ieZAM
         C8Dt5l131PnuAeCoKDpnMYm2PDYpKgb90k2YPRimgP/9iDPH2yzbFtcOkMhl51RaxsMG
         x1E9+1raSuudDMIxYndqjWSo/OTqX5Q6aE8IFT35awqIswgJLyIswbgxqYXKf8hpuBj9
         QnexsJckJEvodRUG/RArtJKlHXZwpuYd4oXbsZzSNbjliKHunWiqZEWgCl2RSMm+JRvm
         lQdA==
X-Forwarded-Encrypted: i=1; AJvYcCU1eStZ2ShIimp8E++qfNM85lTQeqPGqC37OzY/D9l48wLXXs7b3l5FOeZZEligcTLgO71POow7O1lNyZ5QhdFXPM2yKvNPm7SbirBE
X-Gm-Message-State: AOJu0YyW+Gs0Rqn1BEn7Mn+IIQdmjip+DyVA4I0hNEGP1y/CpIrf8crx
	NteKxwOH/3gQ2J6kEjwlaOyFCio025/Pv8VtKxh+ufj+/tA9bcUgtLbLtsgPIuI=
X-Google-Smtp-Source: AGHT+IFGGKSK87rcnJmgzexq+3rYiVKaJtZ99H0a3zsNHEKEaF3v2b0OfuXy/cpjUcYbMSTlWTKjgQ==
X-Received: by 2002:a05:600c:3546:b0:414:ca1:6531 with SMTP id i6-20020a05600c354600b004140ca16531mr833716wmq.41.1710910914424;
        Tue, 19 Mar 2024 22:01:54 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s14-20020a05600c45ce00b00414618bea7csm893210wmo.37.2024.03.19.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 22:01:53 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:01:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
 <20240319124317.3c3f16cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319124317.3c3f16cd@kernel.org>

On Tue, Mar 19, 2024 at 12:43:17PM -0700, Jakub Kicinski wrote:
> On Sat, 16 Mar 2024 12:44:40 +0300 Dan Carpenter wrote:
> > -	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> > -	void *mac_buf __free(kfree);
> > +	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> > +	void *mac_buf __free(kfree) = NULL;
> 
> This is just trading one kind of bug for another, and the __free()
> magic is at a cost of readability.
> 
> I think we should ban the use of __free() in all of networking,
> until / unless it cleanly handles the NULL init case.

Free handles the NULL init case, it doesn't handle the uninitialized
case.  I had previously argued that checkpatch should complain about
every __free() pointer if the declaration doesn't have an assignment.

The = NULL assignment is unnecessary if the pointer is assigned to
something else before the first return, so this might cause "unused
assignment" warnings?  I don't know if there are any tools which
complain about that in that situation.  I think probably we should just
make that an exception and do the checkpatch thing because it's such a
simple rule to implement.

regards,
dan carpenter

