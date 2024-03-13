Return-Path: <linux-kernel+bounces-101316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7187A578
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A345E1F20F95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B938DDA;
	Wed, 13 Mar 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW57ffSG"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BB22615
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324212; cv=none; b=cDfcgi0iuSD6IxXGDQnemWk7awoT5hPJc/jn6MPyXEbLL7NDPH5aU0GfjYHsllhNZUZtWgfZq+NosLpku45kYPoOYXo7NJNFSiwIjVc8iAX+hTmkEbIEyqaD7Nfm1ZG2SHSr1WzWc4NdakFO97FZN9PPySCc+MQNvkiOhRKuLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324212; c=relaxed/simple;
	bh=SYoPjcYuU8Jtq9dJ6eJ/BaLc9EDIPdRFn0FcCAdJ5Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdJk+TAzOhRaypqfdJ9e5K+/RcGm3H8t1V5DTJjQ/6J2Hh+VT/oT9657BxB3kJrtuHG2EpFSAcEHtVvWZR1iNzgafHPcMzy29lYdwyGAb6Wrkh3OPmbha7/3o3+KJlCQ/PARiEqcGpq3KQr2659jys9Vdj366sc9KR9whXAbFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HW57ffSG; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d28051376eso70179651fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710324209; x=1710929009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3c+f14fS4xcyhQ4ZpJsTOO0eup+3eDmvL4CiWI3nyo=;
        b=HW57ffSG87N8jCwHyBVjeNb8au5nRBo5UeuC6ZNmd41R8G/PYvUN/cm2FWoRj4X0tv
         LB108uvFOHdiNy+Qfjsq8KAgJUTK+7HDdhO1bX2XA0Q6VHnN6TRmOKTkGJcNBmKTZmBS
         Ei1Cts5yaAGvIeNme3KdUx8ZA3brx3oAPtwmdb2L7qje9UzONx/Ep1BRsdGSUkLu/aVE
         6rPnXA4C38kbjZw56//nGWouN4XOQLKKM4uQkrcuyGgklhUu9duxTAEQ9NmipTY8D9E7
         AKc+5EIX8ByIsSH/69Ldq6rLY1ikTvns0wFfNLQ3uy5NN/oYXHDIyYmeOKmaKeRTy/JW
         2Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710324209; x=1710929009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3c+f14fS4xcyhQ4ZpJsTOO0eup+3eDmvL4CiWI3nyo=;
        b=hd95Gft05gjuGhTbf6+d04OOPik579587CpCepk7Zo2xaKOH16oZn0AHNOSz6YoDy3
         PpZev/bcE5kplGu3ziGR3Iu8msTNsGGPhEJgXzli2QSp0gkk7GiaJMpP512GcVmnpABR
         4aRehkx59LlJBWgn4+tGhVp+XGe4HwZ+ePsDT+4AYoICaRgG/G5q3keiI5Yd21HCbpBi
         FroSbcjQ9Gy8rLjhhmaWN7b4zQ7YM2hoxEW8Hq9v/jS82v4zg15yoP8FU+RTjzOd/Yo4
         lj2xBiwbdK1N6Uav3YmGOHAideXi2n0V3EWHl2fVJHGq2oXm8fUGFDNueRnZM91awDev
         pYaw==
X-Forwarded-Encrypted: i=1; AJvYcCUbSOcR2VnNRzBnSmbvkMmMuoo+QdhSa4rio5N1AuhHFXh1ygRoaN38Jngg9QguLbFDgKaK1D6uTpmkV+Nag8tnb8L2isQc+3JOtJDD
X-Gm-Message-State: AOJu0YwxNy66QQKpO33fVLsJqIuVMdMZK7+YSgaeMStTRwxhzsOFsIj4
	nQGl9V0b2ZEPHOVaTma8OJhpRJtnbks86qmNPJ1+GLWqkdRS35ObduN+FAxJ1zA=
X-Google-Smtp-Source: AGHT+IGaGa1c2MagWSCpfcSUCwskPRY6kaoYAs/KYgSO6bXuZ0WkU9338PzQENzjzFIlgzadxX4hUQ==
X-Received: by 2002:a2e:9ecb:0:b0:2d3:8c1f:c0ff with SMTP id h11-20020a2e9ecb000000b002d38c1fc0ffmr7515975ljk.16.1710324208831;
        Wed, 13 Mar 2024 03:03:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7dc14000000b005684fa1c4dbsm3746849edu.52.2024.03.13.03.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:03:28 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:03:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v5] staging: rtl8712: rename tmpVal to avg_val
Message-ID: <34420a42-e81d-4618-af88-f17152bf88eb@moroto.mountain>
References: <ZfFpW9XvHhUkcspq@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfFpW9XvHhUkcspq@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Wed, Mar 13, 2024 at 02:22:43PM +0530, Ayush Tiwari wrote:
> Rename local variable tmpVal back to avg_val in function process_link_qual
> to give intuitive meaning to variable and match the common kernel
> coding style.

You're write your patches as if we have applied the previous versions
but we are not going to.  Please read my blog on how to send a v2 patch.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


