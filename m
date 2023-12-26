Return-Path: <linux-kernel+bounces-11389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0281E582
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C8A2828EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB14C3DD;
	Tue, 26 Dec 2023 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZgAswHIs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D954C3A9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231226063419epoutp02ae90289d9f10ddd2ab15d97d1358e161~kTiBGA44k2998129981epoutp02d
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 06:34:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231226063419epoutp02ae90289d9f10ddd2ab15d97d1358e161~kTiBGA44k2998129981epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703572459;
	bh=X5IgR1fuqe7/TpIeMvysCuDXwgchmipkSRN9UrNJUfI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZgAswHIsF91m4J7XB9GScDl1Du7BTMQMogrd+b/5CK6k1j6cBSTeLYrQO7Q+fYHlZ
	 7QPdBIA9BTBNZYbq6B9EJk88AywOlyPxj15X7EU2jiVrt1/++v7uexiAbG0CORF5Or
	 RYHmIZW8cP4l9vKZbaIBXl5S9EMlL4cLTVWcW3zU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231226063419epcas5p2f2899537d4f174e1ffe4d5d1c3e1ef81~kTiAmslld2204722047epcas5p2C;
	Tue, 26 Dec 2023 06:34:19 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SzlNn2R0fz4x9Px; Tue, 26 Dec
	2023 06:34:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.6F.10009.7E37A856; Tue, 26 Dec 2023 15:34:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231226062150epcas5p3b6a82342591e9f0e2dd0646badef6a68~kTXH4b3ss3115831158epcas5p3N;
	Tue, 26 Dec 2023 06:21:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231226062150epsmtrp1d2eb505e40d520c1d527c501034674ab~kTXH3uOip1593715937epsmtrp17;
	Tue, 26 Dec 2023 06:21:50 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-3f-658a73e747f4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.77.18939.EF07A856; Tue, 26 Dec 2023 15:21:50 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226062149epsmtip2422446459e8d3cce9ef4311d21b820a7~kTXGWN-L-0286502865epsmtip2R;
	Tue, 26 Dec 2023 06:21:49 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-15-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 15/15] media: s5p-mfc: drop static device variable in
 s5p_mfc_pm.c
