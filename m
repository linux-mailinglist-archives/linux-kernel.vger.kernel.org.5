Return-Path: <linux-kernel+bounces-100153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B78792A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06FD1F22E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD879954;
	Tue, 12 Mar 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nAHf3C2E"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9758207;
	Tue, 12 Mar 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241388; cv=none; b=Noj9WnKxNeDl4bCM521jhXdcBeSyA1mo3y1hOJmyHxd6zquZYCSIgOZ9ZhznzGFIvThSBxgoySig8hK63ISGhcaZppAbrxHmkcHL56J7/A5tA/v00YiP08dMQ2+cMOPs23lbI39DSmDpEQvv5fNlHV/YiT4lCAXtb+9uo11j1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241388; c=relaxed/simple;
	bh=tKgN9hgrVzLmXZs9MvkMyfYpZj3rKSCbDft77fPTWUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C990qsJrtTvW7J+p0pD4AT2bZYQB/0aRgvDkC7O1d+MaOc7zbqMBClHLUQOxwTJaOhRMAH+3UZbNGy1yz7CvbzMmy773ibxI569LQgVMT5UEcGLQKKAGEl0dmNnLapcqM4uPqNETFce/7Is3tG6wwyJGzOMIfvOnk3Ydp+FFNcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nAHf3C2E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710241383;
	bh=tKgN9hgrVzLmXZs9MvkMyfYpZj3rKSCbDft77fPTWUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nAHf3C2EXHOW3PUr+3y37Sb2TtXiad3myVRg5zHecSLWSDlB4+F8H8Mb2PubCvFAt
	 WnXxP+L2YV8LW3Rq+3kqqestqW7Bp+P3fBp5rl4xNCbSWyPHPGCkhxKLUxVadkDpyM
	 FoMKYbDIUWRoXrPQ0dhwxeLc4l4RvLDdnwn7AnkPfOFQvWctiU+jb6NJgXxW1MWbZJ
	 jXwtguWi0EaF47XAzFMSjurh2yl9jf+SwGVNgEQGenhUEmFRJixfphAiaaUqNfAQC3
	 tCZJui8qHW8VNqG9aXw0mhrN5Rbdwyh8bWEcJwIinbctAX1Fg8oiAyH6F08OYCiQJv
	 sfioVRYrNRXuQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD97A3782082;
	Tue, 12 Mar 2024 11:03:02 +0000 (UTC)
Message-ID: <11f2081f-eb06-4504-b713-b7013af04671@collabora.com>
Date: Tue, 12 Mar 2024 12:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] media: mediatek: vcodec: Improve wording & fix
 grammatic issues
Content-Language: en-US
To: Sebastian Fricke <sebastian.fricke@collabora.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240309-mediatek-typos-v2-0-7eaacd8e5401@collabora.com>
 <20240309-mediatek-typos-v2-2-7eaacd8e5401@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240309-mediatek-typos-v2-2-7eaacd8e5401@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/03/24 10:50, Sebastian Fricke ha scritto:
> Multiple issues detected while scanning the code by far not a complete
> list of required changes but some small improvements.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



