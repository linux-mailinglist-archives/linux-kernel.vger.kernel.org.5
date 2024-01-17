Return-Path: <linux-kernel+bounces-29342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA664830D12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCBB1C241C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805182421E;
	Wed, 17 Jan 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpTlWdTF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C424204;
	Wed, 17 Jan 2024 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518120; cv=none; b=GC/h09pAnrkm5/y2uUz4C87IqSfsJ2bFtGg3erOocV6M6GCgZWaoCXRNZsBhDa81+SC2STSwxVgfPOh3LpTH0eVfa/7oZ728ShwWZOkNCiCyhN3G2OfXrOZ4RSH29nylEuB84cb1UfhrKyzbXIEjijKE88gJmAdfzEXHGdPKrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518120; c=relaxed/simple;
	bh=+z7ocGDpohpn5o1xPPAId2EU50wgxgGx8dEyGIOz2KY=;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type; b=J/iQdaEpKFf2HwQLb0MiNkZ2PLOvwevigL7vOBJWqPIDj7oJTEGsGBHvJvn8lxZ1Ou6Zaga7ECnPvC83jiDorMWj9Gjc7w4QaJYClBOkOMOn9qzNtMGPjZm+g8jK74RiYC7WFSUJBQQvnjIgR5V6pzNbwAkT8pVcMDLFg+bs+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpTlWdTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FADC433F1;
	Wed, 17 Jan 2024 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705518120;
	bh=+z7ocGDpohpn5o1xPPAId2EU50wgxgGx8dEyGIOz2KY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZpTlWdTFeUZN0vFeTtl38cBu0FBxB4zQrCo7s/l+ogyBD+RW9AmnaPaG/6B7DslKR
	 JDZol/wEwujSLGnnhxXcmVvs8UfkLefAvCrk1MDUvo+eJaYaSwlN2kCrigAc5Qehiy
	 IisPmAV0O2RvPPWDYKynKvjG8655iNSfo+GYGz+p//t013pOIQQXSQK4T3tj/bIrDL
	 kWU8GpDDxmaK3uPltZRbep/68x4RfjbiHYfvMfujKv184++7KGPGvoFFIc5SX8Iuzb
	 40iZymttanVduSiLvK+XOwqEVKF07nCsL9REXCWGi7SInbyKpv6Mz2ooOv5lkNRjbM
	 JfjvR4DYpHBVA==
Date: Wed, 17 Jan 2024 20:01:59 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
cc: Oleksandr Natalenko <oleksandr@natalenko.name>, 
    linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Flood of logitech-hidpp-device messages in v6.7
In-Reply-To: <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
Message-ID: <nycvar.YFH.7.76.2401172001530.29548@cbobk.fhfr.pm>
References: <3277085.44csPzL39Z@natalenko.name> <824573bb-ae01-41b9-8f97-a760ae8f3f18@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jan 2024, Hans de Goede wrote:

> > Jan 09 10:05:06 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> > Jan 09 10:07:15 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> > Jan 09 10:16:51 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> > Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > Jan 09 10:16:55 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > Jan 09 10:36:31 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> > Jan 09 10:37:07 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> > Jan 09 10:46:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> > Jan 09 10:48:23 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> > Jan 09 11:12:27 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> > Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > Jan 09 11:12:47 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > Jan 09 11:38:32 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> > Jan 09 11:43:32 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: Disconnected
> > Jan 09 11:45:10 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> > Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > Jan 09 11:45:11 spock kernel: logitech-hidpp-device 0003:046D:408A.0005: HID++ 4.5 device connected.
> > Jan 09 12:31:48 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: Disconnected
> > Jan 09 12:33:21 spock kernel: logitech-hidpp-device 0003:046D:4051.0006: HID++ 4.5 device connected.
> > ```
> > 
> > I've got the following hardware:
> > 
> > * Bus 006 Device 004: ID 046d:c52b Logitech, Inc. Unifying Receiver
> > * Logitech MX Keys
> > * Logitech M510v2
> > 
> > With v6.6 I do not get those messages.
> > 
> > I think this is related to 680ee411a98e ("HID: logitech-hidpp: Fix connect event race").
> > 
> > My speculation is that some of the devices enter powersaving state after being idle for some time (5 mins?), and then wake up and reconnect once I touch either keyboard or mouse. I should highlight that everything works just fine, it is the flood of messages that worries me.
> > 
> > Is it expected?
> 
> Yes this is expected, looking at your logs I see about 10 messages per
> hour which IMHO is not that bad.
> 
> I guess we could change things to track we have logged the connect
> message once and if yes then log future connect messages (and all
> disconnect messages) at debug level.
> 
> Jiri, Benjamin, do you have any opinion on this ?

Works for me, thanks. Do you plan to submit the patch implementing this?

-- 
Jiri Kosina
SUSE Labs


