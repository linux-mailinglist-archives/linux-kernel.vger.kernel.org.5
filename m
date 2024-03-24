Return-Path: <linux-kernel+bounces-112881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89906887F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652841C204FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292518E3A;
	Sun, 24 Mar 2024 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/3Gnc2W"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0933EE;
	Sun, 24 Mar 2024 22:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319659; cv=none; b=jsCgTwxvHlS8Sa9rBNWz9uUQkN8w+diqO5v7aRtb9/Xd7MRsAD24N/SBPpvehyn8bDbVm6SPvpvK1qtVRcBqptmm1DeIttifdXdt6Fz677KIxEANVvkv8Ivh8HHlIEct8R+F6flJq1pae5bRFV8ZXj3BEi/mwMmACRPrtcRQd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319659; c=relaxed/simple;
	bh=AqFkJFWBvaMw+zfMIgl3xomLAFFq9YqqVutllV/J8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kvx+ouh8V0KNQoRdZ9QH+a45UJ1TpzsfIe4NXfSYh6H83paBpWYx3K6yqqE/r5Fm2cfg2qCKB8MiQ5/4oDkHzrj+JZDj8mfS2DcdS/VdcMmtuv+odTdfnoLSdB3YQG8dfKtQkH/tbr3jYdqsruiFz+YZuFdfMMGnuJ0cjMZk2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/3Gnc2W; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430c45ab240so23744001cf.0;
        Sun, 24 Mar 2024 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711319656; x=1711924456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TsjmfCDFGITGTAqlv2AZ5kLiFTR8eAn1Iun3m/vv7Ug=;
        b=A/3Gnc2Wt7+jsAIf3IeVRMzSBblaEg+T1XhgFXkbOvwIYNEFuLYW4loJgFYrhAP38d
         GkEqLIy7GbCBhrwylznEPRkZwcC3fJsrjVHE4qZDiZas11hZVlRP3BUwqNhFRiMtI6xA
         ZP55spNdydB9eOFYy5esegnMfUic5MZU5mR8lcDArSE7NtOXdN1q+dLQ0Gzuz2/aQhPG
         0/BFsDxYBalRU2Zrdv+WNYmw/koBX1qg6m9bOGapCSqASS+ObQIp+dz/68qFlb0R9/g7
         A9U1NcBe2pxhbp/6SJmNsE3vvvbAjfP+UAN5aoUFa88CRv2HbgvKdR1eyRx89SYNGZ6f
         sW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711319656; x=1711924456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsjmfCDFGITGTAqlv2AZ5kLiFTR8eAn1Iun3m/vv7Ug=;
        b=TuqQwbIsyqOpAFP9df9xXY9Vht6D7PqEPx9+uMI03aW/cjtfWlZ99BJJcda2d6HfGV
         AwPLrEOZ+Hkn6zZJXVTqXtUgMnZe/BUfHDJwiAqMaXzObiMbwHJC6FQwvfEZE5KZQSDl
         B7xYWXzGj86jm68hcpwjCkk7IS49Y3y9dzbQ9U6N+s35o6UXiXPyasq1GshmwZ1pFXyT
         EobO2thPUoNAtEyZj/Ax/mRojyCX1fLb06Hg7uiDykLh+5Ijh1VUGJr7+Do/xnHvdOL/
         B5E8C78OVvEsgJnRA9zOQ3n8yqIYpKu2lhWYgxj+/B+lmpaO2LUIFGMKMy05siguvLCW
         8/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXLa9l5XAJWybbLa5jG2celyo6K6EE3i3yCKWfHlkAquMrUVFqGecSdBEXUGhpQF4M4uZ4N2zAs+oQIWTvcAYsId5H7CpeG5vjZQlTy
X-Gm-Message-State: AOJu0Yy0SRdWduETvKEFlGtrmRbOlvo5/IU1JJ4RVQ0PWRC/dTtslQgH
	sPZbjXMPWjUHoYHBL6ook9xHOGKMwaOVKKbHvjhYhV1+pan8yRqg
