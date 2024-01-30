Return-Path: <linux-kernel+bounces-44231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C4841F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F91BB2987C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5909360B97;
	Tue, 30 Jan 2024 09:16:30 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696F57864;
	Tue, 30 Jan 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606189; cv=none; b=NUyb0jguZRq82b2Fge04q+zBYNqEVlO1bb2T6qzYEpi9aItWniCmfdJk+xMUp8JPcKzixw8GNNxl99CsDzEcJC79H0q4lm62h+w34xblc0hVB7NTujXIRUmFj7rS9h0cnp7Bexqrso2HahwLUxHGhpDMagc/6X+SSk927LcAzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606189; c=relaxed/simple;
	bh=rOTYB4EklsfZYfMHWnc0rtCZ9py8ZixyPnAzjcJFpVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfjCWWfx9iya2e0Vw7IDumybVcY/fPf64eLEX3z7kp2SRBkkmy62qvrcpDVM2auWite6XgZD5TKQTH1cFycFDVf23jF14I5WGZr1ee33qW94ipmzXtJ3cyTzE5rgUwrTTdbPd1OeyZBHABzOH6Rs8jFavCZNo8+TtoCs/Ilewto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a315f43ecc3so362337566b.0;
        Tue, 30 Jan 2024 01:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606186; x=1707210986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkAPGBSFsncR9iMdVmIGrDJoGNEAVTETra2CiW5bl7o=;
        b=OxQTHH/+HGkuH2XpxkJNzw2S0Dz6s/Avnn+yyWZYhqer9tisBimDRASwcfiR6CWEMg
         9rKDJ6MCq32CXMwnrnsSaUkgsDH/qths/aH2JWClhH1cNiafPxUxDq8HgTRU8AqdigEt
         QrFLgYpUq0KK2KjzSWl7zZQ+pKGchBe/9GjNP3briI0DE2Fjywtx2lljXEa2ZA/P73vp
         fWCElaq5J5Jc0+/HTUD+9PGykkyZQnV5ahjFxH5mMDGtn4spZ125sGbm1xqUULjcTgRL
         VS10NQ/1zulNEC8POgBvq11mQMUnJs97bpTHeaqPRM37v1sO4G92dq64H4CSj+gN8NpV
         DMDg==
X-Gm-Message-State: AOJu0Yxo3upOz/4WUlizsJYoY6mbyiuaB2cN7u1Oezi+7wyd9nhdof+Y
	goVU9ps2D8C/19e+BKFhWKL+yAHj5PQhTN+HA5nrY1sQeU/tl84dDNYbm2lUhdHOzQ==
X-Google-Smtp-Source: AGHT+IFum7ukz//olbq8wVUaZnPm9iR5RtYxCYgu+GcFoASF1egkr/nXGth3T48O9qhjuCptOyoZAg==
X-Received: by 2002:a17:906:6716:b0:a2e:998b:775 with SMTP id a22-20020a170906671600b00a2e998b0775mr5914963ejp.5.1706606185996;
        Tue, 30 Jan 2024 01:16:25 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id lr10-20020a170906fb8a00b00a3177f658afsm4888148ejb.206.2024.01.30.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:16:25 -0800 (PST)
Date: Tue, 30 Jan 2024 01:16:23 -0800
From: Breno Leitao <leitao@debian.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/8] net: netconsole: move newline trimming
 to function
Message-ID: <Zbi+Zw2o0rDfX1pj@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-4-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-4-thepacketgeek@gmail.com>

On Fri, Jan 26, 2024 at 03:13:38PM -0800, Matthew Wood wrote:
> Move newline trimming logic from `dev_name_store()` to a new function
> (trim_newline()) for shared use in netconsole.c
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
>  drivers/net/netconsole.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 085350beca87..b280d06bf152 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -230,6 +230,16 @@ static struct netconsole_target *to_target(struct config_item *item)
>  			    struct netconsole_target, group);
>  }
> 
> +/* Get rid of possible trailing newline, returning the new length */
> +static void trim_newline(char *s, size_t maxlen)
> +{
> +	size_t len;
> +
> +	len = strnlen(s, maxlen);
> +	if (s[len - 1] == '\n')
> +		s[len - 1] = '\0';
> +}

I am thinking about this one. Should we replace the first `\n` in the
file by `\0` no matter where it is? This will probably make it easier to
implement the netconsd, where we know it will be impossible to have `\n`
in the userdata.

Maybe something as:

	static inline void trim_newline(char *str)
	{
		char *pos = strchr(str, '\n');

		if (pos)
			*pos = '\0';
	}


All in all, this is a good clean up, which make the code easier to read.
Thanks!

