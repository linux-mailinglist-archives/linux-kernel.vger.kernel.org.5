Return-Path: <linux-kernel+bounces-52400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B4849792
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC9E1C235BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA4D1B7EA;
	Mon,  5 Feb 2024 10:14:35 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A41B7F2;
	Mon,  5 Feb 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128074; cv=none; b=D7rul9N8eSosafRKIGbE5/R33INkYoQkI2G8Zlf6Un4GB0Z+cTqHkT4a3RsQ6n+WY7pwkfRW4b3k8SD728Z7EZ0PUTCjZk884WTWlrDYx1qfZUDchpzzfWBoQnSPlpKTsu6f+hLTJTmHYn364MfXFEs+1LeNszig98mO+ul+xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128074; c=relaxed/simple;
	bh=T66TSvjfPaGyd+ykHdJe5K3cX0P9xPAS2OeJTOq0uLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srrZpAeSgytPGXEAkjkMgFncEmerBTarlmNevLSqRahqkm0RJOhjNbbB9gR9lXmMINMeWLIl+nN469aK63V8NT1OTKwE5hdE35SbwuAXhCX0wTWB88XxRm9lvGq4QpSsvkLorRX8wkSfXUzjoC/uggTyV97Z0+ej0WawG9dTIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so6015559a12.2;
        Mon, 05 Feb 2024 02:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128071; x=1707732871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dgcbcy70G2wxvarVa/puvAxGY53YxWzlweb2szxRXUY=;
        b=w4/6bXYNOAzE9+Kz22o5yO6Djn5iuw0EBRw2YjSbCKBXCmugrZ0oCb6f7o57V+varg
         sO1P9TYInVfWM2XFaH64/KDtmPmO/Crl9AXWYhPzMzCQc7pd4OQBb6aRweyCjJcgfIpy
         D6AMBvmMmqA86/aSoKXn4ZqI9w1OT95ch4w3QG5Ix65fM3HjvEm+s4WyKgrGubwrrkKs
         ZTDqoS5DiVKh9xmPJue/mH0EqcTpJ5FPEA87h0nxzYdUkuDiFILwjLQA0KSa1xV3Jn53
         kv7Azfg8aTygPcyLBDO3T7yLU4rHhjT1T+k45OuWDmKAqgmuZUvhcTWeKxb4Kb2kBO5p
         3W8Q==
X-Gm-Message-State: AOJu0Yw3HIcryhAzzt9u9d/oARfQYL1HIH74C0x54o64Y9Csn9L5DXMC
	opwlZxdzHd4gRxMTvj33UOTndfFQ7HG3dPOFYDjSb0zSMHXqnU14
X-Google-Smtp-Source: AGHT+IFOa97uizXKK6sNB1czANrc2SsOw0t6YIxHI/qjaVEKIyc6qlbT9caTE/fGEiYqleGSfLiJog==
X-Received: by 2002:a17:906:f6c6:b0:a37:b79e:ae2c with SMTP id jo6-20020a170906f6c600b00a37b79eae2cmr1979307ejb.27.1707128071265;
        Mon, 05 Feb 2024 02:14:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyVqE48HJaMe1Mej5p9EsucHS68n6RWsw+0i9EuB41GlGzb1ThCtwRzPPTCOI4JD98gBFrVM+CgNrpGm7FlOkGF7aXNbfyRj8td+EwFcZmJfIyaJDf8rxyUkXWEoHeCqiBJhwSYM/aJMbNiXk/4S4zdEpH9llyYGI+an/I9TIMDgwSpgwK5RRBtH3xvNXIPWcNMxq2JhYR7xUzjqUA9txIootGxDakNBHflRfWhpsSNxzd9uUdY+P9PFq2bwdAMH74+VU+k4eC
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id z22-20020a170906241600b00a31805b4165sm4191604eja.11.2024.02.05.02.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:31 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net 09/10] net: fill in MODULE_DESCRIPTION()s for ipvtap
Date: Mon,  5 Feb 2024 02:13:58 -0800
Message-Id: <20240205101400.1480521-10-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the IP-VLAN based tap driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ipvlan/ipvtap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index 60944a4beada..1afc4c47be73 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -237,4 +237,5 @@ static void __exit ipvtap_exit(void)
 module_exit(ipvtap_exit);
 MODULE_ALIAS_RTNL_LINK("ipvtap");
 MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
+MODULE_DESCRIPTION("IP-VLAN based tap driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


