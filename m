Return-Path: <linux-kernel+bounces-144539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE28A478C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F88E1C2130A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB656112;
	Mon, 15 Apr 2024 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mk1QQI/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97D1EB3F;
	Mon, 15 Apr 2024 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158554; cv=none; b=Gsyw5dVWungJTG9N76zu7XTac+OMVeMXp416UEUXQHR/cCuHeBnXUwPzY84ZrFeXopETwEk7NJSNOtODOIWMJQBowo+g4nK3DD/pZkJeQ9N/U815/Ibj4ZR4nmKsmV5xpkazKmslWc7xKpuTM8n+NZ7zNUfRVfHi33kmAkWA+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158554; c=relaxed/simple;
	bh=PeGrG5LrpGE9sy+795bOMZBxA+0vVQWDOIsJTQsO370=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gINv2SjEBd6b9177OLx4iinh13EDPrdBlokBGjkCDycLvyoWLhtYfbl6E/nb0c6EQE3QT8BA8zNuLXW0yv6dmt3DmkK6fSLsBDwpcArdguzvFUOHJaDhF9B1BD3oKGgXciNMHy7I+W20KhPIVNbJtHLGgL2ZQjxKVebo7ivzty4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mk1QQI/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314CBC113CC;
	Mon, 15 Apr 2024 05:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713158553;
	bh=PeGrG5LrpGE9sy+795bOMZBxA+0vVQWDOIsJTQsO370=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mk1QQI/aIZLeB+rprpwjIH3mIm4YAiY8Ze2FqlMtyPs7hy6zcG3KdzixlxEau9cfX
	 Zehx+g9Uiunqba46VoMx+MrtH497ejIU6En2wy/F6YARU1CXcKOl47Y7tsJwJNjcOh
	 DSVikfsQiqwd2b6RLIXbP1HJaUzXk7Yduf37BHTY=
Date: Mon, 15 Apr 2024 07:22:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Elder <elder@linaro.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <2024041510-tacky-childlike-fc6d@gregkh>
References: <20240414170850.148122-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414170850.148122-1-elder@linaro.org>

On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
> Several times recently Greg KH has admonished that variants of WARN()
> should not be used, because when the panic_on_warn kernel option is set,
> their use can lead to a panic. His reasoning was that the majority of
> Linux instances (including Android and cloud systems) run with this option
> enabled. And therefore a condition leading to a warning will frequently
> cause an undesirable panic.
> 
> The "coding-style.rst" document says not to worry about this kernel
> option.  Update it to provide a more nuanced explanation.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Thanks for writing this up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

