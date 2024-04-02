Return-Path: <linux-kernel+bounces-127745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C26895058
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29B59B23C87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121D7FBC3;
	Tue,  2 Apr 2024 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tNq263To"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE577F7EC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054091; cv=none; b=YJkL9hXfgffTXu7FmejIjj0Jd7ZcyONlBaQQlcj2Cyr2Zyh5Xfzdg76uEAjp0sZnfQNI1iw8tiL4Slu/Zs9ldVwIpT+U8HZaBB5WPSKsqsBJ6qEuUkjCvZDvcXegaWJCDfniYKAoMXoveirfIziUeahlURBf/6mGcz5Q3dmLj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054091; c=relaxed/simple;
	bh=m4o/iU+AQ9jMOTYN6ooaE1NHa4LcKTSx7PoeD5OTS2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urtSJmGRpeIYg51MdZ1xRYYzWc/O4ws6Qk09E2txDfpswa3vShJDaqlLHvmm3iN+3GGCWYFEj6CN/XO3WzSPAw3hoFgglVeiGpHSXBDAf1yiHTycst/P0FNTNJYTgnFtXWzYkzF7lrODRIzqEfQOxpvv+OGTJXQmjWpaclqjmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tNq263To; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a46a7208eedso645168766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054088; x=1712658888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G16lC2YSuCH0nQG087sinHXSeTqOMb9VBJ6YVFLPItk=;
        b=tNq263Toc7VoH3byY7jMhg3jmoiGqblXgMxytf7oSVv5KEnNQFjaPeFJ/uWs71LB6L
         Hx0Kw635zRy8yJNUpcXeq4aEgfujk4sCvmOOmARsGuFvXo3xRsg01PyI6UW3kSD8T4NZ
         jGcyGmvSChiQa3HBwNr1RBbmt8SZoAAhk44LSfYpR/l7SmxD9rotpE4ScXFhMvfPG9Y8
         0Gzg2vVUGnhG3Ad9s8P1ZuvxQf9Ps2+1M5HEtX6xLwHXpkwgQm2tuvgp9/WeXY8NXVD1
         eP6beIbXA6LYrP94eUzQC7utBl6eVJs+o+vyC/t3szCppWNpO0CjbeiWM2g2iFR+SOd7
         9I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054088; x=1712658888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G16lC2YSuCH0nQG087sinHXSeTqOMb9VBJ6YVFLPItk=;
        b=fxz/1p4qA42e0BFZKdzUx4rgUBIwO9V1okGUrzYKtEJcaUT4Dfbg44l6iL1Iv3WfRC
         aWpWGnUVWVk2Mk+Yu4J617p8q6OWlEwAWjDdzZi6CFh5qZxa+nSJyMzKBi6on7VCvROY
         tFBzRICkhnHzsk2l2VkMF6zQ6tMihVbXVQTru1A/yVN0bBpcSeJjaa69z7UoihOKyE+v
         AbwJ9lMohUGynRHhpeUCLMP3Kdk/FSpLjoHfD+t15+w3j22VwRAQ9G9FbfASEAQv4mH9
         ZRiirxxIZ27WeweunZsaQhR6JPE3w6w6Bd5SqqZMsUH+7M62r3oLWOau06vUpDiwyezZ
         uXww==
X-Forwarded-Encrypted: i=1; AJvYcCVDSy89/oa7uiX7+cYKUuOGZsW6Tg+8lVjAHHkg5WQ040aCGITD2kMVQ0MDeWGO1WXlK3A838hU4npr83q1fSD/9aTeRvrozGzmBk1T
X-Gm-Message-State: AOJu0YwrGaO1DsutQk6Otc5MTqh0ZEx+lQJ7YGVTs2fVaAr4cFSZQ+zY
	4lKDBg+yXD9r7QCf9JutpB13kllKORlU/RudO6hLVvb9JTOXDT/i11wevoRcQsk=
X-Google-Smtp-Source: AGHT+IH7mjufzReUXPa1rRJkfPuCBfvZvh+cNz4FnNh9ylUnbPbSVtG647+yZI90FUnmu2wp5DzR3Q==
X-Received: by 2002:a17:906:c413:b0:a4e:904:3c7f with SMTP id u19-20020a170906c41300b00a4e09043c7fmr7047920ejz.50.1712054087537;
        Tue, 02 Apr 2024 03:34:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id an3-20020a17090656c300b00a4e7c2b2070sm1338235ejc.8.2024.04.02.03.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:34:47 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:34:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, rjui@broadcom.com,
	sbranden@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4] staging: bcm2835-audio: add terminating new line to
 Kconfig
Message-ID: <6da2518b-19bd-4ec3-889e-ecf401ba0ee3@moroto.mountain>
References: <20240330040411.3273337-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330040411.3273337-1-ppandit@redhat.com>

On Sat, Mar 30, 2024 at 09:34:11AM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add terminating new line to the Kconfig file. It helps while
> displaying file with cat(1) command.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


