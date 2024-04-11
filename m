Return-Path: <linux-kernel+bounces-139950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE378A0986
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF9B25380
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35A13DDC6;
	Thu, 11 Apr 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxP41HbU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8813CAB3;
	Thu, 11 Apr 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819855; cv=none; b=RGoHtyvfKOVZkKPW8M6W+Nqi7rDarVv07hTF6cmvR/nt9rCrUKwSGkeJrsRTowcIlGQWRf8aaX3Y32PdwqCl0fbvHTdRMyN0jWDBo8dRADcmAIP8+92mX17Cq9QJE4jzSTpwKQrUBqyncehKvwcC+6meij0lxpR8zdTDNG0PE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819855; c=relaxed/simple;
	bh=mK7+2Yx5EdW3ebbUvwkBMpMnF62TBAbCt0KJq4syyLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue07x/PWekJp5mzGL1nR75lfJSDlho2ySE8Z6A+WQvP3Xjl02NjbQAWC7hexi/JszGvE4v7edu+oS0xSE4HDpdK2uRh1JktiWBt8+bnmsTiezeQCKgUHTGYkqC9krfBq7U+jiTOXdAVSAvQiCGAXhi3jTaC0penCbQgGEYLugxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxP41HbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698BAC433C7;
	Thu, 11 Apr 2024 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819854;
	bh=mK7+2Yx5EdW3ebbUvwkBMpMnF62TBAbCt0KJq4syyLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxP41HbUsHeHx8gmclfHe27Cs5AwM6Ze+0bJWuPpbhsLbXw2PUYYaxwDP2VA6XFaU
	 MMFSxefVai/53aPaRkLzvqfZZDMCkJP6X4nbIi5CyXwVEGDflxjkl9Ed+Bh972lpR/
	 VDQ942cONfqhySljR1fJVO2uwW0eGdh3i7QmeN8Uib503CPrKNK8ky37Fozcsdnx5b
	 HoISMOeX+iic3aB2n42r5dtXAqg2qtQ3mnP9FBAJR6lTsN46s0QbzjIpDofCE9XarH
	 ybq2ALaYSuPw83DdrBd40OpGU1DPWtU7gB94b/SDefrVmAgVRrSRkN4AbZAZsY426/
	 XOAkSpDi7IOUA==
Date: Thu, 11 Apr 2024 09:17:30 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hid tree
Message-ID: <lzv35zlbbaceu3kizexdvitywdoj3adwcg7vyuzyuz6tgaxiqi@qmuqplm5iluo>
References: <20240411105131.7830f966@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411105131.7830f966@canb.auug.org.au>

On Apr 11 2024, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> x86_64-linux-gnu-ld: vmlinux.o: in function `hid_bpf_input_report':
> (.text+0x1c75181): undefined reference to `hid_input_report'
> 
> Caused by commit
> 
>   9be50ac30a83 ("HID: bpf: allow to inject HID event from BPF")
> 
> I have used the hid tree from next-20240410 for today.

Sorry for that. It should be fixed by:
https://lore.kernel.org/linux-input/20240411-fix-hid-bpf-v1-1-4ae913031a8c@kernel.org/T/#u

If no one complains about it today, I'll append it to the HID for-next branch.

Cheers,
Benjamin

> 
> -- 
> Cheers,
> Stephen Rothwell



