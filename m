Return-Path: <linux-kernel+bounces-117420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE388AB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187B01FA1567
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03256145FE0;
	Mon, 25 Mar 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcMSEvh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F410A39;
	Mon, 25 Mar 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382215; cv=none; b=GEkFybPFAN7z8NzgKwc0TjknBtg1/S46b384KysaXyxgCgU7IM2TESLNFCTakrFvZYvpk0nsZt03tPoCcTHy07V3i6eBQo3w/dgrEpus0JFHPAV03paOtcwO3a1yoK1hMqDopH2dQE7pgcLqmnZMuv4yDwmGmokFd+5pWyg9dCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382215; c=relaxed/simple;
	bh=ENDQ/e0q9PX0Cu5M/o6hx0CVqmsSUPAKQYjWkmXdgyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtgxd6rn0QqJJ1PeEZUGHhmqZhpeLJ4BFmQ/CcXdegMYu+RLKawrC/EBdl6SdEvH9+QwkZb4Os63rp9LeOcAoG+zac8gxHAY7gYYXpwaq2ZK8wyB6VugkLbqrOM/VcGbfM74lE6C0hv7ewBdbNNqEXiMKNaAwEvY5J5lsdXvLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcMSEvh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA093C433F1;
	Mon, 25 Mar 2024 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711382214;
	bh=ENDQ/e0q9PX0Cu5M/o6hx0CVqmsSUPAKQYjWkmXdgyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcMSEvh6wLv5drqay/oxDcZ+vzz+1GCw0Q3n4gWaHMwTKnsG0cUZ7/bI90q2vE/av
	 p6cyw0zqXIV8fzMYtCHudpFRcopl/3WeDp8449JCw0LyP4DDpUy+/6dKmmzjI5e5jU
	 Rdb3Wfo4NUf2VlmA9ciXYrRiHD+XlGaO9gLIpmV1FHo1gjva2Mz9fgF9KlyJZldN2f
	 bSeq6FJVHYQKzuzDjpdtwb5qpAz+3zk/FhfnE3aZfGtXEhXA6IhBs0mZeaReyf9tHN
	 6Ah7u0ksUVa+bzjSh5W6J3JO+LgU5innpV3/nBvqhIleCJjNxWroSNsMZISKuD8g//
	 aFDT4lVjwF9BQ==
Date: Mon, 25 Mar 2024 16:56:49 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>, Lee Jones <lee@kernel.org>, 
	jikos@kernel.org, linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-input@vger.kernel.org, ojeda@kernel.org, 
	linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Gregor Riepl <onitake@gmail.com>
Subject: Re: In kernel virtual HID devices (was Future handling of complex
 RGB devices on Linux v3)
Message-ID: <siebkhaauocqkuox73q2e5p2mbsyc7j4gvpzfvt4c3gvncdpap@oxh5pp4gxpuo>
References: <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
 <adbfdf6c-fb59-4fae-a472-17b04dd8a3f6@tuxedocomputers.com>
 <1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com>
 <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aec1d22d-9e59-4dfc-b108-5ba339b0e76a@redhat.com>

On Mar 25 2024, Hans de Goede wrote:
> +Cc: Bentiss, Jiri
> 
> Hi Werner,
> 
> On 3/20/24 12:16 PM, Werner Sembach wrote:
> > Hi Hans and the others,
> > 
> > Am 22.02.24 um 14:14 schrieb Werner Sembach:
> >> Hi,
> >>
> >> Thanks everyone for the exhaustive feedback. And at least this thread is a good comprehesive reference for the future ^^.
> >>
> >> To recap the hopefully final UAPI for complex RGB lighting devices:
> >>
> >> - By default there is a singular /sys/class/leds/* entry that treats the device as if it was a single zone RGB keyboard backlight with no special effects.
> >>
> >> - There is an accompanying misc device with the sysfs attributes "name", "device_type",  "firmware_version_string", "serial_number" for device identification and "use_leds_uapi" that defaults to 1.
> >>
> >>     - If set to 0 the /sys/class/leds/* entry disappears. The driver should keep the last state the backlight was in active if possible.
> >>
> >>     - If set 1 it appears again. The driver should bring it back to a static 1 zone setting while avoiding flicker if possible.
> >>
> >> - If the device is not controllable by for example hidraw, the misc device might also implement additional ioctls or sysfs attributes to allow a more complex low level control for the keyboard backlight. This is will be a highly vendor specific UAPI.
> > So in the OpenRGB issue thread https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/dynamic-lighting-devices aka HID LampArray was mentioned. I did dismiss it because I thought that is only relevant for firmware, but I now stumbled upon the Virtual HID Framework (VHF) https://learn.microsoft.com/en-us/windows-hardware/drivers/hid/virtual-hid-framework--vhf- and now I wonder if an equivalent exists for Linux? A quick search did not yield any results for me.
> 
> Oh, interesting. I did not know about the HID LampArray API.
> 
> About your question about virtual HID devices, there is uHID,
> but as the name suggests this allows userspace to emulate a HID
> device.
> 
> In your case you want to do the emulation in kernel so that you
> can translate the proprietary WMI calls to something HID LampArray
> compatible.
> 
> I guess you could do this by defining your own HID transport driver,
> like how e.g. the i2c-hid code defines 1 i2c-hid parent + 1 HID
> "client" for each device which talks HID over i2c in the machine.
> 
> Bentiss, Jiri, do you have any input on this. Would something like
> that be acceptable to you (just based on the concept at least) ?

I just read the thread, and I think I now understand a little bit what
this request is :)

IMO working with the HID LampArray is the way forward. So I would
suggest to convert any non-HID RGB "LED display" that we are talking
about as a HID LampArray device through `hid_allocate_device()` in the
kernel. Basically what you are suggesting Hans. It's just that you don't
need a formal transport layer, just a child device that happens to be
HID.

The next question IMO is: do we want the kernel to handle such
machinery? Wouldn't it be simpler to just export the HID device and let
userspace talk to it through hidraw, like what OpenRGB does?

If the kernel already handles the custom protocol into generic HID, the
work for userspace is not too hard because they can deal with a known
protocol and can be cross-platform in their implementation.

I'm mentioning that cross-platform because SDL used to rely on the
input, LEDs, and other Linux peculiarities and eventually fell back on
using hidraw only because it's way more easier that way.

The other advantage of LampArray is that according to Microsoft's
document, new devices are going to support it out of the box, so they'll
be supported out of the box directly.

Most of the time my stance is "do not add new kernel API, you'll regret
it later". So in that case, given that we have a formally approved
standard, I would suggest to use it, and consider it your API.

Side note to self: I really need to resurrect the hidraw revoke series
so we could export those hidraw node to userspace with uaccess through
logind...

Cheers,
Benjamin

