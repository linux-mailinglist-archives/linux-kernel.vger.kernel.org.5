Return-Path: <linux-kernel+bounces-95507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8F9874E89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FA61C23CA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45C12A153;
	Thu,  7 Mar 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/qOYGPf"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054C1292DC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813046; cv=none; b=CxloBCrUmvi91KlXwVTueJl7cDqbE7Bp+Ax4a/qrJ56aIBlp9OEcomEW664+H0/XVUVTRxw4YQasOnlD8NfWpoemZIYFkPXwf03veblqCT9nbqah6LEUTHzSKj7bKu/zX1YKl0vLCO5G/iB3qNhWmoi2IQqMDr4z8JoBwkKo5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813046; c=relaxed/simple;
	bh=AZV5N2AwheCxqRqLM/3q3lQBybrhTfZ5S/lvgujXWzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJB3w16lbY689hxjk1IRlvtBCPKG2RK8Xpmd/69lXWfL2MYX/KSMmj8PpsLFm0q8cn6PtPW8bnTLCwp9FZrcGzLt38gISqcI5CskrjzVDRDLvhOzxv2LUJpfv0bxyxX1w1LRqVQFBcwf5/R3bY1Ju1yeaII/6/lYxTeY3jnAo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/qOYGPf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51336ab1fb7so1005527e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 04:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709813043; x=1710417843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F2Fyfk0Z5Z7LzM4ubY4N0WUN8/ihkIdQocELKuF3SZk=;
        b=I/qOYGPfi/EaBf1qUvv9Z63Vls+yD0TsiK7uOWdKXbkg5iTg62w53zxAbYLL0io8FU
         +SpKxgGPbt7F5EfDR7AOQ6ICiNr3aYgA60G765WBVFdoj6oQXQctywocQdshDaVeECuE
         hA2LQdJLhxq0fF7S/QnHjFnO9AIQhiKfjRkoncezS1NeZYOVpGwGeEbqZFl5WJQpvrnm
         AWgmtMCJ4Yn7C/Rdk4AB72QAcXW5kFk+TOdi5CNsGg8PX6q0p/rfspD7gr84IR+VsA2f
         DL1ifE95laMaiA7LFsliFL8v9j2LiC+xq4APALD+UkdIshhHv33I8lz0fuRUByYz/aZ5
         woDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813043; x=1710417843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2Fyfk0Z5Z7LzM4ubY4N0WUN8/ihkIdQocELKuF3SZk=;
        b=aTQqVTDpBjvKPIOJlxUHqTW8/33FYFEhBaDdu+WQ7jKK72fg12NnnKHNVl9RfqOVAG
         y0jQamxDUoh/LoIreDpa0Fpc7NqH7PARR3nPhiCoTT24sJr4MDTLo+ypGFm0jegQEbmd
         z7W+cwjD5nbZOAznqyge4bt8rrb1HsbEh0svG1DGsqgP/YsCuzU+ZRJE6p4cOtMb9vP4
         eArAHPolaWUIo064kKKYOQDc1fYXVWQ0ANNTELGwqhiuRjnhuJydIzxaCtyAcnEkUN88
         RNQWBPABTJ3dzuoKPi0f57bAmZaGyXamfBpXUGlnGzu7JliWNK4KoPQiLnBG1CYXR/47
         2Nhw==
X-Forwarded-Encrypted: i=1; AJvYcCUQQdlvw+yDVCxdqddWACNLkLLEOArDfkBZqNmKZoKe5ITzx8EXFH+NOnNVQL1Q9tAInRGooK1UGmSN1m5BjmLHDt02d6D86AWuav+C
X-Gm-Message-State: AOJu0Yypg/Y4SxIEQiTfj64YJSUeWauXIlEoTYqmsqTRYIdfcP4yiLQZ
	haf09if995ydZhXZvecNdNbtbzbvlJbP6CeySJ7kjL1rOAia0jA8sA0vGkXIF+o=
