Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27EE7577B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGRJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjGRJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:18:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7F172A;
        Tue, 18 Jul 2023 02:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESJJR3QOtY2KdKXoI4aFs98eKheoPd/E5qE0idIRXdlX2UgjefPofuryn0paEd9EFAtppzdw34/n/xk6UzeXyPp7za+ZGwZPzL3v1MkJy6CUDE+8ZEIGc2l37fZwf/kFUt9XWSPKDCu6J8oxdNPGO0OLC92dEEs3hQxmb5pYElj11k9/PlLC+dj15Wnjr74XucLkb+whstDD4VOCRojXAANkJWTXT9eyOVCc/V9dUJe6Ab4+51e57B6HIadMbMrNysViFXgn/GxE9ncnpjRKEzXgntDUmQrEX0q4R4IskOwXKGd3Cxo09lKdWrxQ5GjK2BtOxDfJBM5QJECVAwdZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUe1b4S0uxlwZ5d3lOzfuxr1mcvOmnmxba5lpfAu/SI=;
 b=FWgzz0FrbzHl93GQmIoCbUoMl6sb9SOc32DlKcmtftQOOhspFGheg/YGgwZgHtTaZWp2iy910jCSM6fLNR3yVnyT1fyka7AwCXf14LlaORcTAyhg3dOqjd4EQog5TPuV90vGLimQlB8jANaTyMIc3V4MXnDGR38eYskrfR62MxpE5/bZD4yhPEmOAKHChxSbRjP8pc83nih7bTzhincDBiaEzsIUFoghxTfL3sZx5U0gKbYcaKeiCnKTuWW9DuBrc+jjG5o+gRfl4XoLqZ6ta5CKRlE8oBMklcz+lmp3K68YtgOuurdcMlG0R2uOgSjxAkQ6QbDYCTyczY6Bv/a1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUe1b4S0uxlwZ5d3lOzfuxr1mcvOmnmxba5lpfAu/SI=;
 b=Tm/nJX+WiPXaP+QylaOZtNWnk1LOM1em6738drYTNo9XnoXx9bZzCF90dk3xaNMMbG2LdjaxBfFgTmmQ9lOaDP/rjEazOJ8wANDqsxg3PTM4M53IkQH7xrltHzibVOIOridhCZ3Zg3mr33VPKstEmL+A+emNGK5Ot3Wa0lJIS2a+rhydPBtYb0mtI2b0FeeimrRpsDBXMUXEaYF2iuWmK/1KwKEEJeGp/zBpRt6VInemQ5mRlXThWuWp2QlsaNfdVwHc8VW5+0Zra6HN+SVzCj2VVa9dUQIf2uuQf4kSB0QLMwZo16V4aZdu7jX/Guh9h+10JYiUKY0foc0YWKktXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 09:18:29 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:18:29 +0000
