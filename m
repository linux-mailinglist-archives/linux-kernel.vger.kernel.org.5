Return-Path: <linux-kernel+bounces-43651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8955A841733
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACDFB21665
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3515AAAA;
	Mon, 29 Jan 2024 23:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkMa8rbx"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAC5381A;
	Mon, 29 Jan 2024 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572683; cv=none; b=nKePk5Dqs2yz8qT/IQl3p7/Esmca2Ms57n2hacg75A8Cm1+N8mgtzRGtB4RcDcQrNDdfrBrCpv9AA+7trVrUeQPgLVHyFrSSQg43+ZJbGfCui2fOGi8BhkMs4gsUMyPLE8tCjXQ/bfQCA9AGLlrwmeOSCh4fhQgjdQkvtXzdMGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572683; c=relaxed/simple;
	bh=8hkUfts92hF0qkVk+zqYtyn0Ec8uWcBGMdPrTKwOhyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmVMtbXPKizW23tWMk2rsWtV47EKyzLBDHkH75b7paO1OH9DAUs9ervSt/gLbg1NQGaMbWKLTZxMvgsLkvimwf7ApOdCtW1tXwiukW5ox2OaCtm71J+Y7lI7U7vsonMRUdV5FSmLEueswi4V1qYgejBMRxGFTTbDjfytDQC55ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkMa8rbx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a99cbb4bbso13768751cf.0;
        Mon, 29 Jan 2024 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572680; x=1707177480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5avTDWbGVtFpQCpIY6d6OUGvnoChm0CpOn9puNFgy5c=;
        b=bkMa8rbxZOg81s/f51LN1MXJR5hGPQnE1EyhmxH09bjucFiAlC3FfAVspSSZoCIYvz
         MSWOP7of4it9XbV2c5RwhDmmqXt1C4cRCWCQfnTcpXgF4QdHU1DpHRLh05AZWR9hmD3S
         8at+0I+FXX8ogz3Xm1fzBKWaD2K9aKiTLzL6ZDAXLTMkStjhvq5EPm+kbcOyOOGEYzTM
         0SB94uuhQ4RsGrycnkhWmngp/VMmwiPbjms2nN5yd7Iemgj2vw9f4QhlMLmj1S9wZ5AR
         37pPndkNSI/IYCxmnnq+tJA9I5eFoEr0s28Ft/dlcekKMkn4kdNJxUJj8qzJs5CGUDrO
         7bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572680; x=1707177480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5avTDWbGVtFpQCpIY6d6OUGvnoChm0CpOn9puNFgy5c=;
        b=FLQ9c9LfOwqexBxxFbHhsK9Cczuvz7mdo3Un+oRrXA9apWsnL98Nu/ySeu4IJ3BfQt
         KHVIvj71dBUBeKTWGx8ihemAk9iDpgnFIo7YLssa6spbD9kzM3g1zaWMCcwRAXtDfQXm
         a/2L+xga4TF6cftQK4xwAtdH/EVckuEPwrFnr0QUtw8yX3iSKxZbueVDeH5/NcT1ArhY
         pjcLW02RfKBdYXOJUGTbQSgbRMzzSuqBgwMrKUa4AyZ1a/fcMqG+ZUnw6V2/t/duJVnL
         C/svtIiCo0AqgogR8fO3kC74eyv3zxJMeG9KabM04mjF3VT0vehEK0W9Rpcon98heJOy
         yYrg==
X-Gm-Message-State: AOJu0YwJ7FNM0go2DQeX+ZyLtmj+MGV0V0D7W4oQNPUZvf/9IrCZoiz/
	OIQ1rAzEycFJPVP/UGtmF5CScb4hTagVqhhCeDhkfPAvt0bDFbG2
