Return-Path: <linux-kernel+bounces-89741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA586F4F1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E3D1F215E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779E7C8DD;
	Sun,  3 Mar 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4TZpENC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4824C121;
	Sun,  3 Mar 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470965; cv=none; b=djDDX3KzsfS+BHX1S5ftjSIOLFbAg5y0ZxEcD1OEP/B499QwQC0ROh6n4NOYpg4hG0J7RJYQaKWQkFMj0TYRJpbSHteOO1gDQrPp8mjtkD1FX/rSGjkz1Aa9b4zFw9KV0sVSSczuah1PMo/TjyOIkE5FCvgMpz48K4OnxVn7qBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470965; c=relaxed/simple;
	bh=FADVOUUahJJk/K1mD+FgJToZVvo6iF2LE+h9xrAETPA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vv4tkV4kkmkHfIo3WB/703gXy63WvQCaB/TEpA8wZYh3pj+BYBdZiHHqSCMTngULQ+2zwp0GEOnsoZveExkPxsgskTcSpBIIEBDLoCM6SJCRDKRrh/uT+UdtZyhCP6Db0BJeCuwh+BJHACIX/6X6WhcZlNnWGAW6BHMjiasHyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4TZpENC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA254C433C7;
	Sun,  3 Mar 2024 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709470965;
	bh=FADVOUUahJJk/K1mD+FgJToZVvo6iF2LE+h9xrAETPA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q4TZpENCBbDrZfwzxz+f8hBRkHuyzRVruU3s6wdzzX9mhz5zfjal4UREM0EgMAPHp
	 1d2w19T5YoQJ0ouEmHxqQSwmvTrpdGIza19CdPtmRUNxS9ajD7x1erAVgF6HcVv5RN
	 nkcLVnzeLEY1If95zAXPe/vThZOlHIlE39+mbPQiLFYNpM1QO6pBC6NbqbR5Kk51Kv
	 i7yFUTS6nOtzEBi+yusC9mSaWZneIdnC42Js51ruhuxhF3jaQvIV+izNfM7hzkAsYu
	 4/7TIKBZY6oL02dIP7DpvORGWYysYn3L11XdxTqWv3WO/HxDtMfCAYyZmbSt5fggfs
	 +HGlq5QAc2slw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:
 linux-rdma@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240301104845.1141083-1-huangjunxian6@hisilicon.com>
References: <20240301104845.1141083-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Support userspace configuring
 congestion control algorithm with QP granularity
Message-Id: <170947096135.143495.12908349666592707641.b4-ty@kernel.org>
Date: Sun, 03 Mar 2024 15:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Fri, 01 Mar 2024 18:48:45 +0800, Junxian Huang wrote:
> Currently, congestion control algorithm is statically configured in
> FW, and all QPs use the same algorithm(except UD which has a fixed
> configuration of DCQCN). This is not flexible enough.
> 
> Support userspace configuring congestion control algorithm with QP
> granularity while creating QPs. If the algorithm is not specified in
> userspace, use the default one.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Support userspace configuring congestion control algorithm with QP granularity
      https://git.kernel.org/rdma/rdma/c/6ec429d5887a41

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