Message-ID: <525bc794-b797-9a53-7f59-debcfca9edd8@suse.com>
Date:   Tue, 18 Jul 2023 11:18:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] usb: xhci: tegra: Add shutdown callback for Tegra XUSB
Content-Language: en-US
To:     Haotien Hsu <haotienh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wayne Chang <waynec@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        WK Tsai <wtsai@nvidia.com>, Henry Lin <henryl@nvidia.com>
References: <20230718091425.307589-1-haotienh@nvidia.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230718091425.307589-1-haotienh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::20) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: a1010adc-bc6d-4c3a-0753-08db876ff2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdI3Fwjij+hCXhXJnVf6DN6P4AnjCkY8bqZ2nPpRGoGRqXiLGHMm/nn4i1fV+U5nvLYsFhlfOsanI6evLs4/5u0cd8CXyADPS4X+Uod2+zF/kXMF0/42h/jreJnikTNXPw9TRAWFVWndFQsAMJgfn6OoGdMIwmgU1qL371Z3VO1w7Xn5tnpofPpirQja10sVr3tYr/H+fgTIPWLsBBqkMzGU3QAtv4dn2UjcLDaKK+o2wlSKO+3QD/lOcHbDiEQLqN9+VhN5m/hyE7ETglJrcsAN3wAb4tyJEElcSav9uCiue9TVxJp78nC1CEnIll1sGbAeQ0vwb4dTpTxoYJzq1VsiYtWR09ExHgrxg3U9n6D18o/7ILjFHEzgCFboZt1vA1iTlITaXhZnWMdMsLhq+RQH9A3RJr/z/E7+OP97fPMRlk/qI3fn1oYPqiIhPg6DoS+pn5OEuNUq89WWTkv4HCq/oLhKcNCHCHFtLr7NldvB9fWbxnpZQOay9DIw1GqWXOa6v7+RR95JiB1lAqPO23cndWLyqySBXUqnRrkZZU8o28Be75BXy5O+qzuYROvWi5XgV5FTr7kCXiPVf8qb1ptg+6rwQqxA6lpmFSk7nuW/7lXCp4Nju1UpBBZxOzMg/zfCxy0U8t5EbGKuxhLIGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(136003)(396003)(451199021)(6486002)(53546011)(6506007)(36756003)(86362001)(2616005)(83380400001)(31696002)(38100700002)(186003)(6512007)(54906003)(8676002)(8936002)(2906002)(41300700001)(478600001)(4326008)(316002)(7416002)(66476007)(5660300002)(66946007)(66556008)(31686004)(6666004)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklYSU1JNlpxR3FHd2VTbDl1bFhLUGFqT2w4UWcwYzRLYkY5QTNKZ2o5Slow?=
 =?utf-8?B?OTZzSDV0T1NlTkR6UWgzSkUxS3JuRWNNeithRzVod21rZG9pbkkwdXVUWXoz?=
 =?utf-8?B?ekhNOHlDYStjT1NlUnkzUk5ETEtkZTJJeGZObDFBT1JNa0JlMzlDdDBVNlNO?=
 =?utf-8?B?YkdGblVNVXlmcS9vSlZKTFdZbC9Ba0RpaVRReTlVUXpMcHZoczF4MWpTdFdF?=
 =?utf-8?B?bmFUcGczYmxWOGVkVzBEMzFzV21CT2FsVFZmUUNJZmoyc1ptWHFLVnIwUEkx?=
 =?utf-8?B?eGNaU1h6dWpEVnAva2gwckQxVTlmZllKYndCOVludnlqdVFLOGxqUk5ZM2pH?=
 =?utf-8?B?UllPbU1JUGJxeVpUNXR1V25oTU5IL2NWMlRhSHk1YnlCQ3RjaTNPWmF1cS9L?=
 =?utf-8?B?dWVWRjhVWXhvWXRENkZRSjJ4UGhvbVd5YTFlbXo0bXVDazJ0NVBUUmZjS3dk?=
 =?utf-8?B?MjI4S3FyL2dyNmdNUlhkNHAwc1B4blFBZHpkR1NGZkl2aGRJalhPUXBMaldl?=
 =?utf-8?B?NlMyV0tFZ3I1b2ExQUd6M0ZrWElQVURPOHc5M0ZGNS81eVBrcEtNYWhDZEM5?=
 =?utf-8?B?MW9VUTJDMVRPV1ppT1JXWWNvZmt4bjFEYWx2MGFDMnFqR2lXSGVsNFI0amxB?=
 =?utf-8?B?eEFhcmRMZStFWU44U3lqQktOM1NsM0IyYjFIQVk5SGJWOUV4ZHdNdXlCanBl?=
 =?utf-8?B?cEVLSzVNL0Q5R0Q5WEhlWHR6QVNOWkJDcHg5dkJQT2lUSllvK2RKYVZxc1Qv?=
 =?utf-8?B?RGpHaVdTc0k3VUxhR3ZEUjRSMVR6dTAzWnNkVnBSS29BaUkyYXVaWCtaUWsx?=
 =?utf-8?B?Rjg3a1ZUUlpaRnExa2ZEenNBOGM4QlpLdWtQYXRLWFJJZHA4OFZ2VFBHaDNI?=
 =?utf-8?B?OFV5eUlZa2tmSUJ3M0RTV3RSM2NnclB3MG5hMXhZQ3N2UEk5bXJhWDArS3VR?=
 =?utf-8?B?SHlyb3phOEVVM1NqZjlNR09TczlTQi84R1huWnZDbWVZWFdwMWt3aTlBbkN4?=
 =?utf-8?B?SDB5cnJFS1pHNGt6Yk13VWVySWx1aElGcGgxcUppTGhLOXdBNWFmWFJEMHBH?=
 =?utf-8?B?aEhwYklhVGgzR2JzMmwrTEdraFg0VVdrWmdDcXJ4YjJkQ3VLUmdkc0ltTDNo?=
 =?utf-8?B?bytDSENqTjdTQytMUHpWTnZBbVBDTEQ1N3FKc0NuVk9TSFAxUFFVTDJta2VW?=
 =?utf-8?B?RmNCU0FUKzJFaDJjTlhMRVhaK1I1WW5UU3ZRbDdjZVViQXNLSWJSd09mb3Bt?=
 =?utf-8?B?ZmRTa2E3OGFuSGRlVW5aWmVIaG1PdmhvZDNKRzdBVzU4bDJIc2VTdlFMRjdi?=
 =?utf-8?B?ckVUdllCYzBIV1ZtS3krMldPT01xK2dxaERLYUpNeGNMa0s5bXpmeHB0MitL?=
 =?utf-8?B?dDFvT2sxcWFYK0RrcUwvRWF6SkdIY1FBdkpha1VLdDRDa0VTTUdjeTZsVnhC?=
 =?utf-8?B?ZzNMdk1nWG9taElqRkRpbTRvSHZBMy9mOC9abkQ0RFI0ZEg2WHBaS3AvUzBW?=
 =?utf-8?B?SDNwZXJib0VHRDNOc29BaXh2d2RVMERXSlRjSHcvTWo4TEcvV28vTkp0VEdW?=
 =?utf-8?B?V3VmOCtrQUtsaGRJdUR3NU1mNU5vUk9abFp2WDN5b2p4RTZaQW52eGxBajZU?=
 =?utf-8?B?NzZCTDhEL2o4bWhCNkdJbFdybkd4QVdycU1sNGdWRlptSW1wS01zdTIzclFI?=
 =?utf-8?B?TlgxTW1uSUdKaXZxNDdYL1RseDNSaktFbUxIMS8yY3BiVUZDcE93QUFrZnBO?=
 =?utf-8?B?UmM4YnV3NWt1YisvUDd2bGQ2bGxpQ2YrQTNycWFhaGpPalMwRjNsK3NqU0xq?=
 =?utf-8?B?bHlXR002NmRySG1RdU1wNDZqKy9pNmpjOFREVTFqMm5ycSt4NkpPckRINk9G?=
 =?utf-8?B?TjQ1ZGtCYXM2UXVqcE44Q0hEVi9JaDNLUy9VeW9KNEtIL1M1aE5DdHlFejJ4?=
 =?utf-8?B?RHZDN2g2eWVNanNWYzVQeWlKSU1lWjMwSTJ2R2FoaDM1cTV4SUFnT1hvcXVs?=
 =?utf-8?B?NGEzQjBsaTJQUGU0bVp1a3lTUVc1dFplbGNNM3NMWTQ4Y2k1OG4vVFNLSE96?=
 =?utf-8?B?UmhzUExybjJ2ODNMQmYwVVFtRVZWeWdwTWdoTEUyZE5jWjU5U1RTdkt0YnJC?=
 =?utf-8?B?T3RiOTRBaVl0cWkvRGo1T2dvbDRCTHRpdGRYK3lMdzE2U2p1Si84dnprKy8z?=
 =?utf-8?Q?DSywGBd0E4Ji1YUIJEQXcSM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1010adc-bc6d-4c3a-0753-08db876ff2c2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:18:28.8661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3U4iBQXIl0/QMY4v0K0syKto5C8jYBvMdLsNQYV6jU4TlG4YEtJF6S3YYLu85PDnfy551WGNQnl40XJ2gXzPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.07.23 11:14, Haotien Hsu wrote:
