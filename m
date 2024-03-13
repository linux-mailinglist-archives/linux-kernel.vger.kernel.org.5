Return-Path: <linux-kernel+bounces-101130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951F87A2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C02628324D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A33E134C8;
	Wed, 13 Mar 2024 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GSbr7B38"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2D12E76
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710309692; cv=none; b=h5/klviW20SUAc07433Ml5qa/VEN3jFNTcuDC617+bThD50WfUKdB59O9pEVHmdiEamTpkHRnW3P7qe7eXuAqrxX1rRV5NTv5Kur+sz5JeA/Yd7RKMrpGvDVIBCImGt7ck6nNq1NcLtBGEo16etigmKWSukmtwScLKXOggOdKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710309692; c=relaxed/simple;
	bh=O7Ld1LYQuGJ8RYWCmpDuJpHzxK88sA4/+eP0rB/C6NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvRgMJQA820PzeT2bmSpMHLbCVRoL1Tr0weLZVMT2BESrorRYqB3qITqSYy8R8NQ2554MbwQrbNdlA2w5lVivbSDLlylF9iaq4ttfiNQjS25i/gYBPmX24V3szz4itBDzwuxHioWTJRA2slBTckS4QQzKot3jaXCtfDripHxPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GSbr7B38; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d459a0462fso21184891fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710309689; x=1710914489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4s+BaYXL4bYNZRyKaIQNGvRcYz7+hEua7FGBCwivZE=;
        b=GSbr7B38OhGX8SrZG6QlaBFwPiJNI6odFmS8Sp4eJIoASdzKn0/a2naxlaNL7EJrEc
         0PbkGihnghsp5NJpwPu+O+LPGxEWpyZma7lhmJ5zfWZsb6ugQr8vdr6DJrSwBmjNv22O
         hzMpcpgctLLDkfVIAnRuASN4i6SP5gyEXWoypgluSg1I5b6Es65/SFJnZ13tNXAB1WlR
         spozP4IoFVbmmhTOeQH8FjCAuz73Wi7OY5p66fCxObCn0FWafXrBHM8+APeLSLrOvouV
         Y2amBubQYqIlX0DlzphDVCV0a02KNnfpir+lDVaKkvnBihQpcte3iIcL2AGwmkh41+Qd
         u8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710309689; x=1710914489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4s+BaYXL4bYNZRyKaIQNGvRcYz7+hEua7FGBCwivZE=;
        b=oua3+t55WE5LCuod9V7KgZUwr27hVKakTLkKHF94IQY9XKxKis1YoB2JrLv8lk65gI
         6MCGUTBAczfkatmXrxhWos6pBPgTbvvSJmcyYXDsaTOqIbAvprf+/xykudylFnnIAb3C
         Fg50EtEnIlF9nYhGYTiWpInkioUI+9DCUN/j8noUaXHWOE9/Kl+VoFF1mPhFdr6/t3Dz
         dfI2gQezXM5DMyax23uMyKLFcaFJsMtBxv+lXqmGUtj54EtKSJtbpLxOyfstwIhnvblH
         Trnmf1x3tqTyuqKRjDJ6fdhLdbB0LEUUDJOMvNTa2zUBGzsCmkGsNU5tb8pdNyHHvEt3
         SYlg==
X-Forwarded-Encrypted: i=1; AJvYcCVxcBz+JXysUX8xGXK6BHGngk1eenWc0bL6FNEzqihwmPJB8/hugl1quHKx+DZIu3CaqFmC6XYboqDynBnduke7w7l2Fuzzs1uVqzbG
X-Gm-Message-State: AOJu0YxJzbWm+ClYCoASXT4JH12Zs072a3LMo5LjJTdMqEiKzeDjEytk
	25v0yUYZ0Y3JwIrw+xZ2urJM6+TrZNtnwHL9Gz+6/c965sjN1iMXQsSMRhl7Rkc=
X-Google-Smtp-Source: AGHT+IEsF2Bab0mR13jcWlh7GpMxPMJz8ZE7X/8KzaIBQoi1e1xTiA0OACTSdu6jXnwx+9HSN3+V4A==
X-Received: by 2002:a05:651c:1255:b0:2d4:6df2:12c0 with SMTP id h21-20020a05651c125500b002d46df212c0mr138246ljh.34.1710309688367;
        Tue, 12 Mar 2024 23:01:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b005687e17cfc3sm731893edb.11.2024.03.12.23.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 23:01:28 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:01:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [v1] staging: media: starfive: Clean pad selection in
 isp_try_format()
Message-ID: <2bd3995b-2625-4874-ab53-fa3bcffb5f28@moroto.mountain>
References: <20240312024520.11022-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312024520.11022-1-changhuang.liang@starfivetech.com>

On Mon, Mar 11, 2024 at 07:45:20PM -0700, Changhuang Liang wrote:
> The code to select isp_dev->formats[] is overly complicated.  We can
> just use the "pad" as the index.  This will making adding new pads
> easier in future patches.  No functional change.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---

I'm not sure that patchwork will find this patch if it doesn't have
[PATCH] in the subject...  But otherwise the patch looks good.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


