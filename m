Return-Path: <linux-kernel+bounces-929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECF814829
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF6C1C23550
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4452C69E;
	Fri, 15 Dec 2023 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b36cOM1C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5B2574B;
	Fri, 15 Dec 2023 12:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D714FC433CB;
	Fri, 15 Dec 2023 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702643670;
	bh=FKxZBM/eGnkcCWYq8ROqWWg4oGWQUMqw+sFNUzKW6/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b36cOM1C5UV7HdfqDsWF5sWuveQJXujHtiSXuKWT5dtHcXCspO+ncwxNERXQ++q8A
	 iGM45bHMBWXS7IxdnbSE08EMqH59r7xE0AoDkqtdNVjKKOOUqiXfxmiT8oCOttqtsd
	 Y7T2RhT3GEcw+dUCXsw0Xfoq4mk27lPSYdhz2qgQ=
Date: Fri, 15 Dec 2023 13:34:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Piro Yang <piroyangg@gmail.com>
Cc: linux-staging@lists.linux.dev,
	Linux Outreachy <outreachy@lists.linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging:vme_user:fix the issue of using the wrong
 error code
Message-ID: <2023121505-viewer-kindle-5ed5@gregkh>
References: <20231211173610.106501-1-piroyangg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211173610.106501-1-piroyangg@gmail.com>

On Tue, Dec 12, 2023 at 01:36:10AM +0800, Piro Yang wrote:
> the error code of ENOSYS indicates Invalid system call number, but there is not system call
> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  v2: split two different changes,
>      only fix the issue of wrong error code
> ---
>  drivers/staging/vme_user/vme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:
- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

