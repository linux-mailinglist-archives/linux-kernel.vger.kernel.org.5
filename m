Return-Path: <linux-kernel+bounces-93032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7438729E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF06DB20EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F712D1EF;
	Tue,  5 Mar 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWRrk7DJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBA41760;
	Tue,  5 Mar 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676172; cv=none; b=ljjZmZsrGR4ZZ5tTKk1XzjyXbmnt5P4CeyL8IQcPgD7RPcA8gFbXFwj/XjcmyXlq27ZdNY48Ze/i4mSatM1xUQfbVyuSHKL+4L4PTcnGgmv9AfzG4OGJgNGl2Diq2aJk0t5I2s6BBz/rYIiyslQpBDd76Sd3lS4309LSm3CJoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676172; c=relaxed/simple;
	bh=ElHvygI1GSUn+CYLCtdELo1XeJgf4EVjHp1j+MhkPyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2kdV8koIZbaCOs+ClyjMwlCk7bcfpQrhBliV25A9fQl7sH9YF2ss0yc4jSBYpWURTqCdXmcz8/tDK8hr/qQtb/o+PnSNAQ/ayRddvQw2HW0ugWZHkpfVorX4SAs+8f70b1CFfYd9WhOnuoysDccAFTiTVn4d92LZjZuY4r8HGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWRrk7DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A0CC433C7;
	Tue,  5 Mar 2024 22:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709676171;
	bh=ElHvygI1GSUn+CYLCtdELo1XeJgf4EVjHp1j+MhkPyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWRrk7DJqPCUihkP+KZiJytDMtCPio79CYeLRwxQZTXe1dj15+4hwAMCh0UHbkRzD
	 mPowsTFjI4fFhVQsg5oh0msf717JW/dDRfin06qdLeKmokcy1eJK4cq+onIFQrB5EQ
	 rxQkV6MmQ6pfrPLYvW1gVbVlIl3kYl98ifqawqZE=
Date: Tue, 5 Mar 2024 17:02:50 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, 
	Babu Moger <babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	patches@lists.linux.dev
Subject: Re: Cover-cover letter for two resctrl patch sets
Message-ID: <20240305-uppish-rare-beaver-f652ce@lemur>
References: <20240228112215.8044-tony.luck@intel.com>
 <b11c545a-7bf4-403e-99cb-38db777fd8ab@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b11c545a-7bf4-403e-99cb-38db777fd8ab@intel.com>

On Mon, Mar 04, 2024 at 03:07:38PM -0800, Reinette Chatre wrote:
> Could you please instead send the two series separately
> and note the dependency in the cover letter?

FWIW, we're including ability to auto-retrieve and auto-apply dependencies
with b4. It already works with preprequisite-patch-id trailers (as documented
by git-format-patch), but we'll also add prerequisite-change-id in the near
future as well.

-K

