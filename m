Return-Path: <linux-kernel+bounces-145468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5D8A5688
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5781C213CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F43F7AE43;
	Mon, 15 Apr 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1WmA62Kw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441691D52B;
	Mon, 15 Apr 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195271; cv=none; b=RFTZC6i8ZBDZAPsPD3Z9KFtcHOV1oYzGhXwTrGt0hyNORVPeBtKyXwbHL3LHfT5Mn16WHvE4cepN72fc9DwKxMundewXr5tLjztuWehhcVzyHd0fiZ2nVIZa5EOlQjJYcMQ0kbXBpqzX1NCou25lOr2nZ4iM8wob9e08H/TmRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195271; c=relaxed/simple;
	bh=byghmlwYgW0PL2c7jQST28C4hISBEL5i30P9W6RbAik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcjJ2cyzUt+ibSx1Q7+6BHQdnLPBVAOGJLpRkm7eev9ukD/YpAlup0q0K81QRfC0dhrraXXsgWEAGkPC3c7nTX6fSrwD4DpB+WQW/78wp+qWJisGVcJD8HFy/aArNqHkq/Lbk0gqnvpcizzCuupqiaxKLGakpU/JGN9U9o503R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1WmA62Kw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713195268;
	bh=byghmlwYgW0PL2c7jQST28C4hISBEL5i30P9W6RbAik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1WmA62KwZ8Z/y/7fHkGBZDB3agmqTdZFPCRO9w5UP44EwBfYi78kr7icRAu8HID/V
	 SInagdizHMCnbNvQ39RD76DPJ3AGyCiVRzg8mnSuqn/GVS74EMM3ioMvtxPc/9V+zp
	 KCiF/E8fR9vdjqrCUAPgbNG1zPsTq75Vt8sw0V8e+gLzfoEDPLHhby6NTM1l/8vRMm
	 78sg2QXKGQIWKSi2x/casIRoLbIxUUEOLvtGpUWGOfHph0MZX3bcVgI2Ng+Y5DjJVd
	 pepLWuHIP2Y1k1oBqj5ZLI9V1jzU+dcwcN5PPgPxJbPnfSAkx48Mj8YmngwSgTk61+
	 y9GnN5Q02cU6g==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CCCAE3780022;
	Mon, 15 Apr 2024 15:34:27 +0000 (UTC)
Date: Mon, 15 Apr 2024 11:34:26 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: ltc3350-charger: Add driver
Message-ID: <141c40a7-9c15-4d58-9081-073c5c72606b@notapiano>
References: <20240409135442.37732-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dab85cfc-973d-4930-8fea-324aa26b5801@emailsignatures365.codetwo.com>
 <20240409135442.37732-2-mike.looijmans@topic.nl>
 <5hpl2kspf667hmmxgg36ahiux5rs364qzrg2itpljspspa47vp@dsbnhdnq5s54>
 <efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl>
 <lxxwadaf2mrghy2kygm3cucb7ygl5qu4dxnmpbancrm2hwjm4g@5eudactyudca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lxxwadaf2mrghy2kygm3cucb7ygl5qu4dxnmpbancrm2hwjm4g@5eudactyudca>

On Sun, Apr 14, 2024 at 07:29:56PM +0200, Sebastian Reichel wrote:
> [+cc Nicolas]
> 
> Hello Mike,
> 
> On Fri, Apr 12, 2024 at 08:53:58AM +0200, Mike Looijmans wrote:
> > > please share output of
> > > ./tools/testing/selftests/power_supply/test_power_supply_properties.sh
> > > below the fold with your next submission. It's useful for verifying,
> > > that you got the unit scaling correct for the standard properties :)
> > 
> > Will do. Did a quick run on the driver as it is now, that yields the
> > following output:
> > 
> > (Any thoughts on the "arithmetic syntax error" messages?)
> 
> The script contains some bash specific shell extensions and should
> use /bin/bash instead of /bin/sh in the shebang. Just call it with
> /bin/bash ./tools/testing/... and you should get rid of them :)
> 
> Nicolas, do you want to send a fix for that to Shuah with Reported-by
> from Mike?

It was easy to make it POSIX-compliant, so I sent a series doing that instead:

https://lore.kernel.org/all/20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com

Thanks,
Nícolas

