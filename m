Return-Path: <linux-kernel+bounces-69928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2C859062
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB341F216BD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CD7C0B6;
	Sat, 17 Feb 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ3YAEFM"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295032AD0E;
	Sat, 17 Feb 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182314; cv=none; b=GB0VMzreTkDam3sp+hdD1xVAB8Ar/pi2QRQdv6I2o+Y/rx0cuvQy2zlWLBlANu52Itcup3Y+MdQ8IrEzb/RqkbTyyZBNvJlNXMmULER0FjrqGkM8cFbLCLGRPmffAjAoizT8rjEEdQXJuP3qPeH3OPfrTQCEoHDbYgupLLeSr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182314; c=relaxed/simple;
	bh=wrLKcTgAlOAAwGZ84+kBEcGq3GuTcCDhZmuTgUtPPQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8K5J7GszuAzaCyi/sFrIpn68VWEzkZsAYKr9XvomCPlX/+RWB6LP5ASfXG4qbIiMi3bAokc2OgGC8ZvNMJRY9whZjXTqv8qYhWqV+y0wmQD38eLi+f/++WspK8JQ+v+OEwRjFGrEc0UAzXhzl4LtE9mybTcuTXHyNaBSRJaOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ3YAEFM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6081e7c5f17so101137b3.1;
        Sat, 17 Feb 2024 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708182312; x=1708787112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PwtaN5KguDzbZQIXi+nboWbk3Flbti9g4PuG50G1wfM=;
        b=CZ3YAEFMYowbNvA4gmXZdc5SNN9xjdVeT6llx6It6zXu6BGkdtRrRSmQ5Q7+4pmdUu
         eM1Gqk6rfCGv9K6vUU/y1Pb7SPpIYJGRQl8yoaRRKEVHPsrQbuPy91fPvuo/tXw6UI6T
         jHbblJxtXqZGUHiq6UM4vFI1WwdBVzBfEzPgIuUVGEfE0oFtNY9gys/np9VsnbnQCNBD
         tvhc7YZKydD2k3Pmk2z4Mf0MY0CbTnSgqvuH21Uy5eG0h4p6IEdHQMLNp5Dau3SQB34l
         hja6HzM+fSXT2n8GHhO9zUVIF/mv8q4wIbuFNIG59awqDteA0oc820UrMu+tXKXg66hZ
         DKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708182312; x=1708787112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwtaN5KguDzbZQIXi+nboWbk3Flbti9g4PuG50G1wfM=;
        b=bsFlmIUqbj9NGD32kV/gAl0XeIUWH9w8jCAhQVLlhG8bNFVk11KZUbtQaoNekVBeJs
         E2WhJior2WqQ8ncvR0yVRQM0+HGw5wlN0Ec01n6xRLKhSajTvxWtQybKbeTlecInQ+tM
         iZxXeGqEL6Dw9X1kfN34Ey94kKpk2CrQx3YOIZWNgd7687QTSN2GvGbAVGjbpokvRXof
         gRXpIaUER+oyaKhUvIDRqomeh16Dg585E8/SDcCNBb0Fl0zi5reFICZl5yzbVTLkHn4U
         tA28ctMEf1uefMhYyFSOtBrGI18cLjc1M+azTe4qRwSf8vyGxn8SHUXufJw7UwT2RN27
         kt+w==
X-Forwarded-Encrypted: i=1; AJvYcCWXGgyuPG35snnhH2Qx28gCGMoLBwPaETqipIggj86NNCS++RoLp+Hk6nWaiaJ9BJ/7pBCnZWwm62ZgXcQReR5dJbupFi/kAKP9P0Se7jpSWUfttUvQOAxTL9/jQolAFnCLX6iB
X-Gm-Message-State: AOJu0Yz4jQ8lv545iWmgmhRnJPMJ5UriRdqWmrK8a3Tg8vDIR3d7fqww
	mEpNMUFFrSENyCMganSWuIKtIJgfKS2RGCjK/Hr2TJ9ZteOSx8mc
X-Google-Smtp-Source: AGHT+IFXWWeoFO1ON85p+Ik0deECpkofY6dfxwOlh2+j65ePXYE8uLwTWQe8xVOQOOgoR17yzG8WSA==
X-Received: by 2002:a81:48d6:0:b0:604:a037:e0a with SMTP id v205-20020a8148d6000000b00604a0370e0amr5823960ywa.0.1708182312024;
        Sat, 17 Feb 2024 07:05:12 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id v184-20020a8148c1000000b006081ba93f1asm101752ywa.90.2024.02.17.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 07:05:11 -0800 (PST)
Date: Sat, 17 Feb 2024 07:05:07 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, sasha.neftin@intel.com,
	kurt@linutronix.de, anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [iwl-net v1 2/2] igb: Fix missing time sync events
Message-ID: <ZdDLI4o1Bll1xvH6@hoboy.vegasvil.org>
References: <20240217010455.58258-1-vinicius.gomes@intel.com>
 <20240217010455.58258-3-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217010455.58258-3-vinicius.gomes@intel.com>

On Fri, Feb 16, 2024 at 05:04:54PM -0800, Vinicius Costa Gomes wrote:
> Fix "double" clearing of interrupts, which can cause external events
> or timestamps to be missed.
> 
> The E1000_TSIRC Time Sync Interrupt Cause register can be cleared in two
> ways, by either reading it or by writing '1' into the specific cause
> bit. This is documented in section 8.16.1.

That is not what the doc says.

It says this:

    Note: Once ICR.Time_Sync is set, the internal value of this
          register should be cleared by writing 1b to *all* bits
          or cleared by a read to enable receiving an additional
          ICR.Time_Sync interrupt.

    - Intel® Ethernet Controller I210 Datasheet,
      Revision Number: 3.1, June 2017, page 469

It says *all* bits.  This implies that the interrupt sources may be
cleared individually.  Because the non-acked bits are still pending,
the level interrupt should still be active, and the "missing" event
will be handled at the next invocation of the handler.

 
> The following flow was used:
>     1. read E1000_TSIRC into 'tsicr';
>     2. handle the interrupts present into 'tsirc' and mark them in 'ack';
>     3. write 'ack' into E1000_TSICR;
> 
> As both (1) and (3) will clear the interrupt cause, if an interrupt
> happens between (1) and (3) it will be ignored, causing events to be
> missed.

Are you sure?

Does setting ICR.Time_Sync[TXTS] also clear ICR.Time_Sync[RXTS] ?

That is what you seem to be saying.

Thanks,
Richard

