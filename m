Return-Path: <linux-kernel+bounces-95188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4253874A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D71288BDE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D6C839E2;
	Thu,  7 Mar 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijDEtdOe"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7D745FE;
	Thu,  7 Mar 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802705; cv=none; b=JxJeVJ6p+y45mQ26ID8M0nV7HjmFw5GrJfFQafjCKGWnMNzji35y9DzgUEfLOgR5eNbQpz9dCeDITA917GvKiF4wVVvZylMNothljKtzgbrvWcAUoyjvPh3QVtZwcHE/T+voKImShQ98cQHOS95Tn/3o2QpK92gzLWijNVOmZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802705; c=relaxed/simple;
	bh=GqcWhzUq4Dw3rkQz7rWUm08eRDTv4UBtcaaqj6KiMiQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sqsqKWXYXsXZ5pJgYmPCxlBV0irH4/wpsq9UibAXTxQ2WpAClI9klItV8w1l74OVOQ4SfIF5D0P6jL0ib/0W8v9hLD6vI6ycPlI5kDfoL5espcAav3GOpG2gjHI/yBd8um/iviwZmOG09JbGRW7CycPu97PAosYaJYOngINs4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijDEtdOe; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7810827e54eso47896785a.2;
        Thu, 07 Mar 2024 01:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709802702; x=1710407502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWbZC5CZoCpm0ayz+A9GPh5eqXUdsbwM1bBGofTxuiw=;
        b=ijDEtdOeJF2mmC+3wKaq3Kj5U37/YKhRvWWDbcikNl4JavZPTksssRBL8UGvUGryFO
         5+QSxwSqzbH3Dzx8cFqBQ/OIJ+Q0pDxW/YeuCWSotRgkxms7L3RAz6wc2+yk77ehRZsQ
         wS0cJ/7dhelwYU41925BCWALR3ZpkrltVUJxPp93ylQp/3nxBCQR1jSZj3liNQ4DBrr8
         SOrd0Xzq15aS1Zkj/j2hWKOT3Aj7lftd+8Hxcd7CrGrr+FMXsTNLwxP1SX0yUbv76a5I
         /puagcgCRtD1aeRtpaBfhxUc0D2OTrsQcehbPgSIiWAbNvqc289XP0J7+KfC7AaaBDy0
         Jqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802702; x=1710407502;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YWbZC5CZoCpm0ayz+A9GPh5eqXUdsbwM1bBGofTxuiw=;
        b=SHOAzzqPG700XKBAnRCh780zlYA3riY2gRfdWgFpEeVaNanfdf4s9q2L6+/bLoDYO+
         pfAij1PQt3nhR60jn5tepUw+i8NBjnnjP2c+wtCWt5HoYYyPrpckI7kRxC0HulMgeGKQ
         JQz/x6QSIZD/5Dr3ETv4/42t/L+JIgq2rlW8IcZscnK3AT+tU5PXw7840JVNgAx7Kh8G
         IvC6YrMlrHPKuLe/ra9sA6Hj3fkf+oi1+i7YZd53GYD/F1riiC4sO8BZq3FblWjM6hOv
         5XUw0KCnizDUpWsyRBGS4fRpEh5HBjnnPxpY6079RGVMyog1FoQLWXAXA2DAhHmbmz/5
         baEw==
X-Forwarded-Encrypted: i=1; AJvYcCXam/vcvQhrvaM50IMoAwUOyqw+rXr0mscieX5tWXAqxdSUrChFrcTH0zfvYLIt1SXrbv2ZY/5VAYouH0/oLd2Xr13Wydk/DtRPKCa43lYnVN9F0gEd3YF6ouZb+SGHI/1SZsJH
X-Gm-Message-State: AOJu0YxanWwbsDm1Oym9h4RNGyLqXQBsEDQm7g1OBzSWN6vXahq7f933
	MmuLuOoCXzaxleMmGjMOR5xw7o5qJVnZVSzAZMl8D2aIfNgdanj1
X-Google-Smtp-Source: AGHT+IFJQSCJDprsiO3pn3kn1HCcHKfOqzyDpFhlHBGAdRG6WX/Fqb7qCbE/gAVTJNahphESYsTMQg==
X-Received: by 2002:a05:620a:198c:b0:788:49fc:d74c with SMTP id bm12-20020a05620a198c00b0078849fcd74cmr445453qkb.44.1709802702677;
        Thu, 07 Mar 2024 01:11:42 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id u10-20020ae9c00a000000b00788292846besm4044188qkk.89.2024.03.07.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:11:42 -0800 (PST)
Date: Thu, 07 Mar 2024 04:11:42 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Message-ID: <65e984ce3175a_f5b79294a8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240306095436.1782250-1-Ilia.Gavrilov@infotecs.ru>
References: <20240306095436.1782250-1-Ilia.Gavrilov@infotecs.ru>
Subject: Re: [PATCH net-next] udp: fix incorrect parameter validation in the
 udp_lib_getsockopt() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gavrilov Ilia wrote:
> The 'len' variable can't be negative because all 'min_t' parameters
> cast to unsigned int, and then the minimum one is chosen.
> 
> To fix it, move the if statement higher.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

Reviewed-by: Willem de Bruijn <willemb@google.com>

