Return-Path: <linux-kernel+bounces-45179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAB2842C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017EFB223B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3E97AE77;
	Tue, 30 Jan 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbV2uy9a"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6347AE5B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642591; cv=none; b=tCLvXK2GN8oXK0jkq9topXcRob5GDgxaNUWC9fWoVi6+T11q0R8FuLulZ7+8jLy7nZa7v8D34rqKz6CoaAWRwqpvFsJXYBi6Gz716K3kKoBx+C+a9MNRoVmQR5C75oG1PxeDaIaaMTVvGxzIxzqxRJq2Wbdi48x/cHrlE7EdmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642591; c=relaxed/simple;
	bh=/g3haUgeZ/8+Nw42/YTKe8O+muHqCzLO+7xztJ6Hfqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ldkQyaCGXK2yw0OY2uPBmrtUtLsnjC9S5XSPWWJ5io1oQPKllr07zZtKpiXI7pcVC1b8LfszPKq7hLczfpbpMU5LNIU2FMbApdhP6CykhXmPd/wNs6Xwg+U733QliHdVz2TlIiYVpkNHQ5qLElCkHlC4TjvH5CKqgfSZ0tybGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbV2uy9a; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3637e03eeccso7776375ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706642588; x=1707247388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWblHEzv7v7VHVoPCU78pyWv3WLms7RIEZWppnMaxvs=;
        b=JbV2uy9aZhYQSZBgCY8QH0EXMal+vGmUXDVMzS9miLj8DkOoLOhYZFIuxBwcWSiSmM
         rJGURQoafisdLejo1P7W5Yt0Fi5/B5HqC/fodw0uOLsguOB0tG4dpxBTPVzcM63aWDpH
         bZUdmdnti2g8IN24z/0pZxQ/8KvAsWvReuShuH1uu4/BwvOfGIAMiwBdieTZCN6zE0dC
         cykLUdV2+eWJ702XzvXv7NXkFjacPNUstteVcAv0sxo/K4zM+8g9f6LwHiKl/F2MUGbA
         9o27FbVSwDgASZmtG1GlYs7y/fcO/wF/9MjpisI2kWCl+BtZF45jY5bqS5pztmo/oMMC
         xhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642588; x=1707247388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWblHEzv7v7VHVoPCU78pyWv3WLms7RIEZWppnMaxvs=;
        b=tQRgIgpzK1OUp1OpLcsOxo07IOFNjP+Vlzundewcty7/FKvzGl7Hzztk3903FrjlKY
         8Z2ZP/F1VANkZ4UxPUkNS9LtXebZ+Uw801L7074TrJ/W/tdtMB72LkRRwWyrst0Ch2FD
         PKnJz/I23JCz6tAte8peeiHAsRgd5+XFblzy8Z3kBAtGi4py1UTJSusGmGFUufL6U/3f
         P3f3mddQrEKkezT3FPUYstxug9eGE9u3ZpYiCWOFdiJEJ14Ybb9xwDhhbmSwkoz66pFd
         KprM0K1b0aW5ZMcgHX8INpFLS4Fqfug2Y+gfUACwJjpzAKV7F6tvEJtgaR4RFVWfhjy8
         ZbeA==
X-Gm-Message-State: AOJu0YxZcwhAQNiAhKhH3lyjNdrw6ox/5UvACRw+7vhL4ki82VZXGRaL
	amFQ2QsYoi9lxeBF7x8vZGMjnOuYzTlPvdU1N8B/rydyChJPRAusHGJl87R75Ns=
X-Google-Smtp-Source: AGHT+IGdnNJX7dSNOtu/weQASGztD2zezNrmEFXP1MoAhqg0SIblOhPZ2Zky6rT+PKSzPz58xRs3tg==
X-Received: by 2002:a05:6e02:ec4:b0:363:8def:88eb with SMTP id i4-20020a056e020ec400b003638def88ebmr2388328ilk.18.1706642588636;
        Tue, 30 Jan 2024 11:23:08 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t18-20020a92c912000000b003637871ec98sm2157762ilp.27.2024.01.30.11.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:23:07 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: simplify TX power handling
Date: Tue, 30 Jan 2024 13:22:57 -0600
Message-Id: <20240130192305.250915-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to deliver a packet to the IPA hardware, we must ensure
it is powered.  We request power by calling pm_runtime_get(), and
its return value tells us the power state.  We can't block in
ipa_start_xmit(), so if power isn't enabled we prevent further
transmit attempts by calling netif_stop_queue().  Power will
eventually become enabled, at which point we call netif_wake_queue()
to allow the transmit to be retried.  When it does, the power should
be enabled, so the packet delivery can proceed.

The logic that handles this is convoluted, and was put in place
to address a race condition pointed out by Jakub Kicinski during
review.  The fix addressed that race, as well as another one that
was found while investigating it:
  b8e36e13ea5e ("net: ipa: fix TX queue race")
I have wanted to simplify this code ever since, and I'm pleased to
report that this series implements a much better solution that
avoids both race conditions.

The first race occurs between the ->ndo_start_xmit thread and the
runtime resume thread.  If we find power is not enabled when
requested in ipa_start_xmit(), we stop queueing.  But there's a
chance the runtime resume will enable queuing just before that,
leaving queueing stopped forever.  A flag is used to ensure that
does not occur.

A second flag is used to prevent NETDEV_TX_BUSY from being returned
repeatedly during the small window between enabling queueing and
finishing power resume.  This can happen if resume was underway when
pm_runtime_get() was called and completes immediately afterward.
This condition only exists because of the use of the first flag.

The fix is to disable transmit for *every* call to ipa_start_xmit(),
disabling it *before* calling pm_runtime_get().  This leaves three
cases:
  - If the return value indicates power is not active (or is in
    transition), queueing remains disabled--thereby avoiding
    the race between disabling it and a concurrent power thread
    enabling it.
  - If pm_runtime_get() returns an error, we drop the packet and
    re-enable queueing.
  - Finally, if the hardware is powered, we re-enable queueing
    before delivering the packet to the hardware.

So the first race is avoided.  And as a result, the second condition
will not occur.


The first patch adds pointers to the TX and RX IPA endpoints in the
netdev private data.  The second patch has netif_stop_queue() be
called for all packets; if pm_runtime_get() indicates power is
enabled (or an error), netif_wake_queue() is called to enable it
again.  The third and fourth patches get rid of the STARTED and
STOPPED IPA power flags, as well as the power spinlock, because they
are no longer needed.  The last three patches just eliminate some
trivial functions, open-coding them instead.

					-Alex

Alex Elder (7):
  net: ipa: stash modem TX and RX endpoints
  net: ipa: begin simplifying TX queue stop
  net: ipa: kill the STARTED IPA power flag
  net: ipa: kill the IPA power STOPPED flag
  net: ipa: kill ipa_power_modem_queue_stop()
  net: ipa: kill ipa_power_modem_queue_active()
  net: ipa: kill ipa_power_modem_queue_wake()

 drivers/net/ipa/ipa_modem.c | 96 +++++++++++++++++++++++--------------
 drivers/net/ipa/ipa_power.c | 71 ---------------------------
 drivers/net/ipa/ipa_power.h | 18 -------
 3 files changed, 61 insertions(+), 124 deletions(-)

-- 
2.40.1


