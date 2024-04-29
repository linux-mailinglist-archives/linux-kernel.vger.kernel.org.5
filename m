Return-Path: <linux-kernel+bounces-161931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7208B5379
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F551281EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03AE17BDA;
	Mon, 29 Apr 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aRSrNF7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1EC2C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380784; cv=none; b=kLpSC9GynvjOAGtyMivcXKOms8sSA0kcSWXHGLPg8KmBozoCRA6g5P9fAuf+IJ52IIA3/ZM9a0tGY34WD9k46gjye+FigC0cJnmcyILLjF8OWux4j3ELKoKJ/IQxRy0pP9KS1MylO2D4a9kX+yOxyr/7omAuEe3GEO9eUiqeR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380784; c=relaxed/simple;
	bh=puIM811pM6hcNVR+yjquLTLcQcBJmvNY5HvyerQUtBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp7a/ff/niVTdE+3xEBkDrQCHJab5+Cjyy79/vSONRF0sc/il4JdUJPFsaUQLOzo3YzVTEpJGTvbdIIfN77+OCCDyXAtbVhKFU70MQr8u5Hl1KRfj3hXHRz6MJ804DtE+uPtpK+XISwawR8rSNIgQylas545CvyRG92gPbyDZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aRSrNF7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB32C113CD;
	Mon, 29 Apr 2024 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714380783;
	bh=puIM811pM6hcNVR+yjquLTLcQcBJmvNY5HvyerQUtBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRSrNF7IZyYT4dQiGkovFOAvma6j7CtvuUTXjpULiWyeuMcVL75OH/r2QEY2MiJLt
	 55+sLX1qPYLtSdaPbQC6iejpiBubNwJh9RJa/wm3+abpXp0e6MMBHJIAlPerSLXusu
	 yn5OMLRjqBWDO7DfCsBaQhNEjfZ5zPmnoFTtOX1Q=
Date: Mon, 29 Apr 2024 10:52:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] w1: drivers for v6.10
Message-ID: <2024042936-bash-blighted-48df@gregkh>
References: <20240425072330.10049-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425072330.10049-1-krzysztof.kozlowski@linaro.org>

On Thu, Apr 25, 2024 at 09:23:29AM +0200, Krzysztof Kozlowski wrote:
> Hi Greg,
> 
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.10

Pulled and pushed out, thanks.

greg k-h

