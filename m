Return-Path: <linux-kernel+bounces-65878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922C855331
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC571C24E51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4C13B2B7;
	Wed, 14 Feb 2024 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="maPFus1q"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D070134738;
	Wed, 14 Feb 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938878; cv=none; b=U+FzfC9SGWy2ZN8SbbcxZa3gRn4dEzFGpqvUup/ae1SOlDEU3SKQp942SZGaFTZNzaPO5cAz5/rJ7svFKcq6x+RQMffOuI00YTclCs/YX38Rg2VDP7PIkbS+8pXfWkDoRu/fXCLrWnCtGmHZkUfSzgQixbix+WZ0WD4JcHFBY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938878; c=relaxed/simple;
	bh=X6od+QN5zi3KBcLvJ2WmLsxhFSgPUZijlXB3ig3ROOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EtxEp+xTxWDtzIPkTvK8UxFdeq7D0AtVV6/JRVKMJSCb3/YgMeBs6ekL6y7Uk6RPiy6UmnwK03lUmsM3afX3UOvo9gclRIilmziOAssMrFKGBWkNHvxySxQcWeVk71PfVx5QC3nR0ukZUoET0YTNUPVrJpaHQODFAwQ9Sha01c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=maPFus1q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso114927a12.0;
        Wed, 14 Feb 2024 11:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938876; x=1708543676;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KnjRLwW6qeAAWQgWTvjpbNM3OaTV5ZKjGAIc59AkD9c=;
        b=cDBLg11p3+V06d0mLwDtO647sZxB8W2F5drP1q0nIGC2kF414iCNMkhQPgBx4zzsjA
         dcsa0sncFqecGKFOIkQcqedjnwqA6t423gh/QuKKnuo/h0h1KYR+c8XVM+HA1pn7R2bg
         soUUdnAvRPH3mj9oe1xKEMPvEpmeIxHL78T0cJc0gZ1TvbUoVaSS8WQ7Qe0+Db2XioJr
         DFYp0bG36+mVOGDISkUzI8zVp9vr/b/PgyvfmreeEZz9Beww9xYGpVikY619tBYKw1/6
         O5evc/RP4BUlEeQvQrj2kp6+8C+dWBhzuEvW0XxzhA43OcMxQvmhHSnDyEXy0hbAAF5Q
         a/SA==
X-Forwarded-Encrypted: i=1; AJvYcCVGc3BtdcfInlYpAfRPZeKW3/R1RjHAXtni4JTmtq47mRXmpDvI9riptFgXSeRIY3r7jBwO7bqGHm2nRlU8FHOz0MGNPNUbUPDdHNnxvFSa3hxqQPoW67QQn9D5FlTOHdOtRrVoG4iJTz8=
X-Gm-Message-State: AOJu0YwW5rzii2arxXzy7HffWlyeZWif0K2S71d0B/6b1ucomu0k6gyI
	mP135CXnv5CVd7njWb7XcRFiUOqv2MHTs7bybXLa4PpVVYqg+Yt/n+SJ5+BcVD9Gpw==
X-Google-Smtp-Source: AGHT+IHegGu1Lc6JHujte9HWk+U849QrRHwoSPJSqWXl8c+HXhJmNQ+qoZKZb3gAFc+W2fsg/d5Lhw==
X-Received: by 2002:a05:6a20:93aa:b0:19a:fa19:23e7 with SMTP id x42-20020a056a2093aa00b0019afa1923e7mr4662887pzh.55.1707938875745;
        Wed, 14 Feb 2024 11:27:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUa34KWh09rSYQyE9nF7fJS3F2IPd03THcCf9aU6FQa3IAiDx1LsWllRCgEoniJtv6tsGHfNIO0J5zRs4HHxiXtfuO9TRPplBhygbzpf3W1S417xhgXdaxak/bluiAQCC+BEUqkffVilz9bdq2CvrThtjeRQvhINJOjZOQVpnZ8ycw8ED62RTnUoUNr8R9Fx/74p4zsKsu+ZRRbF6LfSZFgEsj8SrOFgBOVuY1GkZ6eM1U43plxZeDsTM59OBmUJBVFwQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ei52-20020a056a0080f400b006e0e4b9b7e6sm5566104pfb.212.2024.02.14.11.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:27:55 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707938873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KnjRLwW6qeAAWQgWTvjpbNM3OaTV5ZKjGAIc59AkD9c=;
	b=maPFus1qp9Xv5h9LhLO+NfqqYYnwQda7r95wUFaLGv+wjMlY//L1rO5mAM6+NuhKi900w+
	Lf5zn4iwdVvNADXICzlFQiYMjZttHE3P20l+6DMp6IPvf/VhZEh7A7NiTtGPASS2aAkMGe
	TrAERZ6ibNQcJkNcxOeT1N5ZNTVPay7LVnGz2rffqx04lf3yZ5I/8H1I8Ueq4EVbM4hqP1
	TToN3I7P0vSlPM7R9mdo/8bHDD/BljTvAywkAYlKB0zy8cGEHEQDreR9SXYfAH6Zp8roGy
	iYj+fS6ZmfupGcZmd1seEa+P4SjvDtvoL1WYG8GdzG3n3qYiGwK+OSDy0ongtA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] ALSA: struct bus_type cleanup
