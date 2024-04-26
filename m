Return-Path: <linux-kernel+bounces-159816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B558B347A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4F11C22635
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89813FD82;
	Fri, 26 Apr 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cSA0QZqk"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086C13F01A;
	Fri, 26 Apr 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125108; cv=none; b=XaB+UbsVrImRamRM0dMMQtrC0zq2O8NG7UWfe7mu8994QwWK6rTDJZ7g5/aUoJlOldxy19H39nf8KD2iDIaWl4LTGQr4A50bqXfIcuRD+dRP89NxncORp+QdMk84ejT4k3JKRAb6hw/qZkCq5d/ld7aBFGz01nOeU9yC9DtPlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125108; c=relaxed/simple;
	bh=E8qgf4m07XvrYTj9eR33JxTb531hlL+Mt9Butlmfk3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BxAm+Palhpi4/3ZzUmhzeCSSRTFa8xv45qb/1szvJvDNUFV0gxmfEVyAUTC2dS3872k7f1hoduYJBIWW1JR9d/DR0fqdb5XJutOiLLvh91BV56DpbXayVOyIwBxBwFT+9lEm5OWagAK2pGZ071EMqVrHw8dhBE4GxyQePcHKmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cSA0QZqk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C1132000C;
	Fri, 26 Apr 2024 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714125103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0BgDb0k9EC97zEdXZnKosPq8NNnoO+ShOw0Y/xj2auw=;
	b=cSA0QZqkfpkijLDCqFGRrkVRUipTHcGuNx2t+VtzHDcXq4+4KFbmWq+MjDjKWEtxEUX613
	AQgaThFLDlWdZsueWfULGgMQL78XAF4HIdXbkr0O0rth7uP1wE/ij6XMVijpIII6I6Tkgh
	sKbFcDs05LlrixbrUas28+czy2AEf/cigmozqfTVgQVva2Uv5XdBqBRkod2E+sd2Tp0rXe
	HCLv+CCiW4xK0saR3REGGFcAKZhTLJTSQXZpxJ9iqMdLP4lE4JYmIAQjfTkI3ntQrVJnNP
	YyVmCX9TBMqACJOKjL24EoA1JZF4GdZ4AeVtFSlUiDNkiQCqZw+yNDbJMIZXxw==
Date: Fri, 26 Apr 2024 11:51:41 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Doug Anderson <dianders@chromium.org>, Chen-Yu
 Tsai <wenst@chromium.org>, Matt Coster <Matt.Coster@imgtec.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, =?UTF-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-kernel@vger.kernel.org
Subject: Hotplug hardware with (un)loadable DT overlays - unconference
 meeting notes
Message-ID: <20240426115141.201f257a@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello,

Last week at the Embedded Linux Conference in Seattle we had an
"unconference session", which is a free discussion about a topic. The
topic I had proposed is "Hot-Pluggable Hardware with Device Tree
Overlays Runtime Loading and Unloading (yes, at runtime)". As suggested
by Saravana, here is a brief summary of the discussion.

15 people were present:

