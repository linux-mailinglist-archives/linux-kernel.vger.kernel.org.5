Return-Path: <linux-kernel+bounces-18984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C174826605
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51A8B21107
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62361173A;
	Sun,  7 Jan 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ec5ptg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0611703;
	Sun,  7 Jan 2024 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5f3a5b9e09cso1778287b3.0;
        Sun, 07 Jan 2024 13:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704661676; x=1705266476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqFKwxe/g7DE0cTXEUKKeAEz7faDz+ZW7iaTXoLpK84=;
        b=W9ec5ptgPdVqAliAk2GdrVAJYbPssVEC+ImW7qtNCsFl95MoMFCVmUzxXpdjOFtjJR
         weGJa0jO07grYUDZE3QovtyH6q34nWfTSAhjZVDxnCSvv916yPs8v2nlukZF89F0sU1/
         M4IYAq0LmtyqIkBC5y3A7aSSzbRB8Oag6gjhZhrsq8clICl2/7Te/IzDyr7keQbRnn9Z
         E1/8ej/TP8Bgvooi1NkZXf3yAFz/EUpxiCHu11oLy4t58eAQijqtUyWtaZAYoAxNdd1H
         94PJkNNeSKF/xzYzqDSbYrBOZk8jR39mTVWSK6KsfEuWPw8BCC7tJQpx4F2OQ4Jt9Iuu
         O8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704661676; x=1705266476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqFKwxe/g7DE0cTXEUKKeAEz7faDz+ZW7iaTXoLpK84=;
        b=sLK7QkTVzEqH+smQrsaGkyZUdyYh1mWMu4FMIM6SRxtZvBr3qSDYL9XUZRnAj6QZwo
         2zpMuBSFddHurtJAiL3M5H1+gvPE7Ppd891qIR3SBWG+DsXkEe/h7E13uk73WnuSsmLG
         j8S2EtAjeNFKxSQA+buohoR6UYe9f0TXSnEiFtAn42QM4wVp5Z6X9nKug47mrhOB5OXn
         kHA34OGNJOehIsucaYNZi5cdWW4Ifaq9LwXLeZoevjiRRmldf1sb1UpB3WbuqcQeUosi
         t1l2JXfBCj9qHnIpQZ/H//7u3kinzRwmJGH4sv34ePtWyiu2gl9yixm+RngTZBS3G2VE
         cVtg==
X-Gm-Message-State: AOJu0Ywd8VjLX5PENliBFg++w0H/qnp5ZH2gjPj9jO4KowPKFbHmAiAl
	vJnyin0K+KBYGiG/8wzZut4=
X-Google-Smtp-Source: AGHT+IHgoO6dUdsEdmQNWRRdnNI1v5fKLRztD/ue3i/uQsJd0T1Up1P+Rg3Ai34bQ5DYYg8vrEb1Eg==
X-Received: by 2002:a81:bc4d:0:b0:5f6:e144:3396 with SMTP id b13-20020a81bc4d000000b005f6e1443396mr1244154ywl.4.1704661676655;
        Sun, 07 Jan 2024 13:07:56 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id x129-20020a818787000000b005ccb2d17ba7sm2588783ywf.101.2024.01.07.13.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 13:07:56 -0800 (PST)
Date: Sun, 7 Jan 2024 13:07:53 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
	=?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCHv3 net-next 2/3] ptp: add ioctl interface for
 ptp_gettimex64any()
Message-ID: <ZZsSqXLjVG16Q7EL@hoboy.vegasvil.org>
References: <20240104212439.3276458-1-maheshb@google.com>
 <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
 <CAF2d9jga9oc4OST6PMU=C9rz_NDrURCcLGx-1tP31U00z63vbA@mail.gmail.com>
 <ZZjdUlaYyHZSiwSM@hoboy.vegasvil.org>
 <CAF2d9jhnsubL-sw792ZviSXrFB826G-U8OktdEMN1NCe5zuj0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jhnsubL-sw792ZviSXrFB826G-U8OktdEMN1NCe5zuj0Q@mail.gmail.com>

On Sat, Jan 06, 2024 at 12:08:57AM -0800, Mahesh Bandewar (महेश बंडेवार) wrote:

> Having a general solution for posix timers is a nice addition.
> However, expecting a general purpose syscall to eliminate need for
> device ioctl is an unreasonable expectation.

Let me make this clear:

There is no reasonable justification for a new PTP ioctl.

The system call can and should use the the most accurate method
internally to the kernel.

Thanks,
Richard


