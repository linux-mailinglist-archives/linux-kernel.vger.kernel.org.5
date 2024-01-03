Return-Path: <linux-kernel+bounces-15225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEC58228AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49821C213EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5588A179B5;
	Wed,  3 Jan 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkEqbwsk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98254179A2;
	Wed,  3 Jan 2024 06:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8109EC433C7;
	Wed,  3 Jan 2024 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704265163;
	bh=+yaI7mM29o7p2aP05CBuFB1oVne5AfuOipePV/kh6GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkEqbwsksBjwdPDM7YyvbEzqX2XUDMra4sbcCYxaqIdJ+YCaApNderbGL+pdBq3q4
	 xSbFG8YUhtYmVVTHtrT4ptl/ephs95xpczScde7cj3RWsPTNg86a25U44rlLH65o50
	 akA+l1qsXoKvlVXyry13/XjOr3+6uSomDcIGOLLg=
Date: Wed, 3 Jan 2024 07:59:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5a2f5pWs5ae/?= <mengjingzi@iie.ac.cn>
Cc: pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, keescook@chromium.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Suggestion for Capability Check Refinement in
 check_syslog_permissions()
Message-ID: <2024010306-tweezers-skinhead-083e@gregkh>
References: <1ee10aa6.d064.18ccdb23971.Coremail.mengjingzi@iie.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ee10aa6.d064.18ccdb23971.Coremail.mengjingzi@iie.ac.cn>

On Wed, Jan 03, 2024 at 01:00:58PM +0800, 孟敬姿 wrote:
> Hi, we suggest revisiting the capability checks in
> check_syslog_permissions(). Currently CAP_SYSLOG is checked first, and
> if it’s not there but there is a CAP_SYS_ADMIN, it can also pass the
> check. We recommend refining this check to exclusively use CAP_SYSLOG.
> Here's our reasoning for this suggestion:

Again, have you tested this?

thanks,

greg k-h

