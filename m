Return-Path: <linux-kernel+bounces-149100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D339D8A8BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8934B1F223E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723123765;
	Wed, 17 Apr 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxdLUCvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F29FBF3;
	Wed, 17 Apr 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380633; cv=none; b=hGvU5we0tqBDbBrRo1ET8NVGZ4IaarKl3gYj4pI76cvZDDJn1Fvf2NAlhyxntD2L6AAFK76EY7PkbhJKoBH1YxM6aEc0pS0LoQRfKS8Udnk3PgIeSYvT9dG64C3YDEp3XLo3zYdpyELr+6A5T5W4CNDsMTvUaEW7nVriz9dGjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380633; c=relaxed/simple;
	bh=fOExnMUWA9yWNtR3dzAzpqSXNYc99h+TZZxGHtgxej0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxNlbbAc7xbHjspMfa2a7m1iPkYf7wnQMt7p/bz7/iaxUEOdr7rGPwPT83kRwpZUI177WZ69QwdmDBLV4XBOZ5FeV/EEIbtqWRevjqXjgIFbeB6emt2iS8CwM0UOY8gHlif8MPqSOUNUpHG9IldZ+noaevuwFZKgZTgxXA6V6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxdLUCvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C639C072AA;
	Wed, 17 Apr 2024 19:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713380632;
	bh=fOExnMUWA9yWNtR3dzAzpqSXNYc99h+TZZxGHtgxej0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxdLUCvERRLMmsOLKS7SYmx3HFhefOqFlcYiYDmcZ0Wd30QYgHUoy0OxKh9PAmLZv
	 q7Y3NtGI5d4Up7mMx2XlLHtbh7bZGxqV3pZrjFIKUn0KILL2jgkJv7Ez84gi++WMnZ
	 LJ5B6bi8K1cQUi138qJxi2SGAZh/D55wTOs7HByMlOSD7oBwrtJY9tTBXYFpxFqTI4
	 qTLI4wlqaUG+p5tDzsdJXVb34KTKxp9NulhkZ7c5eNLm7XO56PVee4oTCg5wiQejAm
	 FfDsw8ZQf40QUAJ12PKzIYxZsd8Fik71tZX/D4HobQDC1/YuyE2LT9Q7J67W0t5PpZ
	 g1aJOMW1BRDYA==
Date: Wed, 17 Apr 2024 14:03:50 -0500
From: Rob Herring <robh@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: andersson@kernel.org, benwolsieffer@gmail.com, chris.chapuis@gmail.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org, krzk+dt@kernel.org,
	linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom,pmic-mpp: add support
 for PM8901
Message-ID: <20240417190350.GA3093592-robh@kernel.org>
References: <20240415141743.1983350-1-github.com@herrie.org>
 <20240417073532.3718510-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417073532.3718510-1-github.com@herrie.org>

On Wed, Apr 17, 2024 at 09:35:32AM +0200, Herman van Hazendonk wrote:
> The PM8901 is used alongside the APQ8060/MSM8660 on the APQ8060 Dragonboard
> and HP TouchPad. It works the same as all others, so just add the
> compatible string for this variant.

Please slow down the pace of your reposting giving people time to 
respond. People work in different timezones, get busy with their own 
stuff, travel to conferences, etc. As you see here, Linus fixed it up 
and there was no need to even post a new version.

Also, don't send new versions as replies to the prior version. Start a 
new thread.

Rob

