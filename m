Return-Path: <linux-kernel+bounces-155628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020B58AF4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B323C28409E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2796D142634;
	Tue, 23 Apr 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pbkb08cg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D038142905;
	Tue, 23 Apr 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891874; cv=none; b=Dv3FbKOSSD9lqNUVwVbxZgWv60ZNWwQGtIdr8xpnOaS62LNm9Ks1xDviUyxrffpMH3vbsIWdcBRjqPz8HbAvCQdJM0UbYirDWCy1EUklncqUYZGzpjghP7+Z+e2ldg1Y66eEcujOG4PLpWUo6bqY2FFCTX5o4V6oeyH0vv7Ep8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891874; c=relaxed/simple;
	bh=iTC+KKiwkJXbXS1hp2OGa6puxVm/ExguRDCl8EZcKUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvYCXvR6j3rQlv6r8hJsBfl1twDIvNw/9uTNPYAfZrn22zYfgBW2WceYTb7Hj4lhmEoFZHtf6S3BtEJI3CDqMJqB8KuGnYctpjdBYKxKdAYZwLgQIAT/TFmRAjpJ70gr73E2FpkQHwv0y9GXlMKv8Zq88bGtoKz5idKQ+MZdXk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pbkb08cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64AC2BD10;
	Tue, 23 Apr 2024 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713891873;
	bh=iTC+KKiwkJXbXS1hp2OGa6puxVm/ExguRDCl8EZcKUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbkb08cgxAMYnkBe+tstbgqqzhOEilPkHH1LLMakEpIQolwQLByymguIfxMfkkCZU
	 5wKqn/FoK2+oengNiSdNln9StXOMtZV0RATyCr4ekYA9qBTqSNr5nfYGDuBqxeu4iG
	 nn3X4gOLgnzBADGM7MdwUPyi1Y8+DAuUIYLh1YnE=
Date: Tue, 23 Apr 2024 13:04:32 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/2] Documentation: process: Recommend to put Cc: tags
 after cutter '---' line
Message-ID: <20240423-light-intrepid-aardwolf-7ebf85@lemur>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-3-andriy.shevchenko@linux.intel.com>
 <871q6wrw12.fsf@intel.com>
 <ZifHnw1cxgP77MKx@smile.fi.intel.com>
 <87ttjsqbld.fsf@intel.com>
 <Ziflr9ag4Nl2lTic@smile.fi.intel.com>
 <87mspkqajj.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mspkqajj.fsf@intel.com>

On Tue, Apr 23, 2024 at 08:00:16PM +0300, Jani Nikula wrote:
> Imagine the commit message Cc was named "Attn:" and handled
> appropriately. That probably reflects a lot of commit message Cc 
> usage.

This is especially the case for get_maintainer.pl purposes. Adding a Cc: 
in a commit message means that this person will be included on patches 
referencing this commit (e.g. via Fixes:).

-K

