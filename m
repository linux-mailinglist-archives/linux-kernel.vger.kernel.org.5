Return-Path: <linux-kernel+bounces-88787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E894086E69A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AD62871AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39D6FC3;
	Fri,  1 Mar 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtaHTXd2"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F392900
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312569; cv=none; b=ptI38QnX0RbVMsW5Rkj9wDNdxDWpR09U+HbLFnAAhV82ky64DnhGVZdRiAb7oU2Dom2iAktYf5tFUc7reEEImvsex+byxNSb72anYZ5r39MCmBXPmDToE4Dao/jk6h+h5sYEkhKIkpfZuEzk5Jal3JQrCWWn8aLZcaXHsLIDZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312569; c=relaxed/simple;
	bh=Bkj0I0SUh29zp8LIZC5qKKF3Hbd577+hfaSUf1YEdc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XkCrhe2PAaYNqfbWJVdDAa2znuNWbTfjO9e7GPVouNq0+sXg7xwg1/F7+0K/OQspp8ZWBSi0OD01rP+HOB5f1aT9XDeUDtYUWKBJToGJQ6gUr7tMtjitkUlW++v2fH6uhSM59xNukYed3DDvwdE4G2jqZdbMrEmn9pfqLw9Q3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtaHTXd2; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-365a681e949so8559995ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312566; x=1709917366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFD7+EeXbLhZQK9aauwPh9/7nmAnd7U/WxWooQh3Jh0=;
        b=DtaHTXd2GGQrUM2fIBU2Cync4GeeHq8NpEN67Jd0xrEVD0eFFWB5oquPzjMoRDAMF8
         q3zFbqytcXPq//4/XEGIEChla8MLdL0LDiSxRp4745ExZFtq2o3lM9rSKAjxR0wIPqZH
         Baet6OabZI7YQVdNCNHUETkMsbabkMPieSlIvBAjPEhtKHMqYqeqy4j9jitl1pJICqgr
         KFymXH+C1vSj0Qvs8fe+wFa7lorZ2hMhnGp4XNPwL9sCvIdhShkfuJ+n3Mk7/asmi1Vo
         ZS0PLHWLwoB8s9jbn739DUXOtAjapMZK0V87qCkLB16B0GACXLf6eqG3iWgb59nHQUho
         ZJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312566; x=1709917366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFD7+EeXbLhZQK9aauwPh9/7nmAnd7U/WxWooQh3Jh0=;
        b=NphY8XdimyzZw+46tHcpRoS0753BFtal5893iZrne/E1eGr9kDeQicsKWHcmyHXEDl
         jACSM9vK18NzlsUt/+INgvzcnf3JkJkIXBlcNbtUS3/yhRw5ZU6ZAJZsuvI9DtENOQNN
         okPD2coIFCrcPzVvcxmJcOOUEMmRZm+VqWrwfHf7ECfp8Ujl+OgwmPh3IDs5SPc0iOmf
         ajXwcvnqUIjpypevl/tA0K7Qn7DCnUhElrDUGmX0F5zeem0vtdYYffpck6/qZp0hQM2E
         wbDMlF5ShGp1erw8ACdu725dHeVuBOJr35TXieBBLxS14rJ8hVCvx6Od6wl4sGBKXvER
         9AFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf+zEyRaObdbHN/Sl0jCu1+gGdsEKgkIAEWNqmqpQicuzUjC6HTBu1RKege/coNYX4mvU03wenHp/J3iQNGUWgm/HyPW5du0Pb5SlR
X-Gm-Message-State: AOJu0Yx3o0S1M+zhUZTKdmCndFmeIDxlAbVRaPyR2JLOy2DhxqeQ6otY
	BXKn673/WZG6yxK/gf3XBJi2OCL+mf721OpXhVI97BUDxHyefWK2JsnrLBCLh7U=
X-Google-Smtp-Source: AGHT+IHeHUzCtWeB4wOCTxMMiaIKCpRduUo3dp5evXrqwq4J05sRXrRhKHYPTJR2WbAJYdAIWnaYWQ==
X-Received: by 2002:a92:cc11:0:b0:365:1737:d78 with SMTP id s17-20020a92cc11000000b0036517370d78mr2232767ilp.17.1709312566559;
        Fri, 01 Mar 2024 09:02:46 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b0036581060910sm991430ilq.6.2024.03.01.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:02:45 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net: ipa: simplify device pointer access
Date: Fri,  1 Mar 2024 11:02:35 -0600
Message-Id: <20240301170242.243703-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version of this patch series fixes the bugs in the first patch
(which were fixed in the second), where ipa_interrupt_config() had
two remaining spots that returned a pointer rather than an integer.

Outside of initialization, all uses of the platform device pointer
stored in the IPA structure determine the address of device
structure embedded within the platform device structure.

By changing some of the initialization functions to take a platform
device as argument we can simplify getting at the device structure
address by storing it (instead of the platform device pointer) in
the IPA structure.

The first two patches split the interrupt initialization code into
two parts--one done earlier than before.  The next four patches
update some initialization functions to take a platform device
pointer as argument.  And the last patch replaces the platform
device pointer with a device pointer, and converts all remaining
references to the &ipa->pdev->dev to use ipa->dev.

					-Alex

Alex Elder (7):
  net: ipa: change ipa_interrupt_config() prototype
  net: ipa: introduce ipa_interrupt_init()
  net: ipa: pass a platform device to ipa_reg_init()
  net: ipa: pass a platform device to ipa_mem_init()
  net: ipa: pass a platform device to ipa_smp2p_irq_init()
  net: ipa: pass a platform device to ipa_smp2p_init()
  net: ipa: don't save the platform device

 drivers/net/ipa/ipa.h           |  5 +--
 drivers/net/ipa/ipa_cmd.c       |  6 +--
 drivers/net/ipa/ipa_endpoint.c  | 29 +++++++-------
 drivers/net/ipa/ipa_interrupt.c | 69 +++++++++++++++++++++------------
 drivers/net/ipa/ipa_interrupt.h | 22 +++++++++--
 drivers/net/ipa/ipa_main.c      | 60 +++++++++++++++++-----------
 drivers/net/ipa/ipa_mem.c       | 37 +++++++++---------
 drivers/net/ipa/ipa_mem.h       |  5 ++-
 drivers/net/ipa/ipa_modem.c     | 14 +++----
 drivers/net/ipa/ipa_power.c     |  4 +-
 drivers/net/ipa/ipa_qmi.c       | 10 ++---
 drivers/net/ipa/ipa_reg.c       |  8 ++--
 drivers/net/ipa/ipa_reg.h       |  4 +-
 drivers/net/ipa/ipa_smp2p.c     | 33 ++++++++--------
 drivers/net/ipa/ipa_smp2p.h     |  7 +++-
 drivers/net/ipa/ipa_table.c     | 18 ++++-----
 drivers/net/ipa/ipa_uc.c        |  9 ++---
 17 files changed, 197 insertions(+), 143 deletions(-)

-- 
2.40.1


