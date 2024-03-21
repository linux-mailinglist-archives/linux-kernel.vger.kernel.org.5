Return-Path: <linux-kernel+bounces-110168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B4885B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F951F21814
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E778627A;
	Thu, 21 Mar 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7uRLLfM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE586277
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032153; cv=none; b=e99Fx01IVSJW3CEMHy4qfZuDLvDbbC49AGnIdNDo2EKf2f5CogB4euu5N+BNWJsBFbEnb4LtvHLeKR+cAYa/yzlhAZkKRHRS9Ti+YJfM/f7XsCBUIRWgtFUgy3hvt+yGkMQN3XkWplRnO9aiYlPDJHbDxgAgy0EEf8GcTaamDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032153; c=relaxed/simple;
	bh=mvVCHoV3WyhbYPzYm8+AWnGsZAbyA7SkY5eLDIVysB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nt55dGqn6m6f3ttEvTJG/QZr4qNiCWdPiyXaRPZNKce32pTMtCNhfBP4g+eDcy15tsxqAHn3h77F4faEpWgh/b2V9hWSvtGVJwKwUZSgpDP1JiNO2Xf6BDIh0SoMV88K4oEF/+ScHbMwVkgD0T3AGg/3fS8j+x5JphlNRik5z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a7uRLLfM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so647820f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711032149; x=1711636949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlpyW/qJGkbtizkhGO1yqBNzqS2/ma5JoZfKsAcPkIM=;
        b=a7uRLLfMM756YNW7mB9hZUcZK9H0LXBDzI49/OUWjPnCAakg88BNKpfTCizCsg/qxf
         OEkQwJ/0TM+U74XsOE+D03WO/0T+FDamWGrPHQ1gYWvbeBUIkNfg08oeaAutfzEdMJkS
         gb2IerjjfMMKCGuUY8qJA/nbLt5GIc1u1Cdf6HO3m0LJfVYzBGvE1fXBS7jZqVUi9bCx
         A4UkKC0ElWyyi2FtwLtHJAMl52HtslA/8QOCT8bMxQ2W0Yw5ZXQuWijYjKT9oR+7J2GJ
         e2x8PEudnqwOqQrKB+ZE+7Q3mBLwcqya1KYIiM3vGJuulmsX2umlcIdt60SCvB6h/jZn
         cbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032149; x=1711636949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlpyW/qJGkbtizkhGO1yqBNzqS2/ma5JoZfKsAcPkIM=;
        b=HZjOhwoP9duX6CwS3ZpaJguHanwRQVOXY8EhD4VLO4qWrZXXUkvIP2MxC3s2QZGEXE
         LNmvdgdpSaJcrq8ZVPZCABsGkJf+JBmz6s2CAhu9OlrxNJYfKA+er6RBQmlIzB8WR0tE
         YBsjx0XUhLXNMC77NlOW52YsdVsxFBIy19LHezNAHy8qzqvaDIehM4h0Raap9TLQ4dZF
         OX5O8SstTHOaoAM7S/2DlCs2w+Y41RRm6rsFmdzaEmj8K3SobE18qbKWrjWvWTjlTzdM
         0ojV4+NWbNcNWKgRAoAQXC7COtOH8uR1cNM8s36X2+jQC7fUHKaHXpnxz0tEnJy6P5ku
         xrdg==
X-Forwarded-Encrypted: i=1; AJvYcCX62G/d2ilrCgzwD+YtOUK+TMJjoVy56P7tXDh3o4uzzwlGpwJq+G1FdnkhIEYsYv+Sd6s5MWxRlYz45UK5MU2Q+ygHR2O/tYzkj1gh
X-Gm-Message-State: AOJu0YwSuGIvqnF4gjYclxst4/XvoWrXSZjTkvsBkwt5oW+Ef0+fu8zu
	utoYsRzWsI6edB+Q1xVXYuISm8b2rmGo0r4cceW4vSW0WbiIYSUEJB0wHtyYtS0=
X-Google-Smtp-Source: AGHT+IGqM5LRTTAcA+6N8Hep2ZWFfY82O2I9PKGnkuA08prM+u9q7FCVn8y1OgI4tWJo9PIjBFq0MQ==
X-Received: by 2002:adf:fd0d:0:b0:33e:a29d:9672 with SMTP id e13-20020adffd0d000000b0033ea29d9672mr15509211wrr.51.1711032148752;
        Thu, 21 Mar 2024 07:42:28 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b0033e7de97214sm17328972wrn.40.2024.03.21.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:42:28 -0700 (PDT)
Date: Thu, 21 Mar 2024 17:42:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "*hw_stats_used" value needs to be set on the success paths to prevent
an uninitialized variable bug in the caller, nla_put_nh_group_stats().

Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Set the variable in nh_grp_hw_stats_update() instead of
    nla_put_nh_group_stats().

 net/ipv4/nexthop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 74928a9d1aa4..535856b0f0ed 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -768,8 +768,10 @@ static int nh_grp_hw_stats_update(struct nexthop *nh, bool *hw_stats_used)
 	struct net *net = nh->net;
 	int err;
 
-	if (nexthop_notifiers_is_empty(net))
+	if (nexthop_notifiers_is_empty(net)) {
+		*hw_stats_used = false;
 		return 0;
+	}
 
 	err = nh_notifier_grp_hw_stats_init(&info, nh);
 	if (err)
-- 
2.43.0


