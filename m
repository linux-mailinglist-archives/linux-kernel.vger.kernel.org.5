Return-Path: <linux-kernel+bounces-63470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D85852FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E3228421B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ECF383B2;
	Tue, 13 Feb 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Paw6I42K"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7AB36AF0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825314; cv=none; b=fHtm2t6vYy0zaafOrXDHAjZuqwlOEt0onMPY66mviaf2kAuyO4raCQT2KPDWmabUNBs2lEoiEytOIR0TqWKub4xzNiUTsm6hCk4aBrhD1LyHYfrSLxXfYrXnV/caHJEmUmD/qxiLY4zd2d/sSCfqmJ560d7oXL6pxXONDHtunsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825314; c=relaxed/simple;
	bh=me7PlTw9ozJKPleKI3rxNxFXeuei4K+dzl+UwzIUsv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS3udy9v051jX5cis5K5Q29PRgdj9vWHmNcOf4a75nFRnZs1pc0DHrxDxoIvCo67p7EYUz0W4avUFZDjSFksKrxSP7hBBdYm4QDD2NCamZHak6z47U8tMnVC9C/CvP6hkfuUOqHTbcXT/FvcwIDZnz+8UvdnbigugAJQ91JrdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Paw6I42K; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da9c834646so3474252b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707825312; x=1708430112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Oi7FUHbwlw07W+wPherwGGupHdYS9/nuUZF19sf8Og=;
        b=LjmA4SkAfT/vT73spF+wMvQlok3FfEnR9jg80rbsk19IUVhnHHwH3hGJYYwKUTrhUC
         1hITDCCqjjEn+KwyRNy3NW9Gt9SKIG7xphEoBtlOcIC3IdnAzPt9lzHpV3ydFNsqqe4I
         29tTVNO88FCMWaiqHXaSMQpsvXa5COGVk6nSVamMyx/CbhS2zJ8yve+QH8eSAO2aEKZR
         dZ+ymJAdMyzVxRQVspSAcMhe5//2578YDBf6bQ3rh7hUFtTJ4XOH85G/6t/lbea2N6gm
         5mXUtnBfma+oXOnXzP18ZXFJp9RRu0G8N0zSs2iq0R1BuF1e58VUlDBjh1wF9sjRCICl
         u1hw==
X-Gm-Message-State: AOJu0YwUS/u2mGX5LuMxOo/tEfqdP6wfr9nXZvFOshiaAbDVO0alyyZ5
	dnV7rk263voaRCgaYMUnprWImF1rXL+l0+YUuOLJyWFPMIlgQe7Rrw628R5p0xQx1Q==
X-Google-Smtp-Source: AGHT+IF5bq3vn5UZ0fZwKCKqbe8cpeDTxQz1/fjA7hXMJ5c3vlsjD1ZRbk56U2dPYY8Hn9yFvxv5tg==
X-Received: by 2002:a05:6a00:1785:b0:6e0:a858:fd74 with SMTP id s5-20020a056a00178500b006e0a858fd74mr10619649pfg.11.1707825311626;
        Tue, 13 Feb 2024 03:55:11 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u5-20020a056a00124500b006e03efbcb3esm7131321pfi.73.2024.02.13.03.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:55:11 -0800 (PST)
Date: Tue, 13 Feb 2024 08:55:49 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707825309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Oi7FUHbwlw07W+wPherwGGupHdYS9/nuUZF19sf8Og=;
	b=Paw6I42Kg7sZeDrIZEQJVh2iCgk3BI14UNLyUNwbm9H/CQ5pBpJz+zR+g0csqwIRCnt3VO
	IxUxMCpe1D8KhxRGwiODn9ZQWHvGoVKrpBMrY7BB1dW9EbVhDxLtm+gNPlsWgMlemDt4Q8
	Wr3a4mlhyMoKnBhYIVF4BfzHrxCU10T5LLNor8UV60pcLVitHl7p3QjztWM0JeRjXnNAHG
	qBNi6lGA6GmkFIhJX+FOnO89cSKKNecMC+9o1/kGXRnKTMzcUkvEErE89NFAZ3LEey3bft
	Rg592Lbp5yiCMLlS6vpliRiGaCPBO2clV2IzE4Yl1rDZl57kKzUE4y16d8bUWg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dio: make dio_bus_type const
Message-ID: <oawy3xsbwthm75g32uxl7zshc4bdp7dzwcwfi7pvwwjetaz5fl@mkosszbo3lkt>
References: <20240212-bus_cleanup-dio-v2-1-3b1ba4c0547d@marliere.net>
 <2024021313-undecided-stainless-23ed@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021313-undecided-stainless-23ed@gregkh>

Hi Greg,

On 13 Feb 12:07, Greg Kroah-Hartman wrote:
> On Mon, Feb 12, 2024 at 08:41:01AM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the dio_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I didn't find anyone to take in this patch. Can you please check and if
that's the case take it through one of your trees?

Thanks for reviewing,
-	Ricardo.



