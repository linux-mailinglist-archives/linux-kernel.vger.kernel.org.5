Return-Path: <linux-kernel+bounces-18985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79F826608
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03141F21498
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4FB1173F;
	Sun,  7 Jan 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A35VX3Rq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394E11717;
	Sun,  7 Jan 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35d374bebe3so653805ab.1;
        Sun, 07 Jan 2024 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704662025; x=1705266825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ROm8ZhdgnvaZAIzOUEljUQj8Jiy9j8p4bOwcYNGDP80=;
        b=A35VX3RqUie08OvMzEkC+M1IuXrjLrn5UMU0YqwG90LXGtMezD4/b/GncgYh2KY4+R
         6A7NOw55uQsVgw8ZdmrhudN5Z4sKBx5KyW6aqyHll+STGh21oeS9UxdWI74cil5psOrF
         lxv7wmyNrhxcyW0b4dXDFtpgM6xySUNYTWJV3r8dcVhdrCorPQuKZIV/UEZ2E1zaC/Tz
         9ADPPpMuHE5JQ9MaGLJO3nxY9hFHE+xXCsuBdYrNwSct6D/uWfTcG4LParsJUvNAGwZE
         A1TawopeKvaJQiius44SQZykT9OKVpIc1eHLQxGXAyOoB3alhyDXFk1Z6GJyCJ7NljlB
         iZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704662025; x=1705266825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROm8ZhdgnvaZAIzOUEljUQj8Jiy9j8p4bOwcYNGDP80=;
        b=wA32A4XhtlHv0H4v8gPoi9jWqtFGyhXMfjvg4igzk5wl4OzbSsmdXccgwaS/Vjjwdx
         Wu1KQFopp+Yn2vpLjruzxTVC55sJwUMK82EZQARxvYhuFe+8Q57mq5iYVVGj6YZQsIuv
         dsYsFFhZ4ysP0RHeiySCKDK87qJpalLElw+vYiBGLibA/d0mynzcxgL1Py6qCm1BFVI5
         +8LkVGlVIBHAJVrSYAg7FvgcmNSLrKGc+tlSUbpNoKMCqOGIB2UdGwpcQEYdE2mB37di
         zAfTOa4nywthff6HRkwp1EDu6UfZIrp8E4dQaYdvWzkrspJQuqzQZXSsh59eym/QlnMu
         lFwg==
X-Gm-Message-State: AOJu0YwIpscsJ54RBUH5dbYzLi7I/2zTt/WBFPurfxu2iC/l9bBNPtEf
	NfWks5wCxDKjARxiWfsYIc8=
X-Google-Smtp-Source: AGHT+IF21MDjYIhNQdLPmFTxpaATVZGV9Y8IQG5WrfQGQEJn4TylQlOxYoMmqAaleCl1nqKkReo4Pg==
X-Received: by 2002:a92:c54c:0:b0:35f:d4dc:1b1c with SMTP id a12-20020a92c54c000000b0035fd4dc1b1cmr4900291ilj.0.1704662025330;
        Sun, 07 Jan 2024 13:13:45 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u187-20020a0dd2c4000000b005cb7fccffe2sm2614064ywd.126.2024.01.07.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 13:13:44 -0800 (PST)
Date: Sun, 7 Jan 2024 13:13:42 -0800
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
Message-ID: <ZZsUBqTBPULcSflB@hoboy.vegasvil.org>
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
> I disagree! NICs inherently benefit from bundled PTP devices due to
> their superior low-latency, low-overhead, and precise TX/RX
> timestamping capabilities. For demanding systems requiring increased
> capacity, multiple NICs from various vendors are often deployed.
> However, disciplining these diverse PTP devices across the host
> demands a flexible approach; a general purpose syscall is not an
> answer. The current PHC implementation using ioctls through exported
> ptp devices (/dev/ptpX) provides a solid foundation that is per device
> (/per NIC).
> 
> This series is providing another piece in an existing suite of methods
> used for disciplining / precision tuning (along with adjfine, adjtime,
> gettime etc.) This addition is to take that precision even further.

This reads like marketing fluff.

You fail to provide any *technical* reason why your proposed cross
time stamp method can only work with a new ioctl, and not as the back
end of a system call.

Thanks,
Richard


