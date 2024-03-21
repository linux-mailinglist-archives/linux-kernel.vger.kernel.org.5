Return-Path: <linux-kernel+bounces-109797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7914E8855D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4124C2820E5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2371756E;
	Thu, 21 Mar 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1ZrnHCJ7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246CC2E6;
	Thu, 21 Mar 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010125; cv=none; b=EBRGSrVids14V0lgD2WRu8X3HJKKYbqb8pUWOBpeLf7Zb4anM3xEE06YGB6bXGNjmL5j/8kGjgtwEMDMjEnGButWgZAKUqW4LLlbtciS5sruftlyJWOXk+6bioIzbVxuRuy1oJJhV4NX3zwDF6E3/mmwcBb4ajW2SZ8rws35dhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010125; c=relaxed/simple;
	bh=IIW6SQQLgLtDClFTOxTHaTcvrjEa+NJrpFMbCdwEEwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxBvvCU83LJ2QqWhDM8KkQKdTnGgCW3A90spFCHfPI4t5hAHmn/130QbqLYgjvO1bUYA6bso5D1jCP/U6r8E7vr8xwoPFqD38ZPQ5hdYo1yF7VkHETnaNrmBBUqHb0fFR8jF02LeIRpDUiBZ0I8vRu/t5kkg+tPxp+73397cYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1ZrnHCJ7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711010121;
	bh=IIW6SQQLgLtDClFTOxTHaTcvrjEa+NJrpFMbCdwEEwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1ZrnHCJ766YQlCIASvqysbAjbHcfbkuX1Qdhm6mI6cy5OiUasCwAjTlU3RdY65h9K
	 R7FTO3MyniSsnvZrxjet1GyCus0KoAdGFKy8l/I316cO8yzgWhnT0XWU5NQcDNOIqx
	 hbvO9QMctus6Nf+qDQkREb6mxp2YXPnb4c7eT5C1esd1SXQ8OdTJoAFkQ9ErSZK4qF
	 vtM1V+UClNRJm0Fuv+z7tLvXxKbhgrzuOy7ARD/SLyBWBQvDm0RC8zPITxzIKnvWu7
	 6IkkNp6UrqKpmOtdvq9A6gzXGRNPLuc3kKBxQsSkFPNgv5qZAmhqoR4l24z81r51yj
	 jW4hK58giEUNA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E57B53780BFE;
	Thu, 21 Mar 2024 08:35:20 +0000 (UTC)
Message-ID: <87800bcf-564b-4a8d-a866-3dba0ead6190@collabora.com>
Date: Thu, 21 Mar 2024 09:35:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: mediatek: vcodec: Handle invalid decoder vsi
Content-Language: en-US
To: Irui Wang <irui.wang@mediatek.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>, nicolas.dufresne@collabora.com,
 sebastian.fricke@collabora.com
Cc: Longfei Wang <longfei.wang@mediatek.com>,
 Maoguang Meng <maoguang.meng@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240321014754.6540-1-irui.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240321014754.6540-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/03/24 02:47, Irui Wang ha scritto:
> Handle invalid decoder vsi in vpu_dec_init to ensure the decoder vsi is
> valid for future use.
> 
> Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")
> 

There shouldn't be extra lines between Fixes: and S-o-b: tags, but I guess this
can be fixed while applying the patch.

> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



