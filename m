Return-Path: <linux-kernel+bounces-48989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE184646C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602EA281C18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7847F57;
	Thu,  1 Feb 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmIuxBzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED4E47F41;
	Thu,  1 Feb 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830086; cv=none; b=AN3EX97xTvbstw5B9L+jmHT+OsG60FEdXL9u9bpuh9Mu37N9eEVYgr2m9GSn6OzQRUyA9kj9+WRkRdb8QawqOaXNmACg/+yp8HFjc2hN0OZG4zmqQtt3arBBSvg5AYyDdZ0fvCaOMKUAyJy8NFfM2/kI19DkN8Nz6LKd6Nmg7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830086; c=relaxed/simple;
	bh=payIiLg6forS04gjbDZWmNc0lv97aB/Ofx+IK/zqWkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDi/kPvOTmrxLY7Tq97netlFrawEgFy46oGLhcrhjqgBUD3TopLfgvF++3sgVYaQbgKIVF72Twdq8ZGE4D4OlpkVKmfn9eO8bwC9e4kelCvQPX4jNBgGFT/PJ6Fo1pcgXesrPjPY5s9EDg3H+0D288Vm3hLdMRtJPLLsoWumljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmIuxBzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5612EC433C7;
	Thu,  1 Feb 2024 23:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706830085;
	bh=payIiLg6forS04gjbDZWmNc0lv97aB/Ofx+IK/zqWkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmIuxBzXFfJXUsgjJHiKUMHSqs2oGZ7MYZ4z0exkCOS0neM+zfxX+Iu/VPnTWc5B+
	 puzE3QZ+G5iQn9+BmSUgonVnmgDr2qT7HQcUSAjzLgRRM26nOoNGMdSTV93B5ejHmI
	 Zi3n7yX8iWX1x6cUkD1afB0Y+95Aechn4NePLcbGWHI7PPigXLHriRkkEgbmisGPhI
	 HyOdQXlQy4xysoxWWmxwzyjmra70zEYyC9sSx62Izs7bGX4fDirCndntUI78Cbw8D6
	 XOorupF4qVV6WoSnmpNSLBsXBtzM4g5PlMcMsXs9kCEjD7jy46Gj/x2zp784nUzZA9
	 2DBL9vsjn3qDA==
Date: Thu, 1 Feb 2024 17:28:02 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz, 
	thierry.reding@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, agross@kernel.org, luca.weiss@fairphone.com, 
	konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com, 
	quic_gurus@quicinc.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: Re: [PATCH v8 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <kfs2nkkrwsa2enz67vfb5nenv2obzuomekqjdzaksldd75lows@3mcfd2r55fc3>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-4-quic_amelende@quicinc.com>
 <ut6jbawqqdgfyoxmt76hm67rbnv67x54eho3nae2dd2szbejfb@7joy57g4i3qt>
 <20240131085842.GF8551@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131085842.GF8551@google.com>

On Wed, Jan 31, 2024 at 08:58:42AM +0000, Lee Jones wrote:
> Intentional generic top-post reply.
> 
> Please work quickly to resolve Bjorn's comments.
> 
> I'm being hounded over a broken LEDs tree due to the missing headerfile.
> 

I've merged the updated patches into the qcom tree.

I presume though that you'd like to have this build issue resolved in
your tree as well. Please feel free to pull the branch:

20240201204421.16992-2-quic_amelende@quicinc.com (5b2dd77be1d85ac3a8be3749f5605bf0830e2998)

from https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git

Regards,
Bjorn

