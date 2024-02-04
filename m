Return-Path: <linux-kernel+bounces-51866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783D84903D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91FC1C2164F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EEE25567;
	Sun,  4 Feb 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="B5zKljTb"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E425542
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707076789; cv=none; b=iIhWLld8RxqcnLUDyK3R3EPxJj1zfTIdbZK8ODg+7YFJbUMiKSLIcWT1whja0G7ij0rCQ+Y/vIoDRoPAp9jneXFPgsxZWaAYggALsvFXsfuFBfm1w64F058a+0alh4dN4XBnfvndRIo52n4XvRGNKWOeNjPwcOY3xEk7DfkUsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707076789; c=relaxed/simple;
	bh=kiJZm4wcXa1B+I5trmXEIwmSwZMiWeOAqzJ4LvYhcHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eg1zYy1yXash/cSEG+yliYQNQJxWVZv+/TTg6IyQ8tOOW7+GYdMc+ajibCmPCdbCSNCgOOXn0VABqszqrVuHNVSQmGtA41wUlFhgxT3UhxV/ylKKTdrhiPI21kVR3gLbuaBqD7xFk2SGN2pAMxEv38qeULCro0lgLAHZoVIVuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=B5zKljTb reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2914666a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 11:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707076787; x=1707681587;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8BTH4uSJK5VLlyRZp4zK2rdV7F6EDvysDCPB0/W6F8=;
        b=YeE9jgMWyz5FT8DF+BytqIAOtFhQ/MgX1RSyHhGJg/ZF4GglExZZWY6ljZyG93TWzn
         FnK2PJDpj6HyJqr5+JNzThPiLCZ8DXQHni6xY2cd1nbLugxG1K7gvOogrbgipEaIWvk0
         NUrlv6DXxFuZy7IZFvD8jgFHVU+qTyj1ag5yC+F5f02CQjWmIphUH4BrZo6QJO4hG4JY
         iTmEybESxbRVBKGsG+OQcw+OqxQcmYtVl0p74YfvJiBQglBSzPXBh7qL7eJxM3Xoq7Sl
         +nwQA8O2Ob6LRBXTV6HkOiEtQIGlrUPN8xYAbIMEfrGp3cNNy35GziGraNL+dd70awuF
         yG7g==
X-Gm-Message-State: AOJu0Yzmrt3K7hKDLTQAjfO5om5KElgF+SpMEj9s8siIoZWobX1mIm/W
	2kIMVH/rVaQ/COjv/eTvhJc4jHWbN3ZByLTwqGz6h+7i7yGVbpGm
X-Google-Smtp-Source: AGHT+IGZe3/5sH4A2QF1xjvr9pAuWRkR3UQBZ2jj5MuHHYwQgnkU3FCyVvNwaBYgiE0s+zbCthMXhQ==
X-Received: by 2002:a05:6a20:9f4e:b0:19e:3a9f:f925 with SMTP id ml14-20020a056a209f4e00b0019e3a9ff925mr12258679pzb.14.1707076787267;
        Sun, 04 Feb 2024 11:59:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV9DXBuCEsYM69/54OIWpGogSc3OiEmq+wKJ8seEr2VcT3lx0sYo4kUB1OzE9yerX6YrAg0WE6w4XHOMRLsgwwfJNYXLbApIMUUhsYQ1Seh9TaqOr1UXXSojuGXBDHO/+3i7sw7UhBzQU9U7s+GHYScj3OBmM+Mgf2xRZKX/ZJDGg2uzrI=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001d9a422e0c0sm1340567plj.20.2024.02.04.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 11:59:46 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707076785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K8BTH4uSJK5VLlyRZp4zK2rdV7F6EDvysDCPB0/W6F8=;
	b=B5zKljTbZF2EZB3O4wjQTtkTaMss+5/vc503yu0sRf7uMw2uXJeR8BAc/kOqzutAAykQ0v
	8n1F7ExiO09AwW9cwel6PTjgfYmYByJWIQv9QdicAHNdJJBnV2k5m5wkJ8kuKCaSoISabL
	6vmYpegiKfwkoMMkEIaz3QY7OEcS91Oc4PWgPIyIliwMKB9AWZ8vsLlIf2RsfC7tKLjjOF
	HQejNwElMeT/bgNsjdfdCLAL1d3KlVxhlw7U7jEL4qU4BDvCYnxFOKBhwpOcOXrlU8rNsP
	7wX6LVasUhbH4D5EDE4nAMHhaxEyFQHrmSauVrUw+DGchgWlOy6paNDfiypGyg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:00:13 -0300
Subject: [PATCH] ipack: make ipack_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-ipack-v1-1-aef5e8f84d01@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMzsv2UC/x2MWwqAIBAArxL7naBiBF0lInystRQmShGId0/6H
 IaZAhkTYYapK5DwoUxXaCD6Duyuw4aMXGOQXCouuWLmzqs9UYc7MoraHmzEoRkpnBEeWhcTenr
 /57zU+gHEPjmeYwAAAA==
To: Vaibhav Gupta <vaibhavgupta40@gmail.com>, 
 Jens Taprogge <jens.taprogge@taprogge.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: industrypack-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kiJZm4wcXa1B+I5trmXEIwmSwZMiWeOAqzJ4LvYhcHA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+zPU3u2VSdljkQv1wkG1xVdFooTEbCkut9gw
 QrGXMxbjiGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/szwAKCRDJC4p8Y4ZY
 pqrQD/9plIEwfL5aEv+ZyBjh6nQwoXcClbBkiXrdoFuN2ZfCzqBG0qaNmO0EWbawtI9tJel8O1Z
 NJOyDAPVq3gDquiU+RLCVWPpFFt3QNz+XcS8eMifKCYnOCaFdueKFyAIdaoqu0F5Veux0W5QbMb
 +3XYKtajyROvKeiLjC5RLwqx4gXShbibRgEqf7p/BGyI5RSofF2puL3fhPm1rK5W0F12bhssB9G
 f8GSofOo/6SMfORoZNujfUAAu8fHgHe4mNaI3tpiTekNC3ZjkxmHLm7OR/9pflFohm1G4WrSzNe
 GV2HmcT5WimTwbX05s75trowCw1afG2lkBDcFD/7JYsRw2B/Vu3IcT/++Umcwqmsn5PhtbDP7Ps
 me47hG2eLOQ0aLvIZhSgnRtnEpAMXIccQlTCn+YwIIPUXyPak8Bj0rniBHZOgDwkTYy+E4AOuMa
 nitWaRVjl4V65KXZ+l+/QhmOf2Qn+9K7Z1e/Ji9crVNCFxDobpubAjm7EVqtpkvekiXRnScO5hm
 PyZ4DtOCUM8VjDLy5xmBrwpDp/cmDeVLTGHi3PVvXTV96DnbgegyxNoDwXEolpCV0YlxS7mloJn
 6ZZLBMxRdTnAdD1IAVial2npqeCMQH5Ee+fdPM2wRnDMH2UCTVrpDqzqDGhXrnX3O9XdE64GHBL
 Lt2Mf7WvnS375MA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ipack_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ipack/ipack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
index b1471ba016a5..866bf48d803b 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -187,7 +187,7 @@ static struct attribute *ipack_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ipack);
 
-static struct bus_type ipack_bus_type = {
+static const struct bus_type ipack_bus_type = {
 	.name      = "ipack",
 	.probe     = ipack_bus_probe,
 	.match     = ipack_bus_match,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-ipack-7e502021db1f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


