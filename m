Return-Path: <linux-kernel+bounces-51121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBAA8486C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF76281F95
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7467F5DF2D;
	Sat,  3 Feb 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU9qkXYg"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338305DF2C;
	Sat,  3 Feb 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971331; cv=none; b=El99AyExYjGN1LvCJ0NP6Yfb7O0bGDSDnLrvp6DIoL2McnCEbej4kdR6f+RtjTUfrpv7gqTVGf4/Omo7QFI2xWmjK//9pYMmHldPlnyfHgN5EEDCu0Jik+7JcD2PEZBcJsDj+jVeOkD+tfHF2WNR6xpRDSAtTNTgZM9FWNn2peY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971331; c=relaxed/simple;
	bh=ZE56VVcczwQ2Bb2zqSQpmqinQSmuJZtbgm+CG8DIV4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPc2PIRgjL0kp70PryEdWRI+NUBe/m91ggBsBzZLSEEgiBcEeMraiUSbycJc0uYkMKqob7LEuQOlsBUcpUIKiD0R7bvgp/GCKgTNVkAADP71cohTwBdTNjVvHzl36il0Fjxe1XBwiFoqp4z/IXW3MpyLMuX54bnna+n2spnVTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU9qkXYg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a370315191dso191650166b.2;
        Sat, 03 Feb 2024 06:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706971328; x=1707576128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r2tcDMWd5tAsjiTJCIBbSaN7CchAzH7Jv5tYEeWNeLo=;
        b=fU9qkXYgMyqZqODpNCs2X1to+scQ1alOEGlpbQVcDlEX69FMkRUZYE6ri3HwH3lhWk
         I3oYR/fHLJFQ/dorvXH+ogl/9FqN0KBq8GocQt69vKz7an+EyFKohdH7qfubZHCPycyq
         qhcH1znXrUloUb0pUYGCNHvL4LgVp+beXJ53yFiKjZpNcJK25ZSZv3Q5Iu/J12yKhyhY
         WvWNoVAPATaemf+Qlk9OBSiie6X7snr/Ny8SaMPx8Eu3CTtu3TIiO1b27JOtgEU6OoSL
         FrGP9BfDhrz0K6TAnsWOWYvHGTxqb/sZSjM5vguXVavTfLunZRG7vVtokK5f4zB+xfy8
         Pwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706971328; x=1707576128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2tcDMWd5tAsjiTJCIBbSaN7CchAzH7Jv5tYEeWNeLo=;
        b=XLVhp4wwGGgoMg7H/Dyqp/JeCZxw4W9tjLh6U8h233EpU5STzDIJxxTGBcYleyiKxC
         swwmrKKvxZtsXTSGWZwmGryfiHy5Znl/2lVjsffM+vE6cDT5esF1XwGIPVim32laQuPD
         scjOQiLPfcbIK8lMK7J/u3BgISAcJdU8tMUNhdK5rUPz3qWQ2x2hKen91vW8BLqeTAcy
         pgH9vcG7zllVoyRSTuXd55Ikh4yfUFMnRWMpuAWamE09hoE999fz4a3+yz/TRW9XRVux
         CrKlBZ0SbEdXPhOw5T5c3/crS0DdKM+RDQ/cHcTijfvEm1tmvoUOwndwhoiSu3M9JM/Y
         5wsA==
X-Gm-Message-State: AOJu0Ywsmip2qwD8fHi4OgidRG/U2LWrP9bEx20Zgnn8XrW1JrpIhB7n
	qlpTRoYAMXIAhgBG1z96G6HK0q9SQi/10iM1T/ImwaU29TZLHqp4
X-Google-Smtp-Source: AGHT+IGzcrYFKidH1EDzisryWm6XZ+8Ko0R6VvFGuKexkHpSjrgHig/lagCg//uz8I0Wd+jWLh3dEQ==
X-Received: by 2002:a17:906:6c93:b0:a37:2f67:e78c with SMTP id s19-20020a1709066c9300b00a372f67e78cmr2179667ejr.63.1706971328231;
        Sat, 03 Feb 2024 06:42:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUa/GHnVagfk0PbV/AUH/iZNOy3AJYN7avKCuBexcoxEussaAx/9rOfMP+pTrEWcRhHcVJtO7lsL5A+z58jBiKJFh3r+ICrRQs8Q5KCFNKzSyUiasFErmHxdLZo1pzxrclXeJFxL2oPK6fHGcx4Dbd/AU9r5JWltuKfI7shT4xCW6lGqAdH+rM+nxc=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906671400b00a34d0a865ecsm2036163ejp.163.2024.02.03.06.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:42:07 -0800 (PST)
Date: Sat, 3 Feb 2024 15:42:05 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240203144205.GA3727@debian>
References: <20240203090530.53374-1-dima.fedrau@gmail.com>
 <1eb2034f-b1ef-474d-91f6-c562a5768bfd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb2034f-b1ef-474d-91f6-c562a5768bfd@gmail.com>

Am Sat, Feb 03, 2024 at 10:30:09AM +0100 schrieb Javier Carrasco:
> Hi Dimitri,
> 
Hi Javier,

> > +	/* Supported temperature range is from –40 to 125 degree celsius */
> Should that not be val < -40?
yes, you are right. Will fix it.
> > +	if (val < -45 || val > 125)
> > +		return -EINVAL;
> > +

Best regards,
Dimitri

