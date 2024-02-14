Return-Path: <linux-kernel+bounces-65173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432DF8548E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F309D28CB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5891B7EA;
	Wed, 14 Feb 2024 12:03:10 +0000 (UTC)
Received: from esa1.ltts.com (unknown [118.185.121.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B881B943;
	Wed, 14 Feb 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.185.121.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707912190; cv=none; b=h5PUsP2RyTfgNPX8XkS89MGOSEfrfdsBSkwqVTQaU3zoIGK8WZ2txv1pnHxrBK7IkYP4HKVOHZxDu5YVgB/1+PnSxI4FY0vxfLxbzw5qVpKHMao2h//DovRm3+zFWKWtJtpvc/ulTvZqfC5qQpAUWZEpdB3h2ExerKMEzxFxeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707912190; c=relaxed/simple;
	bh=vhfzV/ZvaGbZZuBUKxehjhDgFWsM6Gh+JqVkHYcwahU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/Drklx3T2tWObfsGREVnFA5InwlDbx61IrkiNQGewqb9j1L3sl6Mxk2iKDlkS7uNADmM05GmZfMg4K4xmWY3F0wHao0ee0GRtO0R+yArBYWXGVoVNEoItVlgZ4atrCibQmSmpHplzJaDLJunQjcd7MXosGB9A4NVwSBR76BjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=118.185.121.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: 95/x58YRaKojPGapQKZszgEdMGRnLhW3ZO5ah2CNGaOJs7kBs77zA69Gv6JGe7wEvW+swWdC15
 oUQSaK/bRvKA==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa1.ltts.com with ESMTP; 14 Feb 2024 17:32:56 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: nm@ti.com
Cc: arnd@arndb.de,
	bhargav.r@ltts.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jpanis@baylibre.com,
	kristo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.nirmaladevi@ltts.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [RESEND PATCH v1 01/13] mfd: tps6594: Add register definitions for TI TPS65224 PMIC
Date: Wed, 14 Feb 2024 17:32:49 +0530
Message-Id: <20240214120249.89716-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209173517.i67qttasxjum7oek@strum>
References: <20240209173517.i67qttasxjum7oek@strum>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Fri, 9 Feb 2024 11:35:17 -0600, Nishanth Menon wrote:
> On 16:23-20240208, Bhargav Raviprakash wrote:
> > From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> > 
> > Extend TPS6594 PMIC register and field definitions to support TPS65224
> > power management IC.
> > 
> > TPS65224 is software compatible to TPS6594 and can re-use many of the
> > same definitions, new definitions are added to support additional
> > controls available on TPS65224.
> > 
> > Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> 
> You've got to Sign-off as part of recommendations read [1]
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n451
> -- 
> Regards,
> Nishanth Menon

Thanks for your feedback. We will do the sign-off in next patch version.

Regards,
Bhargav

