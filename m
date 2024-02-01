Return-Path: <linux-kernel+bounces-47506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6F844EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A431C212A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB54C79;
	Thu,  1 Feb 2024 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBtqqqWR"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F31442D;
	Thu,  1 Feb 2024 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751732; cv=none; b=cvyaZj8/7PoOFTwfkcSU+rBY6Eqsu19Gv7PuMkvAtMKklHYSXlBNVR/zuRVmWTS07mLTaxjofx5+J4G+ljUgnXtawognt0vrl4C1e/8dFmQUQAsX8hfEwXCpAJHZWBqGVZTSOLB44mIG2/9s5fpYXOCt1U5sA5Otljo1+0ahaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751732; c=relaxed/simple;
	bh=efwyMItElJetn/Fmbvc9IiQmkNvaw/WmkGfc/vk+kLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roq4JQ3uQDxDYwikAP+AfLsU15riq+qgDujaGU2OpnBB8+fJL2GXd36pBZuvbPgw6AAlxLwY49h3ciOMyyEJc9UGm2fkGbWFHqWRuCX0DgEpEAmpuRG3fr5n09JxHVbYnzXQaGZvGD1hTVF2joSeN9IGTNeVD2uv9MHdO/Oyoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBtqqqWR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42aabb1cdaaso3294121cf.2;
        Wed, 31 Jan 2024 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706751730; x=1707356530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh6Ffd8hFONsbNouZh9tTHMRXHfYbfdTSU7EN4Ui6ec=;
        b=OBtqqqWR/UmbZ3lqFEdmm8G+h6w/1vBDVlnIVJapR3akdzdbBVyUl5cD1B1WqInsXZ
         7TZ1aGJhdZxrGXRgm5iWPhEXgScrlj5kwjDJ9Kdq7/zCAv8PeuICKtP3fG3Sp2IoePef
         PzeJvj8+FCX1Mp9sTxEFztK9f00ObPjupV1fwnqvhLaPNayl2zmAHtsSlz7kZrAxjtmH
         45UwsgblED79Bay9SuXcM4Ql7Yuh4f+4mGMZvrIddb32Gar+cArb97cSKYqd/VzslQ64
         X15FHKyJtoHnJN6qecnwNahpnORkj87UL1RXHsqAk0hNtWeAu9GSpvmPuHjydVdKDm+t
         48Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706751730; x=1707356530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh6Ffd8hFONsbNouZh9tTHMRXHfYbfdTSU7EN4Ui6ec=;
        b=UiJl8Weu2a2Zpu6TZds5Mv1NzDBD2NscS7DWY5ufVymhAeE1neiqYyKUbw3GUQCL2w
         tIsxKxTJQT6TFkv5h+cGhSnfPFJ7hQKd7/C2fcA50nP0LS2pxw3qNs9yzd1BntU8SYJ+
         DEsSqtcEjXdkP67VSn6CHfc1mBMRLRkdkwt+3ssJxUdpY1NwH+kcLX80gb2jYKwz9cId
         SdYq02xXORtg8dU4u9V4t0TiifgWN2U/8tFWj+rFlfagK8IYQHlD1HaWwJYPl9o1WO5d
         l0YS+CLkbQaZCKVRrpK6dB7+F3SnjCqrls0xwDCzNBl0yZ/ZCV8xahaeE6zGBiRqq+Vg
         CVtA==
X-Gm-Message-State: AOJu0YxSbhSTcv7yaVromojTXLVQJeeKXyCSVHE+eIeTf5uF+6+JsZ01
	MYwdgRpczmJAKWOhExX2E3VS/8bKAh1XADZf3uJ+okwcrLWxA9NB3RCBJns1
X-Google-Smtp-Source: AGHT+IFOWnXn2P2Y2VCCYfIza1FFKtc/gekxJvIwwFYETDHWeAKoegJoj7OBVetlAfDRMf8lVLaiCA==
X-Received: by 2002:ac8:5794:0:b0:42b:e44f:2032 with SMTP id v20-20020ac85794000000b0042be44f2032mr845731qta.3.1706751730113;
        Wed, 31 Jan 2024 17:42:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCURKo0WkmLsMqJJbqX55qBbyBL51ZzDiNz38r0vcdDE27eu7GPcfiDy/Ix89AeCotULtyrdd3B3TLAnrPowZPkMisj+
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bz23-20020a05622a1e9700b0042994b3c20dsm131165qtb.29.2024.01.31.17.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 17:42:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id EDEF927C005B;
	Wed, 31 Jan 2024 20:42:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 31 Jan 2024 20:42:08 -0500
X-ME-Sender: <xms:8Pa6ZV5i9idX7CaPdCcIDAUgwoqwAlixE8Fm1f8_UahkiFdWHCQhHQ>
    <xme:8Pa6ZS5y5toUsEhDaIYN2_W4Y-WXSfelmZh4nkg7mNOJYiB9iEzg-e-DIDalJ2O5A
    cAn7EGv5rQAz_6nig>
X-ME-Received: <xmr:8Pa6ZcdJfFzPVQVEqeKb46Pw3ipreNbOCfrBkoqCvBVDIoG5n8M6IYEtOFR3Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfftddtkeelvdefleeghfelleevge
    ffteehheeljeejudehueejhefggeevfeetnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:8Pa6ZeKfi-UiSEMvCm-xgpKdH8h2OH2lQQzUV8sgjoPXYSNA2J1oWw>
    <xmx:8Pa6ZZLjs8qcaWu1WwDaAJWKPx4Fqcg4VzSoEFZuZ1joUFvPI2p8XA>
    <xmx:8Pa6ZXyti9RMZPLL5fB1NDmwZnBGTW-F5QG2OsLFevkvHhDxOPmEfg>
    <xmx:8Pa6ZQURbSpDp-8uY9sO9dv65UFpRnJzun8hOCXxkMLdJPfPoeIrSQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 20:42:08 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 0/6] RCU nocb updates for v6.9
Date: Wed, 31 Jan 2024 17:40:52 -0800
Message-ID: <20240201014100.3204532-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains the updates and fixes of RCU nocb for v6.9.
You can also find the series at:

	https://github.com/fbq/linux.git rcu-nocb.2024.01.29a

The detailed list of the changes:

Frederic Weisbecker (4):
  rcu/nocb: Remove needless LOAD-ACQUIRE
  rcu/nocb: Remove needless full barrier after callback advancing
  rcu/nocb: Make IRQs disablement symmetric
  rcu/nocb: Re-arrange call_rcu() NOCB specific code

Zqiang (2):
  rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()
  rcu/nocb: Check rdp_gp->nocb_timer in __call_rcu_nocb_wake()

 kernel/rcu/tree.c      | 53 +++++++++++++++++++++++-------------------
 kernel/rcu/tree.h      |  9 ++++---
 kernel/rcu/tree_nocb.h | 47 ++++++++++++++++++++++---------------
 3 files changed, 61 insertions(+), 48 deletions(-)

-- 
2.43.0


