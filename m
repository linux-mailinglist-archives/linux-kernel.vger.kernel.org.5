Return-Path: <linux-kernel+bounces-3572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADE816DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2C31F22B74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05307D60B;
	Mon, 18 Dec 2023 12:36:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203D199B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Stzkc708yz9xn3d;
	Mon, 18 Dec 2023 20:33:12 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 18 Dec
 2023 20:36:39 +0800
Date: Mon, 18 Dec 2023 20:36:38 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Sohil Mehta <sohil.mehta@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>
Subject: Re: [PATCH] x86/setup: remove duplicated including
Message-ID: <ZYA81v/l4eWUxZKk@fedora>
References: <202312151755+0800-wangjinchao@xfusion.com>
 <16028dde-261a-4403-8165-f0a8b70f13fa@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16028dde-261a-4403-8165-f0a8b70f13fa@intel.com>
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

On Mon, Dec 18, 2023 at 05:27:46PM +0530, Sohil Mehta wrote:
> How about rewording the above to?
> 
> "x86/setup: Remove duplicate header includes"
> 
> On 12/15/2023 3:25 PM, Wang Jinchao wrote:
> > rm the second #include <asm/efi.h> in setup.c
> 
> > rm the second #include <asm/spec-ctrl.h> in smpboot.c
> 
> Actually, these two lines are evident from the diff itself. You can
> remove both of them. If you really want to have some text in the commit
> message you can probably just say:
> 
> efi.h and spec-ctrl.h are included twice. Remove the duplicate entries.
> 
> > 
> > Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> > ---
> >  arch/x86/kernel/setup.c   | 1 -
> >  arch/x86/kernel/smpboot.c | 1 -
> >  2 files changed, 2 deletions(-)
> > 
> 
> With the above changes, please feel free to add:
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> 
Thanks for the suggestion, which has been applied to the v2 patch.