X-Google-Smtp-Source: AGHT+IGQ3OBoGB2Xzwed85HzW2vqF9Wr4ggv4YuIMwdrCSN6QXi5cuQxvTkxKxMaf8jv00VCkFixhw==
X-Received: by 2002:a05:622a:448:b0:42a:b64b:1fc8 with SMTP id o8-20020a05622a044800b0042ab64b1fc8mr95296qtx.58.1706572680231;
        Mon, 29 Jan 2024 15:58:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVJj+StFWvymcfZq25WkauCA4IhBQRa2FW/a1p4NYOnBz78lPL4CbD3GF0O0fydsYz+jElpWDQHZTUl8wHBvNwIKe1qC0F4q1K4qxju+qqLlmL66VDjEwPyYjmNOXPRAcu4e0rXO1ztgSGpzvtwZ2uNmUj6uVssxBkY4P2FArYtjzL3F4AZXYllJwz3qqhljVcWQi4CedjKGWVL7vR3dISnSRbbcbCgguxTof41YJMI543WNyR2KKCLwpMwc4BG7AiB8l0SqzKyANe9m7nX+FaWtFxM2inTMrPNMB6t7epYS6XKRhT3tGD0W19r+R1JfFGRT3SzniLxgbX6VTK3cBwlZzw1i7IdaEKnsQQldHMpUyDpj3n/CzQszFEVmo+XrH4E4zKt0HThE0zn/hL1BpMe
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id cn5-20020a05622a248500b0042a29013f15sm3876973qtb.82.2024.01.29.15.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:57:59 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 75AB61200043;
	Mon, 29 Jan 2024 18:57:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Jan 2024 18:57:59 -0500
X-ME-Sender: <xms:hzu4ZTzXtuw3wHArPLUa5lfVb20TYAStr64v_RcYC61M2FrnMxfiBw>
    <xme:hzu4ZbSof8q1PpXG8PIi9aQiStGbHSYhJaK4e-y1l6Prww8kgHDwAzV7Sc8cjEyMW
    8ZwoaEfzkNcQcR5Lg>
X-ME-Received: <xmr:hzu4ZdXkPH8oJInvFk2yFeh6_Ppk19srLJKqDPUU9fDSKdCufMbKnCe95ztKtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:hzu4Zdg4xNEiopyvOkrREEmLbAJcGpmuofbALPLFGyizcsiqqG1p7w>
    <xmx:hzu4ZVAIAo_RhZQ9mpazlwzhruvemEXnZ21EDFoRjMIPlabNiiDfeQ>
    <xmx:hzu4ZWIG_EGl7c1IGPBS-vrCwDsPUMfYWzit5WBtVyYLKYcuHIY4rA>
    <xmx:hzu4ZdZ9d_0nMs4uFZmixMzv9JLj7gBda7v3IP0eGp2-vk38pQS7__F7g0I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:57:58 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>,
	Waiman Long <longman@redhat.com>,
	John Stultz <jstultz@google.com>,
	x86@kernel.org
Subject: [PATCH 5/8] tsc: Check for sockets instead of CPUs to make code match comment
Date: Mon, 29 Jan 2024 15:56:38 -0800
Message-ID: <20240129235646.3171983-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129235646.3171983-1-boqun.feng@gmail.com>
References: <20240129235646.3171983-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The unsynchronized_tsc() eventually checks num_possible_cpus(), and
if the system is non-Intel and the number of possible CPUs is greater
than one, assumes that TSCs are unsynchronized.  This despite the
comment saying "assume multi socket systems are not synchronized",
that is, socket rather than CPU.  This behavior was preserved by
commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
update callback").

The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
Clocksource Drivers") back in 2006, and the comment still said "socket"
rather than "CPU".

Therefore, bravely (and perhaps foolishly) make the code match the
comment.

Note that it is possible to bypass both code and comment by booting
with tsc=reliable, but this also disables the clocksource watchdog,
which is undesirable when trust in the TSC is strictly limited.

Reported-by: Zhengxu Chen <zhxchen17@meta.com>
Reported-by: Danielle Costantino <dcostantino@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..d45084c6a15e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1287,7 +1287,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (nr_online_nodes > 1)
 			return 1;
 	}
 
-- 
2.43.0


