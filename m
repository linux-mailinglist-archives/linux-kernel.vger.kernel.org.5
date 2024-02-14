Return-Path: <linux-kernel+bounces-64973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D21854551
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009E31F2D89A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F87916419;
	Wed, 14 Feb 2024 09:31:26 +0000 (UTC)
Received: from esa2.ltts.com (unknown [14.140.155.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA312B8A;
	Wed, 14 Feb 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.140.155.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903085; cv=none; b=KkApxMwLHzwSXyZ4RD4dE6BuZCLYQxTQ6d/87SSLssmIHWBfzsAEkFYVJBA7BjqzGjc9JJmiBtkqNd8fkaa3pmBhN3uNlC+XnePITp+VgGz6v2Eyyn21Xk5BDsLhNzUDtgv8fsyolrFHhqzxPv/PyB6Q14bSc2s0paRsbrdQC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903085; c=relaxed/simple;
	bh=oT34Qaa1f3ZWrCvgXRGBt6WIgG0rg2dW46uvJiuy3rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1QnWn7XIYEqq+5/tY8CIm980aRNLXv1d4oQ0IMyUFrvAiSbYE/LsfDgTLryX+C2bTTiWOQciCZW8sfjdw3NNA6vjeA47XmiV0QJnlIp7ms5Z8BTR/Ip7ZcAUPfKuW6ZDgHiO5eXKLa3L2H9xZQmi6Gqhzfcshl16KzNpt6sz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ltts.com; arc=none smtp.client-ip=14.140.155.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ltts.com
IronPort-SDR: pwvaSPp4sCHdhnLsgMihVnqqppYhStIQvkknA9BJaz2JXyd4SdwTyxaJGpVdf8dfEG1+IQvTlQ
 B5zxD+sm+l1A==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
  by esa2.ltts.com with ESMTP; 14 Feb 2024 15:01:13 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: conor@kernel.org
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
	nm@ti.com,
	robh+dt@kernel.org,
	vigneshr@ti.com
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
Date: Wed, 14 Feb 2024 15:01:06 +0530
Message-Id: <20240214093106.86483-1-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209-blitz-fidgety-78469aa80d6d@spud>
References: <20240209-blitz-fidgety-78469aa80d6d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Conor,

On Fri 2/9/2024 10:41 PM, Conor Dooley wrote:
> On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash wrote:
> > TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
> > regulators, it includes additional features like GPIOs, watchdog, ESMs
> > (Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
> > managing the state of the device.
> 
> > TPS6594 and TPS65224 have significant functional overlap.
> 
> What does "significant functional overlap" mean? Does one implement a
> compatible subset of the other? I assume the answer is no, given there
> seems to be some core looking registers at different addresses.
> 
> Thanks,
> Conor.

The intention behind “significant functional overlap” was meant to
indicate a lot of the features between TPS6594 and TPS65224 overlap,
while there are some features specific to TPS65224.
There is compatibility between the PMIC register maps, I2C, PFSM,
and other drivers even though there are some core registers at
different addresses.

Would it be more appropriate to say the 2 devices are compatible and have
sufficient feature overlap rather than significant functional overlap?

Thank you for your review and feedback!                                     

Regards,
Bhargav

