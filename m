Return-Path: <linux-kernel+bounces-105797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D711487E4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B42F28200B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2324B21;
	Mon, 18 Mar 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="t0Et7gEh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54D24205
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748981; cv=none; b=R8tk8LMHB264rGLVXyIBBmNn4/vnE2G6Qasqrn3A4ZBMPgw8oDpYJ5FMmKvxKCAg0ezyTgsI7TKrbOyZAOaebjOlQYY/HrIP0h4Qv0krYy6B3f8DCYEMD6kbvAFP5EyEnsYCE2lI+9Td7+7abPb/1hfQ8BlLy5WjmEtsxjirkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748981; c=relaxed/simple;
	bh=XqaEr8+5PbPTo9cFExJMuDm6EYQQTHY+jja90dnLCDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsQwHa4wjaD7bLlEf9Ny7xQlEQdFXVjw15b1ilOGOzsbgiIOLNoEPxYl3JFm5EzHYAZAfIrV1k+ErW0Zq4/NyRA01BwSQ3GGEbyP3MD1z5A+R/xFc8GPrM3VKONPmR3XXmFTab+x2PyrcAQIoxbLfeplaUDJWcLK0xu4bZCHMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=t0Et7gEh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4141156f245so3112955e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710748978; x=1711353778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWOqW0YebhNynLRnswRT+iDOKo43sLSNLgQuiEyKwZk=;
        b=t0Et7gEhTCw5IKP6p97Ixw9v2Voosz/NUSTnlffg8a4R+3Ju6HQTzjHY48mEu6Tm29
         xQrfTGimSNdBN02F9rQpNzuACS7w3RnQ5SQdZxI0EpqRQ+dKS69trtHMwTk0w987blie
         7oL6FEXIWbER93zVucakITLIYgz4WnnI8Yn8SHFd5uY9v6IkhtMzJqlhXaiYlXbNXGCk
         SdJW9WNrSXKwrKNgAjGwhpsZaMXZDc6Z48+r5LeQBZo0zOyWMmYDKiFZ4TnI3O6wR1Bf
         KKXFO6YTtbQDzdWj+yoXuq4R3XsbMnb0MKNq/nQtZ44PJp8Utyu453hz9LPjFD/ZXCR7
         0VIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748978; x=1711353778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWOqW0YebhNynLRnswRT+iDOKo43sLSNLgQuiEyKwZk=;
        b=Llq1euVyY5nbbT2AYZ8kwe63tlmb96XXFo/QgdEeYJHhr1gSqh6lRB2zkgib7bv4S9
         bJjX78eIz4aCE17qUVmB6FHfcZ3vpyNAp0qZk4MsCwWCdfaoLpjklGWXoNGrjLayX+IF
         z4eDY41yn5zVHjqJ8J7/JZanSY6BHzniQnzMZScFcr9yCvFyHPURU8ez9ko4VLrJfu5R
         nkiHWhexsBidJCi64tGYprTFGUo1TV+N0ejJGBUj1yWnPmk/phSby+uZUzVCyA+W9UZi
         7Ddmy85DO8KPHp3UNg2rUffeBv9JdNbbRfp/BY35OnGAbrk9s94RATIe9Dtxj0KHZqV4
         U7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQXtURSbixxoawaOy1Rt7zRnNfwyr0x/snqf/jZFAt975G/atgRcAmDPtrj+fdpWo2QAPzhXalvTOgZMlTNcA3Qf6LU/5EM4d3d2ID
X-Gm-Message-State: AOJu0YxGLX9jc2ol7oQBxm88hw6Cid4ljULva9qlqa41jrVtsFGs4/Ex
	CiW7gLqapiabhUUmNNRoALfAXoqxyoQwEpK9fuN7w8DrogsaTAaC34k0KySTctc=
X-Google-Smtp-Source: AGHT+IELaoCPUiTYZCUp5adT9hoE5Zvai+v/TXPvdYYIzf6YUyfkJyj5svseORCTf+1fmlB5N5IEiA==
X-Received: by 2002:a05:600c:1c84:b0:412:e70a:ab8a with SMTP id k4-20020a05600c1c8400b00412e70aab8amr8103345wms.25.1710748977943;
        Mon, 18 Mar 2024 01:02:57 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id by1-20020a056000098100b0033e18421618sm5582669wrb.17.2024.03.18.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 01:02:57 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:02:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <Zff1Liloe7DwW7Fh@nanopsycho>
References: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>

Sat, Mar 16, 2024 at 10:46:03AM CET, dan.carpenter@linaro.org wrote:
>The nh_grp_hw_stats_update() function doesn't always set "hw_stats_used"
>so it could be used without being initialized.  Set it to false.
>
>Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>---
> net/ipv4/nexthop.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>index 74928a9d1aa4..c25bfdf4e25f 100644
>--- a/net/ipv4/nexthop.c
>+++ b/net/ipv4/nexthop.c
>@@ -824,8 +824,8 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
> 				  u32 op_flags)
> {
> 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
>+	bool hw_stats_used = false;
> 	struct nlattr *nest;
>-	bool hw_stats_used;


Probably better to set this in one place and have:
       if (nexthop_notifiers_is_empty(net)) {
	       *hw_stats_used = false;
               return 0;
       }
in nh_grp_hw_stats_update().




> 	int err;
> 	int i;
> 
>-- 
>2.43.0
>
>