Date: Tue, 26 Dec 2023 11:51:48 +0530
Message-ID: <15d301da37c3$cff325e0$6fd971a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAGlz7pkAtxE1qCvLzw1oA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmpu7z4q5Ug6uNKhb3F39msdj7eiu7
	xabH11gtls0Osri8aw6bRc+GrawWM87vY7JYe+Quu8WyTX+YLFoal7A6cHnsnHWX3WPxnpdM
	HptWdbJ53Lm2h81j85J6j74tqxg9/r5+xebxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMi9OmsRds62OsmLlrGmsD4/XiLkZO
	DgkBE4kzd7sYuxi5OIQEdjNKfJrYyAThfGKU2P/uKSOc83TKcmaYlmlPLzOC2EICOxklPn4U
	gLCfM0pcn5oMYrMJ6EvcP9XDCtIsInCOUWJb/xSwscwCNxkljr2ZCTaJU8BVYvOWjWwgtrBA
	hMSE2fPAbBYBVYlNFy4zgdi8ApYS9z62QtmCEidnPmEBsZkF5CW2v50DdZGCxM+ny1hBbBEB
	J4ktM/cwQ9SISxz92cMMslhC4ACHxIl1y5ggGlwkbp5bDWULS7w6voUdwpaSeNnfBmUnSzxe
	9BJqQY7E+j1TWCBse4kDV+YA2RxACzQl1u/ShwjLSkw9tY4JYi+fRO/vJ1DjeSV2zIOx1STm
	3PnBCmHLSBxevZRxAqPSLCSvzULy2iwkL8xC2LaAkWUVo2RqQXFuemqxaYFRXmo5PMqT83M3
	MYLTsJbXDsaHDz7oHWJk4mA8xCjBwawkwiur2JEqxJuSWFmVWpQfX1Sak1p8iNEUGN4TmaVE
	k/OBmSCvJN7QxNLAxMzMzMTS2MxQSZz3devcFCGB9MSS1OzU1ILUIpg+Jg5OqQYm9qr5Lo9U
	5wVsXX73TLhpz5z9DS2FTyepdOeaty3J7M2RWrt9405hEZea+JmVDc8iP9ZGv5jkz6W3PaLd
	7FItx3lPzgbjthWSjGcdVn27brVvj4rrwd6bIqsvm0pvi/k4/WDR3if8qefE1ijoWmqIv3nJ
	wG4dFrjk9uvTmytbM8Keaf9VPS59Nezv+5VfDr7fF9FvM92KLb6i8+JztVLp8MS03mmTFBmm
	1t9mmmi/e25Tvs3kWaFfXWI1XeKjWI77Ch/TY7xWmLVeyoft4XHPI3mqrhdnei1m5tp2Y9Jd
	E+HotX+/W805tla4c5vNtrPZ1/Y29/em5fVlp++uLJ5k4fLj0irl9JiVizcFP/+vxFKckWio
	xVxUnAgAcUIdP0wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvO6/gq5Ugx+/jS3uL/7MYrH39VZ2
	i02Pr7FaLJsdZHF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWbQ0LmF14PLYOesuu8fiPS+Z
	PDat6mTzuHNtD5vH5iX1Hn1bVjF6/H39is3j8ya5AI4oLpuU1JzMstQifbsEroyL06axF2zr
	Y6yYuWsaawPj9eIuRk4OCQETiWlPLzN2MXJxCAlsZ5TY9m4ZM0RCRuJ/2zF2CFtYYuW/5+wQ
	RU8ZJX7N28UCkmAT0Je4f6qHFSQhInCBUWLLngVsIA6zwH1Gia5N25kgWs4xShy+/50JpIVT
	wFVi85aNbCC2sECYxKyXF8HiLAKqEpsuXAazeQUsJe59bIWyBSVOznwCto5ZQFui92ErI4Qt
	L7H97RyoWxUkfj5dxgpiiwg4SWyZuYcZokZc4ujPHuYJjMKzkIyahWTULCSjZiFpWcDIsopR
	NLWgODc9N7nAUK84Mbe4NC9dLzk/dxMjOA61gnYwLlv/V+8QIxMH4yFGCQ5mJRFeWcWOVCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQYmptm3dluXTxDe
	mr7z5/27E86LyUqtzExKK2qcpbNLvtLT+EKlitRsuWvpCm4M0nsljl7eMFsnIqpSsfRYStFi
	DhvnlNyPga9OeU+RW+ESXrOUNU5m9rZeDbmYUg/Hf7O5YmqD2+WEb53ceOuP5ZslnU9usJ89
	OHP9datrZb115x4uPnGmUfLw/ukua9a2dUkUe37Uv3VrNi/Pfk/ZZu3GDb8stzPvvH3d7Jg7
	z9Rcy5XMKlEZRnduf1Rt3xIvKr6yO/i1rMQ2u9/dmzLiQhyvOLpKPVaMajI335jP0lvczGRi
	u3imVfM+04W+iQ4/NLk5nKQmNyz/sjl5R9g6O4frvD+5LnGbNhaU6jjEvVZiKc5INNRiLipO
	BADxMholMgMAAA==
X-CMS-MailID: 20231226062150epcas5p3b6a82342591e9f0e2dd0646badef6a68
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154454epcas5p311d2b74fb1809bb555a442d1bce82edb
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154454epcas5p311d2b74fb1809bb555a442d1bce82edb@epcas5p3.samsung.com>
	<20231224-n-s5p-mfc-const-v1-15-a3b246470fe4@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 24 December 2023 21:14
