Return-Path: <linux-kernel+bounces-84778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C786AB73
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DBC1C21A97
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628C32C92;
	Wed, 28 Feb 2024 09:37:59 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF22364A0;
	Wed, 28 Feb 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113078; cv=none; b=NPiOqPK/sQCLmqr0cDpDVVjYl6Uzwg28pcUHMuaFQrmsYS9aSHStgWp5Q++yd28YiUvP4BpIfFbG4imXO4Hj0LAzYlEAsZtjZszXUFa3JpB7UxqBGtDMb2uPd9oRV2bu08kcHakKjDZfHuCxNSNa0gyxR//NZV+jUqvtvNomzPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113078; c=relaxed/simple;
	bh=ETYaCSTCkH/+x6alJrxspdKAkwPcQ5ZuvtIHKFHEJkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzc1Xk+ZBhbuhCFYkzmOlxsbp5BtRgu1DfSRx4ogMSj70K03M1OaUjvveLYFWIo92UgLaRGgVstE7tZsYhWgILWCsZU+JhAZinyuV/9VPBe37iwjlsuUmqN3U0xi1JdNbq73seejEPmMC8H7xtKZbyVJpKuwt6uDbfSl13nvjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp73t1709112824t9cd232h
X-QQ-Originating-IP: uiXyMgKtLbN8VY9dRXG13TTDgCSMYnB8CAd8jAB8A5w=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 28 Feb 2024 17:33:43 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: /+iK7ZpVlLRnFYQIv5bPn+DA7FSTSA0wbVyC272BNntqVw2UrL9cwcKu3+z6A
	aVv48q8z6t+BdRrZGMo4S6UlZcH2ug2GU4lMmWcvlL3AvbatMnx+U1xVSFOrwoYKPmGP5Ha
	pp3A6rvbKpwF/9UzxXCOXTIK+mKmFsE8bVy9x5W1BN1swglw3hxyajbrQ9mYED7hkqbyCgo
	PRuyOXxsRZfn3MN6LGExtwarMGz3QrE+GoqYPzMp+uiqv5BzzPg0oAkPYS0op0TpP95TjRn
	2IbRZ28bFFDbfO5b90nFT0QYI/TiDnOL6mKBVJcUrY5Mr5Hi+jIlYJ9eMQh0D/w5CGuwlNF
	vCg8GMr6mhOrtrGjDzFyJThHrohZAN8R0rl7zSLt/dImC6WM4n7aXX0o+gRMyc226sejq8s
	9AKO3UT4kFs=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12801957611283966463
Date: Wed, 28 Feb 2024 17:33:42 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: geert@linux-m68k.org, gerg@snapgear.com,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com, stable@vger.kernel.org
Subject: Re: [PATCH] mk68k: Fix broken THREAD_SIZE_ORDER
Message-ID: <673EAB52C5659E99+Zd799lrOHAVIdm3S@centos8>
References: <20240228085824.74639-1-dawei.li@shingroup.cn>
 <754c3acb-538d-45a1-84a1-0bebd02fd945@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <754c3acb-538d-45a1-84a1-0bebd02fd945@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Jiri,

Thanks for quick review.

On Wed, Feb 28, 2024 at 10:11:05AM +0100, Jiri Slaby wrote:
> On 28. 02. 24, 9:58, Dawei Li wrote:
> > Current THREAD_SIZE_ORDER implementation for m68k is incorrect, fix it
> > by ilog2().
> 
> This is not a good commit log. Incorrect in what way and why is the fixed

Agreed.

> version correct? And what is affected? Note you're referring to a change
> which was done 14 years ago. It definitely must not be that incorrect (for
> everybody).

It's 'right' just for current PAGE_SIZE & THREAD_SIZE configs:

// arch/m68k/include/asm/thread_info.h
#if PAGE_SHIFT < 13
#ifdef CONFIG_4KSTACKS
#define THREAD_SIZE     4096
#else
#define THREAD_SIZE     8192
#endif
#else
#define THREAD_SIZE     PAGE_SIZE
#endif
#define THREAD_SIZE_ORDER       ((THREAD_SIZE / PAGE_SIZE) - 1)

// arch/m68k/include/asm/page.h
#if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
#define PAGE_SHIFT      13
#else
#define PAGE_SHIFT      12
#endif
#define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
#define PAGE_MASK       (~(PAGE_SIZE-1))
#define PAGE_OFFSET     (PAGE_OFFSET_RAW)

But it's incorrect in generic/mathematical way.

Thanks,

    Dawei

> 
> > Fixes: cddafa3500fd ("m68k/m68knommu: merge MMU and non-MMU thread_info.h")
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > Cc: stable@vger.kernel.org
> > ---
> >   arch/m68k/include/asm/thread_info.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
> > index 31be2ad999ca..50faecd6fc5f 100644
> > --- a/arch/m68k/include/asm/thread_info.h
> > +++ b/arch/m68k/include/asm/thread_info.h
> > @@ -19,7 +19,8 @@
> >   #else
> >   #define THREAD_SIZE	PAGE_SIZE
> >   #endif
> > -#define THREAD_SIZE_ORDER	((THREAD_SIZE / PAGE_SIZE) - 1)
> > +
> > +#define THREAD_SIZE_ORDER	ilog2(THREAD_SIZE / PAGE_SIZE)
> >   #ifndef __ASSEMBLY__
> 
> -- 
> js
> suse labs
> 
> 

