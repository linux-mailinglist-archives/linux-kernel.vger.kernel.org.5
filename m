Return-Path: <linux-kernel+bounces-64338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22C853D41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E653A28E9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413246167C;
	Tue, 13 Feb 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhyj7iMu"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAC1CD14;
	Tue, 13 Feb 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860210; cv=none; b=fhOgUhPtwkmba8M0Ecnoz439QbQCxY7sYDBm5BVGgAa4PhrwEvOou2NwWBBIq0VlZWmYwgdptnZV3nQ4h3kS49Z+TB/iw1ohLYhHap8sUVUAklt6dBBENUbqPVJ1MqE232FtMyF+F6BpS5iGAcP1fkt8yLyK1vHE7PntmbqZD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860210; c=relaxed/simple;
	bh=nd+n2IqooMYwTtK4GSBRxqQK8ljwF4sk8hd9duAXu7U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcYj4aScnB0L0gsS21r3SQPzxbUke3TZmEUIvU1WoDL7jSE5o5pLFXh1Ej0dok+KpqbHDrYXZtefJGdHe7dnVJu0vQHq/4k1G5TiGhwPm/tg1mBAgR++kqQDxs955pMzTG9jtrHtfFPCs7HHAXX+RKvw5ZtlE0cUWejOZbBwfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhyj7iMu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0aabed735so62847431fa.0;
        Tue, 13 Feb 2024 13:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860207; x=1708465007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rLAWCOLrAAkedLsR0u9g4LdIF/1rQKFqHb/tWlWW+zc=;
        b=Lhyj7iMucEoZWUsE7xUpcMjlFt5J2flxyMZuTIOjeT4W8TVQwVr6h2M+Yg3Oq1TCPa
         JwXi2Gc4P9/VfFbWcrBUYLFzofcXt0aqDHq1Qf2jG1a2VqnOnK/WlbQCqPB8H7tyxulM
         YABz5cMvuOrNlZgvs1DOEi0Vmw/tFlabPsZnrYfU3bmqw0wrlm3LgaiKt3u0Uf8lmggE
         dUOz0Ko/daY0wUoJXdfv83FV/RXeBAGhli9lKNBMFi4RZxjAVYlnFfIyrbkJmW6RcdOS
         rGCkNVAUHzYJg6A9+GcvyBNigTZ8CpDMEJxUjPUp9hg9KGdbbDHpRN9ARbdy5ar1oUd5
         hM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860207; x=1708465007;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLAWCOLrAAkedLsR0u9g4LdIF/1rQKFqHb/tWlWW+zc=;
        b=LDPxbxn3nZCDBCrbOukZJNXgjPsEBmMejIyu32mmJgxdwXs+I1ZZ4foaSAsup+r4AY
         8R4U13gwuYoduCAUpqgfxO/moJEjCJ0wVK2ZRffhEjRnrgzXn6GC4L1c8cL7lL2+BTNL
         w428Gr8mJANyIrggT8vNdkgwrr3+gUcKqDPVKvenfXadabt6/fIGoaRA0X5zapRGTSOn
         RBGz0hPZV0E5mrwAkgMYjJaDFIIuuZAUvB0U7H3bN1ty5oIE8h0xJVqQ72ZyO4O28kPE
         hffeyY6VMP2fNcSDo9nz49Z7CagGqgWNIBAeysZEAquxNawttmx8k7c7bzxx1ErP3NsD
         5tEA==
X-Forwarded-Encrypted: i=1; AJvYcCUPa3ocEYvSbbM2Qznxm9Oc3qAEx3iJt1IKiD8C7dsHR4X9bqzxbD2z97Upi6dKMm6lj4G2N93vnVvGq2mrcaXyoMhaKo/LWn8s6aRl3MhNxg4Ow3GvFMej7fURQu5pup+3T+4bW6IAuroOJA==
X-Gm-Message-State: AOJu0YzqCBAFlaSNs7qV7IIyyFtU7xdEJlM7P67jS25X0VNx7g6pIrQf
	7BXVD8hODSdW2pZGYWELL9OeKqtuMTxlWjIZZCHlf4H4rsY3K/L/qof1Og6dZu0=
X-Google-Smtp-Source: AGHT+IEgQ0npxYq3Kv3ApOMUZUzsmL5bSmkug7M/j1UTJ1zlXCWYEUOVW4v8W/ST1UvZQ84ws0v2Rg==
X-Received: by 2002:ac2:4902:0:b0:511:7c0c:f94a with SMTP id n2-20020ac24902000000b005117c0cf94amr525617lfi.16.1707860206602;
        Tue, 13 Feb 2024 13:36:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdaLTGOhggHrGm3PYeN+gRZdZ6PMuXywnXIcjFcYBZoQVJ97k+s7Kgz9wD3FptIVOBsNwFz2VKmTipTK1OcQrE+VGh0vvGccL6qR7dc363h68vtaixcuoWyP0RzLEZY5zSA0xCbqy++yQ8pHCKjMruQkSzbAh3s/5vu8Zsioqo
Received: from akanner-r14. ([77.222.24.68])
        by smtp.gmail.com with ESMTPSA id b5-20020a056512024500b00511776d214fsm1420338lfo.269.2024.02.13.13.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:36:46 -0800 (PST)
Message-ID: <65cbe0ee.050a0220.1c11e.d156@mx.google.com>
X-Google-Original-Message-ID: <ZctONUUasbIeWED2@akanner-r14.>
Date: Tue, 13 Feb 2024 14:10:45 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH v1] module.h: define __symbol_get_gpl() as a regular
 __symbol_get()
References: <20240131190251.4668-1-andrew.kanner@gmail.com>
 <20240201052958.GA14943@lst.de>
 <65bb648c.190a0220.d431d.4f63@mx.google.com>
 <ZbvfYqIKKWkTWLf9@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbvfYqIKKWkTWLf9@bombadil.infradead.org>

On Thu, Feb 01, 2024 at 10:13:54AM -0800, Luis Chamberlain wrote:
> 
> While you're at it, if you want to try it, you could see if you can
> improve the situation more by looking at symbol_get() users that remain
> and seeing if you can instead fix it with proper Kconfig dependency and
> at build time. Then we can just remove it as well.
> 
>   Luis

Sorry for the late reply.

Luis, can you give more details of your idea? I re-read it once, then
came back and still don't understand.

I see that there are ~10 users for symbol_get() currently. Do you want
to stringify symbol names at build time to completely remove
symbol_get() from module.h? Correct me if I'm wrong since using of a
fuction which is not declared anywhere sounds confusing.

-- 
Andrew Kanner

