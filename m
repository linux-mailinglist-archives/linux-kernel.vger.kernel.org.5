Return-Path: <linux-kernel+bounces-23659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0982AFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778B51C23CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F1739FC0;
	Thu, 11 Jan 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTJMqCPh"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7A360B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dextero.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3371263463fso2955769f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704980003; x=1705584803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/99NiF4A2BrTs/f1i+EHbcfLqSPcc4NdjFBKleOmWo=;
        b=mTJMqCPh/qAXXDHnpmoi5TWFMznXrMRQtdZelVoXy5Hz+FkQ2bMyGkmx60+BZyhike
         TaxUPC40OG/qo9Zc9KhTKM9k4U1Gd5vv4mg47b5ImE7ONrW1veouz3AGHgXuxmRFuItL
         PN+lWEDsX8lsFj0suCiPcOS1K8iq2kXI41ptbkX4y8V7e8YelyXRb+yGctprrQj6BeZ9
         kjh2Yv721PX/zzsxWe7ICMgMnrCWtDTD6P6ae2QmtJ42U1E6PBYg5tQ75dZfqT9gnzd1
         apSBBTuthWTaRGpQpxEeI3B4wQQcOE6mj1EVlNo/HSuHq4n+Q5vADLLCWu9fTPlT2TSC
         oB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980003; x=1705584803;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h/99NiF4A2BrTs/f1i+EHbcfLqSPcc4NdjFBKleOmWo=;
        b=Gg9ycIiQTwZYAElqDa/QOZn4XQz+yiKE5kUIFGLC8iuD/2UUCNDqCdnKO5qq09nRcf
         EqLrm+7kWieOugd0flrgK54GOfVrDqjy8mAdkCEuVwEzzcV4wcVPNxyF5JWiJhK73Xmu
         gws/QdJlm4PFfhC8oLCgpD/BU/9CTHuuoEG7PrXrnxHp7CVxaK/7JrkluuTBYKmw1HXQ
         ZKGrS+gJzm559AW84AAgLS88nUL5bikvP2cQNqMrUhiD/u26tb0r654DLkXMHH/lsFKB
         ckSaQTJyttrEwv5ahQSeGeinNnw4GFJHS+mIdzDei5YORR+yKUhrywFWGgSXFXaaGFCo
         E5+Q==
X-Gm-Message-State: AOJu0Yx+qqtoACZAlxKnbtAR1AfayVzb5w+RcabXPuCBioWf/NIJqwYW
	GVVuo9mPKOZFtAKo8PVNklI428ct7qTunEaV6+Y=
X-Google-Smtp-Source: AGHT+IFsuF9J9DQ1b9o9M0B0uCNQ4u2/hpHiLtI0CB158k+7cM7TbsSjNtoX1gjNCAU74IrCTBCB2sPeakzF
X-Received: from dextero.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:364e])
 (user=dextero job=sendgmr) by 2002:a05:600c:350b:b0:40e:59e4:6563 with SMTP
 id h11-20020a05600c350b00b0040e59e46563mr9699wmq.0.1704980002699; Thu, 11 Jan
 2024 05:33:22 -0800 (PST)
Date: Thu, 11 Jan 2024 13:33:20 +0000
In-Reply-To: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111133320.2717702-1-dextero@google.com>
Subject: Re: [RESEND PATCH 0/1] ALSA: virtio: add support for audio controls
From: Marcin Radomski <dextero@google.com>
To: aiswarya.cyriac@opensynergy.com
Cc: alsa-devel@alsa-project.org, anton.yakovlev@opensynergy.com, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	perex@perex.cz, tiwai@suse.com, virtio-dev@lists.oasis-open.org, 
	virtualization@lists.linux-foundation.org, vill@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aiswarya,

I was looking into VirtIO audio controls support in Linux and came across t=
his patch series, which seems to be marked "archived" on patchwork [0]. I w=
ould love to be able to use this with mainline Linux. I'm wondering about t=
he status of this series - is the feature still under development, or are t=
here some concerns that need to be addressed?

I'd be more than happy to help with testing.

Thanks for any insights or updates you can offer.

Regards,
Marcin Radomski

[0] https://patchwork.kernel.org/project/alsa-devel/patch/20230209115916.91=
7569-2-aiswarya.cyriac@opensynergy.com/

