Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8A7B21F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjI1QKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1QKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:10:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F242D6;
        Thu, 28 Sep 2023 09:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CglpReCmXDhk/FI5cAkVU+u0frrPpH0N/H2D6YBb6btDFi7Qt4ddQKXqp9kzNO+jU9XuJk6ax9N+ACIlXsyOkV2Bv06y25ixyABxxM7WW+zlEq3JRNcqfAthkghoxR5/BJMvCUPUjcN+pTbWL2aK+CIj4483aHsuphX3AowhwBDFLyUHomulyWfUdJSsOmL8oBYTSHn4EJTDaLx4QbIjr5giLzanymhxddPPKPtOuz/NEOP282ev75pnOXdDsoh1HocmRN2qze0EF/dmMmneigQ+JK8R947QSG9qigPEuUlRKeQNyXbwdj5BY8jCCXl8KOaoRBuDo1sycloCdoCXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPfLkQr5e8DhPVJgYgigehL/oNd6W6ueL5IQFC3hnG0=;
 b=GHl3rZEOBliAfXajM24BGuSPshG7u+Lb/ZAiGu7Meb0Jwj5O9gatDHw6MU2pVlJnth1z+kb67QRAPnAW8v2RDdQ+QyoN7AGMJAwDu3ogwT96Xy/xqqF4UpS2YmkHsMNyhE1ULFXnomTUTGbw+4iOKspXBA1pTeQc1BkeITKcG0kjZ2XzcsqKYXaaGS6FXJbUuJbRPswu6jWt68Qftse2UHT/ATdlCWLBksqIYc/39/AkiCi38LycyyJDE6gLHQK19PFTaOWNzWmxHgq2730HTcW+nfzN8w8l6mJ3IftBR3qtTDvOEJLX2UnOmHcTVPYUT5CQG7+Hh60jpD21/xKUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPfLkQr5e8DhPVJgYgigehL/oNd6W6ueL5IQFC3hnG0=;
 b=WQPd9SokDK54fckyYWMmrSw9zMRIseqVOEpTgNKmw+lb77pSW1H/A5xZDyuObnQWcuEjHJiaWxQ6vQNROV26Vx03Rv7SMY1mBkiby4OWHFy5xF0SQVaR1kiTTVuBpZJgVDkZ4KjLHO3Xa/+pjGABQQVpM2LdOpQBKv69wl+dpXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 16:10:05 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::8304:46bd:5017:3dcb%7]) with mapi id 15.20.6813.035; Thu, 28 Sep 2023
 16:10:05 +0000
Message-ID: <8ed6d9f6-918f-46aa-a2b7-a30c99dcce7f@amd.com>
Date:   Thu, 28 Sep 2023 11:10:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rpmsg: virtio: Make buffer size and number
 configurable
