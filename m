Return-Path: <linux-kernel+bounces-65254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2622854A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B751F2A5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2DF535C5;
	Wed, 14 Feb 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JP0nwrpz"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FA5339A;
	Wed, 14 Feb 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916366; cv=none; b=syC+Pglo3daVs/dit7T6apG9tG0rAlQZZeoPJ3Cnx2qg0mzheDs8rbcPN0aAMboHfW2GWLcR8cr4CTX5f3Z1JulrwMro01OpxT0h0xdDRjO3F1MH+uaDT8ylYO43geMGt3bPu8otv2PmEOtMbeZqzlshtKLtuhh49U6RwzauvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916366; c=relaxed/simple;
	bh=3pj6pCwvGHzrnBYVFkPzbVgTiY8sWV+MYBx7Wk7tlPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgoRwkfivvED/oZU34esd000d8ymKleh6/N06Sdw480vmZIyhZvXjn2nA7zv2aPknGxjc+6gF32JI08SueCLwdOk1/4K0BZ9kZueSevwg4vUJhM13hGo79lTJQuJDxZDmL71WewYq6/52Pi1UBrwGhan57wjk9LBas2J4LagfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JP0nwrpz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0d085cf59so2534777b3a.2;
        Wed, 14 Feb 2024 05:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707916364; x=1708521164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from
         :dkim-signature:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f+TTYz3ZRYn1rS6NQJfMoZIMgC1hO3L4Y8++b56qp0=;
        b=Z3GYprpyYXvsLRb7hvFiPITXMKe1UIweRaFJ3vu/96NM2HtvzE+DaA/G6Hl8BgCGo4
         WDF5aI+GHGwyYKVImkwpejq74O+X8xCBVeEH2KlHhvAW3Ol6xcZCSnUCzwUoM9HQV2N4
         fixoSfRA2baDvV4p5A7d1veqdErciso+czBjy5+Gl+dGSNuuwfhzzQpL3OrQ801vR748
         PpB5aRIH1BcJVXahgzD36VHR44cSr4RWTwzWAsuNtrgeDlLvOXBCca2z/gJodS6oZkUT
         6ZxuatVg7vI0pMibj78HhCoAU9bkd5qYFfHIUv5CeMO9IUaoEu6ipaqWKgISlQBk67yC
         4YsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPHuW6Q82Ehn+oa4VK3W/LGYfVSNvkr7kgnwXYhc+Ex3Qvdq34zrfxAasGVh2DkUslBi748BL+ZdamkgpQLY6mbatRiHwAWsXVz64WLvC86KChVf3TcP59hLt7nDeybKwfxkvWwsS4
X-Gm-Message-State: AOJu0YzQWQ+j5HLxSg7SuyVMIxsIyPfj1LwFT362m/PGblw4RrcqeT7n
	N/X2GA+7tIyxw64cOt3ofLEyKAdwvRSQCpO6j3saMWBfnW4gwgsp
X-Google-Smtp-Source: AGHT+IG7Ea1tTcWbsnNK6seHcuYhMsug3dCkIctRj9d/ftxNCsGdzkD/ijNec/lQ8S4sMyHOSDvLtQ==
X-Received: by 2002:a05:6a21:3a41:b0:19e:8ad2:c934 with SMTP id zu1-20020a056a213a4100b0019e8ad2c934mr2974931pzb.14.1707916364070;
        Wed, 14 Feb 2024 05:12:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhzr6dc0r+a806gJe9uzMu7w2QClDdqjCu7TIf4Jr+3OuBb+x4wwM8Kx07Aj7xAy1QngdIYCBWWvOykLb1qStN0OiWZPsnsId5qK95TARRLC+7CUUGPzf0jRdfmVINfXJ1WBzdVP9y+o0Ym/Eva/j8J1keW8mcHAZEQmVF2PeGtZ5Shw61HvDaITYNJNYR5g8XxKLV0ZtybbiJqFFhVeXwA2W9O3L4FkNkqnlKaINikaG8d7EVCcwfC9WUUQJeJ4pY/Q==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id w5-20020a636205000000b005b458aa0541sm4106954pgb.15.2024.02.14.05.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:12:43 -0800 (PST)
Date: Wed, 14 Feb 2024 10:13:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707916362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1f+TTYz3ZRYn1rS6NQJfMoZIMgC1hO3L4Y8++b56qp0=;
	b=JP0nwrpzpfWIaqrG/NBK9LTQ5tOzpP61eJNKXlR9Lp+bXY1c77qJHME9urEdC8Pd7TqVaj
	urDARYLVAuNEeY7EmqApcaFMtAMGq6CfjgTnrx7Pl69NbUzIkixXARBxCeb/0kjYlPkXJh
	6LEtkZ18BomJzcNk/rNi5SdVtB2YtGIO0kd+k1AGAjr3OUB7gU5yxdZOyy1c/od5zmCVth
	piLHsW3WYdbQtqHc4rASbkX4c4kJXqtbF7f8sAtg5OPz3zUz7piMx0QrJVzyyToALwEhSn
	cRCvtKm1jEjaQPHa/iuFh2yOJvdkRer2+lu7IWBzlpJshl5zc1GBMUubJ6itNQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: "Ran.Park" <ranpark@foxmail.com>
Cc: akinobu.mita@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Fixed case issue with 'fault-injection' in documentation
Message-ID: <piosq44nxwlfeutperrk6d23bx564qlbfirc5xlbouyrunf24r@u6qsgqp47fz6>
References: <tencent_3EA07E65C43816C2A8402DC655CF98916B06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_3EA07E65C43816C2A8402DC655CF98916B06@qq.com>

Hi Ran,

On 14 Feb 19:40, Ran.Park wrote:
> In the 'fault-injection' subdirectory, the first letter F
> is capitalized, whereas in index.rst f is lowercase, but in
> index.rst all other elements in the same column are capitalized.

Does this fix any error or build warning? If so, it should be mentioned.

> 
> Signed-off-by: Ran.Park <ranpark@foxmail.com>
> ---
>  Documentation/fault-injection/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ────────────────────────────────────────────────────────────────────────────────
> modified: Documentation/fault-injection/index.rst
> ────────────────────────────────────────────────────────────────────────────────
> @ Documentation/fault-injection/index.rst:4 @
> .. SPDX-License-Identifier: GPL-2.0
> 
> ===============
> fault-injection
> Fault-injection
> ===============
> 
> .. toctree::
> - 
> 2.34.1
> 
> 

