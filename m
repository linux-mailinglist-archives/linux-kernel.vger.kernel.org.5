Return-Path: <linux-kernel+bounces-1130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54126814AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1460D1F238C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3BB3589F;
	Fri, 15 Dec 2023 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8pdryL7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC435882;
	Fri, 15 Dec 2023 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d346f4a043so1501645ad.0;
        Fri, 15 Dec 2023 06:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702651587; x=1703256387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJpx8lDh+zgSZj5Gc1ilBxsX86teXNLADKg4dm6Oaq8=;
        b=d8pdryL7UmwSQcJdyTKKF0h4h0DfK9utT1MoC17bv1vuJE8i5wn9AHmEeQwzlLxf7m
         mcWUo8vKhtQfSkA4+XR9Kd5VsnNcRD78ZVhRi9Dq8bdGx+6jfiHXlx1KSnrHQE8d1fEv
         RZ+0ReGpHhK/fjUCIJvx/RUCg3zbBWKcEdMWwmW+qW8/7FMvCFGQ3Ngz2gBvsSOmd+Yu
         YOt+HZRV2qH8NtByl9Af89ys7XJqgN/5dNAPJ2ikN972B6YP+22GNDHdeQAYa84uIm09
         cM+ppIbbG2cKqzuAqUltfTkEA31Z9xwl0lpG8fE8mtkxOjV0H4NsI1UF8ECrKEUAM5Kq
         k3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651587; x=1703256387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJpx8lDh+zgSZj5Gc1ilBxsX86teXNLADKg4dm6Oaq8=;
        b=AjsNPbUYssgldJ57ZvjneO8ij8OMI3CGjyM0R4rasLhdxPCogKkA6q+ACsPGfqd2oy
         aw+80NCUjl0Slp85xOjMnLhZhGI9OJfWLfZ93lfI/F3TCduyH9WD2/qELPXWJya5qOtG
         SJTYH0V7ERp3TuQ22CJ0SAqOqAT+5re9SOUUsugDLlaNs9Fls0YrqU/6VuCHqsz2pKZl
         ws3ypeT2fhyt6cUhmtd2cdmw/ixowZeAVPCalFQzLkSgb6IZCHMSl6xsRF/GVqNdhl+h
         PbHWJvrXZ9nWGfI/a0y+4+8SpKOIoctRi5Gd2Cyu4FBDiqt89Go8U0FwCW8Wk6w1P+16
         nHXg==
X-Gm-Message-State: AOJu0YwIImfvXpNZOSnsoPS2Lqe34A8FpuuLAjLb15/spDos73jiO2Rq
	uoAzu/aJrsVVFW1jGYrmUcA=
X-Google-Smtp-Source: AGHT+IHny81eaLMXZ5yyjDTCB6oMOBj6vglrdTY0sAk1mwbs3U0uy8NXK4+C8NeCNhynkXdOpdMpzw==
X-Received: by 2002:a17:903:18e:b0:1d0:a146:f85f with SMTP id z14-20020a170903018e00b001d0a146f85fmr23491918plg.2.1702651586354;
        Fri, 15 Dec 2023 06:46:26 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001d1cd7e4ad2sm14248945plf.125.2023.12.15.06.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:46:25 -0800 (PST)
Date: Fri, 15 Dec 2023 06:46:22 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Min Li <min.li.xe@renesas.com>
Cc: Min Li <lnimi@hotmail.com>, "lee@kernel.org" <lee@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <ZXxmvsqfMFIF0OWQ@hoboy.vegasvil.org>
References: <PH7PR03MB706431C1C25954AD76134FD8A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
 <ZXtLvOfS0uYxESQm@hoboy.vegasvil.org>
 <OS3PR01MB65938570774AF540C6BFD8F5BA8CA@OS3PR01MB6593.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB65938570774AF540C6BFD8F5BA8CA@OS3PR01MB6593.jpnprd01.prod.outlook.com>

On Thu, Dec 14, 2023 at 09:59:32PM +0000, Min Li wrote:

> Would it be Ok if I use the flags to differentiate extts events from extoff?

That makes sense to me.  We can return the relevant
ptp_extts_request.flags.  Something like:

#define PTP_EXTTS_FLAGS_VALID	PTP_ENABLE_FEATURE

Then you can return

	ptp_extts_event.flags = PTP_EXTTS_FLAGS_VALID | PTP_EXT_OFFSET;

Later on, other drivers can indicate PTP_[RISING|FALLING]_EDGE, if
they can tell which one happened.

>  struct ptp_extts_event {
> -       struct ptp_clock_time t; /* Time event occured. */
> +       union {
> +               struct ptp_clock_time t; /* Time event occurred. */
> +               __s64 offset_ns;         /* Offset event occurred. */

BTW, please don't make a union here.  Instead just add text to the
comment of `struct ptp_clock_time t`.

The `struct ptp_clock_time t` can be a postive or a negative value
(see comment at the top of the file), and so you can put an offset in
there as well.

Thanks,
Richard

