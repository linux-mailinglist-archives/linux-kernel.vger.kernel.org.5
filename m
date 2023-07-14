Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A17753FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjGNQRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjGNQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:17:21 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2051.outbound.protection.outlook.com [40.107.13.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24C1FD4;
        Fri, 14 Jul 2023 09:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kS3bSz762ZCsq6nGIBCe2120I8Ib/zXTYIDRS7PWe+PdwA+6aYx8vEhO+P368sb7onY8ypGSDo6hOWV+GWwKr9ilcmLi+bds23Ff3ULeNS0K2UjB8jXHp4wELQa4WwJGwrCArAoyT8OpDYKAPYiYXdEMl+zc3PCY8YA9C2VGcwXvzAFM9100LdGpu0urvYZWa91e1ln7EoUzZjUZWO7lkzKbolyUkmrIASyYeJ3OvbzLl4VPb7RfC8o9wseqKVR3j4/kUl+To5kg6XwuCCqCO63W29U96HYjey6Dpyfi7KsX8/WkhAWOsBQOyEJRh2g0F65QCyRNtpULs/uZCHKXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8OMRfWc45MUKo0rqee+Z1zrEDI2fH/okh8YdZ/vjNE=;
 b=I5z3fyS8G074ldUaNHiOvB2XV4HVnBjduSnCYAyOIQC6UXrDQtx4Bqy5YtPOPbCvAmM7nC5QDyTtDFYuW471sfaD0hAYXzme/FAv0HtsKLBYsjSJ0j1f17myUs3LwO2oJ/NNeCU/fcpfFbVe4lgaHk2lNBJqqOTbPR5sPhmNC8YEaK7ajufNySxkMgyKT5GLyCadtsaA0VZ9/WeRFuAIjhhTMnd55pAJWda1pQN62PNtQuJQl22YDI59p/je0Nd/w/FeA5xVfvOG1q5rDyTrwx/8W3JmfEIrEh06eYqKKkjJwly3aL+1pm56SQ4BF+gpWDbxfN3vAD/nSxZWscuSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8OMRfWc45MUKo0rqee+Z1zrEDI2fH/okh8YdZ/vjNE=;
 b=YqpHIJnaBOJZkqtbV3SDaTsnL0sjY1/w7b4TzDiRYLWJRljjQjSOYmBXTgZ8iE1VeBW+8AfypERavY1lLfbH1VEyPNKmN4YUCOdP5L7nP+OlfxivVB0pPYY36bbfaOQY92tTlsgaP81d3Bmc++Izk5fMKnUW+3iWkXuqO2sqPEcZxBKlBZOHDnUbK8xYdbLVnGsE9+vKN3ZFNmfXcM2ULiO+eJ6C6o4/k5APghZH9y9ApdTJOG0AjXFuh9U7eyzkeRxYNlS9jVfEEYMvFfCV9teSlljFqGmHgf/ahKdQwIoU81zsIf7wKFqW+7BitU1Wq20P/PQk0rDyFWQ4AqMt7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 16:17:15 +0000
Received: from VI1PR04MB7165.eurprd04.prod.outlook.com
 ([fe80::adfb:2fd2:c873:9707]) by VI1PR04MB7165.eurprd04.prod.outlook.com
 ([fe80::adfb:2fd2:c873:9707%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 16:17:15 +0000
Date:   Sat, 15 Jul 2023 00:17:02 +0800
From:   joeyli <jlee@suse.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        jlee@suse.com
Subject: Re: [PATCH] Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in
 HCIUARTGETPROTO
Message-ID: <20230714161702.GJ5866@linux-l9pv.suse>
References: <20230714160854.20562-1-jlee@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714160854.20562-1-jlee@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYAPR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:404:15::36) To VI1PR04MB7165.eurprd04.prod.outlook.com
 (2603:10a6:800:125::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_|AS8PR04MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d26d2c-768e-41cf-48b6-08db8485c963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ex62Is81eijRCNx967d+9RM8B5WlaUDhmiQ+eEe5ZxKH0JZGvsTl6gpe2FjRer8PVrw+Yozpr3wy8J2B4i/Seh9scg3dx1ilLCKsNCNCyevVRDijJMV8Dc71pSh+yVbbLggoYMP+EGpypkeCpt8xnKmEY+Vul+fXqyQVsvHjuTLflunhj05CvwjlOjRGqfvlavXOi6rIDJ2agRrfCfAeoCdGQBgcfxt5q8hIswCGb/2g2l0O5WqrZxF4k8fmnYVLie9jtIt75Xwb92Xaf04/lpfdGgDmMb8A39OPkjKWPi7lnIqw2a8Do3HacSEbEfFsxAxalYp2h73dV8y9n82aRojfV3BjknYbgK7ZcbQHThQZzeeeFJEfnxUKDbKPiTBhDbZWEXJEVHPU0Z3apW6kSdzxbqC8MViBs4qoxuaFRQ+KuChhYLBOUmCQUqmLwo+XW9ACHeSIYIUK9Y8t8VTtfzQljKlxBHsr3s21EnESGY/u8Gbuwxz7OXKLxNL0koFoDiKpWEtYdZyXTLDmhdxYyjkU7aq2mJDN//WgC0FaTh07g7Oqwyrfz0oAQJ3oBOCq8Rt5h4fdL0Q9etdq8jYzDc20gGQ/4NkKAcqkYKhRg8WMTpGE17pgx2mlFsaFCCSIR6LJ9S0KeCQb/gkecqlMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7165.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199021)(107886003)(478600001)(966005)(6506007)(26005)(9686003)(6512007)(1076003)(6486002)(6666004)(8936002)(8676002)(33656002)(83380400001)(5660300002)(316002)(41300700001)(86362001)(2906002)(186003)(38100700002)(36756003)(66556008)(66476007)(4326008)(66946007)(6916009)(54906003)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VOgDZS5QiMmPigKEO8YWT6rrCLQ9WNNHtYRgJZWq22kU+Zre5Ptb+huTI+h?=
 =?us-ascii?Q?KT0gA4MWf7OSP6RUhtLagTBYZ7A3sICKyjS9g5lN79gZcs4C1sWD9dUbxb4c?=
 =?us-ascii?Q?IaMbLv8vbpbniI0XwM3wb3bDv71kPFsoYFcHAXSnhrfPIQIdOey1wObAl5N9?=
 =?us-ascii?Q?GITP8aCN4/WQJvpjK7UkvqgwLuYnh08Jxha7X/EW0oLQn9pSdTYz/NLNrIfG?=
 =?us-ascii?Q?nYiP5+4GU5qzljFsXpFTbNYQBuScVsd/2Y7omhbQW97zAduT1+ZlB9JNDT5P?=
 =?us-ascii?Q?ae4vTIdCeNFtvPdFXnwhVe4QK42utp9B8IF/tzh1Ws3sg3tUDXaoKqC6mee7?=
 =?us-ascii?Q?sIqEHZotfyKUrtsl+nhskbosJWk7JD8Hy6JVLHZ8jBkUI0I2+GD329K6b8vy?=
 =?us-ascii?Q?Dsg09VdoM0v1FRIJkg2oAwUxhxBpJyoBhMMhRyEVMGDqKUIA7ZBJ2ZZPSaxl?=
 =?us-ascii?Q?IbkeND07X3CBex1q35wrMewLEpmEj3CIIyXDI144d+1N0vzqEKxgKjRZKB6+?=
 =?us-ascii?Q?jE6lLtu/RrP8VMzMWfkk1ewIWAXze8PBBICANmhJPSf5eenLdQGJGTQqGJxT?=
 =?us-ascii?Q?vFLcegRKjSrN2vOIIlreZe4hh9doUownI2Q4Wafu1vyCvxv1oVWweE0EhG8g?=
 =?us-ascii?Q?pqCSxTb8j718xp3O5HKQNjyXQGCYFYVukcZPrqWOBWlJS28PE5/HLScSDchi?=
 =?us-ascii?Q?el3QXD/3QwQjNC4ySHw0eXQwLx+HpdzzM/TMr1d9JZbJMeglyRXzp9yEUziT?=
 =?us-ascii?Q?zUpyXAEBk83s/FQdad5QbNyTDT9J0SoCdhDb8xKl6+O1gsWNDLp7NzQNpkD8?=
 =?us-ascii?Q?KyHdjBJIrXBWedzYxl7sCYpmEuFabqju3wc2qHiK/+hJN/Uq2zEFgLMUxdsw?=
 =?us-ascii?Q?zZJwTq0DnMrMV2Re6R8cgYRQ4jMAD8Sa2hMdl3rpZZv7XXjvOsWpa9uOCcbP?=
 =?us-ascii?Q?fkj/4TJVCL0je13u52YGtFO4nvPow3RiqSaseO3HaRtkiOqg/6LN1Lft4AOC?=
 =?us-ascii?Q?S7c9qUrEKF6/wfJvrj8WD5HuTrmyO9qaDfBCdrtyBFLrObYDUNlCv2aWTUtD?=
 =?us-ascii?Q?ntxUMf0z2Vxh1htD5GShFDMKlbu9tw8KoCqH5xKn/R7Lf7QhKAaRI0bSDPl8?=
 =?us-ascii?Q?EkVvuSVnABSu7Fdtj4MvJtjRP+VjIhl2bQ/Vz/vPPil9xngpgO6Pr5L6Y6S2?=
 =?us-ascii?Q?Jz+VtayZVHa0mD6NTAWA3G2KZL79P4aJhxSbyzdFHxEo9xbLVgsn1nvPGSR6?=
 =?us-ascii?Q?Zn3dPEnacyla4vEu/U2bKBiQe8QiHmSvaxYM9ZgE2U9bWmhLYBjckna3fpuQ?=
 =?us-ascii?Q?JYum10+pQmPgJXNB4Kpu8jOWiZbt4I1KnwLT+ZcpYCDfhpYrDuD/XB2OCPY5?=
 =?us-ascii?Q?Px8vbjc5yVjgJH1ecvtfLQ6T+Kw2nXKT8+XYshGJmWUoScvMvkC6Se0QgLKz?=
 =?us-ascii?Q?jNVFLxDf2KYQqBhGy1hirlIajWVRMDEzuJTJ0k1LyFqgGn/MNpiqhDqlE2wz?=
 =?us-ascii?Q?7FJgUOWKtNisdIsENqENFmWue43OVKAgWb/P5kiSzcpSFecVzURcysw2I8p1?=
 =?us-ascii?Q?dITMEpEAAJFfK997WjQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d26d2c-768e-41cf-48b6-08db8485c963
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7165.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 16:17:14.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzYfRswiOMX1GoHonzGyCQspOaiuVkJKG9onaw0RHrCGBukmDs22IOqjN3hrEvdP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz Augusto von Dentz and all experts

Sorry for I send out a duplicate patch again. Just ignore this
duplicate patch, please.

Thanks!
Joey Lee

On Sat, Jul 15, 2023 at 12:08:54AM +0800, Lee, Chun-Yi wrote:
> This patch adds code to check HCI_UART_PROTO_READY flag before
> accessing hci_uart->proto. It fixs the race condition in
> hci_uart_tty_ioctl() between HCIUARTSETPROTO and HCIUARTGETPROTO.
> This issue bug found by Yu Hao and Weiteng Chen:
> 
> BUG: general protection fault in hci_uart_tty_ioctl [1]
> 
> The information of C reproducer can also reference the link [2]
> 
> Reported-by: Yu Hao <yhao016@ucr.edu>
> Closes: https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/ [1]
> Reported-by: Weiteng Chen <wchen130@ucr.edu>
> Closes: https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/ [2]
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index efdda2c3fce8..a76eb98c0047 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -770,7 +770,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
>  		break;
>  
>  	case HCIUARTGETPROTO:
> -		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> +		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
> +		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
>  			err = hu->proto->id;
>  		else
>  			err = -EUNATCH;
> -- 
> 2.35.3
