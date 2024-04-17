Return-Path: <linux-kernel+bounces-148281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC208A8032
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58222842B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DFA13A259;
	Wed, 17 Apr 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVpm9K00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F112DD94;
	Wed, 17 Apr 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347788; cv=none; b=AWcBrLxhlA4/etj4NAaJuWbsoP8nvzwicFjhwDxXdaPeeVdBLH4+XMQge+VyfvPwaf+N3e7G8omUNbcNXg3feCGHoWnp6MzMYzuUWfi9V8X0QkpENhq31kDsBAyoqWttJwGLCGvvJOsuZUNKssHsUAx6eLzjPi0yhw7RYBaceJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347788; c=relaxed/simple;
	bh=zZ7v7PQp0DDEHhoo/bYInJ8iPIZtAFy1cxCwkUCT9gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2rWEh0hfu1Ek3i1yIaCtISFXbSbFs5l77XSCxP5OKj4t3So/URAFMIu1kOW1TCKCE+tjohs+fSAflwHhqST3u48bP8vy5l5VoE/806BXa8GXSoGcLkDm9Zdlu4AadHdbJsqYBxUOK5zAyC585Pz70RVNHABZms6O4p9aoAcgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVpm9K00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603B1C072AA;
	Wed, 17 Apr 2024 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713347788;
	bh=zZ7v7PQp0DDEHhoo/bYInJ8iPIZtAFy1cxCwkUCT9gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVpm9K00ZdOv8mpz9I/gPJjSj4ALSYKsJ2JHp7KFwbtTU8SOxycZhvYqXCUt9u8L/
	 1+gURGur7NOqehJoZfKnYmeCxhI1JNZ1tqTamFpjrPVPIZMYJm2Y04Bdn9XuVsH24I
	 C6AbRRvfOpNOe/vCPTaR6U0OzO5aM8JADqEwsdBkbJzEGk60xb4LjaikdFc5R6OC8J
	 WvNLkF3bPCrfggPF49hTZDmNWXgYMhhoQ1/kd1bJ6F71M6hOy8t4HbprmWLSHlBw+P
	 00VCnT8v/pWZ0wZ9ZOMfl1WVhl7mBxjwW3r/D4Aw00EjTpyMkFVDhhHmHTPb+PgXS2
	 hJledh2aYAfTw==
Date: Wed, 17 Apr 2024 11:56:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Gustav Ekelund <gustaek@axis.com>,
	Gustav Ekelund <gustav.ekelund@axis.com>, hare@suse.de,
	martin.petersen@oracle.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] ata: Add sdev attribute to lower link speed in runtime
Message-ID: <Zh-cx_KGK_M_qUGq@ryzen>
References: <20240412134838.788502-1-gustav.ekelund@axis.com>
 <4e5c88f1-1b24-4f6d-8c11-d7029329ba7a@kernel.org>
 <7e6eb387-5a0e-460c-af08-eff070fa35ca@axis.com>
 <898497f0-d279-4d01-be8d-aad4048df95d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898497f0-d279-4d01-be8d-aad4048df95d@kernel.org>

On Wed, Apr 17, 2024 at 08:59:27AM +1000, Damien Le Moal wrote:
> 
> Can you send examples of the errors you are seeing ? That needs to be
> investigated first before going the (drastic) route of allowing to manually
> lower link speed at run-time.

Gustav, is it possible for you to share the error messages that you are
seeing? Preferably a whole kernel boot.

Since you are talking hot plug, there is a bunch of libata hot-plug related
in v6.9.x (which turns off LPM if your external port is hotplug capable).

So it would be interesting to see if you still get these errors on v6.9-rc4
(we will see if you have LPM enabled), and if so, what errors you are seeing.

You could also try booting with: libata.force=nolpm on the kernel command line.
(This will explicitly set lpm-policy to MAX_POWER, which is different from
lpm-policy=0 (which is the default) - which means keep firmware settings.)


Kind regards,
Niklas

> 
> > 
> > So I want to adapt the link, depending on the connected model, in a
> > running system because I know that some particular models in this case
> > will operate better in SATA2 in this system.
> > 
> > Can I use the libata.force module to make changes to a particular link
> > in runtime?
> 
> Nope, libata.force is a module parameter so you can specify it as a kernel boot
> parameter, or if you compile libata as a module when loading (modprobe) libata.
> At run time, you need to rmmod+modprobe again libata, and so the ahci driver as
> well (because of dependencies).
> 
> As I mentioned, if a run-time knob really is necessary (it should not be), using
> the ata_link hw_sata_spd_limit would be a better approach. But again, that
> really should not be necessary at all.
> 
> > 
> > Best regards
> > Gustav
> > 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

