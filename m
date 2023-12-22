Return-Path: <linux-kernel+bounces-10047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552481CF20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B074A286D87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7662E844;
	Fri, 22 Dec 2023 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ4VREqa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE92E82A;
	Fri, 22 Dec 2023 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5a0dc313058so266968a12.0;
        Fri, 22 Dec 2023 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703275700; x=1703880500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45lHNROzwnE2bBQ0q+jaGpWMOieIeItqZnhNnMC510Q=;
        b=QQ4VREqayr7yIW70hEZvfh9ncTW1o+T0mrUH/k+gjqQRASSxexU5t9cdznhprXLel7
         Kux7iOdQXrEpuDp3EFDslPkBUq23taoBSXyFo88Qh5PZllSFz6wdH9O4RpTgSqfPCmKo
         jw3lS7K7yC5wKIDztRbghFtsS2RwJYOpmMd2U96OWpkckFonr32UbKQWyuywDniAoNXM
         tDJ8NaiZa7FtWAJWoD6nc9phoJjLwVfYz55TdN6EZuOcL5ofqDfo4Eq/HlFRSJwP7yOQ
         n0oASiaqEBQWPYfYmwV1C8d3Sdjy/KIlrdZnCIsT0iJ3v+KMM3Qr9YVJUIb/abHeE7QC
         znVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703275700; x=1703880500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45lHNROzwnE2bBQ0q+jaGpWMOieIeItqZnhNnMC510Q=;
        b=o9DwuJnPzmp3JCWTcR9XKFBmMT/0DAKwPzDRyHzZ1+RKSUynHZ0M6yFUoWelBs71fl
         yL+nrMW148G1CuhohuD5NNRAo9UdOpWF1BczCjfFBc9oMZtJjqGVjrWRRygpUWIEiRtD
         JYgCZiSYEWOD96Huxtvlo0N2EXncVuzJJjgTfdfaB7jNoYgmw6YexUjPD/cF0u4xtiTr
         l+ivbhRt5m7iVp+Y2TEeUSrrqCXkoR9P9Kas7xEPFB/HduvLHhjXiKM7rbd0DEhH7srY
         xbqcyfZ3+AiyHHBeeZxAn17/YllqIzgjfq+ycsXquTSgn6q6cSqlO9YUJg8GjjxMeBAt
         3Upg==
X-Gm-Message-State: AOJu0YxZ5fybMdUKXH9OepbiH7SaG7Pm+GDfp672VO+kjZXowDJe6eRl
	wPtZMV2DlY7aR14M2yX1v5z7WcXEwVQ=
X-Google-Smtp-Source: AGHT+IHA33JdwKl+NzOdAAu4IR+YiidtLctDPaolcGRPMksEf6ESOlCwq2Ogkpu8KLVaWejfHDfiIg==
X-Received: by 2002:a05:6a20:4a23:b0:187:df59:5c43 with SMTP id fr35-20020a056a204a2300b00187df595c43mr3607810pzb.2.1703275699525;
        Fri, 22 Dec 2023 12:08:19 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id g10-20020aa79dca000000b006d90467ca78sm3921975pfq.15.2023.12.22.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 12:08:18 -0800 (PST)
Date: Fri, 22 Dec 2023 12:08:16 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Min Li <lnimi@hotmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <ZYXssHEb1EbUFNkP@hoboy.vegasvil.org>
References: <PH7PR03MB7064C20AF7AC49FFB76F8277A096A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064C20AF7AC49FFB76F8277A096A@PH7PR03MB7064.namprd03.prod.outlook.com>

On Wed, Dec 20, 2023 at 09:59:16AM -0500, Min Li wrote:

> @@ -228,7 +235,7 @@ struct ptp_pin_desc {
>  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
>  
>  struct ptp_extts_event {
> -	struct ptp_clock_time t; /* Time event occured. */
> +	struct ptp_clock_time t; /* Time event occurred. */
>  	unsigned int index;      /* Which channel produced the event. */
>  	unsigned int flags;      /* Reserved for future use. */
                                    ^^^^^^^^^^^^^^^^^^^^^^^
Please update this comment ........

Thanks,
Richard

