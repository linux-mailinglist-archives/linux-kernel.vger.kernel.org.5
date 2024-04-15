Return-Path: <linux-kernel+bounces-144557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC08A47BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C7282C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615B63D0;
	Mon, 15 Apr 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFoeqN/M"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F784C9D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713160967; cv=none; b=WCmUPQRmv8gZNykAFkkKck/3StmmImpX3jZPUv53/vI2fNRNw95/25/hjXZbnueuxvW1mayz8cdrpihvLVoqo2oXkZBXaG025JVeBOflP60CGkau5BztXuTujVUK7L1drOA0ba5TyBDJKWEVd78ttPqUtTYROSqcQM/eKNZA9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713160967; c=relaxed/simple;
	bh=9kIdkk7cASoemAnUbv7nOShQL+l/0S9YmpIl5aDhKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffhMHMDcWHgkj66C+ahcc0kHUwIxmqvf7aB/b0AtWkh1c5uyQIZTEdPaAC85t6hOUl/q3bOeUPA2iAFw5cXkxr4AFFoTbrIg//hGVl2QRj9rMf85fhdfu2xwKLWwX1TSYA/31yNs7swEmRYnSg9GJRjkFHDg+qZOWkgbUAAkSbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QFoeqN/M; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d6e23253so2908284e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713160963; x=1713765763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckDj/bgqCVkgxX+2gSDXoFFTHJGwFqjcNIY+pad7XOU=;
        b=QFoeqN/MQkfVcu9mmv16fxpEuKy6C9qLVVJIZyB/NIwx9vBItO8Kn8BOCWu2Cau5BK
         g4k6DPyMx2BllBVietw4GRqL2IjMMfE0BtDw7x1nRUpy8O68Ku1nseOJUc296OIQMPV+
         aFAwDgetAV/UxXncIgkvilbs8WR8UN/sIFlQkksSIbLUUC+FILaZixlZkCNrbiMudEYD
         lHo4GryEju1Uh438rOLSjxI8lI/xgaf8Yl1Q8kL+m4AL/yAKox+Lgx5ewCAn6iPmp/+H
         qfoaRE9qxCnbDKsUUIF6HueT9BToIVrTywAPRS2bSc+4uf0oBFlfqBRy5PUJBpTw9wsr
         7tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713160963; x=1713765763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckDj/bgqCVkgxX+2gSDXoFFTHJGwFqjcNIY+pad7XOU=;
        b=DfJp1bIqj05W16VXfuhkmGWYmVwOZhuJyZDRiupQls/C4arCOknDON65OZsFjSwiHb
         nd4f4O8T4TC9UVCnEprb58Cvu5hmxcqAFfB4SZik1SyY99AKUSBNIjCzRKi4+YlAnybR
         +8nzrT7ODDFeq+HaH0lhuutnXsgT9Et+gk3/hZ+o0hTU2nJFDkpb7jdc+/SZ9IPV/P1k
         I7QKqX7tSxfIiqn++83SfMtr+prwoc22BrR3yQPnep51pG795iHQVGHc1Egx8NFysGO6
         6o2tJTYDjQZD0dbISr13eKMgrx2jGKqTjipIBL+t+zXnq9o1HpB11sx69Go9IGhfaLR7
         eS1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwxfJasyIU+f2EGXSl7iym4voKnF2tv/BxwHwFxeqAb6m3zyJGenVDDw10++LD6TgXS7uKmJ4m2Xmqi1ndWXkVLIks1XARVUoblakF
X-Gm-Message-State: AOJu0Yxl0PVnp/ebcdmkEZtR8UXkQtosVZm/UTLUncpKJNGVDCNywW/2
	8uReA6LtoBqAV+IGcT40QusKlVHKIp/w0iP/38VqkwhQU0QbFHPg4DBI/z+XrPI=
X-Google-Smtp-Source: AGHT+IEDMXh7pPyTthpm66a/ouSkP9+4gJ9y2nLrcAgmRpWUaMeddCR+q+i01TRwJpnKFKYuh8gu+Q==
X-Received: by 2002:ac2:4ac8:0:b0:516:d1af:adc1 with SMTP id m8-20020ac24ac8000000b00516d1afadc1mr6400030lfp.9.1713160962907;
        Sun, 14 Apr 2024 23:02:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709064a4a00b00a51bf97e63esm5024500ejv.190.2024.04.14.23.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 23:02:42 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:02:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sumadhura Kalyan <opensourcecond@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] staging: vc04_services: Re-align function parameters
Message-ID: <bea0a328-a27b-46b2-8893-1943d0404a29@moroto.mountain>
References: <20240414144614.125672-1-opensourcecond@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414144614.125672-1-opensourcecond@gmail.com>

On Sun, Apr 14, 2024 at 08:16:14PM +0530, Sumadhura Kalyan wrote:
> From: sumadhura kalyan <opensourcecond@gmail.com>
        ^^^^^^^^^^^^^^^^
This will mess things up.

> 
> Checkpatch complains that:
> 
> CHECK: Lines should not end with a '('
> +typedef void (*vchiq_mmal_buffer_cb)(
> 
> Re-align the function parameters to make checkpatch happy.
> 
> Signed-off-by: Sumadhura Kalyan <opensourcecond@gmail.com>
> ---
> 
> v1 -> v2: Repharse the subject line.

Need more changelog here.

regards,
dan carpenter


