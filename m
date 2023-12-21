Return-Path: <linux-kernel+bounces-8088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C5D81B208
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA629B27825
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135E83399E;
	Thu, 21 Dec 2023 09:06:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965D4E60F;
	Thu, 21 Dec 2023 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.4] (ip5f5af5c1.dynamic.kabel-deutschland.de [95.90.245.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B47F161E5FE3B;
	Thu, 21 Dec 2023 10:05:19 +0100 (CET)
Message-ID: <f7bf2cbf-0ff4-4d97-8d50-024ad1c9efec@molgen.mpg.de>
Date: Thu, 21 Dec 2023 10:05:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
To: 15013537245@163.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
References: <20231221071621.1154462-1-15013537245@163.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231221071621.1154462-1-15013537245@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Clancy,


Thank you for your patch.


Am 21.12.23 um 08:16 schrieb 15013537245@163.com:
> From: clancy shang <clancy.shang@quectel.com>

Not important, but you might want to start your name with a capital letter.

> when Bluetooth enter suspend, and disconnect everything with the diconnect

1.  enter*s*
2.  disconnect*s*
3.  … the di*s*connect …

> reason code of 0x15,the hogp device could not into sleep and continued

Please add a space after the comma.

> advertizing. when use the diconnect reason code of 0x13, the hogp device

1.  adverti*s*ing
2.  di*s*connect

> into sleep succeeded.

going into

What device is it exactly?

> Signed-off-by: clancy shang <clancy.shang@quectel.com>
> ---
>   net/bluetooth/hci_sync.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d85a7091a116..16b5420c32d0 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5927,7 +5927,7 @@ int hci_suspend_sync(struct hci_dev *hdev)
>   
>   	if (hci_conn_count(hdev)) {
>   		/* Soft disconnect everything (power off) */
> -		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
> +		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_USER_TERM);
>   		if (err) {
>   			/* Set state to BT_RUNNING so resume doesn't notify */
>   			hdev->suspend_state = BT_RUNNING;


Kind regards,

Paul

