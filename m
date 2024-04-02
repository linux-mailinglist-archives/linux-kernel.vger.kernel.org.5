Return-Path: <linux-kernel+bounces-128142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A28956CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B748A1C2101F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35A12BF1E;
	Tue,  2 Apr 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdFkxbrP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9017F3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068420; cv=none; b=PsU9N7q/EGawMF0aB+WFBcv3t92NFfp67MFdosbntMhja4ToNayLGd6Ipik7nLsYkvkwSb71mUzB71aozrjDE7c24sEAJwwA2/AqlHD0wrmn074ab8o3ERQ0D/kZ9eTGjlv108tbC1ZdSm+pMIzgTm6bOp2dUigNvgF6cZPQSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068420; c=relaxed/simple;
	bh=oIHcHtCcJzlyJQcJrHtXW0CBmC7tGAmmWrN5W6N5pPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qozUD5coj9jNz11EmAonCoGQXE3QDiURGZHw0P7wf9lphfq+/NLjd75y3w9kDaEfKfGn427gbgikx2xp0K102fWhnclen/R58XayO9u+hgLqMy6yXBJIyFCagiC3mlOmEmCiATQyNqBuWaLL3+/9mdykx+lc5sF8tggDrK5f9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdFkxbrP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso6537236a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068417; x=1712673217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARhiFa8cXm2euR/OWBzSXg/MLgRZy4E9E8eMYc7vND0=;
        b=zdFkxbrPPnMzP2QEGFpZKdjciTlYKxMzOyotCol507ylAVlAQ+ko+jQJWXs/k6DmK6
         UxazpAA8s2SavLFY/6J1Pns7V+CXA4ZmuU5yfSW3r9D1x49w8DHzibjH3K0xpoOB0yDu
         FiWCwtL3XmhGn1GDhw3CCYc51UbNB9sPNDd/sRzosp/YjbUxtBIutAU8OJ5I1rikGlY2
         xrYXSaPZekRLs3s5zwyjoGGjtSuMeklO9PRGzSrBiJWaxKnzo3MRmtDHFQp0MUGpNb7L
         GieGZ/7es7G2qNMJ0BOohUYEJlQyOnKJ435d/sm8pNc7a+oYCsFiOYY2abERVKDzK2tM
         /Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068417; x=1712673217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARhiFa8cXm2euR/OWBzSXg/MLgRZy4E9E8eMYc7vND0=;
        b=uH0leldUY056QqaF5tsuQsu3zdmKb+Wo5K++0itiuiexZFKIIvLFdDJ3ZS5SBRwqR3
         TR1u03BRXkYdUNvdrVxevf0CYC6+FdnFGtgxu+v1gQPf/RhPJ7Vn9aV3NFtCyyDBX1t4
         4PRaTpOFySjsEEz/RuPmXIwDOwoJW16qBEpfc6IvxPFgvsF7hO2MeqGujp6hXC1ObgaU
         IvqCJqm5WMYUHIBABcrhOQQJ/f96ABjDuojCRyJmeRc1I1GMnFNENHb5fwC9akBEAGum
         PQC8W1Nie61iI53ZRqtAuz2r05TOwe6kZHbyJMe8jl7cgIAHNssC/KMv2BguOH6IHEL8
         PdBA==
X-Forwarded-Encrypted: i=1; AJvYcCUNXbNWINHA8mHcJak7NAtKW5G7Pk00NLpWrnTrOXxu1U9QAmBly9UjXapxC8m9RE/S2aG8/q1CyLhlzXo7yKWoOJu0VyWscXVwaJJz
X-Gm-Message-State: AOJu0YzOJdodArumqELvnfvIgSRYtipaEWtiwbG53A6AgN7JTVebNzsS
	D2Z10wUHyJsiLeVv035P2hoeYvhLUXyZM8qPGMJSmcfbD2QJhb4KbMy1Hwsf2K8=
X-Google-Smtp-Source: AGHT+IF+kBnlkYlTUwqenWVP/NlTCcISBfePN1t1q6TMGUJAsBQ+nKkznOYJVL9t0UqAIzCZI5ipQw==
X-Received: by 2002:a17:907:2d91:b0:a4e:8003:30ba with SMTP id gt17-20020a1709072d9100b00a4e800330bamr2559616ejc.15.1712068416962;
        Tue, 02 Apr 2024 07:33:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w17-20020a170906185100b00a4e9359fbe8sm308465eje.44.2024.04.02.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:33:36 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:33:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: smatch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Documentation/smatch: RST conversion and fixes
Message-ID: <cca2741a-d7d5-4da4-a158-213787d11b40@moroto.mountain>
References: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401204512.538453-1-javier.carrasco.cruz@gmail.com>

On Mon, Apr 01, 2024 at 10:45:09PM +0200, Javier Carrasco wrote:
> This series converts the existing smatch.txt to RST and adds it to the
> index, so it can be built together with the sparse documentation.
> 
> When at it, a couple of small fixes has been included.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Thanks!  Applied.  (Will push probably later this week).

regards,
dan carpenter


