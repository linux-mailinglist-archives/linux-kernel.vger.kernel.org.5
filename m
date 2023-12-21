Return-Path: <linux-kernel+bounces-9007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B681BF34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF71C24219
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E436651BB;
	Thu, 21 Dec 2023 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OGoLG9TF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768A651AC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491C8C433C8;
	Thu, 21 Dec 2023 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703187828;
	bh=3f4LLHOYQ9vIXC3yu9JguC4DcowbIKg3jo/PtkCxKgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGoLG9TFPFAYjYUxeCsafqcHSwmwba3n0j/eQLkISCr6+C8TEHoYtOnYNTDvepTbY
	 riVCjqUBFz9GqL9wZ1VUEwqTaeS66AHaa5fUqs7xCVgIHh63wdZ+4n9fhBZxZapubN
	 OpTpNSezmC0erIOyoMkBtEYYhjaXN5eaDWCfrGoY=
Date: Thu, 21 Dec 2023 20:43:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] debugfs: initialize cancellations earlier
Message-ID: <2023122118-stopper-sizably-cc59@gregkh>
References: <20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>
 <2023122129-seclusion-qualm-3084@gregkh>
 <4b2fbac42345acb21ac2bdfe6abd4fb4a00bb8c6.camel@sipsolutions.net>
 <2023122129-distress-sanding-8449@gregkh>
 <2d760360e1f47783166365110f8473fadfbc80a3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d760360e1f47783166365110f8473fadfbc80a3.camel@sipsolutions.net>

On Thu, Dec 21, 2023 at 07:55:13PM +0100, Johannes Berg wrote:
> On Thu, 2023-12-21 at 18:17 +0100, Greg Kroah-Hartman wrote:
> > 
> > But this doesn't apply against Linus's tree, 
> 
> Hmm. It does for me?
> 
> $ git checkout linux/master
> ...
> $ curl -s https://lore.kernel.org/lkml/20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid/raw | git am -
> Applying: debugfs: initialize cancellations earlier
> $ 
> 
> > or my driver-core-next branch now,
> 
> Right, it doesn't apply there, that was branched out from v6.7-rc3.

Ah, yes.

> > where should it go?
> 
> I think/hope to 6.7 still, since it fixes something that only got there.
> 
> Looks like you routed that other debugfs patch (the lockdep revert I was
> talking about) through char-misc?

I did, sorry for the confusion, too many branches/trees...

I'll queue this up in the morning, thanks.

greg k-h

