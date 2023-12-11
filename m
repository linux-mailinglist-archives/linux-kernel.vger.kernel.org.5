Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D380BEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 03:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjLKCDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjLKCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:03:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC089D9;
        Sun, 10 Dec 2023 18:03:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBb5nYSw97idlgaN8NWshlo6Q6FRSS9R0PraEoPTLS17ie1fqvK+1x0F51QGhoQ9Ogg1GU+DYBrd87EfT2VgUK8XDTaxk2DA3DgDUJ4w+0F9qqkyptGJOkNb6glgdqVwfDGFkKnpJSMZrvZFRuCMql/pMu+9qpq7mvcx2RJ5a2XDEJipww9rF+AwqJHX5c6Y9TKWV7UIKXMdIXjtxSRqFljY8VkXRRnxwIVckge+PWg9JzfpKJMUjlIAQZEFzRmPNcDYL1YPoiJlKwlKwtEvRvFmTUh8CVBDpGk/zJREakq2O7wUBntESmscK9iqOTcM0PH7+wK2hZoiiZws6eozKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqqAjnsnAXi+OH+K+OB1TdsfIzgTXt5PqRB3fAqshWI=;
 b=Pk45j0Mlj7cgg0zGmiTgiIhKiZd4g6cywMx4qSKjOST2F3ofGQ5v20+NDwAtvnUDJObOTrmYs9NBolvslP7TNA6QlQfAQcrgUyoKxrbUmaj38iM+gbYR8Pkhpm1g2mL5h+fxcQDT2mAbZ29t1KSxlyhESDj67Q5iVX8RRG+QkQYtn1FvKtoUy2lbEZtld64msJNPGj6zi347LZXJJO3PRRu4DU4zQ64FD8v+jvfpAUDm1eRFBwuulcxUUery9Mq9ovwlBIENTUaqqtaJDASIz+vtmiOUHjpoShM+OlgCI4Ip0/MCOZ2GlaLAQuhcbdXx1LQV6C1TKZExbJVO5/Zd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqqAjnsnAXi+OH+K+OB1TdsfIzgTXt5PqRB3fAqshWI=;
 b=3hgWkpjTxxvYXhnM4frTO2WflSEyfEAu2G2aVyXGPu8mPwLseT8wTNsa5kazoMEnW4Z62ikLuTM+VIyrGkYgm5Zo3gPo07ZeE5SKKgElQPZeKYtsK5QUXVoyDls9oQtrwe6i1yzvsY9OF0/bOqUf+4UUwA6M7Lkmin+jE9y99HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:03:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 02:03:25 +0000
Message-ID: <05b90060-9bee-42db-a49b-eb73dce0d59c@amd.com>
Date:   Sun, 10 Dec 2023 20:03:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Enable built-in microphone on Lenovo ThinkPad P14s
 Gen 4 (AMD)
