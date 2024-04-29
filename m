Return-Path: <linux-kernel+bounces-161879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216E8B529D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE21C20EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B5215E90;
	Mon, 29 Apr 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fWgtLpMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBF514AA3;
	Mon, 29 Apr 2024 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377103; cv=none; b=UacXx7Q/r5HLjexo0hTQYKfHvExqDrDd/uTCY/rEFspemZYrjlinGNGZMEKhNmXR0ZNbTw32jW0LOVhGjJkfADpFqa0qVBFj8/YKii5G2OZsTB1kK/N7mxkFsVmtDHzHsDHy+BdKrin/NUIqzIfgTlcGjlTq6npmpsFy8hdwkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377103; c=relaxed/simple;
	bh=xp1MqptAb4gk4u0qt7wVJibOwKdhPFQMAPrlbTDArvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utijv4bKhL5d9sdI0NmPzzniMLqCbokQF8Un7Gc6egJPxL7hS1chGcV/wxcEFbBsrgHTVTpwJrFHv8UtbKISCK12mJUhy2akucFwKUI17Y+Mt/YwwPDwqONRTU0iFynZfHx306dThL5IZLjw0Cg5b/62lC8/YpSxh+nLkbuP608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fWgtLpMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C890AC113CD;
	Mon, 29 Apr 2024 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714377103;
	bh=xp1MqptAb4gk4u0qt7wVJibOwKdhPFQMAPrlbTDArvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fWgtLpMBpQoMdaRdU/8FfIbs9vPp0v81fsIp0nrwxg/aLfIg80ZSEX/UtNqotnhEw
	 TlhB0C88NSYB7Df9hCM5oA8q+pHQE5GVuEpysM0O/gIF+xO6JNnzsdEjgnseonhHJ9
	 DmQ+S9AG1IKKznQZPbKgKMQF2FI9iokRWrtv00TU=
Date: Mon, 29 Apr 2024 09:51:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] docs: stable-kernel-rules: create special tag to
 flag 'no backporting'
Message-ID: <2024042914-bleep-imbecile-5f68@gregkh>
References: <cover.1714367921.git.linux@leemhuis.info>
 <35989d3b2f3f8cf23828b0c84fde9b17a74be97c.1714367921.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35989d3b2f3f8cf23828b0c84fde9b17a74be97c.1714367921.git.linux@leemhuis.info>

On Mon, Apr 29, 2024 at 09:18:30AM +0200, Thorsten Leemhuis wrote:
> Document a new variant of the stable tag developers can use to make the
> stable team's tools ignore a change[1].
> 
> That way developers can use 'Fixes:' tags without fearing the changes
> might be backported in semi-automatic fashion. Such concerns are the
> reason why some developers deliberately omit the 'Fixes:' tag in
> changes[2] -- which somewhat undermines the reason for the existence of
> that tag and might be unwise in the long term[3].
> 
> Link: https://lore.kernel.org/all/b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info/ [1]
> Link: https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/ [2]
> Link: https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/ [3]
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> 
> ---
> 
> A patch to make one of the stable-script honor the flag can be found in
> https://lore.kernel.org/all/655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info/
> 
> For autosel I was unable to locate the code.
> ---
>  Documentation/process/stable-kernel-rules.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index ebf4152659f2d0..9ca8083b41c7f1 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -129,6 +129,12 @@ comment to pass arbitrary or predefined notes:
>  
>      Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.3
>  
> +There furthermore is a variant of the stable tag you can use to make the stable
> +team's backporting tools (e.g AUTOSEL or scripts that look for commits
> +containing a 'Fixes:' tag) ignore a change::
> +
> +     Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
> +
>  .. _option_2:
>  

Thanks for seeing this through:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

