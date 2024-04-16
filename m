Return-Path: <linux-kernel+bounces-146513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BE8A6669
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD361F21C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9B83CD2;
	Tue, 16 Apr 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xx2DwsPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C91629
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257310; cv=none; b=upMHfhIO6wJy8kcOWhNVvVMQY1VmhEMn16b6ZeZ9vRPyTnZh1XY4tIgGyDxhOWdo3jXa6h5WrX1pa4HQDOIZDk5ZAO4a141/dW3x9jS3CzOCndAW8+xhNqNiOzNbXOSiBDupwgte2f1uPdqjcVQCMratGEeexhBKl5Q//E2twp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257310; c=relaxed/simple;
	bh=V+oDn0QCdhCQ8aFwN1VCxY0M9KNpWGzlOPZFuRgwIKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4tM1pjQcEOV5PwH3strerPFkxBSoVtfCFegX/rwX3girEgpkdSqe9pOJQInrr3odGPyBOHBqbQthPW4TSfNSWM6weOWiQTmfWobei1azWysJAkn9cnYCX79YYy6H/udw7fwPnzcHco8UELzYNB3pwr+G7WDZhGNE4RSkicX0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xx2DwsPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE58DC3277B;
	Tue, 16 Apr 2024 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713257310;
	bh=V+oDn0QCdhCQ8aFwN1VCxY0M9KNpWGzlOPZFuRgwIKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xx2DwsPaaQX5+4GQ4gbxz+UmI2v2AcRc0WW7+xc4iLqaSwwQ9Vl5fUzvBWETjD382
	 54FHdwN16TqERSj26B4AJ7p7Idpwf8y5iDG5wy43eDmb1uv4EBcmNV4ZRl/bTJTESd
	 MzaaTr1Y7quWkqpiLxUVJ0Ej/2a8atJ35Ylyy27A=
Date: Tue, 16 Apr 2024 10:48:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prasad Pandit <pj.pandit@yahoo.in>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH] checkpatch: error if file terminates without a new-line
Message-ID: <2024041627-overgrown-ripping-2348@gregkh>
References: <20240330033858.3272184-1-ppandit@redhat.com>
 <1568855168.5949322.1713251087824@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568855168.5949322.1713251087824@mail.yahoo.com>

On Tue, Apr 16, 2024 at 07:04:47AM +0000, Prasad Pandit wrote:
> [+linux-kernel]
> 
> On Saturday, 30 March, 2024 at 09:09:12 am IST, Prasad Pandit <ppandit@redhat.com> wrote: 

Why are these lines in a changelog of a patch to submit?  That's not
going to work :(

I suggest taking some time and talking to some other kernel developers
in red hat as to how to submit changes, that will make things much
easier.

> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add check to flag an error if a patch terminates a file
> without a new line (\n) character.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Also, I see 3 different emails for you here, none of which match, pick
one for kernel development and stick with it?

> ---
> scripts/checkpatch.pl | 7 +++++++
> 1 file changed, 7 insertions(+)
> 
> -> https://lore.kernel.org/all/CAE8KmOxG=3sWKpeB5fdWTK-SCipS=JyDE-_DNgY--DtoSQZ0Qw@mail.gmail.com/T/#t
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..df34c0709410 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2795,6 +2795,13 @@ sub process {
>             $is_patch = 1;
>         }
> 
> +# check if patch terminates file without a new line (\n)
> +        if ($line =~ /^\\ No newline at end of file$/
> +            and $rawlines[$linenr - 2] =~ /^\+.*$/) {
> +            ERROR("NOEOL_FILE",
> +                  "patch terminates file without a new line (\\n).");
> +        }

Why is this a problem?  files without a new line should not cause
problems with a compiler, right?  You don't have a justification for why
this change needs to be checked for anywhere.

thanks,

greg k-h

