Return-Path: <linux-kernel+bounces-160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDCB813CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50049B2182C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F266ABE;
	Thu, 14 Dec 2023 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UHh9nBU3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEF66AB8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-20315d10afaso23943fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1702590347; x=1703195147; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c10wTDKGWx40+Vti3rmzZrdQoTCm+JYREO+5RZnJZkA=;
        b=UHh9nBU3Xdq01s1oEUuoT38ZK58dwPgY2PHrkz1BmwdZoq0x01v5neOTR9/dDLVh+h
         jsS/+BMpel1ld5j4vec+pNps+oPrayssaTNHp/EEfmwugqTuEe0FMPahM2S6Q9f6speQ
         kMzN4NGwmIh5PzvILKCq7w66E3jsNFsPxk3RNwiPf3JPS+Kmfx0+Ok4YySEyK0IdGsTw
         Nvdsl+QL/LBVJH1sprhxEe5dkeMjkHALodFtkAxUipWu1jrkwQS+/Z7784LC36sfhL62
         +Vcso19toDLtUfmcP+NLo7j74+BBz1ycqjNy93b/BpR/V6jRBDZYlgZcpHEVsEtjZJkg
         69XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702590347; x=1703195147;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c10wTDKGWx40+Vti3rmzZrdQoTCm+JYREO+5RZnJZkA=;
        b=GA6mtshU+OeWjUVv5JdzYPRXPb8xSJJyINdu3GpKpTMSAECPUQgKGBicX69vyG47d2
         zBoDFoPcPAPxyzcmr2fLE4T27Ole/QNVou/EWo/wTbECsIM4ABiS776KoH+r9MFaPWff
         +MLN5Z6CE3wK3Gk4RZ8hSmB1ULsTSWw1pIuF3IRczMK89eLj91NwwAS+5LB4eTO46ZOr
         VRjypd+Nvj9PY91vPZ+MYvfKYvcoEl/qYM7PjdYGb0Csk5YbXfxbqY5OOakVCP0vZq85
         nsvXWLWdCktCrb2hzB8fNT7YtnvcGciytoK+zOjhmUWGxX0W6AFWBVDNDx5f8jwNKLZw
         BWQA==
X-Gm-Message-State: AOJu0YxdiOWNcSvOWweqTFSrifLMFmR9+pCAh2iP2GPbahaxDxpDePqy
	WwFkDM0TuL4nGKIgEUAJHwEkQ6tgylXklA5Igjc=
X-Google-Smtp-Source: AGHT+IF+GBfzMrtU6Y1DmkKONVgvTc0x2UUy7AoaDhukMf1eYZovRHxpOzRj+/aiUMtMj7rChQaPaA==
X-Received: by 2002:a05:6871:5b22:b0:1fb:75a:c442 with SMTP id op34-20020a0568715b2200b001fb075ac442mr10423148oac.107.1702590346704;
        Thu, 14 Dec 2023 13:45:46 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id pf11-20020a0568717b0b00b001faebb7ff77sm4729234oac.56.2023.12.14.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:45:46 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports & RCECs
Date: Thu, 14 Dec 2023 14:45:40 -0700
Message-Id: <20231214214540.4542-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231214202856.GA1101963@bhelgaas>
References: <20231214202856.GA1101963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Bjorn.

Thank you for the quick response, it looks correct that this is first in v6.2.
My thinking is that the kernel should use DPC on a switch port if it would
use it on a root port when dpc-native is not set. I would be happy to post a
formal patch for this. Maybe using host->native_aer is the correct way to
ensure that the kernel in this system will be using AER, maybe not on this
device but it will on some device. Then, can proceed to use DPC on the device.

I will submit something in the next few days here. Also, sorry if you
received this email twice.. Mistake on my part.

Cheers!
-Matt

