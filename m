Return-Path: <linux-kernel+bounces-61884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8388517D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F53FB22EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531F73C6A3;
	Mon, 12 Feb 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGXWAnLF"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC13C680;
	Mon, 12 Feb 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751207; cv=none; b=QGXdMBO0UUfVoARC0EyYK7ZL4bsFl2fOL9CbOjvwzLE0qdeGAyMUd46Ix4oHLvt6YNLO2WPsD8KqO7q4PysFr09qfs0L8DD1ytpwRqUEzTyCTv0MVhnTJWlXRZnWKawSAotjhXlJxPZqcm1ZRfjDjTRbgMftaXibOf1ga8VOIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751207; c=relaxed/simple;
	bh=N4WFKQWw9heeCsBrEKWVGFUnNjj8pOVlixpD5A0xOH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV5i/vEC0ZbTwdNk2ryD5hRK0sRwih7CzSw9Ak/NBNZKaNSW22cZibEhvmETObXibRsTw5Whabl07vox68McSKEFLazIRx3eyIQkLJqIqjv83EPQWR+U/b5u+GU9FFqz5bdlvWyJuUjZAtpWwsFTM/9DttVkbUBPQ+0ekhZ7oSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGXWAnLF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so4644108a12.0;
        Mon, 12 Feb 2024 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707751204; x=1708356004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FrdwmEdL6mMykhAGdiiKmiZHVfTLsDV0YUujKxxPGw=;
        b=eGXWAnLFK+VllxxGAo4WU3na5iWtlJzx6ZkGRdYdiCkzN4UdDfPtVXfvDHQdaybZWx
         Cw7ow0MDVyvpmHkSls2iITE8BU+97TybYOZFR97mE2toAcVM66eHAO0qVx2/Efl3hwi4
         Q8dPi2M7IIONPn0cuHCQrVj/kcZOIV0ucknvz0VRnQ+YxqWhNBsnc/W50g2hVPWgdzlN
         ra0MYgZNFnodCxuCDtbVR4orxYLUeygXMTWaW1LIqz8nBDf+rnG+dMGmIqkhF+dbCSui
         4IDYf+18vtNDcd3CZ2pTy05UVRtqJfHP9/vFvEizAeL1Cd/e2P7NRvLcZtJrAzGBxRXb
         XzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707751204; x=1708356004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FrdwmEdL6mMykhAGdiiKmiZHVfTLsDV0YUujKxxPGw=;
        b=W3fVq2t9ZbUIjE/Vs+Pb4KIVY+E3ds17m34IUivc/oLMsNJgswM4uBs29E9CbePNsE
         EWGUl1QxhS+lMgLIXUjdaXpZKrXtqpendcZlPGfPAQnOLSPAFA+UURlFqU+w0DINGL3Z
         yVPFX5iNNGjb129UoLn3NQwqsxwsK2MGt/JWdHkzY9LgXxeMxJCJvJw1gWDvAdAvggPk
         m63Gik3hyIQZG83N8cxXxuo/ojtASakiROi+EoLMfFERNksncbLpJDDUssHzjcoYPj8J
         tSnaTEBzqGS6uxrK42lbhiFuDzFrjfuEBlv2WBYfbaYsSPIMpZugfgXzAZX7VdSLO7oK
         RQOw==
X-Forwarded-Encrypted: i=1; AJvYcCVsUPMGYtiKxQPzCTUgU9vlC1r/dhaPbF+Touk78Jj2yoYsegs6687ax45wcJ/3DuhcZkCgarIgwMr+rwmKff3sUtzAeAgDr5aWbEM9YOlVm7raXDMmqoTBz9jc2cgiIRbPmmSyPizv
X-Gm-Message-State: AOJu0YyYaUIyy3gElbuBtOFAshxXTdMO4HoVeF8iATAFY1UIZ77QsMoP
	IV3XeIjGMXqbKLTBfMFbYHnp8Zq9aTCNP0fe7M17LlISW1a8RND8
X-Google-Smtp-Source: AGHT+IHYYsR50dPVJy0QKfgl1RpMK5y9Al9eh3YlTt73YouNvO+nddHHWU8g3OquMaDClsqtELVA/Q==
X-Received: by 2002:a17:906:130b:b0:a37:aad2:1cff with SMTP id w11-20020a170906130b00b00a37aad21cffmr5452147ejb.63.1707751204018;
        Mon, 12 Feb 2024 07:20:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWQ2Hrje/ggInmoh1c3lx+5h6tuH2XHkjtW0hg0qCaKpnzZtgDsyZGrlYcIFRNt56BLzrResZk9HSxUnME33Ik++vTzh1G0cxSATPzNCdQwialfkykRCTdldfRhf1/X2OEOWJQEnJKMqBwvQnW82eXO7CS7d+F0SuEXOg+KnfHLDWW+nuXK4ninIfp/m4aJmzcDXviKrtqYXvPuZqkKhdQ/EVvwBghQ5eLrQ==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906685600b00a35cd148c7esm295313ejs.212.2024.02.12.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:20:03 -0800 (PST)
Date: Mon, 12 Feb 2024 16:20:01 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240212152001.GA75720@debian>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
 <20240204144347.7f0eb822@jic23-huawei>
 <20240205070421.GA2264419@debian>
 <20240205093349.00003e10@Huawei.com>
 <20240205095323.GA2323766@debian>
 <20240210161117.1bb3dd7f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210161117.1bb3dd7f@jic23-huawei>

Am Sat, Feb 10, 2024 at 04:11:17PM +0000 schrieb Jonathan Cameron:
 
> > > > > [...]
> > > > #define HDC3020_S_T_RH_THRESH_LOW       0x6100
> > > > #define HDC3020_S_T_RH_THRESH_LOW_CLR   0x610B
> > > > #define HDC3020_S_T_RH_THRESH_HIGH_CLR  0x6116
> > > > #define HDC3020_S_T_RH_THRESH_HIGH      0x611D
> > > > 
> > > > #define HDC3020_R_T_RH_THRESH_LOW       0x6102
> > > > #define HDC3020_R_T_RH_THRESH_LOW_CLR   0x6109
> > > > #define HDC3020_R_T_RH_THRESH_HIGH_CLR  0x6114
> > > > #define HDC3020_R_T_RH_THRESH_HIGH      0x611F
> > > > 
> > > > I don't know if it's a good idea, as we would need to make sure it is
> > > > big endian in the buffer. Probably with a function that handles this.  
> > > I think this is the best plan with a
> > > put_unaligned_be16() to deal with the endianness.
> > > The compiler should be able to optimize that heavily.
> > >  
> > I think that would require some refactoring. I would add patches that
> > are fixing this. Have there been reasons for using the pairs ? I'm just
> > curious.
> 
> Not that I can think of. Maybe how they are represented on the
> dataheet?  Often people just copy that stuff without thinking
> about it (I know I've been guilty of this ;)
> 
Ok, just wanted to make sure I didn't miss anything. Yes, probably the
command table drives one into that direction.

Dimitri

