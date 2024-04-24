Return-Path: <linux-kernel+bounces-156566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D038B049F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C6DB21872
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79D158A01;
	Wed, 24 Apr 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc5AJDXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1712156C78;
	Wed, 24 Apr 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948183; cv=none; b=Hn/WATaqw7O6OvjIGGHAyXECgr2p4tV2ssvYQd+oyTwSjN4SO4GVDN6FBhDruC2gt3GC/0lFutnfMKNkcZAaTmRnt1t31g8wNkW9YXSFK/JviIxEUqFqgqCp2fRSDhGI6DEv8IGkDG+KvPBSk3Trb/ZV3GW9otm/3T2r+RYDMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948183; c=relaxed/simple;
	bh=sFk3O4Sw8i7ZmbuTd72z0EqIh57Z+E9Gr3w3NMIS1kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGAY4G9vpMIRmfkPLWfcESqMnYYx7AszVgrKB9CsG7Tfrgy61rlvVS2Znn4mqkL0o8tEokqWmFDr4Y7kD5T/Xqxnblu4535zfZBJnses7Go3yiD/eRaz5TVaX35ishUeadVpiDQv2viLHJ545BernNhEWLux045A/HrXV7BI0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc5AJDXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF16C3277B;
	Wed, 24 Apr 2024 08:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713948183;
	bh=sFk3O4Sw8i7ZmbuTd72z0EqIh57Z+E9Gr3w3NMIS1kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rc5AJDXlQpCQqfyw36aBQqTQ5vg0LE8K50ywbS07mZSb2VVqKyL4GuwfaAR0pVG2U
	 uJDRF0wdI3SsrHoL+Y9JJ9iSY3oSqDOSUgPEO0UmuDXo9RCyLH2x7NEv+Q2lYWKi7b
	 UaK5kFuMlhnCfH1fEyPSkWv2WL15chNcEiFs0uEZ/z5AYcne7Cc5jJKsSqtmYT96do
	 6OT0LeZ87Ir6Stx76Bur7k00OtDWaf8NIopfk+jkQpf/iAvjkvK6OJoIYobczgjMgL
	 vlbwoCtUUqV/8ZXzATyIdFXPuqijmhT06hU19vhOEy7+4SLz69TFtY1SZ3r5ZIKIkw
	 QTmCaHZjTYrow==
Date: Wed, 24 Apr 2024 16:43:00 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firmware: coreboot: store owner from modules with
 coreboot_driver_register()
Message-ID: <ZijGFJbqRlKykG8E@google.com>
References: <20240330-module-owner-coreboot-v1-0-ddba098b6dcf@linaro.org>
 <9fbf48a6-239b-4304-850d-6ca43af93a71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fbf48a6-239b-4304-850d-6ca43af93a71@linaro.org>

On Wed, Apr 24, 2024 at 08:40:34AM +0200, Krzysztof Kozlowski wrote:
> On 30/03/2024 20:49, Krzysztof Kozlowski wrote:
> > Moving the .owner setting code to the core this effectively fixes
> > missing .owner in framebuffer-coreboot, memconsole-coreboot and vpd
> > drivers.
> > 
> 
> It has been almost a month. Any comments on this patchset?

They have been applied for a while, thanks!  Just realized this email was
forgotten.

[1/2] firmware: coreboot: store owner from modules with coreboot_driver_register()
      commit: 46c6685e7e886b7fa098465f8bfd139a253365e4
[2/2] firmware: google: cbmem: drop driver owner initialization
      commit: 7f20f21c22aa22e488530f66bf4fc168e427f5bd

