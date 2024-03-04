Return-Path: <linux-kernel+bounces-90417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3186FEDA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E1F1C20F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB913717C;
	Mon,  4 Mar 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAXvO2PO"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D537166
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547541; cv=none; b=Qb60MI+v+HaDqrG2GG3oq3XWVE57H8u5Mg7UVyysZaMrfua2Ps3j95E7d3dOg9NNY1jFUz57AtXzrbq4KUbknLN5RNwNvrIjZQSOqwT5KqH/XMrQayt4WWF1CiUYRIAJysGaGYCBX7vUPWbuJYLzRgodD/vAET/33EaJhLRcOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547541; c=relaxed/simple;
	bh=L8Yd9aivs1y5S31tf+SgGvY1CAv2qBofPRQcyrKZogA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV+qRhvUJ3QXRUtgQsOrrFLzc3u80cMphSUtFOpLDnFZGPxWS5+dxTe+JSIcwVnabNf5gRTOh5OPSauive7+Y1lru3MKVLTicDFNsDTKQXlETkrui/t4qHwjnz7NaIQ4T2rPDk6xpKvUPF7AFxPT4YW/AaauVfOEyeXSUtO18oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hAXvO2PO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e84f501dso893765e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709547538; x=1710152338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmW5zcFPe9YbXP0IPxGliLDGDmB0I6XEzcryOh8vMLU=;
        b=hAXvO2PO5itBLRLfsKsZGObwFCSzsGqdjkOOfeMRIRjONXUhGWeOW9p2NN9843D4OS
         DIgfqHzxCS5lwYXsvEzs85vuKppRzDY3+J3CGVR/v6uaerdgyxKK9MLnNh6GdUlE5F1V
         j5w4w21p3QP8PiK4VYRktvotkvU+/3f2XFkNdv6nhbE3wt/4P4QmammOEzX1JaTLhCY/
         5J6NT9x1PQ9uXMlGEEZx01RnZu0kRqOfq0MclNx37lBX6Ga0NdBfJ8iz5R4FRSonSa/d
         1xyQpyR+RHEVroquWGZSBWk3Nw8p1Jkm2tRPD9iVjy8RDVYxpYtra4UvFhnZ32gdBijJ
         1FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709547538; x=1710152338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmW5zcFPe9YbXP0IPxGliLDGDmB0I6XEzcryOh8vMLU=;
        b=QOiWhSUKuJAZfTRvXes3kjB55ho6GPFA4IsO/EG5Yavovn/oYO3oknG5XGPswLE8/r
         oE0O1/TpFhgQztTBZUPqaXZu7DQfzXIorZH9R+1L1jNAk5w0DyRVIWIQLBFBhnYSK4gr
         S6UIJs+tK7unPo277/1SHjX7s+YpAtRVZMzTjwlDOdJkRWzI3EkMIahlNl3V/EOcjLu4
         x4Gf/UFFZbP0EbUzebJpD+LyAAjJnx2AynwyoqIN9akzIDOB4i+80jTEQLpGRJAtVU5U
         ZbrT5GPa7S1YTqYNgmNEByHwjKmTDY4n5qumucB2xk3GClI8kwQBqE6ZkCrnzeqdk5ea
         0dpg==
X-Forwarded-Encrypted: i=1; AJvYcCWB3ZsCd34Zn9Qvu8kX3JPYsY3685tyhnv68HsAbyxdSm2VEBh+8xTewFu1hBoXX1HmLBvofFM4Dh89ZO8LZVFD0sMs2EUZls9iqFG7
X-Gm-Message-State: AOJu0YyX5htZHH/oLlSlC2V7eWVP7sG4sXu2xhsspZe6VihvzLmJYaLu
	rgG2+JvFmGNVMeBnG9LyJmj3vyOPFY485ddWctDExofBR6FQvwtJ8NUYZ15GHQA=
X-Google-Smtp-Source: AGHT+IG7Ov7Kyt5GXCvjUp+CIJ4MuPiibAQif/bU5BPfLZ2jv6mBHOrOSrzTXlmjfbxDND2MEzFxPg==
X-Received: by 2002:a05:600c:19cf:b0:412:c219:6206 with SMTP id u15-20020a05600c19cf00b00412c2196206mr6630691wmq.39.1709547538248;
        Mon, 04 Mar 2024 02:18:58 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c1d9400b00412e795f270sm763534wms.22.2024.03.04.02.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:18:57 -0800 (PST)
Date: Mon, 4 Mar 2024 13:18:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aman Sharma <210100011@iitb.ac.in>
Cc: Gregkh <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <835bba82-c144-4674-b8ec-a6bd6af89daa@moroto.mountain>
References: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>
 <1440d44b-c16d-4307-9457-5c3ae44716ff@moroto.mountain>
 <74ec69941cb67e3a351ebd23d5ad4a5b@iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ec69941cb67e3a351ebd23d5ad4a5b@iitb.ac.in>

On Mon, Mar 04, 2024 at 02:04:08PM +0530, Aman Sharma wrote:
> Tbh this is my first patch and I don't have the hardware to test this. I
> thought updating the values from the datasheet directly might be a good idea
> as it would be the correct range. Please correct me if there is something
> that I missed / need to know.
> 

No, patch is fine.  There is no downside to updating the .txt
documentation in this way.  I was just wondering.

> On 2024-03-04 13:55, Dan Carpenter wrote:
> > On Mon, Mar 04, 2024 at 11:23:40AM +0530, Aman Sharma wrote:
> > > Updated bitrate range for FSK and OOK modulation from the RFM69
> > > Datasheet.
> > > The values are mentioned in Section 2.3.2 of the datasheet.
> > 
> > Have you tested these as well?  Sending untested patches is not
> > necessarily against the rules, but it seems like maybe you have this
> > hardware and can test it.  Could you please talk about what testing you
> > did?
> > 
> > > 
> > > Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
> >                             ^
> > Missing space.
> > 
> 
> I'll fix this if I am allowed to submit a new patch.

regards,
dan carpenter

