Return-Path: <linux-kernel+bounces-5473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C851C818B0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C5CB23A83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297DD1D12E;
	Tue, 19 Dec 2023 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuyWikoC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F21CF9A;
	Tue, 19 Dec 2023 15:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7391EC433C8;
	Tue, 19 Dec 2023 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702999114;
	bh=eBBO/Kb+MNXaaqfHk8qHDMfj2T3jpnlp7Abrv3hLatg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuyWikoCQmsVN4fvouG2IcorOqXhHTXt7e5NkkhFwpAMxS+kxdS3A1Qgow8v2ImS9
	 WHgnQ0ONV3BN++3Upv5KFCJ8eUcz5efajrAeYF2oEiAol74Qh8CtRV8cbMwPNm/5f1
	 qZrjwQ5paIv4Ubosvi+aCzVHQPBEXH6Us7K1D9DI=
Date: Tue, 19 Dec 2023 16:18:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Piro Yang <piroyangg@gmail.com>
Cc: linux-staging@lists.linux.dev,
	Linux Outreachy <outreachy@lists.linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] staging:vme_user:Fix the issue of return the wrong
 error code
Message-ID: <2023121920-winter-devourer-4f0b@gregkh>
References: <20231219151202.50368-1-piroyangg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219151202.50368-1-piroyangg@gmail.com>

On Tue, Dec 19, 2023 at 11:12:02PM +0800, Piro Yang wrote:
> Fix the issue of returning the -ENOSYS error code when an error occurs
> 
> The error code of -ENOSYS indicates Invalid system call number, but there is not system call error

Please wrap your changelog text at 72 columns, like your editor asked
you to.

And use '.' as these are real sentences, right?

And some ' ' in the subject line, like:
	staging: vme_user: Fix...

Usually writing the changelog and getting it correct is the hardest part
of getting a change accepted.

thanks,

greg k-h

