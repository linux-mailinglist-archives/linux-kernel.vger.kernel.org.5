Return-Path: <linux-kernel+bounces-49739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEA846ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DDC1C21A58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24D13D51C;
	Fri,  2 Feb 2024 11:20:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D560244;
	Fri,  2 Feb 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706872828; cv=none; b=sPm+CXi+cn3eRheQvZ5+fWjznSySFqXqv41XP89+40xVGIUoyZHg7Tk2tWggRVm/RMH7hC1yZboc/DGIeF4NVJz1oVTE+LRPM8qmUAVmFS+G7ASb9rw0/41krpTqni80ApFzKfzrI/tASzQXAZ45EeGg3ZNjZOEsmdXrd6/KLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706872828; c=relaxed/simple;
	bh=UgCZ0dCPok1yCgQUIpcSRxnDE9MtjJTQmgm/MixG4IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzECF7EVR10+sjv5MRkDDUdL+zPaHNmCIZgkDK3AD+yUPtjHHml/khk9sOudEVA8BydnANcJD+mJErqpqoQlVJ1t6is/3iVAp+TGJGPbk4o57c5bD6yJwUcJFXoCDWwYULnk/VmTNaigT4aFMsW3wpizQvGMhmARpc/5nqkLRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD9C433C7;
	Fri,  2 Feb 2024 11:20:23 +0000 (UTC)
Message-ID: <c37e9225-3890-4f4d-b45c-919b907b184b@xs4all.nl>
Date: Fri, 2 Feb 2024 12:20:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB property
Content-Language: en-US, nl
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Emma Anholt <emma@anholt.net>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Samuel Holland <samuel@sholland.org>, Sandy Huang <hjc@rock-chips.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-doc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 David Airlie <airlied@gmail.com>, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox> <874jerf7ot.fsf@intel.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <874jerf7ot.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 12:04, Jani Nikula wrote:
> On Mon, 15 Jan 2024, Sebastian Wick <sebastian.wick@redhat.com> wrote:
>> On Thu, Dec 07, 2023 at 04:49:31PM +0100, Maxime Ripard wrote:
>>> The i915 driver has a property to force the RGB range of an HDMI output.
>>> The vc4 driver then implemented the same property with the same
>>> semantics. KWin has support for it, and a PR for mutter is also there to
>>> support it.
>>>
>>> Both drivers implementing the same property with the same semantics,
>>> plus the userspace having support for it, is proof enough that it's
>>> pretty much a de-facto standard now and we can provide helpers for it.
>>>
>>> Let's plumb it into the newly created HDMI connector.
>>>
>>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> 
> [snip]
> 
>>> @@ -1655,6 +1678,26 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
>>>  /**
>>>   * DOC: HDMI connector properties
>>>   *
>>> + * Broadcast RGB
>>> + *      Indicates the RGB Quantization Range (Full vs Limited) used.
>>> + *      Infoframes will be generated according to that value.
>>> + *
>>> + *      The value of this property can be one of the following:
>>> + *
>>> + *      Automatic:
>>> + *              RGB Range is selected automatically based on the mode
>>> + *              according to the HDMI specifications.
>>> + *
>>> + *      Full:
>>> + *              Full RGB Range is forced.
>>> + *
>>> + *      Limited 16:235:
>>> + *              Limited RGB Range is forced. Unlike the name suggests,
>>> + *              this works for any number of bits-per-component.
>>> + *
>>> + *      Drivers can set up this property by calling
>>> + *      drm_connector_attach_broadcast_rgb_property().
>>> + *
>>
>> This is a good time to document this in more detail. There might be two
>> different things being affected:
>>
>> 1. The signalling (InfoFrame/SDP/...)
>> 2. The color pipeline processing
>>
>> All values of Broadcast RGB always affect the color pipeline processing
>> such that a full-range input to the CRTC is converted to either full- or
>> limited-range, depending on what the monitor is supposed to accept.
>>
>> When automatic is selected, does that mean that there is no signalling,
>> or that the signalling matches what the monitor is supposed to accept
>> according to the spec? Also, is this really HDMI specific?
> 
> Automatic is based on the mode as described in the specs
> below. Basically certain modes are expected to be broadcast range, and
> others full range.
> 
> I don't remember why we don't use the full range if the display
> indicates it supports selectable quantization range in Video
> Capabilities Data Block. It's quite possible there are displays that
> declare support but don't. Cc: Ville.

I have not seen such displays. Enabling RGB Selectable Quantization Range
is something that a vendor has to do explicitly, so it is reasonable to
expect that it works, otherwise there would be no point to that flag!

Transmitting full range if possible gives a better picture quality and
so is recommended.

> 
> - HDMI 1.4b section 6.6 Video Quantization Ranges
> 
> - HDMI 2.1 section 7.3 Video Quantization Ranges
> 
> - DP 2.1 (and earlier) section 5.1.1.1 Video Colorimetry
> 
> - CTA-861-H (and earlier) section 5.1 Default Encoding Parameters and
>   section 6.4.3 Quantization Range

Note that CTA-861-H deprecated the use of Default Range in the AVI
InfoFrame, instead the source should always signal limited or full range
in the Q field.

Regards,

	Hans

> 
>> When full or limited is selected and the monitor doesn't support the
>> signalling, what happens?
> 
> 1) Limited selected, display expects full, colors seem washed out.
> 
> 2) Full selected, display expects limited, black screen possible.
> 
> We receive the occasional bug report for 1, because there are displays
> that incorrectly expect full when spec says it should be limited. We
> reject the bug reports, because erring the other way can lead to black
> screens.
> 
> 
> BR,
> Jani.
> 
> 
> 


