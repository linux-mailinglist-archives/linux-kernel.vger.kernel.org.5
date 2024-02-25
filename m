Return-Path: <linux-kernel+bounces-80179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F55862B5D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522B9B217C6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1FC175A5;
	Sun, 25 Feb 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WymMGjSi"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387414280;
	Sun, 25 Feb 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708876727; cv=none; b=GnQSYtE6i2rledHEgxkq8u4D6pQZaER4ufhLBWodAIxDJowFJjbxGMAIo9Xi2Ar3asduNAhC+mb6ZOfoLK2PTcYpnjmL1DVIHMZJi1Uc8nhvva3RldawmoRnhGK8gSnJJ/LnCQ27yuF+EECtxAC6mcKG69qXiQsUQ6tpLyjUSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708876727; c=relaxed/simple;
	bh=oWPwKUfFaUKDvLe8z6kb5kll3d3LDHDHamj9jCZzWf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4Rhj6/jINreWFGDbt3Q8Q8+Ca1ukwRjzAxihFUvrguJ/we28dOjE2EXkFpOsKYNCAA+KBJms/4cJfoCR7777yf5cezChCRkd4NDbACFShgH7IkIpi1bbzEzgfmYro3GvEYJ1KV9xcpJP2wvcgwqOcVzH1z/4IN/Gs4CLcAv4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WymMGjSi; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21fdf31a154so651032fac.3;
        Sun, 25 Feb 2024 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708876725; x=1709481525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idPAAJ96XdV4kQvBDm67FrrO1sdpsDxXupC8T/KxzXY=;
        b=WymMGjSiwOyYc+W8UEWbRf8Ty0TWjteLlRsUIq6AAe/tXyOwEtJcKjnBXxflsvhpXq
         L4s0qdQqHxGywzUPcTgOLwEFMJ2faf2Gw73JqqYeNvObQnR8t65kucYEclIiqNbsU3WB
         10ptyMwY3h3SrgTkEbkSNAbXnMj4kv25P9zu7CU1xa2jXz5WlEl8OBIGev74dqXMxBRy
         L7Moh3BTxjVoKrpR5GLOYBBBZvMDsiTqyrZAygXrMDyKPjGMhMkG6rxH9ov3uYK85T8J
         Fl9JyNywpOf4aQRBJpSxSqOh1rqvBer6ymy/vqQJUpi10THB136t6jv8/yUyypXyqejh
         vl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708876725; x=1709481525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idPAAJ96XdV4kQvBDm67FrrO1sdpsDxXupC8T/KxzXY=;
        b=r/x3mHRsdkym390h01i1xUa1xWQheJtGS8V8m0PSyZezyKA1SNa+PZ2t4lHSbVRI8L
         nyanO9G1JbCNLQNzhy7BX9FCJgPR5/0u1WyuVNcXpE7txCZ0k/F7odpGtk2TeUcsSg/V
         yof3s2FaCludF6Keusz+tXZmJ9HdDMaLqg1ybXzzt4JLkVxXv0umPZw5GrjvnJOqFAx6
         MVcmt3qYBY+an9WLdn5dpg+aDK3vuYPnUsYBN6rAnxCP16RExrOe5tNIdZNVov3yG4Wn
         DlHYts/OgUbjzf+d2IbLok6Bl16xUiO3Mg+ChGXCyjWgw1/jvTR5qgxYsMcz1pyauitv
         g58g==
X-Forwarded-Encrypted: i=1; AJvYcCWzSbr0J7a0BNgir15jnjayTXLBYEL219DUqsvzRCQcEqi9U+YNrmeqDNSqSAkf/niej1SXlCqI/cpxVqwClN7uzt0etc9cBvj+mPhUCXDx549gr8mr3BXgJaSGCXyyIau1JNn3
X-Gm-Message-State: AOJu0YynTrsttKIFt0pWEF/TK0VaJHXm9VuWCUVHB5WKz953AFk3MbkL
	VuxvdqU/+K3WHUgeSVpQsr0oQ3KyLx+z5gaYjzITdX0dV4Jv8I6hWeoUP9yy
X-Google-Smtp-Source: AGHT+IHG6YNLTj/YF9EppSR8plKWQXM3ymd76N7wy9J7i7mq3+f6Ljk9ryZxtjo1bfNt3q9zrvVCYw==
X-Received: by 2002:a05:6870:c6aa:b0:21e:e583:25e1 with SMTP id cv42-20020a056870c6aa00b0021ee58325e1mr6105925oab.32.1708876724618;
        Sun, 25 Feb 2024 07:58:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2-20020aa78882000000b006e47ab9b2e5sm2445339pfe.215.2024.02.25.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:58:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 25 Feb 2024 07:58:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Message-ID: <56565259-906b-490c-8543-5009e0a555d8@roeck-us.net>
References: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>

On Fri, Feb 23, 2024 at 11:41:52AM +0100, Christophe Leroy wrote:
> Commit b38460bc463c ("kunit: Fix checksum tests on big endian CPUs")
> fixed endianness issues with kunit checksum tests, but then
> commit 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and
> ip_fast_csum") introduced new issues on big endian CPUs. Those issues
> are once again reflected by the warnings reported by sparse.
> 
> So, fix them with the same approach, perform proper conversion in
> order to support both little and big endian CPUs. Once the conversions
> are properly done and the right types used, the sparse warnings are
> cleared as well.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Tested-by: Guenter Roeck <linux@roeck-us.net>