Luca Ceresoli (Bootlin)
Thomas Petazzoni (Bootlin)
Alexandre Belloni (Bootlin)
Maxime Chevallier (Bootlin)
Krzysztof Kozlowski (Linaro)
Bartosz Golaszewski (Linaro)
Doug Anderson (Google)
Chen-Yu Tsai (Google)
Matt Coster (Imagination Technologies)
Martino Facchin (Arduino)
(5 more, I don't know the names)

The topic is how to implement in Linux using device tree overlays
runtime (un)loading any hardware add-on that:

 - can be plugged and unplugged to a base board at runtime, without
   notice
 - adds hardware on non-discoverable busses
 - provides a way to detect the add-on model that gets attached.

Cold-plug and discoverable busses (e.g. USB) are not in topic.

We described 2 use cases we are working on at Bootlin.

One use case is for the LAN966x, a classic SoC that can be however be
started in "endpoint mode", i.e. with the CPU cores deactivated and a
PCI endpoint that allows an external CPU to access all the peripherals
over PCIe. In practice the whole SoC would be used as a peripheral chip
providing lots of devices for another SoC where the OS runs. This use
case has been described by Rob Herring and Lizhi Hou at LPC 2023 [4][5].

The other use case, which was discussed in more detail, is for an
industrial product under development by a Bootlin customer, which is a
regular, self-standing embedded Linux system with a connector allowing
to connect an add-on with additional peripherals. The add-on
peripherals are on I2C, MIPI DSI and potentially other non-discoverable
busses (there are also peripherals on natively hot-pluggable busses
such as USB and Ethernet, but by their nature they don't need special
work).

For both use cases (and perhaps others we are unaware of) runtime
loading/unloading DT overlays appears as the most fitting technique.
Except it is not yet ready for real usage.

For it to work, we highlighted 3 main areas in need of work in the
Linux kernel:

 1. how to describe the connector and the add-ons in device tree
    (bindings etc) -- only relevant for the 2nd use case
 2. implementation of DT overlays for adding/removing the add-on
    peripherals
 3. fixing issues with various subsystems and drivers that don't react
    well on device removal

* Topic 1: DT description *

I mentioned the DT structure I proposed in [0] which allows decoupling
the bus segments, so supporting both different add-on models and
different base boards with different SoCs around the same connector
definition (think of the Beaglebone family). No objection was raised
about this approach.

Some mentioned the recently posted patches for Mikrobus support on the
Beagle Play [1], which I was unaware of. The proposed connector
description appears similar to our proposal. However I later checked
the e-mail thread and although the connector description appears
similar, there is a big difference: in the Beagle Play proposal the
add-on is not described via DT but rather via a greybus manifest, and
the connector driver has code to parse it and populate the various
devices mentioned in the manifest.

* Topic 2: Implementation of the connector and overlay (un)loading *

The proposed idea is to have a connector driver that reacts to plug
events in two stages.
 - Stage 1: load a "small" overlay common to all add-on models which
   describes enough to get the add-on model ID, e.g. from an EEPROM on
   the add-on itself.
 - Stage 2: after getting the model ID, load the model-specific overlay
   that describes everything else.

Stage 1 could be unnecessary if the model can be detected without
loading any add-on device drivers, e.g. is defined by pulling some
GPIOs on the connector.

Overlay (un)loading is well known for triggering several issues, the
largest one (in terms of lines of code involved) is the memory leaks or
use-after-free [6] of nodes and especially properties that happen when
an overlay is removed.

* Topic 3: fixing drivers/subsystems not handling removal correctly *

Bartosz raised the concern that many subsystems crash or hang or are
otherwise buggy when a device is removed (I think the quote was "are
you guys going to fix them all?") -- a sound concern indeed.

We plan to address issues as they appear on the busses we use, which is
already a relevant work and is already in progress here. The
others (e.g. SPI) can be addressed by whoever needs to hotplug them
anytime in the future. It's worth mentioning that Bartosz gave a BoF
[2] and talk [3] on the following day, both with useful information for
those needing to make a subsystem safe against removals.

* Status *

In the end there are 3 main areas in need of work: DT description, DT
overlay implementation, fixing drivers and subsystems that don't work
correctly.

Bootlin is actively working on all of these topics and already sent a
few patches to fix some issues that were found [7][8][9]. More is under
work and will be sent as it is ready.

That's all. For those present, please feel free to add any relevant
details I have missed.

[0] https://lore.kernel.org/all/20240403213327.36d731ec@booty/
[1] https://lore.kernel.org/all/20240317193714.403132-2-ayushdevel1325@gmail.com/
[2] https://sched.co/1aBGK
[3] https://sched.co/1aBGf
[4] https://www.youtube.com/watch?v=MVGElnZW7BQ
[5] https://lpc.events/event/17/contributions/1421/
[6] https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts#issues_and_what_needs_to_be_completed_--_Not_an_exhaustive_list
[7] https://lore.kernel.org/all/20240325152140.198219-1-herve.codina@bootlin.com
[8] https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com
[9] https://lore.kernel.org/all/20240220133950.138452-1-herve.codina@bootlin.com

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

