Return-Path: <linux-kernel+bounces-85530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94D86B71C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237EB1F239DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003924085D;
	Wed, 28 Feb 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L54GeCTc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD84A40846
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144675; cv=none; b=GRD41v7s+hjbnpceVvqntuM0+KZ0YJuQYsNwy3x3t5BUI9PFEd7XNtFmazDPniafCiaYevlBdVdFiuKFiwNVbQtpZRoUJuoASj6RPqJgA70r3gGTF6EkM70mNyfaI7lw9OfLV4go+tcK/f8l7aZMUv29rqVIKUDxFbqpUFNk3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144675; c=relaxed/simple;
	bh=KLVHgL9DGtOA1LZ4QpgI7es0AHDvgKX2wiD5ghdJhTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRmf3ygE2i4tIuLeHI01KVVU9j6ujDPuApjC5PY6TT7Bl/ll+wkP5bIKQrq5wsJqhBMhMZm5prBV3648fldw3jvu02BHtbFhBfSmCBjqXulL6bBYjhsXOTB4a2iqznLeU84Qzr089SnQ2/dvCVHBtUekzCvd4LciQWKn0PJjvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L54GeCTc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db6e0996ceso738015ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709144673; x=1709749473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3weX12Jydvw2iQSNrmeDVigxrB3bIIY4H0E1E8jahR8=;
        b=L54GeCTcj328PzK+aQLR0zwNXV/WhIGYYLpJk7/USx7/8N6kVYlX3ycYN3MO7HvG2o
         O0ftuVGFK/yv5abtMbdeiQdOwpKGMMLhq727umvr+kyIFidzU9DwM9JiYcwozoVy0rYu
         PwnRGiPyXJWYEIa7j3L72KZl1dME8h7KnOAFLnVq3tayX9gKYj0LpgDgSQNyyIeUJgvK
         b8y0l8RxCjOUQWgWjH7lhIJgWP6W5kQgL7H6om1NQSbNgYzTwVB0e8Th0ihSwasdkYNw
         OIDsCMCXq9EgC7ioUJmQ4FZOLkCUivOcb4E8nG6zj3ZVkDcClCYUmiEXp1KG+flgE/QQ
         vi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144673; x=1709749473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3weX12Jydvw2iQSNrmeDVigxrB3bIIY4H0E1E8jahR8=;
        b=se9lIVP3uAyBNqVdSLw4Lm+QRMO2juh8fBpgiESh6Cr/XrxA70hcxPtiUuNF6S1ehR
         hG8XWUazZrHRFy42rTbboP+eenyjvwIanNM8YjaYvnB5sAVPNj3k0PeAKfaM7Yw18Lzk
         EVRkygwxxMXo8nt87AvHbkOWrE6za7BVZWc+BgZph5sV/vID+l7LwhZvrWF0Q911n0lR
         Xw9usd68FWFxDmk1ATtLcA5lWOLCzW5Ljx3dD128ZVU3IjkLYDJRNQGOsbYzzCIrv3/2
         uEfEBVaTCSBOaJY/ThJ1KBe84qZIVA+UqA3HINSvJ8G5oTy96QNzlbxw9TBx7exQkWHW
         Vz1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhcpRNFVPtIgumxhi/8RGt2u+IeOcOVLuIIZBdjyBdMdjdmngtM5JPKzhFYGmyfqQU/Up9jqDXL6Wdeam0zbr9/iEg0c4oBGlflFjq
X-Gm-Message-State: AOJu0YxiX+g9ESAqvYY+CVkpx/8ZW+bQ9FQoRhtIEaCRT6Hl98Qh6M3x
	80BsrPulk7fkkDAJhbtSLnUSAfO4GW+/GThsPdYYqgrhYf4th9YV
X-Google-Smtp-Source: AGHT+IGW2OqPR1EvjMKlgMtFjg9ZEauoXZciwBOxhwvs7vPMNYZ58qmGIHR9sJXpXeUOxcYRJgdn1Q==
X-Received: by 2002:a17:903:98b:b0:1dc:af71:29fc with SMTP id mb11-20020a170903098b00b001dcaf7129fcmr358384plb.6.1709144673126;
        Wed, 28 Feb 2024 10:24:33 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id kn11-20020a170903078b00b001d6f29c12f7sm3597240plb.135.2024.02.28.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:24:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 28 Feb 2024 08:24:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience
 function
Message-ID: <Zd96XzRHI_jMOCip@slm.duckdns.org>
References: <20240228181850.5895-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228181850.5895-1-apais@linux.microsoft.com>

On Wed, Feb 28, 2024 at 06:18:50PM +0000, Allen Pais wrote:
> The enable_and_queue_work() function is introduced to streamline
> the process of enabling and queuing a work item on a specific
> workqueue. This function combines the functionalities of
> enable_work() and queue_work() in a single call, providing a
> concise and convenient API for enabling and queuing work items.
> 
> The function accepts a target workqueue and a work item as parameters.
> It first attempts to enable the work item using enable_work(). If the
> enable operation is successful, the work item is then queued on the
> specified workqueue using queue_work(). The function returns true if
> the work item was successfully enabled and queued, and false otherwise.
> 
> This addition aims to enhance code readability and maintainability by
> providing a unified interface for the common use case of enabling and
> queuing work items on a workqueue.
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

I'll apply this together with the rest of the series once v6.10-rc1 opens.

Thanks.

-- 
tejun

