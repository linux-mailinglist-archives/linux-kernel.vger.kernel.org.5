Return-Path: <linux-kernel+bounces-163432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3718B6ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F42728158A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118320DC5;
	Tue, 30 Apr 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8Q/ryV9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C4E17731
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459580; cv=none; b=uoF2vkbAuZHPZSkDLWXMDyUp61C52JYztA3rTSgo3TdJ9H9iGjRPadhO/5q09CFF9tsh7OHIYsj3aFWna2ko5rxcloQb7n7duHmfyKJMgd9gBVFnn15LouF5Ou26KBk1x1jvBW9vh14ppslrx8Hqypf0eZQaFxuK5m/5+5QJUgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459580; c=relaxed/simple;
	bh=eomxsH58n2Y7ul46c0ra6SHud53/uQqIv5l6KWdYkvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DykzgI5eh0p2NQ7BGyHDEYJjd7M1azS5AT3pxcNVhHJsUbOyL1RChHKuv9EJ+mGYS+LxVRSEyt9CUXeqzsE7AcS3XrqqB6DJ7od61uzsAwQgmuyAuKjYVTVy+IG2cU1sM91pDwVnEyxS77BbAyM90BevgF5Sv7/VV8byckSX6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8Q/ryV9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a556d22fa93so573525866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714459577; x=1715064377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kmtuXvfOzTJE5RofB9OsnXxtdNCBS9vMin6Fo4lqPA=;
        b=y8Q/ryV9UOWp3CoXmlCjKgkWUrLNm4HaTlgk8fKZylGOfOvjSHZ82Te8MIsvaUv2rz
         HEVpbiKhwqpLwOl02BuGaYEMxG73/FEuEmzY12li/q+zBBDPgUx2pSfgXNx8s41woCtp
         mGdTa2fFZEe7/0Ia/gySyhuJSdJiaVImFNQkA7bZ+WqO/6ExXHq0uB+UGfWTb7kZHSDJ
         kX5TnAkCmKkK535E3uRHZUnKhfOSdoStsKF0xDjfgwdGrI3CXzwW4RwzFM7CSmNnQgKM
         BrWWOCMsm4bj8QwXqUo0GKg/4AcqInyGETcOPrHnrFFgyID2GRKU+NtyNnvYLGLJmU4c
         UleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714459577; x=1715064377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kmtuXvfOzTJE5RofB9OsnXxtdNCBS9vMin6Fo4lqPA=;
        b=dJAxu6TgrEamhEXjAgzbHngc+uPHL4TjgUJOBOK9/GVDFZLnXmag5uR9DEuZ8nvG1Q
         /mFy0mt+2MZDjVDaL1hu8RvEg7kv7Mrhv+4ecfpBBrwkihwgL0+cl/tcKHgA87SWpI8O
         mOaMYPbYvKkmR2n0IcjyrCQmcPUl7az3z1CwtPtpA+YLSGANpYR8cAzmIKlZRqTizjy5
         w7GrZry0ApDZVzgwMQCBEo1ZHzQyYBJMwtDFHil5pdNIFNQJdrA8llAgJ2x4O8uD0FS4
         j4ABZAD6RzJUA2Q3aH5b80cvtycxZ6iUdvbhZ2pNkQQ6bHvQomhIg3kJ8rEz++yZ0OU9
         rq4g==
X-Forwarded-Encrypted: i=1; AJvYcCUbWm5iF7ntZzboa4gx12eOUxKh4urfNyOipczhjd9QV1l/CZiOZwxqawmeMZ50Dk+i5w1u9/Sp4jjAkdb1fVChoxxeQbC/tY9DrRoB
X-Gm-Message-State: AOJu0Yx73uykZLlrIwPHEuaEhJA6yosQe997d2mNTJb8TYOBpyUO/Dml
	30IY3eXpJj9TrfJBXYgMsgXHsn+BjyXx+ZffmLD29lgmDzoz7P/7wLDzyiRqmsU=
X-Google-Smtp-Source: AGHT+IHfEGOIlAy1q7W+H3NzXIySOqeRKPAtUJlO+eVYUEG6rVWXp/uCTWruXEVrubSQ72MD88Po3A==
X-Received: by 2002:a17:906:ddb:b0:a52:6b12:3078 with SMTP id p27-20020a1709060ddb00b00a526b123078mr1142634eji.55.1714459576234;
        Mon, 29 Apr 2024 23:46:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id la8-20020a170906ad8800b00a5931d77634sm139728ejb.34.2024.04.29.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:46:16 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:46:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <183bb17e-8f2e-47d9-b15a-e8b6bfcb7f43@moroto.mountain>
References: <20240429071501.547680-1-danishanwar@ti.com>
 <20240429183034.GG516117@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429183034.GG516117@kernel.org>

On Mon, Apr 29, 2024 at 07:30:34PM +0100, Simon Horman wrote:
> > -	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget);
> > +	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget,
> > +						  &tdown);
> >  
> >  	if (num_tx_packets >= budget)
> >  		return budget;
> >  
> > -	if (napi_complete_done(napi_tx, num_tx_packets))
> > -		enable_irq(tx_chn->irq);
> > +	if (napi_complete_done(napi_tx, num_tx_packets)) {
> > +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown)) {
> > +			hrtimer_start(&tx_chn->tx_hrtimer,
> > +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
> > +				      HRTIMER_MODE_REL_PINNED);
> > +		} else {
> > +			enable_irq(tx_chn->irq);
> > +		}
> 
> This compiles with gcc-13 and clang-18 W=1
> (although the inner {} are unnecessary).
> 

A lot of people have the rule that multi line indents get curly braces
even when they're not required.  I feel like it does help readability.

regards,
dan carpenter



