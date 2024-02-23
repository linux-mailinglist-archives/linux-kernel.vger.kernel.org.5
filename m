Return-Path: <linux-kernel+bounces-77827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC61860AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A16284CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E029125B1;
	Fri, 23 Feb 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="09kdwX+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD1101E3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708669294; cv=none; b=RywE2kRdDib6EyYKMSBgEpCuyj8JckrVaObRvRfQhYJEpjr9JD5vQc5/ZM892LULaoyMx+baF1YJExpq8ewoues6m8Cfw7MVDXZ0X1KOuflcJ/WuYrkdccgCyCqt/MuMOrn1eDzDE6A90I574wO9ZtGRB+6Odt/V/IQfSzqTPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708669294; c=relaxed/simple;
	bh=Kk71Xc6aQZAepgitd/gSaBSUEua0dFghiazSD1VRBzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5z1nYfJqHPsEsbadlclprzW2QeN8t844p0KppvmDr3CMECCeeNmI/kdzmu3EgeX+tF+DJK7Aj5SW3Xr5JmoYT09MUnpVVYO+9OsqAOGAbbSMz1w0O8ItxRfYPHN483am7TiJLozMCsRaZCJPpXOdbHOjyXK1jkdwIsq2iPhdR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=09kdwX+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBBCC433C7;
	Fri, 23 Feb 2024 06:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708669294;
	bh=Kk71Xc6aQZAepgitd/gSaBSUEua0dFghiazSD1VRBzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=09kdwX+37u84gBVyVycXYovSsiL0Q31hEFzmfxVk8MoT9sm4sL9Ba6x33U80qiDRY
	 jKV0Yu7qSCAPNGwekVMaM6gWNeiAb/wni4RPHXPZ//VKxmLeLsYvdwra01KbujyPPT
	 KUBZJPtzzsZlyzM6YANpVxwCMhNFelsn8ZLcuCBo=
Date: Fri, 23 Feb 2024 07:21:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Message-ID: <2024022347-ribcage-clench-37c4@gregkh>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222180033.23775-4-quic_mojha@quicinc.com>

On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
> Rename firmware_request_platform() to request_firmware_platform()
> to be more concrete and align with the name of other request
> firmware family functions.

Sorry, but no, it should be "noun_verb" for public functions.

Yes, we mess this up a lot, but keeping the namespace this way works out
better for global symbols, so "firmware_*" is best please.

thanks,

greg k-h

