Return-Path: <linux-kernel+bounces-139786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7368A07B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0AF1C229E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8513C827;
	Thu, 11 Apr 2024 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNOzlAhU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AAEAC0;
	Thu, 11 Apr 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813262; cv=none; b=c/C84tZLZ0YOM1GSorvfwVPFL8Vt5J0g6lOBewVEDaLjudvPm1eEsMwfxUrliiw3N0q6WGGvB5oSn6IcbN9ggeb6NhG96b0oR7FCLf27Uvm18XWLgVTO+zd+CU+epf0qKEFiKRUg563yPBrftSFZ1lV9PaMsQY/JaFEsbpLE5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813262; c=relaxed/simple;
	bh=9i4J9CK8dnmxvGRBomCaVxL6D6uQfJ69wu/u02ddDM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMy++rlMmdcTZawkh/117x0XG2Wtko0w7s25dPmID5CjfuqoQLH6FDspqkVw/Ff/UaPd82HrQXywTY+OfoXFVcy7fCtWbz0eSzfj24fTesxJ5OPwsCoTv3JUuBchkp2LJrz4CjOUzMmgLK6SlYsrEki0l6IuIuolnV9MzVbv6q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNOzlAhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93449C433F1;
	Thu, 11 Apr 2024 05:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712813262;
	bh=9i4J9CK8dnmxvGRBomCaVxL6D6uQfJ69wu/u02ddDM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNOzlAhUlr+2IaENPBeqWX9/FmaSE5htoNWOxz/Jaifzvc9cknJUykxXbAAGdmaDZ
	 8Ad2ZSUoaIgRnCOxGID5WiFDjexCgtL5jIMGzKVfXysH4kNauIp4lvQLi9rOonOzwk
	 uDXzSlT647W5YmXvqzdXraQ2uMrUdSFkk8Q2Pk0g=
Date: Thu, 11 Apr 2024 07:27:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] docs: stable-kernel-rules: reduce redundancy
Message-ID: <2024041131-malt-retype-1e70@gregkh>
References: <cover.1712812895.git.linux@leemhuis.info>
 <d64757f57823449c99261b167ba0b3b1b8dfcc75.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64757f57823449c99261b167ba0b3b1b8dfcc75.1712812895.git.linux@leemhuis.info>

On Thu, Apr 11, 2024 at 07:25:03AM +0200, Thorsten Leemhuis wrote:
> Explain the general concept once in the intro to keep things somewhat
> shorter in the individual points.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