To:     "Michael T. Kloos" <michael@michaelkloos.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jeremy Soller <jeremy@system76.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        August Wikerfors <git@augustwikerfors.se>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231211015325.6793-1-michael@michaelkloos.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231211015325.6793-1-michael@michaelkloos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:806:120::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f704ea-f246-4595-6edc-08dbf9ed5c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8u4rlGck35ia3Etk+vt/Hii4GAfY0A/TH6ZoI2traCNCMLVkZL8cv36VkwTYNYw+0USt4TuH49DijOeMXCKFAapy6YP/9wP1hXgXzSn8Mgnksx5lpHnVvqSqjZ/z3zaK8QePZFQAlH64gT5qJzVpI5CB3XgrgEy6lmBl1Gts6omWs6K0GY2MLtdx1GmpoCDLWgegcfkah/gY2KAS3k0BYNwm+oquzD0Auti8MZNzFps1CvArQnRUYaY1zmG0vMtdjK/ON8i+XdcXgCftPNH0ZLJgl9c6PJY5P2McXW2Ez5/HLR4m9AlDHObgCbABsKiKLlKdNz2VarBPellIRJHBX6BtOPOf/jukCSoPrPiyJgtCY19PC+Z2JhSA4vVAl/5SXEYhbbXlVrqwTJpJck0wqe2O8Ib1UnO0oMMqxeBJS65k5olVjmtTGhPPb5zrqWVObyyJirX1rzJsYmQHroTdR3qbUlqOG/rrss3ECnMswuZlZLLAaiLE+4YLliGARRpnrhy3sghyGk8JnQjViQcnfkqaEmPnknCRFQQthiirYA8igT8W1bNvVBuPxEr2+VFvhhxxDxw+qoLNQdqui4KwcFzEB3WwlvAbI4VCDsqXTjuYZaE+8zE1EB30RM0eCJB6LzXpp8uRM/KF4YNpHyFCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(478600001)(41300700001)(31686004)(66556008)(66476007)(6636002)(66946007)(6486002)(110136005)(316002)(38100700002)(6666004)(86362001)(31696002)(4326008)(8936002)(8676002)(53546011)(6506007)(6512007)(44832011)(36756003)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUxvMnhxUE4yZnRTVkQ0QmNCZjJKazR5Zi9DaXdpQjg5UmQrY2Q1a0taSmM3?=
 =?utf-8?B?M1FUTVl3V2xqaVlDT2RUajRPTmtZY0sxR0hxWnZhcmRYVzI3cS9KcWFGWkdK?=
 =?utf-8?B?L0Q1S0lYdFNFZllVazl4NzEwRVlReUdsc2FrYjFEb0xlVDBta2ZET0Q1UzQx?=
 =?utf-8?B?L0FiNUZjQUd2Ry8reVI5SFZLcml5cHdMSk9nV3E3dTljdGFKWENIbVgydmdz?=
 =?utf-8?B?bUJDNkJ5amI5MGJNaWdMYXE4WjQ2RmRLWmt1UEVnaWh6d1VBeWJ0Z0VNbnFi?=
 =?utf-8?B?aDZFWE5Fc3NMRmNHZXJ1RTV2dUFPcXdCZG9JYWtndmR0eEFUTHU0T3JBcVMr?=
 =?utf-8?B?K09LL2E4bitEN3pNT0wxQzBibFVESVVqUUNWV0xvMkE3QjV3aUptc1N0TDQ4?=
 =?utf-8?B?QkV3V3VTbWc4VGU4SU56TnliOU9VWU1HeURMU1NKKzBLNFVXT3AyTWZnNkxq?=
 =?utf-8?B?ODZDMG9RcWNIRDdVM0R3dVE3YThJSzBxTkdzS2lJck9HWkM2bHRaWXY5NG5K?=
 =?utf-8?B?U2tSVVJhbGY0S2JoNi9XQ01PQWN2MlZ4MkJsektVU2RMd0dYVzJJQmhMVDlF?=
 =?utf-8?B?cy9wOGJ0UitiODBpWng3bWpVQmhNZlUyVFk1RkVhWFRQaFJUWXRiclI4U3pR?=
 =?utf-8?B?bERVTVVzWEs4dVYwSUlHRnIvYkNFbUphQysyL3ZWendtd0srVHY0TUlDN1cy?=
 =?utf-8?B?ZDBQdGVOR1lsMEV1UHhlQ2VEd1ljdXN5eCtBOW5PQUdHcEUreDlwK2pOc2I1?=
 =?utf-8?B?bmV3MXZMay9DbTR6STV0NWJac1VubC9xSllaS2xPM0JvellqSWMrSitVLzQ1?=
 =?utf-8?B?SUlpckhuVEU2Mlh2c1Nhb1AxbG5GbiszQkw0alpjbGdVNkdnaC9SVllIWWhp?=
 =?utf-8?B?dGF0d2kyYUlTNWFKQ2ZHODZmRGtxakJBYVlncGpxVURJdEpRUllaSXgwMnp3?=
 =?utf-8?B?VzBkbmo4TzRGZXo0TVJMMEhoT1ZZT01UT0ZaK0M5YlNkK21kbXJmSkV6eWNZ?=
 =?utf-8?B?VENxTWFPbDI2Zk5JbDhrYlhaOGs3dUVIVktxd1hzWXJ3YXpZenlWQ3o2STZT?=
 =?utf-8?B?d1dMTVUzM3plMURiTUJ3UlNjVEpxN0lWR3FOdGhaNkVZU0VTN0dCNFdkckxL?=
 =?utf-8?B?RisvTTNGUXExL05ncXUxL2MxUlYrTmQwYnJZZFNRSi9hVUFZaENuQTIwcDc4?=
 =?utf-8?B?RzJFYWxTNFVyLytIaTdGdTloUlo1S2tlNHBLRzVISDQ2Zlp2dmlUZ25NaWRn?=
 =?utf-8?B?dXlWNjgySTlvME1HRzhXb1ROZWNpVTFRdmZmZUxtbERad1QzR0Y5RFk5UHdB?=
 =?utf-8?B?d1hNUFdCcTZia0RpVjdIQUZFWTI5amdHSW81VVNMM2k3ODB5c3FqemxPZ2ZQ?=
 =?utf-8?B?eW5LNG4rQ0xUeEsvV0Zrby8xN2Vta0RYbXVtcjhHNXlGeTd3QWtUQnBqSXN2?=
 =?utf-8?B?ckNOTlpuM1ZyM2FJSjQyT25EY2g4bUU1YW5FMGVHVUYwN0RFR2lqZGdGL08r?=
 =?utf-8?B?Q1VjS21aT2ZUZms3RlhjQ0YxV0Ixa1U4NGZBWnhGOWpOM3Bia1cxcG10RlN4?=
 =?utf-8?B?OVJ0cUJQdlZUZnl4MVFjdmdqUVhTVlNMMmlweW1NbWJzS0RHVExTZTVwRXpn?=
 =?utf-8?B?YkZnNkc1Nm9NdFR2Yi9yVGd3M1QxMGhXQU1pUmVWOXJhWjlqRFRhb2V6R3Zv?=
 =?utf-8?B?TFVZU1ZTMHp4eG8zdUtrbVRYbTR5Y0s2cUIwSGtSUWdnUWVQYTZDa3JrNHFC?=
 =?utf-8?B?TWdDQzRRQ3oyRmV5NnY1S0VjdjJQWklTS1dnNTZYVnpFZGUrRXAza25FYW5O?=
 =?utf-8?B?ZHZRQlVwNmhseE5ndHRYWVlRRnJaWjZhb3ViMllDa2xjbjdCUVA1SlhWYnZt?=
 =?utf-8?B?QlQ1NWZ0dGJaN0h6YzRlRU1rWVFMaHlHZm92Vjh5ZHdCZ05UT2dRTVhlK2Zw?=
 =?utf-8?B?TkI1ZjJCYWlaM0Y4L2doVnd4L1gxTzVkdml2N1FKanc3RFpNdzFmc1V5a0RK?=
 =?utf-8?B?eFd1dEhmdGt1eGN2TWZBVHdNazcvUzJFMUJXbHM2bDQxUGd1RlNGSzI1NlRW?=
 =?utf-8?B?bVV6NElFbFhSeHNHcE9nQVFuU3dlT2liSmxSVldPaTZlSlRjL0RCK21IRVBV?=
 =?utf-8?Q?chGgjWaKimtRGsrKJfg9+iOln?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f704ea-f246-4595-6edc-08dbf9ed5c12
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:03:25.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEw5EkMfAYy1OS1UhgsmjGBuLal6OEI/UBjivgDLt09/xNHgjTHF7r+IqP4VC9PhO0zkmeEDR64KmbsA9DSMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 19:52, Michael T. Kloos wrote:
> Added System Board to Quirks List using model number prefix.
> Replaced/Removed a duplicate entry in the list.
> Added Yellow Carp Coprocessor Revision number to PCI revision check.
> 
> Signed-off-by: Michael T. Kloos <michael@michaelkloos.com>

NAK.

This is supposed to be supported by ACP 6.3 (Pink Sardine).  Did you 
enable that driver?

Can you please share more about your problem?

> ---
>   sound/soc/amd/yc/acp6x-mach.c | 2 +-
>   sound/soc/amd/yc/pci-acp6x.c  | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index d83cb6e4c62a..c08605d99bc9 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -56,7 +56,7 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>   		.driver_data = &acp6x_card,
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "21D0"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K5"),
>   		}
>   	},
>   	{
> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
> index 7af6a349b1d4..694b8e313902 100644
> --- a/sound/soc/amd/yc/pci-acp6x.c
> +++ b/sound/soc/amd/yc/pci-acp6x.c
> @@ -162,6 +162,7 @@ static int snd_acp6x_probe(struct pci_dev *pci,
>   	/* Yellow Carp device check */
>   	switch (pci->revision) {
>   	case 0x60:
> +	case 0x63:
>   	case 0x6f:
>   		break;
>   	default:

