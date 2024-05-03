Return-Path: <linux-kernel+bounces-167644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826B8BAC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46BC282ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D0152521;
	Fri,  3 May 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aRIpo00F";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="aRIpo00F"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F051509B5;
	Fri,  3 May 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739821; cv=none; b=kuJo9pT1Z0o0gN05WC95AvdLiaC3qmWVrzXmP0DkikuNq70NI+ZTuH4JusPP5BQGDbiSMW5PA8co7tMYFCaLh1hKvV6TM9Eu6oHxHsDE562X7F8IrXr6wo1L4KcZezoJrFzMVpjDuAwxjOBfLMbQy2y6gxmSkOD69cf2Cnwtgnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739821; c=relaxed/simple;
	bh=BFAfSVghMOGAAfX4Xx+uy/ldZorqF0zodRu17NS1o2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzmYyp8yXICA+HenJGwPD+/vhgawrAJt733R+bOWkSqmVBg+ouRlAceBJcnJ/pDijvmwa0Q117FNrdZHTv84eyBbCB3Wdb0UTzxTfaKxB2cUXHbcv6nYOnVR3PHE3pAnBR2WRjTG9wNLbHFWI3L9HRqMgoGin1p3kyuN7f3eL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aRIpo00F; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=aRIpo00F; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714739819;
	bh=BFAfSVghMOGAAfX4Xx+uy/ldZorqF0zodRu17NS1o2I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aRIpo00FAHaK0aMEAYnGtoqInWeRaa+SbmNGXrIScEjzyVguO2LojslzBweZtNQ2I
	 9Vtp4BYAcTX7vD0Ct4dg4g9HPjEPE9jCjzeD7NKXNR0H3CCdi/uwCRN3ZGbb733axq
	 hT6fw0ft2tdRcCSAnpijarup11VqjB5+mTDv4K2Q=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3D9CA1286DC3;
	Fri,  3 May 2024 08:36:59 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id CddVVCsbkm86; Fri,  3 May 2024 08:36:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714739819;
	bh=BFAfSVghMOGAAfX4Xx+uy/ldZorqF0zodRu17NS1o2I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=aRIpo00FAHaK0aMEAYnGtoqInWeRaa+SbmNGXrIScEjzyVguO2LojslzBweZtNQ2I
	 9Vtp4BYAcTX7vD0Ct4dg4g9HPjEPE9jCjzeD7NKXNR0H3CCdi/uwCRN3ZGbb733axq
	 hT6fw0ft2tdRcCSAnpijarup11VqjB5+mTDv4K2Q=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 65C5A12862DA;
	Fri,  3 May 2024 08:36:58 -0400 (EDT)
Message-ID: <288e65c39f355531c91761b330e530a6336631dd.camel@HansenPartnership.com>
Subject: Re: [PATCH] block: fix buf size for strscpy()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: David Yang <mmyangfl@gmail.com>, linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Xu Panda <xu.panda@zte.com.cn>, Justin
 Stitt <justinstitt@google.com>, Yang Yang <yang.yang29@zte.com>, 
 linux-kernel@vger.kernel.org
Date: Fri, 03 May 2024 08:36:56 -0400
In-Reply-To: <20240503074845.12181-1-mmyangfl@gmail.com>
References: <20240503074845.12181-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-05-03 at 15:48 +0800, David Yang wrote:
> strscpy() takes the total size of destination buffer as the argument,
> including the space for the terminating null character.
> 
> The actual length of the buffer should be len(str) + 1, which can be
> seen from the indexes where null characters are written in the code
> before the commit in question, and 'sizeof(buf) - 1' right above
> the problematic codes.
> 
> Without the additional 1 size and the absence of checkes against -
> E2BIG, strscpy() will angrily eat the last character of the source
> string. In my situation, strscpy() will take away one character
> before the comma "," (which is presumably the right bracket ")") in
> parse_parts(), making parse_subpart() unable to 'strchr(++partdef,
> ')')' and producing the following error message:
> 
>   cmdline partition format is invalid.

This is the same problem we brought up with the strscpy conversions in
scsi:

https://lore.kernel.org/all/784db8a20a3ddeb6c0498f2b31719e5198da6581.camel@HansenPartnership.com/

strscpy doesn't correctly replace a function of strncpy we used to get
a zero termination for a possibly unterminated string with a
destination that's one byte larger than the source.  The current
proposed fix is this one:

https://lore.kernel.org/all/20240410021833.work.750-kees@kernel.org/

James


