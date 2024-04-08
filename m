Return-Path: <linux-kernel+bounces-135015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17489B9F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BFD1F21D99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915938DF1;
	Mon,  8 Apr 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qihfQW+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D3381B9;
	Mon,  8 Apr 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564043; cv=none; b=nsnMDWOeDBLduU4Wjhedwt8agp8HZXd752Z8PKY6Y30SC2nipAmPOnfd5KYO50ZvbJk7cIOI2EBJN3CzgPsvZ7n/MeI80fthRYqVQY6dtLKAlkjI6GJuraqazA/zpNTWOZuFayW4t5CcjRudQ32ox1QocUWb21lOqLWULo4V4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564043; c=relaxed/simple;
	bh=D+6KGLQNGfPx/zzDCGJFle1h0xBvnudCFSwBJmsqPUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px+XNQMnYUPA6TsDxkDTP7cIW7/rMLHqxK42KlfMQboW9nMXnh+TYn20tlaF33FUOu4TTrmAqLbuwvKCF7msSUaE0XDTfb4fYy2l44Aw/L8pPvbX0Y9gKXGVLEecg/WcFENdltQ4vho21SoZ5PJSgwtFDmqQWuJxArCKc27QJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qihfQW+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB5FC433F1;
	Mon,  8 Apr 2024 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712564043;
	bh=D+6KGLQNGfPx/zzDCGJFle1h0xBvnudCFSwBJmsqPUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qihfQW+7fEdTF/7OtLJgt/TeDCS54A1A3l3+mDL+rTMm+sf0pDx5llSGh60KZnzhO
	 qKopuya7vUJqIxO3MkdP/lxHAM/x0Gqo2XTdGD7pR2kg6OeTP5vlw7uGrLRvc1u4lx
	 XaGIaugFeFqAtTLDjMFO1QIDso24n6lXI3nMG9oGtm/9ld/CwD+VRCnT5fiBevWt6d
	 AqWiLvEwgvyxrk7SkRrJ4xDUoYZUUi4MJ6Kt4fQjAg+ZrmAHKLbKT1bnbHVmhsSocO
	 cxQMWJiY4RFvtbpDQzcuwClGzebR39DhQH+4ii1ImBAaBHnyQoqwPQEqTh/ES75EYl
	 AhB6u4txGyD2Q==
Date: Mon, 8 Apr 2024 16:13:59 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 1/2] platform/chrome: Update ChromeOS EC header for
 UCSI
Message-ID: <ZhOnR4R_wjix9afn@google.com>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-1-f848e18c8ed2@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-public-ucsi-h-v3-1-f848e18c8ed2@chromium.org>

On Wed, Apr 03, 2024 at 06:05:21PM +0000, Pavan Holla wrote:
> Add EC host commands for reading and writing UCSI structures
> in the EC. The corresponding kernel driver is cros-ec-ucsi.

FWIW, the new host commands haven't been in [1] yet.

[1]: https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h

