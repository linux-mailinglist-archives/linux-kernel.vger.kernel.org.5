Return-Path: <linux-kernel+bounces-139700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66C8A06A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63777B22A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADB13BACA;
	Thu, 11 Apr 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WagXy3eb"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D362144;
	Thu, 11 Apr 2024 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805723; cv=none; b=VP6gVt+omDaUiIhXgefO5l9hR2eRvmU3dr8x7nXAwifS9OrQ5iKPArhFRn0x9rLSP13kCe/gTJx56cL1uMgf2xFcDzjCpTzyHPBkgA7F/QEGQX1Ojhkanv+rHEh8lSJ/jF1/Xymc69kVK1/oVDAp9k6bwKJpWcPEQnc4OVj8fPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805723; c=relaxed/simple;
	bh=cAuONMPJwvJSt5auTmdKZNE+w54IfNSEqALKtSe4XRk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T6EcgdFyOyL4XDvuV3pGPDevz+ZprwAT7dgZmrgTJzEku++2NEaEuNfVHm3fT11GKyxIpYS6HLx2eHlG+EpTPc4dRO/fuHDVABLex0hcY9s6nQbmNj01W6hNRZNN+HtrLhngdaEE2HBG9McsZgG7W9cpQaHXIfIr1oqSrF0wztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WagXy3eb; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d620408f8so269230685a.3;
        Wed, 10 Apr 2024 20:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712805721; x=1713410521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWMwAJNawsLnqu9wc+hDyG54i8DosmTB85miYXMTJyg=;
        b=WagXy3eb/TBFZbYLIaiwBM+DnOGIOFCUtgwBOLspupE9GJMW8yZLRYU7Chw/18FDzQ
         OJttYnPJLvaaBqbH607YMJXmiKCXyyY2o7whfZNfFF5bnE++nIyI7/ImHYVkGgFSl0e5
         BJcLc1oNEo29q9AsrNlmV3dnKU05/o6N6IVQLJdtlQiehti3rl422LPBVD6CRMd0RX74
         f05/3NZ07/TkwySAHXTvEcxW8rNAGd/OLEn9p9OXchCguyV4E6hSX8EvGIbQdSRC8wvh
         XpZloEGB90ls/eRe4yc+1HXV7C7w+MNP7lRaA0793uHRfZ+cCYhqR8E/BnJKbxAk14ZU
         Gfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712805721; x=1713410521;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWMwAJNawsLnqu9wc+hDyG54i8DosmTB85miYXMTJyg=;
        b=B1o0t2u+U6zyYMDMA9oYKPNXjnCI5z4PhR44OPDVKQ/bMXYbu/zJSiYRCKih9wzmS6
         gvjmJs5ZQWql+p4+bxnrnrw+1JM0AaBOaCSwpmDbTmOy+dIXR83pmMqOss2v/h8JrBzx
         7qJOvddyU06sf/FvRykZn/Z549Ng6QpqFAPBCLpAasmu0YRipfem9UTbnASt3skYaN/Q
         MM137X25GFdSv0el9mrgQtgPvYbnT4s3F9ZQRGwmpYoL97Uo4AAMY1Qwjx0n87KvyNOx
         RpY0DXNEOPbBTQDHgxI7QNuqZbpMzHXN3fN0Gh2XQzw9EwP0us6Hdjqa5j8fUnFVmowx
         8wIA==
X-Forwarded-Encrypted: i=1; AJvYcCXyf+jBFR27EL8MmR2kqALRbOgfgiH+oTcMux+xNHvO1zHGP5jhrf8In1HJzSWar3N6a/Gtgl5VW6sRlN5/bcpm8vqzE7k6gNYEtNm8
X-Gm-Message-State: AOJu0YyNdCr87qg1rQJvR0ZvKeJZv43U4AMKkD1S3n+vhkKtfIfK7do6
	CsIvW4IHLts5OdDIxGqCV1o25BdZq3tMrFeUTO1TPQylUcCbirz2
X-Google-Smtp-Source: AGHT+IGOpjPeJEDhPzWELzM4UM3RmciG1mSgB0feBaLqVTsLT94BZtheKVLp8xwSVPwoYwsNUvPUeg==
X-Received: by 2002:a05:6214:f6e:b0:69b:192b:58e4 with SMTP id iy14-20020a0562140f6e00b0069b192b58e4mr5055684qvb.57.1712805721250;
        Wed, 10 Apr 2024 20:22:01 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id z6-20020a0ce986000000b0069b47a53012sm370941qvn.140.2024.04.10.20.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 20:22:00 -0700 (PDT)
Date: Wed, 10 Apr 2024 23:22:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Junfeng Guo <junfeng.guo@intel.com>, 
 Ziwei Xiao <ziweixiao@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <66175758bab7c_2dcc3c294a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409172602.3284f1c6@kernel.org>
References: <20240408180918.2773238-1-jfraker@google.com>
 <20240409172602.3284f1c6@kernel.org>
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon,  8 Apr 2024 11:09:01 -0700 John Fraker wrote:
> > gve has supported software timestamp generation since its inception,
> > but has not advertised that support via ethtool. This patch correctly
> > advertises that support.
> > 
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Signed-off-by: John Fraker <jfraker@google.com>
> 
> I think it should be a single line diff:
> 
> +	.get_ts_info = ethtool_op_get_ts_info,
> 
> right?

If inserted above .get_link_ksettings that works. The current
ordering is not based on actual struct layout anyway.

Probably all statements should just end in a comma, including a
trailing comma. To avoid these two line changes on each subsequent
change.

The rest of the discussion in this thread is actually quite
unrelated to this patch. Didn't meant to sidetrack that.

