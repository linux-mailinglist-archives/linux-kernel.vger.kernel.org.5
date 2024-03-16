Return-Path: <linux-kernel+bounces-105150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094D87D9C2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81F201C20F85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C518026;
	Sat, 16 Mar 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="WTdzJWpJ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A9C2F28
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710584312; cv=none; b=rDoyIVDvxtSw9hBnRxkapjZIz2PQ58iBHfl4u9tysjA8Let6npgEc9nzjeanPvzQ/yd1Yc1vUgc1YmmYiqiNycw9niTluWKrpr8/qlKm0fe1aGh6cAv8uf5vEr10wCmX8Lv476uDysrNa3JN/WoXmQbNR0Hpx5dqqPTaw9Gh/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710584312; c=relaxed/simple;
	bh=4Qv2iv24BM4N5rhWKQHGpMd7hu0rv8dZU6QY+sNN2E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbQgCSErBIMjUdPeNirvNCMkaCl1WQr1Tv8UQsTdg/4MLu2blxeqUKofMbV9lhPPwEREDxfo4MPW+9KzL6y+gbf4sXphIPJQuAOpgcgO4vNNThoP/zZnnOlKwf2CgXh7Ui645QGOejnu6dcHdfSyLqLiM0z8oyLNpJM2VyulDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=WTdzJWpJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4644bde1d4so372716766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1710584309; x=1711189109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZibTUb2beDDFO7s5+ADcLRkljFQu8UZ08PzSzzRuyg=;
        b=WTdzJWpJQFkXRVSj5q3JW7j5DKXi9cJMEAcf92e/UoXhvX80a+Iqe8d7V/6RN5KRvA
         IcmDAha/uGTRBem3WuXRQP+c4K76D7gvOAKBpoFM5F50tGPdO1Q3wN68yXOFQGog/3qr
         xL63oyeY5bydHvb4aem4tfiMa0RFX3atsCtiF27uNeeAh4qNVcQhm7G8Vu4jShUt4wNi
         hnnuv1+WjeewFaq9g+xt7Y4IakJmg8pzS9p8qKpYxjX4DsUnoHx0dRxC4MoDm10oJZK8
         PUOtnNTTJJ1N96MfAEPqgBvYb1VEa24CiG+UMvTA6goA5QmPGpe+bk5zaModpId795YD
         C5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710584309; x=1711189109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZibTUb2beDDFO7s5+ADcLRkljFQu8UZ08PzSzzRuyg=;
        b=qNTdFF2o9iK2c5o7isadR4efxC4R8j7RFLpgCJcdo2NPbRrQACOxJNvanUc5hERV3N
         gFx25dVjJo5PcT14x+KbeZO7esfrGkCCUPN/QB6rU+NfSr5Qqht1MMWmU/QYKP7FXOxN
         rQFOpozvMKbZUprLhn/11JeoO2snl1Phm3jyv/Z8uab/WoBObnKk1heW2YBKu9Xxhqfc
         Cp26BW7f7XyEgP9o3RfLXAtPDxlhXm1yTZdN+5qDtMa8KgAnSFegIXEx5Zul/Ite6lOJ
         HCuHnElLz9h3nBkpL4MtwYHzBR0VKPNCVYy/oSKG0oDXhj5P7xWq2l5E7H5lDLunLNqx
         6FaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFsqJZo0exlucB+RObljH7KurBTYH9KKI7rxHMlPK8epj21lXFw0aptGFpDc5BKvpM70PSUYQOOQQUizi5DhzLENZnEd5ml3hLaDY/
X-Gm-Message-State: AOJu0Yxl5OgxpSDvXbrB5ykuDm5NA892yFoDz7FtuBhgQDWtopJn0jWs
	kMf1osaefrXmj6KyQ7M0Q2C4RBNoT36agE9XZWwZqfWduaW+r58li05JV1BqkKw=
X-Google-Smtp-Source: AGHT+IFitShcfWanROCLOse88lz09EK1cUssei37FAjOLrcSJZWLjhOVIh2v4/mYPjn0bG2OwVQx6A==
X-Received: by 2002:a17:907:968c:b0:a46:220c:a55 with SMTP id hd12-20020a170907968c00b00a46220c0a55mr4297795ejc.73.1710584308724;
        Sat, 16 Mar 2024 03:18:28 -0700 (PDT)
Received: from localhost (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709060d9200b00a46ac55d8f5sm112562eji.26.2024.03.16.03.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 03:18:28 -0700 (PDT)
Date: Sat, 16 Mar 2024 11:18:27 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
Message-ID: <20240316101827.GA3058508@ragnatech.se>
References: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
 <CAMuHMdWwegdks3eEviEsBJE3AvUVKbZqHduYdhuwz=8xTMDs5g@mail.gmail.com>
 <260d82b6-e7fc-40c3-b414-50a883709fd7@moroto.mountain>
 <ZeWnD9YrXLWJYmhT@kekkonen.localdomain>
 <cc121bef-8bca-44e6-81aa-bf8e682bdaf5@moroto.mountain>
 <20240316094652.GC2092253@ragnatech.se>
 <0b77e146-df2f-4fe1-a4e8-206a62a5ac59@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b77e146-df2f-4fe1-a4e8-206a62a5ac59@moroto.mountain>

On 2024-03-16 12:54:23 +0300, Dan Carpenter wrote:
> On Sat, Mar 16, 2024 at 10:46:52AM +0100, Niklas Söderlund wrote:
> > Hi Dan,
> > 
> > On 2024-03-04 14:16:56 +0300, Dan Carpenter wrote:
> > > On Mon, Mar 04, 2024 at 10:48:47AM +0000, Sakari Ailus wrote:
> > > > Hi Dan,
> > > > 
> > > > On Fri, Mar 01, 2024 at 04:42:01PM +0300, Dan Carpenter wrote:
> > > > > Sakari Ailus pointed out in another thread that we could use __free()
> > > > > instead.  Something like this:
> > > > > 
> > > > 
> > > > Looks good to me.
> > > 
> > > Thanks for checking!  I've never used these before.
> > > 
> > > > 
> > > > We could merge this with your SoB (pending Niklas's review). :-) The driver
> > > > has been since moved under drivers/media/platform/renesas/rcar-vin/ .
> > > 
> > > Alright.  I can resend this as a proper patch.
> > 
> > Please do.
> > 
> > I do find the idea of scoped operations and the syntax
> > 
> >     struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;
> > 
> > a bit foreign in a C context. But I think the intention is clear and it 
> > allows us to avoid having the remember to free the fwnode in error paths 
> > which is a nice thing.
> > 
> 
> I said I would send a couple of these but then Markus went ahead and
> sent the patches that I was going to write...  And then it was like,
> "Oh, these have some questionable style issues" so it wasn't clear what
> was happening and I lost track.

I have not been CCed on any other work in this area for this driver then 
what's in this thread at least. So if you know of no other work in 
another thread I think you can go a head and send a proper patch for 
this driver at least, if you want.

-- 
Kind Regards,
Niklas Söderlund

