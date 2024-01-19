Return-Path: <linux-kernel+bounces-31179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C63832A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F4E1C2314C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE8551C36;
	Fri, 19 Jan 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUxw6+ki"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5664CE13
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670105; cv=none; b=VNoQuX3EnKRtinWZqUvAcFMeEVK0NQ6jmgSLrcM9C4WAOL05QXzVjcFao3tEhmo9jZkqQbqrYKa1PlCN/HJvr5L0qaZjEeQWf6nZOvee8f0SVmNLJCinemzq85GIUAPnNJz2J1WiJ33fmylQF9mWDqp833oc+BNg0tA7P7fxFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670105; c=relaxed/simple;
	bh=K7kOg2NiZtuBd/Ch9PPGpxtgWQazDvlPeYhXWlOidms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKIFPYtfa98zu1hSRBJoDMlD1ncfkY3sYZddRkIcxTqr2Ckn4yKhU+zKIODTG1gjCWDtQN8sdivAyuMhEKTsFytjXpOw1aOS/rq5ac2Co4mhMa1GNvvKYEagyCTjT9gVBxZWbYj7dc/uHPW9lbmxwd43RXqi+TFJwLR2twwA+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QUxw6+ki; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-337d5aa5ef6so460061f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705670102; x=1706274902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fb00m/4fXSK2elurL8+vFDfKU246XZ6cwAMjhuLk5M=;
        b=QUxw6+kiVdLJijGvTouC1ji1sNFZkW/Jz4+S2Um3YLC5qjRlrm17GqKfanWkWNhwmh
         S8uxs37UF7+riSTF/As5IqkiCNWKa/UXvXQ5QJEXfy0VGixWCGVhkva19d0iHsLPPVVr
         l5yMutHil3QDVjEG9y66UZ8yCz0h636PKVaYXTiCzG7goOCWDuo2y1QUk8pTdNl8F5A7
         mItvrF/S9/hUVrBmHL0nnXdyz8D4fs+qNVl2Ds7CALsrqxcUJviUvZMuUY8oy9D+2ycO
         Qgs+7R8x50H5H8+Yzw3gV+wI+wL4pur5jfUGjpYl19I3N7FHMtcuXpApMLbeS3b7yXpu
         8Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670102; x=1706274902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fb00m/4fXSK2elurL8+vFDfKU246XZ6cwAMjhuLk5M=;
        b=DONuldgkGPb52srsTt+uDhI4boAIvVlw0r+tGem4Jkikw6sBYMhzDmIKQgEoqzjyyr
         YXxdVauJ2AAXhI6sl6yUyCq23a4Tu57RC4LIsIT/3ohHoVhCNzwv6d8emn62faDVPNZf
         j1QBvLWw3luHEpVr3bl/JmDmgoiwgK/z/mjbfV/COEtHELlLtxuc6HtTyGhpHccToBDQ
         wLfE2VNG2Yd4218aw9nXIfwnade2fK2wuGd8aYmMaxTkT+z/vDGHdfZcYD8fmFV0IRW5
         pVPLHwKSJhVcXeJg2ZGPIDRZXavc8h2her3RBcOHQuTOpLNT9wiG0W+x/q0hKS0yK7ym
         N6Qw==
X-Gm-Message-State: AOJu0YzS/K0HsYF/SLqxtiSBiYf2nVhPaf0zqwQLdfoVSAtyCq+sWkvY
	kr4g2aj9N/nKC4NFVDPxhDLoghJc4XBqQhd0U9nQoir12yn/4DRHRZXigSglZlQ=
X-Google-Smtp-Source: AGHT+IECgnAsAQ/TbdhOd9jFSp2Z26ajBoyr6I+xGjnS5yL1Dyktn+STaFRaWg9vaz2rlfPJxWB7eA==
X-Received: by 2002:adf:fa0e:0:b0:337:d932:4980 with SMTP id m14-20020adffa0e000000b00337d9324980mr936025wrr.143.1705670101770;
        Fri, 19 Jan 2024 05:15:01 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id n7-20020adff087000000b00337bb0f370dsm6512697wro.40.2024.01.19.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 05:15:01 -0800 (PST)
Date: Fri, 19 Jan 2024 16:14:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacob Lott <jklott.git@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Message-ID: <b02e7a82-0db3-42f0-b5d9-e6d33b159192@moroto.mountain>
References: <20240118191703.89535-1-jklott.git@gmail.com>
 <ce1d6680-a7f5-4939-a47c-3079e7136c28@moroto.mountain>
 <ab907c56-5d91-482c-8308-fe06c22c7f55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab907c56-5d91-482c-8308-fe06c22c7f55@gmail.com>

On Fri, Jan 19, 2024 at 06:42:57AM -0500, Jacob Lott wrote:
> 
> For the future when talking about line wrapping I've been going based off
> VSCode's row/col count, is this not correct? For reference when writing the
> commit I would use a new line before hitting 72 "col" on each row. I ask for
> the future so I can make better commits.

I don't know anything about VSCode so I can't answer the question.
There aren't any tabs so really I can't imagine how VSCode could get the
col count wrong...  (0_0)

regards,
dan carpenter

