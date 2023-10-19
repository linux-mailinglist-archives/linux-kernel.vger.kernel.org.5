Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3D7CF560
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbjJSKbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJSKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:31:19 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F2511F;
        Thu, 19 Oct 2023 03:31:15 -0700 (PDT)
Received: from [192.168.0.233] (unknown [95.91.242.42])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 20A9C61E5FE01;
        Thu, 19 Oct 2023 12:31:04 +0200 (CEST)
Message-ID: <2a7c1af7-5477-4736-9eb0-3347672b4601@molgen.mpg.de>
Date:   Thu, 19 Oct 2023 12:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add return error code
Content-Language: en-US
To:     Youwan Wang <youwan@nfschina.com>
Cc:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231019023953.218624-1-youwan@nfschina.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231019023953.218624-1-youwan@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Youwan,


Thank you for your patch.

It’d be great, if you versioned your patches. For example:

     git format-patch -v3 …

Am 19.10.23 um 04:39 schrieb king:
> From: youwan Wang <youwan@nfschina.com>
> 
> Signed-off-by: youwan Wang <youwan@nfschina.com>

It’d be great if you started the first name with an uppercase letter too.

Despite patch diff stats being small and the patch probably trivial, 
it’s common practice to state the motivation for the change nevertheless 
in the commit message body.

> ---
>   drivers/bluetooth/btusb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b8e9de887b5d..ec6bdc9687b1 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2826,8 +2826,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>   		goto err_free_wc;
>   	}
>   
> -	if (data->evt_skb == NULL)
> +	if (data->evt_skb == NULL) {
> +		err = -ENOBUFS;
>   		goto err_free_wc;
> +	}
>   
>   	/* Parse and handle the return WMT event */
>   	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;


Kind regards,

Paul
