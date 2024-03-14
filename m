Return-Path: <linux-kernel+bounces-103231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E999B87BCAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53372823AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A446FE0A;
	Thu, 14 Mar 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UvBUPVua";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UvBUPVua"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9576F09C;
	Thu, 14 Mar 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418967; cv=none; b=KuKemCbBhioOjGN+qtVgId4EosnMcRtrlfc9nJdBXfJj4tQzD4iZ92r3kLcqQDwixYjA0zMEhI1lQ8ocHOjh8feU6pRIT8rzMnZ3crLsAbYnKDTrnTo1H9IuVNjEjwrSSOvJYpDulfRQ5hYGlLh0wVnraNCj45+XBGCwUClKdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418967; c=relaxed/simple;
	bh=uF11DoSFt961i+nkF6vLB5AG08D98tmA/0JbyoEeduA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f54zdYlTTE16SC3O79KtSJQyZmxt773CSw1te9QSO0pdVkj6v/izMEY9lB77uvyg1xYd3KGBlfAAo0MAqq1Xf7Dne+RvduAHvvZdbOvG2TpVbWNogh0Tc7TpDu28X0GZvW2t8QiUy1MrVyQ9ewe1IgJPkmOuYS1HRxQcyefkojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UvBUPVua; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UvBUPVua; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1710418963;
	bh=uF11DoSFt961i+nkF6vLB5AG08D98tmA/0JbyoEeduA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UvBUPVuafM8nwhbmf+1Hg6nBV1/IyeoZtHbq1z8RHiZHxhwNuxkEsyH4HDtoxhgrg
	 Y9nheLFZYYlBQlrR83z/myUdmiIr3pC+Iqvt9YLvosJx1bkdYh/ehBZGXqQJNwRrBD
	 GlY+t+sdgsvvgIVhMOt0QDcmxgiDicffdr3iRrK8=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 96A7312861A8;
	Thu, 14 Mar 2024 08:22:43 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id GuyOpsDknp7T; Thu, 14 Mar 2024 08:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1710418963;
	bh=uF11DoSFt961i+nkF6vLB5AG08D98tmA/0JbyoEeduA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UvBUPVuafM8nwhbmf+1Hg6nBV1/IyeoZtHbq1z8RHiZHxhwNuxkEsyH4HDtoxhgrg
	 Y9nheLFZYYlBQlrR83z/myUdmiIr3pC+Iqvt9YLvosJx1bkdYh/ehBZGXqQJNwRrBD
	 GlY+t+sdgsvvgIVhMOt0QDcmxgiDicffdr3iRrK8=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9F5BE12860BE;
	Thu, 14 Mar 2024 08:22:41 -0400 (EDT)
Message-ID: <7133628a2f45ad63e90c481387ed5b44906df54f.camel@HansenPartnership.com>
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: James Prestwood <prestwoj@gmail.com>, Eric Biggers
 <ebiggers@kernel.org>,  Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Karel Balej
 <balejk@matfyz.cz>,  dimitri.ledkov@canonical.com,
 alexandre.torgue@foss.st.com, davem@davemloft.net,  dhowells@redhat.com,
 herbert@gondor.apana.org.au, keyrings@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org, 
 mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, iwd@lists.linux.dev
Date: Thu, 14 Mar 2024 08:22:38 -0400
In-Reply-To: <a4d24b2c-7dbf-4354-9514-f8a253aac14b@gmail.com>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
	 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
	 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
	 <20240313194423.GA1111@sol.localdomain>
	 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
	 <20240313202223.GB1111@sol.localdomain>
	 <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com>
	 <20240313221043.GC1111@sol.localdomain>
	 <f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com>
	 <20240313230611.GD1111@sol.localdomain>
	 <a4d24b2c-7dbf-4354-9514-f8a253aac14b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-03-14 at 04:52 -0700, James Prestwood wrote:
> I'm also not entirely sure why this stuff continues to be removed
> from the kernel. First MD4, then it got reverted, then this (now
> reverted, thanks). Both cases there was not clear justification of
> why it was  being removed.

I think this is some misunderstanding of the NIST and FIPS requirements
with regards to hashes, ciphers and bits of security.  The bottom line
is that neither NIST nor FIPS requires the removal of the sha1
algorithm at all.  Both of them still support it for HMAC (for now). 
In addition, the FIPS requirement is only that you not *issue* sha1
hashed signatures.  FIPS still allows you to verify legacy signatures
with sha1 as the signing hash (for backwards compatibility reasons). 
Enterprises with no legacy and no HMAC requirements *may* remove the
hash, but it's not mandated.

So *removing* sha1 from the certificate code was the wrong thing to do.
We should have configurably prevented using sha1 as the algorithm for
new signatures but kept it for signature verification.

Can we please get this sorted out before 2025, because next up is the
FIPS requirement to move to at least 128 bits of security which will
see RSA2048 deprecated in a similar way: We should refuse to issue
RSA2048 signatures, but will still be allowed to verify them for legacy
reasons.

James