Date: Wed, 14 Feb 2024 16:28:27 -0300
Message-Id: <20240214-bus_cleanup-alsa-v1-0-8fedbb4afa94@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwUzWUC/x3MQQqAIBBA0avErBNUsqCrRITZWANi4VAE4t2Tl
 m/xfwbGRMgwNhkSPsR0xgrVNuAOG3cUtFWDlrqTWnVivXlxAW28L2EDW6E2abx3vZHDCjW7Enp
 6/+U0l/IBlrASWWIAAAA=
To: Johannes Berg <johannes@sipsolutions.net>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=X6od+QN5zi3KBcLvJ2WmLsxhFSgPUZijlXB3ig3ROOk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlzRRgqD50Kjh/z7zUDRvFGQ5rgpOi5V2O2AYGX
 hIUhjfS3WCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZc0UYAAKCRDJC4p8Y4ZY
 pmcbEACD0T5RsUDq6fWHxNRzwotB+m1utHfTeWp77RvfXLKoZZIAHgmzUfz9dS3PErdHFheGoL0
 xKFWgt7H4f0/0/Yo3BJjY8Tw76AwIM7o2bGowLqAeFhJWdY12hSKPUPwI2IWTA4lVuXhm9nlSxP
 VQ5d8P6ISLYq71oVht5jOQmryblOVTmJ+IUoV81ELF/lFFIaQHM8nUsMtlKhls5m3U0nqpdA9Qn
 B1yvd6yIInkH2xrlR8LXpIwUaCnkmycURdEiwVNTxEKu0vNcnk0RXGB6361bsP7WYiZkAIP6EsP
 iBDMvJA4w8B+m39Rtvr0N837wC51+FmezpSNFXcd45iyIes4y4UMt0Cn258Xqlwkk8fZJlGFfqI
 BpTtlvAV5H4SnFovK3tpFGB9kaUQtlmiWriE82PYlrgppFS608qDCc8VTFUefNpLl+63MlTf7bU
 eUtVvA1eSMoS1TjO1D78+AX+0rwTr1SyO8cWnf5NFWjmr2wfEUWIC96OGYMBwmPC2FkKTAf85+z
 Hl/TbRFhpy+tW4dImZ1e7nO9rSN3ytLFR8cgUuTgD79cMBmV/08exealAOZHHV3tGm982wreRXJ
 mlTdedLshYOHDS3IEnMt3cNEcgznRJkKX1fcUXs2MbvZT/tkAgD5Sz4Q4kd4FP4AAQvc6EEC56/
 oVLkY93fN75xWWg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]).

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22

To: Johannes Berg <johannes@sipsolutions.net>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
Cc:  <linuxppc-dev@lists.ozlabs.org>
Cc:  <alsa-devel@alsa-project.org>
Cc:  <linux-sound@vger.kernel.org>
Cc:  <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      ALSA: aoa: make soundbus_bus_type const
      ALSA: seq: make snd_seq_bus_type const

 sound/aoa/soundbus/core.c | 2 +-
 sound/core/seq_device.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: d7bf73809849463f76de42aad62c850305dd6c5d
change-id: 20240214-bus_cleanup-alsa-1d05ffc6507b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


