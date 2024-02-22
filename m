Return-Path: <linux-kernel+bounces-75835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59885EFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493461F23EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A9D17562;
	Thu, 22 Feb 2024 03:09:13 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE410A12;
	Thu, 22 Feb 2024 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571353; cv=none; b=OrA5g639gk+YMy6XI9aDlUuXI5ypNO/MrPCGEBx3sTJ+JcWerQViWyOwm0p99UB1RpQ2HAqBlMv5D9YAp+dvnkxaYvH6YLjPl+80dUboryiO/e0wsXZkp1391BaXmhfCmVZRi7/hT5i0nW6E5HyrnPBVzdUHK/RO7u87rgoPCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571353; c=relaxed/simple;
	bh=utSs3m/ghTp4R805q7ZPfnuZ2Nk1u20QIFsToJjeTH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgpEo/T5PgA2ZPG0VK6tyx2645SQlBbaWF/jSwHYS/9MpocBaKXX04pykzx+/jV0n9FIXkda/F6kua3u84uzr4FvmpJKDXql+de5iw52c1BclXtWWyekl1p8DLPDH+ykyqdKiarSBgT2eXiws+yOIkmsjZcmhBzRbjeI869aNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so3883025ad.1;
        Wed, 21 Feb 2024 19:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571351; x=1709176151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utSs3m/ghTp4R805q7ZPfnuZ2Nk1u20QIFsToJjeTH0=;
        b=EmN7hVvJfya12V21lLC5e+Fi07GPwiIrbU2x0cBoBXiw/7zbfqUPMT+V/X9kgESK0o
         TuXP/ZE7jHcblU5Zb57oxlfeh3uOmOUOR9nW2zvEnKqFOwxLtQenR6xlHWCkx0tiutir
         SyHTcGMUXQ6DiB1LBCZulw5MuYLp+8CJdnzOYatSvnLoJmQxYRpjEVwhpFb/CMVDUqZk
         gy7GDvhE1M0TKVs9aP1bSUlFJ+h/EhjQ+o+Dwmcv9F0SnX11A/6XKDSV4S4Zbhbiy+Zy
         oaNI6+vF0lxKUaZ8i8hIoiIL04/pItvemnIxp9n/0yVdWbokvAzTM8t2ct5xxvQGsHJ5
         OeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrxjVMr8RDgcPwPeC3rnOSwNDLbg+4JzGS1zHSPiMQRDp/ZTIHIqx7hLTsXGsYQFARZRNRSHwpx2YkvHWwG8sug3T61Qo8MAadkhm3AhMDcTViKA8HpZscEBNYVO14vWA4AspEKJDKNw==
X-Gm-Message-State: AOJu0YyIuwe/lHsxyHhxW4P1K4bta+kqTrI+6rjx5AXJ3eOHd08rqHQb
	XkQd46q86jItHmB1caS5q1l2LWbIQJK/UhTe0v2tokgTFd+GvFAz
X-Google-Smtp-Source: AGHT+IGFvtSvMMQ+ev1NRjHkB1t0K8/305nAlbjKCh1a7FXjQST7s7J7xBqN7LNtwYtEY1MRkRu6tQ==
X-Received: by 2002:a17:903:2288:b0:1db:bd46:a429 with SMTP id b8-20020a170903228800b001dbbd46a429mr2039102plh.28.1708571351085;
        Wed, 21 Feb 2024 19:09:11 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902d3cc00b001db398d13ecsm8780462plb.258.2024.02.21.19.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 19:09:10 -0800 (PST)
Message-ID: <9eb36b38-87a3-4619-be64-8a6ccf3b407d@acm.org>
Date: Wed, 21 Feb 2024 19:09:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
Content-Language: en-US
To: Can Guo <quic_cang@quicinc.com>, Rohit Ner <rohitner@google.com>,
 Bean Huo <beanhuo@micron.com>, Stanley Chu <stanley.chu@mediatek.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240220090805.2886914-1-rohitner@google.com>
 <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
 <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
 <0f959cca-ad29-4b8b-966d-55eb37156ef8@acm.org>
 <cca63e1e-e16e-476c-b646-b6ff2cfb70a5@quicinc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cca63e1e-e16e-476c-b646-b6ff2cfb70a5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 18:05, Can Guo wrote:
> The if-statement you are mentioning here, is it the if (hba->vops && hba->vops->setup_xfer_req) or if (is_mcq_enabled(hba))?

Hi Can,

I was referring to the latter if-statement, at least if it would occur in the
code that you plan to post and that I haven't seen yet.

Thanks,

Bart.


