Return-Path: <linux-kernel+bounces-160988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF38B457A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D381C2123F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DB8481B1;
	Sat, 27 Apr 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpUrxbS6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6538DD3;
	Sat, 27 Apr 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714212601; cv=none; b=L6QN4z9i5p/gTTgL2zx+fI6Tf2BCn3GxVedAEw2iNV1UEN19O9Q/ghssoKGRFgPUTO/sOy/Lwmw6JVqSw1ixGd702ePPVAt0gsvvNZP6KVtx/PuE3OoL7a8iC8yB+aDf7QqA8SCxJZU5kIvETOuolQ4//rxw2avIyixsCpsOia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714212601; c=relaxed/simple;
	bh=t5/MRahSsfUd6CRK81ZloNGyOeQGhk68mymtXtOpCn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo/G9oSAxTFja2otnD/8yHp0QRpUqUeA+7U69QukjQh0MOB908f/eUcLuG5UZy/ueceSStEqFmk3d+t/B4ZchUkbIZTtdaEYCuYLgpAc00TWlHCiOaiTVDOTKa/CCRU57iHK5ig4T/gbuXJm8/0zRnv0u5OZpMcceepeEHqbl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FpUrxbS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E45C113CE;
	Sat, 27 Apr 2024 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714212600;
	bh=t5/MRahSsfUd6CRK81ZloNGyOeQGhk68mymtXtOpCn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpUrxbS6GwbDqn3/W8eVbFqCO17d8MG/7k8qsHu6CRCG2rUaD1lHhUBO4bDEFghU6
	 heLuAyvt4JTOpcuCQaJTEcMgnXgp798Y11kltE4EuoQhm+cUz2bWeMpQsmIhkHG5BB
	 fC73C9osHcVV2BLHpV3Zbb2iFmmajIi1nOaKk5fM=
Date: Sat, 27 Apr 2024 12:09:56 +0200
From: Greg KroahHartman <gregkh@linuxfoundation.org>
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: Sasha Levin <sashal@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs: stable-kernel-rules: fix typo sent->send
Message-ID: <2024042715-repossess-unshackle-a078@gregkh>
References: <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>

On Fri, Apr 26, 2024 at 11:18:14PM +0000, Bird, Tim wrote:
> 
> Change 'sent' to 'send'
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>  Documentation/process/stable-kernel-rules.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index 1704f1c686d0..3178bef6fca3 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -78,7 +78,7 @@ in the sign-off area. Once the patch is mainlined it will be applied to the
>  stable tree without anything else needing to be done by the author or
>  subsystem maintainer.
>  
> -To sent additional instructions to the stable team, use a shell-style inline
> +To send additional instructions to the stable team, use a shell-style inline
>  comment:
>  
>   * To specify any additional patch prerequisites for cherry picking use the
> -- 
> 2.25.1
> 
> 

Thanks for this.  If Jon wants to pick this up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

is fine from me, or I can take it through my tree as well.

thanks,

greg k-h

