Return-Path: <linux-kernel+bounces-11076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D6781E10A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54834B216B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFE524D2;
	Mon, 25 Dec 2023 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RevVVwKj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B302524AC;
	Mon, 25 Dec 2023 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d099d316a8so3604420b3a.0;
        Mon, 25 Dec 2023 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703512550; x=1704117350; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQDRirBfKKu4jOrue0tUkAqdRYM+XKPGLgDKcTkbvWA=;
        b=RevVVwKj6DBQlntZIWTjcNYvlfwlqNwlPLT0GAz5ETfe8gJrWmZLVZiAIOoUhnneai
         VUt5gIDuvEhTxXLwLfZtIDwmvuJWxLlCT4AmMuZM/ZHnkxxdIbvOrklh/tayBxN25SGA
         I4yvRJYmDxi7SAVumUFG4Il4fXKlDpekeolCy7JaacP5SR3f/VEvS94A1df7cmTbcN7d
         NV7qPgA11gkJ2n3aGsLl4p7gckgbyXHjPKZhgxAL+sNSEzI/JTdvAPXSQ0BGGHRi2Vif
         HYLR1XoiGtIMXToLPcaSAWK60SHlF9Nm4QNQb8NBYfAX8MgzgzqSmFDYWohTUfBbaQRf
         aWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703512550; x=1704117350;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQDRirBfKKu4jOrue0tUkAqdRYM+XKPGLgDKcTkbvWA=;
        b=NJfBPOlLDa0PDw71MeyERFeXNal87cpZ7fC7egd4ZwvRR2Bu5uw2JdX0fi8tUAuRMz
         D2X1lbtFVFQRY0qypiuL3YDHmAq6Zu/gV3ybj4siQ5TlzPex0R1+itcOl5cP7rIbOUQz
         OenoCCEhMs7E0JFdVBTfK+hpKCTS7yaTRQIadZT+43jpwhaRGXCh2Hs0R5mVGDjmIKjQ
         2gCqg2CbrIRxB9VH32+JHxa/PZDsYQPJ+dnPm49YXOzIeo4VCrtN3cMYfDTq1m0gBH/Z
         NHtWouS5TQ6Bwoevc9LWcWTelF2Csf6OPoxLktBb2uvrTBaHJMX8WFh22QtQ/I3oxml6
         6SPA==
X-Gm-Message-State: AOJu0Yy+Pz8btCqXChioBW4Dvg3gayyyVA6IC0OmL7MUf2u423IGIALI
	FKmsW9EK6ab1mijBYaLd7J4=
X-Google-Smtp-Source: AGHT+IG59G1LSj7Se2+3+49YaCUFtV38BC2bYVSUV4Q/ViyW4rnvflyTan011DTVyVimmqJSzr+AJA==
X-Received: by 2002:a05:6a00:2383:b0:6d9:c201:676b with SMTP id f3-20020a056a00238300b006d9c201676bmr820525pfc.24.1703512550263;
        Mon, 25 Dec 2023 05:55:50 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id e8-20020aa78c48000000b006d9b66f3d07sm2300822pfd.95.2023.12.25.05.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 05:55:49 -0800 (PST)
From: Ruipeng Qi <ruipengqi7@gmail.com>
To: quic_mojha@quicinc.com
Cc: agross@kernel.org,
	alim.akhtar@samsung.com,
	andersson@kernel.org,
	bmasney@redhat.com,
	conor+dt@kernel.org,
	corbet@lwn.net,
	gpiccoli@igalia.com,
	keescook@chromium.org,
	kernel@quicinc.com,
	kgene@kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	mathieu.poirier@linaro.org,
	matthias.bgg@gmail.com,
	nm@ti.com,
	robh+dt@kernel.org,
	tony.luck@intel.com,
	vigneshr@ti.com,
	qiruipeng@lixiang.com
Subject: RESEND: Re: [Patch v6 03/12] docs: qcom: Add qualcomm minidump guide
Date: Mon, 25 Dec 2023 21:55:42 +0800
Message-Id: <20231225135542.1789-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
References: <1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

<+How a kernel client driver can register region with minidump
<+------------------------------------------------------------
<+
<+Client driver can use ``qcom_minidump_region_register`` API's to register
<+and ``qcom_minidump_region_unregister`` to unregister their region from
<+minidump driver.
<+
<+Client needs to fill their region by filling ``qcom_minidump_region``
<+structure object which consists of the region name, region's virtual
<+and physical address and its size.

Hi, Mukesh, wish you a good holiday :)

I have the following idea, please help me to assess whether this can be
implemented or not. As we all know, most of the kernel objects are
allocated by the slab sub-system.I wonder if we can dump all memory
keeped by the slab sub-system? If so,  we got most of the kernel objects
which will be helpful to fix problems when we run with system issues.

How can we do this? From the description above, I think we should
register one region for each slab,  for each slab will have some pages,
and the memory between each slab is non-continuous. As we all
know, there are millions of slabs in the system, so if we dump slabs
in this way, it will introduce a heavy overhead.

I am not very familiar with qualcomm minidump, maybe my thought
is wrong. Looking forward to your reply!

Best Regards
Ruipeng

