Return-Path: <linux-kernel+bounces-144606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D008A4855
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE6B22BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95677208CE;
	Mon, 15 Apr 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmTPhJVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77D200DE;
	Mon, 15 Apr 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163574; cv=none; b=r1LWcXUvC9WeLPXHSQ1Tu61G42SSOjHC0cNBuxGLZbIE+cXCBJq/APN7qxNzPvTnjLCcrjSvLGG1z0BjjO4VwMRhYGeHndZs3QY5dgW0OwZzw7rvOwaCHEE7YPMqiSbLA+sIEbi2bFhfAkQ/YxGEynhEifbG5uaaZSSjK60Ma4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163574; c=relaxed/simple;
	bh=M3E5v9WIUoK8ZPJWrgQ5BaTLENMbot55qcTTTIDrCOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwA5L7GvHoQ7ZxwQrqgXFnTLHNTY57o0mUKnv01lqIWX2mMaftrLI9Ud1Sml2tERRXMgOK/b4bHLsLRGxrDkSantP9POufaZxAkdMyZnJrqfGFnjgKJWpHqQfkTOUDsDgtbnzv6qCTyJUiFV2pmS8awCeOodkQ78uSuvU+DdY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmTPhJVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694CEC113CC;
	Mon, 15 Apr 2024 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713163574;
	bh=M3E5v9WIUoK8ZPJWrgQ5BaTLENMbot55qcTTTIDrCOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmTPhJVdPaJsXIsEAlxGSSn5tY8tggYoQnpA9Jsr6n6hVeOLdqW8/HiMObdriwyG+
	 0R0MCOPz1CZ7nY4gpQsFY2Ay62MOJRUeHC/XgBAzPJFFJ45ZacHWJ0VJPUIrE1Wjt9
	 D6Zt/wxaMefOwY0QJPnvkaWgZkkAcxNDrrz4827kfyumERAOelQGL7NBnnVesap4s2
	 aAok9xfs5ac4k1TSibuXtS18AQn38hMtTEIcOKcXRiOSzgBodT8BO/D7syj7P2UWPI
	 cp5T5H8dbTXXthsJXq8cydXx7ZvQEiMYuNxGoU6grIDEX62MxTcCdKOTKNY6RuTKPF
	 1nQkkLXZoIm1A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwG6V-000000004dk-481f;
	Mon, 15 Apr 2024 08:46:12 +0200
Date: Mon, 15 Apr 2024 08:46:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for Fibocom FM650/FG650
Message-ID: <ZhzNM_zouHPLdvBz@hovoldconsulting.com>
References: <20240312062913.12723-1-gch981213@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312062913.12723-1-gch981213@gmail.com>

On Tue, Mar 12, 2024 at 02:29:12PM +0800, Chuanhong Guo wrote:
> Fibocom FM650/FG650 are 5G modems with ECM/NCM/RNDIS/MBIM modes.
> This patch adds support to all 4 modes.

Can you please say something here about what each port (in each mode) is
used for?

Johan

