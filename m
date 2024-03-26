Return-Path: <linux-kernel+bounces-119213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC688C5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85283296D18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BE13C695;
	Tue, 26 Mar 2024 14:49:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3998313C3FA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464585; cv=none; b=B33GuAaAaiXFqzoQrImhOev1ZTu7dmj5weyJ0+THw36kavCKpHO/QWh0b5P8Y1Dj9muXdG4USyiVNT+xBsMYpbeSLlvYsZdU6dJ0l0s/kKf+5QQi8L31ZSXvzrvtXC8q6LmUmDzJ3t2JYvSADDGO5AszV//A649BovpJxwH3YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464585; c=relaxed/simple;
	bh=k5v21t1TmqzSwACthF9qJZyOoMQAkYvln4gyBoWSjy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IebJVEEv7ZVyQBtT1dHr4ysbi+uRWpycBgf+VPWkYFa1YwvzPe5ftRnPENBEOmFiM2pk8ctLU1dfkJu/RlitOkJS6yA2eisBzfvUjpXh//ZO4ofZuPFoJsV8gGd/0Y7CymMT1WLdaoZ/XyvVoL5NdHjlHyazDjX2ttn8SoiC2mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4130C339;
	Tue, 26 Mar 2024 07:50:17 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E442C3F694;
	Tue, 26 Mar 2024 07:49:42 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Make raw debugfs entries non-seekable
Date: Tue, 26 Mar 2024 14:49:19 +0000
Message-ID: <171146453849.2983526.5247920976483225405.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240315140324.231830-1-cristian.marussi@arm.com>
References: <20240315140324.231830-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 15 Mar 2024 14:03:24 +0000, Cristian Marussi wrote:
> SCMI Raw debugfs entries are used to inject and snoop messages out of the
> SCMI core and, as such, the underlying virtual files have no reason to
> support seeking.
>
> Modify the related file_operations descriptors to be non-seekable.
>
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Make raw debugfs entries non-seekable
      https://git.kernel.org/sudeep.holla/c/b70c7996d4ff
--
Regards,
Sudeep


