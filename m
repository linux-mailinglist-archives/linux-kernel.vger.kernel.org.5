Return-Path: <linux-kernel+bounces-75746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F6085EE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24353B244F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7F111B2;
	Thu, 22 Feb 2024 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXlSBEPz"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE9362;
	Thu, 22 Feb 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563472; cv=none; b=S1B2bpHEUrfdFn1kh5/E8dlIKcGlRnBkk/5U5bo6ArhRfdi6HXzjbm+XOaMWzXQFv/n2Cj5Zc8amc7aNaz1BvTfmxQQDCbvr3X1M+XVSUOfAtJyFiQmzWZQFanCAx4qEcgl0MTmFeBqwRWVF4zZI5fFBCuHACANC2TcfoFIlVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563472; c=relaxed/simple;
	bh=q3czQcS3f2pROsTuqtnpicsUyFkM6v1BBvI4pgSvdXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIEaVwqV11Hji38lUKCyol1ynTByOhldPmcEe1oHCgj95a9MUde0oqUWhNwQAGvs5aCtQczUMdtRe+yXSLVzdEpvoFhtaZMbfIkHiCsbKBrzw7lDnKmMzBGkBM6xPNiA4pwLukW7+cdTY15nEV5tIJy5CTvD/YGKSq2OA+cMCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXlSBEPz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2ddc5f31eso3190740a34.0;
        Wed, 21 Feb 2024 16:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708563470; x=1709168270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9z+l+LmhwOwpEKG82m0tQWp4Ln8RYwoZgiLG43m1ZY=;
        b=kXlSBEPz9TJkRC+rEY6WDQvb4F9PYxwfB4LanlH2DOzPfuGzjRBFx7tH/cwN/bT3eo
         BxwElpy+ZvRyXhXffZh17HBNP7WMtIHWumtjEU2CdYxVnr2N2e3DISnS1Gd4XCE/ZqqQ
         P/QL5aWnseLeKMxKCSiEPsqDZiRC9ihsYf9YlDk+vo7Y8is6SgbBOEeeDRpBj5rd+Wq5
         o4EI1Of8QzsOGKdx4fY60i+9aZ9XWZAJxYmrBE+G8zCw2V7wYjUs5lsD/zqkaqa9W1V0
         h1HycnfaqFKIz5cFH6AswBc6IYk0sNQ9zQpENrXiPJPjrUwCchZVPZVRf/I79V3INjkj
         tWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708563470; x=1709168270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9z+l+LmhwOwpEKG82m0tQWp4Ln8RYwoZgiLG43m1ZY=;
        b=jDxqWx6JfOyqBy0qKzWqEfTlTvQoWS1/6ICr9tRxx8OL1TNz/3YJQjokhEeW/vGS4D
         KmJRb0jdbEPA+AbXTpMGrLBomhzOrKZtTR9AmWld1kgaz50MP59qG2A7vj7K9Cyp9iRO
         M6ZOt5QWffti9ONhJf7CZ4kp4mP10z+RdaMUz2buggr6pGDeyXn7hoV6JRvuI/Gdngmi
         DxmaZ3H8G45XfjLOUWy8/nN9/0WE266XeszKHpSGJkRZ/IUavKfeEgyXmUY1UZdtMnK+
         mOHizMeSm5x4J9Ieu/Q9kQlkIM5WLLO6VohTtilKwaYoaZV7YzK25gH1aiGE1b3Lu2EN
         s3pw==
X-Forwarded-Encrypted: i=1; AJvYcCWxVCopt1AVsNknJArh/U21qVMzE5j9MHTzZ//5T27ndLKQkDJmbmzIU7pycJk3/6T5N+oTvnFAVUQxoEfFqdj0yzWiVgyQvobBGpulI/ZqrVKhxkWdf1Iu24MGT9S/TfvcjsLZoUudmQ==
X-Gm-Message-State: AOJu0Yyaka6W1G2HXHSUD9X5CjyHlionBGNPzFcArwvsZvxq0ub/sTjs
	8dR9+pidchNrZ/vlMh4rNacLMyYsu1SSG6rVH6c2gKJaDfXHW7h9
X-Google-Smtp-Source: AGHT+IEm6oL3wxme8BU11INuHwl70DgBwixvjutoHH08Ks13q8LJMtAHpEMsI3+keRfORWtcuMEQFA==
X-Received: by 2002:a9d:65d5:0:b0:6e4:57f7:a6cf with SMTP id z21-20020a9d65d5000000b006e457f7a6cfmr8422502oth.2.1708563470531;
        Wed, 21 Feb 2024 16:57:50 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id i5-20020a639d05000000b005dc4829d0e1sm9260581pgd.85.2024.02.21.16.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:57:50 -0800 (PST)
Date: Thu, 22 Feb 2024 08:57:44 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240222005744.GA3603@rigel>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com>
 <20240220142959.GA244726@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220142959.GA244726@rigel>

On Tue, Feb 20, 2024 at 10:29:59PM +0800, Kent Gibson wrote:
> On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:

..

> >  }
> >
> > +static int linereq_unregistered_notify(struct notifier_block *nb,
> > +				       unsigned long action, void *data)
> > +{
> > +	struct linereq *lr = container_of(nb, struct linereq,
> > +					  device_unregistered_nb);
> > +	int i;
> > +
> > +	for (i = 0; i < lr->num_lines; i++) {
> > +		if (lr->lines[i].desc)
> > +			edge_detector_stop(&lr->lines[i]);
> > +	}
> > +
>
> Firstly, the re-ordering in the previous patch creates a race,
> as the NULLing of the gdev->chip serves to numb the cdev ioctls, so
> there is now a window between the notifier being called and that numbing,
> during which userspace may call linereq_set_config() and re-request
> the irq.
>
> There is also a race here with linereq_set_config().  That can be prevented
> by holding the lr->config_mutex - assuming the notifier is not being called
> from atomic context.
>

It occurs to me that the fixed reordering in patch 1 would place
the notifier call AFTER the NULLing of the ioctls, so there will no longer
be any chance of a race with linereq_set_config() - so holding the
config_mutex semaphore is not necessary.

In which case this patch is fine - it is only patch 1 that requires
updating.

Cheers,
Kent.

