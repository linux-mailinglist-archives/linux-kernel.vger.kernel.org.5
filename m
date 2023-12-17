Return-Path: <linux-kernel+bounces-2506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE5815E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B921C21357
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9F2187A;
	Sun, 17 Dec 2023 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDiAnXDH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F61860
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 08:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3AFC433C7;
	Sun, 17 Dec 2023 08:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702801619;
	bh=1fBFa7KnqQ9xWSZ26tjaNmTI8RnkhMSZXhtpjyFdnfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDiAnXDHn5dAWA9qFFiINt9xw1o/CbRr9bjk+ys6WhRA3bphw79azYh6wTjcamEP0
	 +/JIzvBON/ljeeJP+U7pHAB28tNXrfO67zys9IHh8zq2lu8423CKH1i8r0UwzjrWUx
	 PR2xce05ByNkIA9DoIpJbDLteQf5PenR1NmAQWuk=
Date: Sun, 17 Dec 2023 09:26:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Ren=E9?= Nyffenegger <mail@renenyffenegger.ch>
Cc: cristian.ciocaltea@gmail.com, masahiroy@kernel.org, cmllamas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Update comment (addition of gtags) in cripts/tags.sh
Message-ID: <2023121742-handed-upper-88a0@gregkh>
References: <20231216211232.2699-1-mail@renenyffenegger.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231216211232.2699-1-mail@renenyffenegger.ch>

On Sat, Dec 16, 2023 at 10:12:32PM +0100, René Nyffenegger wrote:
> Commit f4ed1009fcea (kbuild: add GNU GLOBAL tags generation) added support
> for the GNU Global source tagging system. However, this addition
> was not reflected in the script's header comment.
> 
> Fixes: f4ed1009fcea ("kbuild: add GNU GLOBAL tags generation")
> Signed-off-by: René Nyffenegger <mail@renenyffenegger.ch>
> ---
>  scripts/tags.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index a70d43723..cb9696134 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -3,7 +3,7 @@
>  # Generate tags or cscope files
>  # Usage tags.sh <mode>
>  #
> -# mode may be any of: tags, TAGS, cscope
> +# mode may be any of: tags, gtags, TAGS, cscope
>  #
>  # Uses the following environment variables:
>  # SUBARCH, SRCARCH, srctree
> -- 
> 2.30.2
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

