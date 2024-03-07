Return-Path: <linux-kernel+bounces-96182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8987582F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5220B24219
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11751386B3;
	Thu,  7 Mar 2024 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VtNJC9GQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDC130E35
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842941; cv=none; b=FxYD5YOB+d9aDeAdZdvwg7oik+QudU/DYv2fLTPWzrkvH+A1J2MScLgi6bNMhep0/oiun/xeVAyLdujKw22A15zVtgsKWviLAzV1ajqrDRJ17wJtOmmGhNHvyXT5a/b3KB2KUwQcbkSgZYn6+dDyEq2Xtx49LCY64C4q8oUChz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842941; c=relaxed/simple;
	bh=cylp0CM1hDfJ/ThVVxDLMeMzgh0QXgkgMiDLquSPO0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXTONVVqjbRRdMgCWonN2JHSaUXPOcOEKCmBZImgn85DvAZL6nMV404A7Ubz91g34tglg+Mxymzkoy7OilbXc65D8pHr+ZOdOACbTPAGSOVUD5AVeNaHxyXW07qvXqGxAj4rxPZmu1uGxGsbLBLriDwN/BNtEpahYEkrfuB0MyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VtNJC9GQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B558C433F1;
	Thu,  7 Mar 2024 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709842940;
	bh=cylp0CM1hDfJ/ThVVxDLMeMzgh0QXgkgMiDLquSPO0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtNJC9GQa9ZT0ewJk+c5VPM+fJl8fn0YqzA7Z79mjTxiCUhcgcf9UNjxcCeWhJ0Eg
	 CjlCE2PxaD6CMUiTkEkDRzK4VWvfjNjzbMauuDf9HTHkY7uo/Ic9Pbksdc0ED+IJTy
	 L6GEFIRyYHGGRd6CvMwk6oPjXFMPwxGzN9gB0iXg=
Date: Thu, 7 Mar 2024 20:22:18 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] nvmem: fixes for v6.8
Message-ID: <2024030702-eggshell-impending-f817@gregkh>
References: <20240224114023.85535-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224114023.85535-1-srinivas.kandagatla@linaro.org>

On Sat, Feb 24, 2024 at 11:40:22AM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Here are one fix in nvmem for 6.8, Could you queue
> these for next possible rc.

Sorry, I got to these too late for 6.8, I've queued them up for -rc1

greg k-h

