Return-Path: <linux-kernel+bounces-78725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA198617D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5301C20BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF983CC4;
	Fri, 23 Feb 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNZyeRWl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593342E41A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705652; cv=none; b=DyL4XxYKhqnrLfDeV/XHwkDLP8jwXnWRuZ4Dy333aL2fa32sMTvDTPIDEuDI+k4HfZyXBpJlVvCo6Fuz+g/DJ7LzamiZzi2mbEAEO/B/dJoNRgIgI8GMxf9nCMjj5GET0SiKkHStKgw/W+VVhVIx/3HEnuOyJKOjZU2hndYVxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705652; c=relaxed/simple;
	bh=3XQlxBiuMQWbH88pVbFc6FT+A2e6X/Jk9rLhCkkzIbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bi5LxqyQ8MH+DaHeEvq73i3O/K6qn6avqgG5eOaTEzjlS1HDxtT3CgFFgcl88dSAg5egM5XW6zlRb2rsiKsqKVm9HGK0IxxzrwirhBYWHQ/TrEmbKrhg1c6l4SQXjAx6Krx2Pa/YpfOUMLoe7mkwFVQ+DcW2gf0G35HlsP3wnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNZyeRWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBFC433C7;
	Fri, 23 Feb 2024 16:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708705650;
	bh=3XQlxBiuMQWbH88pVbFc6FT+A2e6X/Jk9rLhCkkzIbM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UNZyeRWlZFTMiC53eq7hVxWywPyfMaf7E6YLAJ7d8JKp9/m/ldWRdpoagGAy/Xe9P
	 asSJg9zuGa6SKFzYefYiww3GCRbKOq0oMtCpZeZZwjQuxdyMlypeMAurGXN4mc61mp
	 Vj43slfwOeurIgar/n7t93U9aZe9+9gOEKBujZKbDcRCuolorzUGszsO5ANkIPo2xh
	 tbognc5d8Fva1vqrio7knGDAFNKVHrYyuYau/Q+zURZ9DMMESwTS5OPrrKpJ9JDb98
	 K9oP0u4DNbYPQgC00laaAxgnReg0zxRtxAuEMUc5jqZvD7A1kyVMcpAgEKiMhA58o2
	 eTyZbHWxpJ4pg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240219-device_cleanup-mfd-v1-1-e4eef5ed2da8@marliere.net>
References: <20240219-device_cleanup-mfd-v1-1-e4eef5ed2da8@marliere.net>
Subject: Re: (subset) [PATCH] mfd: core: constify the struct device_type
 usage
Message-Id: <170870564960.1739496.12759407049155095921.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 16:27:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 19 Feb 2024 16:51:10 -0300, Ricardo B. Marliere wrote:
> Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> core can properly handle constant struct device_type. Move the mfd_dev_type
> variable to be a constant structure as well, placing it into read-only
> memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] mfd: core: constify the struct device_type usage
      commit: 3cb10854004d2cb9c8f3a33deeeb499d0e0c7120

--
Lee Jones [李琼斯]


