Return-Path: <linux-kernel+bounces-11074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043881E104
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B31C219DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388A524C7;
	Mon, 25 Dec 2023 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI3YTTXt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF6524A2;
	Mon, 25 Dec 2023 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7ba7c845e1aso225638539f.2;
        Mon, 25 Dec 2023 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703512321; x=1704117121; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQDRirBfKKu4jOrue0tUkAqdRYM+XKPGLgDKcTkbvWA=;
        b=cI3YTTXt1ENU8eMkwdtw7m8Dh9dZogOrx6uPcBLtyo+VMzt4sp/pBCo+ysqs4Gnjg5
         hOn+HMtBH9Is1GWykcZAkEKGVF5frasNHmpWCXJm8Tx5uFKNf1CapTXqlligmO8+wrMH
         64rNMn/4j1X0hhTkV54lVr5oVn8sAUYtonWVDsudyzGadL9Xr/Y3c0Hgna+6iKdhk7I8
         7Pd9w1OfyAoZEklOMRIdHI21Txz4Go33nYHao8w4p2Lmdg+ZINGfRSLhLYVLo5xDn59T
         mI5JTGqcVgTbw5d0WQaFvUdoViP/MBxBU5SBgh5NBm87KnjgD79GJ4uN05yiwO/tcx/c
         4QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703512321; x=1704117121;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQDRirBfKKu4jOrue0tUkAqdRYM+XKPGLgDKcTkbvWA=;
        b=Y+povrEi+VtutrkcaMUl1ZzItIuMtdMtxBiQVUNP5jIk9N5y2P0MZ7AmwO6bTQaTWQ
         GRI7YzG+ngdhibcuFT8BN+rZMzWhns1/wAUVlVqpU1lOtAearm7vz5rJsmq/ZjuetIDR
         VM7Ns9UfezL3xgIPYKDUPq+5BAvIPQmvk26n/bLuwIt2/K+cQ6VQh+1B8UE9rB2VyJnc
         DCQzpnZyE8kTSbfYlnldBoenxpYx4+u7bmCmqoKlXRuhcf+aj0Volc4RV7b0eqAA2JVj
         RuXUJS4alif4ohKnfF9n8+Y6/IOONWtEv+PJTQdEJqHEhrxXpFYVd2mnV0gaxigD1AWb
         aCRQ==
X-Gm-Message-State: AOJu0Yyqa4gEsfvdo5lQPZzLhboK5dZk1RfmuSy5IXOefya6PivuJWga
	vN/iz25R6ApFEoaS7i1vE4Q=
X-Google-Smtp-Source: AGHT+IEYgLF09i/9I2s+ydOWQU4ZE4IGPKPqYKOFoFRWMaYWMfy6iMab7ptoQkzUq/hKh7U7yFYQVQ==
X-Received: by 2002:a6b:5a15:0:b0:7ba:b0d7:20e5 with SMTP id o21-20020a6b5a15000000b007bab0d720e5mr6741671iob.0.1703512321676;
        Mon, 25 Dec 2023 05:52:01 -0800 (PST)
Received: from ruipeng-ThinkCentre-M730e-N010.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id k4-20020aa792c4000000b006ce5da5956csm8002767pfa.24.2023.12.25.05.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 05:52:01 -0800 (PST)
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
Date: Mon, 25 Dec 2023 21:51:53 +0800
Message-Id: <20231225135153.1408-1-ruipengqi7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <in-reply-to=1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
References: <in-reply-to=1700864395-1479-4-git-send-email-quic_mojha@quicinc.com>
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

