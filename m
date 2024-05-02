Return-Path: <linux-kernel+bounces-166693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F18B9E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080181C221C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579215F300;
	Thu,  2 May 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B91kLkBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D515D5D1;
	Thu,  2 May 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666127; cv=none; b=oc9AB4Y1KxH9Z4dg1citUMA26xf0wgIywOQmPUmLInTBpRuCgkKKUA2Z7tsjYYWqFb/WlibZXAx9PwvPjYRsRcZ2HPcmT4HkooXdCpheqq6+oXQJlTcraueErhM/xXXAOeyUuUZe0FzM4i8CmkmnelinCJ0sw9LABAoFhaUHoh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666127; c=relaxed/simple;
	bh=gl9O2WwztfOm6npo/1+WfKL5nQmCth7iyvHkJ0RH9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/Mw2p9Dy2sc5qqne5oU/kv2898vIGjd2asxV8zhKatGv2EScb1cPFMQBVGivqNhOsfq6XU98o09KeVS9+veng4UhKBuEzbJaQU7ewUtwRzHr9ADQmMTOovOfcRLGuJJltdUVipPEwBrd0J/GtbWXmYQQaFqCXQmodoFws2U2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B91kLkBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F317C113CC;
	Thu,  2 May 2024 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714666127;
	bh=gl9O2WwztfOm6npo/1+WfKL5nQmCth7iyvHkJ0RH9c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B91kLkBmHQ5lgyqltlx+5+JcepgXeFHd3/LFM+sal1nWhA7JX0Ujg5q1mMDQmkYyH
	 nJNFtQ4OGjCHSRHBADn4BsNG+VSlxgi9/cuXEPy/2yeMt10fXlf9RHyWU72p6zOjGB
	 FfHypT2i/vlMF+7mS6Kj13RThJegMsFp7bGVdPuBA+Dcv+rHNg526bxxcdz6zB6O0P
	 upi0HTJTDinSBNItRssW3+t5zxldFhnkyfKTNYsWPZkBEeRH58SZC+GjHWYbbgjYod
	 UwQqBq3OyxOBsd1RExxWOf7Az07+GijsHDWq5RPPlO4Gp2dhsZ8K8XSA/35viCc+N7
	 yl0v1d/V+lRuw==
Date: Thu, 2 May 2024 09:08:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tomasz =?utf-8?Q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, conor@kernel.org,
	ojeda@kernel.org
Subject: Re: Prebuilt LLVM 18.1.5 uploaded
Message-ID: <20240502160845.GA3193908@dev-arch.thelio-3990X>
References: <20240502152416.GA3178126@dev-arch.thelio-3990X>
 <CABB28Cwu3CMeBNch+snX8LG_g2oaYRDboVK4prwc3jp7MHyQWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABB28Cwu3CMeBNch+snX8LG_g2oaYRDboVK4prwc3jp7MHyQWg@mail.gmail.com>

On Thu, May 02, 2024 at 04:33:32PM +0100, Tomasz Kłoczko wrote:
> On Thu, 2 May 2024 at 16:25, Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Hi all,
> >
> > I have built and uploaded LLVM 18.1.5 to
> > https://mirrors.edge.kernel.org/pub/tools/llvm/.
> >
> 
> Is it known when dist tar balls will be uploaded as gh assets to
> https://github.com/llvm/llvm-project/releases/tag/llvmorg-18.1.5 ? 🤔

Not sure. It seems like there was a 24 hour delay for 18.1.4 if I am
reading GitHub's release JSON correctly:

$ gh -R llvm/llvm-project release view --json assets,createdAt,tagName llvmorg-18.1.4 | python3 -c "import json, sys

llvm_json = json.load(sys.stdin)

llvm_tag_date = llvm_json['createdAt']
llvm_tag_name = llvm_json['tagName']

print(f'\n{llvm_tag_name} was made at {llvm_tag_date}\n')

for asset in llvm_json['assets']:
    if (asset_name := asset['name']).endswith('.src.tar.xz'):
        asset_upload_date = asset['createdAt']
        print(f'{asset_name} was uploaded at {asset_upload_date}')"

llvmorg-18.1.4 was made at 2024-04-17T00:26:56Z

bolt-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:08Z
clang-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:09Z
clang-tools-extra-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:10Z
cmake-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:11Z
compiler-rt-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:12Z
flang-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:12Z
libclc-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:13Z
libcxx-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:14Z
libcxxabi-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:15Z
libunwind-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:16Z
lld-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:16Z
lldb-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:17Z
llvm-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:18Z
llvm-project-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:20Z
mlir-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:24Z
openmp-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:25Z
polly-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:26Z
runtimes-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:26Z
test-suite-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:27Z
third-party-18.1.4.src.tar.xz was uploaded at 2024-04-18T00:13:32Z

Cheers,
Nathan

