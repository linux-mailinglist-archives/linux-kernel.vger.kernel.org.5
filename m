Return-Path: <linux-kernel+bounces-101128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B7587A2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713682816B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4A12E76;
	Wed, 13 Mar 2024 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS9FGUoH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8110A3B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710308839; cv=none; b=HyNJ4pUOJHIbs66Br8OkOGr/Ks0sB5KlfsMqRtfZGrzEsM1sUQD4wH/IUYuC0lfTQSpk7kZSqEg4irz9p9nAKey3c2wo/k4K5+p/U3h55n+bND8dnUQHEnHjLJrWoebakivl4ssCdktJRSQjtIQ9SQH9oD7zH4k6G64Tc7jTC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710308839; c=relaxed/simple;
	bh=XyJjIP3N3pEfS6auuifybHfrxfnQVY1JT4z5GvMYXjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbKVaI3cAtavZBVM3uMXZ1lJCjHpgRs8UyvK4Fvh2mO4/IfVH4Ib/eJ8NF5saK3A4gbBwW/SSNiGm4kE3B5ksRbNekwSeMkPDwsFMckMotXZINqmwtL1UjoqiGaOllYeud3nRDPTjRKPIN4/l8lhxhsuX8+xgNpDHasoOPmlX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iS9FGUoH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so712739a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710308836; x=1710913636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1rNabkQK5fwhzB8TbiWGYIspOvr3QURMvFrMa2kcQL4=;
        b=iS9FGUoH9q2hm0a73vPl7ZQiHDSmSnHrUiJ/6SoiX6jXG4wtG2aw46tfM54+HDOccA
         KjJYuAua7YQtRggCr05ACBgG8+VWvtVPP6DCTVpQEK3L6MwOR7Er3TSM5p4BfgiXtl++
         zcFoOoyVvFLxBvFFUltuZekkZ05nCfHpMJK5Et9xEN2taJWSig8SKY9T+TgAXwBaYdNb
         U70QdUj7q8BunC1E2NOL24ndB9F/udlBmThgQ+3I5tLZ4r3wnDuLNv1kruMHbWhZ2M4Z
         zrDHDX+QrudbUhJyRcJSemU9DhzvDyXJpiKkSs9Wn89xl0m8f8YSyqGW25BCsZebeqtB
         RiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710308836; x=1710913636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rNabkQK5fwhzB8TbiWGYIspOvr3QURMvFrMa2kcQL4=;
        b=BOHsFFZWQB3Jp/fWYhEcPsUh39HdNqV+/gJxa5LHIbG6PzozZ3jVya8DO7CnlhXhzD
         XVaDSGhER9JnTigBgRhFBpQ8HeIqCyGKTOkInvx5xU3lXGz8jAHy/fpmcJ9zY4qiEY8f
         PlFSZzUTRXV1Msg3Z8W8y5M7Rtzn/PfMpReZfZQJbJ1EoyvaJMPRmYLLphpVT/N8WMda
         j+D7Nc24W5RQk/lr0LkFDgTk0tHFwNEvE2Qa6TFDlaFVywafhQRzJvIeBCydENg5zLJB
         lzxH6OxtsOqz+sRFkLaleqz1A3AUICz7MV/51G+XfO4JAzLiq6Q+ntwyuiv1XHZ/3tBE
         cl4g==
X-Forwarded-Encrypted: i=1; AJvYcCUo/ZggJ34AoQSRA/xyVLzgbleCo/cZ34wUG1wVtosAO5OqYpPydv1BUJkIVYIYIbeDaHAtBQd2zC7lLWxiJX4vf5PDeqpNvoIGZIMp
X-Gm-Message-State: AOJu0YykPyasfXh0qnELp5mVBLjOYfwXiJWPe+oGtPsPFVAeCGXvt47F
	KYnkct/cXjpFFh4cgezU45BMtt6QlBf6/Rh6QbQZYOuOSLw4T2c1jIGKgBcdwaSU0LXwHlrGhuR
	J
X-Google-Smtp-Source: AGHT+IF8t33P00Vffm3hQwTe343HmIWz64ZgPwumplB9cLE8YNCblECEIyKCkjc9aNVqfKfuN6GZQw==
X-Received: by 2002:a50:cd95:0:b0:567:45e2:c4db with SMTP id p21-20020a50cd95000000b0056745e2c4dbmr4453144edi.39.1710308835557;
        Tue, 12 Mar 2024 22:47:15 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gy4-20020a0564025bc400b0056820311668sm4623037edb.57.2024.03.12.22.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 22:47:15 -0700 (PDT)
Date: Wed, 13 Mar 2024 08:47:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: renaming tempVal to temp_val
Message-ID: <aeb35d3c-8d4a-4b22-a620-7d61c255827d@moroto.mountain>
References: <ZfE4iDfGUyq/C9s4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfE4iDfGUyq/C9s4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Wed, Mar 13, 2024 at 10:54:24AM +0530, Ayush Tiwari wrote:
> Renaming variable tempVal to temp_val to address
> checkpath warning 'Avoid Camelcase' and to
> ensure adherence to coding style guidelines

The end of the line is at 72-75 characters.  s/Renaming/Rename/.  Put a
period on the end of the sentence.

Rename variable tempVal to temp_val to address checkpath warning 'Avoid
Camelcase' and to ensure adherence to coding style guidelines.


> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---

This will break the build.

regards,
dan carpenter


