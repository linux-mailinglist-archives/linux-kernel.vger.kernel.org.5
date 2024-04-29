Return-Path: <linux-kernel+bounces-162356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBAD8B59C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A8A1F24AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC56D1D8;
	Mon, 29 Apr 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLq0VWnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7B54FAB;
	Mon, 29 Apr 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396982; cv=none; b=mLTkv+LC6ueBvxPaSF3Zeb5S5XURQqqr/R0vyiwwaG1iz9IoYj/bpu+GFnnXfih1nppe88Hg7spiHS/8UwenT+lCUPI6wvc+IAjSgWV9QkKWVQdkcCqwSHiJgGYF4lGu7qeWXhFTTtkBnMlSAXu+7VLC8leUXAB8iKAWxNYMTJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396982; c=relaxed/simple;
	bh=Jrk+wtx13fSoXMFUAd70bsbYcdKXycBdeKJThU5avMo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gIn59IpRQkNnV59uNNb20b6Z0SP80LqYmGV1Wujfnw1PNziIZfTeAZICdpzYKxU9Lt+aH/+PeghUuSSzzriBj+HPSdSFeXq1HnE9XyUUANPChTVgp8FMWRZ64yn/D4DH3Hm1ga3X5iv2eFpiatM9Ig9E1iSRdRvVLWpELvvt73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLq0VWnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AFBC113CD;
	Mon, 29 Apr 2024 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714396982;
	bh=Jrk+wtx13fSoXMFUAd70bsbYcdKXycBdeKJThU5avMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLq0VWnSO5LH4s4zHkRjAC9C+k+Saa8Wp2ttSiE5+Jf1EjSvSBAoTOCITFozNpSGJ
	 tEj56FoTZMl5NgyCm/YNSDvZNt7PUXOKM4/FYoeisGnlODrgx8vpKKXyCka1xor3gV
	 F83DH+vdu6UutG9lWDdn3YXtiTH09NNjBEXjDB4qel1jBLMKrhi3hu+CT8ovhH45ce
	 mRQ+LBgggU7IDMRy0AeUK9qKw1XfQ5GXHywNrk0sm5GaMH1Y195Kao/C7ff4yOfCF/
	 tN6zGBI3pVVgYhffrDhhSoooiCCtJ2YS1HasRAY9xx0yLT+kA8sADHhKmEeR/7U1go
	 UsKSl5MKjVZBg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Apr 2024 16:22:58 +0300
Message-Id: <D0WN0B2JL7N4.V0GPQWA79SJ5@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Dmitrii Kuvaiskii"
 <dmitrii.kuvaiskii@intel.com>, <dave.hansen@linux.intel.com>,
 <kai.huang@intel.com>, <haitao.huang@linux.intel.com>,
 <reinette.chatre@intel.com>, <linux-sgx@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: <mona.vij@intel.com>, <kailun.qin@intel.com>, <stable@vger.kernel.org>,
 =?utf-8?q?Marcelina_Ko=C5=9Bcielnicka?= <mwk@invisiblethingslab.com>
Subject: Re: [PATCH 1/2] x86/sgx: Resolve EAUG race where losing thread
 returns SIGBUS
X-Mailer: aerc 0.17.0
References: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
 <20240429104330.3636113-2-dmitrii.kuvaiskii@intel.com>
 <D0WMM3MYQODE.3A89L7D6OVG3E@kernel.org>
In-Reply-To: <D0WMM3MYQODE.3A89L7D6OVG3E@kernel.org>

On Mon Apr 29, 2024 at 4:04 PM EEST, Jarkko Sakkinen wrote:
> > Fix these two bugs (1) by returning VM_FAULT_NOPAGE to the generic Linu=
x
> > fault handler so that no signal is sent to userspace, and (2) by
> > replacing sgx_encl_free_epc_page() with sgx_free_epc_page() so that no
> > EREMOVE is performed.
>
> What is the collateral damage caused by ENCLS[EREMOVE]?

Have you measured cost of eremove on an empty page?

I tried to lookup for a thread from lore because I have a faint memory
that it was concluded that its cost irrelevant. Please correct if I'm
wrong.

BR, Jarkko

