Return-Path: <linux-kernel+bounces-131928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DE1898D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608771F21E71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB5A12FF9E;
	Thu,  4 Apr 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN7JpYg6"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B0136E00;
	Thu,  4 Apr 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253447; cv=none; b=gJPEXX728eHrmMT9I+AFuNI/pcERTmIZKtvby4DWrNC9a2sIsr8XFPZhTaZZPGhWwg4q+ZMPsrcoB3R+7II3oxaMydUxEMpKGY7VfRcgDQvY6UulMrH/SD/dSicPUIyxYaX7YyFL4OEfwBpsSXhZBvlhjBrW1gVzRuys4DvYDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253447; c=relaxed/simple;
	bh=YhU3sEXSw0D2kdXjvQ7QXDBcZkocQIOBobWOsVQFuAY=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qsux/G/UCZGBXkbYe2SeLjwegI7hULP0+nUspmP26sNU2q9vKIvR6cIqUfrU0IOVcCsoJ/jh94DDMKZNCdKTyDzJ5oXDLl/h0cHCB9+ENf3QEssjo/L1qja6Y4tHl8j/ME1pFBh4GdXK2lz7+F9sIp1jqsnSUIws8Kv90uT0yrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN7JpYg6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecbe6dc8c6so1130809b3a.1;
        Thu, 04 Apr 2024 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712253445; x=1712858245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVHlK0SMG0qBoQQG+gZsRC+Q+8tU5y/gfXSNtSzLvIs=;
        b=bN7JpYg6YSdCznRcRUDJg/4ojbKsU2zWVwPcMW8f/6zaelCwsRLKsvl6TUec8k2Ucv
         Ont8wfHcUYR8BmpGrS875ymWcXLqaZt6oQ90jKv46NwbY1Kg2hWz5WqQPo5Fjp6oz7BP
         Olzitb+W0gpmtjyov8xxaDuUVDH5b0a+W40pULYU8Iv+Sc75Oxg//NT6n5vQ1OHyK9Vm
         uT7/3/dxYm5xZGDmQQjN1t5oNIMIkr8Oqzznh0z2qUPyu1ItNJbCEAFWEndtGJAjL3Dm
         NVwCZzwMZkYDtgNAmy7e1WgUPafW98hp/5Tk2lInZLLlhB27ySJrdjn1DFcVn0inpIYV
         kn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253445; x=1712858245;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVHlK0SMG0qBoQQG+gZsRC+Q+8tU5y/gfXSNtSzLvIs=;
        b=cJ0puXxsRBlnv76WjK1jcqqqgJVWtS2SXIxKKC8QmPPs76LaaN44k17ywcF/0p9jhI
         UIL0NJ2j+3ZYa1fvu9EFbWnLLM+faE2QWqHBInL6gEiTz4Kil7dIX5aKodhs/2mXYYZ7
         9U05U8SKBx6VZlTmF9wxTD4EALfqMJjQdL82a3EeB+kCXiZ/yIQ5yX5Pwnhsd0hxYtFw
         fYWag2GIa4DsKM9QklVINa984tZj3PB9bCRyQ9gqNQqG3kC/4u1QZU0UyVQLN5HBKOBq
         0uaUOaqOraMWfQsfJ+6FzPs5yza+51ArwNnFnap1cZHOexvtsmAOCwDhQ2iUxXMDcp+7
         44Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVrZjHbso3lItrdxKAu8HJclsei45spwP6ZqHDiQVI+IME7HrwKImshXqH9g2cv6m5wSOg0ZLHH09rNTj5oQI+Mn+qDdcsaz49I0637
X-Gm-Message-State: AOJu0YyWchelch/4q7YziLkpLzhOm2BA1wsCsvNVp8o21IBejuAf3qTr
	adMzvMRZ5d3zkHppJIh5NWcYm5SvW5V7nr0nGFaHlWSI812CRZ8XWEKCxOQJkdE=
X-Google-Smtp-Source: AGHT+IFKDRLk2i3xeGnF/jxy9Jn4pmGaJmcF66H+hQFmmIl3WVwHo0yK60Pt5nXC11k3VcRteYTUoA==
X-Received: by 2002:a05:6a00:3d0e:b0:6ea:f026:4003 with SMTP id lo14-20020a056a003d0e00b006eaf0264003mr3811250pfb.3.1712253444957;
        Thu, 04 Apr 2024 10:57:24 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id lb25-20020a056a004f1900b006ea918dab9csm14043537pfb.157.2024.04.04.10.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 10:57:24 -0700 (PDT)
From: "=?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?=" <jpaulo.silvagoncalves@gmail.com>
X-Google-Original-From: =?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <jpgoncalves@joaog-nb.corp.toradex.com>
Date: Thu, 4 Apr 2024 14:57:18 -0300
To: linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Joao Paulo S. Goncalves" <joao.goncalves@toradex.com>
Subject: iMX8MP Cortex-M7 Relation to Audio Power Domain
Message-ID: <20240404175718.pzcvffpef72dfuoe@joaog-nb.corp.toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello all,

I was investigating why the kernel freezes on the iMX8MP when attempting to boot
the Cortex-M7 processor using the Linux remoteproc interface. However, with
v6.5, it started to work, and I was able to pinpoint to commit
b86c3afabb4f ('arm64: dts: imx8mp: Add SAI, SDMA, AudioMIX') [1] through bisection.
The patch appeared unrelated to remoteproc, and after some time, I realized there
is a connection between the functioning of remoteproc and the audio power domain.
For instance, adding the audio power domain to the node in the device
tree (below) made it work. The same behavior occurs in the downstream kernel.
There is a workaround for the problem by setting clkim8mp.mcore_booted=1 in the 
kernel arguments, but this is not seen as a final solution (it seems to 
disable all clock gating).

imx8mp-cm7 {
	compatible = "fsl,imx8mp-cm7";
	clocks = <&clk IMX8MP_CLK_M7_CORE>;
	clock-names = "core", "audio";
	mbox-names = "tx", "rx", "rxdb";
	mboxes = <&mu 0 1
			&mu 1 1
			&mu 3 1>;
	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>, <&rsc_table>, <&m7_reserved>;
	rsc-da = <0x55000000>;
	syscon = <&src>;
	fsl,startup-delay-ms = <500>;
	power-domains = <&pgc_audio>;
};


Do any of you know anything about the relationship between the audio domain and
the Cortex-M7 on iMX8MP? The TRM is not very clear on this, and the only thing
I could find is that there are some mailboxes for Cortex-M7/Audio processor
communication managed by the audio power domain.

Thanks for the help!

[1] https://github.com/torvalds/linux/commit/b86c3afabb4f4ea146c206508527eb2a15485bcc


Regards,
João Paulo S. Goncalves

