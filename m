Return-Path: <linux-kernel+bounces-123360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284F890717
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FB628B06F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE28003F;
	Thu, 28 Mar 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3O5deGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEA7EF0E;
	Thu, 28 Mar 2024 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646594; cv=none; b=Li8vz7Um2IugvEB2X6ZHtNPQWNB+4qJfDsfo+HSmQ5IefiHdRA5TI0K54t55F7oy+9kuBX+CylmAodd8jJEe3Xw983Pww1kNNyoCizqahoLd0qgZmoBqfS9QKqZZ67HpwdS1eLY4uL+xHFcdtzDUN9Gt3FXCsNiFSRKAleOW8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646594; c=relaxed/simple;
	bh=ocaxfsxN2RcUH0BomGmZ305cwqYXx8cqNkONuTikcDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcUa0T5lbz17wDF2en2PyfFxA1qbs6l2ppe3A+rul/3VcZHTggg5eCAbxcASv2V+KxhdDe+K85cZFq1/ezWDxDf7Xsm7kJ2ScstrA+djkoQFfOFX+DQ9i5DIbenjCOO/S94JgSbIvoaw9+2u971aJH7iYNc7wdlXBAKO2TkN/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3O5deGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6415BC433F1;
	Thu, 28 Mar 2024 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646593;
	bh=ocaxfsxN2RcUH0BomGmZ305cwqYXx8cqNkONuTikcDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3O5deGfX9GRSgL/Psat0maVZbp8A5TWl7tIDu1qVpVTHzTsAIMlWJvZKr0FYIrfC
	 d+B+HZQLBuSmScwh6J68J1Yod66oGgjz5r7U4txDFOXCctZWmBveQVUSeKb3DhRC1u
	 HYYXh69lgfDQy0D93Hwh4xJ/OgXp1SpmVyQInq1Beh6eLgd0WpeaMSLNxDUsr2DF1D
	 thZTaqRVCa0wVkLbWy371zuWYs0av2KNhf/ZAZ67f8Q4z5HUP41IMNGBkp10ZJUkKo
	 pDw2eyNRQAwgDWtN5ojgraW5dW9r298ioLakOjobNgfloTOKUDYF9POjTE7KDxePJC
	 IlRMDzgtkOIsQ==
Date: Thu, 28 Mar 2024 17:23:09 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH iwl-next v2 1/7] i40e: Remove flags field from i40e_veb
Message-ID: <20240328172309.GB651713@kernel.org>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075733.8967-2-ivecera@redhat.com>

On Wed, Mar 27, 2024 at 08:57:27AM +0100, Ivan Vecera wrote:
> The field is initialized always to zero and it is never read.
> Remove it.
> 
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


