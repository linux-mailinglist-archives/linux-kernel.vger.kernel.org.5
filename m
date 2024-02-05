Return-Path: <linux-kernel+bounces-52187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C7E849519
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31106B20DA6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A6111AE;
	Mon,  5 Feb 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTiLfbGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DA11185;
	Mon,  5 Feb 2024 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120590; cv=none; b=r9FAy7cf6a1hltxMuCtYDzDeorDu6IS6aLpVWYygdqMTaBMIO3I+dEpCA4dnq9E29vyhvXkLvYuZlCeJuUEu+NOURD2X2rvfWw54sN7CZ8HSN0jahqFSbMcz3neojoO6jSFbewvesYwyXxl22GCq5L+LUGmeckuWjBxseD9Osko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120590; c=relaxed/simple;
	bh=tjnc9TCmrK1oUMDhylwqt1frva0l2latksdf20OLonI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwnpcobIKXrytyhdeyBeSksnNpeTsm6fgiCWmGnzLw2mYJJPCg1RqBQsB/AurewtIQ7Pp5ZC3dy6CuT6D92ZiFeg4AWm/CEXQJlJ9VgjrOTkiXmhVicLzBjJWu+wQZ4HgtjCSflzZysMy5p2R1dk6BBYEqy+MokYhULDRZaDWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTiLfbGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ECAC433C7;
	Mon,  5 Feb 2024 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707120590;
	bh=tjnc9TCmrK1oUMDhylwqt1frva0l2latksdf20OLonI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTiLfbGJRMd1+e0OKid4AWN6lQY8CEaTyYUIznZQoQ/HwaI7A7XJEM/UCkwSljBGe
	 GJZPHPVCVSep1ftzfS43KB32fr3Y8bhTqOS/GZbBEtOKsj6oP1QZLr6duyWXbfu+m+
	 6L7TZ8rLMU7gkilZZPK87QTu2YNqMJ1t0g9Su5bDfXYpPdux2warMTCkKQyMFwdMpQ
	 iVc+FV69wwiCLUbpXfl3RacrD44tFfD4/SSelZ944Iy0yaiL63wEooW5R7F1AarK28
	 X4fZoZbpek3tZWnrJIlfFdS5A6fcrSmRbAVzVZ1pOghwRPrx7TfyVDG1pK4gz/W3tj
	 CC3IJSIMrlEKA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rWu38-000000000W5-0y2L;
	Mon, 05 Feb 2024 09:09:54 +0100
Date: Mon, 5 Feb 2024 09:09:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Steev Klimaszewski <steev@kali.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: correct analogue
 microphone route
Message-ID: <ZcCX0hDGrWqRXr9R@hovoldconsulting.com>
References: <20240125154531.417098-1-krzysztof.kozlowski@linaro.org>
 <c34dd7ca-01b5-4424-a8ec-a525b8d722a3@linaro.org>
 <5497d428-cdc1-4057-afda-6861d2e3860a@linaro.org>
 <e9b6f790-831c-4df6-b16c-8d7a2f8ddc26@linaro.org>
 <CAKXuJqjDM3P4wOKz3CaAB9DUyemqQ6ks=FPnfL7OsHnnyoyn=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXuJqjDM3P4wOKz3CaAB9DUyemqQ6ks=FPnfL7OsHnnyoyn=A@mail.gmail.com>

On Sun, Feb 04, 2024 at 11:30:54PM -0600, Steev Klimaszewski wrote:
> On Mon, Jan 29, 2024 at 8:27 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:

> > so I will go with that approach. Please ignore this DTS patch. I will
> > send ASoC changes which won't affect sc8280xp.

> I somehow missed that patchset or conversation; As an owner of an
> X13s, which is sc8280xp, I can say, neither pre-dts patch, nor post,
> seem to do much good.  When I attempt to do a voice chat in armcord,
> the responses I get to how I sound when using the mic on the X13s
> itself range from "You sound like hot trash" to "You sound like a
> robot with hiccups".

That's a separate issue entirely. Both the digital and analog microphone
(jack) is working on the X13s as long as you use pulseaudio.

As I've mentioned before, there are problems with both playback and
capture when you use pipewire however ("robot with hiccups" one could
indeed describe it as).

That suggests a more general problem with the Qualcomm audio drivers,
but that has nothing to do with the audio routing.

Johan