X-Google-Smtp-Source: AGHT+IEOveF9UbntUxmeb+e0X61SQlJ1XyQ4o/IbANscdGDMXK1a8bNLPOHlN158zX5Jwmon2vM0jw==
X-Received: by 2002:a05:622a:1883:b0:431:2051:4798 with SMTP id v3-20020a05622a188300b0043120514798mr7069993qtc.14.1711319656564;
        Sun, 24 Mar 2024 15:34:16 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id f9-20020a05622a114900b0043140cd9996sm1755194qty.38.2024.03.24.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 15:34:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 71CE81200032;
	Sun, 24 Mar 2024 18:34:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 24 Mar 2024 18:34:15 -0400
X-ME-Sender: <xms:ZqoAZskVdGmhQOS8zL2KIdPl9geuz2l8sxA5agPqGeyZnsaQ_m_KWg>
    <xme:ZqoAZr34Qd14dUXkNabIm-LIgo5ExmDOIQWaCjMhEgv8T2I2dwM1vg_u98kom5Nl2
    1GDt0DnbBxL8gXrtA>
X-ME-Received: <xmr:ZqoAZqoOLaavqJWSMA12JkWf0NCkI5oXgaJvJn3Sr8xPhNnm6jVRCHKNpZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfhvghn
    ghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnh
    epgeegueekgefhvedukedtveejhefhkeffveeufeduiedvleetledtkeehjefgieevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZqoAZolm93EPyBPofGZoKueO3M_toAm3XE2FVD5v-g2KF84iBmOTpA>
    <xmx:ZqoAZq2CBV2j-2HAjZ0s696N6F6pryw7hyWKd_eUpbVSvc5XkpJMMw>
    <xmx:ZqoAZvutIo04m9R2uAi5HY1CWg1xhSiCLR-FzX3zo-9Uyw6MTWr_hw>
    <xmx:ZqoAZmUnFcBFJsq-LJC7JrwoO0do9dzJy10kxJykkTMREJT_oyopDg>
    <xmx:Z6oAZl0mNwEreChwyMQeU908jCwfiLLrrv30bQ8p_bW0fSdk_a1utwiczrY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 18:34:14 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	benno.lossin@proton.me,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 0/5] rust: time: Add clock read support
Date: Sun, 24 Mar 2024 15:33:34 -0700
Message-ID: <20240324223339.971934-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

This is an updated version of:

	https://lore.kernel.org/rust-for-linux/Zf2kio8NYG5DEgyY@tardis/	

where I'm trying to provide the same functionality of Alice's patch:

	https://lore.kernel.org/rust-for-linux/20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com/

along with the lesson we learned from the previous discussion:

	https://lore.kernel.org/rust-for-linux/20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net/
	https://lore.kernel.org/rust-for-linux/20230714-rust-time-v2-1-f5aed84218c4@asahilina.net/

There are three important types or traits (the design was mostly brought
from previous patches):

* Instant type: it's a generic type for timestamps, whose backend is
  just ktime_t, but it has a generic type to differentiate clocks.

* Clock trait: to read a clock, one must implement the `now` function,
  in this series, only CLOCK_MONOTONIC support is added.

* Duration type: it's a signed 64 bit value which represents the
  timedelta, I've considered making it unsigned, but I want the
  following code:

  	d = ts2 - ts1;
	ts = ts3 + d;

  to work even when ts2 < ts1, but I'm also OK to define it as an
  unsigned.

Let me know how you think about this.

Regards,
Boqun

Alice Ryhl (1):
  rust: time: Introduce Duration type

Boqun Feng (4):
  rust: time: doc: Add missing C header link to jiffies
  rust: time: Introduce clock reading framework
  rust: time: Support reading CLOCK_MONOTONIC
  rust: time: Add Instant::elapsed() for monotonic clocks

 rust/kernel/time.rs | 139 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

-- 
2.44.0