Content-Language: en-US
To:     Divin Raj <divin.raj@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Peter Hoyes <Peter.Hoyes@arm.com>
References: <20230928153825.151948-1-divin.raj@arm.com>
 <20230928153825.151948-2-divin.raj@arm.com>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20230928153825.151948-2-divin.raj@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fab851-173f-4dca-79d4-08dbc03d6088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTCcCRobEb4AYjecB9pyDAK+EaRgWh0ict9Hifwu0c5mwO3bEbLQ6lXHxNgSMClXfdHbp8b+u9Bz670IjIBWBKxHwro2qf68ZPggWcv6G9es3/qwevhmmw+xfbZxxzN1ohvArhPWwMliqEPeulMPGKra6FbFACfqI6/57p6yCOFFsL7+ejufwNfIHbHp72o7QmAemgexGuhah+D30I41QkKLSbzdJpckQW7SJDVL3GsA7ZOWJjaQCsBor4YvzO+0O/cs8bpxGJwn0uU37zljPmSdQJ+W4XT/+f4vmHHDfqxUGUTxGJsKsW3pb6HeNfURrUVdlCB+IOKSfNAPDuNbYVBqKhMcA1HwYBAPGvBwaTrwrBmOBuT5KryUyfZPZc2o4Rv/d3rBHZXGxntPYpZaMMiShogIVRom1s5Lb9PYmF9x+ael79o+LPMOH2TmvyK7rUPTY4pKOgx+jcrnClyI9ZBbk0ogWm3JxyUnzMb2mM6RHQKosMbziuBVLVupLk7fdKODj5MfO0cubQqshV9u12Fx0CYXXzPIntHUhxUCKoUqH3Ue8V820fTF9sQpRTbXZbAqdcN6w2kzv1NTBAIgYTJvFMJcVfWegNZiaNKYqmtg7zZxzMtxBPKgx0ShLXN5QE/i6h/kqfR+aCPEoDHfFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(6486002)(53546011)(6506007)(6666004)(478600001)(38100700002)(31696002)(2616005)(41300700001)(44832011)(83380400001)(2906002)(6512007)(26005)(110136005)(86362001)(36756003)(66556008)(316002)(66476007)(8936002)(5660300002)(66946007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emYzcHRMQUxjZ1E1c3QwNDBIT1lucEZIMnpRa1pPYzVIdmpCV1l6RmE2UWFI?=
 =?utf-8?B?eTRQWkJBSzVqS2RnZzRvQ0NmVm5DRVl0bnBvdjViZldtclhFQnJlTmVvNE4y?=
 =?utf-8?B?QjA3RDBIZVFzdWJhQVF6eSthcGx4bWxITi9WSzdXRkZpSnhuc2o1dVU0N0U3?=
 =?utf-8?B?Y3VCcTdTRHVQa2JmUzUzVkF2WWJtd1NoM0V4U3VWcnN4dWhRRjlCRzhpWXh1?=
 =?utf-8?B?aU5IQnF4MmFtOTBraFlwUHlTUjFaQ0M4Z2twc1FTLy9TVTVhWDFSelI2Zjhi?=
 =?utf-8?B?akp0TWhjaWJmS3d2VWlGSlBtaHZqNlYyQ2FKV0oydTVqNnlQVnRLMXYyaUJH?=
 =?utf-8?B?RzRRUEpjNUtMdW5JSzVDNllzTnNvNzZwRlNXRTNWQkRtZjB4bmdzdm1DWFBZ?=
 =?utf-8?B?WmhxSVYrQTdCKzJSQmFIZHEraUxYSFkrZnhKVEdvN2ptRXNJRnFDYzBHdGdz?=
 =?utf-8?B?dlM2bmdhT0dmNE83ck1hdzFLVVlseTRMNEx5N0padGpYSjBjcGJSUDJkZWNm?=
 =?utf-8?B?Y21QTTdOVUFTcjNNaU9FMmxEWWxzSnhKVzRBRWc3TDVIZ1JBaTlRckdoWG80?=
 =?utf-8?B?VW45cE56alR2a2JTcVBXcXJkRDF4dTlxdndMUzByVm1JK0J5L3cwWW9ZUnJq?=
 =?utf-8?B?Rmc1Rk1oY01DZmdlSm0rVlRtaklxbHVMWkp0NnBXdFlyU1FQbmNvVVpTME1I?=
 =?utf-8?B?ZiszZGRDTlFzMmFQU1NhbExQT0RnTG5iOTdNWFhyYnpLSkJpcXZVek1wTjZW?=
 =?utf-8?B?RTR5bisyL2NYRlNvRHlBTW1NM1R3bTVLM0NmVHErV1V4OFdyT0s3QTFBWDVD?=
 =?utf-8?B?UnNNTDdpZGFRZUgxM3pqSVk1ZUV4cHVsVXlRclpHWStRNS9CbVV3MEs4S1c2?=
 =?utf-8?B?QjkyNkZ5MDdNQ0VHUWxKTm1NcytqajdIZk1nMHdLaXdod1h6bEpLL0wzV0lX?=
 =?utf-8?B?RUE4UVQxY0R4Y1BIYUFGdlhrYUw1YWRVazlwZlMzRzdIeFc4WE1Sd0pPNUov?=
 =?utf-8?B?dEk3cHRaczc3UHZjODRzaCtrQkdJVGNnQ0NHTnJQWE5qTmdnVmZBRnNIR3ZX?=
 =?utf-8?B?N2JDbDJqM0pMTUlvUjNFL0N3VnYxYlFMK2ZDbkdkT24zaTRKUTJYcWVmTHRx?=
 =?utf-8?B?WXhWTkd3ZWlINnFnd3pORXhZdTN0YmkySXBYeDFoWmk3QzZwWG1kRDlMTU02?=
 =?utf-8?B?dVpkcDN0M0x3UVZwNG1nVTVueXRqUCtaNmhxMkRrVEFTQkV0Q2dGZXJhSEN4?=
 =?utf-8?B?RFZYM3FsV2pXUlppcnBEMThXeWRwUHBaVUltNVptY1FXdUV3bDRtc25vMFF3?=
 =?utf-8?B?ZjF3eUltZnBGYSttTlplc1phSW4yUUE4aWlaQWRXUHNuSDlDM1FXaDN1cHBi?=
 =?utf-8?B?K3pIYk5GZ1dzU1hwMGVaZERrYXNhMVo2NE4yeTZBOHViQ241WGdxamYxdUpM?=
 =?utf-8?B?a1p4ZDlsVEZ6c053ajlRNE9NN2RHRFh6c01PVktSYmVwMTFmK0haWFczbXlT?=
 =?utf-8?B?bVk1cEp1Z3VlUFBBY3FXQU5zSXgyOFVNVWtHZWFwdnVqRVU2T2dFNkxyejdV?=
 =?utf-8?B?ZGh0aml6R1JSNkpnVzhkMTN0NHVidENDa1J1b0E3SS9wTkFGejRSTzlWOXBt?=
 =?utf-8?B?OU1PUmpwOTJsQWZKcjBTWXR6dFVCcWxpZjFRNG94WTVlWTZ3RW5NRGF5RjBO?=
 =?utf-8?B?WEp0UnI5dTdxVW1UelpwcUpORVp4SGEwVEpndHd0SkJRWVF1bEttM3JJYzY3?=
 =?utf-8?B?VXdNd0xpZmdZNkoveDh0WXhwTmYyRldmWmJ2azVsK1RaVHQ5SytRaUIwc0Vt?=
 =?utf-8?B?RjJTeXU1QW1UYlBmRzg3MWhHQXFyejA1UEtJaXZJeVI5NG1pQ0NzaGYwS0pw?=
 =?utf-8?B?NXVIcTU0eS9wdFVtZjc1dkorUEdJNVFSWjdSaEZ5eVlzNmM2NmFReGlGdzds?=
 =?utf-8?B?aXlySUpUUVJFSlpGbVBtQ2hkY0xJMlVxU1FWOEFNNVJ5U3IvdnpFKzk3M0xY?=
 =?utf-8?B?WDBXbXVWZzN6OGJQazMxSmRuMGhBVnRFUzc1T0VmaEpEbm1oSDl6dXVPTHhL?=
 =?utf-8?B?YzBpbGQ5OXhXMXM0M3JiN25oTEl2SGVKZzhhVUlsTkxaZDFrTHlqOFBUZWhl?=
 =?utf-8?Q?ZkR+LSJeo1mA7eioiyZF2a/k+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fab851-173f-4dca-79d4-08dbc03d6088
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:10:04.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72tdwvAXIMuUXCKBUpiWWtaHHZJ55T60vDwuUrx34SLGDLWpnziZ55XX1I2YINhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your patch.

Instead of having this in Kconfig, It's better to have buffer size decided dynamically. Probably by resource-table.

We still need implementation that achieves that goal. Meanwhile  I think it's best to keep buffer size fixed.

Thanks.

On 9/28/23 10:38 AM, Divin Raj wrote:

> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> From: Peter Hoyes <Peter.Hoyes@arm.com>
>
> Replace the MAX_RPMSG_BUF_SIZE and MAX_RPMSG_NUM_BUFS #define in
> virtio_rpmsg_bus.c with the Kconfig parameters CONFIG_RPMSG_VIRTIO_BUF_SIZE
> and CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS, allowing user-provided customization.
>
> Making both the number of buffers and size configurable facilitates aligning
> memory requirements between vdev-buffer and vdev-vrings for client drivers
> that require larger buffer sizes, for example.
>
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
> Signed-off-by: Divin Raj <divin.raj@arm.com>
> ---
>  drivers/rpmsg/Kconfig            | 23 +++++++++++++++++++++++
>  drivers/rpmsg/virtio_rpmsg_bus.c | 27 +++------------------------
>  2 files changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index d3795860f5c0..677f4a1ac8bb 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -81,4 +81,27 @@ config RPMSG_VIRTIO
>         select RPMSG_NS
>         select VIRTIO
>
> +config RPMSG_VIRTIO_MAX_BUF_SIZE
> +       int "Virtio RPMSG max buffer size (in bytes)"
> +       default 512
> +       depends on RPMSG_VIRTIO
> +       help
> +         This option allows you to configure the maximum buffer size (in bytes)
> +         for Virtio RPMSG communications. The number of buffers will be computed
> +         based on the number of buffers (CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS)
> +         supported by the vring. By default, it supports up to a maximum of 512
> +         buffers (256 in each direction). Each buffer consists of 16 bytes for the
> +         message header and the remaining bytes for the payload.The default values
> +         will utilize a maximum total space of 256KB for the buffers.
> +
> +config RPMSG_VIRTIO_MAX_NUM_BUFS
> +       int "Virtio RPMSG max buffer count (even number for TX and Rx)"
> +       default 512
> +       depends on RPMSG_VIRTIO
> +       help
> +         This option allows you to configure the maximum number of buffers used
> +         for Virtio RPMSG communication. By default, it supports up to a maximum
> +         of 512 buffers (256 in each direction). Please note that this value
> +         should be an even number, as it accounts for both transmit (TX) and
> +         receive (Rx) buffers.
>  endmenu
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 905ac7910c98..87a9a4fa30e0 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -109,27 +109,6 @@ struct virtio_rpmsg_channel {
>  #define to_virtio_rpmsg_channel(_rpdev) \
>         container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
>
> -/*
> - * We're allocating buffers of 512 bytes each for communications. The
> - * number of buffers will be computed from the number of buffers supported
> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> - *
> - * Each buffer will have 16 bytes for the msg header and 496 bytes for
> - * the payload.
> - *
> - * This will utilize a maximum total space of 256KB for the buffers.
> - *
> - * We might also want to add support for user-provided buffers in time.
> - * This will allow bigger buffer size flexibility, and can also be used
> - * to achieve zero-copy messaging.
> - *
> - * Note that these numbers are purely a decision of this driver - we
> - * can change this without changing anything in the firmware of the remote
> - * processor.
> - */
> -#define MAX_RPMSG_NUM_BUFS     (512)
> -#define MAX_RPMSG_BUF_SIZE     (512)
> -
>  /*
>   * Local addresses are dynamically allocated on-demand.
>   * We do not dynamically assign addresses from the low 1024 range,
> @@ -902,12 +881,12 @@ static int rpmsg_probe(struct virtio_device *vdev)
>                 virtqueue_get_vring_size(vrp->svq));
>
>         /* we need less buffers if vrings are small */
> -       if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
> +       if (virtqueue_get_vring_size(vrp->rvq) < CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS / 2)
>                 vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
>         else
> -               vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
> +               vrp->num_bufs = CONFIG_RPMSG_VIRTIO_MAX_NUM_BUFS;
>
> -       vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> +       vrp->buf_size = CONFIG_RPMSG_VIRTIO_MAX_BUF_SIZE;
>
>         total_buf_space = vrp->num_bufs * vrp->buf_size;
>
> --
> 2.25.1
>
