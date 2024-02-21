Return-Path: <linux-kernel+bounces-75691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B885ED72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E43284343
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13761350E8;
	Wed, 21 Feb 2024 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDCTFdyW"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204B12DD9C;
	Wed, 21 Feb 2024 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559455; cv=none; b=fOZk3WkQvHqPgRdn+suyaNOKV5mPWvg9MoTVVL3rUOs5kCQMgZUSTXqXDRcMsZw8b0AxhuYoBoxrilcMGACa2Naqif5ADk/enU6iP1Fg4eyXBD45cFY/HYgXalgZ5mjc5hFlWSnMvDaVOgazk095sMaeVNbWnJaIHemHz/fiA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559455; c=relaxed/simple;
	bh=+F3FwsNuYJcoRogLHWj8TN7/aBSkjTsDrn3YDdVqzlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b37lzxELEV4gGm3AmIQhyzfJLfBqDYmx1824ea6eejIEVpaW72VVw37qjuVA4m9NF+IclxMlO6oML9dedhy4EHeO+GKUMAL3htqdhSYpH/VOk0354LN81sl4rjLGAV5PRop36cxPf6qNha/AfNBKmryIFJOJwmtDB6XqqhkVnUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDCTFdyW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6861538916cso7183486d6.3;
        Wed, 21 Feb 2024 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559453; x=1709164253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wpJsXHNvgeU4dal1ulrv4/ExFJIkJaSEOuwbJ3BtDq0=;
        b=KDCTFdyWTOM3KcN45woaSZm/r0Cf35QpbzrPJHaet3dWIeoUxnaCQP56K+ec58+Dx+
         W4XjHjXQA6vZmMZUb8ptRh7kHfDJVjVT4QDRjh4q9fHQ+Ng5NXr+fxd/Hi4Pm+pDkSLn
         FkvT24xf2yrRIjlIMVETTMws7g1mYZRVSdPe85WK230GGalZBNkpxhZVSBNE+YOs5gAb
         2iznKxq/sAy0mQFpbtl7oQoXDrpSkgGMI3tXGnw2Uj0zX06m3APqzO/B0wdeDNBWq+bT
         C8pB4jup2O7HynGMY3K6jco+1CucUpwPXZ2PD4od+1gOXgyw6+NVVAKeWTWxhwz98b4T
         4TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559453; x=1709164253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpJsXHNvgeU4dal1ulrv4/ExFJIkJaSEOuwbJ3BtDq0=;
        b=Vo7o2qvbwAY8Vxc/GBAM9fmP6x0DQcbiZ1UQffpJN53A4wgq5DMkysBuFRXbD96MjB
         vakDC1NRaPLhgINo3mT0C6SJ573MymJPayZGAS1SiyjHD6VRVNnA0vb/xsgi6SKI1M74
         mYy0WF8r078x934h3Uj032QFE6R0DCuElBGSykpFEUP+M/0gBzbon8Gq+/BExjKdPFg1
         y/1OFpbWwVcnKH9rdN8FMuKXwZbE5vxeYxL1dz3jNG90GfaeAdeeBSi/ks9JCp3e0cJ6
         mcUr4XL5CWWGj7QS5AzlwoaydAumRcD/SukiJCR1oq7YsbvsF/opf4j+o26nQBdejhDg
         00aA==
X-Forwarded-Encrypted: i=1; AJvYcCXuJJQtyn7IM4yjGMjEc/3wbx/el/M6zdTcP1oA6a1yoq0kMeTNLILpj3XWvpx7EtArRvjVCCQQ/EhSwIfhqwnEal1pRxyfIbXIeG4e
X-Gm-Message-State: AOJu0Yw0zW5sNzL2VARhutyzBCStlgZkokR4kXKuaQJvT29tnw7UG666
	haSglEegzCt5ozCrKDLWUSOx9rA3qw40ECwKeuSYiN9Bm+D/FqTwM8GldTLt
X-Google-Smtp-Source: AGHT+IHIQaHZ33MBLelZ3bpytnTaDUICJ6MtwXYD6PAZ8osX4cb4angP51aQftIcJeEIVibbxXBrPg==
X-Received: by 2002:ad4:5aa7:0:b0:68f:4a94:8d45 with SMTP id u7-20020ad45aa7000000b0068f4a948d45mr16659977qvg.11.1708559452634;
        Wed, 21 Feb 2024 15:50:52 -0800 (PST)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id pf1-20020a056214498100b0068f5a02ed6dsm4906104qvb.145.2024.02.21.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:50:52 -0800 (PST)
Date: Wed, 21 Feb 2024 13:50:50 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: copy routing table more efficiently in
 rt_dst_clone
Message-ID: <psfmabpw6p3fk5jk3iuuhv4eiolmtvteiydgoxowk35jxpdslu@pcuzmfyxkm6s>
References: <xlabdyc4izitfdfpuoy2p2hi3abiq4mrrgizdqz45k7xeftbsg@ee6jgncdaqg7>
 <8afe7956-8f29-49e8-a59f-7e6b4136fa1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afe7956-8f29-49e8-a59f-7e6b4136fa1d@kernel.org>

On Tue, Feb 20, 2024 at 07:44:24PM -0700, David Ahern wrote:
Hi David,

You are correct that rtable is a container of dst_entry, and the
previous code copied not only the fields of rtable but also the fields
of dst_entry. However, the *new_rt = *rt line not only copies the fields
of rtable, but also the fields of dst_entry. 

I have demonstrated this by generating a random number and putting it in
the "expired" field of the dst_entry that is part of rt, and the printing
the random number that was generated. After the copy, I printed the
expired field of the dst_entry that is part of new_rt and the numbers
matched. This proves that not only the fields that were part of rtable
were copied but also the fields of dst_entry.

Thanks,
Oliver
> On 2/18/24 6:35 AM, Oliver Crumrine wrote:
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index 16615d107cf0..ebb17c3a0dec 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -1664,22 +1664,8 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
> >  			   rt->dst.flags);
> >  
> >  	if (new_rt) {
> > +		*new_rt = *rt;
> 
> rtable is a container of dst_entry, so this is copying those fields as well.
> 
> pw-bot: reject
> 

