Return-Path: <linux-kernel+bounces-125158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1258A892154
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D416B1C24E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC08565D;
	Fri, 29 Mar 2024 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrneEMLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CBF1C0DD0;
	Fri, 29 Mar 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728731; cv=none; b=SnWTCZnTnUeJmmBm4bj7o4vADAVFBUZ1IN9briBLCcL1RYB4pC1mpnMUZspdAGKOYe8ZfM9dGL59DDYwYWn3UlRZrYvGVx4vNarxuWfFn/cYgMTK6N6DFryxADLB/8cB47OusXlaql80Y4hN3CGccbVXEHleDmRcbG0Pq9c/DC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728731; c=relaxed/simple;
	bh=w4yBZavzUXkQn94G7vCY2jveYKh91htV8qdZ+sg+9Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAol3SAitxshkRqYOkLFbQpXS5Q5Sv/45/i2Xd8E5OUj4VkIOrEY4774PHsxDvM+88cxlvrv08wuqqlsY2CHTpPhvpGdHRcTmxNr0kxAKRG0l2nMV5cCtKlIIDU7i9LTfWm5vke0U8X7CiqjVHOQBVWGMZQtNMX/qhvhaje2kpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrneEMLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95735C433F1;
	Fri, 29 Mar 2024 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711728731;
	bh=w4yBZavzUXkQn94G7vCY2jveYKh91htV8qdZ+sg+9Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hrneEMLRANp4gzufIXuN8LJGsQPzRxYhBkmnMjF+lLjkOssMi1IXGSLpP3+PiMgIr
	 FWUX46/y17ENCQCm5KNS/+Bcl3WAf13ITaFOn+ZoSVajTYpTh+pe55IS/H9eW5J43a
	 cVfwnChoPAYtMt+jTP8aMzbUfKwXbnUzG/QUffEZWr80ptzbY09JwgH/J8tI12ITBZ
	 +FIQCT65sYYSwGuSVvKTZCK5LODgfeeUrI/56roymZajZ4+jv4k6C4ADGibirEi6M3
	 6BkV8Ct+JeeBcOkweRyPIymOiHqmCw6nfeKoCOCTZ7GAE3dMS+OHKL3ta4x44lWJwK
	 axIcISCkvnS9A==
Date: Fri, 29 Mar 2024 09:12:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 05/12] firmware: dmi-id: add a release callback function
Message-ID: <20240329161208.GA279061@dev-arch.thelio-3990X>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145140.3257163-4-arnd@kernel.org>
 <20240329134917.579c3557@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329134917.579c3557@endymion.delvare>

On Fri, Mar 29, 2024 at 01:49:17PM +0100, Jean Delvare wrote:
> Hi Arnd,
> 
> On Tue, 26 Mar 2024 15:51:30 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > dmi_class uses kfree() as the .release function, but that now causes
> > a warning with clang-16 as it violates control flow integrity (KCFI)
> > rules:
> > 
> > drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> >   174 |         .dev_release = (void(*)(struct device *)) kfree,
> > 
> > Add an explicit function to call kfree() instead.
> > 
> > Fixes: 4f5c791a850e ("DMI-based module autoloading")
> 
> Not sure if this fixes tag is really warranted. As I understand it,
> your change only removes a warning but there was no actual bug, right?

Sort of, the warning is really pointing out that calling this callback
will result in a crash at runtime when the kernel is built with kCFI
enabled, which I would consider a bug.

Cheers,
Nathan

