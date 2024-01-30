Return-Path: <linux-kernel+bounces-45043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26440842AED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA111F25EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97912BF05;
	Tue, 30 Jan 2024 17:29:29 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418586AC8;
	Tue, 30 Jan 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635768; cv=none; b=QT/pH1v0LXrAeHnOeCNcGa9fZWA5l70ZSQBgZWKtFfmJHtqAdonxWmtssdMSgjjUSlmb2mT8enNKiCpPSEG8W4mL3/fg4WrOJ8vIeoQ+BQ327s1cfy/mubBC/6IFTLk7Rl8Vx2Ti2dc/wunr/6qRrRVd6rqMXHA85cBDTVAxWwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635768; c=relaxed/simple;
	bh=wQ5lyz2eBlx1PxsGXBAMIkd3YS8qNppoaChpsHFgeSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljFon+YermeneluwqqDzB6PiVIGSoYrSFh/bRdtF8LMTv0OCj7Rzp57aWFIC202F+/vjRFVOWRKPI7EtygTN4HADbQtv5LRjYtAqx/80YVeuKLt497QhXq/BexwP5J06PEnIrqQJAHJ8tckAvb7q/Qq6ZEWTbeZPwKhPRXN1vJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so445376266b.1;
        Tue, 30 Jan 2024 09:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706635765; x=1707240565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX5j+4Pi5k+lrwe5c2LVQlx9bMQ0Yzg1CVxNcNnOwRU=;
        b=nVIcyk/fobbLJV6cBWIKnD0wj2UZoOYgi6CemWDu+UageYZPZRN+fyR2uiGtkqVCmf
         5DWML6lR0VuzqPlYgFT3MLx/d/V8y39VGY3RFAMFytZrSf5twpGa2zwp6b/v/qhminvK
         rN4cDRWPTHmLArozwnIq3voZvB4CTHGhpczfJgHwKNGGBk5qFDh3EVABQm31gs0HPHUX
         IB6yN7bG3l8XxnYXojeP9o1YkhcRbe1pWmf7Lo8CoIikucMkbYSxey1bIcIV6zK6/E44
         q3voEOitGGFJu2YJ51iK22zyu/nHZ6lhTgstoSkis5cKaj6/oyTuwiatjfjYxP5nktE4
         VvTg==
X-Gm-Message-State: AOJu0Yz2HiLxFA8g4wySrjKD19C8qSCchDr9HZGG3Zzsk8fRSsrG6NbW
	7a3D9/tUs3njGSaHRGl2pAQYDJMylHOQw050xQfQhzPzFcmUb5SM
X-Google-Smtp-Source: AGHT+IHP0TNvHsKVfe06kCsdvC4yvJ2v+4V8iPbs6DfFMnJTk08qnmxaatQnOQvg5LTM0M+5jDtpvA==
X-Received: by 2002:a17:906:250e:b0:a35:d943:b183 with SMTP id i14-20020a170906250e00b00a35d943b183mr3829613ejb.35.1706635764952;
        Tue, 30 Jan 2024 09:29:24 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090652d800b00a3193a5556csm5309049ejn.189.2024.01.30.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:29:24 -0800 (PST)
Date: Tue, 30 Jan 2024 09:29:22 -0800
From: Breno Leitao <leitao@debian.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@linux.intel.com>, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Message-ID: <Zbkx8vd+vzLvWuuF@gmail.com>
References: <20231121114831.3033560-1-leitao@debian.org>
 <874jevjgvo.fsf@intel.com>
 <87jznqewa7.fsf@meer.lwn.net>
 <ZbkebMW+xLqNhsoB@gmail.com>
 <63304f6a-d26f-414a-8c92-14d740774379@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63304f6a-d26f-414a-8c92-14d740774379@oracle.com>

On Tue, Jan 30, 2024 at 05:23:36PM +0100, Vegard Nossum wrote:
> 
> On 30/01/2024 17:06, Breno Leitao wrote:
> > On Tue, Jan 30, 2024 at 07:22:08AM -0700, Jonathan Corbet wrote:
> > > Jani Nikula <jani.nikula@linux.intel.com> writes:
> > > 
> > > > On Tue, 21 Nov 2023, Breno Leitao <leitao@debian.org> wrote:
> > > > > This is a simple script that parses the Netlink YAML spec files
> > > > > (Documentation/netlink/specs/), and generates RST files to be rendered
> > > > > in the Network -> Netlink Specification documentation page.
> > > > 
> > > > First of all, my boilerplate complaint: All extra processing for Sphinx
> > > > should really be done using Sphinx extensions instead of adding Makefile
> > > > hacks. I don't think it's sustainable to keep adding this stuff. We
> > > > chose Sphinx because it is extensible, and to avoid the Rube Goldberg
> > > > machine that the previous documentation build system was.
> > > 
> > > So I feel like we've (me included) have kind of sent Breno around in
> > > circles on this one.  This *was* implemented as an extension once:
> > > 
> > >    https://lore.kernel.org/netdev/20231103135622.250314-1-leitao@debian.org/
> > > 
> > > At that time it seemed too complex, and I thought that an external
> > > script would lead to a simpler implementation overall.  Perhaps I was
> > > wrong.
> > 
> > I think you are correct. I personally _think_ that the external script
> > is better, mainly because it is self contained, thus, easier to
> > maintain.
> 
> From a cursory look at the two versions, the actual Python code to read
> the YAML and write the reST is the same in both cases. (Breno, please
> correct me if I'm wrong.)

You are correct. They are similar because Sphinx was not bringing much
value to what I was trying to do (or I was not able to explore all
Sphinx benefit - It was my very first Sphinx plug-in).

That said, the plug-in was basically a wrapper around "the Python code",
that was re-used for the one-off script. So, moving from one to another
was easy.

