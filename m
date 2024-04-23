Return-Path: <linux-kernel+bounces-155260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258EE8AE7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B362849C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E15134CC0;
	Tue, 23 Apr 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MvKGBXoI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2AE745E2;
	Tue, 23 Apr 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878043; cv=none; b=WxQQdzSjNa74vLkANkI1Kv5W01Y/7XuawsDR9Qtemc6Zb+t//+hEWv4LHqX9bKWW8vrWDxcBvtfkhUYzO1heE9LdaTO/czwyWkQcICqjUHBTNgEkL4e0xc0+AnXpban7J5ub+yXsoQmfLPgh5DWKbV/tLSvIrhk0aEX0T3+D770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878043; c=relaxed/simple;
	bh=Nj68OmhyWQ0CGi21mO9xDGPvMfeGzy1GgT4t4QLHt9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7fPo4L/sRrTNQ0wLUMIpqpn7SN7bW50QGFe3nPB5/54efp8PTfSYZJ6BDku2KBgBgVSL94rUFnFICit/0CTDPgMSS0fF7O/SiUr2AflmD6GVbxf/OC+2SHU9FFnUYIlGTADLVyqRgIAL75HA47olEyNg2E3ibU1hOk3EqTpQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MvKGBXoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E075C116B1;
	Tue, 23 Apr 2024 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713878043;
	bh=Nj68OmhyWQ0CGi21mO9xDGPvMfeGzy1GgT4t4QLHt9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvKGBXoIusIMLOqh8FDQ1oONCTHyA3lZInQKBh9Bs3HnbwjAwS29f2am1vd9P+faq
	 Y0d8DUfTL+/USTbXekvx1D7SGQdzt7Nsgq+pQo0at158QgjK2yJfUQva5DqrtObjp1
	 uUmPQz+wpa+ZkIs6EFVOM5sLGbqiBlnquz3bAjZ8=
Date: Tue, 23 Apr 2024 06:13:51 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Phillip Pearson <philpearson@google.com>
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
Message-ID: <2024042343-overboard-subtext-62c3@gregkh>
References: <20240411095424.875421572@linuxfoundation.org>
 <787e0ac1-cb31-47d9-8200-3f6a3b4119dd@roeck-us.net>
 <c5d0c7f7-96a0-4806-b3b6-269d9189037d@roeck-us.net>
 <2024041949-strained-steadfast-13cf@gregkh>
 <a5c09590-edfe-4fef-8edc-75a39b92446e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c09590-edfe-4fef-8edc-75a39b92446e@roeck-us.net>

On Fri, Apr 19, 2024 at 05:36:33AM -0700, Guenter Roeck wrote:
> On Fri, Apr 19, 2024 at 12:41:02PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 18, 2024 at 12:38:59PM -0700, Guenter Roeck wrote:
> > > On Thu, Apr 18, 2024 at 12:25:21PM -0700, Guenter Roeck wrote:
> > > > On Thu, Apr 11, 2024 at 11:53:29AM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 5.4.274 release.
> > > > > There are 215 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > [ ... ]
> > > > > 
> > > > > Sean Christopherson <seanjc@google.com>
> > > > >     KVM: Always flush async #PF workqueue when vCPU is being destroyed
> > > > > 
> > > > 
> > > > This backport is bad. In kvm_setup_async_pf(), it removes a call to
> > > > kvm_get_kvm(). However, it does not remove the call to kvm_put_kvm()
> > > > in its error handler. Also see upstream commit 7863e346e108 ("KVM:
> > > > async_pf: Cleanup kvm_setup_async_pf()") which explains that one of
> > > > the error paths in kvm_setup_async_pf() which is not supposed to be
> > > > observed can be observed after all.
> > > > 
> > > 
> > > Reverting the above commit from v5.4.y fixes the problem. Alternatively,
> > > applying commit 7863e346e108 on top of v5.4.274 fixes it as well.
> > > 
> > > I added Phillip Pearson to Cc:; he did all the testing and can provide
> > > additional information if needed.
> > 
> > So which is recommended, revert or add the other commit?
> > 
> We decided to apply 7863e346e108.
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5465806

Great, will do the same here, thanks.
greg k-h

