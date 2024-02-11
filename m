Return-Path: <linux-kernel+bounces-61156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BDA850E20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F861F25B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083B79C0;
	Mon, 12 Feb 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1ObsQp9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A694747D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723629; cv=none; b=GTKYb7ZCXezYWOSXcZrTNw6QDstnRFp3mMCcEuRndIiiGKpFrTvrPZdjitDlgijk5YGqVNE+CdqiSSbpP4H61FJa0wAb3OJAMSayiSlOivW6pM2DPQsOAjo+Sj6tNskXz/K2RwkH8Xqdk8Ks13Nk3i66xPNt1kpfehgv2nXdbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723629; c=relaxed/simple;
	bh=UEPUmfwTzhCWgki7FMLU8n07rTkE3BfTUOwthJ67cWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwBNufMAQ6MiUX53Snwi6st+ooNEa7VDL2OcQ/hICm3wX29umyuTk2BDFDKtyR9YhdnJfVUP3TrIj/048UwEDXPR8ne4CqQW9GRDC5erAAhAOE4KlnjdMoV/3k9nAwxb00e37KZkKGklUB4jIwLHWxiZ7cJbk0rfgX92vvb8scY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1ObsQp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE0EC433C7;
	Mon, 12 Feb 2024 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707723628;
	bh=UEPUmfwTzhCWgki7FMLU8n07rTkE3BfTUOwthJ67cWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1ObsQp9N2jjwaV/FwvatefdJtCLIB0BL3/uic8FkXplH130/F3aP5OM4qgp5Kkpz
	 hVef4e19PDjTyt6lZY7A1zba8MWONVKa5kRahh6XCXAt+/XoGMKFBUBrrCDNJjT1To
	 WxlhsJd0QcZ619orJYBBTSVvI7bHAGTXH+J743rY=
Date: Sun, 11 Feb 2024 21:04:18 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] Subject: [PATCH] sound: drivers: fix typo 'reguest' to
 'request'
Message-ID: <2024021133-strict-unwary-0487@gregkh>
References: <20240211182846.3608447-1-guoych37@mail2.sysu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211182846.3608447-1-guoych37@mail2.sysu.edu.cn>

On Mon, Feb 12, 2024 at 02:28:46AM +0800, Yinchuan Guo wrote:
> This patch fixes a widespread spelling mistake of the word "request"
> (incorrectly spelled as "reguest") across multiple files.
> 
> Signed-off-by: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
> ---
>  drivers/mfd/da9063-irq.c      | 2 +-
>  drivers/scsi/lpfc/lpfc_sli.c  | 2 +-
>  drivers/tty/serial/max310x.c  | 2 +-
>  drivers/tty/serial/sccnxp.c   | 2 +-

These are not sound driver changes.

And your subject line is very odd.

Please try working on drivers/staging/* code first, before branching out
into other parts of the kerneln so that you can learn how the process
works without wasting other subsystem maintainer's time with invalid
patches.

thanks,

greg k-h

