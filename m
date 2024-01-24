Return-Path: <linux-kernel+bounces-37500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334A983B0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26A428A62F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FFB12A172;
	Wed, 24 Jan 2024 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8mDSddw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A807F7F2;
	Wed, 24 Jan 2024 18:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120357; cv=none; b=SAfOD6aIbZHtknoH2p/tvHuoyaX0yM+GoBAlu2gE5OY9DpZD4/2LeMUB+4J/E9D4GvRleiEKlKTp3ZkJohGg56lwEoRlhd6uygnTo8MK0yy7idiUyihKcRrD0CMhlVcUtLVEY+y4cQlWQbDnLPIcOMvhDghsAyS0HNmk0iWvtTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120357; c=relaxed/simple;
	bh=fu+WDFHPoM2Kn0sOnwkBIKYDNv9+uDzbcq78InGY8sI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a6AyHGR8JzaWxcXWL79bxBL3yNolE5kWv5qs1i1tZONYjwus33HgNxLBKwDMZJ40z+9XdchURX/3CzzHe7GYCzyxy75gEV2q86aISv4rPKRtDGSlPk261jKwy3QOYegeWcKSUy608yq/1sQLJJKnRk4BV2rb5tw+Vsmu9nGSBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8mDSddw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69C2C433F1;
	Wed, 24 Jan 2024 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706120357;
	bh=fu+WDFHPoM2Kn0sOnwkBIKYDNv9+uDzbcq78InGY8sI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=d8mDSddwYEH+Wr/Fw37NimgJB8ZDYK9KWfzZWfQdByKN1aSLAItIjs8VX+gs7Sg0b
	 OvKjAvTvymZe0lzNJxlX3+3Byjx/yhXDqKrjBL8gmZjQk3DzW9bZkYtGBAcymisBdA
	 cJs6KNhjF2yPmjYFv6jy9HjtuJLnR2De6IGws4Obhhr8d+fB/WUQt5daKmPy5xzokm
	 SoZArbMS9mBhjx9dTQ1M3wdkza6b3q+zea/okBOXEaGLDQ4n0mzepjG4SleEGBTsPj
	 XjmZQ1iHoJ+wn1sxjVwGlZqXT3nvXGCQMTwShM1pQ0HZUlhvOnheZS3YUb1RbUi5Lj
	 q3igeEtfYcDfw==
Date: Wed, 24 Jan 2024 19:19:16 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Sandeep C S <sandeep.cs@samsung.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    gaudium.lee@samsung.com, ih0923.kim@samsung.com, suhyun_.kim@samsung.com, 
    jitender.s21@samsung.com, junwan.cho@samsung.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [HID Patchsets for Samsung driver v3 3/6] HID: Samsung : Add
 Samsung wireless keyboard support.
In-Reply-To: <20240124161029.3756075-4-sandeep.cs@samsung.com>
Message-ID: <nycvar.YFH.7.76.2401241917490.29548@cbobk.fhfr.pm>
References: <20240124161029.3756075-1-sandeep.cs@samsung.com> <CGME20240124161121epcas5p1fef1a14624b26cc436b899d9f6cde164@epcas5p1.samsung.com> <20240124161029.3756075-4-sandeep.cs@samsung.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Jan 2024, Sandeep C S wrote:

> Add Support for samsung wireless keyboard with input mapping events.
> 
> Device 7021 (Samsung wireless keyboard)
> 
> Signed-off-by: Sandeep C S <sandeep.cs@samsung.com>
> Signed-off-by: Junwan Cho <junwan.cho@samsung.com>
> Signed-off-by: Jitender Sajwan <jitender.s21@samsung.com>
> ---
>  drivers/hid/hid-ids.h     |   2 +
>  drivers/hid/hid-samsung.c | 108 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 110 insertions(+)
[ ... snip ... ]
> +#ifdef CONFIG_HID_KK_UPGRADE

Where is CONFIG_HID_KK_UPGRADE coming from, please? This is the first time 
I am seeing it, and it's definitely not being introduced by your patchset.

Thanks,

-- 
Jiri Kosina
SUSE Labs