> To: Marek Szyprowski <m.szyprowski@samsung.com>; Andrzej Hajda
> <andrzej.hajda@intel.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-fsd@tesla.coma; linux-
> samsung-soc@vger.kernel.org; Smitha T Murthy
> <smithatmurthy@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 15/15] media: s5p-mfc: drop static device variable in
> s5p_mfc_pm.c
> 
> Change the interface of power management functions in s5p_mfc_pm.c to
> accept the pointer to S5P MFC device structure. instead of relying on file-
> scope static variable.  This makes code easier to read and modify in case
> more devices are added.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   | 42 +++++++++++---
> --------
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c  | 26 +++++++-------
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_dec.c   |  8 ++---
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c      |  4 +--
>  .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c      |  8 ++---
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.c    | 40 ++++++++++----
> -------
>  .../media/platform/samsung/s5p-mfc/s5p_mfc_pm.h    |  8 ++---
>  7 files changed, 67 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> index 5d10c1cb8b92..f0bda2f7f1c2 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
> @@ -183,7 +183,7 @@ static void s5p_mfc_watchdog_worker(struct
> work_struct *work)
>  		mfc_err("Error: some instance may be closing/opening\n");
>  	spin_lock_irqsave(&dev->irqlock, flags);
> 
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
> 
>  	for (i = 0; i < MFC_NUM_CONTEXTS; i++) {
>  		ctx = dev->ctx[i];
> @@ -211,9 +211,9 @@ static void s5p_mfc_watchdog_worker(struct
> work_struct *work)
>  			mfc_err("Failed to reload FW\n");
>  			goto unlock;
>  		}
> -		s5p_mfc_clock_on();
> +		s5p_mfc_clock_on(dev);
>  		ret = s5p_mfc_init_hw(dev);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		if (ret)
>  			mfc_err("Failed to reinit FW\n");
>  	}
> @@ -393,7 +393,7 @@ static void s5p_mfc_handle_frame(struct
> s5p_mfc_ctx *ctx,
>  		s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
>  		wake_up_ctx(ctx, reason, err);
>  		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
>  		return;
>  	}
> @@ -465,7 +465,7 @@ static void s5p_mfc_handle_frame(struct
> s5p_mfc_ctx *ctx,
>  	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
>  	wake_up_ctx(ctx, reason, err);
>  	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	/* if suspending, wake up device and do not try_run again*/
>  	if (test_bit(0, &dev->enter_suspend))
>  		wake_up_dev(dev, reason, err);
> @@ -509,7 +509,7 @@ static void s5p_mfc_handle_error(struct
> s5p_mfc_dev *dev,
>  	}
>  	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
>  	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	wake_up_dev(dev, reason, err);
>  }
> 
> @@ -565,7 +565,7 @@ static void s5p_mfc_handle_seq_done(struct
> s5p_mfc_ctx *ctx,
>  	s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags, dev);
>  	clear_work_bit(ctx);
>  	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
>  	wake_up_ctx(ctx, reason, err);
>  }
> @@ -601,14 +601,14 @@ static void s5p_mfc_handle_init_buffers(struct
> s5p_mfc_ctx *ctx,
>  		}
>  		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
> 
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
> 
>  		wake_up(&ctx->queue);
>  		s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
>  	} else {
>  		WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
> 
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
> 
>  		wake_up(&ctx->queue);
>  	}
> @@ -636,7 +636,7 @@ static void s5p_mfc_handle_stream_complete(struct
> s5p_mfc_ctx *ctx)
> 
>  	WARN_ON(test_and_clear_bit(0, &dev->hw_lock) == 0);
> 
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	wake_up(&ctx->queue);
>  	s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);  } @@ -688,7 +688,7
> @@ static irqreturn_t s5p_mfc_irq(int irq, void *priv)
>  			}
>  			s5p_mfc_hw_call(dev->mfc_ops, clear_int_flags,
> dev);
>  			WARN_ON(test_and_clear_bit(0, &dev->hw_lock)
> == 0);
> -			s5p_mfc_clock_off();
> +			s5p_mfc_clock_off(dev);
>  			wake_up_ctx(ctx, reason, err);
>  			s5p_mfc_hw_call(dev->mfc_ops, try_run, dev);
>  		} else {
> @@ -752,7 +752,7 @@ static irqreturn_t s5p_mfc_irq(int irq, void *priv)
>  	if (test_and_clear_bit(0, &dev->hw_lock) == 0)
>  		mfc_err("Failed to unlock hw\n");
> 
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	clear_work_bit(ctx);
>  	wake_up(&ctx->queue);
> 
> @@ -837,20 +837,20 @@ static int s5p_mfc_open(struct file *file)
>  		dev->watchdog_timer.expires = jiffies +
> 
> 	msecs_to_jiffies(MFC_WATCHDOG_INTERVAL);
>  		add_timer(&dev->watchdog_timer);
> -		ret = s5p_mfc_power_on();
> +		ret = s5p_mfc_power_on(dev);
>  		if (ret < 0) {
>  			mfc_err("power on failed\n");
>  			goto err_pwr_enable;
>  		}
> -		s5p_mfc_clock_on();
> +		s5p_mfc_clock_on(dev);
>  		ret = s5p_mfc_load_firmware(dev);
>  		if (ret) {
> -			s5p_mfc_clock_off();
> +			s5p_mfc_clock_off(dev);
>  			goto err_load_fw;
>  		}
>  		/* Init the FW */
>  		ret = s5p_mfc_init_hw(dev);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		if (ret)
>  			goto err_init_hw;
>  	}
> @@ -927,7 +927,7 @@ static int s5p_mfc_open(struct file *file)
>  err_load_fw:
>  err_pwr_enable:
>  	if (dev->num_inst == 1) {
> -		if (s5p_mfc_power_off() < 0)
> +		if (s5p_mfc_power_off(dev) < 0)
>  			mfc_err("power off failed\n");
>  		del_timer_sync(&dev->watchdog_timer);
>  	}
> @@ -959,7 +959,7 @@ static int s5p_mfc_release(struct file *file)
>  	vb2_queue_release(&ctx->vq_src);
>  	vb2_queue_release(&ctx->vq_dst);
>  	if (dev) {
> -		s5p_mfc_clock_on();
> +		s5p_mfc_clock_on(dev);
> 
>  		/* Mark context as idle */
>  		clear_work_bit_irqsave(ctx);
> @@ -979,12 +979,12 @@ static int s5p_mfc_release(struct file *file)
>  			mfc_debug(2, "Last instance\n");
>  			s5p_mfc_deinit_hw(dev);
>  			del_timer_sync(&dev->watchdog_timer);
> -			s5p_mfc_clock_off();
> -			if (s5p_mfc_power_off() < 0)
> +			s5p_mfc_clock_off(dev);
> +			if (s5p_mfc_power_off(dev) < 0)
>  				mfc_err("Power off failed\n");
>  		} else {
>  			mfc_debug(2, "Shutting down clock\n");
> -			s5p_mfc_clock_off();
> +			s5p_mfc_clock_off(dev);
>  		}
>  	}
>  	if (dev)
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> index 6d3c92045c05..8eedf6524c39 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> @@ -215,7 +215,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
> 
>  	/* 0. MFC reset */
>  	mfc_debug(2, "MFC reset..\n");
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
>  	dev->risc_on = 0;
>  	ret = s5p_mfc_reset(dev);
>  	if (ret) {
> @@ -243,7 +243,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>  	if (s5p_mfc_wait_for_done_dev(dev,
> S5P_MFC_R2H_CMD_FW_STATUS_RET)) {
>  		mfc_err("Failed to load firmware\n");
>  		s5p_mfc_reset(dev);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		return -EIO;
>  	}
>  	s5p_mfc_clean_dev_int_flags(dev);
> @@ -252,14 +252,14 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>  	if (ret) {
>  		mfc_err("Failed to send command to MFC - timeout\n");
>  		s5p_mfc_reset(dev);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		return ret;
>  	}
>  	mfc_debug(2, "Ok, now will wait for completion of hardware init\n");
>  	if (s5p_mfc_wait_for_done_dev(dev,
> S5P_MFC_R2H_CMD_SYS_INIT_RET)) {
>  		mfc_err("Failed to init hardware\n");
>  		s5p_mfc_reset(dev);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		return -EIO;
>  	}
>  	dev->int_cond = 0;
> @@ -269,7 +269,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>  		mfc_err("Failed to init firmware - error: %d int: %d\n",
>  						dev->int_err, dev->int_type);
>  		s5p_mfc_reset(dev);
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		return -EIO;
>  	}
>  	if (IS_MFCV6_PLUS(dev))
> @@ -279,7 +279,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
> 
>  	mfc_debug(2, "MFC F/W version : %02xyy, %02xmm, %02xdd\n",
>  		(ver >> 16) & 0xFF, (ver >> 8) & 0xFF, ver & 0xFF);
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	mfc_debug_leave();
>  	return 0;
>  }
> @@ -288,12 +288,12 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
>  /* Deinitialize hardware */
>  void s5p_mfc_deinit_hw(struct s5p_mfc_dev *dev)  {
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
> 
>  	s5p_mfc_reset(dev);
>  	s5p_mfc_hw_call(dev->mfc_ops, release_dev_context_buffer,
> dev);
> 
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  }
> 
>  int s5p_mfc_sleep(struct s5p_mfc_dev *dev) @@ -301,7 +301,7 @@ int
> s5p_mfc_sleep(struct s5p_mfc_dev *dev)
>  	int ret;
> 
>  	mfc_debug_enter();
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
>  	s5p_mfc_clean_dev_int_flags(dev);
>  	ret = s5p_mfc_hw_call(dev->mfc_cmds, sleep_cmd, dev);
>  	if (ret) {
> @@ -312,7 +312,7 @@ int s5p_mfc_sleep(struct s5p_mfc_dev *dev)
>  		mfc_err("Failed to sleep\n");
>  		return -EIO;
>  	}
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	dev->int_cond = 0;
>  	if (dev->int_err != 0 || dev->int_type !=
> 
> 	S5P_MFC_R2H_CMD_SLEEP_RET) {
> @@ -384,12 +384,12 @@ int s5p_mfc_wakeup(struct s5p_mfc_dev *dev)
>  	mfc_debug_enter();
>  	/* 0. MFC reset */
>  	mfc_debug(2, "MFC reset..\n");
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
>  	dev->risc_on = 0;
>  	ret = s5p_mfc_reset(dev);
>  	if (ret) {
>  		mfc_err("Failed to reset MFC - timeout\n");
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  		return ret;
>  	}
>  	mfc_debug(2, "Done MFC reset..\n");
> @@ -404,7 +404,7 @@ int s5p_mfc_wakeup(struct s5p_mfc_dev *dev)
>  	else
>  		ret = s5p_mfc_wait_wakeup(dev);
> 
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	if (ret)
>  		return ret;
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> index eef26d4e02cf..b620db8896e1 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
> @@ -477,7 +477,7 @@ static int reqbufs_output(struct s5p_mfc_dev *dev,
> struct s5p_mfc_ctx *ctx,  {
>  	int ret = 0;
> 
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
> 
>  	if (reqbufs->count == 0) {
>  		mfc_debug(2, "Freeing buffers\n");
> @@ -514,7 +514,7 @@ static int reqbufs_output(struct s5p_mfc_dev *dev,
> struct s5p_mfc_ctx *ctx,
>  		ret = -EINVAL;
>  	}
>  out:
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	if (ret)
>  		mfc_err("Failed allocating buffers for OUTPUT queue\n");
>  	return ret;
> @@ -525,7 +525,7 @@ static int reqbufs_capture(struct s5p_mfc_dev *dev,
> struct s5p_mfc_ctx *ctx,  {
>  	int ret = 0;
> 
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
> 
>  	if (reqbufs->count == 0) {
>  		mfc_debug(2, "Freeing buffers\n");
> @@ -568,7 +568,7 @@ static int reqbufs_capture(struct s5p_mfc_dev *dev,
> struct s5p_mfc_ctx *ctx,
>  		ret = -EINVAL;
>  	}
>  out:
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(dev);
>  	if (ret)
>  		mfc_err("Failed allocating buffers for CAPTURE queue\n");
>  	return ret;
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> index ba22c6a3219a..87492db83536 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
> @@ -1346,7 +1346,7 @@ static void s5p_mfc_try_run_v5(struct
> s5p_mfc_dev *dev)
>  	 * Last frame has already been sent to MFC.
>  	 * Now obtaining frames from MFC buffer
>  	 */
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
>  	s5p_mfc_clean_ctx_int_flags(ctx);
> 
>  	if (ctx->type == MFCINST_DECODER) {
> @@ -1422,7 +1422,7 @@ static void s5p_mfc_try_run_v5(struct
> s5p_mfc_dev *dev)
>  		 * scheduled, reduce the clock count as no one will
>  		 * ever do this, because no interrupt related to this try_run
>  		 * will ever come from hardware. */
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  	}
>  }
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> index 08545213caa9..8908c159a91e 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
> @@ -1992,7 +1992,7 @@ static void s5p_mfc_try_run_v6(struct
> s5p_mfc_dev *dev)
>  	/* Last frame has already been sent to MFC
>  	 * Now obtaining frames from MFC buffer */
> 
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(dev);
>  	s5p_mfc_clean_ctx_int_flags(ctx);
> 
>  	if (ctx->type == MFCINST_DECODER) {
> @@ -2072,7 +2072,7 @@ static void s5p_mfc_try_run_v6(struct
> s5p_mfc_dev *dev)
>  		 * scheduled, reduce the clock count as no one will
>  		 * ever do this, because no interrupt related to this try_run
>  		 * will ever come from hardware. */
> -		s5p_mfc_clock_off();
> +		s5p_mfc_clock_off(dev);
>  	}
>  }
> 
> @@ -2088,9 +2088,9 @@ s5p_mfc_read_info_v6(struct s5p_mfc_ctx *ctx,
> unsigned long ofs)  {
>  	int ret;
> 
> -	s5p_mfc_clock_on();
> +	s5p_mfc_clock_on(ctx->dev);
>  	ret = readl((void __iomem *)ofs);
> -	s5p_mfc_clock_off();
> +	s5p_mfc_clock_off(ctx->dev);
> 
>  	return ret;
>  }
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
> index ecb3065c33c9..ae4241408383 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
> @@ -14,13 +14,11 @@
>  #include "s5p_mfc_debug.h"
>  #include "s5p_mfc_pm.h"
> 
> -static struct s5p_mfc_pm *pm;
> -
>  int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)  {
> +	struct s5p_mfc_pm *pm = &dev->pm;
>  	int i;
> 
> -	pm = &dev->pm;
>  	pm->num_clocks = dev->variant->num_clocks;
>  	pm->clk_names = dev->variant->clk_names;
>  	pm->device = &dev->plat_dev->dev;
> @@ -50,58 +48,58 @@ int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
> 
>  void s5p_mfc_final_pm(struct s5p_mfc_dev *dev)  {
> -	pm_runtime_disable(pm->device);
> +	pm_runtime_disable(dev->pm.device);
>  }
> 
> -int s5p_mfc_clock_on(void)
> +int s5p_mfc_clock_on(struct s5p_mfc_dev *dev)
>  {
> -	return clk_enable(pm->clock_gate);
> +	return clk_enable(dev->pm.clock_gate);
>  }
> 
> -void s5p_mfc_clock_off(void)
> +void s5p_mfc_clock_off(struct s5p_mfc_dev *dev)
>  {
> -	clk_disable(pm->clock_gate);
> +	clk_disable(dev->pm.clock_gate);
>  }
> 
> -int s5p_mfc_power_on(void)
> +int s5p_mfc_power_on(struct s5p_mfc_dev *dev)
>  {
>  	int i, ret = 0;
> 
> -	ret = pm_runtime_resume_and_get(pm->device);
> +	ret = pm_runtime_resume_and_get(dev->pm.device);
>  	if (ret < 0)
>  		return ret;
> 
>  	/* clock control */
> -	for (i = 0; i < pm->num_clocks; i++) {
> -		ret = clk_prepare_enable(pm->clocks[i]);
> +	for (i = 0; i < dev->pm.num_clocks; i++) {
> +		ret = clk_prepare_enable(dev->pm.clocks[i]);
>  		if (ret < 0) {
>  			mfc_err("clock prepare failed for clock: %s\n",
> -				pm->clk_names[i]);
> +				dev->pm.clk_names[i]);
>  			goto err;
>  		}
>  	}
> 
>  	/* prepare for software clock gating */
> -	clk_disable(pm->clock_gate);
> +	clk_disable(dev->pm.clock_gate);
> 
>  	return 0;
>  err:
>  	while (--i >= 0)
> -		clk_disable_unprepare(pm->clocks[i]);
> -	pm_runtime_put(pm->device);
> +		clk_disable_unprepare(dev->pm.clocks[i]);
> +	pm_runtime_put(dev->pm.device);
>  	return ret;
>  }
> 
> -int s5p_mfc_power_off(void)
> +int s5p_mfc_power_off(struct s5p_mfc_dev *dev)
>  {
>  	int i;
> 
>  	/* finish software clock gating */
> -	clk_enable(pm->clock_gate);
> +	clk_enable(dev->pm.clock_gate);
> 
> -	for (i = 0; i < pm->num_clocks; i++)
> -		clk_disable_unprepare(pm->clocks[i]);
> +	for (i = 0; i < dev->pm.num_clocks; i++)
> +		clk_disable_unprepare(dev->pm.clocks[i]);
> 
> -	return pm_runtime_put_sync(pm->device);
> +	return pm_runtime_put_sync(dev->pm.device);
>  }
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
> index 4159d2364e87..9c71036f0385 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
> @@ -12,9 +12,9 @@
>  int s5p_mfc_init_pm(struct s5p_mfc_dev *dev);  void
> s5p_mfc_final_pm(struct s5p_mfc_dev *dev);
> 
> -int s5p_mfc_clock_on(void);
> -void s5p_mfc_clock_off(void);
> -int s5p_mfc_power_on(void);
> -int s5p_mfc_power_off(void);
> +int s5p_mfc_clock_on(struct s5p_mfc_dev *dev); void
> +s5p_mfc_clock_off(struct s5p_mfc_dev *dev); int
> s5p_mfc_power_on(struct
> +s5p_mfc_dev *dev); int s5p_mfc_power_off(struct s5p_mfc_dev *dev);
> 
>  #endif /* S5P_MFC_PM_H_ */
> 
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Thanks!


