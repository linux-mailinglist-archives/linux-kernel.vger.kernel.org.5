Return-Path: <linux-kernel+bounces-66368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C3855BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6831F2880F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0C1078B;
	Thu, 15 Feb 2024 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKYv8CDc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF239DDAE;
	Thu, 15 Feb 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982679; cv=none; b=N/t0P0+AOmf/4g16WXpNrFXl8ioQh3oI0qsW2akgCax/UvJmMoXCnd9Gki6PMfhZjxnBFWWnXHIH7qucIxmCzir7etpdAWh1GZXz56FXti5onycHsoLuTvuSGtrhc9AVW77e4a/akx+206rxyA4cCFb1UnodKYNIUKGv1nIfkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982679; c=relaxed/simple;
	bh=m56EgYE9aTH5bwqtaWRmlBM91krkH7JiWCqkxNH8zHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5VebZyjjNUOvheZ6l9pMjBZoo1asU6AiBm5FrVNxbJP7YSMW5G360GGzSqpLqY47CLB32EXcJSSD9wUOFB1pwY38dLoz0azi7dyVnfEEhOQ38Zcsgq+KLkmniRiDAEzzNLafx7UyPvlCwmxtLE+9yKs3dstmh/bH4s920Xvplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKYv8CDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06892C433C7;
	Thu, 15 Feb 2024 07:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707982678;
	bh=m56EgYE9aTH5bwqtaWRmlBM91krkH7JiWCqkxNH8zHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cKYv8CDcKjum5/gKIM01h9SIJu8ikhRsqlFDRytMTj2vC/iuC4AzkGtftPwzhxaKF
	 aol/2APaDtW4bCExipwsht3dNAlT2Si3z5zKZ049/rF+KZyB5TPyJbfc7NYNUOD4mq
	 PmZb91nTd8TVt/ZRMMuOjswTbP6aKkNezgVyyDd9uZf5o0o4crWv7zuTEZIAgntMLp
	 iuC9sZlJ/2geLm6f1DLYQig4oW9ByBaHjykoO9SC/AFJaiGgNU7qomVu+GY/d3OUDs
	 KadhGsjoknJeVy5GVfq8XUaovG2Uz5UvPOq+TDSPwYZn0F3hA9RIxMdqen4U1zqbat
	 0PP1zDOQuFjDQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1raWK3-000000002IB-1FkX;
	Thu, 15 Feb 2024 08:38:19 +0100
Date: Thu, 15 Feb 2024 08:38:19 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFT v2 0/3] Fix up SC8280XP idle states
Message-ID: <Zc2_a9_w1Val6Lz4@hovoldconsulting.com>
References: <20230619-topic-sc8280xp-idle-v2-0-cde50bf02f3c@linaro.org>
 <k7v2qov3m43q7vniqu3w6q64277ea5mf7gvt6fzgj4e3a5uagt@fcsmuu24cfqr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k7v2qov3m43q7vniqu3w6q64277ea5mf7gvt6fzgj4e3a5uagt@fcsmuu24cfqr>

On Tue, Feb 13, 2024 at 11:35:06PM -0600, Bjorn Andersson wrote:
> On Wed, Dec 20, 2023 at 11:12:53PM +0100, Konrad Dybcio wrote:
> > Comparing the data available in the downstream sources with what's there
> > upstream, it was easy to spot some differences. This series aligns what
> > we have upstream with what is there on the vendor kernel.
> > 
> > The big asterisk there is that the downstream sources for SC8280XP can't
> > always be trusted. A simple test shows that the lower idle states that
> > were previously missing are implemented in the firmware (Linux reports no
> > errors and enters them).
> > 
> > HOWEVER
> > 
> > The only cluster idle state that's been present until now (the deepest
> > one) is now barely used if at all, as the scheduler seems to deem it
> > inefficient or so.
> > 
> > Hence, a request for testing and comments, especially from those who
> > use the X13s daily or have reliable setup to measure the power usage.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> What did we conclude on this one? Does the extra state make sense?
> The last patch looks useful...

I asked Konrad a while back to provide some performance numbers to
accompany this change.

I think he said that this series made no difference in either direction,
but IIUC that only after a really quick attempt at evaluating the
impact during a meeting we had.

Johan

