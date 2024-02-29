Return-Path: <linux-kernel+bounces-86149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA386C06D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A5C284893
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB23C062;
	Thu, 29 Feb 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+6Lwhft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77443FB81;
	Thu, 29 Feb 2024 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185950; cv=none; b=pY0GK+SUGHjUQD4rBRvnPU7eyP2XNPfYBMei75jHG1y/jd4rEnLtxVtJpdPHhqCDdFEsypnsIGBwnIY5q294Xg2ZXbve6gkWFbCjyoQik0NxFx8rgWAXsQH1kSvmepUvRtewL2hpLlCGBw+o1m+ConZwkZeFyRxYcZ92dwW1JnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185950; c=relaxed/simple;
	bh=ClWBYfdOHZndAjih59+049MxeygzaZ/Q0HJGSyqUcmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLSYksvOnlCmCZXh+5FP+mANOCGUQSoJS7jEKh7j/x8c5yBuOSn6dfDmfGTxcpvwtKm/ZsNqDkbHIRfDmen/T2YS0Duer3tSCM7WqlFrrrAtZDSQB+6ShXgEcdMVdape4UsrCC1TbBse1Nn6jKGPmxwpDKZra5NdpldlV2rjUok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+6Lwhft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD08BC433F1;
	Thu, 29 Feb 2024 05:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709185949;
	bh=ClWBYfdOHZndAjih59+049MxeygzaZ/Q0HJGSyqUcmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+6LwhftCApccpVbIMe9dTDkJt+Ep1DHq10zu5cdn6VnAQewg9B6hBXdRO168wnVF
	 dR2Tre0Elw0Kd9p3tJgaMCTS8OqT63sTUkpwipbAAhcTlPiIPgu+v2oRxFPWu/ituM
	 1IFG7U2MlGqv8FB8CBwkDCMwKfzpz6OxnZsrb6uM=
Date: Thu, 29 Feb 2024 06:52:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	pmalani@chromium.org, bleung@google.com,
	abhishekpandit@chromium.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
	hdegoede@redhat.com, neil.armstrong@linaro.org,
	rajaram.regupathy@intel.com, saranya.gopal@intel.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
Message-ID: <2024022923-disloyal-tactless-09ca@gregkh>
References: <20240229015221.3668955-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229015221.3668955-1-jthies@google.com>

On Thu, Feb 29, 2024 at 01:52:21AM +0000, Jameson Thies wrote:
> Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
> plug type and updating the modal support macro for consistent naming.
> 
> Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
> Cc: stable@vger.kernel.org
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
> Changes in v3:
> - Fixed CC stable.

I see two different copies of this patch on the list, which one is
correct?

And none of them are properly "threaded", so that our tools can't pick
them up at once, can you use 'git send-email' to do this, or do replies
by hand if you aren't using it, so that things will work properly on our
end?  Right now all of these look like individual changes :(

thanks,

greg k-h

