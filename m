Return-Path: <linux-kernel+bounces-78131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F68C860F52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC071F2224A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDF5DF1E;
	Fri, 23 Feb 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tU/pwnqt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C724205;
	Fri, 23 Feb 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684215; cv=none; b=cR7/q5QOaltNv02lGdVUBMnJQBxIW+7SmHT4B3Bqbokml0hBFQKNNXzBFS03TL0MwRZcx4EONTHBG0B44qssH4oFiFULkJc/Vt3Wc0S5CugvjPq4keEIGvAYDtEEBcfKNACyuJv709/SAfqHOtjoKnPuXZ6xS5mdYqG4mA8yemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684215; c=relaxed/simple;
	bh=oksfU+fjc/xYMcDn3tKuSUAuIA25aWOSa7trmb9oheE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kSpbsc9S2N81I0doZTlx9oJ2KjAOVM8ZZpJTvDylS06/YoOU0DHnu3YlpajP8QpbbsxVkTX4/8hx3Tr6BN7MSIOjg7PGT7vYxOygQF+7BUVXV0Y93Q8vfb7juZbeOVFcxpv/HUGb93y1kenJLhxfrkT5cJfQaTJxCCUf4zR9cTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tU/pwnqt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708684211;
	bh=oksfU+fjc/xYMcDn3tKuSUAuIA25aWOSa7trmb9oheE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tU/pwnqtf19cXHHYt1duEeCMAfVyO//g1/TgqsTYB9Ebx++6plCrQCDjvstojhAf5
	 v0ukIqQhDkyu7HyZQflSangDQJCtC/Ey+OqWJiwsAc6s8uowzyP1mv9npoCgUC7Vd1
	 2VbYQVbaQvZL1Y0mxRy9+VSh4SoEFHDnOySXbHTbcKcjvg0fBw7uWUG9xFjy0ddhbW
	 YJJLWBlqzX2QFtOrFB0Y/+sIv83593pRK/y/aeFVWIrsqFvCtByXlaSGP4C9WbCX7A
	 +sU/xobO40rWRVkhw2q+wWX04YQr6hnsF4KXBp5TbfYr6eZ3lgRSnEtQshhnBWpyA+
	 w4PfC7SSPL6sA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 25C5637820DC;
	Fri, 23 Feb 2024 10:30:11 +0000 (UTC)
Message-ID: <0a09cbe4-3a36-4d44-a826-5b1dbab6dd49@collabora.com>
Date: Fri, 23 Feb 2024 11:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] soc: mediatek: cmdq: Add cmdq_pkt_jump_rel()
 helper function
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Moudy Ho
 <moudy.ho@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20240222154120.16959-1-chunkuang.hu@kernel.org>
 <20240222154120.16959-5-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240222154120.16959-5-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/02/24 16:41, Chun-Kuang Hu ha scritto:
> cmdq_pkt_jump_rel() append relative jump command to the packet.
> Relative jump change PC to the target address with offset from
> current PC.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


