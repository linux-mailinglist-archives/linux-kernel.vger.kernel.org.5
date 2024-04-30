Return-Path: <linux-kernel+bounces-163610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7DC8B6DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05031F2218C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEF6127E05;
	Tue, 30 Apr 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUuvWqDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D251E48B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467400; cv=none; b=kUS5vpVi2+M196IbVe7dLSo20tIVxt/7jaYdZxx1E2TY7iploIqdF8TVkV0RDohg1k1nkFOdlt/lJAiT22gUqTfljOhO+MyS/FSNCWLo5HU/M2vcxs2OhB5HfQ8/vt8M1BecuPn1ykwnIXBlVvU1EbJ9uhJc/VWCPYLvilADF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467400; c=relaxed/simple;
	bh=PYmpfRKkwqmwjNn4UB80si1wOG35F5XHToI+k0fkKc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0NCzZXsVZNbR2N+WMyfmIB+Tryvqwyc+3kxEvj+oAd7MY30Jgydco2nJKO+B/i1vlS9Jj6uFy+y7t6k15LHyduEcKSjgn25Cg3w7mIHEtynEORsmSiESoAjEPP/ukecQROIaZMYcaAEqXspCXw8nbzH4/DWssGlFpZiXKr65YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUuvWqDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B3FC4AF17;
	Tue, 30 Apr 2024 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714467399;
	bh=PYmpfRKkwqmwjNn4UB80si1wOG35F5XHToI+k0fkKc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUuvWqDalpf7i+2Zhv89nzS/lGYomW3hTjUz7IqHaX5LMM+05QT0U/5EcfCHLnP5y
	 y6uqxDxcDhtFNEqHNUSMxvXRmOOh2s33451h0QXnt1dVL5siuEzKzFZa1xD5vtta1v
	 hvp1CHvEVE4mV9xbwWg0cfPqCa1Ct4CVBQnEsd9U=
Date: Tue, 30 Apr 2024 10:56:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] slimbus: patches for v6.10
Message-ID: <2024043013-foil-pucker-4c7b@gregkh>
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>

On Tue, Apr 30, 2024 at 09:50:03AM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Here are few patches in slimbus for 6.10 that includes
> - fixing autoloading.
> - coverting driver remove to return void
> - some timeout fixes on wait operation.
> 
> Please note that, I have also included a fix at the start of this series
> rather than sending another email thread. I hope that is okay with you.
> 
> Can you please queue them up for 6.10

Shouldn't the first commit go to 6.9?  If so, why include it here?

thanks,

greg k-h

