Return-Path: <linux-kernel+bounces-161873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35068B528B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2BD281F46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED8814F65;
	Mon, 29 Apr 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kEGcJgPW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C44171C1;
	Mon, 29 Apr 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376949; cv=none; b=TlfYUKMgjoID3jHKFmGQN670LnNWXOblPmINK0iPgDvti0cBL3EF8D/jCCPqUrtwWvTPR6j+Bx70XduOxg+GH5eqrGhL7Ghy3WQFdFncCcI+x/TPPBV5VhLP4Q4AQTwxN/VGGTs7QOGrIBNPyb0PLZHHsLt6Qpf+3N5w9xw3ao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376949; c=relaxed/simple;
	bh=yKavsInFyLfIS2QTxbS6Mq2KLQgz3M/8o98Y1G9Rr1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPyMNt1IS7RY9MrRE4Dk/oaAr8Z56lPyEqpRpFGjzJ6w0b0rzcetgu2LHIUz6qy5mubB7SJvEX7huhPDcWQf4uxCOlA9qLbfN0+IzlTvY44jPg3II5gP1PbIjXIwgf2Rp9tKwrFnYTM2OzRkNzc8883CVjr0/CN/ERfXXs27yCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kEGcJgPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F79C113CD;
	Mon, 29 Apr 2024 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714376948;
	bh=yKavsInFyLfIS2QTxbS6Mq2KLQgz3M/8o98Y1G9Rr1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEGcJgPWODsG6NlRAa6VZaA64nylaqIpNUiga16VoZmHbfC4jYdBZorUEMuf5iIqB
	 SJUGO3LKF6KfmLf+Ps749YhV9JgETdIl88u365C3LlQXEbPpCAPknEQFpfPfkcdWEb
	 4Hykrqm59qy99abUO1AunxPxVzJxLLC7JYBzOCTs=
Date: Mon, 29 Apr 2024 09:49:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] docs: stable-kernel-rules: call mainline by its
 name and change example
Message-ID: <2024042952-prelude-slinging-77ca@gregkh>
References: <cover.1714367921.git.linux@leemhuis.info>
 <0a120573ea827aee12d45e7bd802ba85c09884da.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a120573ea827aee12d45e7bd802ba85c09884da.1714367921.git.linux@leemhuis.info>

On Mon, Apr 29, 2024 at 09:18:27AM +0200, Thorsten Leemhuis wrote:
> Fine-tuning:
> 
> * s/Linus' tree/Linux mainline/, as mainline is the term used elsewhere
>   in the document.
> 
> * Provide a better example for the 'delayed backporting' case that uses
>   a fixed rather than a relative reference point, which makes it easier
>   to handle for the stable team.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

