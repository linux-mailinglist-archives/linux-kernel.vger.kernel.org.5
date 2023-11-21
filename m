Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3827F257C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjKUFrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:47:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5358BA0;
        Mon, 20 Nov 2023 21:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbSCfrXfj86y0U6KchffjEYp5z9sBoE8pDL2LUQ0xHxcxHPdImH0wTaZxYvkn+MLIrOL55HtfbYsdwmnSAPsR6mKQWiRClQO1hCO3+nEbDR3mB1vkIsESYeaQoNdMjusuJhFcEawXHPlje0WXe6o4iwACzId6cG327KxLz3VGtBH24sTtlXhbXTas7F6jTeSjvortucHUFcAg3Hl8lWNN+CNEno61dJesAW3kVOWEkb+rGLDjr6XEsJcZ5WPKbvAfJXT4GoM2Y0xNjeILQQiBz0tljDAdwV6pLvS902Yi8N88V1JjvzZyJXvmDKj7j8CrswZ5DX/w5gBbSZeMD/Jug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLYECJIn+OMMlktkYLP+kbnvCTuoK4OJLmIjJKn4zrQ=;
 b=JoWXHMAIzwOnayUzETN1x23Awhv0Z6fG7e+A3Fz3pceSZL0Ee/fJbSIO1DKNvQtt4b0MoAsNANvBF4EARexocJLOou3nnVELRy7H5al0VdpgkNEOSIIqFI9wjTazdHy2RWgd/o4mSoWUHFOlbpVHlrJPHRjP3pyPJxql9YhTaQd+5AZ4GY5c7CuQfzJ+jBgFkFwbT2vGaLupmI7u6pLKiNUuG0fdqjgXUSI94cihPq8FV6Sg0EU/yjYxOLp4VUzv9hQ8Mk86V5Tqurb+tvjubFeYmC7p/rxa7zh6/4CjOiznn9NcrmsPFNaqh9OBwClysGlJXz1GQSfbOnmNPCIvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLYECJIn+OMMlktkYLP+kbnvCTuoK4OJLmIjJKn4zrQ=;
 b=Q/EGeIJj1C/Gm5zDkUNsKO0KcemQ25rj4VUFx8zFKtDO3i6A9ObilKQZjm/t6NTCwqJA1CDx+y0ZKi71w4zdXO2f914XN+ZiBaShxKfaUNhLAR5IeNew3XT0j5iniiXR6Uw3ZjiRy+gB1vgklw73VKn3mIcogetJLyJTk8RmFdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 05:47:38 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::83bc:6ff8:d40e:a7fc]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::83bc:6ff8:d40e:a7fc%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 05:47:32 +0000
