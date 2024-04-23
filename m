Return-Path: <linux-kernel+bounces-155110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C7D8AE561
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2351F24312
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916A86242;
	Tue, 23 Apr 2024 11:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDX2fZDm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7C12DD9A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873319; cv=none; b=Z7VBymkt5dJNb0AxaL2GD7qaiRqdDOw8y3eB5o4u/cUd4QH9K5O+Ve01smteIdlKRjqlbRnXljUcy7DK7muQXYOAkJCPenFpJUtNCtsf0VsN97Ep31MZ7JzNobjwfXm90vUTxhglf2VEYnRzEXGJX5dOZdjo8LPfcaJQnT05bHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873319; c=relaxed/simple;
	bh=naRCsBSPKOwXtsBWSD0Z3M0ggK9Ecnz+DijdexeNtJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeM8vv9krHyxLJHEtWuO8aeJtrdZ2pmlbZ138JDsT7aqzcI8jwH59P5bViAD/O8CXeVPo2qIz1QyidzmqDsOA8ktZ+kolY6eRTuEEOu1mpoPuUOGAMQmzXN3vLT6IrME5gmuPaqtHnCyZneFNP+6Wukxm/lyFYVuxKkC/zUYcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDX2fZDm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a55b3d57277so275513766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713873316; x=1714478116; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLs2w5Mb2TuW5IEF0yGhInk4y//qTnl8Y3J8SN796zY=;
        b=iDX2fZDmoCqJnTihACafsRkXvpGsjirWwQndLp/JCcwaB+k9v/L8SdsHsHEgren86l
         p8/Tb263UwpreD5ExLsH08JAAd9Z0RbCbtVV931cuI9R8pHMTY+7ytH5HufD13ida8nL
         n2XaKxXP9yLJmDCs1DG9ICymjay9lM3TU39DMpvOKSXMZLk8l2S/UK++mU/p9eka2QYA
         97NHG8hkw6uvxMt9/23yj2iqh13vCHBpDM4Fa4LIHK2ZMZ4iazLVTjB9P1QqFnN9/k7L
         N1cjxIWMYHR9YGZ6MDvnLrST6ifl9CHHiR5kpqWfs6N5HCwIXUnY8WYkJ1EnKuUPMSR5
         dPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873316; x=1714478116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLs2w5Mb2TuW5IEF0yGhInk4y//qTnl8Y3J8SN796zY=;
        b=IGrciO4q062WAgEg9kZrDlCq3nGbEHnNOWIel9hUm96Vd79/6BXLkfngycXpoNtrca
         QoqYJejSlPGXzBNjgsNW3pHhvYJoDS+OY6CtpvUgwGYPiADrDGq3NFsvBtzG+jOodRnJ
         clHh9t0A4QJiQbD7Jm0OyCnZNDnn++tlY8yC7vXM8Kc+HYb+6fKgj/6ACD+4FABLRPhA
         GVh4mucT+eLegy1vJIdAn7PmR1kY7cagAA7aWs6MdvrZ+7kna/xQwxcBZpkqVvXDTXSp
         T8fkRmy//i0XbLmBObfdMt2P4jLDGL9L3ekCQRJeuNqFi97X3KcyEbnzl5dwdM8z3H2F
         iB+g==
X-Forwarded-Encrypted: i=1; AJvYcCXWQyS3jFY91wCDg7fGY7cqev8xWFrCXvlVSQxlvvs8x73Wo3CWVOiPIhpFvD+Fk6P7YGKNuXYsr33J96QRInnggdYoxKrbzwsg7XUO
X-Gm-Message-State: AOJu0YznRQ5bPcAEXDSwM+cGl5fx52fYVnX3M6NuYE7VSR6Akl4456FP
	npoaALCksy72meQ5XyOI4lPH0l43U2O6IvfVUwglSOYLAQ2H4OOh44cXyHItFGw=
X-Google-Smtp-Source: AGHT+IFZ405qdGxDMkW1+5YC21CzN8lvjF3c9LLGQSea/WcHK3KI0QcB69sFb36UHpXXURv+h98QNQ==
X-Received: by 2002:a17:906:3791:b0:a55:554b:1f5d with SMTP id n17-20020a170906379100b00a55554b1f5dmr7343452ejc.41.1713873316016;
        Tue, 23 Apr 2024 04:55:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qy7-20020a170907688700b00a5887279b8dsm57534ejc.179.2024.04.23.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:55:15 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:55:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ibmvnic: Use -EBUSY in __ibmvnic_reset()
Message-ID: <da19d324-3c66-4bb1-8fa2-dc26dbea622b@moroto.mountain>
References: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
 <f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>

On Tue, Apr 23, 2024 at 12:54:55PM +0200, Paolo Abeni wrote:
> On Fri, 2024-04-19 at 16:08 +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Fri, 19 Apr 2024 15:46:17 +0200
> > 
> > Add a minus sign before the error code “EBUSY”
> > so that a negative value will be used as in other cases.
> > 
> > This issue was transformed by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> > index 5e9a93bdb518..737ae83a836a 100644
> > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > @@ -3212,7 +3212,7 @@ static void __ibmvnic_reset(struct work_struct *work)
> >  		    adapter->state == VNIC_REMOVED) {
> >  			spin_unlock_irqrestore(&adapter->state_lock, flags);
> >  			kfree(rwi);
> > -			rc = EBUSY;
> > +			rc = -EBUSY;
> >  			break;
> > 
> 
> AFAICS the error is always used as bool, so this will not change any
> behavior in practice. I tend to think we should not merge this kind of
> change outside some larger work in the same area, but I'd love a second
> opinion from the driver owners.

I missed the original patch due to my procmail filters...

You're right that it doesn't affect the behavior of the driver except
for the debug output when we do:

	netdev_dbg(adapter->netdev, "Reset failed, rc=%d\n", rc);

But the - was left off uninitentionally so I think we should apply it.

I have been trying to look for similar bugs where the - is left off.
It's a bit challenging because there places where we use positive
error codes deliberately.  But in this case a static checker could
easily detect the bug with a low false positive ratio by saying, "We're
mixing normal negative error codes with positive EBUSY".

regards,
dan carpenter

