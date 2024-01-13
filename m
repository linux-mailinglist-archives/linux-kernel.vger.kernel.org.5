Return-Path: <linux-kernel+bounces-25325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DE382CD89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF585B22275
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6A23AD;
	Sat, 13 Jan 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgfOxyro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED11FA1;
	Sat, 13 Jan 2024 15:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1097C433C7;
	Sat, 13 Jan 2024 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705160208;
	bh=tvM2HFUsXOqj+z6VW1pIlboZLlk9IaeJm+YWWlkru3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgfOxyrosBInAGnvCIlerJ1tt6vEE1rwk6R+Ebss0TUcVDWnAXZmp1U2Ik47VmZLJ
	 VxW+6Y2M30scALrwarN4DAPs7rU7cNLuYpEuQCTbF+Dy5nqr43QC0UBkim5XxlmUAA
	 a7uC7saVaE3CwscdbZmQQ1K6FbiE3VVMiWV+PJAHMkYJ+3UUG+xeGSVrzTJhUbGvaG
	 4BhFmj/aQhKpE1Jk3bJi6qzmqiZiZb7//KjC6vksHJdghUVLx0Wl4RuFBsQiaM+FRV
	 sUyqfUoU2IPDm3U9BF9w8Sy2PCoVCCPtlHc0lAltrZC/uZxtUrzVgopMyXPt9WzvcI
	 1h2TveaKpRsuw==
Date: Sat, 13 Jan 2024 15:36:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: hmc425a: add conditional GPIO
 array size constraints
Message-ID: <20240113153642.5f3d60e5@jic23-huawei>
In-Reply-To: <20240110-unfitting-squander-b1d71c185bb7@spud>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
	<20240110153757.5754-2-mitrutzceclan@gmail.com>
	<20240110-unfitting-squander-b1d71c185bb7@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 16:17:45 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jan 10, 2024 at 05:37:09PM +0200, Dumitru Ceclan wrote:
> > ADRF5740 and HMC540S have a 4 bit parallel interface.
> > Update ctr-gpios description and min/maxItems values depending on the
> > matched compatible to correctly reflect the hardware properties.
> > 
> > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>  
> 
> Seems like you need a Fixes: tag, since the original binding was wrong?
If you aren't doing a v3 as nothing else to change then just replying with
an appropriate fixes tag to this email is fine as b4 will work it's magic
when I pull the patches off the archive.

Thanks,

Jonathan

