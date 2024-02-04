Return-Path: <linux-kernel+bounces-51671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B380E848E1C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F342844BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854C224EA;
	Sun,  4 Feb 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="I2vALc+A"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D80224DB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053990; cv=none; b=B5JkdSqWiS4ASNVHyzg267FV2vVMXbWtTin/rkzm5ug/kRxEnu89C2yzm3VYL1hxSY/kcuAUvGnfQMKe5ZOcqKRdgd+zYir9wP4KqYesH9X7p+fGCN6s/O4zgS+E1/lpWjyNPcyb2VeNEJHh+GrSYY8/jX7UY8va6mNvOlb6nnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053990; c=relaxed/simple;
	bh=39L7K2G61+561g3+CI2tnEk652pmBpSfAqBwbE+VTkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qzU6QcuDiPVNaHUtEBSfMMsbdGnpscTqrlBX9vmJdXbnlw/eLdhAwQXTdRXrP0/BR4hfvSu7RkXo51zVLUatNMKtWJPsFoDEH5bc1KGEGXHCRWFrQ9kw9KWEFdHLBdehXs1wrRx3A6b/ZK5oL+b4VvSbxrZCLQvvoQG/Cd93LVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=I2vALc+A reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d746ce7d13so29873115ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053988; x=1707658788;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zkObaXrwYZL3Whc2v3FDZXnZaEc+cfjpbpTR4g/kNso=;
        b=mGHt5Q5NjUydHb4S4qPr4ZWPFe1LTrJ2gEB9huatPRT8uVLl1+lfv/IQ7T+HA+le8/
         KAdn4/WVXExEk/26IwJrSQENCiD699B+AmE82U77tQmHnhHOhybg1HeFVgzijR49u0ae
         UIidF3epRJ1X458ueVPhnCrhHGzqLyFwWCHClCnmPxLQwHi7MZtdWp3eJrWOtcczPkUR
         3IkQNLmLtmgqIqem6whkpxsrJ5gv18/XT8rEhIx1n6BstiVSfOA5+rS5gDhsN85RJ6R5
         95nvc0VyAL2cgy0py7Rf4PzmJZOcGBl7KA0mmkTs4wOX7+08Xg9lBPzB/QcNr4OpR34T
         xAeg==
X-Gm-Message-State: AOJu0YzwvMt+o6JpJZPDZGLyJv9Z1RqMZChpDKcmRKfpy/MTBYm4xtcm
	att/FV+m3E5htarJMCfezCkYGM3kOT4o0ztrAakkaoMS8YIf40W2
X-Google-Smtp-Source: AGHT+IFYK42rn+5ZcYN6JAIbs0gBYEkZswQ4I9afgJLJI+eXgqDc7uQHNAMxASkYsS+XR/xFzY5GIg==
X-Received: by 2002:a17:902:6b0c:b0:1d6:f185:f13b with SMTP id o12-20020a1709026b0c00b001d6f185f13bmr9655143plk.17.1707053987794;
        Sun, 04 Feb 2024 05:39:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0LxPG/wq/voT8GuT2mXE4TKOZznSYDIaV8k5n8A58zMwyD2/cQtoMMXp58HyJOGW8iAIpA2NXO7BIsRLt0sICZc2fatgDgZ86xL6+QPtjxOIDyHITkPnMik1F7wv4x5bB0Hq3z8Lw0ZnvaIjTPzvy
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kc12-20020a17090333cc00b001d7137acad9sm4643253plb.57.2024.02.04.05.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:39:47 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707053985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zkObaXrwYZL3Whc2v3FDZXnZaEc+cfjpbpTR4g/kNso=;
	b=I2vALc+Aohm6X12DjLcfxe3MtcSAbBMKWMXfCYO9h+xjTlSvmxAd8VxzKlprh8hOMJcUv2
	IohZrf8DtX9gsCTHhYuzsWHW7g69P7HJBpvFVLFqaeiqYZilT3ECrgIaE6w0XZz2S6IyCi
	Wf2Hsw2ce/hkJL9F7eM/mfUQt3Yab/PLauI8tYjDbr5I2yiesjXlc9d8wjJ0YOrWaKGaaf
	ZZ4ezdnQZXiRmjucBKAIgb5DPL0q6QA/0O+rNEhSUqu2aWKAjwhUMqfK5dOYUMNEHxP5Sm
	xPfNoe0NbZoiokL4zA9QWDNGXYjX8sYfIAKlT1OABV63t/rdLo1ziC+g/XVYVw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] time: struct bus_type cleanup
Date: Sun, 04 Feb 2024 10:40:14 -0300
Message-Id: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL6Tv2UC/x3MTQqAIBBA4avIrBNMLKqrRIQ/Uw2UhWYE0d2Tl
 t/ivQciBsIIHXsg4EWRdp9RFgzsov2MnFw2SCGVkEJxk+JoV9Q+HfykDXlbNbUphXQVKsjZEXC
 i+1/2w/t+GIVue2IAAAA=
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=39L7K2G61+561g3+CI2tnEk652pmBpSfAqBwbE+VTkI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5O/VvRVcHeRY3MVnpWAJN9ZuCIvEfSoZsxDD
 0M8oGBEXUmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+TvwAKCRDJC4p8Y4ZY
 pq2ZD/972OuQdA0Fgux1CO1vppyWfZcOw8cy3QXMlGEuxFtxo/B22V7ZyWQAAzWgFY1ZRVY2tN2
 YjUYH1pcp0inAj1wkCYv/VlsrLaRZx6J+pA54AZuAvRLAsYihqbwOyxvjozQf5XhYjRsW84IWQb
 MvyiRH0qgR2UyI8tnyNeV6dByTVAV38+bGp79a33sj2l3raR5H1f2ooNAn/JjlpEw1GLjxHhRIm
 1IC9kyqXQW6eHDSnXftmVCvNkMCIfxjttSiLsTziMJdyTgxL6lQ+P4cAKxKmqLQtC3+RW16E7b8
 5E0ORDYcDUiiETR2xNLHHHtBOxJM5DqPV2HPSVkaagsyQT+DojvSAVi743RUK4N7A2+Wp0iji/A
 7lIseSBqHcmxfU5/sZhQXLL1rSY1TggqFc6jRYJfndiqV4kuv1MV5/iW1scoPgJBG+/RdJHaitE
 p+SMaqKTabMwltPJJAFj7ki5sRpis9AWDv1GEdU23pZ310VtuqiS4TofsMKvSbEqItIj9vM2nLG
 IQcd4Fte/4uMVVMeXjrkXUUzHonQZac3ThLMud44lT2ya14jkU+hT7lHHKTADlkbPWP0B4gMwvD
 V9WomN095PNfFFbO6pmV2ki5ytQSuBALplFJWqBOVBLMlkLsUKi/0Qrz83yN6o1iaw6GsBZAApo
 49/msN/s7JtK1tg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      clocksource: make clocksource_subsys const
      clockevents: make clockevents_subsys const

 kernel/time/clockevents.c | 2 +-
 kernel/time/clocksource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
change-id: 20240204-bus_cleanup-time-9586b102d5e4

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


