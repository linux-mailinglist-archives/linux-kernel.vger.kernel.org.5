Return-Path: <linux-kernel+bounces-150562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1FC8AA0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A712858E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD0175551;
	Thu, 18 Apr 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLy+4Lpt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB3916F855
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460761; cv=none; b=DlNekITbUD6kDe5554C3DwvJ4VGvrPt5Mu73i9+jyhW4Pk9aodzwRffDx5t62MlshymV5EKJbQjYh7ASGxfVLKYPsabWo8s2OCKPQs91KGR3AKmiS7TQc61yYcK85b46btO4zrR6w/B3MWkWq9tj88wzVEDSNUOQ+wVlCP3Yr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460761; c=relaxed/simple;
	bh=yROCoENx2b9yAJSMGatAYPh1hwYf8DqL0GPMYtwTMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQdHQSQiWXX78ezRy3oFwveSH+AC2a+HUcCsSr7Vwr4LobMD9ZoBhmdhT6QT3W+v7WqH4c6IHVhOB2d2fUQWQ4B4RUbPMJ4c4sWYJBS9RyN8xtMzj3PBvNgLZA9zigR8CMrWH9lkyZ7bs5HNp9c4zRbLQSuL0Ooz8UzIDErbICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NLy+4Lpt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aeeso509715a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713460758; x=1714065558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXGa0pEP8iUBNqIHW4VCl1wGNComHip6UrWPNRc9bPA=;
        b=NLy+4LptwTJ+sVVrAsl7QDaAMMCIkfZNfPnlZ3AI8aHeahkSb7f2UpAeCkxts8RiK+
         GxxBNrPYYlGKIBRjnnfJSsRHi7S2ljRDJTFWbl0HawdXLRixFLqKYC5L9yynSsvR26IT
         yR87XL/niiHEhGGnzj+K0TRT5LrzccSb3JxHZTlMIHu1EQH3jTNe163YJYwXyI9a8kJ9
         1NqApXiH4doMCSphcDVj+vd8OQkcjz/od/4kgjIzBXNyZe1GoJ4l2j/7MfORvagFaRkg
         XEUuJVi23TJT0fzp6/f5rXD/RvVZ74DYqTyOWeZCKh3lECgSM8vu4pzV+ZBhpU4W6DDk
         j7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460758; x=1714065558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXGa0pEP8iUBNqIHW4VCl1wGNComHip6UrWPNRc9bPA=;
        b=O2B+vaOgcUJGSTCEwsNbrc/MR6/39C6/QXcVFAV5maPq10FsmLWSqM13vWNpwjlKoL
         cB6P9uZ7vs7QlBZn9r+z9vlXHmGmbGY2yFPThzmAxtlD4i9wISCNiJNwBj0onu3TNqAK
         IxdkH3pdh0iK/yWJ/ksQiBs8HEI3mJgEwaAXS1Bv/jOUFk6Qv1LuVbm5Os45kYNsbYAw
         f/4WAWhTV8K9ww3eLcQlyPx5+w6JEXIgExN0wmi4ZnXD6DQrMw0BKa7i0b1SAJ9Gs/YN
         NMeVFZXhYjPZx6e+5j3KS+B8Dhz4p/UIrfeJE0oMqi2yiDBHe+B8lx5aKapm60Yw2a92
         9PDg==
X-Forwarded-Encrypted: i=1; AJvYcCWf8IJix7pnOrr9fyapOdjzWnA34mpaOHHwEWv90Co7XAa39e+t0n7lm7eLTID5jJlzvoIprNstDRQywwkOu0ONuRWU9V6FODdncgAR
X-Gm-Message-State: AOJu0YzQpGc1/BDk8iQeuAouBHE5HjT2J8GHnO6anJ2AzhTI/sN+WX02
	OeOM/8fLHCtl5gq3kGhNnnRo/6Fex5Guwm4GQzcMl6HSEoDew6/krt6GwtVxcaI=
X-Google-Smtp-Source: AGHT+IEwc41StGMMjA7NT/EcMHzsdl7Ubbyp3HEt0hPwzN/ol9BuHMjJLxAT3hzrUe7Xf/hT6lTnuQ==
X-Received: by 2002:a50:875d:0:b0:56b:829a:38e3 with SMTP id 29-20020a50875d000000b0056b829a38e3mr2946788edv.16.1713460758239;
        Thu, 18 Apr 2024 10:19:18 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402089300b0057016d010f9sm1101811edy.16.2024.04.18.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:19:17 -0700 (PDT)
Date: Thu, 18 Apr 2024 20:19:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbdjFdIHN0YWdpbmc=?= =?utf-8?Q?=3A?= media:
 starfive: Clean pad selection in isp_try_format()
Message-ID: <ea244234-38f0-4381-9c9a-b6c6076e7dcb@moroto.mountain>
References: <20240312024520.11022-1-changhuang.liang@starfivetech.com>
 <SHXPR01MB06710239B9F69E2F0EC0CB01F20EA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SHXPR01MB06710239B9F69E2F0EC0CB01F20EA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>

On Thu, Apr 18, 2024 at 01:27:04AM +0000, Changhuang Liang wrote:
> Hi, Hans
> 
> > The code to select isp_dev->formats[] is overly complicated.  We can just use
> > the "pad" as the index.  This will making adding new pads easier in future
> > patches.  No functional change.
> > 
> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> > ---
> 
> Could you please help to review this patch, thanks for your time.

Linux-media uses patchwork, so probably it was missed because it didn't
have a [PATCH] in the subject.  Just resend.

regards,
dan carpenter


