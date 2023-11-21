Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99827F2712
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKUIRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKUIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:17:13 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85254E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:17:08 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231121081705epoutp0453fdadda4acaaf876143d2f39847070f~ZlWwhOJU42088620886epoutp04I
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:17:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231121081705epoutp0453fdadda4acaaf876143d2f39847070f~ZlWwhOJU42088620886epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700554625;
        bh=lr6fW94vxYn0ZDsRpc9SHce8t6pGUFIFeLHRkfVVUXY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=d0wk8axYdNk/C8HWvC4uD6DcuHVulzVW2XsUOVk1zx2gk8uABsN5p5tRrzzXEo6j3
         W7C3xq7//PwKrTXQLeHQut+f7E/rD3XSAIZrzeJdrOeoaUqT6wb4dpMBkmP3wT+XbL
         pzwRZZI7Jum8L+jfEiNEp/kkoduiS5iKEDDzTVb8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231121081705epcas2p1650b71573632f2feb800ca67d331d56c~ZlWwOxhp81304013040epcas2p1d;
        Tue, 21 Nov 2023 08:17:05 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SZHKY0tXJz4x9Pt; Tue, 21 Nov
        2023 08:17:05 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-3d-655c677fcb48
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.3C.10022.F776C556; Tue, 21 Nov 2023 17:17:03 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2] nfc: virtual_ncidev: Add variable to check if ndev
 is running
Reply-To: bongsu.jeon@samsung.com
Sender: Bongsu Jeon <bongsu.jeon@samsung.com>
From:   Bongsu Jeon <bongsu.jeon@samsung.com>
To:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com" 
        <syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231121075357.344-1-phind.uet@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231121081703epcms2p2d9573fae7782dac583fa061a170e5885@epcms2p2>
Date:   Tue, 21 Nov 2023 17:17:03 +0900
X-CMS-MailID: 20231121081703epcms2p2d9573fae7782dac583fa061a170e5885
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTXLc+PSbVYPE8dYstzZPYLfa+3spu
        cXnXHDaLYwvELOa9eM1ksXnOHSYHNo+ds+6ye9y5tofNo2/LKkaPmW/VPD5vkgtgjcq2yUhN
        TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzjjf/Z+1
        YAdfxZ/nbxkbGM9xdzFyckgImEjc/vCZsYuRi0NIYAejxPU7d9m7GDk4eAUEJf7uEAapERYI
        l+js+coIYgsJKEr87zjHBhHXlXjx9yiYzSagLbH2aCMTyBwRgS5GiQsXL7OCOMwCrxkldhxt
        ZofYxisxo/0pC4QtLbF9+VawqZwC5hJt7WugajQkfizrZYawRSVurn7LDmO/PzafEcIWkWi9
        dxaqRlDiwc/dUHEpiU8Pz7CCPCAhkC3xvY8N5AYJgQZGiTtv70Lt1ZeYdm8BmM0r4CtxfOF1
        MJtFQFXi/5Y3bBA1LhJd79aDxZkF5CW2v53DDDKTWUBTYv0ufYjxyhJHbkFV8El0HP4L9+GO
        eU+YIGxVid7mL0ww306e3QJ1pYfEq22b2CYwKs5ChPQsJLtmIexawMi8ilEstaA4Nz212KjA
        GB65yfm5mxjBSVHLfQfjjLcf9A4xMnEwHmKU4GBWEuHdwh6TKsSbklhZlVqUH19UmpNafIjR
        FOjLicxSosn5wLScVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QD
        k/8sWc3zcjfvfro5af2GvOlWYeKVp+2efZ5kXSvq/mNaxK7Ver/vPzfi2ez539BAwXRbhyJ/
        /Jl9+sUnPwtsYY3fcNohYw63NYvoQYlZPyfU/tyafe/q3muRkxNP/2NlmiYh2Ho55Lu7os2p
        g4USPKf37nuuvsBDb9maddUCG0uc565/zmZwhff9go+XV/g2aFlwCfmJXsk3LzYT+zm3WTM7
        4NuMklyDN7veKDQqntJgMouYzxS+LSYjsH6Si+g8mXkTXy/aOk141pk1DzduU9X6bdmwXbWP
        J3+FvlR0nFfA4usN003yN109E6G55UNm/IWmCWLvRfYVHfvOtsvn1td8n139Rj8n+xzZKtQn
        cUWJpTgj0VCLuag4EQAzMW80EwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231121075419epcas2p280fa7111de7f37b46f460b6c61ff7175
References: <20231121075357.344-1-phind.uet@gmail.com>
        <CGME20231121075419epcas2p280fa7111de7f37b46f460b6c61ff7175@epcms2p2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 16:54, Nguyen Dinh Phi wrote:
> syzbot reported an memory leak that happens when an skb is add to
> send_buff after virtual nci closed.
> This patch adds a variable to track if the ndev is running before
> handling new skb in send function.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
> ---
> V2:
>     - Remove unused macro.
>     - Re-adding a line that was removed wrongly.
>  drivers/nfc/virtual_ncidev.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
> index b027be0b0b6f..590b038e449e 100644
> --- a/drivers/nfc/virtual_ncidev.c
> +++ b/drivers/nfc/virtual_ncidev.c
> @@ -26,10 +26,14 @@ struct virtual_nci_dev {
>  	struct mutex mtx;
>  	struct sk_buff *send_buff;
>  	struct wait_queue_head wq;
> +	bool running;
>  };
>  
>  static int virtual_nci_open(struct nci_dev *ndev)
>  {
> +	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
> +
> +	vdev->running = true;
>  	return 0;
>  }
>  
> @@ -40,6 +44,7 @@ static int virtual_nci_close(struct nci_dev *ndev)
>  	mutex_lock(&vdev->mtx);
>  	kfree_skb(vdev->send_buff);
>  	vdev->send_buff = NULL;
> +	vdev->running = false;
>  	mutex_unlock(&vdev->mtx);
>  
>  	return 0;
> @@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
>  	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
>  
>  	mutex_lock(&vdev->mtx);
> -	if (vdev->send_buff) {
> +	if (vdev->send_buff || !vdev->running) {
>  		mutex_unlock(&vdev->mtx);
>  		kfree_skb(skb);
>  		return -1;
> -- 
> 2.39.2


Reviewed-by: Bongsu Jeon

Best regards,
Bongsu
