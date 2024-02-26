Return-Path: <linux-kernel+bounces-81038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E4866F51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA39C284DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B01D52B;
	Mon, 26 Feb 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWFYUrNp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444ED1CFA8;
	Mon, 26 Feb 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939250; cv=none; b=ATtGz+Cxnz4I6SUhG18nMN0fUjO0W4avC+RnOcV8Rv9Y1VxctpluAjV7LN+z5K1dkx5ek45ehErU7c1fgFTZfSXOuJ+aGsTlCFGOkKRVLqj10nON0KYI9ZvvhQ8F2ZTk35Jl/4XbLcK5J0kNYU7gzeAFZxp6+2VS2UJC1SUyokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939250; c=relaxed/simple;
	bh=/UeRed/g2dvEogajnUSGfibzVL58QJsfGr5Ye7NLJ6A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OeXUeIbnTgfxXmn7++mPj7zlPVq4YKQGiYhU+PWqoZZSI1pz95WZ3oKe+Xh+o81w8uOwbv1dXarkJbQttOjbNKXqJIGFizc6DdFIXZ3+e6X+/1JLHte468LubAx0fa4niUDzs8jt7jc92R2SAqljTr5DJQIvpjoIrGufP7h9I6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWFYUrNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD02C43609;
	Mon, 26 Feb 2024 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708939249;
	bh=/UeRed/g2dvEogajnUSGfibzVL58QJsfGr5Ye7NLJ6A=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=LWFYUrNpuVrGfyaCTHcJ0njC8oeIZeFIlxTf3Oq8vJ0GqEDu1R20h+/USNlHpKUeT
	 2u88KntporUe1ncLhL9kw6o/MHuifazh+2rwo3rjkI6XeXVCnJxCYVtKwZqJqGTZDV
	 K78kPtL3jgy1PYDS90InPI5QloHPHXS9IZovly8bfTTLXzYdRGVEn1NXsnSTQ+wHSK
	 7roFPdCxO6OAvZK5MfGrapyUovLB4S01jnnDDqpU5YMb4/v5hnzh3nJoFzLNZQ4YAb
	 awNA0NjpezdEPac1QWji6C0j3sPvhDRYOPwO/TOjeHduZkgSn84BV/cY9pucUUWcz9
	 L0y5n6xu6VY+Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:20:46 +0200
Message-Id: <CZEWEJNBXC8P.XR6UVZKSDMDY@suppilovahvero>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, <linux-integrity@vger.kernel.org>,
 "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.15.2
References: <20240226062245.2279635-1-jarkko@kernel.org>
 <1ab10318-5e3d-417c-9984-7b17f4e386e3@molgen.mpg.de>
In-Reply-To: <1ab10318-5e3d-417c-9984-7b17f4e386e3@molgen.mpg.de>

On Mon Feb 26, 2024 at 8:35 AM EET, Paul Menzel wrote:
> Dear Jarkko,
>
>
> Thank you for your patch. Two nits:
>
> s/RIVER/DRIVER/

lol, thanks for picking up this ;-)

>
> Am 26.02.24 um 07:22 schrieb Jarkko Sakkinen:
> > Add TPM driver test suite URL to the MAINTAINERS files and move the wik=
i
>
> s/files/file/
>
> > URL to more appropriate location.
>
> (Two commits would make the commit message shorter.)

I think I just remove link-tags as there is not much else than the links
in the actual change (trivial to pick them up from there).

BR, Jarkko

