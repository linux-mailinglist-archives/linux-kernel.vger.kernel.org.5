Return-Path: <linux-kernel+bounces-127493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE00894C78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF382282758
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D13AC2B;
	Tue,  2 Apr 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8XIPWsI"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603E383BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042120; cv=none; b=onI8FSxas6xgBwhYSp6UoquNx1Z66jMSH25OupWrD/nBwIrYM8qggPAEB7p//5useydJEW51Qz6t0liCsvNvQVEi6/jS61bP+1SKHUXHfuovECRHoGZ7v45GL1SJ4rjibRn0c5JiNLk6ku6SuLgNf6/hLZ163G4w0iDfrCgLBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042120; c=relaxed/simple;
	bh=YV6DYQDC3IEebm+Pxkl6Atlk7TWUF7BcjSHmxpdG2BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPZpKXKq93nIj6biHSkwINarJV2FcoBd9GhrR5528vcXXQnj4BIUwUlsO/bkPVePNTova8nVlOPg//X9UXbYyITH9dsg7kPKkC8j7FSp8xOatqBvQsLRhaP9qmRdjssEz7rRjrqxFEPAWViD6lV1jJ5yyofg8d19z/bxnQZB4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8XIPWsI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56dc9955091so1808083a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712042117; x=1712646917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcLmIctw5YZRqLa0BDTmesSSp3mrMTcdHK0j2v9fFws=;
        b=s8XIPWsI59RZd7FgbkmJs6gzqcVro/5P+kHFJeP3LkQIy9hjvfa7RgN5HYSFxoZSnW
         7QD7R2FuZmSf//E38wMg+VuxadOADKcAO6Q26SxBvMUctcBJVerROKzqq+Hp01vZewl9
         27TjR5ug+pgoDnoEEvRPY5/2r4qoZ1VNS+hkE5FyIw3qQXQ29CjX22cPcAjiFqbrAvcZ
         NC5rdzubWl8BhwFy8pkCkAphIU+xQ95CARSYvpUz0FkqNPsZLFujRqzgv3z2cwX3YRIT
         ARAfwh7vMJM1CQ+qS8pr5/uYx/LQNT3a4iKL9r09op3JeTddCK/XvTf6JCP9rulE+dGc
         k+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712042117; x=1712646917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcLmIctw5YZRqLa0BDTmesSSp3mrMTcdHK0j2v9fFws=;
        b=Rh9DFj9v/UqntI4VbewXaQ+VusD46YeBTe75C+2bjvfPFIYjMk8rO7VJuvixg1OmHq
         aS8jMrW7T9+3ukplkR2W4K6lnHTt2LVgwY3X5Wo15q64ELCzSq6SCrhAJ1BlRFEg/k3D
         WHem0HaH44UcDFaGDMAsIOdVRHkt/WW93vwMtbRq43YZ0TXNEX6OlYmUq1okFpL1bT4K
         Y4Pfvc2KC+9D7v1ReykMLp/1Z49SaYBTg2i0SkGFHLcaCeLK4HWZ58+8ZWhX5iWVegfF
         0RKE8xNDgP7lmjSlsEn56mc5e6MAgCW4OJbovQwTLVeF3y7UVUCMd2JUBMSFCNnr1rvv
         mYvg==
X-Forwarded-Encrypted: i=1; AJvYcCVbIm0aKSh22UqoNmQn8IAx4p4yZCAjxLBTXJS56jlCZN6NqWg36bIhjkZa3ixA3BTvLbfq/l+0fTPGdO+8TkBaMBJ5vht9hdE+sAfi
X-Gm-Message-State: AOJu0YwJTH+Nn1V7wRLyHUHl6xzNCIJeXDrNkGv68hcOjk9ffJ5FDERb
	65UHuGyuMhyEmLbpH5Imz9CWUqvSeFxwtcuxySyVKdQth0dCpfcnmud5MYTzJ74=
X-Google-Smtp-Source: AGHT+IE/t+XdD6wZQ394SX3ykpFvfynHcDHGuPT0TNGqT3wlNCQpXzyhP3G0Pj+iSe8R3hFkGfbHEg==
X-Received: by 2002:a17:906:4083:b0:a4d:f0c3:a9e9 with SMTP id u3-20020a170906408300b00a4df0c3a9e9mr6839023ejj.28.1712042117061;
        Tue, 02 Apr 2024 00:15:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090626d100b00a4e1aa345f6sm6147253ejc.115.2024.04.02.00.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:15:16 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:15:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Uri Arev <me@wantyapps.xyz>
Cc: Shresth Prasad <shresthprasad7@gmail.com>,
	christophe.jaillet@wanadoo.fr, frank.li@vivo.com,
	gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	luca.ceresoli@bootlin.com, prathubaronia2011@gmail.com,
	robh@kernel.org, skhan@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] staging: axis-fifo: align arguments to open parenthesis
 in axis-fifo.c
Message-ID: <fdc25599-f8a7-4d66-9535-494de8439da0@moroto.mountain>
References: <z2ewk44rjutv24i6lqau3adrmlprj524ulqtqbncvfaj44dwcg@2dnnbm75abbp>
 <72dc90fb-79ef-4dd4-b30e-97b1e7058156@gmail.com>
 <qnljnwccqvqzilxuoat2s6md2zwcuhfruzbpepxebk65k34t3g@cyl67lk5lsoe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qnljnwccqvqzilxuoat2s6md2zwcuhfruzbpepxebk65k34t3g@cyl67lk5lsoe>

On Sun, Mar 31, 2024 at 09:33:55PM +0300, Uri Arev wrote:
> > Oh, that's too bad. Thanks for the heads up!
> No worries, I wouldn't mind it if your patch got accepted and not mine
> :p
> I just don't think they accept patches to axis-fifo anymore, especially
> not basic syntax and checkpatch patches which are not as important as
> actual bug-fixes.

No, we're always taking patches.  You just had bad luck/timing where you
sent the patch 2 days before Greg went on vacation.

Greg is back now, but I imagine he has a long list of stuff to catch up
with.  It's possible that he also accidentally dropped your patch
because of the vacation...  I could imagine a situation where that
happened.

regards,
dan carpenter


