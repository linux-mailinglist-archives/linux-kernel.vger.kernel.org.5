Return-Path: <linux-kernel+bounces-56438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6384CA27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9987F1F27DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED259B72;
	Wed,  7 Feb 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQNjylFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5359B61;
	Wed,  7 Feb 2024 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307443; cv=none; b=H49MXLRN6ecpVct2DyatqDhRWzuNUopdCsDSwqproZVq5yOGqzI3lbK9oyCcGF93kJq5ZqWdh0qZynRnsZHsS9os3FvbMh6rGn8Gvc1ncvu7p0WW1EhP96aJU1/R00vFGHJ6dpW5W+NoE0t1LtsxHGRvqA3EKyMT1FHlb/0Uqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307443; c=relaxed/simple;
	bh=QKftlHCvnz4PA0HyFRTffsRwC4M0FHR2Bt8ifsskhn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPaSoaXdEC2G6b4kqa2zWtMZodDQFnlyiip1KAyJw+w8W/n0syogyxVz+bbMDsVYPjdq+x3enM0wMriR8K/whPLnlU9PKLUIyR14uUWgiPOatqInTyFjP1+tznIAye1kGISmiEGGbklhL0X2a8qJgMy9DP5O3d4ZHJwosUmY9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQNjylFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C929C433F1;
	Wed,  7 Feb 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707307443;
	bh=QKftlHCvnz4PA0HyFRTffsRwC4M0FHR2Bt8ifsskhn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQNjylFEZqmw901m1hs3LiTkT1oSXiJzAO80rj+Je/5h03o1ZRrVaxiwdhtsr+yeh
	 lDtAbSzzFZ0YGy9e+EknuYChS9Recc2wVCAWIUvZI4edAnTrHi1acZv5RybxYhfcR9
	 9RI4ee09F1h3Pg+6eURw/fggXRrEMaCAz4o0jnSQDo5hduW6YCZDcnl0h0hdmuwRZK
	 pXN6fjjtE91sg1OFQmdLgFMFGUlLOwB3dYRVWlT01/jK01G3zh8RI7ymT3j9P3GM3G
	 str6fHBNf0uA8IG1qH5mCRcMqiwCuMVPIhIi8zz/yck0nsgb2m6Ncuz4VqOGoDAqs0
	 DVmIgfC7FkoFA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rXgex-000000003Qa-0ZuX;
	Wed, 07 Feb 2024 13:04:11 +0100
Date: Wed, 7 Feb 2024 13:04:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Steev Klimaszewski <steev@kali.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: correct analogue
 microphone route
Message-ID: <ZcNxuyRJdZCryHU_@hovoldconsulting.com>
References: <20240125154531.417098-1-krzysztof.kozlowski@linaro.org>
 <c34dd7ca-01b5-4424-a8ec-a525b8d722a3@linaro.org>
 <5497d428-cdc1-4057-afda-6861d2e3860a@linaro.org>
 <e9b6f790-831c-4df6-b16c-8d7a2f8ddc26@linaro.org>
 <CAKXuJqjDM3P4wOKz3CaAB9DUyemqQ6ks=FPnfL7OsHnnyoyn=A@mail.gmail.com>
 <ZcCX0hDGrWqRXr9R@hovoldconsulting.com>
 <c075f2f8-4fbf-4309-a478-a5cfb199fdd5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c075f2f8-4fbf-4309-a478-a5cfb199fdd5@linaro.org>

On Wed, Feb 07, 2024 at 11:05:02AM +0000, Srinivas Kandagatla wrote:
> On 05/02/2024 08:09, Johan Hovold wrote:
> > On Sun, Feb 04, 2024 at 11:30:54PM -0600, Steev Klimaszewski wrote:

> >> I somehow missed that patchset or conversation; As an owner of an
> >> X13s, which is sc8280xp, I can say, neither pre-dts patch, nor post,
> >> seem to do much good.  When I attempt to do a voice chat in armcord,
> >> the responses I get to how I sound when using the mic on the X13s
> >> itself range from "You sound like hot trash" to "You sound like a
> >> robot with hiccups".
> 
> does arecord exhibit same issue?

I only did a quick test by switching from pulseaudio to pipewire and
running parecord. Recording is corrupted (robot with hiccups), while it
works fine with pulseaudio proper.

You can also notice that something is off by looking at the pavucontrol
volume meters which were quite active.

> What is your setup looking like? I would like to reproduce this on my x13s.

I know that Steve is using pipewire (on Kali Linux I assume).

> > That's a separate issue entirely. Both the digital and analog microphone
> > (jack) is working on the X13s as long as you use pulseaudio.
> > 
> > As I've mentioned before, there are problems with both playback and
> > capture when you use pipewire however ("robot with hiccups" one could
> > indeed describe it as).

Johan

