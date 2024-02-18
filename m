Return-Path: <linux-kernel+bounces-70543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5598859905
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A401C20A24
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7ED6FB9D;
	Sun, 18 Feb 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="MRHOPFj9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0EB6BB4B;
	Sun, 18 Feb 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283855; cv=none; b=HPrX/OlVGhgTAPeulPo3m1JE87t2u5sr9yOWPtsGEh+8cXKJAzekfUt7nSVDImLgVF1SVV6+cphbE3b7VLU3z4K3nNyF7fT7Nj5XStPLf/KqAdC1dF+5sO5oe3ZDA8WuoLYvZfjfVfT2Y0qQWiBLRtpMAV99Z0d70i8gjfAT2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283855; c=relaxed/simple;
	bh=6GJYJnEYvcK/tf09aTbDx+ptD0yLjYaCAgUY2ebxhSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aJDx7BXDlLFOOr9b0LCEghFP00woOGd5B6+cBBuaOA3VsTu9VvGZuXhNlyeljK2+FWOvsBGfmR4LaNPyp+qL9Vqz3NhOKyKNKNZmWTP1kOZxS5XvUgn0chOfnlE+DrQJlRZKNn32H/3VsiqxtAvW8RGKGxoyy0rim0H6JbICRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=MRHOPFj9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e45c59fc6cso262519b3a.0;
        Sun, 18 Feb 2024 11:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708283853; x=1708888653;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fk8ukIs7uHZX3iUzXQ9ugL6dlcSfSv7TsYZrgqe3wyA=;
        b=sKQB/nfNxh1uTUwE5iMH4+FvPTqXKkNFOYqwHYu1gW/Qlj8RM7/b7+Hh7E2CQGs/9k
         jnpFOx6DG6I5IrGOxyrKMfX9Iymp2nrdV5CYDpdvdWhPu+Kd9YvU2Re/l4RXBIy1ZzFN
         uYQf0qVjOa0r75Y57TNguD9GxHnSMLCcpDfuyE8aok1ZXfL5uxdGAFkKXq5nNNf/vl8l
         dd6NVkrrv52Lf1GAJr8M5i92aSFNkqJhAGS0xPtC5FG952BVgZDdmKKMEITAyGtnIT3n
         oLsZuTuYjmoXEjwIfhEMPvnADlJNqsOKVCV7N5TSjZZi+hyKOlDILX2Eb0rh8FWsaGn5
         UOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX34ZH27npQxR0a1yYXN4W7H+Bjmw4x1J2zJ1O1bTot8bsMRJ3FrhgA0GKBlSpt9KL+NGLaFB5hfV7c0qgfRTImlUaInsw9ce7Ksd6l
X-Gm-Message-State: AOJu0YzpeYwBf2PwD1F+vawix66pfdyjQS0rhJfib9R1VD7KUyGyDpLu
	h0v70ThjjVAZLMiNCIn558ojQXsUySEJQ2zufCkGryutqMfnXNQQ
X-Google-Smtp-Source: AGHT+IGhBNi9Lw6FXwXRzIebt731JMDf2A17N2sNhIEye6zeVbXhui6MOUFTBGKONdiXEvxH9lnYIQ==
X-Received: by 2002:a05:6a20:c4a0:b0:19e:b6c6:8f15 with SMTP id eo32-20020a056a20c4a000b0019eb6c68f15mr9120711pzb.25.1708283853089;
        Sun, 18 Feb 2024 11:17:33 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id s19-20020a056a00195300b006e4648bfee5sm275405pfk.161.2024.02.18.11.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:17:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708283851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fk8ukIs7uHZX3iUzXQ9ugL6dlcSfSv7TsYZrgqe3wyA=;
	b=MRHOPFj9Fuw29IUIQuHv88ixcRHkksyIRDMvBSwQjjUSxuyjdWyoUgrLj3K6ZvJLTmxIb1
	BGiiVuQVC01CHgYhbRIX/TfmLnzuCjVpQErRQultSc9/5UqO38jpzd1YSkryitvHHuydQ4
	dmbCkq1OWdwrB21XoCrL0RO84X+HJg8RVmzYluhYMfwJw/6FGi07j/DZwuqbwvCBBss5f6
	BE9BZM8Ib/p2McmpJ2hhFEppJEwVyQYmsKm9s/FItYn7bWHCPkeQ5YH5HbHWMPwyfo6cas
	QOhVqs6vjmlcGk1iqL64n5M6kD6NSF1z3eISE4zQTJDg6+GGiRhNvYresusfuA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/4] usb: constify struct device_type usage
