Return-Path: <linux-kernel+bounces-1430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B7814EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678901F24810
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184233011F;
	Fri, 15 Dec 2023 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jHJfNHKo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBD30108;
	Fri, 15 Dec 2023 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8147940E00C6;
	Fri, 15 Dec 2023 17:37:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rb52ClGutCPv; Fri, 15 Dec 2023 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702661845; bh=L/eQchWNcZ+GPbxxL6Z1CyW4o2naLvFk2gMbKMczlLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHJfNHKoPxhrxJahFXjpcEdTG+QLB74z64Lwg5u3qdBPRe50hzFIBz/BXqUpvbSLx
	 P+dA8fwi7PU63uOpq0hUxFY6BrUlZh/7SPmdYoFC6e7mu5jd3W26LooHdsIwIsj3sG
	 qIOwGMk6x7dlOY1RLJZqJ7wqmKqRjcyFInQDOQzWTUh0YPdylZIUPQh+KdDOG9Hgxe
	 S/tRuTHhh4nABOFxqOFWzHEMDe6CfinpW8x1IYzCghewSnXfSMLDp32a+dxiwtxvHB
	 aGhWt6W3ecFgfOvQ6JvGcef4g9oVGQHAs4mfa0O+984LrGBa2MKNTLX0nBMxw+DSuU
	 aFfkFhsuCRSh4fKmWDI7uU5UDAPizhv9YxuHr+Y9SjZnxAm/sx8kPHVea1mh9kqR15
	 MeVcsXlaNh+88GwcYBJl9SvVpIY+6i6jRMonYdczmyEVNnZ0oKC7VM8MmXxs0aoiD9
	 7hOW2L+mIf0XSFMi+MmqQPqryK0aqC07kBhy0kklNREKiDgLuLCGBzOjXZ384wMUfG
	 5ifzB5vLQIY+dWsEJ4m1noRxpq5050SQUV6hDRF7sbLm+OuAlFou77lVgkQdevDdJk
	 VvNiqY/rMBlq7Qj01GDxO8wNeovL5TS0qPFozkNNB5zGnNXtuNYgmtQX/OizQW6Bj9
	 41gVlQncpOKLrvsS7B7RYv64=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E22F840E00A9;
	Fri, 15 Dec 2023 17:37:20 +0000 (UTC)
Date: Fri, 15 Dec 2023 18:37:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: ras/core] x86/mce: Handle Intel threshold interrupt storms
Message-ID: <20231215173714.GBZXyOymaUEB5tvMYP@fat_crate.local>
References: <20231115195450.12963-4-tony.luck@intel.com>
 <170265660288.398.1352223643373155784.tip-bot2@tip-bot2>
 <SJ1PR11MB6083E1B502165AA27D685AB7FC93A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083E1B502165AA27D685AB7FC93A@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Dec 15, 2023 at 05:21:12PM +0000, Luck, Tony wrote:
> > The following commit has been merged into the ras/core branch of tip:
> >
> > Commit-ID:     1f68ce2a027250aeeb1756391110cdc4dc97c797
> > Gitweb:        https://git.kernel.org/tip/1f68ce2a027250aeeb1756391110cdc4dc97c797
> > Author:        Tony Luck <tony.luck@intel.com>
> > AuthorDate:    Wed, 15 Nov 2023 11:54:50 -08:00
> > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > CommitterDate: Fri, 15 Dec 2023 14:53:42 +01:00
> 
> Early X-Mas present for me!  Thanks Boris.

:-)

You're welcome - thanks for answering my silly questions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

