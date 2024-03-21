Return-Path: <linux-kernel+bounces-110326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863AF885D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360D41F2498F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E0712C52E;
	Thu, 21 Mar 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZs0FI2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FC5B1E0;
	Thu, 21 Mar 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037876; cv=none; b=L2CCuagq112ANS85JXvlFFRo1g/7st9VGuzEzvjqw7a9Quo3BIWCQzcpYICaP/DCpyGqHVibjMdeydg0NLXWnlW7v85l05IPQjTyM9o8UrP94Pa/3ZGaaYpX5lYViiueqjGZTB/wfkPWtQxbMsUcXVd0RBr8CgCqyoXdd0IY8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037876; c=relaxed/simple;
	bh=IEmiVzXuXBegaxIDc1zPKVYzuRTC061ngwiBltqvnF0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NreZNYxdhH/uahe4L9+PAtrnrud0QkgAvY/K5DbQYjOSJm/FmGAgPU5Yk3wRUkPF50yTysz/ylMmfua+V6AANaQhtPSQlgwdPIddWy13nUZlvAVJppTF+dPeh57BHiWqXBA/5wknNtArESVqses1gmU5sm7PtyE0fbR2EIVrkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZs0FI2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3802EC433C7;
	Thu, 21 Mar 2024 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037876;
	bh=IEmiVzXuXBegaxIDc1zPKVYzuRTC061ngwiBltqvnF0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YZs0FI2HEQFRyPM3IriqeyQWnZHAYfiO029cBtBX0nJZNJ0CZ2HPojjCYSB+iQDbj
	 6HcAu8yvTPtuQ5vB9tQBhk+RcJ0/kJpVibt1//E6B/d7hKGNLsaDAL+xRnZtuFvQeL
	 xcB9KaAz+EvDyG0rZ7s1pZo8AjUFOrGraFxo2PKt7r6ds2XbKJRQ9jd+4XjNNd1KX8
	 ovM3j5//Et+EepZTBJ2kBSTqtWct1/tkDNc60Hq5jxxTN3FQiKcsTtgXK9p6+EP1ed
	 lIJNAIJkjGKERhy+8qKU6qvQaFVCW3cnJOJChG1teI3zT2V6BsXhTmZHCT562at41n
	 /Af2uZ9pyEJ6Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Mar 2024 18:17:52 +0200
Message-Id: <CZZKAZB5K1PD.2UKMDD28AUCEC@kernel.org>
Cc: "Stefan Berger" <stefanb@linux.ibm.com>, "Stefan Berger"
 <stefanb@linux.vnet.ibm.com>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <saulo.alessandre@tse.jus.br>, <bbhushan2@marvell.com>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>, "Lukas Wunner"
 <lukas@wunner.de>
X-Mailer: aerc 0.17.0
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <ZfiMhi9D2Rhh89BI@wunner.de>
 <d02eda40-2d3a-43a2-a3a9-cb79055acda7@linux.ibm.com>
 <CZXXPKTAUUM9.35VZUFITJWF6A@kernel.org> <Zfp20bLB0onXo7FV@wunner.de>
 <20240320-quirky-truthful-manul-da6eb9@lemur>
In-Reply-To: <20240320-quirky-truthful-manul-da6eb9@lemur>

On Wed Mar 20, 2024 at 4:41 PM EET, Konstantin Ryabitsev wrote:
> On Wed, Mar 20, 2024 at 06:40:33AM +0100, Lukas Wunner wrote:
> > If Herbert applies patches with "b4 am --apply-cover-trailers" or
> > "b4 shazam --apply-cover-trailers" (I don't know if he does),
> > it is completely irrelevant whether Stefan strips my Tested-by from
> > individual patches:  It will automatically be re-added when the
> > series gets applied.
>
> Applying trailers sent to the cover letter is now the default behaviour i=
n
> 0.13, so this flag is no longer required (it does nothing).
>
> -K

The whole policy of how to put tested-by in my experience is subsystem
dependent.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Official documentation only speaks about patches so perhaps it should
then be refined for the series.

I'm hearing about this option in b4 for the first time in my life.

BR, Jarkko

