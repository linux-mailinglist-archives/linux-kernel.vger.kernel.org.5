Return-Path: <linux-kernel+bounces-88781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBC86E67E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E84C1F2A77C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222FAF513;
	Fri,  1 Mar 2024 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnHPZZ4P"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562C468D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312185; cv=none; b=NRT8sPqzdE8HoTM0V6wNYUJKXwVMu+OwMyo6nkTbMrnzjmMjg7obmnN40eMuiisVE0sVcaz8VrkSG/AJXJcTprQTr0c39arGKuRfGNv4iqiAbW5qqr6R9YpA8XjDLun1Jrp1XgwJv22U5GthNHCT9JW/PY5nPBuOolkCtY0micw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312185; c=relaxed/simple;
	bh=/cFMkXs1YLuLcWkvfAIme/Dxe5G3rypX0cn7ux3WWHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuzGVdUV0b/mn+rjVp7en2U++Q597xDGYogbKEUwQIBULSVwH3m/MrmyyHbq3MnbieI0HDUIq/GoZkfRTPPK8/91eD4sYj2Xdsy4TYXHD8vD3laYlauoK1vbnPDXlvVDo9QvBzGjEHjDJQLwSzjiO9VIMM+zYJkN1K/Xs7d2kNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CnHPZZ4P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d18931a94so1296127f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312182; x=1709916982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3VqmontYstpREaYRLuFgnoF0ld9uXpBQEwscACOSmI=;
        b=CnHPZZ4P3NldBSArxCs6//bWsWyy5eLw5uTEyPHwG3nZUFdVT8yBGw4D1/Jv6jFq6R
         3W0JL2D1cPLDlSpSwNsSL1f15VWA2DXcjzHEgX258hV6J5CC2MceoAhPzEV4kzHvCQ5c
         GavLKzD8MfzVhilAdVmgq2KMZlfalDRNX4c5yAnB7jJ4Y+cNBMZ5TnOCKuXIBF0u9G2/
         r8h1rNrTgIGFc1S8Kh3IE8lV4fIvZgTxdlbhaMM02B3Y7+Tkl3noGaDYbNBMMJNqIlRh
         fkUJYhPnDNIQXZTiJjOoAPdVCFCyeldxiznoJ/LGYGpEO7dN+8amUaF8OYM0bIrztmjG
         CbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312182; x=1709916982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3VqmontYstpREaYRLuFgnoF0ld9uXpBQEwscACOSmI=;
        b=nGEQdZ0v2dtwKJW2EuxcHYkY/NXh/CwuHwtfWIR0R0Xl/1wb2qngK3wiqRgdkyiwhP
         3sVc8FNOtdyi2rd/3IZMpF6y+7ypI3bFcHizLnKc5poghdsRxXBaHcR+dWwO5XZCVieH
         qTt9QptH0PD/boXdZiM0I2YXpvRXNoPjmE5wG+WUYGyaVuVnd3rOhU2n2qnpLAFN26wL
         qu4mDHxxBdG1yBkftsTuukV+1nzlfld3WrkH+x6ZHhS5dXVnAmYyw7HgDZswBC+Rp7/D
         nKJ/6PF+GOEcTS/XCIk6C8X2zMaKID6rV51zasPqx3oPAcq51LZfnZG7t0eBC1NbewT6
         aBDw==
X-Forwarded-Encrypted: i=1; AJvYcCX7S7Z6ZqXZxAHwP6YqFs4OXdZKc/L0NOYx9aqaex3yJ3RD18NkQvWl4DXb2/YLlVB+Pv9BW1K8nsZKZ74/psYADMnqSYUKKUHbJqGl
X-Gm-Message-State: AOJu0YxbwIzEhOK4aHQufdmpnocti1BVF7dCyVlPz5G1NQcOubgl6QOG
	MjOVMtAx9UJ98tAEREGDEghuZQihZop8erRghJ6ldHjXcIkaXmJgBQR5UVJAd/E=
X-Google-Smtp-Source: AGHT+IGgN8ojolxlaeOgWQJDi81cvaJNFC52G5ZvMJnSJLlTJJuzLntA1bBA/gTcgOaSnW1MlBUEnQ==
X-Received: by 2002:adf:e9c1:0:b0:33d:3fed:39f3 with SMTP id l1-20020adfe9c1000000b0033d3fed39f3mr1816627wrn.52.1709312181785;
        Fri, 01 Mar 2024 08:56:21 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u14-20020a056000038e00b0033e10b7a1bdsm4823816wrf.32.2024.03.01.08.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:56:21 -0800 (PST)
Date: Fri, 1 Mar 2024 19:56:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] io_uring/net: remove unnecessary check
Message-ID: <da610465-d1ee-42b2-9f8d-099ed3c39e51@moroto.mountain>
References: <7f5d7887-f76e-4e68-98c2-894bfedbf292@moroto.mountain>
 <3d17a814-2300-4902-8b2c-2a73c0e9bfc4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d17a814-2300-4902-8b2c-2a73c0e9bfc4@moroto.mountain>

On Fri, Mar 01, 2024 at 06:29:52PM +0300, Dan Carpenter wrote:
> "namelen" is type size_t so it can't be negative.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Jens applied Muhammad's patch so this part isn't required any more (and
would introduce a bug if it were).

regards,
dan carpenter


