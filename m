Return-Path: <linux-kernel+bounces-138280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4E89EF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A4B281A88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14261586C5;
	Wed, 10 Apr 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="chWcdsU6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BC158D97;
	Wed, 10 Apr 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742592; cv=none; b=EpY1QXUZsjhJsO+jGKfDTIxj00f7jICjUjqkyXq8G3L1TabQ2wmZteatNKLL+7Y56BHKyTFcVYEQdoPQDbNEQEifrjL29gdEr66quEXXQO0MZdf12Qh/wILo3V6okOVVU+B2I3AnQWJP1yx5uHNeCfmJSYKAGYOq4JlFdS0Nm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742592; c=relaxed/simple;
	bh=9EIcnM9Ibe7JbXZ8eAtGo6g7cnqXXcNhJCTV5wJYFkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU3+1W+mQRuCx6FJDg0pNsNAhpZ2tHbMp7MUbn3L+cYu/4IYt3N9PH2egjnYhnk7gPvEy57kSKbJigvuZ8ZuROtVUzMw9xexRrTxrDjeBLW+y04ZEQBODrRq0aXZIeGziqmTIqzpleFK1tVyXfTkuoG82UfrSSCeGeAQY/TcO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=chWcdsU6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712742013;
	bh=9EIcnM9Ibe7JbXZ8eAtGo6g7cnqXXcNhJCTV5wJYFkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=chWcdsU6YnQv9GfWi1KfuxJMCXDDZR35uq+lHRRXGrOflxnR+Lei3splYu3JgGJ6o
	 MyNakp2WVghJuRuIN6uMKyK4JlW224mvgfnsBStwV+pXOCAXlz8RxXk7Zxs5TZuW7H
	 v/eS2btQ5nNpExe7l87qhtu7GQ9hLj6mZ6AvgxWHvvz7G2e0XrRsFYPC/vYt+ewPxv
	 ACxHuIEwiyuwYsFpmV+Bj8/+lh4vP2PKYXEooKWjTHJOOd4jXDpv1RM9epvDl45lkb
	 XCgvDL80fO85EjFcKvWVU75sH7IR3djEFPvNfSzV0amkIXlBRm8IfeFcGCwVroE0ez
	 1omnwdgPsiL0w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B7ACC37820E2;
	Wed, 10 Apr 2024 09:40:12 +0000 (UTC)
Message-ID: <1865719d-db95-413f-b4c9-a5e2ce35051b@collabora.com>
Date: Wed, 10 Apr 2024 11:40:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: mediatek: fix module autoloading
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Peter Wang <peter.wang@mediatek.com>, Stanley Jhu <chu.stanley@gmail.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-scsi@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Will McVicker <willmcvicker@google.com>
References: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240409203954.80484-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/04/24 22:39, Krzysztof Kozlowski ha scritto:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Cc: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


