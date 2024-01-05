Return-Path: <linux-kernel+bounces-17567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB3824F74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C411C22BBE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD82031C;
	Fri,  5 Jan 2024 08:03:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557A200AE;
	Fri,  5 Jan 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (unknown [95.90.233.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6568A61E5FE01;
	Fri,  5 Jan 2024 09:03:13 +0100 (CET)
Message-ID: <1a3a481b-db1f-4325-8ca7-03f2bc44b2a2@molgen.mpg.de>
Date: Fri, 5 Jan 2024 09:03:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: mgmt: Fix wrong param be used
Content-Language: en-US
To: Clancy Shang <clancy_shang@163.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
References: <20240105031111.132851-1-clancy_shang@163.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240105031111.132851-1-clancy_shang@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Clancy,


Thank you for your patch.

Am 05.01.24 um 04:11 schrieb clancy_shang@163.com:
> From: Clancy Shang <clancy.shang@quectel.com>
> 
> bluez lib could not receive MGMT_EV_DEVICE_FLAGS_CHANGED notifications
> after sending MGMT_OP_SET_DEVICE_FLAGS

Please add a dot/period at the end of sentences.

Please extend the commit message to describe your fix, and why it fixes 
the problem.

> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>   net/bluetooth/mgmt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 9dd815b6603f..c74abdf3618f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5177,7 +5177,7 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
>   
>   done:
>   	if (status == MGMT_STATUS_SUCCESS)
> -		device_flags_changed(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
> +		device_flags_changed(NULL, hdev, &cp->addr.bdaddr, cp->addr.type,
>   				     supported_flags, current_flags);
>   
>   	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_DEVICE_FLAGS, status,


Kind regards,

Paul

