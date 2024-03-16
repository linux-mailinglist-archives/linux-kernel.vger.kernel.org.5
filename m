Return-Path: <linux-kernel+bounces-105249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929587DB0E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AC8282526
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668461BF40;
	Sat, 16 Mar 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elkKsbaf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615D1BDE2;
	Sat, 16 Mar 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710610024; cv=none; b=biyPOeNt/s/ihJ2V1J2Qq++9Je2n3fMhzF24IWGR8kbxZL9UgfeudEw1WJpbX8eEwwCJgdU8nJKqVYXmRAFFlNrh8B+jbAps/DcJkHp8fI2K5kSldGm7xEihqZqrJW2GlExb1QyMsozuXdDSS67Yd7ihstu/zsBPBVy3LMm+cfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710610024; c=relaxed/simple;
	bh=zYt14r8nDdOX+ZfrAQslKLIlUylEWdawHHVHKwxd1LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jid0bD/hx4cBLFGJA3EGhH/aMZFyXiyP18PMbxnhSU2Uzr88J9fsJcnwvHTUBWZmqPIxHe8uVFVWOY2BPOMyS7S0d2wFGXuq1O7RtINTNFZDW6IyrTM0gwLKlCHLXmLSUAR5uxq8n2hiXbpuucQzjPHfp5jOXICcO2X3BA19ijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elkKsbaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BB9C433C7;
	Sat, 16 Mar 2024 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710610024;
	bh=zYt14r8nDdOX+ZfrAQslKLIlUylEWdawHHVHKwxd1LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elkKsbafdZ4m/gSiQ08z+s2biv9jHP9xk/EX8VZQUbzPa4Su8y8C0R3ECe0/bIwKS
	 az0vBPCf+QGyFLTePrORh1gBJqqpMIydWmeAKHNaSeqlGS+SnkLwMt2N5l0txH7gOQ
	 YWEfzhVkoUISX/irR4UDLUbs34VwUh4bs/UoMmBdOp57g/a/cdM9v335fvTBUIoE2C
	 LeaL1gwftzTlNz7FOqt8ZblN7leRkoMYks5dNRYhhu+DR5ydVM+xpaPrXcOO3xO4Te
	 bnrMUWWxcdnL5oymCKby2hv7a0a+hYlsURUObqNkdeOIh+PZ3plhF/ahnMztSIMSTr
	 JmnzMCG2KtShw==
Date: Sat, 16 Mar 2024 12:27:00 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Prasad Sodagudi <quic_psodagud@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 11/12] firmware: qcom: scm: clarify the comment in
 qcom_scm_pas_init_image()
Message-ID: <qwzpjymdu7svm2ojehnbyztcnbgvpqakj3rmhfzjwf2mld6w6u@zj3qrcza5hf6>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-12-brgl@bgdev.pl>
 <ihz4jczbhn3gdcs6nkgnzpyv3577ebd73qbkynw6jz7ciy4fu3@kxqu7olrrely>
 <6a3e3071-f8cd-66b4-99a0-427f7e11177a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a3e3071-f8cd-66b4-99a0-427f7e11177a@quicinc.com>

On Fri, Mar 01, 2024 at 10:49:57AM -0800, Prasad Sodagudi wrote:
> On 2/17/2024 7:50 PM, Bjorn Andersson wrote:
> > On Mon, Feb 05, 2024 at 07:28:09PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[..]
> > > +	 * If we pass a buffer that is already part of an SHM Bridge to this
> > > +	 * call, it will fail.
> > Could this be because the consumer of this buffer operates in EL2, and
> > not TZ?
> These buffers are consumed by TZ only and not by EL2.  hyp creating the
> required bridges for pil buffers.

Please help Bartosz document what is actually going on here and why
these buffers should be handled differently.

Regards,
Bjorn

