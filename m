Return-Path: <linux-kernel+bounces-35134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB52838CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F201F21E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3165C90E;
	Tue, 23 Jan 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INbUVT4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC348CE4;
	Tue, 23 Jan 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007358; cv=none; b=tz+wqbWHkK/u1KnFBYetb+lF0O4n/J0fF9r68UP/feWUY3OyE0hLKOH4gDo5J31AnKlNMPP8YKsQViz3MhXMKTQBShQv7RRU+wIwrseq3l58zc7YGr8m08dfNsB/tI+jkcQqWi+YCHSzE+InoVhx9qTyF7YRYajZ0DGUnoFhg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007358; c=relaxed/simple;
	bh=4tsL23ghaEQEaT2bq2YzzgROa1LghxVl/vUgPgfSGjk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SCqOxflR0EAH2lUvfR2dYBgumeJ2aaD38zcQpii7lEVFjWFztIqpFdmLsnkjJqonrVCUXuvnaT9u9tlXOHxIHSAh9s/8ZFvRo592oG3aPJhmZ1MXWP3t1kC9M4hmKUBUha6FQ334OBIXvvdJjEy+RiUqJbByP/cKbgyo2oDilqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INbUVT4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36A0C433C7;
	Tue, 23 Jan 2024 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706007358;
	bh=4tsL23ghaEQEaT2bq2YzzgROa1LghxVl/vUgPgfSGjk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=INbUVT4TOo/bB4RTGM/M9Ew6RjGLp7arfUjRaP7TWHjkxi7/pPLGwre3bg/wrGzb4
	 sjfwQIUPqwTNZKOmXtuLQ3St1YhhmewT0k21fkNuZDLriMnsaohlGPHxB+0ynDF4Oz
	 kqPtUFS6d4vEfVIWLoKIoaDyvvLD7QVaWPI0DU063Fgf0fKxAqwav/saDHH7xS0POc
	 5thnsJ34QEYuHvSTadpNTy6TF8Xafv7uMHgaC0MYmIuzYC5IC6v7ZiuLUVoNDFRRYs
	 gXYk5AKuqwYK/nBYZ5zXsObSU4h81DBuUQ5PRYZO3PKvKOe/BcJlKaaz16hKNa1TZY
	 d4vsa9diE6L9g==
Date: Tue, 23 Jan 2024 11:55:58 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Mikhail Khvainitski <me@khvoinitsky.org>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    iam@valdikss.org.ru, jekhor@gmail.com, u-v@mailbox.org
Subject: Re: [PATCH] HID: lenovo: Add middleclick_workaround sysfs knob for
 cptkbd
In-Reply-To: <20231223191401.70727-1-me@khvoinitsky.org>
Message-ID: <nycvar.YFH.7.76.2401231155270.29548@cbobk.fhfr.pm>
References: <CAMMabwPd-m7a+EQV7zb=wU52=P1FkqFU1dg9=gyvaS1EP5tX3Q@mail.gmail.com> <20231223191401.70727-1-me@khvoinitsky.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 23 Dec 2023, Mikhail Khvainitski wrote:

> Previous attempt to autodetect well-behaving patched firmware
> introduced in commit 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw
> on cptkbd and stop applying workaround") has shown that there are
> false-positives on original firmware (on both 1st gen and 2nd gen
> keyboards) which causes the middle button click workaround to be
> mistakenly disabled.
> 
> This commit adds explicit parameter to sysfs to control this
> workaround.
> 
> Fixes: 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround")
> Fixes: 43527a0094c1 ("HID: lenovo: Restrict detection of patched firmware only to USB cptkbd")
> Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>

I am not a huge fan of sysctl device-specific knobs like this, but I guess 
this is the best we can get here, unfortunately.

Now applied, thanks a lot.

-- 
Jiri Kosina
SUSE Labs


