Return-Path: <linux-kernel+bounces-51888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A832684906E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B30B210D8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFF0286AD;
	Sun,  4 Feb 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="XSXWJJI4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37B249EF;
	Sun,  4 Feb 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079435; cv=none; b=hrsADmj/S78gMV8IMKn6crEjb7HcJRYxZVdZnMmWGuAFTXcBMaEAk/zYStLP2rDDmXE/eD6LqsOTco/4PT7oWdlVvdiuNz7R05skWVD6sIP5b9tLsM71T1pEVDQj0NEmVD1FICFxtwgCp1vXUW/2AGBTalIrGy3/nGmibE8+plk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079435; c=relaxed/simple;
	bh=+J2CwGJATVSTrkTar827B811DKBVEBvn5hOTkh8S6a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ogq18lSsU0PStu81SpW3VYz/io+pHTyppKl2chOkdOeCoxoPocVPYZYX3v/+Fsj7f5UTBTvWASjDr49evd9iYi2kCgiWtgY+h7Ff/VdREaHzdjoh22T/N36g+5UdYhDRE65QyVJc29/2eCk5EjoBBxcAqdQaNG/qIWPTQtfEvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=XSXWJJI4 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d958e0d73dso19185805ad.1;
        Sun, 04 Feb 2024 12:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707079433; x=1707684233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r75W2kNreUlmx6m2oyR+QjbDy53Ws3L45/ED6d0a1BQ=;
        b=XNH+uzOQgf1RUhEYNjB4nbw3HgZQUrLpDzs80O0PooU9iGtnF4twXElNMpNuCyPT7b
         oEb0yKR6K+9nvfG8SRoDE9N024hof650lR+WWGDHUxu7FyQCDQoOkYDqypqe1MloAtWN
         8Yl6BCC0C6Uhh4ElNYCm7TYNM0ZOPXuLpA0o6w0yjn7Riqh4d0UX1Lss0+xdYuh86lJV
         f59I5A6A2Ji12LXEnZB4OcigJYXsioayUZldqsn5dvYF+LAOh2f5hU5oOGw5+vfUpu5Y
         7QF2OhHSwrW40ljydjCTDS3BKK3dhKJxma6Itv+UjXVTKwNDvDhIy4/iyo84FP5au/tp
         +QbQ==
X-Gm-Message-State: AOJu0YzDiuVU7MerlqUX1n6BNAhoP/1hEFwdHJ6eznDV1zZqOi+KQpSc
	//bWy0BAlUWuHiCaS3UfUTIvfo0JTht8NZf0jHE52tQADvUm8paoWwE8ys/GB27cwA==
X-Google-Smtp-Source: AGHT+IHJJxIBfK4BeKJlqE9ezfM755xyffvp6qbG8CYhhNOz25hN3X4w/E46pWC4Sagyo0dI9QgQ3Q==
X-Received: by 2002:a17:903:32c5:b0:1d3:f344:6b01 with SMTP id i5-20020a17090332c500b001d3f3446b01mr6463346plr.3.1707079433214;
        Sun, 04 Feb 2024 12:43:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWDKUIBa5raN42BsRh/DAMnRw+fqK5zk4pB8zKbARWdMRS+cwtSu9CJ41SA9F3b3s8g/I80KscBuJyEbw2APMZ/56eBhWc6V1z/drRut0Mqe/2aNgB0ug+FC3XIlVuKFY0Zjsg/U9qjcw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jc18-20020a17090325d200b001d9537cf238sm4911349plb.295.2024.02.04.12.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:43:52 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707079430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r75W2kNreUlmx6m2oyR+QjbDy53Ws3L45/ED6d0a1BQ=;
	b=XSXWJJI4qUCMZI2qweezFbcv0l7FuH5vxCTz18+MI0yrJf1NS70IXskuVrBRsOw5WlPbHl
	cRIsuybjgyPNvVoJhRKRcYcr4+SodaOGbXjHIlQ3kaqHsg4/fotwhiPKY0J3CHrUEINuyY
	bCj/Q7B0gySSvhClpfugYHu9/4BaMNKI54kDHDWxvP2wxS8SWD63bVWIeAo1VkgeXvOqnZ
	yrD5okZI3ybto7HF7Abk9PuylMNvyvgHnhBYm8DJK0G4BvhhUeeAOTBD1xGObX7LAFZOjv
	i4Y0yDK1hhNpJR+/IxZdpeMtoUnc6MUh0454B3a3/w4oM73pc/XUjbsJy+VkLQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:44:21 -0300
Subject: [PATCH] ssb: make ssb_bustype const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-ssb-v1-1-511026cd5f3c@marliere.net>
X-B4-Tracking: v=1; b=H4sIACT3v2UC/x3MOwqAMBBF0a3I1AZiCBZuRUTyeeqARMkQEcS9G
 yxPce9DgswQGpqHMi4WPlJF1zYUNpdWKI7VZLSx2mirfJE57HCpnErEq946LBbRGQ2q1Zmx8P0
 fx+l9P1jFjdhhAAAA
To: Michael Buesch <m@bues.ch>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+J2CwGJATVSTrkTar827B811DKBVEBvn5hOTkh8S6a4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/cliSEkbwXjTFuKttXxHU9xmnboK86waA00r
 RQxrQcdymiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/3JQAKCRDJC4p8Y4ZY
 pkC4EACsdmCHPFIx1PuIV15g1OQZ4SKC0lSWJ/UvhmF7vqsdqKAPt+Rxt/nofPWm6yXmOx0qCu0
 AVL3aM/B8xhS8Lyqz0ZqM/trelK9enFyD92QBtZHRtBRvJtwHKv/qVnccETEh7R12kiOk1lQTDv
 XeyajF3zFd+6go++eUGHN1ufvyWcEH4Ev158+fBx1Z6DlXIkyP9Z3qgdbfzZIr1MohLZCoII5At
 hyZNmzoHOvYGSQacfEZAHCO3Vk7xGfMzu2YFy5dcE9I3Z/iXR+Q4KKtpNDiN7jRtSvdt3Jq7TVw
 WbuBu2U5u7Xn90XXwcLsV8KOMIZpHyqyXkRznijmpiU9d2Ho66cYfgti1HB+K6QLXtaRuDojt9h
 cR0oMM0so/mEO/JqpBxPuRVfangED4esSZV5alsBLTvcP3O+gX9pJCZhe8WQ30k4URjO9IM1OCf
 j03g6o+snspMg6E9orPhFdHzW6+3mxTYzcAZuLSz3Pv6VqZfZoHHiiKspZXvwcT+ftcZLQeY7Pa
 5JdjyZnIjME76ycuC8YXxFsI7l0aGB/+JqY+pLvtxytEhcHsF7WY5+ZGgH7M8+1IYK+1O0qdwNd
 NNKbGFb0fMnUKr8YhanHOn1mJyEsSJeleROt7jRLiwjE/GPc/s3AkNZTpSMl3Sggx/nz95JP/U2
 xmnUCEiPcJUrdxQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ssb_bustype variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ssb/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index b9934b9c2d70..9f30e0edadfe 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -384,7 +384,7 @@ static struct attribute *ssb_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ssb_device);
 
-static struct bus_type ssb_bustype = {
+static const struct bus_type ssb_bustype = {
 	.name		= "ssb",
 	.match		= ssb_bus_match,
 	.probe		= ssb_device_probe,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-ssb-64aef4eda20e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


