Return-Path: <linux-kernel+bounces-39159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E6383CBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0D29C101
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8124134757;
	Thu, 25 Jan 2024 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUeP44zI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E21353F5;
	Thu, 25 Jan 2024 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208937; cv=none; b=tzWh+tOrhlDAjbKsBBVVKZo8Fq1yfXjeMduGs+an0jX0T9h3hNP0JwoQN2tWgRWtQOmYY0QFZSvUOt/AmQ1W7i0eJM5PhFMExjOlhhEeH0UU7H1iRRaKgt+yWm7ZWv9IQiN/fdu5S+0Wkq+hfUyIgcfLKMp+tl0p3FlZNIyk7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208937; c=relaxed/simple;
	bh=xL1o4akDmv3GZ05qtXAp1sjKZZofuqrZ/jYaOhwh2MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEbIweTXHBpZBXXeP/rIu9xBGJsy4s5RxRhTcWn2Q9H/DS9J4za0pwflTzc5j/uWsG1UtKRnsfPhwcQyDzfP+0MtvauzoSZ/dmqKJYMihPEv3KqzgGRE2lelaEfL0cityl3vRie7PnKxT2wqxc+L5OxsgZxCGboFN51W9Ae3YnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUeP44zI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eac352733so52995555e9.0;
        Thu, 25 Jan 2024 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208934; x=1706813734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL1o4akDmv3GZ05qtXAp1sjKZZofuqrZ/jYaOhwh2MY=;
        b=nUeP44zISTVCpgbAPBYwSA+4ET9NTX6HyeysjglUwXiO+ZCv2kegzPpRzB2vU6KlV4
         ciTKxoSo2Z0RTYdmIp6kFqPAeTFsVOW+qYLi09iD7rZN//BbLL6xjRqB/SWNIJayzaen
         tG8bPzF7nFUNJVb3q7jremPiVpyLeI+F+0TT1Irh7KnmoSOXnhIisYIh7JSbnXAwLR4M
         FBfmurXrfRMcoQI0/Gdt0XMqyjs/06oMqBerZJRG9u5cOseQj9AQT9zTxkzo5gYZsiMq
         kpEmtGYgjdn/mM/+F2CEn7lhqXKcj0KKXAXVg2HU09gXpYc/4Fey49PfpYWnPAxyuhms
         w5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208934; x=1706813734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xL1o4akDmv3GZ05qtXAp1sjKZZofuqrZ/jYaOhwh2MY=;
        b=LgH2RiD327ujkLg5pmcHeK1YcS/rxAU5UbWLbuR7f0orB41MXZmhrAU/hfRsuxO9Rt
         vEuNRnImTyCxBDap7fODimz+aYuKaYsezt/6Mq60SkkLehwkkDnTAjy/kOOWXO4Lsjxo
         wIzm+m0oE2kcNu0+KOOmQII4YwtNfa+UYPeD5Mdj2+f1VT8ZGdfX6pHrXO9qJEh8ylL8
         P8TRHJc4HMtVEx0Oattbtk4qrTfcD+eEqfwg92RbAQs7WCD2nrDEux3CZd+QGm7aFiND
         rfCtH8jdAgBzqQYqJ9GzuAacfMtzuYvSWzMRBnwalrsIhec8WDIWA46dlwHIqERtDhSd
         vxwA==
X-Gm-Message-State: AOJu0YzuYs10CTnQVD6EQ55sBqI0hRrkEaEltCi+tEjdwIv0rF6s5xI6
	saLoT0CL8zLhYC+lv3fPGD3f7ODwJ+cMIZajoeTRygf70ISypwlcVxRGdMXscQk2be0o9uhU6wG
	xHXOkPCH4WBJn/bc+FSSp91UXsU2dRZXARNg=
X-Google-Smtp-Source: AGHT+IEoXkbKpfHQ4JOFFkhGZW5beAXCIJBNiwpq7N/BVuKOwFvEQBn+pDmlf5IYPOO7PTdyWK0WGPy6quicNwKnFQk=
X-Received: by 2002:a05:600c:5106:b0:40e:c2db:92cd with SMTP id
 o6-20020a05600c510600b0040ec2db92cdmr138592wms.32.1706208933741; Thu, 25 Jan
 2024 10:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125102555.2621736-1-ckeepax@opensource.cirrus.com>
 <20240125102555.2621736-2-ckeepax@opensource.cirrus.com> <20240125135509.GL74950@google.com>
In-Reply-To: <20240125135509.GL74950@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 25 Jan 2024 20:54:57 +0200
Message-ID: <CAHp75Vc4jiz3Wjg_1DKs=X=Q8oxMmEASx2VB-BZsawSDa2cwRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mfd: cs42l43: Tidy up header includes
To: Lee Jones <lee@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:55=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Thu, 25 Jan 2024, Charles Keepax wrote:
>
> > Use more forward declarations, move header guards to cover other
> > includes, and rely less on including headers through other headers.
> >
> > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Patches look okay to me, but seeing as Andy suggested the changes, it
> would be good to get a R-by from him.

I'm worried now only about missing a commit message in one patch and
(with less severity) the v2 of this one which appears not to be
necessary (i.e. v1 is fully okay). If you consider the commit message
absence is okay, feel free to apply v2, otherwise with that addressed
v3 can go in my opinion.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>



--=20
With Best Regards,
Andy Shevchenko

