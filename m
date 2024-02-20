Return-Path: <linux-kernel+bounces-73500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9C85C38A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD9B281307
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D777F35;
	Tue, 20 Feb 2024 18:19:49 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB24763F6;
	Tue, 20 Feb 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453188; cv=none; b=VwHjudjnSRF8JBZYDx0Lf89Domxh8+Vp6dggHqOxygeooZjm9FA30HaahSGtnS+sLkUwXifdU3QWOaZEOy8qOwRFMwQRQEqy9aRj/PuYx5L+1jNsPAqL5gY61FTWXuADCOvKlVrgXafR3io8ZhuENpYDkP0wk4UcfJgz5uaiEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453188; c=relaxed/simple;
	bh=jyYnr1vl6x18LWQLd7EauTB9Xo3hvmJzMJZ0083i9Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+QmX37YxoXvTa+UHl7vmdMDq60eaW02dmtno2j6v516+jW31SnDy4OEiZTirik5HiDoHOovzVFPs3YWjGNXLBcqb31e3eSEPssPmhxlDkZ1y1rhdIdgxm2YsAsU9hGorsBV6Ll1pqn3Ur9T2feW0KrCM9RFJbr8lkcQyzVy9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d934c8f8f7so54620035ad.2;
        Tue, 20 Feb 2024 10:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453187; x=1709057987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIaEw1j+qBtvH9M5w+a4/XEf+88yuJ80F8Q41APfGUI=;
        b=wZyNewfMZsu822YNske5TKT67ENt2f9gQWvWXLcxEYcXhyWGYZS6bG/2sEQipUT7SC
         xgDyRogRkGz/jHQSkgFCiOuiHE2PHkSEoNlOCzvZzmK7dwEaO1ej3Czhs287cmXyEM+F
         799C7kMzozAleJ9ITzjBOWS+VXhjuiGoA3504BLI/qpAw3gJ/qAg5vD2Ay3e6J8MVxaD
         u2CuhkKGFmOirazUhpqpP9ews3fkMLooHRqqoYxuutxgYJ0jg8ocxiCnYmQ5G9A0cZHm
         o+Yk0EJUlH8fy1ZeBkYC5UmBiYDQbWOGM6biQ8s3nv1yX5g5X6kTIu3RTp+mRp7Ktlko
         1+QA==
X-Forwarded-Encrypted: i=1; AJvYcCXT0rJUgFydKuLf7KW/42/oskAtUffBaaaGiQIQ8oew7mX1uAZ+3bSSBNv2OyLAJ0bMC0Ss3YvcP9lfNlvTAn2osQDK3lS/UYzOaHcH3GJsUKRqFpkQbOHJZW3yF+jrRtm+XEKpyN/HYg==
X-Gm-Message-State: AOJu0Yy9OjrYt3myFydTaw3d+bKz0cNJx7h7aHa0Kx5rdtp5moVfm+S3
	5Y0PNLKsHYsbA+MV7Z+fb+SgJqIjaRHkDolEIhyT2KnYgdTEbImN
X-Google-Smtp-Source: AGHT+IFLKIJ8T5RC9P8/uZ8FZkGizTQrrQBxZm4RJgH2uR30HVY5oRcERKtInkYamNv2sQyhKl6Puw==
X-Received: by 2002:a17:903:22c6:b0:1db:d42f:fde9 with SMTP id y6-20020a17090322c600b001dbd42ffde9mr10215831plg.41.1708453186714;
        Tue, 20 Feb 2024 10:19:46 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:455a:b76d:46a7:7189? ([2620:0:1000:8411:455a:b76d:46a7:7189])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001da1fae8a73sm6519834plt.12.2024.02.20.10.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 10:19:46 -0800 (PST)
Message-ID: <f55c36c5-0b8f-4b7a-a0b9-b11320781a4f@acm.org>
Date: Tue, 20 Feb 2024 10:19:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
Content-Language: en-US
To: Rohit Ner <rohitner@google.com>
Cc: Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
 Stanley Chu <stanley.chu@mediatek.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Avri Altman <avri.altman@wdc.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220090805.2886914-1-rohitner@google.com>
 <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
 <CAGt9f=Qd8P4OUuT=KJQqpwJPYVB7zeCJjWn_4CTiXWce6ZRERg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGt9f=Qd8P4OUuT=KJQqpwJPYVB7zeCJjWn_4CTiXWce6ZRERg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 09:58, Rohit Ner wrote:
> Do you propose to remove this callback altogether? This callback should
> either support both transfer modes or none.

The only UFSHCI controller I know of that needs this callback is the Exynos
UFSHCI controller. As far as I know there are Exynos UFSHCI controllers that
support UFSHCI 3.0 but UFSHCI 4.0 Exynos controllers are not yet available.
Standard compliant controllers should not use the .setup_xfer_req() callback.
As you may know invoking that callback means performing an indirect function
call. Indirect function calls are slower than direct calls, especially if
speculative execution  vulnerability security mitigations are enabled.

Bart.

