Return-Path: <linux-kernel+bounces-88992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB8E86E91F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2131F29026
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F0A3A1BB;
	Fri,  1 Mar 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0oWY/3C"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7D39AF3;
	Fri,  1 Mar 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319788; cv=none; b=gjDhoudo/XOCAU4qT2Tt5UvzezllSl5TyMqEUNtMz2ladWfkZmVqqOrKnNgRGl1E4uami6ITxkjBTuSoy4gjz0eXnX4GbLG4bLgbm5jjYzcyDbqVQoTo26NabtXulOU3wbhS3FPOaBYDAjFeA3Nk2+o/0cT3sa0A1cgUulKgJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319788; c=relaxed/simple;
	bh=51tp/Bjz8IURQUYarrI2wOwDWIoS+kIinrfe1M6PZJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebhgi7Mv5n94Ghgd5ToSGD5Mq+IAhJeUWf+EC9MfV1D7IMOqpY2o7R0a7P7ME729tpgGpM+gsPDE8Z7p5JuJ9wM30AdQPt8vjVdQEBQg9EYV5jiQWscYVbYxxWlEjn8AQdkbCUaHYW0vVY6LrPZRzEpq/8z9Sv7QF/rOTmJKYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0oWY/3C; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a10f19d4a0so18432eaf.0;
        Fri, 01 Mar 2024 11:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709319786; x=1709924586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SE40B9hgoMxl2rpx1CQNiiNwATV4tS/ycE89d3SLnCQ=;
        b=X0oWY/3CkECWwnOG0ccbPGnVVloa5vNvNGi8Fe6n8e18tYFVunjMP0dIMUyBH/9Jb9
         w4yPp3Gx9oj3tEV7IDQgK7uMsry9A1PbZqNjQDezTiLA3o1xCyp9B4G3t05YFQsMjO9+
         5jFcRwpig34SoiJwVaqm2sqYDCPfUlkogiXhfMsQfmdNKDddaVkYFDx+lprYSufbDknF
         2b+gz6wf0cV+4Beeh6ImITJrjBe4EJ3x2ziH4U8Tnq4SxFsSFkOogH33TQPI+BTMKRqp
         Hj3M9DMOlnFZikMJJk6hpyMlSzEK39S3qaVq86tDRUkSJmjVjtOdYSuhKHRZXZiuVFXS
         OogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319786; x=1709924586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SE40B9hgoMxl2rpx1CQNiiNwATV4tS/ycE89d3SLnCQ=;
        b=MnEAecrv5FyKNvUWKZ9vTW6M870pmCm1f39lAMbZmtkmEXTbHAFhtBBubolyAtmB96
         IiSH12kgAsEQr+sPbtP/xWcrcZEpdu+qmQkqHKfE8vKI0Q8tl4UJ96qy6oEcWkBubuxw
         s3L1RUZ9aNyq4Q8S1YS/iah14LacPujFKTS6noa8eiBLG+5vvRHkvNoPI8iTR58nRkjW
         ymI0I96goYkga4kipFtKwZXwa2nd8OYjA/mpcM2OW/060ZXpmKh0T6tvNUqONn6xKATV
         WI1nPgZF571AGDn5kBXY0xj2fXQodLaHIy1jxDOfjl0DrKkKazEWDWR+NcGjvnwiJKzS
         0lmA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ393JaTNaJWLqcjuQJaJrX1nlSqsRhV4N0lzazY27RXld0GqW+/xGfM3FC3putXcec7R2/pWRVPz25rf2hbSHq3U0GrVEh4vKd8v29S/y7IySoB1yvC6BquVfJU55u3THXQKXoiyx/JCXe0m0JJYUI4t8o5gDkQ4WnoTMbWRIyKL1s5zWihXPFA==
X-Gm-Message-State: AOJu0YxKmdsEq6ufCAFr1qBHj+7yETaYMa+vwASDVunsPKFyDyiIOzAG
	/dGCLuOeyLM816rqapGZXw6dJWocIZEYolig2UbShjTHroh/ykHji5aitk5+GaJqpB+TPwfEw5C
	7hvZYPZE74k1qyzc3l+0hZhRe9L4=
X-Google-Smtp-Source: AGHT+IGbx4/tIW7yuZmPHNA1HEkqzlBB14mzmokKtAQVuFrKDPObAQs6vzZFYqB/ou13sLvxvFCgpeCY1I3OTb6wNS0=
X-Received: by 2002:a05:6358:88f:b0:17b:6b42:8d9e with SMTP id
 m15-20020a056358088f00b0017b6b428d9emr3158417rwj.0.1709319785941; Fri, 01 Mar
 2024 11:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301144458.2810597-1-usama.anjum@collabora.com>
In-Reply-To: <20240301144458.2810597-1-usama.anjum@collabora.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Fri, 1 Mar 2024 11:02:55 -0800
Message-ID: <CABPRKS-0v0bdsAp6aK80AQn80WRSGpF3SP9HtwH2wMPXoByJQw@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: correct size for wqe for memset
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.com>, kernel@collabora.com, 
	kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Muhammad,

> -               memset(wqe, 0, sizeof(union lpfc_wqe));
> +               memset(wqe, 0, sizeof(union lpfc_wqe128));

How about instead memset(wqe, 0, sizeof(*wqe));

Thanks,
Justin

