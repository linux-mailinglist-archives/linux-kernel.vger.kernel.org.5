Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2727EC697
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbjKOPC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbjKOPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:02:48 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95A125;
        Wed, 15 Nov 2023 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1700060538; x=1700665338; i=heiner.kallweit@web.de;
        bh=1XGJVR5EsV2PqMjL0uCouljZURA98tfjKWIQF+yrTiQ=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
         In-Reply-To;
        b=nZkqOwy9OZDJB3Q8d/PAdO15bois2ZqHfx3omEieYmYMSAO5CfYYAIBtS7EHRAC8
         1cP8tAZlJT21lu6MsR8xAiJ5Q8mnw/BBNnuLWIGZQ7b2PkfLlVpaamz9bl3HIO4zZ
         9SZURLBheUw44YeB9Dayv/x7BfIagiHTNVVVI/P8wePRBMwUAg27VV/d2MKlSZ4zd
         SmIQ5ruFSI6H2n4q2G26YIJdtVMIXBqSPFYvRElRjI66g229k+sLIWKeU0N/lJAVs
         sR2iYR/uG8xyckj28dFPRhqpfE8XJVkfdK1cCqNFvKJhbPGToDyc/4P40g6qNLV4T
         AYRXmKq37O4V7Gr7pw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.86] ([95.117.28.160]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d7i-1rVhJK0RQm-012G7h; Wed, 15
 Nov 2023 16:02:18 +0100
Message-ID: <22d15e87-a629-4c4c-a2dc-dcae50822e72@web.de>
Date:   Wed, 15 Nov 2023 16:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Heiner Kallweit <heiner.kallweit@web.de>
Subject: Re: [PATCH net-next v11 09/13] net:ethernet:realtek:rtase: Implement
 pci_driver suspend and resume function
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
 <20231115133414.1221480-10-justinlai0215@realtek.com>
Content-Language: en-US
In-Reply-To: <20231115133414.1221480-10-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e6jKnEIV3n1u6T3RkYr6AqL5gkc7Eu/zW/ktHBr4E8C+BvLG9Oj
 x58TwvvO9X3t0UCqlXgQD0uYubul6Lkf4FsahyGw2xpsxgXdppol/rtODcxXiqg6Um87HL1
 wYj4NI6Psm4BcHQ2esobAshiyMM5LAdTibRzlIAFf48RXXzzH4AomHm35RCDxQC6MynlT7z
 l6l55WTv9jfGkk6BpXLcg==
UI-OutboundReport: notjunk:1;M01:P0:QXQgC+6F2YY=;HtuUTlb7oCQ0XE/Jsx86HW8Ghw4
 F+Kvh3zigqHCXcuuTXmzlepa//mvY4QHRARZvypSYEi+/ap0RuVxF/LDe7nI4Biv88rmh3NqF
 uhLxSxygBJiLWzFRuMs+/yXYRgE7GUqo8yWQkAmf1BgMyj5kLYo4dzkYBSPFfPDHis54BmceZ
 9H1S3QT+0U72B6C+aFMcYYmIw0RrrCwQzmqEzHMwXKbf/h/GK7pR5zcSTPkkRXdplFec8GHzP
 3v/+YKj7LXXYi5CJxUK4kKuHgpJoqeAxd0cgot8j/ZCOm1hlYrumWClCpzjvGPjj26n9H+5Mr
 vFK1S6RAzEPNst4MlclQXuDgcgMw5fG744wQyVIqGs0hJmhu1wtcy06s+3ijjAM/5GSq68/IH
 gOZkTtqLWdcZr1584TPXgguDMQc5oIU43ySHdHKV0ysq9Sqt1mJT1kdYiQHf/jik6plK5pGsc
 f54Q8KZzZoyf9K8CV5SselYKh8goxk/s+B/QhBT6aEqVXo/Z63LJZhZd5TmKvh24w66zlYX3T
 V758nKjM+e+HgXRrAJyO6BK6C4UzKuKgcf/6TKIAvReD6t40qpQuxZH6cF6QBRQL9Vr05tzhy
 JVd9mYghvbN/ic+I4gNemgirB5gsX94siRGbhAeFGD65NQBMxzxmw2YdbWnzdpIqHcLQ/ZIw/
 JA3DcZP1b9h22Dxpei7/FceiGfiaxUn122F27XoII1wi8cddbSrEiPuy2qGRx298DFW/tFJRm
 QjBFN1afyOaWuaGWDQ4NTofPH3JI0jHyi3naxlFe0URAflCH5Tt0daXt/sgzBh3rGpTr2lnFa
 lE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.2023 14:34, Justin Lai wrote:
> Implement the pci_driver suspend function to enable the device
> to sleep, and implement the resume function to enable the device
> to resume operation.
>
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/n=
et/ethernet/realtek/rtase/rtase_main.c
> index 12607663dd72..b7679b74cc8a 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -2323,12 +2323,76 @@ static void rtase_shutdown(struct pci_dev *pdev)
>  	rtase_reset_interrupt(pdev, tp);
>  }
>
> +#ifdef CONFIG_PM
> +static int rtase_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +	struct net_device *dev =3D pci_get_drvdata(pdev);
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	netif_stop_queue(dev);
> +	netif_carrier_off(dev);
> +	netif_device_detach(dev);
> +	rtase_hw_reset(dev);
> +
> +out:
> +	pci_save_state(pdev);
> +
> +	return 0;
> +}
> +
> +static int rtase_resume(struct pci_dev *pdev)
> +{
> +	struct net_device *dev =3D pci_get_drvdata(pdev);
> +	struct rtase_private *tp =3D netdev_priv(dev);
> +	int ret;
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	pci_enable_wake(pdev, PCI_D0, 0);
> +

IMO this is done by the PCI core already. See other drivers
and PCI core code.

> +	/* restore last modified mac address */
> +	rtase_rar_set(tp, dev->dev_addr);
> +
> +	if (!netif_running(dev))
> +		goto out;
> +
> +	rtase_wait_for_quiescence(dev);
> +
> +	rtase_tx_clear(tp);
> +	rtase_rx_clear(tp);
> +
> +	ret =3D rtase_init_ring(dev);
> +	if (ret) {
> +		netdev_err(dev, "unable to init ring\n");
> +		rtase_free_desc(tp);
> +		return -ENOMEM;
> +	}
> +
> +	rtase_hw_config(dev);
> +	/* always link, so start to transmit & receive */
> +	rtase_hw_start(dev);
> +
> +	netif_carrier_on(dev);
> +	netif_wake_queue(dev);
> +	netif_device_attach(dev);
> +
> +out:
> +	return 0;
> +}
> +#endif /* CONFIG_PM */
> +
>  static struct pci_driver rtase_pci_driver =3D {
>  	.name =3D KBUILD_MODNAME,
>  	.id_table =3D rtase_pci_tbl,
>  	.probe =3D rtase_init_one,
>  	.remove =3D rtase_remove_one,
>  	.shutdown =3D rtase_shutdown,
> +#ifdef CONFIG_PM
> +	.suspend =3D rtase_suspend,
> +	.resume =3D rtase_resume,

Use pm_sleep_ptr and related macros then you don't need the
conditional compiling.

> +#endif
>  };
>
>  module_pci_driver(rtase_pci_driver);

