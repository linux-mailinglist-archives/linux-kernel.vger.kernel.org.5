Return-Path: <linux-kernel+bounces-49653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96957846D7F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B12969E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109C7E110;
	Fri,  2 Feb 2024 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhf7tuAb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93777F2A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868816; cv=none; b=NkZ1qpXvo/Znf841gp3yjNxHcuafBNbccOXznCmgNaSCB1d3QHN9djv4ybJ/jEvec8tEXln2P8qn2E/JKnTUNqYIUEa/CBaPkjHuTPqqsLfcGuBSnziTN+V/TypI7SbhXh9Nb9IIraMYNpFNBmnjLGd1aBM/yK2sO0N+Kmg5kGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868816; c=relaxed/simple;
	bh=PJHamj29rRPnmcKigV5i/g/eYFjHdot+aXYjPD55b9A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=u2Jb9iqzuckYqoSI0Cr1LcqI4lXkJedw0yfHt+G3ouw2/ouw8qchdWitXhDQ0ZMJHehEfvyTyvYr9L7rwyCxQlBu1FIhqb5O/XFW3CMsRt2IXj1iQaklh1C+N5orvByF/PplZzGgh1xVgwg3oWkI6fBilGQwr1m8Kv3+/Wng5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhf7tuAb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b9f4a513so2947291276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706868814; x=1707473614; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmGh++VKQQZ2V54BTT2UNO9KFpQjbrHNRiYoSPHg+q4=;
        b=qhf7tuAbPqa3DyhMI7DqkdD5a3vJEYC79d27UG3soDoQiQAw+i7tvlDRE2rgGV+wzQ
         Bu+hKBbsBjgV1JlcFmrBXzUYh4CP9LeuZrS8ckkdwjCE3xanE/UBGpAHTti3oaweX6S5
         pDaqrtJoagKqPnom/3w4Hi7XutGVtCfujLWYpiVofqpaD2PizNszOgI7TPz2Nfd4P8Dl
         d4Wx0zcNpnOte0RDFxjodsq/DmnSOu+arLt7wiULjp1awrqlSjmv3UG1K8HiyggzR6Qu
         mD570K2VB8Zp/ISAC4kGngiGqe6T9PTmjrt9R6U2CsyhzFKnPnoNIU1DIFOkRlbaWtLc
         duUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868814; x=1707473614;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmGh++VKQQZ2V54BTT2UNO9KFpQjbrHNRiYoSPHg+q4=;
        b=ANjZpKlZvTw2JZngqhH/k5YnI9WcbWi3PzzStQ8QxT7dU4D7Rwn862rZHiAJH2peCP
         kOJoGmaAeXmvSEgf9vdRy9rJTiSnUFKJn/Ouav3QmtzVGJIBgYmsWtsubo4hSoZ+E++K
         UPxB3R7cZ2ilRZWJdSt/Ug6YNcazfWhV3AZ3fkCBDpIj97cRut/9ZIWc+w46nTje5GBY
         ANKEMNmb6H1ojnqTsMnN2S3hLB41wLeA4IpzJCz+L+Pbsn+vzalx25UXTzwSvmQHTLkS
         GxTFX1NA7FWWReKaXlE41VHQEk/Jp3hK8PoaAXBDCD07cjQbHLvJ5Shn1tFJMdhxDzlg
         jrOQ==
X-Gm-Message-State: AOJu0Yz4Sv9fgVzuJRYQ4/N0hXfaFEagsAhN8TtUcLg2FRa4N4pgCcdA
	OoBx1bGg3yZsHApOpddyoVSyG4MUk+6p14tiFkSHUdg9oYAwacof1gee5c/8tGZDe52nocADMwU
	YQ7s4lld4YEIjxA==
X-Google-Smtp-Source: AGHT+IHQuDuJH0mZGbsVco2iwKbDb58UrPvCTOyPc5GNYofsRrkiUKpKuGdcwTQbpesKZsxG1/P8Eb8Eln40n9U=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:2186:b0:dc2:466a:23c4 with SMTP
 id dl6-20020a056902218600b00dc2466a23c4mr499035ybb.4.1706868814499; Fri, 02
 Feb 2024 02:13:34 -0800 (PST)
Date: Fri,  2 Feb 2024 02:13:25 -0800
In-Reply-To: <20240202101326.876070-1-saravanak@google.com>
Message-Id: <20240202101326.876070-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202101326.876070-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 2/2] of: property: Improve finding the supplier of a
 remote-endpoint property
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

After commit 4a032827daa8 ("of: property: Simplify of_link_to_phandle()"),
remote-endpoint properties created a fwnode link from the consumer device
to the supplier endpoint. This is a tiny bit inefficient (not buggy) when
trying to create device links or detecting cycles. So, improve this the
same way we improved finding the consumer of a remote-endpoint property.

Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index ba374a1f2072..6c168446b647 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1232,7 +1232,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
 DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
 DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
 DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
-DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
 DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
@@ -1303,6 +1302,24 @@ static struct device_node *get_remote_endpoint_dev(struct device_node *np)
 	return to_of_node(fwnode_graph_get_port_parent(of_fwnode_handle(np)));
 }
 
+static struct device_node *parse_remote_endpoint(struct device_node *np,
+						 const char *prop_name,
+						 int index)
+{
+	struct device_node *endpoint, *sup;
+
+	if (strcmp(prop_name, "remote-endpoint"))
+		return NULL;
+
+	endpoint = of_parse_phandle(np, prop_name, index);
+	if (!endpoint)
+		return NULL;
+
+	sup = get_remote_endpoint_dev(endpoint);
+	of_node_put(endpoint);
+	return sup;
+}
+
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
-- 
2.43.0.594.gd9cf4e227d-goog


