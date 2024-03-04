Return-Path: <linux-kernel+bounces-90675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FD870326
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641971F2245B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580793F8DE;
	Mon,  4 Mar 2024 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6DFlEAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0BA3E494;
	Mon,  4 Mar 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560005; cv=none; b=NCTJAfPdfs6fTqGPaCh+y+n5X/2BUYDnhigtW0MneebleczOXeX/ONKDsTaImmx+vkuzBhLBsgClN52pPaS6rg3NyUDx4mpRqlTtNGWF/Z7mdTunsJir3r0Iv2WtyGjXw5B/0V/ytJbEIJWjGlAifCXk+sfSbxeWqdQk3QWg9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560005; c=relaxed/simple;
	bh=9lEerqDMG7S/DxOXyrAqh+UDQmh9AVrZ/aB4ftJMUwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQGxcDbNsJK4+EHeqq+MTQHBe8ne9ZXVUZjKL5E1kqLcD3RE+NzVIBcjwn+Z4k0ojoQ8xuWyLks5qHvXn4s1r/MgbNjsyMQWZBQh6YyZBgrsRiofaTrxX15Sv+nL4Mligk8zD8jp64DQGpsra3lgy2gIlBPmtzVXibJzktclRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6DFlEAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE353C433F1;
	Mon,  4 Mar 2024 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560005;
	bh=9lEerqDMG7S/DxOXyrAqh+UDQmh9AVrZ/aB4ftJMUwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6DFlEAD5dUnLlhYNh2xHdBSLY61mLIKtr1kjl2Rx8m5aT9XsgfZTLiAPQ2KYgICn
	 yfBmRTNkIGxgn2rgMvBPgqyI1KGk6o/9igFPbUSgOrhI97GiC/Vo7RRCS7eG1NgdhL
	 /U6wO1iYNVUHmsNLGywzObw3Roi7K3ryK6PmVa42coarpZtVrcq5CXFkvXc/oEPi2f
	 2YQPRFcCuBtCstGLij0RVPO1lePsbFCWXB8nndY3fDqObEPLTqewR3bCK5hb/m5b3y
	 LX3n16Y7xnEUzSoFIFXi5yvse6XDg37sggv0k09Fyx+w1oRYekcGqRcl6M/4taCOlw
	 xOUo22/IRnLXA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rh8eb-000000000Z3-1QeY;
	Mon, 04 Mar 2024 14:46:53 +0100
Date: Mon, 4 Mar 2024 14:46:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: oti6858: Remove redundant assignment
 to variable divisor
Message-ID: <ZeXQzV3QOoclnNtT@hovoldconsulting.com>
References: <20240207101833.2440799-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207101833.2440799-1-colin.i.king@gmail.com>

On Wed, Feb 07, 2024 at 10:18:33AM +0000, Colin Ian King wrote:
> The variable divisor is being assigned a value that is not being
> read afterward, it is being re-assigned later in both paths of an if
> statement.  The assignment is redundant and can be removed.
> 
> Cleans up clang scan warning:
> drivers/usb/serial/oti6858.c:412:2: warning: Value stored to 'divisor'
> is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks.

Johan

