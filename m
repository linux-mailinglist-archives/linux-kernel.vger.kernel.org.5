Return-Path: <linux-kernel+bounces-1216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573A814BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556CA1C22BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337293714C;
	Fri, 15 Dec 2023 15:30:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F3358B1;
	Fri, 15 Dec 2023 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6da5278c796so252498a34.2;
        Fri, 15 Dec 2023 07:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702654236; x=1703259036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ba92GFPM/tt1qfp1KdnfvaSpvE60g/HEh4qozyZtO4k=;
        b=iJ6Q7m/Oqwrty1KY8196R8jqBzBMMfvviXVodmS+Ym02kzlsKD7y3qQ0vgVijcN3ti
         f296dSTVeM9tG6qFZCc6pOtKmVdUK0Wi8QWxlWVNuksRPD9QDZNDZwJP04CjNcuzEOVO
         8GcF9eQTM8NKzz6ZQPdidVklXU0lOEEwT66NbNsuIYJQZ70TQ3ODhB3CZ9C7kQgmWlSp
         IamKYBt83t56gezzZ3iLPeTNeFkAtPtJMdO29mhpsz01zJRgfsPsjjyt19jDZMVlEbmN
         c6YHbwgJlPSaf+SRBm0THqZlp2XMCB1V47T5ob05vH/qo5yVoMPCpw00et6S3yROXmjm
         y3+g==
X-Gm-Message-State: AOJu0Yy83XmIPjGrbfpzcu7r4Wnk6sWC68q5TztQUQZFPt8ktT7531ho
	yIWR7HBQVOVu04fl7ooU4w==
X-Google-Smtp-Source: AGHT+IFQJMxgb+dIVnYYafUiq0Yc23cF6FMCvw1DlmapqifNPYZpehv2R35z2FDKiD2JJprNR6dazQ==
X-Received: by 2002:a05:6830:11ca:b0:6da:5056:39a9 with SMTP id v10-20020a05683011ca00b006da505639a9mr918586otq.68.1702654236565;
        Fri, 15 Dec 2023 07:30:36 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id er5-20020a0568303c0500b006d9d144786fsm1205846otb.79.2023.12.15.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:30:35 -0800 (PST)
Received: (nullmailer pid 4047793 invoked by uid 1000);
	Fri, 15 Dec 2023 15:30:35 -0000
Date: Fri, 15 Dec 2023 09:30:35 -0600
From: Rob Herring <robh@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Raul Rangel <rrangel@chromium.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/6] of: irq: add wake capable bit to of_irq_resource()
Message-ID: <20231215153035.GA3996646-robh@kernel.org>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.3.I29b26a7f3b80fac0a618707446a10b6cc974fdaf@changeid>
 <20231213221959.GC2115075-robh@kernel.org>
 <CANg-bXB0EAd-703oOzXsFSS72Z3bfT8La_5K=W41L+B1uMz2-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXB0EAd-703oOzXsFSS72Z3bfT8La_5K=W41L+B1uMz2-Q@mail.gmail.com>

On Thu, Dec 14, 2023 at 02:05:16PM -0700, Mark Hasemeyer wrote:
> > If a device has multiple interrupts, but none named "wakeup" you are
> > saying all the interrupts are wakeup capable. That's not right though.
> > Only the device knows which interrupts are wakeup capable. You need:
> >
> > return wakeindex >= 0 && wakeindex == index;
> 
> I was assuming logic described in the DT bindings:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
> "Also, if device is marked as a wakeup source, then all the primary
> interrupt(s) can be used as wakeup interrupt(s)."

Also not the best wording I think.

Which interrupts are primary interrupts?

If we can't determine which interrupt, then we should just leave it up 
to the device.

Rob

