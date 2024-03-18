Return-Path: <linux-kernel+bounces-105801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7C87E4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DD42828AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E55288B0;
	Mon, 18 Mar 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcBOLlQs"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F525774
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749153; cv=none; b=jN1WXnrcGAg4XlAz7kE+rXGEXvIPxQNCuyH4/jTYYl9akw+If0fE9CC0fllRi55BRWuu4f7QdDWuPTNu3MmY9ZlIAkHI6KgRrE01WhxeuXz2NjBZxyN6AYfjkO/8Flp/8L8ut0JMwX6Ph9w1VcwL702mCT+Wkxt/ndYUtFnEQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749153; c=relaxed/simple;
	bh=xi5wwcua6lSYpDyXXRxYzCJScSbcdjnZzat3Av4lAFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDGCuXiVh+q8U8ULkvllIBEfUWIUFo3ST211tFoExKxzAjqK4+pALCrRimO6iKoT6nnAb5wPwlh2CxKJgao2G0fwTg1UgJ1tbGcb3rXt9W3bLURg53zNmlEE2y/9shHF4RknUyQAuIWKXdxdLxvBeicHTdvZupc1jcOn4An3V3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lcBOLlQs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so457419566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710749150; x=1711353950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItwEhW+Elih6WOdZ654FWHRBfnNI2hxeOn7Y1OcJxDk=;
        b=lcBOLlQsJJHhrlOR8jwNpiV9pjv+mgPTwIkKuLlGvqugNHYh+I2uPNrItMz1CRZyOz
         xfyIRZM3063F+mh6QHX5uwI93yrkrvEroBqtX/w/zTJrhtFszLcZN48lNLujaLy5+/mi
         lfxm2z3DxAT0KH0LX3Rlewr6VNWYr5M7nsEV3RapNwJudHX86F5KZ5HUJmlGwAMWtaDD
         Xx2O8QOuWmIE8IEFWUr+DRWKijuIiFuTNFv+hecLxtQbpe0zwt6vfAEWhQ6ncrGCiPJg
         cg06XHoQctWVUNKbo8LONaZw2njAIDU6/01J5YjwVxGXjXrXLhQ2AMxKwq9JcX8y++5o
         9ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710749150; x=1711353950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItwEhW+Elih6WOdZ654FWHRBfnNI2hxeOn7Y1OcJxDk=;
        b=pUmL5UpDTPWrsvtSxs/BT3BrihjI3h/E21qztGUT5bGtSfCdUP7yLZhQwJPDrkZKr/
         wv0vKImuZ4SgVhdy4ehEGvY+8Z1CL4VgT3/+8ip3SWa3oIRSbpEcRF6unGu88RtcKtzb
         E3yuAEvMragPPu/YQ6LNkKhTqVenX77gt9vajTDIlJIBge0HJDRtKb5CliDpLdhn3te9
         Big1g1Wq4tkZq1OlB8JvqNbmi57XSfJ5rtgjNoBL6pNwhkHfXbFkwfjUD5iq33Zsxcx4
         K+8L7Cqp3USxxbCpnch3VLSQLAtRZsCJRT5tQIHm4rt8SZnlu5WDWCzkJSJAr1+4ropL
         s9iw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kkAOGDninb70332x9v4IAiojF5NrNdRsIWNIRXB8SiZTN7F27mExM0iIcHmgI5sE0tEVxi71NGXicSXfgwpDgH8/zFvk3pTzeASl
X-Gm-Message-State: AOJu0Yz7zdNXmEnyPcGiuLU26kxIvprVtL8oJssjigKbl8CkVi/gP2bV
	lXGUVajL8HUqsULadJoqvg80RRbGcB2nYIMTOb35Wo1nx383dn7hihn3RzegIKA=
X-Google-Smtp-Source: AGHT+IHKtcrmJOgM+mlLfZ7Vs05DyRjA6NQDYRTKLkIuZFdj2gc0SGhwQECvBIW2kaQ3t2ReK5LFKw==
X-Received: by 2002:a17:906:5fd5:b0:a44:e371:a31b with SMTP id k21-20020a1709065fd500b00a44e371a31bmr6557533ejv.10.1710749149848;
        Mon, 18 Mar 2024 01:05:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ht17-20020a170907609100b00a461b1e814asm4517581ejc.130.2024.03.18.01.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:05:49 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:05:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Message-ID: <148f58b6-fe56-4fd2-b430-d6aa40037bb5@moroto.mountain>
References: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
 <20240318032133.GA1312783@maili.marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318032133.GA1312783@maili.marvell.com>

On Mon, Mar 18, 2024 at 08:51:33AM +0530, Ratheesh Kannoth wrote:
> On 2024-03-16 at 15:46:10, Christophe JAILLET (christophe.jaillet@wanadoo.fr) wrote:
> > UTILITY_NAME_LENGTH is 16. So better use the former when defining the
> > 'utility_name' array. This makes the intent clearer when it is used around
> > line 260.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  net/caif/cfctrl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> > index 8480684f2762..b6d9462f92b9 100644
> > --- a/net/caif/cfctrl.c
> > +++ b/net/caif/cfctrl.c
> > @@ -206,7 +206,7 @@ int cfctrl_linkup_request(struct cflayer *layer,
> >  	u8 tmp8;
> >  	struct cfctrl_request_info *req;
> >  	int ret;
> > -	char utility_name[16];
> > +	char utility_name[UTILITY_NAME_LENGTH];
> Reverse xmas tree.
> 

It's always hard to know what to do when the original code isn't in the
correct format.  Someone sent a patch last week which fixed a bug and
partially converted a declaration block into reverse Christmas tree...

regards,
dan carpenter


