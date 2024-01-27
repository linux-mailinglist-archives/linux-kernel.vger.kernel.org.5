Return-Path: <linux-kernel+bounces-40950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3CF83E8B4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122B3B2269E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2F64422;
	Sat, 27 Jan 2024 00:48:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B72635;
	Sat, 27 Jan 2024 00:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316491; cv=none; b=iBNRKMnHZt6zUF5KmpOt48307Nt0WfmlvOAZwwQ8FXpEKoS7AzDrFcAPrnfcOjYQfKJd78SbBrqesbrDCWlMu68VoTujDwc/DuYSpBQOCz2a3Mm4VLFvT3PczU677ZrTyDIEf9oxzZ2srrs5xpuHdVzkA1q5MWkpes6AwR5Dtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316491; c=relaxed/simple;
	bh=YUX7Rd7sW1XLX01vOlN8BcWNyfg8EzhT7x3WOG79tVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s/cGmScHm6bqyCdzGZFV14ATaqHIGnndvGQi1L9oyozsM/ZiNKitgO09WoU0TNB3X9qHwcsZGbzbmQwzM1cXyGUmKNVODHLotPRDHr4fu6nfn+nmnO93mo7fFgngGeabWQY7TVj4R/DsrpOlnah+RRpU9igIvqK6IB/fKyKGV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F1DC43390;
	Sat, 27 Jan 2024 00:48:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 8A483106A754; Sat, 27 Jan 2024 01:48:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240123150914.308510-1-afd@ti.com>
References: <20240123150914.308510-1-afd@ti.com>
Subject: Re: (subset) [PATCH 1/5] power: supply: bq27xxx: Switch to a
 simpler IDA interface
Message-Id: <170631648751.848730.15797573817520426864.b4-ty@collabora.com>
Date: Sat, 27 Jan 2024 01:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 23 Jan 2024 09:09:10 -0600, Andrew Davis wrote:
> We don't need to specify any ranges when allocating IDs so we can switch
> to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.
> 
> 

Applied, thanks!

[5/5] power: supply: bq27xxx: Move one time design full read out of poll
      commit: b282c30dad3e10738a4f03043efaff93d9e8de02

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


