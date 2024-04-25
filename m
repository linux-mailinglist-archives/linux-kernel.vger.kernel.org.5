Return-Path: <linux-kernel+bounces-158631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFBA8B2340
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EB61F23D76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F815149DEF;
	Thu, 25 Apr 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/YFezP/"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2C5B201;
	Thu, 25 Apr 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053414; cv=none; b=Rs6roTREsu3UT49xHQRlYj+8Zp+5zHtDqN7mMOaUj/WDU9U1Ql8afVcxcorwsxJd8Ps0f5rhy8cTkQyCLx62fmB0xu8csOgHynD/Wrsj/vf+atZ0r8cKyfs5t5du22DtoJvqFVHVk5yXUy/YV+7pPtYEUq9LLQvOpuHjX8TJmwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053414; c=relaxed/simple;
	bh=wylgrDvpmfKc/1c27fyhdHqRJd6ueA2a/2GtprMcJzI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dSj8nPt0w5As9ZpmqJm5AtUVeOeKbICp6BNdQtJ1ejEXiKwhGFJQGFJ6jtHsBTuZ7kgrybD73NNwdqJ5v1mdoHJpUtzC455lrbvlKEcphnceMo+30zUR5N0ehh87Adcv6Mj4HNrF1pobCQ+F9p8XG6Omquf4Libi8fWzqgaVyg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/YFezP/; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b5a87505cso5000526d6.2;
        Thu, 25 Apr 2024 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714053412; x=1714658212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZkTpLfnyx6tU6FqBNqPSCdKtnr0jGqDIJz99fTbxaY=;
        b=D/YFezP/Tw6YRy75dMKapGoMlZxKLLoi/V3sxQ0vBT7cemhlPJtBDbaTf/NMW+Xm0z
         L2AufIRO9RUL/HovzwpPRnmD+UUBjFlT0l6qZ/Cbsgc982yQ7yWH06E6GpHZvDmXnkHu
         j4VEVQiH91x5yRB0Ok7tX31NrzxIICzDX8R4YJ1RChE9qHRDgsoz1v4NaPCn3VTMlV0x
         4v2jUrbKAHteFmdH4Oze5cxzbN7ALktSpiuL49c7kIGrA8g/tBFJJlerhYIxYZpsA06y
         ARPaIgsilZ1MbJd0F8NH+HbmD3P/ek8CJH/4H6Ed8jsp/98ojh6qGsSuOTJ/1uj0ibsw
         9xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714053412; x=1714658212;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZkTpLfnyx6tU6FqBNqPSCdKtnr0jGqDIJz99fTbxaY=;
        b=NfUBJTOQgvWu+NtOqHt3dI67831GKadNJVcQdvld0p8oPxfDUNglx8oe9ie9OjsBjI
         X7VphPCbthPc8Ao6oPh7db+VwEvdysGkfJCcqNciW6yIM5+iZI/OBYOZQX9oQp3d/DnH
         Xe5fju/u0I5iHUtIxhMSAg4+UGzrD1t/PRtkIJZNHJSJvz+E8VuFrufr0MMVgAMYIkIb
         0HUXLRr3ZkAeDwAQEaDRWCX9+jU+l/Iy8+WfsZjRI85Fk+7e5rH6e0zDRcQ54da/LFfW
         oMakXNjp8lD7AEUFGOHFyYlwJfL8iZo4RrsIUX9aj3rsiz6JtmXXRpFpujVjYZOjaYug
         rc6A==
X-Forwarded-Encrypted: i=1; AJvYcCWpGaAbvfECzUoLUxVUik7H4BPAwqcBaH2WQqqs53UD4frwkIYIRscLHtJj1srC1bQOwi+EggS2UUSa0ZbLWLwf92OKvLGFb6B4MyYEtwJQ5aMm5w/QxzOiFjt6JxzSRchmCKa9
X-Gm-Message-State: AOJu0Yx9zQTG32ndqYLg7LF0RZhWwNE2JpfgXROBwg07NbGXivJqgMix
	biJXAGhhCecSBlI5vg9oMrs6J0H206oy20fcFQ5JwInRXFyZQlEZ
X-Google-Smtp-Source: AGHT+IE/G2O3EEzK0J1FIG9XGxASGB30fiHnk14JNb/wHA79yML+Z9Q1yw+BE7YnS6r3waJRpgGRWQ==
X-Received: by 2002:a0c:f8cb:0:b0:699:2eb9:9c09 with SMTP id h11-20020a0cf8cb000000b006992eb99c09mr5585565qvo.24.1714053411578;
        Thu, 25 Apr 2024 06:56:51 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id g2-20020a0cf082000000b0069c5d4b95d8sm6918053qvk.73.2024.04.25.06.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:56:51 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:56:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 alobakin@pm.me, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <662a6122eacff_1de39b29444@willemb.c.googlers.com.notmuch>
In-Reply-To: <b330dfad-1ba6-4172-a76b-b965221b15f6@gmail.com>
References: <20240424163045.123528-1-richardbgobert@gmail.com>
 <20240424163045.123528-2-richardbgobert@gmail.com>
 <6629bcc9486a3_1bd6b02949c@willemb.c.googlers.com.notmuch>
 <b330dfad-1ba6-4172-a76b-b965221b15f6@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: gro: fix udp bad offset in socket lookup
 by adding {inner_}network_offset to napi_gro_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> >> --- a/net/ipv6/tcpv6_offload.c
> >> +++ b/net/ipv6/tcpv6_offload.c
> >> @@ -29,7 +29,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
> >>  
> >>  INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
> >>  {
> >> -	const struct ipv6hdr *iph = ipv6_hdr(skb);
> >> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
> >> +	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
> >>  	struct tcphdr *th = tcp_hdr(skb);
> >>  
> > 
> > Only udp code is affected, as only that can be used as tunnel.
> > 
> > For bug fixes, let's try to avoid touching other code. Also that vlan.
> > 
> > As a minimal patch all that is needed is the following, right?
> > 
> > - add the fields
> > - store in inet_gro_receive + ipv6_gro_receive
> > - read in udp[46]_gro_complete and udp[46]_lib_lookup_skb
> > 
> 
> This approach is smaller, thanks for writing it down.
> 
> What do you think about doing this and still writing to
> inner_network_offset exclusively in {inet,ipv6}_gro_receive? I still
> prefer it for reasons discussed in the previous series. The code line
> in vlan_gro_receive will still be there, but that will be the only
> addition to your snippet.

That sounds fine, thanks.

