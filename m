Return-Path: <linux-kernel+bounces-64530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE2853FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCE71C28358
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890463103;
	Tue, 13 Feb 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIUqnLY7"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069A62A0F;
	Tue, 13 Feb 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866442; cv=none; b=ddzJ7j0eFCszXPyYFQDCjA7B9xHJj20vcps+MliWc+S9lHogsF6x0TCBhJH2RG5tGQOYclBKbRnmaU3/FX5uQ4NL0imzyHgyCfozqhBC9UmRKhm9QJ1tR/o7cpRxOm0jPeigojnKXkk+e20eVpe9LV376wUxyREUm68qPoJSDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866442; c=relaxed/simple;
	bh=SL+DWwzMuwsZWS8ZXXZQv+kY5MSLDaLgtc/cHNlt72E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDoSAk6T07KOizbbtsOrIZ0OhenK6a1eZDWIz+YXFYIAKpe45W+YR8cEvQTw0Pcq36unsFeiTmgZwIQY8462NOUbHcoEinvGIxSnZe3r6jVAy+in5RZo9S3MiDQq9VqVczfRq6tf9VWI4YKFWtqNeGJu6Ptg577OurdToC9bylA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIUqnLY7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a9c21f9ecso26636931cf.0;
        Tue, 13 Feb 2024 15:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707866440; x=1708471240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SV0hfKeZdTCNgLhSrxnbIoDi1O8xN4jn5LbKvQw2nV4=;
        b=SIUqnLY7CjaWzl+ydKhj8ECpg8T8NitK4OGxzMeyTanmUPpAc9Aos9W8VRjUdGClTA
         WMaLBTk95qU8vI2MgnTC45h5yfBIMKF5bujnjY/NhdmO+Ofem1bvCfqR7rE67NQQY1tz
         OyitLwj9fjTy4I5eWiCn65xdmXPFVNTc3N3jx0dPAw/feK+lYiA116StRNbXHaWk/own
         cY6lg00h2B9QOrg2bx6gO3JKtp7IkKuVF4WqOhlEB7ggYMz9XfqY6Z/F2nQzx6zreBqt
         SdIk0b3zDGX54PZz0yoo2mUN9FlyoNs1YU9lCzuAhDUHc0GdWpQVPSMQV2ZGqkonmseW
         MCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866440; x=1708471240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SV0hfKeZdTCNgLhSrxnbIoDi1O8xN4jn5LbKvQw2nV4=;
        b=vE9oLYetoOWqiAmHJTM99JjV590TgaUo3py4bal6pVNFbcrPQIb0k6tzuyQPMKVYxZ
         zkZpyY5EyXk2lfkT2kbR4CFhQpnjkIzubmnNzHtgvX9USaCCQCJatPh15QKyKu2URkSp
         XY98w9/CD3nQ3zR+zBmOTzZvIqxyllwu/Y9PAEkKnEuGMXUL9Zhr3yu76xeWBancWPhW
         EUVJxuFYEeeRbZYEy8UsXpuWXuD/cxfRvZZriUgRxq3Z54eLpnoyw7rSjpxdQRqD3ONr
         Xybp1G54U4NS22h68EH+9Sp5iZfIXPuRUU7R/WEtbK+fuGBmGbZW81D/YpZN5uu6JcbR
         FTNw==
X-Forwarded-Encrypted: i=1; AJvYcCVAzFea4Bxs39n5ybsK91mxqr4I+wsRHbzBwYFT/aoODBE/AK88a7EtwQwQFuSGFBk0b4mxMOz6TNHqHK5AdWn/oqv+IVLMphBc9eG+rT8INkhJGF4LqtMgWfdMNXaot5VjqyPp
X-Gm-Message-State: AOJu0YxbgkDx56qx5q3TGlTyhb4DG8EMb1VyxWQsW8kveB1Jox3IGfAb
	AVQcXr5zwCrB2pEjRYQVr6on7mwRdK4FPEf+RR+N8MSjRJ3ysr0odIb4InFp19c=
X-Google-Smtp-Source: AGHT+IEm6WVFEgDcZFf2hs0lojrag9DkxAFfnhQjsi/DuNtZ0S4KykxnwaFIjW8qrY5jDv34lyQijg==
X-Received: by 2002:a05:622a:7:b0:42b:fac1:840f with SMTP id x7-20020a05622a000700b0042bfac1840fmr941208qtw.34.1707866439933;
        Tue, 13 Feb 2024 15:20:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPkdA5d6orib5bUCMQbjqqYBh41H4+fu3RAudv/RuPAgTcnBN5WjOPLn+qdBd4YwdYfsqEa/97QJXb40M22HtSyEZpkDQZURmQqQxwQS05138WKYeJ+vcQTeZd0KDBjv9Pd2nDoicisBP2nyxYIDqo7KG5kM9WnuGxb0D6XpfeuHk6pHOMSuDISSQRlbpRvW+sUkMToXNP8JH2ajUpdA0XA8sBqGEzRQvAh0wTdw3Plc6nXi+bMJHQxyQndPhvL007PNDwTe2hsz5Zna+tpUiwvRJOIby8R01nlv9sZCdA32pyGxmYW8SVOQ8dVEEW/lukLRLMLrWlXXHbSH4wL47u1V60ai606Uqnz2RL1fJYOKSFlrTj47GyG1AEepX0w9H/e/3ryEPJrUGwa9u6oJz1jZmOSopHid6LTygXAmoe+Lw=
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bp42-20020a05622a1baa00b0042c65d05e17sm1513620qtb.21.2024.02.13.15.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:20:39 -0800 (PST)
Message-ID: <582d0c59-e78c-4283-8b89-a09651bf4f78@gmail.com>
Date: Tue, 13 Feb 2024 15:20:37 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 05/15] net: dsa: vsc73xx: add structure
 descriptions
Content-Language: en-US
To: Pawel Dembicki <paweldembicki@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-6-paweldembicki@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213220331.239031-6-paweldembicki@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 14:03, Pawel Dembicki wrote:
> This commit adds updates to the documentation describing the structures
> used in vsc73xx. This will help prevent kdoc-related issues in the future.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


