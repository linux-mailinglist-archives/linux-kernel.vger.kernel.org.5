Return-Path: <linux-kernel+bounces-145825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD58A5B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD50D1C20A26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642BE15A4B1;
	Mon, 15 Apr 2024 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIQEanwn"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF8158DDD;
	Mon, 15 Apr 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210041; cv=none; b=IewseuL4f4hOhEc6CyU6f8qC1M+iy95scE7V/q43i9pNNwHsm8jAqmVYasKXBSA/aWhCP3v6MUlBMn+RsJouFHxm6L8rxO+3ZJKDj2FjTvBuqWxthqjNWeYnrNwKspDzhTxTeKIOWHo5qpAxe1NlwDUG8Jgt8jU86fgcnh2M1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210041; c=relaxed/simple;
	bh=6Ttx8LXV+Esj2TgrBQzSuZueSQvIpovS42b8zl0f2oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKdzL+0fCf3fkpNU6a22g6X3Ge1qduG+seT5jt2wTgTpcpuxNpVwepKpvhK0YNmRK41C4g188ouWPp5dXMwnV6E+PzUx1IFiWPjQ0aSCLWVE/frkP/38zexEm20IhiZzNvtcT911obFPh4ZW97bNSzudiOZxLKBac2kS116gnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIQEanwn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3115473a12.1;
        Mon, 15 Apr 2024 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713210040; x=1713814840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nECW4dFQOyypWbzxFUAI8T3e9FduAl7Mv8A1PasfnEo=;
        b=BIQEanwnivN5ovghwTHhvUaShv//9WVs8uTpZIB6B0CtCh9MgJ25xfYnjVJt6YnPsT
         6qT7eOXFQcSu26x2t+/fVOyXQw1hG5f9fy6xc+lU6y6k4F+b7O2BV2PVXkQEVoWt5blL
         +p5HYlEYnQ1GuUEqd0E073t8ynrKTSTFu4/pNtTTIGODrmm/Pa3Q0Xta8GEPpHa5pkpy
         BydP+F0qbC7VGTNU6DiLHGy1y6UvwebPwDbI8ss9P65lHaxlNkwOFflIB8mUjlxsPy9L
         jZPHJz04255DW9ID95fdBty/VI4PQoMqpv2yOZwoFLaZjpyMJ31DrqRHOi3ZUTiVoyAk
         X0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713210040; x=1713814840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nECW4dFQOyypWbzxFUAI8T3e9FduAl7Mv8A1PasfnEo=;
        b=v4hG5REiQ2jaFZfy6c+eAOicHIRG3YDsp7KY1hIiH0nBkmOev24qQweOXNPJE0em9J
         Z/lwDwiqncyKYjbOD+j8UKi0T4mMBhIld33/pahz8gNfSDOnS68eTA3U2V0Yo+KLoqye
         WeXMGP92uACkjrtN07QrEXpRB0a+P4N4CuwiO+XIh9cp3kpMmV11h0qdMJWWZ4nIKDY/
         E2tDnnwWm3r8dNxaCVZoioXRITbonqcrdgLrEJw4UDt8uoooKw5nmeNBL5KhHwXTuEzZ
         IT1Qw0psG9hCp2sn+1/BExmzgLiKS/LA9pSdILDXdQdAzcvOv2ZGFhQ5ySRUbABVLRi+
         1Zgw==
X-Forwarded-Encrypted: i=1; AJvYcCVlXubv2AxDMU3tsCID50Y7VOny7o5zkQqt8aY6TFbR0kA2fBGgt/b4VKTKxQJdDC72LewzK31zb2WDwkcmq8i3Vwi6CluojEsgs20+pR/vfygiszLOj9SJuE/XYncyKm33XT7aUKaxVvnATygj8GfAM67H4yGmg7xOsI2qqt64aPfvJh4ubJV05Epg7rqm
X-Gm-Message-State: AOJu0YwIHEBZnT0oqAEZmcJ0tyUSqGRRqsbTH3cmWfv8+hI7pEBh1F9e
	LKxhzv2SgKbih48nZ6/8iqDi0YGBq3IFFPkeohwC2nqdVPBr4wJO
X-Google-Smtp-Source: AGHT+IHabfXmkdzNGpRUvJgw4CTICvVnL2aJzRBUWETYyo+U0ii4Iu4bvX10MY+jIFKKbTYhWmnTYA==
X-Received: by 2002:a17:90a:f2ce:b0:2a2:e183:6306 with SMTP id gt14-20020a17090af2ce00b002a2e1836306mr9727764pjb.45.1713210039626;
        Mon, 15 Apr 2024 12:40:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a588100b002a058af5e12sm9083064pji.12.2024.04.15.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:40:39 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:40:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Peter Hutterer <peter.hutterer@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nitin Joshi1 <njoshi1@lenovo.com>,
	Vishnu Sankar <vsankar@lenovo.com>
Subject: Re: [PATCH 1/4] Input: Add trackpoint doubletap and system debug
 info keycodes
Message-ID: <Zh2CtKy1NfKfojzS@google.com>
References: <mpearson-lenovo@squebb.ca>
 <20240324210817.192033-1-mpearson-lenovo@squebb.ca>
 <20240324210817.192033-2-mpearson-lenovo@squebb.ca>
 <ZhR-WPx7dgKxziMb@google.com>
 <f3342c0b-fb31-4323-aede-7fb02192cf44@redhat.com>
 <ZhW3Wbn4YSGFBgfS@google.com>
 <ZhXpZe1Gm5e4xP6r@google.com>
 <92ee5cb2-565e-413c-b968-81393a9211c4@app.fastmail.com>
 <ZhcogDESvZmUPEEf@google.com>
 <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91593303-4a6a-49c9-87a0-bb6f72f512a1@app.fastmail.com>

On Wed, Apr 10, 2024 at 10:48:10PM -0400, Mark Pearson wrote:
> 
> I have a stronger preference to keep the KEY_DOUBLECLICK - that one seems less controversial as a genuine new input event.

Please see my response to Peter's letter. I think it very much depends
on how it will be used (associated with the pointer or standalone as it
is now).

For standalone application, recalling your statement that on Win you
have this gesture invoke configuration utility I would argue for
KEY_CONFIG for it.

Thanks.

-- 
Dmitry

