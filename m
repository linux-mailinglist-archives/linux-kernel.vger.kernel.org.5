Return-Path: <linux-kernel+bounces-60438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1358504F0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB731F23148
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF265BAE0;
	Sat, 10 Feb 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzNCnSdl"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB836AF0
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578968; cv=none; b=pjCtzxBtB55Vqr4SdMfpdjscME0zVrjQCr2ZzjWRnwcsEMR7snHxDEa12qjAmZQd1M+pyEsC6zmet8oaeQa11XukCAv5lU3qIOJnx7NHOByOoXcVkI9IlhH6aVSMheXxeTt0yNXC6YHXnXSpUQv9dOb3fHcrA3XqYKvde3aXSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578968; c=relaxed/simple;
	bh=lJApX2EBAcNh34LWwrUaPax+BM9BG9Wp0v2CJOLi4BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEnTB2SdD83gi29hbyNwm54TYfxgQ/9fAKsyoxRwf8ZcV4dqzJQ6BjpSAT93bXsnHGsHUYx6PkW3knvcXjJah3dNFV/Ta3ZibQygskURuLc7cH43QfQVSovwfWfGLlBcca7Mxyr7vzUJth3cK03CsysdonMVe+1U/69Ir11TSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzNCnSdl; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bba50cd318so1408452b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707578965; x=1708183765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+ZbG51dE6UVc7hzzIUXGXIlf8j/Yb+04IIzEUmAJ+Y=;
        b=AzNCnSdlLqN4W16TGbOTum4svcz8ysI7XMrvtUdB2QhyX2+wE5Jd0axicDsX2U3bK+
         D0gt+tMgZbAzBiZqHn6foFpUwaB+awiUMxq9ii65+oN28HyZ7hRQ3+ENVAjB4APaE//Y
         mu771TaSY7Ju82esH4jZQHFolD7hs5jG3XCokYvOYrYsqqUHvLi4JTeoSkHUudmsvatk
         6kH5Hv8VUp4UeiXIYS+mqHgawm+w5OmnRq0PB+iC3bW/8SnfQndAX2BTh4JX+l9zeAAI
         MWobvYLp2tMvEMjX8Mai4IQ6KQAon+uMrMmHuoVuuUP6pmPSsh+hslDETMs7zRou8+Wh
         gINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578965; x=1708183765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+ZbG51dE6UVc7hzzIUXGXIlf8j/Yb+04IIzEUmAJ+Y=;
        b=j6fSbNVsTnZSxzcWHJgPpXzTObctu0F2G9naUnXROyXm6Up9wxUls1Uwkh7gR86/Cf
         cnYQyEfHoWNRlpcDu5jlIpuszVr6vklRyyOzSwpPwPkOJj4XT1GVSLgViRjNeOG+se/O
         3mERXmbUk+Zi9YRLYifIsd86/LoNW7mwJon+Ux7dU3ShHoKFn16mJwK+3fb5M4iQgARt
         2GwIujkv8BTtffDXF/xyMhe6ExDvppG3/rCsdBcbNx1WDpMy660ArTLqntRgVhfISvUx
         fmtSKBjHANjvKOf3Yq4gGDRXOohnEY5bI5AktEn+l+w0zu3pytZW8u0Dn8NtrqSiIF+y
         SDwA==
X-Forwarded-Encrypted: i=1; AJvYcCVUqbS5UM2GCs7BoHwxMa6WPMsLpsBnRywyeYkgUGefNNzTVI3HTCC4gxEMyrU+y7OJVZemXsT/vkLCJYTXH3GWwbHQjyIo/SzycPkL
X-Gm-Message-State: AOJu0Ywe+bBOxMizvSvxnvtygag9ixI5JU7D2grlOfZN3nwYQsSbiMov
	MA3jGPbnX0Bls3q15IW+4VmSY1K7xBUBTaAMW2y0csziC0iqisbR
X-Google-Smtp-Source: AGHT+IGqbJYFgbLuFIwRZhe4bxE0vofbALM0acYfOPamrEqA2AXOaPJMq+11wP41/sQmVpjH7Z4gsQ==
X-Received: by 2002:a05:6808:14d3:b0:3c0:2c0c:306 with SMTP id f19-20020a05680814d300b003c02c0c0306mr2472818oiw.0.1707578965484;
        Sat, 10 Feb 2024 07:29:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxk9m/zPRB4fDCKO8wso0ghzmTaleDwDzmgLTbUZQCa54Ht/q8hjFmPHQuWD6InvjeQ9VJVQs+3by8COedXnz1rGnpEPyxqejDAPW/mFs+LGYkUe5WyIIe2Zc8EFumdgKBqzbVdTMy5KDsYUZ+NIVsjz+V1Fnb40kwxDj1zt38A7SPDDvBxRC3azgAEDvHavGG/sTvKhFmtHry1sSfDx/8HmOIhJeBdh2SuHqpa7BLt+fcv0jTVYQEPd9BdFYGtAVvGZcCsJvppdrEqiJA3N3DqA7d2C95hFfL+9YNZ7mtpow=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k70-20020a633d49000000b005cf450e91d2sm3716793pga.52.2024.02.10.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:29:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 10 Feb 2024 07:29:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Edward Lo <loyuantsung@gmail.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>, ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs3: avoid an unused variable warning
Message-ID: <a47e652b-120f-4147-9163-cdef251616d1@roeck-us.net>
References: <20240202125101.986302-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202125101.986302-1-arnd@kernel.org>

On Fri, Feb 02, 2024 at 01:50:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A newly introduced variable is only referenced in an #ifdef:
> 
> fs/ntfs3/frecord.c: In function 'ni_read_frame':
> fs/ntfs3/frecord.c:2460:16: error: unused variable 'i_size' [-Werror=unused-variable]
> 
> Move it into the same conditional block.
> 
> Fixes: 4fd6c08a16d7 ("fs/ntfs3: Use i_size_read and i_size_write")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

