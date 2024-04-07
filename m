Return-Path: <linux-kernel+bounces-134310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1386789B027
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7871F2159C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69317554;
	Sun,  7 Apr 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9AcafR3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4916FC3;
	Sun,  7 Apr 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712483334; cv=none; b=QFnKANKWzXnyUdi+dd9jjrkz9adO35mp4ED04zoqYTYx3brDYjeLIUFEpwW1BbnicVZssgk4wxIfC1g6/PIXgteEER/e6HnEvMpsZYmpedZpsQQaaQQH+epw92/4ZO6vhBIXFBxnH3oSHMsVCx7AcExi01Ci9QfDKkVCpGzAU7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712483334; c=relaxed/simple;
	bh=ZE35ZxdAKiX+2gavtrBx6xOGuGY/CHR9DeTkciZNrRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y93SRvByWjoIEik4yYv33PaSLlsbVOj7VL6bh2IFMlxT6+fyxQwhTsOcGgibV2cO5ooSPgO/yNp56DiWec+oS+KDo3xaRWgG7pnhSn8eAJwOKUSi6K4980bh1eR5ZkAQXydmb9ix3dQtnhRtO+jYskq8tEmeJoU2Br17ZQ/2hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S9AcafR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5163C433C7;
	Sun,  7 Apr 2024 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712483334;
	bh=ZE35ZxdAKiX+2gavtrBx6xOGuGY/CHR9DeTkciZNrRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9AcafR3hP6kSR3JKuxWIDVULcV/9VXE5ihDW12p/INmOXzrY9mapu1wJj2cJTPz6
	 MD/6B01+iXxxnfLO06TwHMY8PIEWQFyoCFBOCUWW88r86k7P+gbrvhDdmFHo1OSN5q
	 lelQxkaSd47p3iYjjsAZZjDvYwdDPgXgsGwnltFM=
Date: Sun, 7 Apr 2024 11:48:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Fran=E7ois?= Valenduc <francoisvalenduc@gmail.com>
Cc: torvalds@linux-foundation.org, lwn@lwn.net, jslaby@suse.cz,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: Linux 6.8.4
Message-ID: <2024040734-tattling-bubbling-fcf0@gregkh>
References: <2024040409-attentive-raffle-d9bc@gregkh>
 <2024040409-disliking-mammogram-096d@gregkh>
 <41c2bdd3-9b66-404a-aecb-8633d4aa98fb@gmail.com>
 <762f7ace-7fee-4f61-823b-54a1b7d5bdce@gmail.com>
 <2024040629-bullfight-wind-54f0@gregkh>
 <0a716f53-5c88-42e7-b183-fb8ae4d4959c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a716f53-5c88-42e7-b183-fb8ae4d4959c@gmail.com>

On Sun, Apr 07, 2024 at 11:36:23AM +0200, François Valenduc wrote:
> While bisecting, I noticed there is now a new configuration option in
> KVM (support for Microsoft hyper v emulation) which is thus needed for
> Windows guests.

What config option is now needed?  So there's no problem anymore, right?

thanks,

greg k-h

