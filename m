Return-Path: <linux-kernel+bounces-49964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3602847221
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927631F2A9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FE14532B;
	Fri,  2 Feb 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tNmsLPyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D79144609;
	Fri,  2 Feb 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884998; cv=none; b=dl1fNhdLCchcYk5PWXMgkUn4OIDrKrf4Kj1fZF+chaNbw2i+HFqrDwNkB2lzHhep/KWi2XEkDF5ygtCzTtwhlCpvRyxfa7TfUjA7RHYxburfspwR/n41mz+BcpINPAjFIcuiSq4BXTfWlYnjfIPRhjfYe3MCuseHq3jb43O5kPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884998; c=relaxed/simple;
	bh=UL5MG5trZVklc1V3Dn8smqd1itLHkJW/M2Z7+NrLxcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od6qYPd1eUPWqz+gWozfNwTvK4sv0s5u0JZJw82POFFqiAfLw4PGFlcvE79XXEHr32Oy/+gsB2d8qDR54cA9L6eYgbdqMp3tEe6jUvsXwxpc0Pv75lrwQxRGz847w6qRPnXOfX9wXZx0FOcYljpRF96CDMHyuf38AEn3VcqrwCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tNmsLPyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A113FC433C7;
	Fri,  2 Feb 2024 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706884997;
	bh=UL5MG5trZVklc1V3Dn8smqd1itLHkJW/M2Z7+NrLxcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNmsLPyVrl8w3Tpd/N8duozKEd0SxyDvKNGhYlj1dM2ZkftZiDrVu9ll6PMLtIIMM
	 tHhwEQumQMqva72a+OqeTTwp85miCji40r10lccNppZJDxCuj1YgX6LfC9euqhnLMj
	 msPR16aQTr7UzsyjQlDpd+cOY+X0mmNelAuuJirM=
Date: Fri, 2 Feb 2024 06:43:16 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/16] misc: fastrpc: Add support for unsigned PD
Message-ID: <2024020248-improving-algorithm-a5f0@gregkh>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
 <20240202064039.15505-3-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202064039.15505-3-quic_ekangupt@quicinc.com>

On Fri, Feb 02, 2024 at 12:10:25PM +0530, Ekansh Gupta wrote:
> Unsigned PD requires more initial memory to spawn.

What exactly is "Unsigned PD"?

And where are all of the userspace changes for this series so we can
verify they work properly?

thanks,

greg k-h

