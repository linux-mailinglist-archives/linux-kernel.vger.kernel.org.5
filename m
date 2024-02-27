Return-Path: <linux-kernel+bounces-83632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173A869C84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DE11F266EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF304F1E6;
	Tue, 27 Feb 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpphTSnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFA4EB34;
	Tue, 27 Feb 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052042; cv=none; b=UA5JqnJeDrQsA6EkkEuzswBYN0HZ+O4fPayx05Igpwg2vg8ABZHPJB+mepx6aTQb+6p7mnPfOe07pm/hIlqpyiMKZet9fMr6oem4bfOxFUZ/sojuuQ8FdX4a9wPSoFGbWL3AoUcSokp41KYG9cwIrmyUoU/X6CYQCJrxSXsnT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052042; c=relaxed/simple;
	bh=HIakpDWozBMuOguxGlB8/IWi2fuUJlBZQtFYT81dH88=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TVTOvuGZO+HZ29WQtLwqyEbkci+lUkDBley5Xwfhn88nbxY57ugYwdUs21LqrFUgBPysYsyNL9rwm06+AbYSRxqZ/cCV9a4qgq8bsK4iwf97xIFeDZNM76f2VuhXpz8ZMnPq4LvonRqHDkN+Dbb4sE6NSlJNgIXncjCNe/juH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpphTSnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AD7C433C7;
	Tue, 27 Feb 2024 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709052041;
	bh=HIakpDWozBMuOguxGlB8/IWi2fuUJlBZQtFYT81dH88=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bpphTSnTg/V43P9LN4bQEQQs0ghOxW5kq6M9KogBQzu2uFu/QNmcR9iAKAZ9x17jH
	 Bxz8FIDFd2aZwPBPskBihQV8EJZzgJOmuXsVeTH63+c3SljZIA8/vOcu+rwtGkkG1h
	 AbX5uMltxZ4H7wN834vYBq9tOCWmNzXIheROk19KdKwfMHOxyAccvR+4b2QGnEhTRY
	 3SwbQPtRSuixNoAQ8L/OzJm109kauWw+C/ZTQ8JUsfFZ8pyJoNqZfnhOH58Hykyhv3
	 TDMaKNfjUeIAxuChjxyUfvwg2Z3T62UKVg3tFk06E08ruSAcz+y/pr6c2Suyw3kOMF
	 kiTL87jTWVOmg==
Date: Tue, 27 Feb 2024 17:40:42 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Max Staudt <max@enpas.org>
cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
In-Reply-To: <20240207163647.15792-1-max@enpas.org>
Message-ID: <nycvar.YFH.7.76.2402271740260.21798@cbobk.fhfr.pm>
References: <20240207163647.15792-1-max@enpas.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 8 Feb 2024, Max Staudt wrote:

> Dear hid-playstation maintainers,
> 
> Here is v2 of my patch series, with the discussed changes.
> 
> 
> Differences since v1:
>  - Dropped patch for 7545:0104 (SZ-MYPOWER controllers)
>  - Dropped patch for DS4 clones without a MAC address on USB
>  - Changed hid_err() to hid_warn() where things are no longer fatal
>  - Simplified goto as return in minimal report parsing
> 
> 
> I've included the patch to simplify the PID/VID mapping to controller
> types, since the previous discussion made it sound useful for future
> support of second-party controllers. Please feel free to drop it if you
> don't think it's relevant now.
> 
> 
> Thanks for your feedback!
> 
> Max
> 
> 
> Patches in this series:
>   [PATCH v2 1/5] HID: playstation: DS4: Fix LED blinking
>   [PATCH v2 2/5] HID: playstation: DS4: Don't fail on FW/HW version
>   [PATCH v2 3/5] HID: playstation: DS4: Don't fail on calibration data
>   [PATCH v2 4/5] HID: playstation: DS4: Parse minimal report 0x01
>   [PATCH v2 5/5] HID: playstation: Simplify device type ID

Roderick, any word on this series please?

Thanks,

-- 
Jiri Kosina
SUSE Labs


