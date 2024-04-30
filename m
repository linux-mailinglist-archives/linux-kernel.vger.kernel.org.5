Return-Path: <linux-kernel+bounces-164649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302BA8B80A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55591F24658
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03B199E95;
	Tue, 30 Apr 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b="eW5L7EfS"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C66199E87
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505716; cv=none; b=XeQEeFpHpG1yu016L0pc04QYkg6fQ9urriH2YO43beA+hBbMUaJlGw6FXQ9rZgLBE+BiF4yj4N5gwPn6Kj3I9Kdrq9OKjDVMEw/Qh68ZY6s/bi9rnU8MFAUttVydjoDXT+x9wXiWp3ZEGi7Bog9ccRFXMN8rIt0hWddtvOvzdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505716; c=relaxed/simple;
	bh=8VoMAvq3zO3JVqiphTJGZqYC0YcLa4T9AVNVLehqUQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jgmMAWvP2dI+RrCdUZEU/R8dPLkJ0nLuZE0jpGBwRhZXRkYMpRAApqchR4QCuf+H18QK4LxwzD7IwpCh4hLjGN0xGhYPDNZVdBZPqWwtQ9EDs+OzG1rSGRhDzj0ghErSEiq7wZpsYpf/laetNdIINEwzlB3hWk6xtap957jn//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com; spf=fail smtp.mailfrom=bluespec.com; dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b=eW5L7EfS; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bluespec.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78ebc7e1586so17471085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20230601.gappssmtp.com; s=20230601; t=1714505714; x=1715110514; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkIPuP+CuWN9tKCMSVVGNkNWpD1n57mvYpOJRL642BE=;
        b=eW5L7EfS+DZQQuw6+gpxz+aI9APHdEVnOIubMZqG6Od+J1aaZ5fi4XEhZNCC+pc7Z3
         y6VpTW7S+0kK9zGw7l/kVOUBMquLGzNy2XiTNAqxIsP5tizKES31HLbmGO9tks4Ed43B
         T1TeQP3Xotp4TmRCNSentvpRne9GOIyrZXCP8nVjgFpGOITWkD+QCVhCynFI7ayCW2ZS
         0CkqURMOdG4XEXVbgr/J4uLyxc6+69APgh5CI6POr8IsoR8UzNeuvgBq0gcePZHvicHK
         Wv1TM50JVB5g+aOwdnqLrC7s/eHrYK349UQUKepEd+vcsMNZI56sx+8wuhQrdbjv/dhG
         +JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505714; x=1715110514;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkIPuP+CuWN9tKCMSVVGNkNWpD1n57mvYpOJRL642BE=;
        b=XZ1yVl4D4vsPiJQEfBefSQhGWtokIITJAcOX/1TsObtdp+DN2kYgbQbFMEQgDLG/Fg
         OmkGprZgVFMXtZ41Q2EmcSdqairR72PwNTxcmWbERT7u8k8EuZTSwNngwo6kXFah5A22
         UHAPiMkVM30ofPw4tFINDLeUqu8gWAkr7uiKRt0Qf2yhrUib5u5MUMleOIuJtVVKoY0K
         WdSg8FTFMTwVnXSPwP/ccRPhZ0FxGYucv1RV9OrBnHYHKDD4LxQCEUn/tcrGHJFwXEBV
         YcLlXTEijEov/CfXkTXbjsP1Qci3YQ7B3AF7mDgbup9qUpA0cjxbIXWlSoGGjNYHM5XY
         899A==
X-Forwarded-Encrypted: i=1; AJvYcCXhazfc2srjjdHV+p71V/esg1h5bo8ZJlPWq36gJSXusVqm8Cs/G/guQR0oMnbvBymmeYEuCqamwBBlLCHRPA8e0Uu/JzF/SIt1O//A
X-Gm-Message-State: AOJu0YxUAY/xtivaCI+ZuCnHFLM8Jh8ngvxYaYPSWF9cU4u7BukmZq8k
	2XUQxYnbylS0QuWJJ5DSXrCyMXMTVGmd9FulgEzs65XMacmyZWfvXzv2mCD5
X-Google-Smtp-Source: AGHT+IGBKXU/7tRSFz93Y1xzcjPZPQaoRweolkwmfOyZ1X1BJG2s1+KA1acju3jrin1dLUxC2l0LEA==
X-Received: by 2002:ad4:4ee4:0:b0:69b:6b28:f941 with SMTP id dv4-20020ad44ee4000000b0069b6b28f941mr7236867qvb.20.1714505714112;
        Tue, 30 Apr 2024 12:35:14 -0700 (PDT)
Received: from localhost.localdomain ([102.129.235.205])
        by smtp.gmail.com with ESMTPSA id mg20-20020a056214561400b006a0cf4808dfsm2100850qvb.45.2024.04.30.12.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 12:35:13 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:35:09 -0400
From: Darius Rad <darius@bluespec.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: Warn if insufficient queue length for
 transmitting
Message-ID: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The transmit queue is stopped when the number of free queue entries is less
than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_MAX)
is less than then this, transmission will immediately trigger a netdev
watchdog timeout.  Report this condition earlier and more directly.

Signed-off-by: Darius Rad <darius@bluespec.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 115c3c5414f2..72ee8473b61c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 			set_bit(guest_offloads[i], &vi->guest_offloads);
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
+		netdev_warn_once(dev, "not enough queue entries, expect xmit timeout\n");
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
-- 
2.39.2


