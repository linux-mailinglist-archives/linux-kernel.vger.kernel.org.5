Return-Path: <linux-kernel+bounces-105144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D02D87D9A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20FFB2136C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF562171AD;
	Sat, 16 Mar 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wc6W/u8U"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C2134C4
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710582371; cv=none; b=QwUJ31LXxTqdVyH8xBk9ba6BpXNBQkH4vF+LwOYJAMChRiOjJ7bdVfjeczLkGojfWviIRmFTmRcjLavJvWVNIcQvbAPwl1Iy8X6FCusLDfvy79sB7N761hGda/9+4xzHCM2iId1ec3jsgD6b6AghonBsJiB3sRVpKpyldfQG+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710582371; c=relaxed/simple;
	bh=RT+XZPRzwFZFTgFvITaOrYfXlyrwyyKF/JKHV/iD79g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RhL62fFsr25Ovj0yARffV5ogKgW8m6vkW4C76n6YthxZz5d9MTArd3iOKZjWGkBI/LrgYbmQByrlVvIz/cr2j3zvqxA/PMS//SOZiu17GWvR414f3x6yFKi/RhPUZxEJ3CItNRLA52erLragNhu4GaSbM4neP4OXrtq2bWgfN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wc6W/u8U; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-414023d288cso8748145e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710582368; x=1711187168; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fd/UYSinQFLXB7b7RayERbmP2J/ErjoE+16L+UoVOvU=;
        b=wc6W/u8UuZmXLyU3DULmxVaEGUnQ/O7XY7mEQKquCEfowMBtuK/dUE1RkCyB0WOFc9
         9kud/r5KlFisRzKBY+cpsVAqlPTsYD/NfgdUTEW6E9u55EQhvWPBiW0kL+qKuzStWH7y
         Ecp4MmkG+iIKqDrLhVNeC/BmgoLjxWNeJ5nbOGl/+qDe9jc9WEe3QSVU0gpACmEaCuDw
         Ms5EuEa1FAQRqvBevylhb0/gN3WOz+9x57TsKh5sfUzMO8d4rkWnniNJJESsY7YeO2yS
         CdJD8QADtgHFwzEnswxxT3QKafUBhhiA6W6zz4IgBr7mqrLaoC0xmLa9enaNcaQoU6P7
         mTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710582368; x=1711187168;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd/UYSinQFLXB7b7RayERbmP2J/ErjoE+16L+UoVOvU=;
        b=UDrQi9G/F25rKUogpHrHvgqammugQIYgdO5MWABzsFJTovNa5jnAjCinTcEErxnCHo
         JXxKWjuJmAAvZLhpakC21Zg4e067k3jHmTunkYDkrZmuAYOxOkD1Xa8fNyn9agihc8jf
         +1BXP2+6LJdbV6w/MfKjX13jI1b0VO1kGfalCRRh93V4aRcmM39Jgjkl03b5o/AqrHul
         xD9xF2rqrxGVAVFSeOXb6svQwslu7SUofb0P7G6QQ1KtMt9T6lQVOPns4c63ZRPrrpaL
         dKuVCowQMyS7zz3fU68IOLwvvZB1kYItKAR0zqR6jSkokEbsVKqZBHm12+WMxxDRAO6X
         HTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqKQwbHaKsmGhuLZ4h5HwZLZtadoG1O6G7llzl0YQ8SkmBFpBcDb1bI84F7Y1KKJAgGKP/hH+XUvJ4v+1vXEII3zRgJFNAv9t1Wps0
X-Gm-Message-State: AOJu0YyNTmXMbYKN6o/BCIbOlialFV4yR4/7Vo1d4dA9v6haCfPuFYwr
	Ka6SiGuT/SNkSOpZnGdzVBBXXxu4xDfGi8oNssSG5HkveO7AmecxMMBBXhhsdZo=
X-Google-Smtp-Source: AGHT+IGFOTlS9lxuq3HAgMjbB2h84JYJpY5dbc3qOKbWAN2V/LTfz7RhwItxNXIBOHi/hk1KkO123g==
X-Received: by 2002:a05:600c:1c08:b0:413:fe9d:eaa5 with SMTP id j8-20020a05600c1c0800b00413fe9deaa5mr3500066wms.26.1710582367577;
        Sat, 16 Mar 2024 02:46:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e15-20020a05600c4e4f00b004140893c0dbsm1026028wmq.17.2024.03.16.02.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 02:46:07 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:46:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The nh_grp_hw_stats_update() function doesn't always set "hw_stats_used"
so it could be used without being initialized.  Set it to false.

Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/ipv4/nexthop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 74928a9d1aa4..c25bfdf4e25f 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -824,8 +824,8 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
 				  u32 op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
+	bool hw_stats_used = false;
 	struct nlattr *nest;
-	bool hw_stats_used;
 	int err;
 	int i;
 
-- 
2.43.0


