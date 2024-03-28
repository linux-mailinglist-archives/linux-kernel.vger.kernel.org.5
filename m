Return-Path: <linux-kernel+bounces-122424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C72088F737
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8CF1C24315
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE0745949;
	Thu, 28 Mar 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftCGu+1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60400D304;
	Thu, 28 Mar 2024 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603613; cv=none; b=byNtoDNEGGaM1NCl1KzyjXNJiy5Jxt9wsHUvtYU/qn0653O7eB8blcnsrc9lVKNn9C5fgFayIciRvqffD8l6dQlBVfhLsxaMA9KWppKrwRIYWIWgAOTYYLUByOjdXatmTVyEd79t3WRQafX39ZHJdWm7I82yvkFygANRVT9WNN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603613; c=relaxed/simple;
	bh=nNDoNeVkx3lsLGt6cZnB5tXn8fXGFUJdOBK7O79ATdU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ECB89x2SawtFL3czzWGXy/qsAXwupcylgEvHtIShjwRUXl3vSNrgGvXGIykA76Llyr6VilWqQUsJPM4A4hjCC9eNhnhTQQ54LZrNTzmx6/hbp47OiE3+/vyomTOSMEsPn1nKifiBzF2FyRhU7f4/i1C/TXCcRp8mIHxglBq6hwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftCGu+1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B59AC433C7;
	Thu, 28 Mar 2024 05:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711603612;
	bh=nNDoNeVkx3lsLGt6cZnB5tXn8fXGFUJdOBK7O79ATdU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ftCGu+1tDZdMw5dOxoF9vvq5lW+Otcl56AJxf643bHo1VJ5VGf/spkG0S6e7keS5b
	 3YNukZhqfwv456jxgF36e0xgoYG9zhIvJ3ttaQMH1AmV7s4z4+ebybPPFVp/yWcEks
	 KTFqAXz+7ILgE0JfV3qaWxjhhNGCkNQNdyzjd9gjl4Eao1JD17HQIc8fg8HktBRAvq
	 mY2JoV0CP4Gh/xYYJckAjNUOhn2bEJ3Sq2Iav8rMsI/3plZC/CbSS3zyIfLeu74Z08
	 9cxeC7lc6pVCe+mmmOKY3oQAQpEFVNOKkL9Xtd92UTp5BLZ/wrDVG7EpC6XAoUg90Y
	 9rflje1TTvQDQ==
Date: Wed, 27 Mar 2024 23:26:51 -0600
From: Kees Cook <kees@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
Subject: Re: __randomize_layout;
User-Agent: K-9 Mail for Android
In-Reply-To: <SJ1PR11MB608346DDA3F41ABB893C7860FC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB608346DDA3F41ABB893C7860FC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
Message-ID: <1B6E0664-D1B5-4FCC-A874-8A9587924687@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 27, 2024 9:21:59 AM MDT, "Luck, Tony" <tony=2Eluck@intel=2Ecom> w=
rote:
>This e-mail is to check you on whether that __randomize_layout can shuffl=
e the
>fields inside that nested union/structure=2E I tried some experiments, an=
d in a
>few kernel builds I saw the whole block move to different offsets, but th=
e order
>of x86_vendor, x86, x86_model, and x86_reserved was preserved=2E

Yes, this is an intentional behavior: __randomize_layout will only apply t=
o the struct it is attached to, and is not enabled for any substructs (anon=
ymous or otherwise)=2E

>But experiments aren't proof=2E Nor defense against future versions of
>scripts/gcc-plugins/randomize_layout_plugin=2Ec becoming smarter or
>more aggressive about changing layout=2E

The behavior is also supported natively by Clang -- neither implementation=
 is likely to ever change its treatment of substructs as it would kind of c=
ause chaos=2E

So you're all good! :)

--=20
Kees Cook

