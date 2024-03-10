Return-Path: <linux-kernel+bounces-98177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6014877612
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09DD281D78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6F21EB51;
	Sun, 10 Mar 2024 10:18:04 +0000 (UTC)
Received: from mail-m17239.xmail.ntesmail.com (mail-m17239.xmail.ntesmail.com [45.195.17.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9101E4BF;
	Sun, 10 Mar 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710065884; cv=none; b=C9uKjppu42Dh0XRFfxrJFSrvrDBOAL2WEeuqgJ1syMycshIQwnEnQPxe5+rFmjvA/+8ke7bvYdx+/f29roapww7E7MEy+qZzg/3SE7FrYzaKEmrm2kuGmAMEi0fGZ4u9jmxCaGXFsWgvujRrnjXAUrS6IYcvTAl3c9zRhqvPOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710065884; c=relaxed/simple;
	bh=hoSaxIrK/bsoOT//u+O5KkCPMqyUjEDnfRuL7ydKIl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I2Ygqxp6Biv+3s6x1sQES/t066/gRY+FEmJ21jDIQPUy3sHY7CUjoQJliwcVkPPLt7KOgxTm/J92X7xVhH6S5l46pN4vg7agKTpQJtelAqSKtNqNv4B7HFPk9GoLyLGIj3ghM99M1ZY/REkGl8t3TfSfLnwXsDlfDm/m9qp+9wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.195.17.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:9430:407d:a711:d2ee:24f8])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 3842D7E013B;
	Sun, 10 Mar 2024 18:10:09 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: dmitry.baryshkov@linaro.org
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: ipq6018: move mp5496 regulator outside soc dtsi
Date: Sun, 10 Mar 2024 18:10:05 +0800
Message-Id: <20240310101005.13541-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAA8EJprc_xjejMANBjDkA2_FnRcYSJYsmM4VOvsKu1FkuMvGeg@mail.gmail.com>
References: <CAA8EJprc_xjejMANBjDkA2_FnRcYSJYsmM4VOvsKu1FkuMvGeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUIZVkMdTRlPTElPTh1OH1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBQk9IS0FPS0wfQRpMSkpBH0keHkFJTx1DWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8e27d75deb03a2kunm3842d7e013b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NFE6HRw*GjMLLDNOGSIvFxMZ
	IzoaChVVSlVKTEpLS01OT0tCQ0tIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBQk9IS0FPS0wfQRpMSkpBH0keHkFJTx1DWVdZCAFZQUlKS043Bg++

Hi, Dmitry
> Please inline this dtsi file into the board file. While it might seem
> to make life easier, having such includes makes following regulator
> settings much harder. Especially once a board or two start overriding
> or expanding those settings.

Thanks for your suggestion. But unlike mobile phones or dev boards,
I don't think any manufacturer will change the voltage settings of
the mp5496 pmic on the ipq60xx router. The s2 part of mp5496 pmic
is used to supply the CPU, and its min/max voltage corresponds to
the CPU frequency of ipq60xx. Although the downstream qsdk kernel
uses the cpr regulator driver, its min/max voltage is still the
same as the current setting.

Thanks,
Chukun

-- 
2.25.1


