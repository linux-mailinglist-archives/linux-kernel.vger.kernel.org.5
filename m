Return-Path: <linux-kernel+bounces-45468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE71843126
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5FF2847AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1979941;
	Tue, 30 Jan 2024 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWDOsg8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448B7EF06;
	Tue, 30 Jan 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657120; cv=none; b=BYlxUl9xTQYK5yo7nqCGY/n4RPIFE+J996TRXKbHGSi4TGAoiZapszwL6634QS0ZiEolpVovNFcjUvFQBL+ywgJ3BQ/YtH2NT41qy6LXbcft37Fy6M+4kbHfB6CuAj1fGCADrdnlxRF+kASfbsebc74emucd3sv4IkkelJ1H6r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657120; c=relaxed/simple;
	bh=xhHQxDgz4WJv9YDPEekgMzWVmwxQu21H4INhA2VR63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5KT3z3/DBgMqVvoV7GfkWw343pdwMd4M5RnRmsCxGa/pmlKGNVxsRM859p2fRplfF9FXNtbf1t8YAEcviL5HEurS5gGJgTO5DM3mP8DGkSKc12zp/LIRtftO3q8uO+k804PCPc3eRN6nbV++GjVTEjaDM/oEbBg1a8R+v20vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWDOsg8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422D1C433C7;
	Tue, 30 Jan 2024 23:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706657119;
	bh=xhHQxDgz4WJv9YDPEekgMzWVmwxQu21H4INhA2VR63Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWDOsg8O/ginvXn1r+dEyk5UMI4cIUldqsgzVfcGXmn+EVug5vwZeOOfEAn1onrK8
	 8UDinIWIBiVVXVpF11OGM+8Jm9duax2nCg2uN6MjdquY0MTWtZ1sfviPV3v9K5GUpF
	 FOV3gA3nqsADviJFn2fGrLoIqhkeHGi0tYSyZ5vo=
Date: Tue, 30 Jan 2024 15:25:18 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 usb.current tree
Message-ID: <2024013009-helium-woozy-c6c2@gregkh>
References: <20240131095231.292911c3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131095231.292911c3@canb.auug.org.au>

On Wed, Jan 31, 2024 at 09:52:31AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the jc_docs tree got a conflict in:
> 
>   Documentation/usb/gadget-testing.rst
> 
> between commit:
> 
>   20d03ae36ec0 ("usb: gadget: ncm: Fix indentations in documentation of NCM section")
> 
> from the usb.current tree and commit:
> 
>   e49bf650ab5b ("usb: gadget: fix max_segment_size malformed table")
> 
> from the jc_docs tree.
> 
> I fixed it up (these commits fix the same problem, I used the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Fixup sounds good, thanks!

gre gk-h

