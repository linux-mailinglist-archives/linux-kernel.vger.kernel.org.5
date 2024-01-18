Return-Path: <linux-kernel+bounces-29671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7F831189
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDE35B22E81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE06FBC;
	Thu, 18 Jan 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PHPfExvq"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5F53B4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546307; cv=none; b=FcBJmgF8VWATFfyJWqpBV//HysHGqCL9NgTF3jrLJAKZUZ0wQcnD9fWEBOtUkCsg4jmiPq1x9Q00QeleZujkI1bQsm+n+fBrQ/He8QSc8LG6eUI/ohfRImyfiyCRCZP1lVRawbftuWyNPP8f/jsscyfmy4lWAUE3TjZR+Sva4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546307; c=relaxed/simple;
	bh=YHhFdreFP9ZE/+rucVuzbm04/JKcvfDc6wo5uMXaSX8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding; b=ukeH0lSMl1uWyHLw5WDB7MaWgKrRMAXZiq04D8CeK33HTajkTGQcLF+qOW+La9TmXIZV+jg+S6bq5ASjQZptarfFfejSB1ykQUyJx9ryXlL9/uPwIb7i0ZHSQ8hxnk9vISJm/S+j68biL2iTDRHHZBPgQ97rzMjoag6Y6dWIdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=PHPfExvq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337b976773fso2335294f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705546303; x=1706151103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5JsUOgz+DPxJOOyNlG1B9EN9snqbFszTDtDaVe5HBM=;
        b=PHPfExvqFP9dNkw/o1LSkVNxh6G6osL4+UztZaPS6M0NUeISe5flKcZVRQz+UKZbVW
         oARqCfAPr6CwtY7/naIvTKlrEGSe8pfSmeWSIEE40dcrWIQbuERvvrGEBd1jlGLA+XBA
         0iEMeDvqlD9WrkZtuA5HFhzlH+OyYaXe+sBgWo0aNsrdHQTjjfUJkJpgaPJxvcuViza3
         U4d122bRIWi8OtteFp87ekFHFOkw2nCY5vDX2LAiDrHT/Jeg03xaLA5S4Zh4SZ+hOsOL
         EWB1sxcXlXH1cGAIGs2DeOW9Aa8a8sTZaWoN5S89l9kmZ7NUYqgz5ZxXrAFT3gun6z0G
         qo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546303; x=1706151103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5JsUOgz+DPxJOOyNlG1B9EN9snqbFszTDtDaVe5HBM=;
        b=MAUsrNtnoR/hgEYakFt7SmLt5eZga6iTxB802AjNfr7T5Z9OOC3b88LtcJpGHQp4Sp
         Jt62afjW1QCcclc5+GJqjpL0b8fY0zBKb/eVBouVx4B5gNNHabfwlF/JkcF/7JscFzzh
         aJiEel7cFJBXZ0TAYlaXC3OwMDgKzpz/Xvd1bF3Rttvj++Ok0yYyz152nwWWD79m/w6q
         ahxgtAIBVpveZgv5kmHclP+bxd0OJgOleOjwI99F/GKbkHTM9RMBFg9Yv3cyv5VvTY/U
         rM4qnj9kmk7Tbxva7N6yCWnD+FCPlAFjlUM4qmZ9q8rwL8i36BssKaHL2A7AgOQDi/qd
         8/wA==
X-Gm-Message-State: AOJu0YxlCRcXhl/bXP5hGSHUIZp67x+qTvF7UySCn5FHFDL/nC6PrCVO
	E6tSArva7JXOSo6jtmHgeDTg8VRFknWyABwcSt1AVthNr8b2z/lFASHltDj1iQ==
X-Google-Smtp-Source: AGHT+IGuu+Qi2Tx2cCYMGpPYN+O0khIiJHE3lWN6J6IrC2aFuK1G0SyFIM92LO01t3+UwG9sk29NlA==
X-Received: by 2002:a5d:400b:0:b0:333:44e2:16b7 with SMTP id n11-20020a5d400b000000b0033344e216b7mr79098wrp.49.1705546303326;
        Wed, 17 Jan 2024 18:51:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d440f000000b0033664ffaf5dsm2868219wrq.37.2024.01.17.18.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:51:42 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] selftests/net: A couple of typos fixes in key-management test
Date: Thu, 18 Jan 2024 02:51:33 +0000
Message-ID: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705546294; l=736; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=YHhFdreFP9ZE/+rucVuzbm04/JKcvfDc6wo5uMXaSX8=; b=E1xkCdz0M9XB7LOyp1foBBxJnUvlo7QXSIQqLpKlLQB377ZXUXuwOvQUCG4cuseiQQNIU4E6N RodDkay3j8aAB5yco4ZxHozCAOJCI4dCrc0vyqgUf83CsOC7UR+yKr3
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Two typo fixes, noticed by Mohammad's review.
And a fix for an issue that got uncovered.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Clean-up double assignment

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

 .../testing/selftests/net/tcp_ao/key-management.c  | 46 ++++++++++++----------
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  1 -
 2 files changed, 26 insertions(+), 21 deletions(-)
---
base-commit: 296455ade1fdcf5f8f8c033201633b60946c589a
change-id: 20240118-tcp-ao-test-key-mgmt-bb51a5fe15a2

Best regards,
-- 
Dmitry Safonov <dima@arista.com>


