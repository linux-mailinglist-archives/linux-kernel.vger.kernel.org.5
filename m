Return-Path: <linux-kernel+bounces-111675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF6886F67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B8D1F22F50
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594EC4DA05;
	Fri, 22 Mar 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrUQqLM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0547F7A;
	Fri, 22 Mar 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119927; cv=none; b=Tzha40nXfJU3IkOnmy4tRlOzNTKsZyXK5qgXVA/YT30G9pYxbjUllEwXBwU3B0XyyXly8sumLZ4HlQhJTMbSB0BasJu8F7lHPGFywkXhfyWn6ZgkKcIHirH1GBHlYAelqjDFLtkiAJ4ilY2wHCFyGydZHwJV1QF4kHSfQORSH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119927; c=relaxed/simple;
	bh=hOaLhxPz7fVCaMThTMnaFGE2tZ45awgUPoVTCtWs6g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN2h5nbMzGBHa1z7Tl7wbWsd5qwhFzuATO+3+UUAA22GQi30iTGG6u6kIj0uYdRioO7+S2O54xXwngGQco0gwn9Yj525G0LKKfzkBSdX827ELq00o0/nbHRIjj3e5XfBCDYZvjbMPp9Cf5wbZiJGEoGIIfZH9w6ZfMatcKpL7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrUQqLM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EA3C433F1;
	Fri, 22 Mar 2024 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119927;
	bh=hOaLhxPz7fVCaMThTMnaFGE2tZ45awgUPoVTCtWs6g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrUQqLM6Wd72xhvdojCAxLcOUHzbjowfK9Q6V1DZNjleYaL8dnybvK4evpAFX8mQ7
	 s35JIOjXpZKZxD6UIuLwB18IFHLym8ASvgFeqxKBkdJGF/vS+FdsEx7fr/4rx5Sq5c
	 fDFDRnwivnaAyIFlJLQ9epuq8LCbJQ47U+b2zkd3AsG4gRfdLcYcDUuNSfJKIVnHmG
	 E7FAoiwQzCOApDNsBLcevzwjOfOCQrqBQ+hPv4oaAHUhPfhOeDuMqzKizMwsWFwD7e
	 0GghMSDTDvqvrgKgskldunwWSpG/JvRoXgW0aSFgz5mUJHahSx1okZQqYrK0ab4mFf
	 GygPI/q09zzmg==
Date: Fri, 22 Mar 2024 10:05:24 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to
 dtschema
Message-ID: <20240322150524.GA895852-robh@kernel.org>
References: <20240321180617.35390-1-five231003@gmail.com>
 <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
 <CAN19-EfCOWFqFCrF0iCaxhfZuteWawQoH0d6pTN3cgQ7p-CK6w@mail.gmail.com>
 <5dd3237f-e0a2-4214-a63f-233e89a26b8d@linaro.org>
 <6552bcb8-e046-4882-91da-1094fff3d239@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6552bcb8-e046-4882-91da-1094fff3d239@linaro.org>

On Fri, Mar 22, 2024 at 07:49:57AM +0100, Krzysztof Kozlowski wrote:
> On 22/03/2024 07:34, Krzysztof Kozlowski wrote:
> > On 22/03/2024 07:23, Kousik Sanagavarapu wrote:
> >> On Fri, 22 Mar 2024, 11:33 Krzysztof Kozlowski, <
> >> krzysztof.kozlowski@linaro.org> wrote:
> >>
> >>> On 21/03/2024 19:02, Kousik Sanagavarapu wrote:
> >>>
> >>>> +  spi-max-frequency:
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>
> >>> No, drop. From which other SPI binding did you take it? I asked you to
> >>> look at existing code.
> >>>
> >>
> >> Without this, "make dt_binding_check" would break though, right at the
> >> position in the example where "spi-max-frequency" is used.  That was
> >> also the reason why additionalProperties was set to true in the last
> >> iteration, but after reading the doc more carefully I realized that was
> >> wrong after you pointed it out.
> >>
> >> I followed along bindings/spi/nvidia,tegra114-spi.yaml.
> > 
> > OK, you are right, the property is used here in controller node, however
> > Linux driver never parsed it. It was never used, so I propose to drop it
> > from the binding and example. You can mention in commit msg that
> > spi-max-frequency was not documented thus you drop it from the example.
> > 
> > DTS should be fixed as well. I'll send a patch for it.
> 
> Cc Daniel,
> 
> BTW, J2 core is rather odd platform to work on... Even cross compiling
> and building that DTB is tricky. If I failed, I have doubts that you
> tested the DTS with your binding.
> 
> This applies to all GSoC or some Linux Mentorship programs: I suggest to
> choose for conversion bindings with more users and bigger possible
> impact. So first I would look at ARM64 and ARMv7 platforms. We still
> have around 1000 and 3500 unique warnings about undocumented compatibles
> for ARM64 defconfig and ARM multi_v7! That's the platforms you should
> choose.
> 
> Not SuperH, ARC, or whatever with only one DTS which is difficult to
> build for regular developer.

To add to this, either ask DT maintainers what would be useful to work 
on or you can look here[1][2] to see what are the top occurring 
undocumented (by schema) compatibles.

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs/6453674734
[2] https://gitlab.com/robherring/linux-dt/-/jobs/6453674732

