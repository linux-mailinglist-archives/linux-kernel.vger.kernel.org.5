Return-Path: <linux-kernel+bounces-48426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A8845BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4909328EB49
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27877A06;
	Thu,  1 Feb 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsTa/PUR"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC704626C3;
	Thu,  1 Feb 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802208; cv=none; b=F7FECmIv3aqBdzdAqcQWj5i1Ge1gNQTbRelBP5j/XKR7c7GKbbjWqq/Sd+hXkEw32Y7G0yDEKKyGYTB3VtSIN+wFqAA5VENGAWbiVLnpjPg76r/tVQcJE0+CgK50FSL+esCrRO7vZQLm9jj3ESt2IJiYtjhN/h2fqqEkOvACEd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802208; c=relaxed/simple;
	bh=j99reKCwRyXseO7+0KwcycRiHYsC+7kzPqhM+tn/SsI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wml5oZAVg/rihl62Oid34+FYuwNTxi5bVhZTD0JWBtX68k1NWsDT4TOFkDZf73/6ZgJuY3NFrQmtE16hYaR/+SKU6m19q2mNu+hub/vRuTxqWKn4Tv0gW66sVZfX/DPsZFMIu6t0250waVQlVikBHNabpevujaLNcibDsIAf6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsTa/PUR; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-686a92a8661so5982226d6.0;
        Thu, 01 Feb 2024 07:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706802206; x=1707407006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGJSIkR2dvNRRMJHxM9e8OJOgNv6ZtO/1x+1Cqwz0po=;
        b=bsTa/PUR/Vjt8qCkZsCxNAJuWj+WrC594N735O4EVYbTTlrxqbFNEB6E/v1gs0vZMN
         vALI9RWBdqh2oSNfZJ3gsxgpMnOSQdarPfXhFank0sFeJIJVZ4MOn+DSzcEsa/zopgFi
         22XdsNoOLrcBISUkrzOAgpOJ/xfMB5WJFVxvqaVskmac2IzWN85nUw6WabQiz9a72H20
         zw2fvj8Z08Y0PB3QfyG7KUgonMYaioDAuH3sUUhXAnzeS94GPAbeGFHzvkh4vFooFcYt
         BqZEnsubqkIA9mulJAcqUtVmkFD+WlSmmrYqPN2wiPdKo+AVGHccwl5aRbMSzajaYwV5
         NE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802206; x=1707407006;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGJSIkR2dvNRRMJHxM9e8OJOgNv6ZtO/1x+1Cqwz0po=;
        b=RLqZzdVMa/hV9RSWI0UqHqYlyRiRqi90jEt6vIyP5E9AawvM8j7BtBjXAevO7EgcJL
         Lrp7iBy9lBs4O4TwocilKMDxyZfDakfKORkyXkGmRXGL//ygsx8aZ3rY0iAC7ZfthqKM
         nhsMkbluoTc4n2h0F0YzKDON6Fd1dKk5KWn52T9I2lKrJwdpNhjmn279DdpiD0FjP9yY
         tuOnGvBDSuDD8bFA1kEIFdu5W5Yb5ddWcKGK62YpFYWgtHuPluoBUFynuzHmEEbBWa3H
         rz8UKfTTGGmtv2i6To/A21v+Xp1txQdlOvIOQSXV7TWnOdA+9geSt68lufDNvu4TmEgZ
         0lHw==
X-Gm-Message-State: AOJu0Yxaa/dT15IkS48Gzw31G6QTqHWzyJ+fLBTZnPV4YoTSnuJx/eGu
	5w3V08KUXj+xylUKOXxj3Alp/fVbzaUVWCfTDco20ZY4sj6NypRE
X-Google-Smtp-Source: AGHT+IGzJaJU+bUSPwjIjMdQGwyFoZWguU4RABNcHeN6pre9iCalIHrbytMdU30/1BTKsgnrY0Scaw==
X-Received: by 2002:ad4:5968:0:b0:680:f683:c7c3 with SMTP id eq8-20020ad45968000000b00680f683c7c3mr6250336qvb.26.1706802205710;
        Thu, 01 Feb 2024 07:43:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVBsfF7vDPMQjUv6D8D1TCxE6vkP/Lt0CkL78PzD5ichT2AGaHdohDRv1TFPMivvr67dM1LYuz3N8oAoGuJZOE4sG6OZhwm9rVrZrKF4Fzv9zLdhKQALuUdpJlrZwl8HlqLoqmxLgOKWxnWeEGe+l1I+NP49TEZ0zor5OGkGqwZXFz6Lzce5TBOQTLejeKMZI47R6hAkfToRRFZGJOhGgu7qYoPR8oJZtTyMtHa7arSspnRBDMAvb5CPpE1DdU=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id b27-20020a05620a119b00b00783dc450d84sm5359896qkk.12.2024.02.01.07.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:43:25 -0800 (PST)
Date: Thu, 01 Feb 2024 10:43:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65bbbc1d2e236_222699294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <1706789109-36556-1-git-send-email-wangyunjian@huawei.com>
References: <1706789109-36556-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net-next] tun: Implement ethtool's get_channels() callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> Implement the tun .get_channels functionality. This feature is necessary
> for some tools, such as libxdp, which need to retrieve the queue count.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/net/tun.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index afa5497f7c35..7cf448ff93ee 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3638,12 +3638,22 @@ static int tun_set_coalesce(struct net_device *dev,
>  	return 0;
>  }
>  
> +static void tun_get_channels(struct net_device *dev,
> +			     struct ethtool_channels *channels)
> +{
> +	struct tun_struct *tun = netdev_priv(dev);
> +
> +	channels->combined_count = tun->numqueues;
> +	channels->max_combined = MAX_TAP_QUEUES;

Conditional on IFF_MULTI_QUEUE?

> +}
> +
>  static const struct ethtool_ops tun_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
>  	.get_drvinfo	= tun_get_drvinfo,
>  	.get_msglevel	= tun_get_msglevel,
>  	.set_msglevel	= tun_set_msglevel,
>  	.get_link	= ethtool_op_get_link,
> +	.get_channels   = tun_get_channels,
>  	.get_ts_info	= ethtool_op_get_ts_info,
>  	.get_coalesce   = tun_get_coalesce,
>  	.set_coalesce   = tun_set_coalesce,
> -- 
> 2.33.0
> 



