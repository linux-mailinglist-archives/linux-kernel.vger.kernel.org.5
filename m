Return-Path: <linux-kernel+bounces-32106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD683568B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF1EB227BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426C137706;
	Sun, 21 Jan 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gxF88Mqi";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="gxF88Mqi"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8FE364A4;
	Sun, 21 Jan 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705852717; cv=none; b=uTyhV8mxVxzdOyQZYmKQesgXI1AqLeuNiXvVmJaxq5gtZQHX5A8QVzF3NoskhReUHCwRhVkxTpcJoiQWi0tXVhAQ7Whm3wTHtBIhUDHW1FtWSxW0PoroOafZRfqg/uTnNFp3oHF348Q75fV3zimtuNk4RBSMj0K41cOjO2aFPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705852717; c=relaxed/simple;
	bh=vZKUTi/pGvf34rerdB8LD1X0SEf4pI83URewsECcsQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxEW0DAhwGYTUbO1qsiNLCWdLeycI2pfFm6Kd2KQNNuMi7Noth0domQDotmQ2DFCwdtWAekozVva0U2E4xQQIJW2f9rEmgNq4DI8Gowy/Qezg/kJtjIgedteO7ze0qSSfDO4pefHrtF45sP+a+Kb4leYvWQd7EF1IQ0Vd61RIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gxF88Mqi; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=gxF88Mqi; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705852714;
	bh=vZKUTi/pGvf34rerdB8LD1X0SEf4pI83URewsECcsQ8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gxF88MqiU/GafvH4sDGJEarDrnZWJRlter/VpO/KynZEw+/RglAO+/PhZTV5oWZAI
	 nclI0TW5nsBHZTZfcVh9Td6c75Y+zCR9854fr/PDMkxJfW/jzldVm6qFMcD2DYgPwP
	 cvdXuGK5fL+CSwWdV6B1rKougVtBELCm35tC8g5c=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E7E3612810AE;
	Sun, 21 Jan 2024 10:58:34 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6anIjXJcDn9K; Sun, 21 Jan 2024 10:58:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705852714;
	bh=vZKUTi/pGvf34rerdB8LD1X0SEf4pI83URewsECcsQ8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=gxF88MqiU/GafvH4sDGJEarDrnZWJRlter/VpO/KynZEw+/RglAO+/PhZTV5oWZAI
	 nclI0TW5nsBHZTZfcVh9Td6c75Y+zCR9854fr/PDMkxJfW/jzldVm6qFMcD2DYgPwP
	 cvdXuGK5fL+CSwWdV6B1rKougVtBELCm35tC8g5c=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1D9A31280FA8;
	Sun, 21 Jan 2024 10:58:34 -0500 (EST)
Message-ID: <83d6dca5fec8b2b31e548d56cdf196e39549d9ca.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Theodore Ts'o <tytso@mit.edu>, Linus Torvalds
	 <torvalds@linux-foundation.org>, G@mit.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi
	 <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Sun, 21 Jan 2024 10:58:32 -0500
In-Reply-To: <20240121063038.GA1452899@mit.edu>
References: 
	<d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
	 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
	 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
	 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
	 <20240121063038.GA1452899@mit.edu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-01-21 at 01:30 -0500, Theodore Ts'o wrote:
> Unlike James, I've tried to use DANE, since about the only thing that
                    ^
                  never?

> has as disastrous a user experience as gpg is DNSSEC.  :-) I just
> manually upload keys to the kernel and Debian keyrings, and it's been
> working out, apparently without much pain for either me or to those
> who rely on my keys --- at least, no one as complained to me so
> far....

Well the theory is sound: if the DNS is secure and trustworthy, getting
the gpg key from the same domain as the email records proves the tie
between the uid and the key (obviating the need for all this keysigning
and web of trust).  Making DNS substitute for all these stupid external
CAs for web certificates as well (via DANE export of the X509 public
key) is also a good idea, as is exporting the ssh host keys and things.

However, having maintained DNSSEC for almost a decade now, I'm not
going to pretend it's something a non-expert sysadmin should be trying:
it's very particular and problems are hard to debug; you really have to
be in the top tier of expert sysadmins to be successful with it. 
However, once it is running, bind9 now takes much of the pain out of
rolling the domain keys and, if you run a dynamic domain (one that can
be updated with nsupdate), you can actually give all your users scoped
permission to update their own key records, so if you have an expert
sysadmin on the domain, they can make DANE usable for all the non
experts.

I think the gpg usability problem is that I can't mark my key as being
DANE available in the key itself, so gpg would just automatically check
the DNS for an update and throw a warning if there was a DNS problem
(but still use the cached key).  The failure is the users having to
figure out that my key is DANE available and then what combinatoric
explosion of gpg options they actually need to update it.

James


