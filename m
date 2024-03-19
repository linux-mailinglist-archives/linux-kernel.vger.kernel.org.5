Return-Path: <linux-kernel+bounces-107070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE187F72A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8451C21AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8ED4597B;
	Tue, 19 Mar 2024 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Av3aHhJN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610F4EB5D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829051; cv=none; b=aGp41tBPUKpEb01lCaZPYK5ERI8M3rGV7HDET9kuwcg6z6a7roqy3qiDmYBgBkCu8ba3im9lyfhcAXu2dP3TIj3HXizmQRLhXWzfmPfsuJ1pDRARJR8XSG2h+ZIhi3h4qkoj/6ZSd0zOeLBcgL9DELxUELM7n9O5BqWjmro+ACc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829051; c=relaxed/simple;
	bh=QQLxq5dEZDeApbmB/Lkx6MXuL7gadJz/3NlJEViXU8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5ok/HDyf4KtPUffn+tUbd4U3MVVrHWa5sYzn4baeMLNce/WOPGI5z8xTIEyVhtP1N3mlQ1m5sYcx8iRk1HU4uscl+n6RRJOtg1RHs3Cyr++rU23KJHkZ74VqOaoLcVkBfTukEf83zySTCZlqm8QSFpWscWyMTn+V5p754cq2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Av3aHhJN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1784175f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710829048; x=1711433848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NxyLAPBD0uYaEFsJsCLCqoFa7u1wfvFPNUDw78rj08=;
        b=Av3aHhJNCQawdMQQai4qNPACRYGCK2p1hwW9mZlvVIkkTkME0b8+s2o/DnRI+Z4BpO
         8nreut+frpFQRQAwr0wyXCSD1y4ccYzxZfDJp+HUfXtB6IuX5Qox60+N1SR9lHwf+sul
         wJBoux7ECkxx7wvdet7DTYM/PVJU6VCg0eGmMbNUe97OEqxuEMVElnVawYswLddvqAlt
         e9w48jaDL3HKIaGdkPUMCR1evaoISDel2ZoyfDDaC4aByLaAfOpXaI5f6TAdE2iRbluQ
         U7POapYx4XPbZIifCTzCmzc4tti6H2mfjT7rU32Z29aqGzNLcw2ed5LSu+DutMn99Rh5
         LyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829048; x=1711433848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NxyLAPBD0uYaEFsJsCLCqoFa7u1wfvFPNUDw78rj08=;
        b=AvoE4QHzkxinI0pPMSW0E/EB+bGtzEp9yGEm67j+wMr+JeEKDuLcvv1xjKjodOUWz4
         Mdqd6UUAdO9sTnU4dunh3lcHQsxSHe9hva9iyL2tlvJSoKLVPFYk2/VCr9wjeqYef4U1
         1pZTx3dIJphHClFTPubVyAyS6nb37GmkvZt0FK6rfM1mel4gFRr/EKsXZwSF/zdfnaay
         3QL05SDEvgoWiTn8KtLK0k2qsGcpaeKRpo4lDYI7TkzOfojmTEpAq6xas1OomkO2/6DU
         rDq9mh4rj8f1URO4O5atOC9iFH9lj8Z9kcVrJYUpDOJsejI5Do4j2SGIi4i3CF4Pwu45
         g43w==
X-Forwarded-Encrypted: i=1; AJvYcCXwTa1Xu1j9A0eD/1mfuViJc4Vjk74vLHP3xzN0Aw3arMwfhIAPe3agmHnh83q87/kI6asRF2kvAuJ+aoxmaAAkXjui4rh2glZgqkd7
X-Gm-Message-State: AOJu0YxbIHy41BNDiklKrYqAH1jNe6aCERcj4YEG9kykJWwZ4eI2SXcA
	Dr1W2Jaw5vasSm9ce4P/x/hjMJ4zvjiAwlhtky1YHUgp8f1AbBVgAIkcsTHW5kg=
X-Google-Smtp-Source: AGHT+IHxChfQOs9Mp8LF/ggHgGIqPNQKjvXFOMYn+smQajFfFmtbcaa0DsoWP2SsJGfEiulLyAko/w==
X-Received: by 2002:adf:f606:0:b0:33e:cfff:a05d with SMTP id t6-20020adff606000000b0033ecfffa05dmr1111932wrp.59.1710829047915;
        Mon, 18 Mar 2024 23:17:27 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b0033e45930f35sm11520855wru.6.2024.03.18.23.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:17:27 -0700 (PDT)
Date: Tue, 19 Mar 2024 09:17:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v6] staging: greybus: Constify gb_audio_module_type
Message-ID: <9ef61ce3-6f14-4292-9364-903bc52c250d@moroto.mountain>
References: <ZfiQsZBrHfImIJfc@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfiQsZBrHfImIJfc@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Tue, Mar 19, 2024 at 12:36:25AM +0530, Ayush Tiwari wrote:
> Constify static struct kobj_type gb_audio_module_type to prevent
> modification of data shared across many instances and to address the
> checkpatch warning that "gb_audio_module_type" should be const. The
> "gb_audio_module_type" struct is only used in one place:
> err = kobject_init_and_add(&m->kobj, &gb_audio_module_type, NULL, ...
> so checkpatch is correct that it can be made const.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


