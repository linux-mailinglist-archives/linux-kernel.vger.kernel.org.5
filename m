Return-Path: <linux-kernel+bounces-93278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327BD872D61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76181F24EEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B4BF4E2;
	Wed,  6 Mar 2024 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fdpvnQAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC388D52E;
	Wed,  6 Mar 2024 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694710; cv=none; b=e7gAA2mp1h44uW4vRBrcxUcGzalY6yL/r5z/1t79wMN1sRcW92RBO7s+gQ+etV4cui8NUhGqMd5cRnqPcV2gYK8AaWc0zJ8X7rStuATvWivWqUMhwODwWc0qG1++E2Mm0dKJaXKZnEAO7oB0m3jvENGxAjan3Um6YUFnGsqsByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694710; c=relaxed/simple;
	bh=58VcRiQTZSjcLPi8M729ux0GJeTmIkW30qWk/AP4e1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBZoAD2l39hXzf+cAhGbCiIQ+KrqlriDlMfFNM0cdmY4K3Tgag4C3Pxh8fe/HNa8eOi/zZmE/2Yfo/LcinTpcN0FI9OBLpIM9ahqHQTHBBL8O2uWMLfjiHjBJxOkeIhnti+tvnPxFtbNf6xcgJqtBdn97IGD0m/FXblCMeItGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fdpvnQAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148D5C433C7;
	Wed,  6 Mar 2024 03:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709694709;
	bh=58VcRiQTZSjcLPi8M729ux0GJeTmIkW30qWk/AP4e1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdpvnQARNfitU21vgTyfY+H+5wuo7pw40AUwsQtqCaVkc0/Q/0fCjjYkWUvq71rOG
	 wGV+iJAcygcCygBg6kyO4DsBEfmO8lphOXNk/e6T9ubfV/DdMG4VH603bvwyvIJLVm
	 q5R4keJKMJyxNz2IzuidYB7ASuikYGGVkTIxBqMk=
Date: Tue, 5 Mar 2024 22:11:46 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>, 
	"Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"x86@kernel.org" <x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, 
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, 
	Babu Moger <babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Drew Fustini <dfustini@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: Cover-cover letter for two resctrl patch sets
Message-ID: <20240305-amethyst-trogon-of-flowers-b732cd@lemur>
References: <20240228112215.8044-tony.luck@intel.com>
 <b11c545a-7bf4-403e-99cb-38db777fd8ab@intel.com>
 <20240305-uppish-rare-beaver-f652ce@lemur>
 <SJ1PR11MB608338D24D58E61B77B423F8FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB608338D24D58E61B77B423F8FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Tue, Mar 05, 2024 at 10:27:47PM +0000, Luck, Tony wrote:
> 1) Because of significant rebase changes, I dropped all the Reviewed/Tested tags
> from v15. But b4 seems to have noticed that part 5/8 wasn't changed at all since
> v14, and picked up some (but not all) of the tags for that patch:
> 
>   ✓ [PATCH v15 5/8] x86/resctrl: Add node-scope to the options for feature scope
>     + Reviewed-by: Peter Newman <peternewman@google.com> (✗ DKIM/google.com)
>     + Reviewed-by: Reinette Chatre <reinette.chatre@intel.com> (✓ DKIM/intel.com)
>     + Reviewed-by: Babu Moger <babu.moger@amd.com> (✓ DKIM/amd.com)

This is a feature -- any trailers sent to a patch that hasn't changed between
series will be applied to the new series. We don't apply this logic to any
trailers sent to the cover letter, which is probably why you aren't seeing all
the trailers show up.

> 2) My cover-cover letter created some linkage between the two patch series.

That's not an expected situation, which is why b4 doesn't do the right thing,
sorry.

> Trying to retrieve the 2-part v4 series with "git am" would pick up the 8-part
> v15. Using an explicit "-v4" does work to pick up just the 2-part patch.

Another option is to use --no-parent to break the thread at the cover letter
of the series you want:

    b4 am --no-parent 20240228112952.8090-tony.luck@intel.com

This option exists for these exact situations when unrelated series show up in
the same thread.
> 3) That b4 am picks up Reinette's "if you make these changes" Reviewed by from:
>   https://lore.kernel.org/all/12766261-26b2-4aa4-a735-c2380c4963fd@intel.com/
> [though I can see why it did and realize that we'll need "b4GPT" to parse
> surrounding text to figure out that it should skip that].

Correct, we can't possibly do the right thing there, which is why the usual
advise is not to give conditional trailers, or prepend them with a quote, a
pipe, a dot, etc, e.g.:

    If you fix these, then you can apply:
    | Reviewed-by: ...

> Should folks that offer a conditional tag mark that in the text somewhere to
> let b4 know not to auto-pick?

Using the above strategy effectively achieves the same result.

Best regards,
-K

