Return-Path: <linux-kernel+bounces-73220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3238185BF89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644C41C212C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA0974E24;
	Tue, 20 Feb 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nomaAyFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03374E0A;
	Tue, 20 Feb 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441884; cv=none; b=qG8hhtEogNs46Tg0DFMlijDlyF10sweLv+Tn63qkfoTl9KZT/GW808iZg463xOBK8GTOXjoS4i3fC0DVOx85VKR+cuHQnDA9rUpfvdFmQmvKX2gGcEFW1RC0qwcqZhQt49ypz7mguHJyh49DwcFrcBIlX4qrqDvYjK6tmHK+pAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441884; c=relaxed/simple;
	bh=jg/XNpG+vxzMN378bRYA6bw5Ca729FovgoyK24j+9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeUOUx5MyGxVmajCrjovp4k45asaVDCdZiabmqFGz1oEv38MPQ2wleuD280DNqv42AfJwxgkns2iAxBqcJp8xpqTRapOEk4KdQ+sKsd0FA03dwHFmG6bm7qCW5U0cT800ANfuTz0C+PXCedZ5883rrrHDAn94+NNkYpAMEM3+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nomaAyFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA08C433C7;
	Tue, 20 Feb 2024 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708441884;
	bh=jg/XNpG+vxzMN378bRYA6bw5Ca729FovgoyK24j+9eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nomaAyFPUOvPidgj0jxM+VXZjOF9ar/dO2WY8bHJHmQwRzW02d7sNdAzNmULff0nq
	 d35C2pgp8d8ymOh7ixzEQVYBrLCyu13CsywdM1GpgOTLJbi/rr1pqeAz64JoIVw05A
	 3lt2xH3DIk2d+3IbluQd66/p2lZYlltKS6vq0gJY=
Date: Tue, 20 Feb 2024 16:11:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [v6.6][PATCH 00/57] eventfs: Linus's updates for 6.6
Message-ID: <2024022012-vocalize-vindicate-3eb3@gregkh>
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206120905.570408983@rostedt.homelinux.com>

On Tue, Feb 06, 2024 at 07:09:05AM -0500, Steven Rostedt wrote:
> 
> This is a backport of all the work that lead up to the work that Linus made
> on eventfs. I trust Linus's version more so than the versions in 6.6 and
> 6.7. There may be plenty of hidden issues due to the design.
> 
> This is the update for 6.6. It includes Linus's updates as well as all the
> patches leading up to them. As the eventfs work went in in two parts, half
> went in in 6.6 and the other in 6.7, there were 6 backports that were done
> custom to 6.6 as the bugs found in 6.7 were in 6.6 but implemented
> differently. This series starts with reverting those 6 backports and then
> applying the updated patches to get to Linus's simplification.
> 
> I ran these through my full test suite that I use before sending anything to
> Linus, although I did not run my "bisect" test that walks through the
> patches. The tests were just run on the end result.
> 
> This was created with the following command against v6.6.15, after reverting
> the 6 patches:

All now queued up, thanks!

greg k-h