> From: Henry Lin <henryl@nvidia.com>
> 
> If memory accesses by the Tegra XUSB controller are translated through
> the SMMU (System MMU), the hardware may continue accessing memory even
> after the SMMU translations have been disabled during the shutdown
> process and this can in turn cause unpredictable crashes.
> Fix this by adding a shutdown implementation that ensures the hardware
> is turned off during system reboot or shutdown.
> 
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
> ---
> V1 -> V2: Resend for the typo in the mailing list
> ---
>   drivers/usb/host/xhci-tegra.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index a56cc81b9404..6ef2eac9835d 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -1925,6 +1925,15 @@ static int tegra_xusb_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> +static void tegra_xusb_disable(struct tegra_xusb *tegra)
> +{
> +	tegra_xusb_powergate_partitions(tegra);
> +	tegra_xusb_powerdomain_remove(tegra->dev, tegra);
> +	tegra_xusb_phy_disable(tegra);
> +	tegra_xusb_clk_disable(tegra);
> +	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> +}
> +
>   static int tegra_xusb_remove(struct platform_device *pdev)
>   {
>   	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
> @@ -1947,18 +1956,22 @@ static int tegra_xusb_remove(struct platform_device *pdev)
>   
>   	pm_runtime_put(&pdev->dev);
>   
> -	tegra_xusb_powergate_partitions(tegra);
> -
> -	tegra_xusb_powerdomain_remove(&pdev->dev, tegra);
> -
> -	tegra_xusb_phy_disable(tegra);
> -	tegra_xusb_clk_disable(tegra);
> -	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
> +	tegra_xusb_disable(tegra);
>   	tegra_xusb_padctl_put(tegra->padctl);
>   
>   	return 0;
>   }
>   
> +static void tegra_xusb_shutdown(struct platform_device *pdev)
> +{
> +	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);

Where is this balanced?

	Regards
		Oliver
