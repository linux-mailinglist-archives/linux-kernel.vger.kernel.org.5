Return-Path: <linux-kernel+bounces-11062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80981E0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8952822D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806C524AD;
	Mon, 25 Dec 2023 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsQiABlV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4051C47;
	Mon, 25 Dec 2023 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33679c49fe5so3398379f8f.3;
        Mon, 25 Dec 2023 05:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703510700; x=1704115500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncwBF96I3+wYyMTERq4e+nBDWR/IIaIfVwaDbdyJKS8=;
        b=RsQiABlVGGePOsSz+C0sMMPTurdDxflxPoKFnzgZd2gvdrBgfDX7VkXUv6qqagnpJA
         lCzbG3Klwd2M/0jdcM+vT46zNxW0FlS+MBf8lt+k8KKPqErBqb0NuX/2NxeTe7CHDxx6
         O/I3vyXuGyHu32NhvVNnvPboT9vjnYkjD2mgfxCPds1/RJpzAyMBRsdOSoghcWXwQ1jH
         ckdC3yJxwwoXSR9r9wd/4dZXXRAzl4j9HgE7TRrJHPf3TShkwGSmZaYkmFs2Zbrxuo0L
         H2mGj3uI4sf9R3+Z7LDxE63S/b3v1zNNf7NHcFwwHmOfV1zBr/7mtxgjv03ZC0XZ6mZD
         /yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703510700; x=1704115500;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncwBF96I3+wYyMTERq4e+nBDWR/IIaIfVwaDbdyJKS8=;
        b=Cwi5hvAAZCIflm0DDydNfLGt4X0oTOnGaUYexhGFb3rPvj8iacnz2CeoJ5n8WPNAmj
         AopKCCTPXTy9Vb1/Vs9X1XNtKjUaTBwP675oVsQSSeQqN3LzkQP/7wGaSm/3jpA/H3bs
         86iz85gaVESiUw9ckuGhAmcT8lgpk5FeApi78tSm49BObVoMgajMLRUZGw3Zv75l2hdL
         Q6J3VssKKRnyVM/kcsaxYTFeFn42SwW8+zU/9f59yl3CxiU0uVuJ24h6l/11P/D4BO5W
         596RMOFEny4CiWOWqCMuKR7NN+V5guMe9l1l9dPEq89rtGqwjt94g0JMzmuY1WIc2OH7
         OIUw==
X-Gm-Message-State: AOJu0YwkMbjN3JG65qoCSwRvI0wbvi5vSWaqzEN5RsYr/G+G4YPHcMxc
	OvgL8fTdrUMtDkXshH6d2A9vlx0+YhiULwWXxDI=
X-Google-Smtp-Source: AGHT+IG41SCwACWV8U87qYA6+6Kcw8BMdXdgLiqNbl02y0fJ7Ng0ACLwuJ4cwq6yo6961NrTK8H6KAeOUAmB5KRkDO4=
X-Received: by 2002:adf:fd11:0:b0:336:8ac7:4654 with SMTP id
 e17-20020adffd11000000b003368ac74654mr3188758wrr.135.1703510699790; Mon, 25
 Dec 2023 05:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ruipeng Qi <ruipengqi7@gmail.com>
Date: Mon, 25 Dec 2023 21:24:48 +0800
Message-ID: <CADHLONEODF_JiB4q9zQW3P--U68Tf4RGKne4Gt3PB9e8pz7jPA@mail.gmail.com>
Subject: Re: [Patch v6 03/12] docs: qcom: Add qualcomm minidump guide
To: quic_mojha@quicinc.com
Cc: agross@kernel.org, alim.akhtar@samsung.com, andersson@kernel.org, 
	bmasney@redhat.com, conor+dt@kernel.org, corbet@lwn.net, gpiccoli@igalia.com, 
	keescook@chromium.org, kernel@quicinc.com, kgene@kernel.org, 
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-remoteproc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	mathieu.poirier@linaro.org, matthias.bgg@gmail.com, nm@ti.com, 
	robh+dt@kernel.org, tony.luck@intel.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023, Mukesh Ojha wrote:

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

