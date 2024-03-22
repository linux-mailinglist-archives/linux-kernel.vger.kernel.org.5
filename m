Return-Path: <linux-kernel+bounces-110955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2A9886639
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA04AB212AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEF125C4;
	Fri, 22 Mar 2024 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjzZtlJT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98F10A24
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085434; cv=none; b=YnzSkid0iTCH8RdjQcb5V4dY8crUUdOwU+2Kmx0818mH8ZZVjQWTEKb322fmPBtT8TN55CVDYe0nDReVHPCvjKE+/ertwcJoWgapqyyu3LYCQAL9UTFH+X5yMhS8r6fkTQzHoGQd/ErNemiDKQ+DzKeTu/pWekokbJ3tXIiwCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085434; c=relaxed/simple;
	bh=gH5pexmzbUGwNCHZ9PTUYn/hBvXARLC8S6NicdNMIyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiGvuauztrAvxW/GuPQuBWudKr0XHYWDVOhVnH5WybSs1qW/TNoQMm274KZBM4ZjqjKwIYWoKyDVv5Z/ZzKLfNk1TKsoBxYOsmVV/urMKLyQfx9Rfm5j4XWfF098IIYc9GNNMLA+YI5ZEU0clWXevSlFwzqX6XhBMonuDhE6TB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjzZtlJT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4147b5d8a0dso1290825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711085431; x=1711690231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=321mETi/Adac/ZBnxDuN0Y4/HnqrpGTboku9RcY+CYU=;
        b=pjzZtlJT5WlhO9Ui5ZQAd9bqJUv176W//paUoTCZqRTFkBlzf20OGUuqKWkYu1TOxW
         yK702v89lw8vrsTshQ+2RHwA/tYKBvefv27s8szJJ3ZZxYBZmzsAeQUeo/bk21nNJzw6
         eDIkEoiyQOyflCUZ+mypoqVU/CSqCZV7GtYIJGUMfIoFG1BBCwJugFG1R+xhDMJ4tF4u
         9Hra/fHyksrTDX0Y6p0Jed0KJm+Spvj3n5+snkOKqxA3wGc6qNw1N9Ovp94xlYkzw9XI
         YoUFkClmPOaIg1aMU3QNkoeeS7jEr49kQV+5d7ffp/bug7P+0fK96z69g7PJDZmkFJWG
         5+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085431; x=1711690231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=321mETi/Adac/ZBnxDuN0Y4/HnqrpGTboku9RcY+CYU=;
        b=D8YKeu6FmPsWv8SlZ47tACXW+1PXaLUrqR8cJd3YM7JMFT7ouoD8OC3OnLa1qw0ATE
         1aCITRwYpgA4RJkIc2JKJyl9omZ33ThDlVBhhMBnyZ2koOD0sC7qP6R/lSdJ2tvAv2dL
         QKgNZewN3TTPQPMgiEJ8hWag2E7300xsHgmytqYeNeVwXEPNwO+pyl5h0t+wL20d7sgj
         NEOw6Fxgm9YdRhXQVNnhecP3L22Cmacx85HQIh2tUIQ6HVfM78ClYZgLogLSTGnjASxa
         NP8xTY7IzfiHOqBVQ+PqtA1OicCHdWPJi3f7jNIQNrVoNhHUQFOW115jHRrTAn9pJrYz
         vyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXhLL1PFfasPjblfR4BYhUWordwS9N/A9nC2ecmHP2A748d06+0QxD7zDmOS4wBsG2jxMeuGlzDfiw+08dU0enhiEDSyjq+jm/2Ityn
X-Gm-Message-State: AOJu0YyymMyE3QqzPcKxmQahTPunVFZSd9sUXNY0Z0hRjQGSToDB52oG
	pvLFOpntOTaQ2nFyO2E6HPIGThpZdWoegZtUKR/G/4RcaVmdfQDwuPcJ32vqmyc=
X-Google-Smtp-Source: AGHT+IHkKxlHhdE6WoCQw6vjGFcdk5VzZZM3XWQTSj4P8n78wnFsREbl0RQB8AA7bcd6TncGfFNFEA==
X-Received: by 2002:a05:600c:4f89:b0:414:262:df45 with SMTP id n9-20020a05600c4f8900b004140262df45mr764816wmq.32.1711085431191;
        Thu, 21 Mar 2024 22:30:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b00413e79344b7sm1882713wmq.19.2024.03.21.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:30:30 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:30:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Laight <David.Laight@aculab.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <1655b591-1259-4d71-8f93-e840b1ccc22e@moroto.mountain>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
 <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>

On Thu, Mar 21, 2024 at 04:20:09PM -0400, Julia Lawall wrote:
> Does one prefer an initialization of null at the top of the function
> or an initialization to a meaningful value in the middle of the
> function?

I prefer at the top, but it will be interesting to see where the
consensus is.  Kent Overstreet has said we should move away from
declarations at the top generally.  I don't know if anyone else agrees
with him though.

regards,
dan carpenter


