Return-Path: <linux-kernel+bounces-21802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A52829483
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB72C281F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA663DB85;
	Wed, 10 Jan 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8uBaUIX"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA83D966
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e43fb2659so33252045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704873103; x=1705477903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YP56O+ka9egXRogxRY/IcuNAqoutWmWtHH4NGgeMzmE=;
        b=z8uBaUIXtAGvxU/avXjjVUqq44MWWE0zMUksAxH35tC5huME9hVgkyvMB9Ca7iW4DR
         HDm3trdaD9onNBvxJ2d5o2ugtEw8Mzyoky8iAIZjHanJOF8KV/QYaVsuQEQBrcLrJsX5
         9gFkq7jhBd+OWRwRJxpjDpwjBeJ8ihZjWaWUxfp3GX1l5nkMXFrGaVWLV3/yHz74lc2i
         6bQ93PiC/PZe6EZhM2yboT6zzpP3BGrWZRQSmN/7PdxkUNRExKRJkFJ4WRS3/RDzfw1a
         wAtn3ImsLNKwcAtFUQcN76viAYpzM3QSPlCeP4r2vMC736+e7f83ZtvpLJGPokmtt5xy
         Ix6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704873103; x=1705477903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP56O+ka9egXRogxRY/IcuNAqoutWmWtHH4NGgeMzmE=;
        b=BkbA6tDbCbyORoM0heCP10HoMRbDW50pfDDd1EH8Buqj0fH+Df3QWJQiVb5E1FORjK
         BjOZRHQvdBd55fhVQbSKcGjx69g4rcUoda4IOdeCJGCD50qQ0RcbeU0LvHRvFLJEpbqL
         FrQHHvc9LADgV7QyxJPg7u3IGXTIwZ95Fk4Avtw8jA3Yr6KoQfycAQ8HtTISfQPgOauX
         /1CdVIGS+HgKDhHTSLfmMyypkWSLy85J1lwbkJB3KRjGLGR/AULWS8C4LtAobcllTgDu
         eS7PbDTWmoMlpNu5oAiyQqrgOUxucIC7GHwAhIIWR/Cbj/X3bXaDTuEQdhVys0TeqMsX
         mLYA==
X-Gm-Message-State: AOJu0Ywy47WsRD5jmiaRU7G4WuBs49QqB8JQe8W00Dbk/rPet3w6k29I
	iLpfAKzFEln6kLR76rV1U6QZU2tb/LKzZYobgvfScHxOLL4=
X-Google-Smtp-Source: AGHT+IG9rGcLM44Fx06MOQlPAy6X0qV7njAUYmbcepFhr/WKeb4ywh4TgTxAt+9HF5bj4FVogxLGRQ==
X-Received: by 2002:a05:600c:18a6:b0:40e:4ab8:639b with SMTP id x38-20020a05600c18a600b0040e4ab8639bmr249138wmp.39.1704873103535;
        Tue, 09 Jan 2024 23:51:43 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b0040d83ab2ecdsm1191216wms.21.2024.01.09.23.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:51:42 -0800 (PST)
Date: Wed, 10 Jan 2024 10:51:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthias Yee <mgyee9@gmail.com>, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: fix open parentheses alignment
Message-ID: <f22e751e-863a-46a9-8dd6-0ac55f1ad9c8@moroto.mountain>
References: <20240110072304.2226-1-mgyee9@gmail.com>
 <e3941caa-7546-415f-be7b-b955cf13aa8b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3941caa-7546-415f-be7b-b955cf13aa8b@infradead.org>

On Tue, Jan 09, 2024 at 11:30:17PM -0800, Randy Dunlap wrote:
> > diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> > index 36183f2a64c1..688c870d89bc 100644
> > --- a/drivers/staging/vt6655/card.c
> > +++ b/drivers/staging/vt6655/card.c
> > @@ -81,9 +81,9 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
> >   * Return Value: none
> >   */
> >  static void calculate_ofdmr_parameter(unsigned char rate,
> > -				       u8 bb_type,
> > -				       unsigned char *tx_rate,
> > -				       unsigned char *rsv_time)
> > +				      u8 bb_type,
> > +				      unsigned char *tx_rate,
> > +				      unsigned char *rsv_time)
> >  {
> >  	switch (rate) {
> >  	case RATE_6M:
> 
> Is there any chance that checkpatch is wrong about this warning?
> 
> I much prefer the alignment as it was before this patch: following lines
> are aligned with the first parameter after the '('.
> 

It just looks weird in the diff because of the + character at the front
and how the tabs work out.  It looks ok in the code.

regards,
dan carpenter


