Return-Path: <linux-kernel+bounces-45466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B02C843121
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B11B22450
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB879949;
	Tue, 30 Jan 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4slPpyn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1CF7EF06;
	Tue, 30 Jan 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657098; cv=none; b=DeV9sxg0gg5l9+3sdu1A/KZ9VVvinqub648LZANQdHj8FGixMGfeOum5d3g/mN0cLzRS/RejMF7NY/le1lZM2+eIFZ0rFcda9A9yQTSWTkP8IjBoGr7WCn653uj06OW1JHgDUd9zBupm2R0+lYI7kOpEPwU6PqbL5/GrkVtQtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657098; c=relaxed/simple;
	bh=h+fiOBcSHUoUZfnJbyVjeSVHt9iH3RGtwKjNjMY5Flk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF3aRtEXWnL1Sg4z/5OYYL2nG2iPD0v/Urrlb2HzlvlRqa15nIq7Ra2P/3EvSF+zxxbEAZTibKLXaij5eTc67mKWdIBuL8+tzi2/mR9Zw9yoXuNdauypwYe2F5pb9FbhjDZQU68e3xiM8GG0CJQOa+mA00G35l2fI6pLd5Dca2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4slPpyn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71cb97937so26742845ad.3;
        Tue, 30 Jan 2024 15:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706657096; x=1707261896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PYmS+wAfBRPLW1A4cOHciujMu9QywnUJYSefvoV7DU=;
        b=V4slPpynY/Yzibvci7o9ESqUA3ug3rClggUg1+BrMNtc/tQm0cGBTYZICKLI3oA6ec
         kKhZstKwsdEsjtlzISsd0dLYZJgc1RHAqC0dAxquWkY//k73gxcMmtGZ+VlCU7ZMYE2E
         CyLviu6SwkMXSDRl6ouvIadF0aifEOQisyMZM/StTXzi6w30SZTGy0+UhaA+XCWzfbiv
         PTJx488Q42ecKDFDD/mcFqW9ofVE8pEAH4dvKjGxs2jzX4yjEzNs4CUBqNxKDAzG9pQ5
         EC+O1xA/D0ZCHlxYajxGMwSIw9/kDDIt2EVeWVKuAjKpYSO7G70m+TQ2hD8utNRa6JY+
         1qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657096; x=1707261896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PYmS+wAfBRPLW1A4cOHciujMu9QywnUJYSefvoV7DU=;
        b=A0OYEfLoQA7rr0grx+tVxT0mENNa2scPF6rO+edVrzXw0Qus4EOgqb/L5MuyQRZg21
         wZx1bCICwv6CE835RlFuZPkNjy6J8LCws6Zevq5fxYMuVK7Ujy5ui4o4YLzXAzFyTVlK
         pod81mEM7NiOtZiGr+Z76VP/o9zlWgUvk/TOfxTVovBUEuKBwpQrekbii2UdjzWBy7gO
         YgRiMr5d7aHdA1KP2+Wod1JjKvY/5KjQiT07rFwzR+wmG3q6kmXPa3LI9YEXOXmgYjlY
         Zl+INHtP/Ckxv8ERQAjRcndvDwyln2chr3PDS7ZZuMbMlqQOm39+TmD1U9uVHeUGusDQ
         v8Ag==
X-Gm-Message-State: AOJu0YwmOaa8mcQxVR14tUsqfONaA4rbcLawjXPWz9JK/UIrWwR6bkqN
	lHjuLTo9VwTjq5a34t30dbTL12cnIs4CpC1Z7kIklcCIxAdGmHExLFgDaA2J
X-Google-Smtp-Source: AGHT+IG+ase8x0aSn5hJbirv65Ls60h0K3hk876L9tuikWYYNLdWD3EJsc0bskHtGlybvVWBNt1UKg==
X-Received: by 2002:a17:902:64c8:b0:1d7:75a0:3c86 with SMTP id y8-20020a17090264c800b001d775a03c86mr64811pli.66.1706657096379;
        Tue, 30 Jan 2024 15:24:56 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:955e:133f:54ba:f642])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902a61100b001d6f8b31ddcsm7750316plq.3.2024.01.30.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:24:56 -0800 (PST)
Date: Tue, 30 Jan 2024 15:24:53 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>,
	"mark.satterthwaite@touchnetix.com" <mark.satterthwaite@touchnetix.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v6 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <ZbmFRTW4IsfYT5hc@google.com>
References: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
 <20240125165823.996910-4-kamel.bouhara@bootlin.com>
 <b466d75c-944f-4c45-80f3-993b1fe40d7a@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b466d75c-944f-4c45-80f3-993b1fe40d7a@leica-geosystems.com>

On Tue, Jan 30, 2024 at 05:32:54PM +0000, POPESCU Catalin wrote:
> On 25.01.24 17:58, Kamel Bouhara wrote:

> > +               u16 offset = (usage_id * AXIOM_U31_BYTES_PER_USAGE);
> > +               u8 id = rx_data[offset + 0];
> > +               u8 start_page = rx_data[offset + 1];
> > +               u8 num_pages = rx_data[offset + 2];
> > +               u32 max_offset = ((rx_data[offset + 3] & AXIOM_PAGE_OFFSET_MASK) + 1) * 2;
> > +
> > +               if (!num_pages)
> > +                       usage_table[id].is_report = true;
> please add an else statement to set is_report to false.

Better written as:

		usage_table[id].is_report = num_pages == 0;

or

		usage_table[id].is_report = !num_pages;

Thanks.

-- 
Dmitry

