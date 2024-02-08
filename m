Return-Path: <linux-kernel+bounces-57834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4CA84DDFC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AFE2849B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14296BB4B;
	Thu,  8 Feb 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jB4/BiFb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF546D1A8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387533; cv=none; b=iAxMhfwJKlVHYXSBStbOXo1VlM2ew64sEpzWNTrIS5f20MmDSs5eA38qtuGDQJdBVtFT+alkGhdcvaFi/GFG19bRZLpEYwwGnx1gVEPr9FuDsxN6fAxFGpwrrzdUGbKUdz09OHlPi92pRvUtUF53gvYO7i10hgYKxyQLPOzMYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387533; c=relaxed/simple;
	bh=+wnJqL+pqGvJcwEHa93fmS0oXb5TjuFDPjn/Uorknjs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dj4DmyCONmG3lwn45WTygN8rJ8PZUmjojSsDPJHWEVRm9RHya73Ty8BMylW9v5GTAvus1Spn8uzZVludao7qAXCWIBqN9BOZzWx46IpyqUdUc5pkaVCpnunstO0uxHNcdARj8cI2cC1uDWQgRQCoimHexpysmtQk3/ZOzEquVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jB4/BiFb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a38291dbe65so192051466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707387529; x=1707992329; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3l3rhYnvc20HMeICU1VJe+MdTxuoHKteQqL6qQ8unM=;
        b=jB4/BiFbDvXzCzynzmAuD5C6DIwNLQBrP3G1CpsI/F0VpIyiaADzlF4slsJIrvsSMw
         pzDlYynZDMe4/CK38whOh03tOL4I/ZeWJ0EGsdUB+8pcbUa2lEtKQet7G6XBa+dJ/Tp+
         9tOBpKjd4r/iua1FxG1B6i3Tx46sKtsEBdlZI/9hBZ6weLmiTql+yKSGJVFvleWZpWqa
         FTc4gPKqM6qBb+7BVPd/kxyE99xlARsXEdXTvTjxX0hzk7Klicd/d+kxUMeot9xl65FS
         UpVVQd7WVqtSwnztK/05g8CPDk+fJlcxVxZt2xAlCuiXXEpTO73O5jFVmiVNWc6bEY9m
         8v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387530; x=1707992330;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3l3rhYnvc20HMeICU1VJe+MdTxuoHKteQqL6qQ8unM=;
        b=WBxVGMLa880+zgPB48EKlzdMM3bJBh+6GPL7UgNa9AQ9tMoj/J7LalZNS8st1yIMnY
         Go9ZGST9BUEsr0na5rKEDpcZg5eyjo0+GQqol83OBouLs+c4++2aAbUA/Uatci7MO401
         oNdMDVr/XEJHmzJSmrFkkQ4daf+2uZ8z8oc9fNucaZIlsC3nWmFrs9/7vOHYDZ4fGB3B
         HCBMUFjgD4wBMhTZTHFCI81Fbix47CcQjBrupDNgoGxxOZDt13fuY+CpEJI90kx1a9tM
         9BRwk1XjzOSZ0GY14mMw50urZwYw2BfXIgbrfw+5Q8p7d+bY7XZ9lvXgmvJc3T7h25Kc
         o7Uw==
X-Gm-Message-State: AOJu0YzaUP3zfbF7TFhm3pA8MOcV1SvDQLWprttyGmYbCED/6wK/GlbS
	Lcrc3zvzsRo4OeASrdzIAHDwZay8ZEG70B47lLV1AfsW4rxBwkAAqHvwbhtzWLg=
X-Google-Smtp-Source: AGHT+IE58kzQNKsgAZE7QzdfSsUOh1a2HwCrg81I60aaDwW7QliqB5Rtf2DpP5/iwu31bmTlV+6Qew==
X-Received: by 2002:a17:906:386:b0:a37:3b00:199b with SMTP id b6-20020a170906038600b00a373b00199bmr6727416eja.30.1707387529681;
        Thu, 08 Feb 2024 02:18:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnj0O9VjVBXDc9EkEsJ3HBmiZix7NO1jblKXDiOm1U0BHjdFpDjp3SJVaHoWpFWNli0Kt74isuuHqJVBtULNlTVxyshw92DSgDV6EoUgv2kQnnqDnMpxlugArvm2jsxuYn9h3Faz4AQUffrBdCto960O/HhVY/hhA+F5ZbmGjtCkRttyKq3t4ELUsrmOW0sSSa4f8chX043hiYVZP5gO+Ts/tiRUYRph6Wjy2ZkW6umKwYRnFi0my/gVhwF3+gIEG/qjwVak5YyJKA6cm9cEBngYeTah+VhqQ7gCQKe28OqzdNmgZKJWtaAQRr56XrXyfx9KcDTU7TZPPy7VfeNbRuU4sv0trFfsC71586wZrsAxh7YDLujH4=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hw19-20020a170907a0d300b00a376d1a18adsm1753615ejc.98.2024.02.08.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:18:49 -0800 (PST)
Date: Thu, 8 Feb 2024 13:18:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aurelien Aptel <aaptel@suse.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cifs: fix underflow in parse_server_interfaces()
Message-ID: <05c63e91-ce29-40aa-807c-ac730181c83e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In this loop, we step through the buffer and after each item we check
if the size_left is greater than the minimum size we need.  However,
the problem is that "bytes_left" is type ssize_t while sizeof() is type
size_t.  That means that because of type promotion, the comparison is
done as an unsigned and if we have negative bytes left the loop
continues instead of ending.

Fixes: fe856be475f7 ("CIFS: parse and store info on iface queries")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index b79b6bbd7103..bb3975dc9072 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -620,7 +620,7 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		goto out;
 	}
 
-	while (bytes_left >= sizeof(*p)) {
+	while (bytes_left >= (ssize_t)sizeof(*p)) {
 		memset(&tmp_iface, 0, sizeof(tmp_iface));
 		tmp_iface.speed = le64_to_cpu(p->LinkSpeed);
 		tmp_iface.rdma_capable = le32_to_cpu(p->Capability & RDMA_CAPABLE) ? 1 : 0;
-- 
2.43.0


