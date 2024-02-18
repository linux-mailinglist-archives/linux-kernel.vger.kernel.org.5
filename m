Return-Path: <linux-kernel+bounces-70493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E051C859899
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A4E281A35
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF41E87F;
	Sun, 18 Feb 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdawcmHJ"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB86341A;
	Sun, 18 Feb 2024 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281357; cv=none; b=W6hnesHSjSOww95oaCOO1P4AQdA+uxvdpugPOyOorfLmPXKL2c0u3SddM9isSYNmU6Hr4Ao/h3mvyZ2aQ4qs2l/LtCH+2m/3kbSZyIWf2WvWJYnA2QdQ+4g+5+PfQ01Q2dB6uK6huxJBkss66ToE2lsRpc5eVFHN4L0b/6tSVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281357; c=relaxed/simple;
	bh=5fuux1HAirtBiYVp43TmFsANlPjwHWYFEx8MXM16p6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=it+V73VItZ60aThscE/OC4WhdPeX+PhnZ02ZI7p7LXdWWH1nAxAqg5VI8dzLqtgTfXRt8YwMbs+FVoXF23GGnsy3E/45eQz/l2hGb053lLooAMtYp4C3qg4677u7xMXJuKTzQaxCebeNjtdHQUZuX2yfmisGNCzcVxSSYtnbydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdawcmHJ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42ce63b1d30so40096361cf.3;
        Sun, 18 Feb 2024 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708281354; x=1708886154; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtlFK2N47ATXOiP1HgXvAlQ7VAuyaeK7nB3D2FRWvkg=;
        b=gdawcmHJzaU3npzbZ9iGce4JBxkG0GxOfjtDXK8663kOMUiYKB1w1DXP+L1NZVCcwW
         L1aZlXHt9b/P0LM0wowItyL4O55UsZh6+6vos3a8BQOQCKzwxY/xEWEWYC1ZfZ3VALCP
         /Rv+FFpgvUigAVF8XxIWVNHprsPl2184zLVr+6dYIO1Odiem1PrzE6RlE4gKPjGY8PdC
         KWs6k/3d1f2EJozq77WJNtyMPpZV4XXfYAgpWPaEHjX/dSO3/GZ2PbszxObhur89OQ6H
         2clbms3LnOwgVsWKLnWiePjZcOK+Itkb75QtIIZZw3r8F32GZIM84PQ5ul5rzn9x0iVK
         eXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708281354; x=1708886154;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtlFK2N47ATXOiP1HgXvAlQ7VAuyaeK7nB3D2FRWvkg=;
        b=fQMJyFmEP0n+EKUHx5V0TLKi0Sf4IlDn9WZVTWfFDv4xkvI8r84z+xvuRse8BfEg+V
         2W1LJB5ucOXvpH00Oq9Tpepkh/qKkHurp2A6lVn20nWY7uf4rtp0j94FwwtwYCoEOTzy
         WQ0PC18ND1weCgOJag80EAX8a5BojWwPNKBl8pD0yTTbPRgfIJe7dpzU7PC+X3lhcGrz
         9wa8DAe8F1TIDDwkMAiNd8jJfOBDI02MfHm9BCp+Dsyx/1pr/JoqvQzkhGrLLdqgqWG9
         Tb1EM/iu04h67xEAyfhmmUlBjhOx1F8ZCTXNXIdINXkQdITfHVKDicQ2klQN8Brkrvav
         +h+g==
X-Forwarded-Encrypted: i=1; AJvYcCXpdJ2NZo5fuOKG7rKBiYwVpthdKZwDn69bS09xf3hdB+Jl89LlWHZIJVeglZbrONGlKtIn/FkXH3L/APYM08uj0VqD8/XtWk3fHdkv
X-Gm-Message-State: AOJu0Yzs9xirdttn/3UTMQMPO8KhdJnwwfxQRArVNxp4jWh7yzK1TTYr
	pjQtXyZFFL1jiF8BFFap3D40tqwy/x4FCZIaC02anHBBD5Z7Qe66
X-Google-Smtp-Source: AGHT+IEsGtbyPHD9+xbewDdwoJ8fl023wuuWU2V8e7302Cwwd7xV+PRUpoDCmgLcjwR5VsR6WbToDw==
X-Received: by 2002:a05:620a:1928:b0:787:54a5:9047 with SMTP id bj40-20020a05620a192800b0078754a59047mr4612171qkb.34.1708281354320;
        Sun, 18 Feb 2024 10:35:54 -0800 (PST)
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id c9-20020a05620a11a900b007859c6a3a7esm1764078qkk.105.2024.02.18.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:35:53 -0800 (PST)
Date: Sun, 18 Feb 2024 08:35:51 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: copy routing table more efficiently in
 rt_dst_clone
Message-ID: <xlabdyc4izitfdfpuoy2p2hi3abiq4mrrgizdqz45k7xeftbsg@ee6jgncdaqg7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Instead of copying field-by-field, copy the entire struct at once. This
should lead to a performance improvment in rt_dst_clone.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/route.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 16615d107cf0..ebb17c3a0dec 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1664,22 +1664,8 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 			   rt->dst.flags);
 
 	if (new_rt) {
+		*new_rt = *rt;
 		new_rt->rt_genid = rt_genid_ipv4(dev_net(dev));
-		new_rt->rt_flags = rt->rt_flags;
-		new_rt->rt_type = rt->rt_type;
-		new_rt->rt_is_input = rt->rt_is_input;
-		new_rt->rt_iif = rt->rt_iif;
-		new_rt->rt_pmtu = rt->rt_pmtu;
-		new_rt->rt_mtu_locked = rt->rt_mtu_locked;
-		new_rt->rt_gw_family = rt->rt_gw_family;
-		if (rt->rt_gw_family == AF_INET)
-			new_rt->rt_gw4 = rt->rt_gw4;
-		else if (rt->rt_gw_family == AF_INET6)
-			new_rt->rt_gw6 = rt->rt_gw6;
-
-		new_rt->dst.input = rt->dst.input;
-		new_rt->dst.output = rt->dst.output;
-		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
 		new_rt->dst.lwtstate = lwtstate_get(rt->dst.lwtstate);
 	}
-- 
2.43.0


