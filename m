Return-Path: <linux-kernel+bounces-105780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01F87E43F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B89B20D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBD22F13;
	Mon, 18 Mar 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4WN0RnI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607962233E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748011; cv=none; b=TTjXozvVCeZgCPBZ6n44RSINTstZ7PekowtqS9ezarlet0R0fByw3LXr5/cNhi0GJPax/6SCN0QZzB/5FsrZkAoNq27k2w7pZgEf3vgTKKKcqM0QwiuaD4XM0vEC94GiCc4hC3LJgXbm5RfhDsUMMeVgUWBI3z8li980+UPFKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748011; c=relaxed/simple;
	bh=UTJYMf+NRe+rvxB+RF4YgiuMYkKlsh1f8OgGGwkdlwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz1wPMSC0uOwnZZOEQVsONg8+fxVAvTijDu6lClQFKFMxLjWB+Qm0Da2vQTnvMu5+2oRHnSoZBnNyPGFAm29C3e7bovm0lqiu/OYUjJwxC/4XizBX2HI/dS+ZdUaz1uU57CEll8qDxvkKEUydeTeQSs2LdUypYYjHRp5UJLk1Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B4WN0RnI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56acd06c016so420636a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710748008; x=1711352808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S8gaPXAtnKdawB9vZ5HJ600QW3oApTxrNP/2KihUaY=;
        b=B4WN0RnI4bwt+NZ4FBA7NrbEOPbTvb6B7cv6+TPMJIkKvdMOyK9Ch0QIWB+5f9n/u8
         ef6Iz+A2t7ONkgAQp/W6xP8rT7n+0mzsCEL0bAosvvo9t7yFIvRuHrv6d7Z3TDi48Fec
         KjboRG5ppBnc963IjkOxJ7xYT7IqiSXsKlpQnEGS1H9LBCKHTKA/BNoqToZND7fvIRI3
         9UasotzvJ3nVQ/1RpptUi8+0KVLbgV40nvnh4V2cLAzqDxZ40wSxeD67YL8tFbqbpnP2
         oi1gU34rFaJgHiw4BfrwHb8g6fIyjTRHb5n1s36Pjrtx/aNrZExgxsK3r0w63yoNIz3d
         T31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748008; x=1711352808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S8gaPXAtnKdawB9vZ5HJ600QW3oApTxrNP/2KihUaY=;
        b=vfc7481Mv4+oQgjSrHDevr+MDIOF3GhqxetiyeVudRlkT3KUcOPpABiepQuWTLmfYN
         KpI82zqM41sx8zNNLkzwEGE+bIrSlCL3xhK33dIVCP3OU+mbhIRt92/7ee+fpUrX44ve
         IKuB5syxa1fAK7a/gWQ132JVMUe3YzYR2RszP8JZq99tXGf8Kam2eHtdvYETEbaNW/J9
         khmtaf2HVh3vu2Kg142On0WnVsXwU+5IqrLFuYXbF9vmb3KYQCZbG28nfEc80Tw2cPv1
         eBNoQ7QnRBvi6udhWkHgv2CwYq4fmQSBEeqbrMHtn371hspfhfmvjjbOk2X07ml7Uein
         Cacg==
X-Forwarded-Encrypted: i=1; AJvYcCWqSNUqybthUAUXNbufN5kQM9FRDpT5uE6HBn7R+NgYw73PsmtJXkRAb81lKBdBn1RkMTXLX0ShiJmD/OLaJ3VDNoEAQIoXLziFuqrC
X-Gm-Message-State: AOJu0YyRVO5j0oEke2+Ec1tIucS3jHXJw4FpYvh7nORl9GWZpgilVD1F
	9UOFag4g6IftGtWBWKbTx/m+ZX8+cvKecwso/76AZ+XR/v6DFCLjajpzYbScMjQ=
X-Google-Smtp-Source: AGHT+IGqDPxJV0DskYtRlE0rM526L4YfePoEYEQmPu+WGA9GEZOFbtgzqJ82dKbHS/Fpr71YqKHykw==
X-Received: by 2002:a05:6402:4581:b0:568:bda1:9630 with SMTP id ig1-20020a056402458100b00568bda19630mr3449092edb.7.1710748007599;
        Mon, 18 Mar 2024 00:46:47 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p4-20020a05640210c400b0056b0af78d80sm431346edu.34.2024.03.18.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:46:47 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:46:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: aggregate conditional statements
Message-ID: <1e45558d-2a89-4cb7-a855-2682b54bbf12@moroto.mountain>
References: <ZfcxGebTKxVUJONY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfcxGebTKxVUJONY@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Sun, Mar 17, 2024 at 11:36:17PM +0530, Ayush Tiwari wrote:
> Aggregate the two conditional statements into one conditional
> statement to reduce code length and simplify the code structure.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

I'm not a fan of this sort of thing.  The new code is fine but the
original code was fine.  If you were going to be taking over the
maintainership of the rtl8712 driver, then you could do whatever you
want.  But if you're just sending drive by patches, then it's just leave
the original code as is.  You might be right.  But it's not worth
debating or even thinking about for more than a second or two.

Someone was complaining about my code recently where I tend to break
things up into separate if statements and they were like "You could
combine them all on one line", and I'm like, "Yeah.  It was that way to
begin with but I was fixing some issues and I deliberately separated it
out for readability."  So that's one life hack which that if you don't
like someone's code style, just find some mistakes and re-write it.

regards,
dan carpenter