Message-ID: <2d234d31-3045-72f2-57db-db03515eebcf@amd.com>
Date:   Tue, 21 Nov 2023 11:17:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] phy: core: add notify_connect and
 notify_disconnect callback
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Roy Luo <royluo@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
References: <20231110054738.23515-1-stanley_chang@realtek.com>
Content-Language: en-US
From:   Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <20231110054738.23515-1-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::10) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7405ea-32e9-42f4-0876-08dbea555aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJlOzhk84k36T8qPPZos+8yaIZ6UAge1RWTMANxo8+XXIgJpiiD2ftWJhr4fe4hWbT017OnvIq3NpkbA3/O6q0ikkONpTQ/Ixgw2p9ZzsacDyb6JcL8lISy3XVsEiPA4hNuPyv0s694HF2LnxBUfwxWbbwnmakB5kGNvUBq9GJa/J8mZqcxWT55Nebe5Li3Y9y/FlA1tCzeauGdBXL6dOlHzCJW6lRvu8jfn7hE1FMZH8I/o0HvyssDKNlh8292OUoRZFhaWpRbFjvvbAj2LBFvmNHh/laNdRrEOW7zaDto/N6eQtvGiEXVH1p6e1McUF7xmOQh9O0kMdNCIzyK2sH2egxjicAb6wvWw8/DAIjv6p71FJRJm5NtfVtmS0xkpDB3PT8a4RTPEaTOkNmq5OAXmQy4TX4nwDHWeGgomiqMpexcgm5Fxcfic8arqf1vMXGfiOnKee+q+h5/DaVrsEZCoeQn0p1sL3j6D3VAiGNLPsKRO52xXZq/MdMAIQmzhjFhsimjkn+Rn5sVlDAyHevGmY7MebXBzaKcJ2GGFO5HoCrbZPPecxT7AqF0qixaERuYFzw1np7ql/dwkRmjzElRkXahxVoLktijkbeUynG+YUsWzNRC4hGDNPHazecLmSeK9CYrPxN02Gc3UdVmOgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(31696002)(31686004)(110136005)(6486002)(6666004)(6506007)(66476007)(66556008)(316002)(54906003)(66946007)(36756003)(53546011)(6512007)(26005)(83380400001)(7416002)(2906002)(5660300002)(478600001)(41300700001)(38100700002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0dMQ3oxUU1pQ0hBOHRva01lbTI3ZmdLaWJjUVNxcVd0MHhvc1JrTm02VEYr?=
 =?utf-8?B?QWtqOUNreXlaN0Eyb0ladnZSTXVKWTY4blVJUFBZZ0NMeSttdVVHc0NsTXdn?=
 =?utf-8?B?NGVYa1ptSk5ZYkhRdEVIcjdZZUdrdTFNejJSNGs1bEhKbzZxV0NXRmZYVVpN?=
 =?utf-8?B?STd3aXVWcjJrbHo4N0E2UDZEa3BkWDdwZjR2SENwS3RCYXVOME1PQ21oR3A5?=
 =?utf-8?B?NXdPektINXFJdzdCU3JMejU4ZmNvVGg2SWl3Lzc4L0YxNG54NmhPMEwzR005?=
 =?utf-8?B?VjZ3NklFWUpYTUNNL2Z2dmw4aDJNNElBdGxPOHh4Q1dLbXYwaFFYZ1hrZVNR?=
 =?utf-8?B?bWw0b1pQNlFxZlRwNms3VHcrdzlGSTlCdGRvUzFObGw5Z0dLbk5tWEdsMm95?=
 =?utf-8?B?aCsxY2JsQzMrWXYvdWFXdWtnY2J5eXdVNXNlcTdhSkhUeXduaG5TVCs3TEhz?=
 =?utf-8?B?WEFFdDN2WGhtdlFxclhTYldSallpcFJIQXdOQzdnRWpkdDVLZVRNNUY0SkY2?=
 =?utf-8?B?amszZXl2dkRnTkdxWk9EZm1xSXc2R2xCa1pnVlhnQmxiTkdVYm52ekZCdlkr?=
 =?utf-8?B?N3NnNTN3ZjVteVRyLzlBamYzRGY4QkpTT0ZhOVhCYmlqZmo0M1l4a3dwYmgz?=
 =?utf-8?B?dTZvcllhRmJvSk9oZzhNblhtZXk3dHJyWE9xcnBSc2x2LzVLb2VMMG9mUkx6?=
 =?utf-8?B?dU9rRDJFTHFQQWE0eXBub2M2bDRzMVFza1l4c0lPbTNCVklBc2Vxb3VWNFlF?=
 =?utf-8?B?elpaYXI3cHY0c0dvZEpzd25iTFE3SXNHQWU4T1h6OGZ6UlR2NFBweUhBMC9x?=
 =?utf-8?B?SXA1NlUwSVE5WFB5QWNRR0dpTWhqVjNxMXFWN2JlYk5BdXdwNGJGbks3RGFk?=
 =?utf-8?B?aUkxYnpweTZySmlET3UzcmRwUml2UFJYN3F2SnBsNzAwc1pMZXR3dFdGRk9p?=
 =?utf-8?B?d2JheGZLSzdyNnlQeDVhcllvN21YUjkwc3ZQVmpka1lDZGR3WENvNFNMZ0NI?=
 =?utf-8?B?MyswYVgvN1FMTFRPYmFnamdXaXh4VmpGdDcwbDVUUEhmbFEyNHczTWZEQSt2?=
 =?utf-8?B?NFIxc3ZRcmZDMHZKUk53Y1N6cHRMdXR1WDNKcHErZzlra0dJeElpQWRnV2Fs?=
 =?utf-8?B?SGZNcHRxcm1sU2QxeXBqY0RBL1JQRDRGbjI4L0lYS3kvcGtBRjdCZHpVN3o3?=
 =?utf-8?B?TUVPcHZXVmJLRks4RzI2UWVEZm9NV0tIeHB5eWdmMmRqTS9tc2ZadnJrUW1i?=
 =?utf-8?B?WjJYcXdaM3hRWllqSnVEbCsvZU9BNDBPTUFEekpSUmw2VCt1T0VPMEQxRlhm?=
 =?utf-8?B?TThlTU9rdzQ4czdsbjlGMUxYKzRpOSs4R0Y3dHk4YWRzVnVpM0syNXgzM0JI?=
 =?utf-8?B?YXF5WUhFZHFuQ3hsUG1zTU9JaXpkemFvN2VUWGpXblJxS1BHeWhZMm1wVURp?=
 =?utf-8?B?TmhTSVZIRmxldXZLTGdiRFhRUVkxWUhERG5Ld04zRVNZcHc1R0hiQnl4Yzdz?=
 =?utf-8?B?L1NiK0FmcW54eUNLb2IwbTYwTHZVQ3lsaDBjSUlTTndpUzh5cDB2c1Y4c3VY?=
 =?utf-8?B?MWRUdnZxYmZhTm50cmxFb2hMMHVsRjloMnRNaW5iZmc2U3A2djVUa3h3R1U0?=
 =?utf-8?B?Q2ZRbUhySEtIUG8wZHQzNllwQldmSUpnQk5aVUJqcGxYTXAzT0FMUWw3U3Y1?=
 =?utf-8?B?SFViRCtTN3VXNVZ6TUw3ZHNOQzliMkJpcG51bkxBRG1pSll3N2g3Y2lzVTQ5?=
 =?utf-8?B?N094ZVpVa0Z6RmZPbno2N3VUTXN3VDcwMjFsSGFFT012K1JYVnM4b21OUlhR?=
 =?utf-8?B?VDQzcVFlNWNvMFREM1gxV3FQaWw5R1FSZWRxSk5Wc2ZuSlhUeFd4Z09TeHg3?=
 =?utf-8?B?c3QvbWhhbkZsQjhYSXdISXdpZXVJaXBDcmZIdlREZnVjcFg0L2pVejBIWE4z?=
 =?utf-8?B?TExjMXB2R1ZPVGFPMjRIZmRtaEI5RDVpbExwU1FtY2pHblkyWE1kb2p1cUlH?=
 =?utf-8?B?UW9qK0IwcWlrdmFleHorM0ZtVUlISWxTK3ZZanN1SHlFY1ltSDQ3MlNFUU4x?=
 =?utf-8?B?Z0w4b2RnQWU1RWl1MmlUa3QxVmxFd2dheHJsWS9rWXRNSGxBUTlvNWEwaDVo?=
 =?utf-8?Q?Lep9QGK6POfS806/p42umzjbB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7405ea-32e9-42f4-0876-08dbea555aac
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:47:32.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxt7LMdrZurohbs3mvPrmPmK6nbsBJm0+MahIoVpW/tPDHV4ARHSsY547nzaGo5wbOwvqD/ybYXTxx7jQ970Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

On 11/10/2023 11:15 AM, Stanley Chang wrote:
> In Realtek SoC, the parameter of usb phy is designed to can dynamic
> tuning base on port status. Therefore, add a notify callback of phy
> driver when usb connection/disconnection change.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v1 to v2:
>      No change
> v2 to v3:
>      No change
> ---
>   drivers/phy/phy-core.c  | 47 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/phy/phy.h | 18 ++++++++++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 96a0b1e111f3..a84ad4896b7f 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -489,6 +489,53 @@ int phy_calibrate(struct phy *phy)
>   }
>   EXPORT_SYMBOL_GPL(phy_calibrate);
>   
> +/**
> + * phy_notify_connect() - phy connect notify
> + * @phy: the phy returned by phy_get()
> + * @port: the port index for connect
> + *
> + * If phy need the get connection status, the callback can be used.
> + * Returns: %0 if successful, a negative error code otherwise
> + */
> +int phy_notify_connect(struct phy *phy, int port)
> +{
> +	int ret;
> +
> +	if (!phy || !phy->ops->connect)
> +		return 0;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->connect(phy, port);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_notify_connect);
> +
> +/**
> + * phy_notify_disconnect() - phy disconnect notify
> + * @phy: the phy returned by phy_get()
> + * @port: the port index for disconnect
> + *
> + * If phy need the get disconnection status, the callback can be used.
> + *
> + * Returns: %0 if successful, a negative error code otherwise
> + */
> +int phy_notify_disconnect(struct phy *phy, int port)
> +{
> +	int ret;
> +
> +	if (!phy || !phy->ops->disconnect)
> +		return 0;
> +
> +	mutex_lock(&phy->mutex);
> +	ret = phy->ops->disconnect(phy, port);
> +	mutex_unlock(&phy->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_notify_disconnect);

Please use EXTCON framework for notifying connect/disconnect.

Thanks,
Kishon
