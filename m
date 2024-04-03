Return-Path: <linux-kernel+bounces-130521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2F897961
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA21F21C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B651553B1;
	Wed,  3 Apr 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaN+YfzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7C155310;
	Wed,  3 Apr 2024 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174070; cv=none; b=kc8HQ5RyZrnHEiKmvd6YsMuhzS/PScKiycNS/UEYyk70i7fRRpgYFNW7baBSkRDFsByYOnZllWS6FfmhJZUtNgoqRTjhMgSGIIi/x9tgReGKDrwGlfMVo15shQtPKx+dkhct2jZoGQ3MomIU3Aw0+ks5DKv9fITuDEOpWiKoTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174070; c=relaxed/simple;
	bh=qZN2hJpnCDd8EWchAl3M1u0cB/a97vB9HCwXho/fp5I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o7vnIlEtGATYHxPAq7uFYkXHITmVdNSdoi4I9Z2b4XY4WzYxqvrd8ZL/p2uPH3IqkIgyewJzBlqMix2m/s6ShiPIyD1Yd8Rktwd27GjIXbR9HMpu13GJ5xzWSWUwRiRdmR+2gRDAOXRcoGx2uqsJXAaF58SC+q0Kg105gZQwIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaN+YfzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE5EC433C7;
	Wed,  3 Apr 2024 19:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174070;
	bh=qZN2hJpnCDd8EWchAl3M1u0cB/a97vB9HCwXho/fp5I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VaN+YfzZlTYgIGlwfIaPxLKb5fI+JHKIWRchnK0SZnPZe0Bxu1GmfBdeDNKNuvR0Q
	 uuK4YHLF9gsa1DobE4pCUITJ2vXHHD92tY2WEKWRYYHXMXpEuLTi6mWEVcwMaLyQ+9
	 JHL2Nvf8aJHk9gEcjQ7NJQoUnuYJ06Ocfh0VSz2pfxYSjs7/553j8Sc8b4TdZkPhDb
	 Sk3zJcbJJx5D0RkijWwBheXogwtFfxPNrtsWwROS1I3175/0Bv+n20oH3cCepoNchy
	 +fbG8r5QbVGVh4fPigrbWYN9jK2F5VCRhkzq/Yhp4mJdrPhUd5z2xmYk90NObBBgKJ
	 y8EmFM/i+wErw==
Date: Wed, 3 Apr 2024 21:54:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
cc: Max Staudt <max@enpas.org>, 
    Roderick Colenbrander <roderick.colenbrander@sony.com>, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] HID: playstation: DS4: LED bugfix, third-party
 gamepad support
In-Reply-To: <CAEc3jaBvM6zVAqecUaxbtwUOTni4yT0wum_5ab5N1DLVYvhOeQ@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2404032154040.5680@cbobk.fhfr.pm>
References: <20240207163647.15792-1-max@enpas.org> <nycvar.YFH.7.76.2402271740260.21798@cbobk.fhfr.pm> <nycvar.YFH.7.76.2404032010320.5680@cbobk.fhfr.pm> <CAEc3jaBvM6zVAqecUaxbtwUOTni4yT0wum_5ab5N1DLVYvhOeQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Apr 2024, Roderick Colenbrander wrote:

> > Roderick, please speak up now, or I'll queue this as-is for 6.10 in the
> > coming few days. Thanks,
> 
> Hi Jiri,
> 
> Sorry for late reply, let's merge it. There are maybe 1-2 nitpicky
> things I forgot to email about, but I can deal with those later if I
> feel it is needed down the road.

Welcome back! :-)

Now queued in hid.git#for-6.10/playstation. Thanks,

-- 
Jiri Kosina
SUSE Labs


