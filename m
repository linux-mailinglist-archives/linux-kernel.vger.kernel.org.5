Return-Path: <linux-kernel+bounces-96172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A852387580F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964BFB23AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081A1386BF;
	Thu,  7 Mar 2024 20:16:14 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A581384A3;
	Thu,  7 Mar 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842573; cv=none; b=fIwrZj/N6R7OdhdbamGQbLo5bOQdWiPefJBAB9KcJOiI8dxwY1G12jV6TuTezuLs3Rw//uwqwcD4ET33xZ/f+xv7LhRlhW0A3bAHNa2kOENWYhtAd/KHruPc477AtsgkNASXpi4LbapVbOZk6OAZRO1qEM3oHchRosySLp+wdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842573; c=relaxed/simple;
	bh=A4ojRm1yac8P8+7JjT9Co/kkOIRrumYEoOESGZHp/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGlYyeYNP6Lw9YX3bwoWZNXnbIZUw9P45dBC5JBsrdE4U88CwUeFOqIlxhcdDTGLBkawoE2SAoMyULd4Q8n87S2pv3QFN8wXg5sna+ZJvdYKGyfST0CcMKP1LWegsBBVlOK+ac4pPiTR/sTPUsTXhGsu2eRpyGgta8jBCafu5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 8CB3B14053E; Thu,  7 Mar 2024 21:16:00 +0100 (CET)
Date: Thu, 7 Mar 2024 21:16:00 +0100
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: coverity-bot <keescook@chromium.org>
Cc: Jameson Thies <jthies@google.com>, Hans de Goede <hdegoede@redhat.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, Benson Leung <bleung@chromium.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: ucsi_check_cable(): Null pointer dereferences
Message-ID: <ZeoggIXSLy+lVHP1@cae.in-ulm.de>
References: <202403071134.7C7C077655@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403071134.7C7C077655@keescook>


Hi,

On Thu, Mar 07, 2024 at 11:34:21AM -0800, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20240307 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Tue Mar 5 13:11:08 2024 +0000
>     f896d5e8726c ("usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses")
> 
> Coverity reported the following:
> 
> *** CID 1584245:  Null pointer dereferences  (FORWARD_NULL)
> drivers/usb/typec/ucsi/ucsi.c:1136 in ucsi_check_cable()
> 1130     	}
> 1131
> 1132     	ret = ucsi_register_cable(con);
> 1133     	if (ret < 0)
> 1134     		return ret;
> 1135
> vvv     CID 1584245:  Null pointer dereferences  (FORWARD_NULL)
> vvv     Passing "con" to "ucsi_get_cable_identity", which dereferences null "con->cable".
> 1136     	ret = ucsi_get_cable_identity(con);
> 1137     	if (ret < 0)
> 1138     		return ret;
> 1139
> 1140     	ret = ucsi_register_plug(con);
> 1141     	if (ret < 0)
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):

This looks like a false positive to me. The code looks like this:

	if (con->cable)
		return 0;
	[ ... ]
	ret = ucsi_register_cable(con)
	if (ret < 0)
		return ret;
	ret = ucsi_get_cable_identity(con);
	[ ... ]

From the con->cable check coverity concludes that con->cable is
initially NULL. Later ucsi_register_cable() initializes con->cable
if successful. Coverity seems to miss this and still thinks that
con->cable is NULL. Then converity correctly notices that
ucsi_get_cable_identity() dereferences con->cable and complains.

     regards  Christian