Date: Sun, 18 Feb 2024 16:18:08 -0300
Message-Id: <20240218-device_cleanup-usb-v1-0-77423c4da262@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBX0mUC/x2MQQqAIBAAvyJ7TlCJsL4SEaZrLYSJUgTi35OOA
 zNTIGMizDCxAgkfynSFBrJjYA8TduTkGoMSqhdKau6aZHG1J5pwR37njY/aG6vQCzkIaGFM6On
 9p/NS6weC5oeeZAAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=6GJYJnEYvcK/tf09aTbDx+ptD0yLjYaCAgUY2ebxhSs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0lf0XrVU59zxdkDbhqM5QpjMXi6CKG6M3iVkP
 O3KAmgT84CJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdJX9AAKCRDJC4p8Y4ZY
 pgMXD/4w4M8hTVUeQ03i/xH8L81HmRX73jPaVTutmQfmyhtNqSLpvmz1C5hjPyqJ315QO5nIafM
 cnXLe8T/enzPM2iPm6v7ONmllalJU0Qq3jlW1kyCrabbrFVu840zc6PqTfc/9/H9v85e68FB3nH
 Dq4UEw2W7HQCiXn9J9CsFoyOQ3HRfn8K18vqVGRObbY1vqDWhDA0dVDvvb0srBrrnwyhG5eXvOk
 fSntC2IM4IA8f/bdt/+6juGP5+/q7LzwaiQMZtNwcAXr/HCQTqBMrmUGNDA7EatsM0L626RRINd
 ojChGNRtQ1xhD7RGyM1v16/nkwXHFOkcEfFdzul1AMQjjtlu1N0LnzI3Ks5UBll2rxYWJbJfe97
 ni6rP9+0O53xd+BKSoecgPIiNjk19+cAiLWlx7ff1fI+eO6Rb/3vkWcWOT7iymAayI+ujavlDlG
 Hv4QGmf1BRBZxY9Px7ERDBPaKTBPxEOtrznN2vofwwflF4ox1WraEsQsGcrB2w6S+cJEpgsPhO+
 yhhG64K6VBwRQbNs/lwHlzQ7U4NZ9bn7+QjXK14LUoZiLT0oop6VcXW392F/J/MJj06/LAhWjKe
 yCf+JCQQyxcSRbIIpLVGJwXGHpz8/4RKS/akIleyNDLJw2vOM5JzMG/gVGQ8YkcSIjbG4yhM0pi
 bKVAYl7RABeNT2Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that makes all device
types in the net subsystem constants. This has been possible since 2011 [1]
but not all occurrences were cleaned.

---
[1] https://lore.kernel.org/all/1305850262-9575-5-git-send-email-gregkh@suse.de/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (4):
      usb: typec: constify the struct device_type usage
      usb: phy: constify the struct device_type usage
      usb: gadget: constify the struct device_type usage
      usb: core: constify the struct device_type usage

 drivers/usb/core/endpoint.c           |  2 +-
 drivers/usb/core/message.c            |  2 +-
 drivers/usb/core/port.c               |  2 +-
 drivers/usb/core/usb.c                |  2 +-
 drivers/usb/core/usb.h                |  8 ++++----
 drivers/usb/gadget/function/u_ether.c |  2 +-
 drivers/usb/phy/phy.c                 |  2 +-
 drivers/usb/typec/pd.c                | 30 +++++++++++++++---------------
 8 files changed, 25 insertions(+), 25 deletions(-)
---
base-commit: cf92b9df3dcf45eab0fe3fcf9e97ce55c31c48c0
change-id: 20240218-device_cleanup-usb-98fac2ef0160

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