X-Google-Smtp-Source: AGHT+IFnwdhtwPsEP5oZPW0CnfMI15eNBkLQXmofIyA7OiFWrgmhnEk2RBJxkYTJufQTd/r6sVxagw==
X-Received: by 2002:a19:9155:0:b0:512:ec79:3be5 with SMTP id y21-20020a199155000000b00512ec793be5mr1093760lfj.43.1709813042704;
        Thu, 07 Mar 2024 04:04:02 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b00412ea92f1b4sm2547606wmr.19.2024.03.07.04.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:04:02 -0800 (PST)
Date: Thu, 7 Mar 2024 15:03:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2] mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems
Message-ID: <831b4af1-f6a2-4bc2-ac9d-7227c28121d0@moroto.mountain>
References: <31a20aead3419209991bf01aaeaefe07ab94d23a.1709081052.git.daniel@makrotopia.org>
 <8ae44e8e-fc3d-28bd-5d1e-e900ce53529f@huawei.com>
 <27c875fb-9507-4034-8468-c4d46c952754@moroto.mountain>
 <005448D3-A311-4B2D-B515-C7A9399B48E4@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <005448D3-A311-4B2D-B515-C7A9399B48E4@makrotopia.org>

On Thu, Mar 07, 2024 at 11:42:12AM +0000, Daniel Golle wrote:
> 
> 
> On 7 March 2024 09:17:45 UTC, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >On Wed, Feb 28, 2024 at 09:45:13AM +0800, Zhihao Cheng wrote:
> >> 在 2024/2/28 8:46, Daniel Golle 写道:
> >> > A compiler warning related to sizeof(int) != 8 when calling do_div()
> >> > is triggered when building on 32-bit platforms.
> >> > Address this by using integer types having a well-defined size.
> >> > 
> >> > Fixes: 3ce485803da1 ("mtd: ubi: provide NVMEM layer over UBI volumes")
> >> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >> > ---
> >> > v2: use size_t for 'bytes_left' variable to match parameter type
> >> > 
> >> >   drivers/mtd/ubi/nvmem.c | 5 ++++-
> >> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >> > 
> >> > diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> >> > index b7a93c495d172..e68b8589c4279 100644
> >> > --- a/drivers/mtd/ubi/nvmem.c
> >> > +++ b/drivers/mtd/ubi/nvmem.c
> >> > @@ -23,9 +23,12 @@ struct ubi_nvmem {
> >> >   static int ubi_nvmem_reg_read(void *priv, unsigned int from,
> >> >   			      void *val, size_t bytes)
> >> >   {
> >> > -	int err = 0, lnum = from, offs, bytes_left = bytes, to_read;
> >> >   	struct ubi_nvmem *unv = priv;
> >> >   	struct ubi_volume_desc *desc;
> >> > +	size_t bytes_left = bytes;
> >> > +	uint32_t offs, to_read;
> >> There still exist a type truncation assignment 'to_read = bytes_left' below,
> >> although it's safe in logic.
> >
> >Yeah.  As you say, from looking at the logic we know it's safe.
> >
> >    41                  if (to_read > bytes_left)
> >    42                          to_read = bytes_left;
> >
> >Obviously the new value is smaller than the original, so it must fit
> >within a u32 range...
> 
> 
> I've sent v3 of this fix which should be finally be warning free now.
> 
> https://patchwork.ozlabs.org/project/linux-mtd/patch/ff29447dcee834c17e4e1e99725b9454c90136ca.1709178325.git.daniel@makrotopia.org/
> 

Thanks!

> >
> >This bug has been breaking the build since Dec 19.  
> 
> I have a hard time believing that as the offending commit was only applied on Feb 25.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=3ce485803da1b79b2692b6d0c2792829292ad838
> 

Ah...  Okay.  I was looking at the author date.  Not the merge date.  My
bad.

regards,
dan carpenter


