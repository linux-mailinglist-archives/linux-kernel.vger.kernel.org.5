Return-Path: <linux-kernel+bounces-70060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA9859285
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AD21F22A59
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BC7E77C;
	Sat, 17 Feb 2024 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="mmLItJ/2"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD88120F;
	Sat, 17 Feb 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200807; cv=none; b=Uf5PSEwHH6056Ea+uLry/M4imH+5PBLqVQQlIu8dP9EQToY8Sjj+g6fROjxnrEURBzmQRCd60qSd8mY/YfuCef1npBAR44YhH/PJ7V19RUdpoXFcgHgSwbk2NFJaz1laRiXH98QudPVAP9P6nsGzPW8mIZgLKifUM1+7qdgPHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200807; c=relaxed/simple;
	bh=y6BYSrCEA+qZPTeLeEv74HdrbzQ4CCbt7n0reUwhfoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2t/5vdE0OpRql20boES76nhg4w2mIPXKwu/YdrB70XDlycwPw9MKoo32oqyogvIoIZZ8OeVZRJHV87ZlXdhuRo7NFvGBDtl/pOMz62VWlW1Y65Dlm4jupk/HQVAvs7f3l1A05uuXxxxCDAD053OturbU4tsk9dfrkcGlwW1JUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=mmLItJ/2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2592747a12.1;
        Sat, 17 Feb 2024 12:13:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200804; x=1708805604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmWynX/cFY/zYOq/2eCC7fEshtrUVqvaNfQwMNQ7SfY=;
        b=JuZVSWYHsg2sxnZiCsKNxGhZkcMmT9kr23AITP+JdsoHFa3PnYBdzRAGIyedC0bMvb
         n9yW8gKBvaAaO0NfuXLug1M8uOodw9X35F5pNWqxvEKS5qjqgOqkT/kvnOCnD7k0Bosl
         u2ePz/n9QD3T2VHLAlhcs/o5EVrqPYLFg8d/1vXI2pV2R1QbQvefUuu/L984sIow6Tzh
         pjpjr2k0uvU6gjlTj4pBgZa6JmY1sB8yjGI2WtvvivrxfHTotVjor1YAxc9CYz/J0cbf
         cossGcTTsmxvx7VGRpfPBbeaDFhKOswQgc5Mz21QhQHsycJploabjhA+W813kMogJfXC
         s9pw==
X-Forwarded-Encrypted: i=1; AJvYcCXNevoQzUadtRRklgMSvnlk/wMw/oBYEijx6oP0izWADEpoqfLdUgHqsMEkIT5aWh0Lfi7W660Q6YIB97gGZa19ZEvbK1xEZfKr/8DyVit0KqTTktZvr+cYgfj8UFUCRNszhlGvZ5GjxRhq0MFpPMhBok/dhHKKIhU+8r2yj6Q3R1zf
X-Gm-Message-State: AOJu0Yx+ZLQH5HEY0unQFXjqmiXgEPWnimzXfsrkfhTadd3Tn/RgfE57
	d5LdqZQg5puYKufnkZLm9z+njAT4MGAts86KJYbDo91+w22F6hQ9
X-Google-Smtp-Source: AGHT+IGXInpkUwpO67eEfAZG6SMtlHXxrmmO6ZqL1R6Tv99t29Os7Hx2UnFHEXYlf5KDA9RavDqXyQ==
X-Received: by 2002:a05:6a20:2d0f:b0:19e:9d92:492e with SMTP id g15-20020a056a202d0f00b0019e9d92492emr11119962pzl.44.1708200804103;
        Sat, 17 Feb 2024 12:13:24 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fh14-20020a056a00390e00b006e08c103dddsm1999319pfb.192.2024.02.17.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmWynX/cFY/zYOq/2eCC7fEshtrUVqvaNfQwMNQ7SfY=;
	b=mmLItJ/2x1YIEiW8tOghxhkXrDk0/58hvlSpnv7t72c3p1Qjr0lwTfr3tBnpPX29WNkMCG
	TCGdzm3/QEMD9og4rc7VY6itAm0m+qbsCy/EytMaV0wD8VZICY8mL9ofq9vHqjbqpJamMw
	emrryPMrxmYrz37Te0OuQbVZ1xcHkk87JvibWr/i+erc92CrLkSb1DBHlfhoJVoV9dg7+t
	P5cmdlPdMFB/Ne3PelnGsX/vnXewjknUzaKkV/KVBLc66QA5ZAUgkWGeWaKO+4osaLK20y
	L5UhBx84gxR/OUwUT4ixAQpN0Qa9FuFvUjHspFtulAAvAd3oQBnehPF3zobBsQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:31 -0300
Subject: [PATCH 09/12] net: vlan: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-9-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=y6BYSrCEA+qZPTeLeEv74HdrbzQ4CCbt7n0reUwhfoY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNtfkuOOhHL7kJiC+Ppke+4cIU9PVk1Ov4nG
 MXL0y/nXcaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbQAKCRDJC4p8Y4ZY
 pgv+D/94g+Fv2KX/++lAfaa5txLoX+0t+RdSw4BU2/ZLzxwCGk6D1dqvyxAxeQNpvnsSMVvu/Xb
 aIgLGT+kw9AH1PPNAzjVhxvQ+4dRD0jGaE1S55vQYlvuYD/EoNfbUBfPRO7502bYtuei+ZtpnN3
 Y77RsNGBDlT0di184JU7nMC0wNSM9vY/b+T9I+1+Trmo+OeWFAkAhLn5A3mYt8xSZAnSHiAdLIU
 awjwNwWo59k6W/01zNDwnsV7wJkyxy7S7q+Qxc/EOb5IIvcHBsOMmLLIaSAfzqayQxLwSdWrsnS
 BFvJfFIELdcWsjvgk14W3Aon59uGIGph8EKU+fMRWCzEMFfTPjHJONBfaLg0XvgqGAR6K80HSwH
 UP6IjZ+GKKwksYq3z5819HNKR0jiF2UPqN8QMC3fZ9sTt/FV3zKJMDmTwvu3K124Js8dk6DRG0K
 NB9aHAC9I/HGjkbvgJOmc8O30Q6NM21KE3FZ4Sa2Yql9v5ZVnkVSLaLh94vgAVyJKaO30+vxIoj
 ZwB2h4Onx0QmWr2/LbquNc0SqdkHVHuJ1pj78wCYbSjM1oOLs19o6lTf9yFHIs4yMuVQhjU/mqp
 n9LGhrfGQy9v6jWy4K174vgXeQZ+Ys0ot/5+40MtWJlKLxwi1quuhhtel1aTUYgeJFDgF1g1pnI
 ofJclDNx7CiDU6g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the vlan_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/8021q/vlan_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 790b54a7cbe3..df5552518251 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -537,7 +537,7 @@ static const struct header_ops vlan_passthru_header_ops = {
 	.parse_protocol = vlan_parse_protocol,
 };
 
-static struct device_type vlan_type = {
+static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
 

-- 
2.43.0


