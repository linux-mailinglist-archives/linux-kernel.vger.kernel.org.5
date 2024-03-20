Return-Path: <linux-kernel+bounces-108438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B4880A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF38B22167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7E14A8F;
	Wed, 20 Mar 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuLHqj6W"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAC11CA0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710911302; cv=none; b=dAc1/FnIufXGYOsLc6LonbpnmTypjcrW08CSF+bt4izOrm8izjEOq1D2OzWzN1dag3sJOZ/xsZlm+mg9nA6F22rAX7IgbVBrR6ZUyB6/9oHfJOaXyY0UsvnpswcQv3UPYs4vhsp3soGGlL/b+pv6raarUaJpaKG9lb+LWBBHbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710911302; c=relaxed/simple;
	bh=A1dK1FDTClBBeiIDvehBrkcgKHtbJHgy2lmHel3n8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBF2YDOje21/W9mGEzLFQHj+itS7h8rq3sJVUuvaW1ypVvsgeI8U0UZgVAiYc/k2KOB84iPjgyEUoGxv/bg0Hq8YIm7kEw6B35R3wJaTRY9fMDFKRz71AFSAL4B1Nn9MV4KLe2CF4JM8x4Zxd84phW0BKE6DLN5yPyZv6ohgzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuLHqj6W; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d094bc2244so85689301fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710911299; x=1711516099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDbezmp48NlomGRK//vO3jPNjuF0l+ROTMlkX7vEssc=;
        b=DuLHqj6W1YbmyNs1g15iazEbCojzBV07d6eorjVbB/ca8Oc+Ju8bQj65li77j/8VKu
         TrFotgday53zih+GRo0bq5746Y18XKfT9GEmD+pdu0yDsZtvNE0kFNsOXJwC1Osx16kL
         FS3oVZbYuOuPtAq52ljQff4SHpA0QyYW7VnJtDR9aE3jnDuPBBeB0PK/hy15hZY00zzB
         k449PxsDSXW2WYwgAUQlWo5USKzinkUB2UXqv1n3bCWfWcPu9nVX6lXAvlgOryqStodX
         PecJ3cn0A//6c2inmfc309ng70/57weJoOqRl6tUqXW7q4Fj8r4+N7PJ6+JaVz9qyY5g
         lsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710911299; x=1711516099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDbezmp48NlomGRK//vO3jPNjuF0l+ROTMlkX7vEssc=;
        b=slfDpkVcYQDEDeztasGrWtlR8f3ZLGlTDzWPKvJUw67Qd34iOJiXM2iMvVcbXksc9M
         KqwfmHptl+WN8tWV93Rz0H9BgTTUrOjp92TJ9Rcf9wnBejd8FIsYTV8Z8su0ot0wqxnz
         xh4Edmi1Ev+r/ATqYGSYysUkyQBQKvU92eCtxBOg1aC8ulz1R54wbdd0tZ3qF4SqYHiW
         a8v6Mt77gDzCJJc2POoK1iG/pfWXB5+48v2gIz78hKqBdhs2ffg81leKd47e/vD8nvTg
         Xxc6+QieSGx6IHlq+MpW5nfUD0FBmby4Dv2Cylq+WMAM+s91MeJ+fDJnMdKtG+gkxEh8
         b7/g==
X-Forwarded-Encrypted: i=1; AJvYcCV73KaKPZ5Se4ak0idneRgl1X7lKLBwCBZS9EmNPCemrJWYiY7/xuyyiqhp+AfRZWPTMJB4JrD9vMs5Qnpg92OwTU9jR5/BDwl79vGe
X-Gm-Message-State: AOJu0YwK466VFdAcvb80DrqGbZpl96DsKvnJsARlbZ97NTNfJV1ZWKqu
	aBQwi/fhUA8IvfoISP3UnOeG0T3+rJlcwSKTLIfSRLJBYfHvFW6CFvZHUPqjqII=
X-Google-Smtp-Source: AGHT+IFHREE/lnhx8SjTOBAgPbDyrtU66YBCV4semN7SKN8NIdNLbGqeziR344GPCdUdj1AZEkyvFQ==
X-Received: by 2002:a2e:a724:0:b0:2d5:9703:263c with SMTP id s36-20020a2ea724000000b002d59703263cmr2766745lje.4.1710911299145;
        Tue, 19 Mar 2024 22:08:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b0041409d4841dsm912164wmq.33.2024.03.19.22.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 22:08:18 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:08:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
References: <20240319181735.366565-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319181735.366565-1-chandrapratap3519@gmail.com>

On Tue, Mar 19, 2024 at 11:47:35PM +0530, Chandra Pratap wrote:
> Replace '(foo != NULL)' with '(foo)' and 'x != 0'
> with 'x' to adhere to the coding standards.
> 

In your commit message use "opt" and "*opt" instead of "foo" and "x".

Removing the != NULL is fine, but the *opt != 0 should be changed to
(*opt != '\0').  There are times where comparing against zero helps
readability.  I wrote a blog about this, but I had forgotten the case
with the NUL terminator...

https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

regards,
dan carpenter


