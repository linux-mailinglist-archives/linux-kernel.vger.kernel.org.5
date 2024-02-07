Return-Path: <linux-kernel+bounces-56670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5084CD60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F60B1C20DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1458A7FBA1;
	Wed,  7 Feb 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ4mIGle"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ED07E77F;
	Wed,  7 Feb 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317637; cv=none; b=VRTPCCt8TjyDIc+apjBjw3aaR0wkbvhKjC8WL/I/bdkfWw+fG/RCRakiVjQpNzU/UDcRqkIPEuIR7fKuBFkncZAhUzxOvgFMTmIuMozm2x25uXKQsqgj6e8pIH939w0bgikVtkNbz3GLuI/PUlhDzILfComtbaLVlq7jwUK/u2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317637; c=relaxed/simple;
	bh=KH4aIouyuWdasHE18nyazskEQVAdrjiFumKnKbkPI6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3xvK8aumeotOMr5Q8nE2IHyhPhj8bmOzz9WkghA7e0QTiJyzVlNghIjFoZgS6IJ/GP1Y+BMbJPHrjvhdvKLEahvv8WHxh6octziGL1LCABYeC/jbMlf16JAB5xSuu+EG3BF7kFXGJpbm7hOKY834xAp32UuVr3LhBdxpGZeABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ4mIGle; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fe2ed8746so6134075e9.3;
        Wed, 07 Feb 2024 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707317634; x=1707922434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeaVh/lnio4gc/XMvIeYWIMuMXXG24LyCbi+Ce3p0Z4=;
        b=OJ4mIGleaOsBeugTXqLWNKF3h/WCkgRYChieUYtyPIS8nNbjGg3II2d+aNI+rX4YHN
         m2hGadX8KBE3yV/mdEDKTJz9bcFmLqOq92T9xyDuZ7qasLmrHf1ivyDbt1+mAWUak4qz
         65oCHv6kKQaVfoWYFa/s2wb7Li2gCKwyBsQJ0S4WvA6vFwXhUMSllDft4Ej9NRWSb3Dl
         U8EiT2x2mKRNdTlgCmu36QjOPxURr+XiWDQ+1Vfq271jbyjC5Ef1WL2QABbvoHVoWyQ1
         WMl6ZJqbcsEjuUx+eljZXdT6QIT/Lnlks6kKVFBBNAVV74oIfqobNjsUhBYAu+doQt6f
         irxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317634; x=1707922434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeaVh/lnio4gc/XMvIeYWIMuMXXG24LyCbi+Ce3p0Z4=;
        b=rK5RMea63R2Fq6aG62fl0fmf6oybKpg5d5YFsIxzgcL8qm9bCTavgOZfs3C1HeGKb8
         gh2jn9WU5UmR1WkB9BeSkA3wrGjsP1jwVU0ZX5kKEYP/VgEGi9xhfDVDJ69wtwfpXuoX
         pErEl5nODLgUiQ3d7R4p06192QiBpdqHnMdHp6in3ot1/BdmYPoiHDK5IUfHM28F79PK
         ovObbhK2x3cHn07B7IykpU2QSkSLj44RGvIuEneYREaKf+NW78fKKMwS/fsWc+QFKAYG
         tj9Nhu5GS4bDdUq2LUHiGSdEM1iybypRIC8UYFeVr5YCPEhbuC40Mm4AH+O0btsUx0B3
         MhyA==
X-Gm-Message-State: AOJu0Yy9SxskviLvlJKm7vGCfGuVj1vPjwp9tptjchqwY7MPiJbdsgDa
	rOgrJXbTjv6G0Wj1iWAuCLqY9rkXCgcvf8Qj6dywPyJ4mUDOMrid
X-Google-Smtp-Source: AGHT+IEOQ9PUIelS9Up3Z2leC8+AjPwTxciDKQOF2tPtygDXxH5vKSWw8QMymkOzILSud2oeBvCkJQ==
X-Received: by 2002:a5d:4750:0:b0:33b:274e:af5 with SMTP id o16-20020a5d4750000000b0033b274e0af5mr4000326wrs.60.1707317633607;
        Wed, 07 Feb 2024 06:53:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwEZeTZpLOUCuBBjOuuCPiaDg4fx3wo4eteNjPkY7pPmbXE257RElKiqFaWqGh19r6WiTQa3bHalYEHnoIvIiGYfD/RlDE62gzy4HyBq0t/x4K3RQpaUhnYf09YWrLx6+WybBjC7djl4Ib+nYT5ONxyYhEdYu3bOJh5et5C6WVjfJMtWAj8evl2hKsTx4BRcBc2hsWSHT5Nz3Unz4l909q6KADPQcUo9fAc/cK3cPXlODGHtbLODwrBEwyzhVChRUmlowGgB+e03KOH79Uit/1qDWiv3eEIa97//6SOtKUdeknV0whWZzJukADZYzZFz7525mcQb2gUoqtfuekjW2cRRlAv7IvIYw/RYbJ0OEdNNbwb8ftux/4GnuQm4YRZ5RKGhFE1OxioSy76oqqL1uhGH+XoI6+4MC9NZyg5x6aGuHsZAl+0MwGi6m+CxqlE+BdKOMyVBMaGF4kH09pQsCXuIS9tTx9YnXP3CmgGN1Oi4WW+1+LLQ==
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id d21-20020adfa415000000b0033b4fdea014sm1263624wra.92.2024.02.07.06.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:53:53 -0800 (PST)
Message-ID: <13e2f96c-2434-4266-8a5e-25b267d1fb0e@gmail.com>
Date: Wed, 7 Feb 2024 14:53:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mt76: Remove redundant assignment to variable tidno
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240207131113.2450297-1-colin.i.king@gmail.com>
 <87il30h03n.fsf@kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <87il30h03n.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 13:31, Kalle Valo wrote:
> Colin Ian King <colin.i.king@gmail.com> writes:
> 
>> The variable tidno is being assigned a value that is not being read
>> and is being re-assigned a new value a few statements later.
>> The assignment is redundant and can be removed.
>>
>> Cleans up clang scan warning:
>> drivers/net/wireless/mediatek/mt76/agg-rx.c:125:5: warning: Value stored
>> to 'tidno' during its initialization is never read [deadcode.DeadStores]
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> "wifi:" missing from title.
> 
does this require a V2?

