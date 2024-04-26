Return-Path: <linux-kernel+bounces-159663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07818B31B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A0CB21E67
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402D13C8F4;
	Fri, 26 Apr 2024 07:55:31 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE413B298;
	Fri, 26 Apr 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118130; cv=none; b=OzaFjzxdeN6DTZtnB2DtHxy4OGBFnKYF+PS8lM+sUDJnY4nsz3TfxtUKiY04T3VARsQlpcKPIYT1Qgtoqrc1NZ/WUnHaqpv1vvfhT4mvVT64cq3oN95QqKjiNKqFY3lZxpvJoBrQ4mHbS5esryqksuawRmvdwzMEw9Me3pNkswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118130; c=relaxed/simple;
	bh=Rm3DpWjzaOSI5jpO9QOE4lLk4IsUne5anO/l6tOeE0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTxeYRH/gjBp9OUFLPkyIq3UDIyfUWQQrRK3w8iLQk2ZH0XopxkfQMGm2R0xqZqRXfDn0RB/5s8YinxpG6/2oTQVRJAnVhivIF7d8GM/Q1Yb1z01vJIZwNVBs6aTsvzocndYoD5bdpfJZ8dZo2e8LUw4La8zzc8QPV3X2bPr6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aeb7e.dynamic.kabel-deutschland.de [95.90.235.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C0C0061E5FE06;
	Fri, 26 Apr 2024 09:55:04 +0200 (CEST)
Message-ID: <a062a503-4dc9-43b1-8ccf-e2c91c3e27df@molgen.mpg.de>
Date: Fri, 26 Apr 2024 09:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_send_cmd
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org
References: <20240426072006.358802-1-iam@sung-woo.kim>
 <20240426073142.363876-1-iam@sung-woo.kim>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240426073142.363876-1-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sungwoo,


Am 26.04.24 um 09:31 schrieb Sungwoo Kim:
> Wrong call trace was attached. The correct one is below.
> Sorry!

No problem, thank you for noticing. Please send a v2, so people using 
automatic tools can just use those.


Kind regards,

Paul

