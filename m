Return-Path: <linux-kernel+bounces-68972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D98582D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B502E282D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C512FF9D;
	Fri, 16 Feb 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjg3FXyj"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52412FF94
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101747; cv=none; b=IqNAQRa8Hjy4HcvQjhGXF+x4FdlW3kw6I3yZ5niF7584ug+UoVvxU66yckTSF/9ePMU/vr1JQ0D3VRUOOFYogY6pFPkzLku2tOV46sisVLOwHh3mY2mJk66QVcZf46iIJA1jCQ5MHZ8TNRcs+KHro4GM7OGoSJKCUCCDiu493WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101747; c=relaxed/simple;
	bh=kJA9SvSQtKhopxNvSYgX57KRG5gHICyTanoDq+usWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqnJWFa8UTSxPLgVyw3hrd/oZ64PQqAnab5dj+/jMeMYkdsoSFZ8UMYpqkDfMeUZolpC0gAdVRApI1L7/L9kpOCdLZ0ojJ2c0mQy+VJ2Pi5DpwWgKNJzqvS0zZ7DPdtINJOq/sBgQ7VA1VZ+/ha4hZDygnCkN9Ya2TxmBMKiPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bjg3FXyj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e08dd0c7eeso1452238b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708101745; x=1708706545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q/nDGaqIOSjwzp1dEq84CPrfaDhq/hb8XMiVVV5kLQ=;
        b=Bjg3FXyj91lRwoZzSgRhKMhz87ZKOXa6S1cnxgpnbNXWFdyrSPvdsD6i7759k1xsp2
         ic4v0d4dnY+lk8nRXhbKuvxb5qkIk+uhwwTQgv7GFOGOaD8fWpZ81RmeRoE2ff0XWGW4
         ebuTKEFaJNEpUA2/gIk3lQRPIk3tNdYEHHiVgxrEYYCwcHUUYNLEz24fbZZcH1e55vY/
         2lGtZv+HdM0FLa0N9CqNU9uW84XBSlxN9tSvFxOZ6b3rTnQpAd2hSGVwtX0BZuT67lYH
         sX9pl3g9vzzoFGgLZHnv5+M2/bNqH8Hn/jAjfZrwHo58c0kb3+LaWPGUBuDs8l1aZaBA
         osbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708101745; x=1708706545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q/nDGaqIOSjwzp1dEq84CPrfaDhq/hb8XMiVVV5kLQ=;
        b=HLhP/DnXxw/cAXEV01xGBW39KMTbqtkeVGyMtqQiyJiB9KUplEy41n7WenNv26TIq0
         +ZhBQQCfOnipK0rBz6FvefCoygOCiKu+74TNswe8wUMGK2x3tILwBkZOVVQ52oZ9s+AZ
         qug68ww1xBoWyS0ozRUxhpBboiWDkKbmR6EAsyr/2QAJjdYDXRc6eAmj44x7o+QF+P8T
         44Fnp+YMI5n+pLiP6goJR37cluliJZd8YftWARzwRSYDu7A4eGvUFvxvgT4KIZyXnv+p
         32w9QChN2knC3f2uwwZm+V1jPmS0NWG7I7c6JM6mCU5Zs8MMU8eTmLrStHXj7jw5ihES
         /gKg==
X-Forwarded-Encrypted: i=1; AJvYcCXhOGqNq8qU3aafHAIOYjmjS2J9MsRtkzo8Vih8HVZx0HDbgJ/qUiGFrxkzyhyx+htp79Q7fYdG+0lMFA0/t13BjWjlv/nGQltDFjGr
X-Gm-Message-State: AOJu0YwPYtiKRI62/I8FhieAcVYM6TGAEjVocpT56jViS1jvUzKgpb6f
	sSKJw7DFQ9jjMCc3RfJ1doEicu+GybUjxwsDc0vRixMheEZs2qmyfVY1Ydsrij0=
X-Google-Smtp-Source: AGHT+IFGMjsHchyMVqnJAk1qDQYvlXYfoffag15IxuJsiPRNeIA05kfnzwQudcccPSO8y8lITEChIw==
X-Received: by 2002:a05:6a00:2fd3:b0:6e0:94b8:cdf2 with SMTP id fn19-20020a056a002fd300b006e094b8cdf2mr4689688pfb.33.1708101744917;
        Fri, 16 Feb 2024 08:42:24 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id ln14-20020a056a003cce00b006e09ec7bdb6sm150144pfb.193.2024.02.16.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:42:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 16 Feb 2024 06:42:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_work: allow building non-SMP again
Message-ID: <Zc-Qbco0lKtiwJl0@slm.duckdns.org>
References: <20240216163535.1997122-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216163535.1997122-1-arnd@kernel.org>

Hello, Arnd.

On Fri, Feb 16, 2024 at 05:35:07PM +0100, Arnd Bergmann wrote:
> I assume this has already been reported by others, but I didn't immediately
> see another patch for it.

Oh, I just replaced the broken one with the following:

 https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/commit/?h=for-6.9&id=fd0a68a2337b79a7bd4dad5e7d9dc726828527af

Sorry about the hassle. Thanks.

-- 
tejun

