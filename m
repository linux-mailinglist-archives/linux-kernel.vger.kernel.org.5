Return-Path: <linux-kernel+bounces-89662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCC86F3D0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 07:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141041F22051
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868AA9463;
	Sun,  3 Mar 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="K1qlQmq2";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="K1qlQmq2"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B78BF3;
	Sun,  3 Mar 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709447843; cv=none; b=Dd9DiNZh/b/OBn0BGNyP9qPCePdhhlgnf9URlYBLKgPxhSAP0dgnis4gQ/nJsJDEIfF7kJYXwZFhnJB+UWgCcttDUpPK4bB4Zvi7Ww0uiqPsszor2yTSdhBH/cTmY0Y6tA0K5eeusQfme/LqEB9gVhmQkq9Hh8jdcnTwGXhHrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709447843; c=relaxed/simple;
	bh=Mi/1sj0+EwyDTN7bDczKsKPQ5d8sXsTdgkNDwNjo7u8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJGfj7nNLrh0XcV8uhaK6juq/t1I+WmqLf6RnE67jrmECTO8qAjL3WyDHEnpdxutILIEQALcNpuxm341qMBz1YYzikjcwJMNR9Fmu7hYqxr8ru9mdt3WBmIKNdvQRwTzinnKDbxF1PTUnwrkgikBLtP8lEAijHCxZQ1LwjNOhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=K1qlQmq2; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=K1qlQmq2; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709447840;
	bh=Mi/1sj0+EwyDTN7bDczKsKPQ5d8sXsTdgkNDwNjo7u8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=K1qlQmq2ZgLYGQE2Y7p53QE3LjGwYBigLKKyz6tlNIlQ24KGyL5boMI4CMkmH6EL9
	 HnFt619DD4D8mfzxGTuC78ShdKZdyDA6+DLoq4cBWP5+9jMKMtZtm2Fv9nILFS2alg
	 PA71UbUk2w/x9IZAIslQBYA7Qt/t9vVOa7S3y+M4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BF3B712864AB;
	Sun,  3 Mar 2024 01:37:20 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NNLYqV4Cspjy; Sun,  3 Mar 2024 01:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709447840;
	bh=Mi/1sj0+EwyDTN7bDczKsKPQ5d8sXsTdgkNDwNjo7u8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=K1qlQmq2ZgLYGQE2Y7p53QE3LjGwYBigLKKyz6tlNIlQ24KGyL5boMI4CMkmH6EL9
	 HnFt619DD4D8mfzxGTuC78ShdKZdyDA6+DLoq4cBWP5+9jMKMtZtm2Fv9nILFS2alg
	 PA71UbUk2w/x9IZAIslQBYA7Qt/t9vVOa7S3y+M4=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9AFF5128646B;
	Sun,  3 Mar 2024 01:37:17 -0500 (EST)
Message-ID: <5227f58bb2caf9ce76e131b4d775df4755a0cafb.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 01/12] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Lukas Wunner <lukas@wunner.de>, Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-kernel@vger.kernel.org,  saulo.alessandre@tse.jus.br
Date: Sun, 03 Mar 2024 13:37:10 +0700
In-Reply-To: <20240302213427.GA30938@wunner.de>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
	 <20240301022007.344948-2-stefanb@linux.ibm.com>
	 <20240302213427.GA30938@wunner.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-03-02 at 22:34 +0100, Lukas Wunner wrote:
> On Thu, Feb 29, 2024 at 09:19:56PM -0500, Stefan Berger wrote:
[...]
> > @@ -238,12 +237,17 @@ static int ecdsa_set_pub_key(struct
> > crypto_akcipher *tfm, const void *key, unsig
> >                 return -EINVAL;
> >  
> >         keylen--;
> > -       ndigits = (keylen >> 1) / sizeof(u64);
> > +       digitlen = keylen >> 1;
> > +
> > +       ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
> 
> Instead of introducing an additional digitlen variable, you could
> just use keylen.  It seems it's not used in the remainder of the
> function, so modifying it is harmless:
> 
>         keylen--;
> +       keylen >>= 1;
> -       ndigits = (keylen >> 1) / sizeof(u64);
> +       ndigits = DIV_ROUND_UP(digitlen, sizeof(u64));
> 
> Just a suggestion.

The compiler will optimize the variables like this anyway (reuse
registers or frames after a current consumer becomes unused) so there's
no requirement to do this for efficiency, the only real question is
whether using digitlen is clearer than reusing keylen, which I'll leave
to the author.

James


