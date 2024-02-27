Return-Path: <linux-kernel+bounces-83391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5718697C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50671F2AA52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE281448D7;
	Tue, 27 Feb 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm9/YHG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8413B798;
	Tue, 27 Feb 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043885; cv=none; b=OWVq6hMQOV4pmAt2huOOO0oRR4XKOEk/OnqMXMunHM+0LsW/To0riYPj05jkR0ZMMrymodCpR89LoBXdLUnW0y1vRYdirxHU6yEuwlV6o1R6Md+8AkP8fGValaRVP0Zdgp+xJEuhUpZO/MwCvJAaOF38OeDTnsrbcgfA4qvvITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043885; c=relaxed/simple;
	bh=y5hECNS3lW8/P87KlOIBOFLlBqMFwb8pWysds1a84KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrJB2Q2nyNEMzGk/egMC0OwvvE6yW6293ZS4QC/MRtMEWAgAaGKi8pb2uNT9hRsUFxCUWVJcreGBH5Uelvsz9T4NDfVr2SEijTiPP9n9DhUvY0SrViKegcoogombDWBLO6Wv0FhoFfYBnz0pLNJU7mo++OmRGKkPcQWKhJK+iMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm9/YHG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B8C433C7;
	Tue, 27 Feb 2024 14:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709043884;
	bh=y5hECNS3lW8/P87KlOIBOFLlBqMFwb8pWysds1a84KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pm9/YHG6O2HDZ0A57Pt97CBOHlsFbQaPxF8FEqHjpkSuGre+5rjKvGzg++0+3YRI8
	 QZJTpaZ/UkFXGeIJio7C5iC1BkDTSWQ9L16LAdw3gIEBSv6mpWRgzn4l8qQm78jb+1
	 OeebeBnHKovuG8y8nKOrj7HfBXQmEvCJ01NNyRiQEM38qYV+XKiqdpRmG54g7yT5vB
	 vWzvY4b+M3RDGa6MvgKrIVcd0ThjE8bCn8SFPM1DrvHYyHmfsP/blMci+RO+ZrII+y
	 t4ftu+ERpB5LXLyUUBhX5+ryx619zmo/7itU9BDB/5ha1D5XQ26bIaamxjOL6b+Bpy
	 FkW8Os/vdXLag==
Date: Tue, 27 Feb 2024 08:24:40 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, airlied@gmail.com,
	akpm@linux-foundation.org, conor+dt@kernel.org, daniel@ffwll.ch,
	dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mripard@kernel.org, tzimmermann@suse.de, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com,
	ribalda@chromium.org
Subject: Re: [PATCH v2 8/9] media: dt-bindings: Add Intel Displayport RX IP
Message-ID: <20240227142440.GA3863852-robh@kernel.org>
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-9-panikiel@google.com>
 <13aeb2ff-72f4-49d9-b65e-ddc31569a936@linaro.org>
 <CAM5zL5q0oKoTMR0jSwYVAChCOJ9iKYPRFiU1vH4qDqhHALKz4w@mail.gmail.com>
 <e1fd8cbd-060b-4d15-8256-6d8dbba545da@linaro.org>
 <CAM5zL5qxBM1xQ__t86gxUKMy8O3BzoCe_vTFxxsqFq7mw4-8EQ@mail.gmail.com>
 <890afb05-1b19-47b2-bfd8-5f6de0caeda3@linaro.org>
 <CAM5zL5rs4JyFznnWDLZP_2jwnX+yc+OwwOijGZGsQK+WtpiWKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM5zL5rs4JyFznnWDLZP_2jwnX+yc+OwwOijGZGsQK+WtpiWKA@mail.gmail.com>

On Tue, Feb 27, 2024 at 02:11:27PM +0100, Paweł Anikiel wrote:
> On Mon, Feb 26, 2024 at 6:29 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 26/02/2024 13:43, Paweł Anikiel wrote:
> > >>>>> +  intel,max-stream-count:
> > >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> > >>>>> +    description: Max stream count configuration parameter
> > >>>>> +
> > >>>>> +  port:
> > >>>>> +    $ref: /schemas/graph.yaml#/properties/port
> > >>>>> +    description: SST main link
> > >>>>
> > >>>> I don't understand why you have both port and ports. Shouldn't this be
> > >>>> under ports?
> > >>>
> > >>> I put both so that you can use the shorter port property when the
> > >>> device only has one port (i.e. no MST support). It would work fine
> > >>> without it. If you think that's unnecessary, I can remove it (and use
> > >>> the ports property even if there is only one).
> > >>
> > >> No, it is fine, but then you need allOf: which will restrict to only one
> > >> of them: either port or ports.
> > >
> > > There already is an allOf below that says that ports is required for
> > > MST support and port is required otherwise. Isn't this enough?
> >
> > Add both port and ports and see if it is enough.
> 
> Ok, I see. I tried and this seems to work:
> 
> oneOf:
>   - required:
>       - port
>   - required:
>       - ports
> 
> And that would make the if/else with port and ports below not needed.
> What do you think?

Just always use 'ports' rather than complicate things.

Rob

