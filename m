Return-Path: <linux-kernel+bounces-48475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EC845C84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC9A1C2C732
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC3626CC;
	Thu,  1 Feb 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMzdWVFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A4626AC;
	Thu,  1 Feb 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803775; cv=none; b=o5wXCbHIVXAJbFLwrNBtl2Aei0PFOrFYMBxmxUJXcpjFk6O5jQmSEfT3dHoMb8JWByy2as7Wk/KbKd+dvBLju/fULATftkuTkZfNbYTK9n0N5DCDefDKWGVU6vl878E7gv4VYaJPZbyxZQ4tU1oW4MFcFBMfQGWCTdMiicUsErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803775; c=relaxed/simple;
	bh=rcvgKkAFbDGfteuQyxWJp9KmDKoTlFpiaCcJiMj3tbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehw4DxitkYPjYByWgbxKDmLvvwrEwE5zuIn7gNaNaeMDjqLCrjH45F/OkVbCSrF0+sK8w5/Ao2Y1xNpNOTyK9G6xX2XUrBhnL7BPesTrbJ7RJMR30k1ojhrxw+fb2wuyjFJWXQ4sxP9HJtMFH2rWa8+hA2yovTiecP0R5mGzJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMzdWVFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6839C433C7;
	Thu,  1 Feb 2024 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803774;
	bh=rcvgKkAFbDGfteuQyxWJp9KmDKoTlFpiaCcJiMj3tbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMzdWVFd3DHFOz89NxSPixk3igdlaO10a3igYdL+ylfv9rXVzJdFelsiH19E4s7YQ
	 Wytkz+teLY+NmyHcjO8k1CmVMAPcxq8bcHoI6azBQBY4G+y7sV0kt3Wj4YvFNhyIBt
	 WcGtNdrSaUGLnRb0FIfxQbWv/2lO0rqWNkIvEsgbtZ13eYDwv6ipXNUO1pII/uIUcn
	 aT0U6CHajoTFr3tXeE1/nHF7q4lDdIpeZ9puU8RH8WRJ7pFSKWBnPsbpNHMss3iT6n
	 iBgBC6CxwH+7NUKiSuQwNjqs1AjJmx7hm/gXhWcRHjA2ZRsIrxH7LJTB1wcvQxiCId
	 K2oLsZWXvJz7g==
Date: Thu, 1 Feb 2024 08:09:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Jiri Pirko <jiri@resnulli.us>, mcgrof@kernel.org, russ.weight@linux.dev,
 gregkh@linuxfoundation.org, rafael@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, keescook@chromium.org,
 masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] net: ethtool: Use uts_release
Message-ID: <20240201080932.4f8bb9fc@kernel.org>
In-Reply-To: <Zbual3uIsjXENw0c@nanopsycho>
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
	<20240131104851.2311358-4-john.g.garry@oracle.com>
	<20240131112432.5133bcaa@kernel.org>
	<fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>
	<Zbual3uIsjXENw0c@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 14:20:23 +0100 Jiri Pirko wrote:
> >BTW, I assume that changes like this are also ok:
> >
> >--------8<---------
> >
> >   net: team: Don't bother filling in ethtool driver version

Yup, just to be clear - you can send this independently from the series,
tag is as 

 [PATCH net-next]

we'll take it via the networking tree. I'm not sure which tree the other
patches will go thru..

