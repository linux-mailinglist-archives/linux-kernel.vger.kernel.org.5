Return-Path: <linux-kernel+bounces-117897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA7188B10E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E61FA5A04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E5E524D8;
	Mon, 25 Mar 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdVen1LO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62E482EB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397525; cv=none; b=tM6E6oXh4vQSNDehUkTzABQ8eTv/+u3pHWHT6j/iv1JYkIXWwLeJQYerJ/wPwvU3P3feCZNYZc5Fa6lhPVb/jjm+8a3QS05ptgxV+pCxpfmUdPu59YpWVJftgSw9Bj9HubN8zS06hHMoAk4DraNySeP2DmoZJrSVWjwB/j82cqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397525; c=relaxed/simple;
	bh=PxI898NZIU+tG81gqoZRmwgGkW51J9UnnR1S6B1Kv/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdxssUGTABmCWYXp32yKnn5vhIwFQsSrr1eptErleEbf2sVLZdP6+0de0zI9mEFTJUd6vlFvcTQa5qVqK4DHXI9DN2RMOqvLxQ8ZdilUfxezee5cZmoWzt/sMBUuBsecBH+9fbjq44y2PUXhbUMzdBAUXZ0vTDnlsZrpq8uO3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdVen1LO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1def3340682so38905975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711397524; x=1712002324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkImbuTh/gKGdcy5/eBZH+9wmZ6U6LM9kNnLUBbGZxw=;
        b=bdVen1LObU+OPR+20eSh1yU4f5FTJPHwKahE89SjsqvxYBKkA80yLGDEWKuiFXThbx
         5gHAmofki7rY6JEJLUCWM0I7dx8AE62xqSWmS8BgJhtahmH6m8ycWQsBe+sdyV1gQKSU
         EWnvLhfX99HvPzeptyAC4XeLOMNYYwkZ2hKYXXpSDUEFtPNQehuxxOv3ueaE8pOfYmoh
         DPFqrp0UKRUbSDH0REfg1T9Xsva9SyW9K7Qtuo23AH6zUu4TmjbjduyXYdlRYZ1jgUB4
         6eEwD0bLUylhCna1gENW4YEOww5OL0cC5i+XTWvYpBud1xT2quojrvFGUfNYlcpJtN14
         BsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397524; x=1712002324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkImbuTh/gKGdcy5/eBZH+9wmZ6U6LM9kNnLUBbGZxw=;
        b=E21SzR6uGAwUQKtWBVUa7lgIqskjdDmI5gFdFhBnwNQsWp58pQk4wUt3JKQLgIH14U
         djLAFwBr9TJ+B20BIhSvBtSP4EWI2af5EMVEBpOKNzjWlXslereMn5Lqc7slUsL5WkZT
         mpD+hciLTnvY0ePwAzdyp+iDTjZH73MBPC/UjLfLnBp03rLM77R5aOIe/Isk8yKrsTlB
         wz0dKCmYRjGUZV/4+bM34Eq5q4Tv1MDyrVZz0kcxEXBl+a6nNHBSZmBjnBMYlM/uMCdM
         p2DuCwNpd8ro7XldZowZnpH0cTlLFRXTrxGj+dfn3NJeJpwvEgJCwaW/pN/KDRuf7g7f
         XSYw==
X-Forwarded-Encrypted: i=1; AJvYcCWgTSJ3lkx0TZIfNJ3cPpF9+5cKp4a2XqUq8+qBSBIIvLUI2AZvKmbBcP2JLilBn8RfRLyRXuoFZTZXdFamjcb+tdVQmxnyn67WjIyn
X-Gm-Message-State: AOJu0Yw14FbHKqTt5XOc7KqWOZTJJx+4mH+fhSnznA08SIFbOwAA8aai
	7V5xRH+BRQH/lNjnR8T3T0HdATlMGNZ12kuABMvO5gMa5XQ9UVI5
X-Google-Smtp-Source: AGHT+IGcjRwV5fR2bsBI7GyCbjXqYFyCieW2x0BxZX35vtqvA+tIC23MmxdaZSMebTswxPpVP/8KrQ==
X-Received: by 2002:a17:902:ce91:b0:1e0:b5ee:eee9 with SMTP id f17-20020a170902ce9100b001e0b5eeeee9mr5813496plg.6.1711397523605;
        Mon, 25 Mar 2024 13:12:03 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001e0a612ab8asm4889633plg.295.2024.03.25.13.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:12:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 10:12:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: remove unnecessary import and function in
 wq_monitor.py
Message-ID: <ZgHakfp_zqelT28s@slm.duckdns.org>
References: <20240321150420.37648-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321150420.37648-1-shikemeng@huaweicloud.com>

On Thu, Mar 21, 2024 at 11:04:20PM +0800, Kemeng Shi wrote:
> Remove unnecessary import and function in wq_monitor.py
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Applied to wq/for-6.10.

Thanks.

-- 
tejun

