Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D268F80B88E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjLJDYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:24:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C30102;
        Sat,  9 Dec 2023 19:24:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FN0rjZb92NYEF26V1xRpoDHHtruvk8NJaswBuLq1+ILe7xLl/i5KV+cM/etUbeu+MMh6ugFw/5eTiRw0iW3onYVn/cveQImFQ5kh5Mp7IEnQjWzg3eLU90Yr0kHp+33qZpIOsupROtf89dwVHw/ffAuo5TB1/bzA0+sYtJT9VqCJatWCVRnSDCTa5BzF4fsa4ddxopQiZO04qbNF0YYwGm3grBV5rax2JKYAnQB+wM4vdjgE5tLz4o0Xq1UB2NAn+eL1g81Mv3YK62g/cMmor1Klos+E/SBh68daKe4Z5S1Eb54v0jLyKVNR7eAOdmGHqiBtaq/v4mla6PScdXyZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wIRaukU9cw2SDrld9AqVGNvCxMimopCrbRRyD6vaUI=;
 b=YYnWhQr3ZTmzkOj00A2YCLmLT2WmyRFXj3fe/bU6BvI1geYKZRIPY0TQj8CsKSW0vxGoWMSgbvYXMQZ4rMgW8QGzai+IHKkdZy2OD5ak2Nzd2epMTVMUnr+Nhmc8T6zLSmfAG/thxVPo4vzlArijqaKIwz30R7hpniGyx7skroRTlRZ+sEmgFxcSzUo0a09MZrOoUHz9Ap8J+nPaaI6bTIP7xY4DE3WlhsN4OP4H9sB6NFvYjdVT2lk6Rp0HRDN9io6Ko5L1uDkKDW4kiIdluRCkCVOJ9/jhmHCYqMWfNRKdZQzR1o2xexWjOq9yzFjxHlELNfXX/ahwp3uS7rAQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wIRaukU9cw2SDrld9AqVGNvCxMimopCrbRRyD6vaUI=;
 b=Bp9PXMeK4HBEImazKMY53rtf7wmRuLHDEXvk3DNiTbes8uQxagkoTb/uB8KdYUzkvuhEyhmy7PfpdsCmC0+biZVwKo1924HgGO+saGpGi/qSlGutgd9bbeG0r/KtWFgQNBqA4j5uF+0hl4MUu9Gmo9RO9hzsOnB/TfuWOd4m4IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 03:24:22 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::e007:72f7:4102:9258%4]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 03:24:21 +0000
