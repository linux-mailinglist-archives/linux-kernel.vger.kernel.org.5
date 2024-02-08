Return-Path: <linux-kernel+bounces-58217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FCE84E2EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0609F28A89F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BCC7992B;
	Thu,  8 Feb 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZlIznGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC367E93
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401636; cv=none; b=AOx7FCM3TypRJ+zb1v/OmASgZocOZsFJMGgFZYMICOrtyNRyB+ywZyxHFN4b4/bQS80qSZjPqvfHlSiaM1PyVcoFcU3KSrHSRViVhp+c5CQc4ItdNRA4ZHBUrsyhUczyfenV4iqewjIzWwlxutUo16mepHGM00FgXwOaB19+JiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401636; c=relaxed/simple;
	bh=LwKdzWUKp1OJdjX4VLZ3vAE10kCJUKpFJeeenAWfDQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pMJa5lfepwuH1zGyl0Jv7VShozWYP4HpACFr1mYyYzDNyghzU70nl15iIs0A99stOrybzHrOa8Eoca3FJhkjeWTr7UFCSy2RlUwcvCFn/A/ifW/jXklyBAgl5ZRGDGaqwMzT6gqbDfCEd2q+XTiEK69rnd2Nmhe3bsKQYQG71iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZlIznGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D15DC433C7;
	Thu,  8 Feb 2024 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707401636;
	bh=LwKdzWUKp1OJdjX4VLZ3vAE10kCJUKpFJeeenAWfDQE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TZlIznGughGpjcERDT2Q29cfnPvC8gBiEJc55+zdGFJ5Dtl0/MxGR/J94LcPxL/VU
	 emc33q1ZFDQnACpp2PtzvmmeZCf683ADfpMJoGj+1oh4CVX/T0rMZ/v/lSb5ZY1R3+
	 pyj7d9klJpYgJZtRKNExOFvw4hEkwjtBUWhneJeE3gxMLqZFIwKAw5jlvGi2cEopVR
	 mv7e1dsMyr6zI4JnfoymN0oskcnl6/BYCDsX85AHJnF1i7h52H4DMhdihX9LKxBzUT
	 D8A+GNk9q1OPSeMOL5veDyWZq9+9mpLkX7Bt4ollXkydP/H7NfCE7ewNw2Ktuwptrn
	 44LDdDHqwAfsw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240204-bus_cleanup-mfd-v1-1-07335ebc034f@marliere.net>
References: <20240204-bus_cleanup-mfd-v1-1-07335ebc034f@marliere.net>
Subject: Re: (subset) [PATCH] mfd: mcp-core: make mcp_bus_type const
Message-Id: <170740163499.1057025.16175133040884881576.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 14:13:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Sun, 04 Feb 2024 17:10:32 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mcp_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> 

Applied, thanks!

[1/1] mfd: mcp-core: make mcp_bus_type const
      commit: a940faea35c0bbdc0b2e563cc3b75c1b120e3ae8

--
Lee Jones [李琼斯]


