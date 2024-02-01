Return-Path: <linux-kernel+bounces-48956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B9684639C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4F01F23129
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF074652D;
	Thu,  1 Feb 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FpYQADfV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770846450;
	Thu,  1 Feb 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827528; cv=none; b=TjwKin9W+DtHkKIEtg+hAgnjpFqscB05X5W+5YbiX1pug5Xu9/nBsgR8BQaDn/QS8YJz2/fIlM6jfLqewiCtmjXLAiz3rex/FrAyy4+sQwShHO9S1mz+r0j+Zq7u30Xy6pefKOxXSXIpU2W77tSXs48WThMnBwuxJSlIP2vUhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827528; c=relaxed/simple;
	bh=8XBsL1A3aw113J/qN7bYoaY80G0MxKQO+WepQk2DEv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edpKxjlcJN9jfxXVhxWpXZKTMwXt5bKZYycDrrvKRG6HXEzBW/GuO2db5XIEgdgLi3ULTdfbBBTMhd7MHAWwOX4lporOhk0O4APH3lP9GS2ROQfR2QzhH19fMJ2YbEsuCyRMlSKLmHJxZWm0lANwx4kSRaeLTEDZVldUZ6jsPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FpYQADfV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706827524;
	bh=8XBsL1A3aw113J/qN7bYoaY80G0MxKQO+WepQk2DEv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpYQADfVXKnGEWMRmWDQtH4LIDnaEbuZNL3BoumMJBVO7Xn0UhBwe/HT5RI0eq1AX
	 Lrjpj+4IK8ZLpn9UpbZtR7DX7S1owvOEsG6cAJJ553AL1lMgyFxm38XnLw3mroeS3y
	 NisNe6PwIHC6S3vAMBsbd7C0HOe/c5M4h+wGwSkP21c/KMEB78WF0RupAJD1qYRe3o
	 IT6hWJZZsW1HFyvrOUBSFWOIOh5AJJeuII3NgKhiHKYV94UNhecjbRdrDjFKm/iebs
	 hRp4gsU2pT3Vy7prWQi21QDMg42Zywu3zXGzi9p225Jf3m25eXEluIf0fqjPKZx8vJ
	 HQpckr/ElAycg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 78D45378208C;
	Thu,  1 Feb 2024 22:45:21 +0000 (UTC)
Date: Thu, 1 Feb 2024 17:45:19 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <679fa364-28d0-4faa-b46e-805faf56ae53@notapiano>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
 <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
 <ZbA4VthTMPT7BSRo@google.com>
 <2024013059-poison-equation-81d1@gregkh>
 <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>
 <2024013012-gully-goofy-2a55@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024013012-gully-goofy-2a55@gregkh>

On Tue, Jan 30, 2024 at 04:23:02PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Jan 30, 2024 at 04:01:57PM -0800, Brian Norris wrote:
> > On Tue, Jan 30, 2024 at 3:51 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Tue, Jan 23, 2024 at 02:06:14PM -0800, Brian Norris wrote:
> > > > "Don't you want to have a driver data or so associated with this?"
> > ...
> > > But why limit yourself to 32bits now?  Why not make it 64?  It is going
> > > to be sent to userspace, so you have to be very careful about it.
> > 
> > Is that question related to the question I pasted/replied to, about
> > driver data? Or a new topic? Sorry if I'm misunderstanding.
> 
> Same question, driver data, you make it 32 bits.
> 
> > Anyway, for the size of the tag field: I don't have a strong opinion.
> > But FWIW, they're coming from this project:
> > 
> > https://review.coreboot.org/plugins/gitiles/coreboot/+/269b23280f928510bcadd23182294e5b9dad11ec/payloads/libpayload/include/coreboot_tables.h#36
> > 
> > As you can see there, we're extremely far from exhausting 16 bits, let alone 32.
> 
> We've run into running out of bits in other subsystems before, it's
> "free" now, just be safe and make it 64 like I think Andy is suggesting.

Either you and Andy are suggesting different things, or I still don't quite get
what you mean.

Andy was suggesting we added a driver_data field, that is:

struct coreboot_device_id {
	__u32 tag;
	kernel_ulong_t driver_data;
};

You're suggesting we make the tag 64 bits long:

struct coreboot_device_id {
	__u64 tag;
};

Like Brian, I'm not sure I see the benefit of either change. As he said, it's
unlikely that having a driver_data would provide any benefit and won't ever be
required anyway, and 32 bits is already a generous space to give to coreboot
tags. That said, I'm also not against either change, and can apply both of them
to the next version if that's indeed what your experience says will work best.
I'll wait another week or so before following up though to make sure we're all
on the same page.

(To be honest I also still don't see how this struct makes it to userspace and
is considered ABI, I only see the generated modalias being ABI and hence 32 vs
64 bit tag is ABI breakage but not adding driver_data, but I'll take your word
for it for now)

Thanks,
Nícolas