Message-ID: <8a218987-965b-4228-b1d1-f7c061d553ab@amd.com>
Date:   Sun, 10 Dec 2023 08:54:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] ASoC: amd: acp: Use correct DAI link ID for BT
 codec
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
References: <20231209205351.880797-1-cristian.ciocaltea@collabora.com>
 <20231209205351.880797-11-cristian.ciocaltea@collabora.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <20231209205351.880797-11-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: c2108c11-4acf-4850-997e-08dbf92f7fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL7TBSMyHzx6bKtpyCyZX0gM8ajPcGWSRamYavyJiuLh6LPxRIMSPKw6ts1pLJdIO+nZGXkxTAJ1EfAsGWiNrczOj0ULSHfkNWxPXxyaiRrhIBL3kDtS/Q+yIUMnnghNU23wLJR4ACq/a7K5Mo2d0eJ4IhC37KYXPjf3fL0OIflTeBa+LXWKuPJqPki9STVEXcn2m2Mu+Dmr/s1SpsWLy+q6liYFUg4SMdHCQt+yFZmZsD5u1tGeHB6vxBd2F2ydyWmAopIqeyC53sjup3ky76Nh14EccgJ0V4Qs4EjspfUVgUBg4cKYlRMDOku11lmOPLvdn3545TLN06R8YXoCGMkUocWi0rWKpnhMpaTvqJL3RhncuoQHkN6ByKybL9L44rB4UhRIcUjHSsO/DJbcQEQz2dJngXVkJ6ncUhPrA8MnVtteqV3uQe9cOkuy7+uul7/d9SQ1wRISZHxZoTFBMdHNCUuZG6LL9JttGDKDZTcedxy/nZZjX4AfQ+vlTi6aLsIGh+vWRjQj9cpCGnmn+dy1jmo+2+rgvFXzRc3FczNuZyhXeIksx8rWGAAZdc1Md4Eqsvl3gPFUXd3JSsCX5rmXQR+/VytaIi7oCebMBm7FW6FCrsqAQabrhemQmfNxJaz+2UBHw9Plpxz67iLjWNJQ08wy1q1ubB+Jjh8hGCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(2906002)(41300700001)(38100700002)(110136005)(36756003)(86362001)(31696002)(2616005)(6512007)(26005)(478600001)(6666004)(53546011)(6506007)(6486002)(83380400001)(4326008)(5660300002)(6636002)(316002)(921008)(66556008)(66476007)(66946007)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJuS1NhN2ZoK1VqazNPZFJwVUZyZXB1aFpqb080V1RoaFJRYStjZk9USStN?=
 =?utf-8?B?SFh3cU1lQXBxWmcyOHNvYmVLQ3o1eXJZWGpnQStVR3o1S2JTVkptK0NiaFND?=
 =?utf-8?B?cG1xTGxzL1BFZWRMYUdsejNUNGZsTzZQZW1NN3VoT01ISDdPalBFSjYzYzMr?=
 =?utf-8?B?dDdwejdFMzdyVUVZb2g3Ym42a2ErOG1zeXJlMUd0TWlLRnpXRi96a2FvekRI?=
 =?utf-8?B?cHRHL2xKTWtMRVd4bFVTRHlJcFV5aXNQSkduQVZjSkZSUVVuVzNnb3dNeHZw?=
 =?utf-8?B?OWluRzJGdWtEclM0UDBzSlNzUW1yNXhuS09oNW9XeTNDQTV2OFFoc25RZm1k?=
 =?utf-8?B?a3JlQmlKeXp4bUh3VTNXV1pnMjR1bUpha0hCd2dpY1E2Y1FoYzVYSWpBdU00?=
 =?utf-8?B?OWNMNlRyNHlJZW4zMnQxcUhxN1lrZGovZ1JCWEdnSFF2WG1lVzVoTnlZRzl4?=
 =?utf-8?B?Q2s3YmhlYW5ETEN4WVdXZEh3QW5qcU5UTmxaY0FmS1hMcFZ0RkFtLzYwV3RC?=
 =?utf-8?B?MVRwRXBSNHpIVXhOT0RpMEZZd3RDUXQ2Y3JPTVB4bmo5eFVHWkZYOUVaZVlY?=
 =?utf-8?B?ODBnbG92WW5iazVMYll1WmQ1QVkrV09pOXN3Z3JsVlBuK0hRWkFIeW5pMVdo?=
 =?utf-8?B?RVFkRU1OWDRjYUdsaU5QbHhuT3pKd0syOUpvek9Sc0dFeGNEVGVpTVNYRDdw?=
 =?utf-8?B?bW1rN05FVjdDQjZDRkRNa1JjR0hsUXAwTTFwUjlBZElEYUYzaHB2d3o1a1Zq?=
 =?utf-8?B?YW8xZjg4bmkrY21KeWg4QWs5Q3FEYjdGYjlEUkdFWHlJYytyY21heEtQYVo0?=
 =?utf-8?B?NVR2OElGSXJiRHlMNGhabFBBK211S1c0MFNBSWljVVcyWmtBcHpCOHp4NnVt?=
 =?utf-8?B?S2I1OXM4eGdHZ2wraDhkSkh1U3E0cXV3VzhMb29wbTlUVlA2VmtxL2QydnF5?=
 =?utf-8?B?Y2Zkd0tyZ3IrS2pNUXZ2TzExeWRJMFcrSUdQbkd3KzBmb3VyTTFGRnM3aksy?=
 =?utf-8?B?bGRWNCtjTnVqWXhPRVdRbCtpVFpnaEtnREVOb0xQczUxK3RVcEFRekV5Y0lB?=
 =?utf-8?B?TDZONFhHNFBKQXJxVEMxMXh0aU9HQ2RGZDhyRVNWMitBOWJLMjRyWjhKRVNy?=
 =?utf-8?B?dzdzTllFSkhoK0FIdnIyNlhUYUdiUlB4VGJXaE5CMVVoam9oVUxCSjRDRDlS?=
 =?utf-8?B?d29CZ0FlaGlkZUxSQ0laTVRmRXZsUFJQbWtwVjdLNm52VStKdmk3OVYrL0dR?=
 =?utf-8?B?NEtmNHdBTXZsZU44SjMyWFAwVWsyVjRWakcwVjFQNkEvb2o5RVljRXVJZTRi?=
 =?utf-8?B?TXZnZnBsSTJFYjVjamllNEJRVVlrRTVXSFJ6MXNNMkJkMy9EYlVlS3ByM0lF?=
 =?utf-8?B?OVVNTVpBUUhPeVd5L0pCSlZIZlV6c1NPandmajZldlBMT3pyakh4Zm9kUXF5?=
 =?utf-8?B?dVlraDBwSGJPSjlaeFduejJCSXFWNTA1V2JCMzBmbEJBK1IwUEl2YXpPaUIx?=
 =?utf-8?B?UGcrRkc1TGJXMHZ3UG50a3N3MmNZUFZWcHNNQzMxYlZHUXZsTk1XM21SL1FF?=
 =?utf-8?B?RVdWZFYvUUg2RThieGtqUlRsR1hlSHNrV2tKMllOVTliQlUwVWZIak9od3dj?=
 =?utf-8?B?REluaVQvTVhZL0hzYmE1YmNBMldFcjRqMUxFUXNpTWRnMTJzSC92cTA3YVZR?=
 =?utf-8?B?Ky9Mb2NGYjhBUlJxYk9TQkVuMWNpaHBQNkNWRGZZRmE1Z2Q4Y1dvZmxpUWtI?=
 =?utf-8?B?eEZ3Rlk1WGRMNGUvcHBJL2t2ZkNXc1ZzSm5uZnJpYjg5eW9Hcmc4R0Qrc2VV?=
 =?utf-8?B?VTBFYjdoWUx6Z292TkFZN2hnNmN6UXdVdkdQUzVDaDVlUUtGYzlsRzRzYjZ0?=
 =?utf-8?B?REkvQ3EyeURUam9oVzJrTHdjTS9zdjV0UmdBUS9WRGRUNklsUUF0N0ZYRU8x?=
 =?utf-8?B?SGtDaVBtVXJyNlZiTVl5aVB3WGJQOGtzSXR2cUw0QkYxbHVpeS83MGpUblZa?=
 =?utf-8?B?cEFUaVEzQzBVbFhOZzBydkY2Z0ZpcHZ6WnVWNWkwVC9hQTNwL0xzSWw0UDZr?=
 =?utf-8?B?MXNFS2dvbk8yMDBJenRoZ1ZUYjd4aituTXpqNEFQeEQzdnB3bG5IdHNBbUM4?=
 =?utf-8?Q?In2l6Jflbkw3TAKgQrpu6hopu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2108c11-4acf-4850-997e-08dbf92f7fed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 03:24:21.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgVYxWuMdW3Kp8MmjsgHciikMgk8QlrPUntUvktnKuty+ADQM0UNcRhKc6e7fsqeTHFhBkXJB2mw+HKdDcepkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/23 02:23, Cristian Ciocaltea wrote:
