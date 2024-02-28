Return-Path: <linux-kernel+bounces-85203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9586B238
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF06B27EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E35A15D5A1;
	Wed, 28 Feb 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jspN0fJa"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2A2D022;
	Wed, 28 Feb 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131470; cv=none; b=dTEzg30hsyU+uLOsPKiN+I7CRFIGZqDOfuP5AGJJLHQjJSD8xGIIQJB1rxTTxj+IvUpefZL4BC11tMuI1Pm5v/2iBJn+31KSe2Pg0N7xQ8ToANoFAWtw/UAzD9PmspeBpnBDAASUAWoFbRmwemFd0F4kIz2ImA9bql7Bgf4tQyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131470; c=relaxed/simple;
	bh=olE0FXhZOWfdzamPPzy8N6YHJoFdSGjzOj/E3EkKrpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyBwQ9ymEh7+Ftc8j/BEg38uZj//R6Nueud5Cujx9eDbPz6m3EeZQTwNuagmItyKwdksyG6XGiql4CcbF2fzVEg2a3x6hdPZNM5/qaCngn44PO1YF6t1TbuNfAGTyxMe2VE4JybQgtjlBRNYI+t+0bpUvvG/8KSBBuZGdU+rESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jspN0fJa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513143d3c42so1943303e87.3;
        Wed, 28 Feb 2024 06:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709131466; x=1709736266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCvg3ZSTY6UsMQEo9IKBvhUq62IW9v9TIocZdUsb004=;
        b=jspN0fJaFHko6vhampWHUyfO/aZ7gmsdsgwZwi9Q194gz8MS0wLJs5Vfknhq28gVNX
         +/OEC445jKp/cTzlRTHyWSml9Gf1z67Qa2eM+//Z/HklPd/rDkAHYoV8yr8qkCk36j4J
         WiKXKn1zBz+GiTHRYUKRJjB3gJQo45sCJWoH7OxbmAbrKwIBPTeGq6a5PpJCTzTd1t87
         VyOxGbOBHIcM/gmt7RfE1Ygl8aeq37TJgqZEqC226PbBUAssYWSvTxJSrqEHejMnw9Gc
         ZtLZKzxfrNW5l8sHWaqKRGQlQgey5VavtuJeoIawV0nzR70GXljbiS0dynqhHWePIs3B
         MldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131466; x=1709736266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCvg3ZSTY6UsMQEo9IKBvhUq62IW9v9TIocZdUsb004=;
        b=aheYs636pF1BIzW1GjMJHfzNcONdPKp63zcAe1BLJSNROCiP3a/XLnoUcp3b7jVRFS
         bDUpY3u601j2O92U8rVsLRzJd7i+RDVHEWOcgDdMrWZ9xuDxAnnDy2As7W7m5DHPO7eK
         EknZuYBCKryyuECQUBZsgH+cTZYCkc8rBxkOPrUxyV/Lpz5xgcqHxba5HhVX8FSaB35e
         nrmtSShWsZaTztGX04VDSwo8IljhJwU3mcaBsHfu1FWuLnrzFezRVt2iGsA3SXPyoTKA
         9owpTrafIinNlJP4GvYFVyNK3adXdeKh1NCnX2aodllw8HLgYZ8h+N58D2wnT6ibqzaw
         jcbA==
X-Forwarded-Encrypted: i=1; AJvYcCW4X8u96kyqgOnrt+bNHGWM9R/dE51uS4HaRAXjhkXMSSRiT67Lmo3/wbGGfccR6gjm2MQemnAYiqmY/OeJNAeatO9Qnxg2KlFOVyozbbvJk0FPEIc5pasbMImGfqsu9imXgSlq
X-Gm-Message-State: AOJu0Yy9OlOIbB1UTdVhCyG6Z06NCMZqCxMff7DjFDCUmSnoOoR/qnTs
	f2b7kv62zlYtkTB1ulnXANXK6O0+NkucfSC1IB4l1GeqYe90YHlVx+iNp0vXq60S+0l+EsPmblP
	9LnUIsKtqdbrTqqhEUNGHcV8cmjVOJWCm2W64KQ==
X-Google-Smtp-Source: AGHT+IG0+IcV8CfoxgJhKFcckn/p8vyqYDPe0ejLrcwThdxuFI5XnAzkm7y7FvlQxPYCDCBRN3hFRW0S4/rjCjKAdtM=
X-Received: by 2002:ac2:490c:0:b0:513:19f7:951b with SMTP id
 n12-20020ac2490c000000b0051319f7951bmr1505831lfi.56.1709131466363; Wed, 28
 Feb 2024 06:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228140413.1862310-1-arnd@kernel.org>
In-Reply-To: <20240228140413.1862310-1-arnd@kernel.org>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 28 Feb 2024 09:44:12 -0500
Message-ID: <CAA93jw50D5Kqi4=ze4qn1TUswWtmEao9=FBtH=4W_g9CnBf=AA@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw-qos: fix non-bql configs
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, 
	Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@kernel.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

but why do you want to disable BQL?

On Wed, Feb 28, 2024 at 9:04=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> It is now possible to disable BQL, but that causes cpsw to break:
>
> drivers/net/ethernet/ti/am65-cpsw-nuss.c:297:28: error: no member named '=
dql' in 'struct netdev_queue'
>   297 |                    dql_avail(&netif_txq->dql),
>
> Add an #ifdef check for CONFIG_BQL around this usage.
>
> Fixes: ea7f3cfaa588 ("net: bql: allow the config to be disabled")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ether=
net/ti/am65-cpsw-nuss.c
> index 9d2f4ac783e4..3a3ec9959ee2 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -294,7 +294,11 @@ static void am65_cpsw_nuss_ndo_host_tx_timeout(struc=
t net_device *ndev,
>                    txqueue,
>                    netif_tx_queue_stopped(netif_txq),
>                    jiffies_to_msecs(jiffies - trans_start),
> +#ifdef CONFIG_BQL
>                    dql_avail(&netif_txq->dql),
> +#else
> +                  0,
> +#endif
>                    k3_cppi_desc_pool_avail(tx_chn->desc_pool));
>
>         if (netif_tx_queue_stopped(netif_txq)) {
> --
> 2.39.2
>
>


--=20
https://blog.cerowrt.org/post/2024_predictions/
Dave T=C3=A4ht CSO, LibreQos

