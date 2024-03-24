Return-Path: <linux-kernel+bounces-112686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BE887CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C64EB20ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921318028;
	Sun, 24 Mar 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3C1SR5a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A317C9B;
	Sun, 24 Mar 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288319; cv=none; b=oiljjVjsso0v1Yvkzg/fyGyJqu7qEb8WFV8UUm+ORpyHgd3KSozp1FnWxX6q2owXdc3UPDDRi4z6SWRQfPWwhGeWgBj3dn0JRQl7/u4mMxUUkgLPOcyKdh5mhoS+2jjSX5sNEGgY/j6GVWykqK2CqxKZPpXi9luKC8tQ8Fzc/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288319; c=relaxed/simple;
	bh=fdaFFsv5xeJ2owFZCWtsohQOZAhO2MGEtb3Dm1Cbn94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rua7wnqTUzK6jk0DtYunK0f1CdbehujKnmDqt20z+MPNtCMYExtFY3xFsnUqhAUCnE60eLJgWLOg0Y6XI/7l/ppzsQZmEVn3g4NBeGSj0mCnl+TyvbpgH7wn9C0vvpfiaatMEBwT2x1RKqdbw6jRPjUJC5gMEI4Ztx0fq49jaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3C1SR5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A449C433C7;
	Sun, 24 Mar 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711288318;
	bh=fdaFFsv5xeJ2owFZCWtsohQOZAhO2MGEtb3Dm1Cbn94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3C1SR5aj8Y4iALCQyQtK6EHOPA8OBkvCA/aenQ881qiHoV8N73IBJuph1aHeoXCj
	 Lw3okiAZLRogw20TRGwL38V9fXBPkx8MAd6u1GUkOid5GLuyTlqKuo9EQsQdhoThtT
	 y3RyFPKVMUN0AvHD1DJZ83afyckR3GBhQlRPFtBw=
Date: Sun, 24 Mar 2024 14:51:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.7.y
Message-ID: <2024032439-uneasy-raking-fbed@gregkh>
References: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2zaqetj6wlxgpbxgex643dnudgwhcrz23xgfuai3t3hgavjb2d@vwhyha3hlg5y>

On Sun, Mar 10, 2024 at 03:43:38PM -0400, Kent Overstreet wrote:
> The following changes since commit 2e7cdd29fc42c410eab52fffe5710bf656619222:
> 
>   Linux 6.7.9 (2024-03-06 14:54:01 +0000)
> 
> are available in the Git repository at:
> 
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-for-v6.7-stable-20240310

Now extracted and added to the 6.7.y queue.

thanks,

greg k-h

