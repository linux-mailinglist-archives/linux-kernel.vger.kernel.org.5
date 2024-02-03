Return-Path: <linux-kernel+bounces-51150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF44848721
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002A01F227AE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625485F843;
	Sat,  3 Feb 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="AUO9blWQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BC5F553;
	Sat,  3 Feb 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974319; cv=none; b=ftEytGV+I0nAzbXY5yq5KyRfU9het/PSRusfKzVmbw/Q8h+jAQnan2LrOUX5MTaEV1k3ePH+7Ow5vNyCXA3kcVkGraNVEHEtNSpxD6ZpE9W6wo1CPZFaoCFJZIOfgkBdS7dE6IEeLRk8eqpetgDSP6kQEc9jymLcdzimS99eVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974319; c=relaxed/simple;
	bh=YeXplEKxiKSr0fUaoHc3KKtm9jjg4cmFKCOYzQsxP34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YOUsf0nFA2kGzQiaDQGdFEMice1XByvXPwoZ8rLFPHWrcuFJdD3bX0T95TtIygzMx0crE5Gyc7JFvVBLDit2Ym4zvp6urgXYvzVtZCRXwHKchI0HZX8D3yfXZsQSHBO/PeSz6SfOBNWpzk+alK0jY2RIv75iZDX929HiukGW/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=AUO9blWQ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d934c8f8f7so27572355ad.2;
        Sat, 03 Feb 2024 07:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706974317; x=1707579117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/QYvYl3noKUntcPqI6dq+qD8nnGZtpzrjLRRn/gWtg=;
        b=FW+emPEm+NZNuSTPvlR2VLAE1sJXpifArT8njISszzx6p1D4j3NjOWa6cU+WMq6eoy
         zvAxkaMV0dnisgU7DkOlW1VbeaA6chpYT2zE7FCZAKViF3RGrKp4Rap3OMdFQYtvJGG0
         GNT7d/eEB2a3Onc2CianleFE8la9YlZZEOddZLC06p9Cpdq4oiY3RGNKlR5hJ3iX6oEH
         wAQo+xUCSvlcxhxwAbh/fBX0K4yi5Q0z/kXYI03HRAdx6IXBK8L8xXERed1yBCOevNyG
         CyrR6H8GRcsZZGAQ9OkbVY+qwSA7BC8O4uaCkk9TjjVixAgUNJsI8af/T0bfApy4FXCf
         9Hdw==
X-Gm-Message-State: AOJu0Yx9c20zKl/PvVpAsMY4Gde/lWgXJHJOMrqjB6XksOVcT+tzrxU2
	IctaxRGXvVY5AUl7WAxmRQtincqejYDpxS9U0JgJpf8uwh9IdFkcpXcHwHelvpNDXA==
X-Google-Smtp-Source: AGHT+IGPO4lYod4XCkRsx0HysvoZ3svwv9xRXfLAeLaTODo6eU5/9qaSQGQZbwKi7fzoy4YlqXIReQ==
X-Received: by 2002:a17:902:7848:b0:1d9:503b:807a with SMTP id e8-20020a170902784800b001d9503b807amr7541442pln.44.1706974317298;
        Sat, 03 Feb 2024 07:31:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXAOrivb0PQOiVn977dTG3F0TB3hp6eWI6gsc4gISAHKe60+2tH8scaZP/17r975a3luZH8OKof75R0DLYRWKvjKMdqyEtODI0UbJAxxWaCMa/dd5y64UqVdPRBQP2zq5Fp2NsoIYTsFhM/RYcxtkQIdDXapJMynIff5U5AHiKHKY+vCTivXDldEiXAY30/PD8FEOzAP8TLHVpvXDCe4MSWJZ+JfGGlYUvHse+reekVn8qeEP4g6fWn1ruj9eFS
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ju3-20020a170903428300b001d91b6175afsm3437131plb.18.2024.02.03.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:31:56 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706974315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/QYvYl3noKUntcPqI6dq+qD8nnGZtpzrjLRRn/gWtg=;
	b=AUO9blWQx2WJvxkrvcD1acABmJKwhXhOXdX5AHxsvshLgZHXafPD3j7Rztf4w1WrV9MUs2
	HveJJ2K+4oHTTRtple2ng9o6wn6AlKqwch//99Ry377U9mwKwRRi7l7HUf+6rJPfhUkBlN
	JokedENvwIscwwnjIpWy7oTP11RyM5w3EkJZ/IwdkWlRWo8PPIi8aVMWdkhLSl0G7VhfYU
	WFFLkxnT9XDYTSEkewV4Uxb7C02iNcc3Ja+/KJ7iOp+ZNzX7nJbBO6I3+nAGKPWEirasuh
	nASun878mm/sDBLJr7UMnExca/V4Uhc5ZWyST6k2fUCL4fduj+Oy5jW61SIxlQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 12:31:26 -0300
Subject: [PATCH 1/2] media: cec: make cec_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-media-v1-1-33e8feeab912@marliere.net>
References: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
In-Reply-To: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YeXplEKxiKSr0fUaoHc3KKtm9jjg4cmFKCOYzQsxP34=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlyDBuFHPWAN8p98l9B8kgNwNyYbw0dpVad6l
 Sy3X7jhBNyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5cgwAKCRDJC4p8Y4ZY
 pjuFD/0WXuxiejW/FybhrMFQ7866XFRpdoNfRN2YZGCf/hnKf4bd1ee6N7+UzR0cP3FTZDPfx/A
 20wyByski8er3Hk9h9vpVE16Q7c1rUE2t/APgUvQpcomWICaROvh4xEHFMMEB6INI6PFO2aBdII
 3y+2k5cnmUlcaURrSDwKsL613zGNTdGHiy+SFNc0dBDh9WvvY+NB6MUNaZ1hVwG0p2OEESCxgMb
 uRV1DA/ZJc3fu0Yn2T12+PwxjnSoYwc9VwYRJbWksPaE2lunlgVDJ0dqzel2iPpo/teUolfS8ze
 mU41RU4X2JG5dUSQKSQfbpGY5MtrOQpmJ54QXiCouwGJJXcZARafPjnhxzDkzlcGv+nMGO0qjgX
 fh7yY0k0aykZON9jFEOFpTcgtCUwScHwm1TS9kQaHtib6hEmqvpiDYtacvTaoO8ihmC8pGiEXQj
 tqeHsaZQuKXdhaX5gRBysAgTgnonkLDP7nQ31HNMaIjsXhCK8QPS4RjEfLXwgZCgTIoVtaTLw8h
 N05Z4r9unhPZS2lezBHFGXCQSL2vEOTjrx8BeRmnuat/hnFOsDRknolNtxuAx4eqaaV8/Yo22Wi
 0a9VYLy1433mpryLM9JtuCICaQTFZU49OFQcYBC/RYDPe2fc2yF1e/REu65K04J/jETLF3FjotQ
 KYLK0bG2XGDLaGg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the cec_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/cec/core/cec-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 7e153c5cad04..5a54db839e5d 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -93,7 +93,7 @@ static void cec_devnode_release(struct device *cd)
 	cec_delete_adapter(to_cec_adapter(devnode));
 }
 
-static struct bus_type cec_bus_type = {
+static const struct bus_type cec_bus_type = {
 	.name = CEC_NAME,
 };
 

-- 
2.43.0