> Commit 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink
> creation for I2S BT instance") added I2S BT support in ACP common
> machine driver, but using a wrong BT_BE_ID, i.e. 3 instead of 2:
>
> [ 7.799659] snd_sof_amd_vangogh 0000:04:00.5: Firmware info: version 0:0:0-7863d
> [ 7.803906] snd_sof_amd_vangogh 0000:04:00.5: Firmware: ABI 3:26:0 Kernel ABI 3:23:0
> [ 7.872873] snd_sof_amd_vangogh 0000:04:00.5: Topology: ABI 3:26:0 Kernel ABI 3:23:0
> [ 8.508218] sof_mach nau8821-max: ASoC: physical link acp-bt-codec (id 2) not exist
> [ 8.513468] sof_mach nau8821-max: ASoC: topology: could not load header: -22
> [ 8.518853] snd_sof_amd_vangogh 0000:04:00.5: error: tplg component load failed -22
> [ 8.524049] snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP topology -22
> [ 8.529230] snd_sof_amd_vangogh 0000:04:00.5: ASoC: error at snd_soc_component_probe on 0000:04:00.5: -22
> [ 8.534465] sof_mach nau8821-max: ASoC: failed to instantiate card -22
> [ 8.539820] sof_mach nau8821-max: error -EINVAL: Failed to register card(sof-nau8821-max)
> [ 8.545022] sof_mach: probe of nau8821-max failed with error -22
>
> Move BT_BE_ID to the correct position in the enum.
>
> Fixes: 671dd2ffbd8b ("ASoC: amd: acp: Add new cpu dai and dailink creation for I2S BT instance")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   sound/soc/amd/acp/acp-mach.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
> index a48546d8d407..0c18ccd29305 100644
> --- a/sound/soc/amd/acp/acp-mach.h
> +++ b/sound/soc/amd/acp/acp-mach.h
> @@ -27,8 +27,8 @@
>   enum be_id {
>   	HEADSET_BE_ID = 0,
>   	AMP_BE_ID,
> -	DMIC_BE_ID,
>   	BT_BE_ID,
> +	DMIC_BE_ID,
This will break the other platforms as this same enum used in topology 
to create dailink.
>   };
>   
>   enum cpu_endpoints {
