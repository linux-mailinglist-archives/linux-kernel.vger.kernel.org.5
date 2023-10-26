Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F587D7FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjJZJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjJZJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:44:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42572191
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn/MHnUzK2Hte0SsGthFFd6SA9P6y5XkXxz3GqheqSRaP2xS1kmzZ4zvHwEsa1K1eMDSQ7ZAoM1XqmkELTZyJrjtvY9Wa6wJhkOo0Cr08gy4H+miwMLglH8Znh4h+aYZTmodrAHcgNe136DgV1JmGlIHcYA19LYggf1JpVkRjTVchJY0/skySQRMDdWb4sFE984ETra8L3uQpGfuYxTQ4q5kaQi3f0X3ZUdpmszPbqIifvt6UJ6ub0FpEtMEnj6qRpdmbayqDGaMEtDbEnMyHE7UPMrazR1vDidyY/+B/YTPpdrVOX3xhI8SufRy0U973DrVYzKIKIieB5HqCE2+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHP1MsGoiOE1Ixy6ZWs2wVTJP12mav0myPnZpN77W+w=;
 b=lts9igrn9beNaSyQ5vF6lzQoFgQ1WC144ClRSr6Yo0AkLVME7NU8LImzcRlMrmRqHvteeExutgAin4jcfJa2FUc47ruE1BiWolGUp7je2m+EYkMddQS50L+p84voCzDemKX6xlStVqo6TVkQk8b7K7nM5MH38Vy6dkPDVSn6jXzU/OT42OyzrUxQ/ea+c5TuSLzwz619TY156r8qCMBZVFhAV4ZoE3b8HMx5Im4jEjRnQk2ipsBLR8ICkGjBPQxA/kIjBrq0+RRy5tAaOesyLEodYu7eIwUBo9feToBtqIrtyKMDffVhLlbU9Yf4FQvsB6JB2PNximhx/N2OHmrzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHP1MsGoiOE1Ixy6ZWs2wVTJP12mav0myPnZpN77W+w=;
 b=2LAx+rOKD8FAkd9vEunTmrbTjptNQVo91Vyn3i44tZy3jbsZPlgwamw7MBSG55B/sOpRhuH23wOBkSp9FbFMLvLnaoSh08MQ5GxrKJgR6WRXy2JmLG++0keYOFWZ/cI1oFSlZg/PMCiCotYJjyJlXr30t57A/pxKIW9Kv3uhdxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 09:44:33 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::7354:d327:ee4:dd79]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::7354:d327:ee4:dd79%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:44:32 +0000
Message-ID: <7a88aa82-f352-443f-a103-b34d5c2b0904@amd.com>
Date:   Thu, 26 Oct 2023 15:14:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ASoC: amd: acp: Add acp6.3 pci legacy driver
 support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, venkataprasad.potturu@amd.com,
        arungopal.kondaveeti@amd.com, mastan.katragadda@amd.com,
        juan.martinez@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <6737a19b-e7fe-4f71-8a78-bb6641ef067a@sirena.org.uk>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <6737a19b-e7fe-4f71-8a78-bb6641ef067a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 082b4fee-5c5c-457d-0f85-08dbd60827f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UppZ6ccluOPAKNwSG3dqbH3nMxdc9E6AGF5Aq4cvW41FKhzDNH4nl9cK2rCP+7soqzooMLPndRxv+H8TVWB+TFWmjrHOj7TnvuH8q5cqe+OYXlR/Hw/xbNMzsKdRccHwBsmXIiau1xYoO7Y4xrjf/IelxSnEo7Dfql93Ywm3m0h5eehrwEU3WlrosreUBNwrslzNA9HTq4foVgvCyrHws8I1ygrjIus9/lwRm57x3cYwr1Ng/8psU8rga2O8HYZhuiFPvEnBMll7IjzW/qWBzkWMbE5anQ0bBJtVQaFQ6WHiXZTyzWHZs55EaTsE9s8IDJo9Ev43mw0SVmx1qZuuKYQHo2nHBiIK6vicyM6ibtkB5okEDVZCWyqtVzevrGhXRKfQLI9YkQt8WixtW2fRpiFgmTNO+AWcLjvoh92gGDyVcQh3BIMMtr5qdzqlbdvXdKwXYFHHfMbGfsarfI4DUatROONIRS9j/aNpUShQ6ZgYTxEO9RkNtzB94e/d5JPLtYHax2EgxTcC3F5+qOGSpyEw3n2Cbv6Yqe1jv9JZikzS4qFDBW0K/un82qxQqFXCp6g/WgFN90UeUe1FG1tc3ktSGdl0vypDau6kes96pLGXwngVlszOX+IH0ViHPYAiaeBRmgutyHiaAKVw+aWsQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(36756003)(26005)(6512007)(6506007)(6636002)(66476007)(66946007)(316002)(110136005)(66556008)(31696002)(38100700002)(54906003)(478600001)(6666004)(53546011)(2616005)(8676002)(2906002)(6486002)(4744005)(8936002)(7416002)(41300700001)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXJOdlZDR096ODA5QWxUQjl6dWRqc1hZN1NVSFRJNXVhcmJEUjB0NldRTVl0?=
 =?utf-8?B?ZzQvbXIrSXRTYUEyZnMwaVJiUGhBN1hjZGNtRnNLUHBJTFRjSUtYd0NHd0Zq?=
 =?utf-8?B?QnFjMmMvdXdnME0vbC9QeGJXS2trcWdGY0xKTENxWXJvaktOUlhkcHRURUky?=
 =?utf-8?B?UzdSK3VSU0Z0SThTRmVzYThCd1JlVTZzc2p5T3NEWm44TENoMHh6c21nUnNY?=
 =?utf-8?B?cDM4eVBSYVQ1T3dPSnEvM01Hc1BRVlVxTjU5RjEyTDIwb0EwTTN5WWM5MWdk?=
 =?utf-8?B?VDNtUTRxZDNYbXB5QWtHRUpsdmR5ZGJNSysrUGJhOXZ6c2F1Y3NPTURZMzJz?=
 =?utf-8?B?cUlxZzJSSlh4Z2tLcTdkU3ZnSEhVZmpZU2gxcHIxdjY5UjZ0UzFHVFFuMEJp?=
 =?utf-8?B?ZzZuQVBjVjJKcHRVenJDSWhqUFBML0NweTdrS0M1Mmk3TWpsM1RZdk5HaGgv?=
 =?utf-8?B?WWF6UWVJUzhOYTZWZTcySWh3Zms3Zjh4Ym9Ga0hrNmdlbExmczBWNzJBL2ZC?=
 =?utf-8?B?YUFLbnlIc0hKQ091SHhET3J4ak80R282UWFydzdtb2JvNTZDYUZYM1pIU3R3?=
 =?utf-8?B?ZW1WRUg1dG1Lc0tldlZZN3ZPdXliM0RKcHhDa3VSRlVBWGc5ZVBtWFhrcWJ6?=
 =?utf-8?B?SUtSd3F2YmpTUHQya21LbFN3aVh4ckNHVEwwOGwvY0dEcXdKQWJGSTQ1NEMx?=
 =?utf-8?B?TXgyUTZOSGsxR0tna3pyYzMxT0JBTG5GNTBtZWh6OWR2NmN1TDhKZGhlVVlH?=
 =?utf-8?B?aW03cnViV1R1ekhZN0FnSFJ6TjQ4bHNnUzhSY001Wm9MVDlyR0VpMGl2Wm5s?=
 =?utf-8?B?bGNXcEVoS3NjYjlDTjgzR0kwMEY0QWdvQlNEOTBWTzduMitHSkF3RXg2STRZ?=
 =?utf-8?B?N1Zva2hkdTl2bGdMR3RhTGNpMUNQK1JrZlhGOE5BK0FGSjBrT1huOExxYUJt?=
 =?utf-8?B?MEpHcVM4S2VoUG9YTEsvT2JCRkRSNzFKSEhzVXAzdGVwUTQrQUhZN0l6Yk4v?=
 =?utf-8?B?YjRJRTNvanZSOS8xWm9QRFg3V2xGOGhXMUlJQUc5ZFZFclVKekU0WHo1cEFG?=
 =?utf-8?B?NFNHYWFUTjRGdHdvU2VCQnFRVHJmdEkyc2pzQ2hMYld0TGJDTmRIekhscy8w?=
 =?utf-8?B?c2pQZmtKL2ZMcHIxNE1NM2I3b3Fvbyt6Nlllc1hKM3pGVmp1dDBPTGRGYlhP?=
 =?utf-8?B?Y0g1MWdUeXNlV0lRWWpDcG84eXFUdXNWLzNPeG9ReTNOZVZyM2FoQ0E0bHFK?=
 =?utf-8?B?QjlOMENDSWVqWjhpWHFMc2NrSkxGUW15UE1JS0wveWtHcFZkTlFiejZhbEcv?=
 =?utf-8?B?Nzg0QkJXTUdvWnFNeTlTODBiVzZTMDdZOEJpQnVWOSs0OUlPaEduUnVveUNt?=
 =?utf-8?B?K1lvUytWSDVEQm9NaGJXeDY2VEQrN212eWVBcnJwRFNGa2w0OGgrYUJ5ZXB0?=
 =?utf-8?B?SWNKam9OMVRrV3ljL0Zoa0xwQTN1NnBsZ2xqN0YxK2dYdzRWSUpWWVVGdllZ?=
 =?utf-8?B?aTcySmI4OE1SdTBKaEYrQUIxaFFBMUs2WWhCRFZvWHZDNld0MURYL1B5UkZQ?=
 =?utf-8?B?ekhTTEZqT05sYVlraHlKdWJTT2VicG85WGdMUHZFL2lxelRWeGxja2dPVFRH?=
 =?utf-8?B?K0JKSU1VaFNVTmZLeGZwSFhGL01laUdGNjBDd0FmR1J5aDBpenE2Y0xKNlZX?=
 =?utf-8?B?Mnk5TXFGUjYrR3Y1SWJYZmVVNTNHbXBDUzU3bjRhUVoyVm1Ha0x0OE1QMkJF?=
 =?utf-8?B?MVJSYmpVL0NMUWRWQTRrZ2NLdmZHYnlteXNWUFFEeG1FelNXdWZPaVJ2WGVS?=
 =?utf-8?B?eFkxRHhSNVVRNDQ0dWJUdWppZWdCekVZNm8wUDUxU3F3NU9oak90OTgzSkN1?=
 =?utf-8?B?UVdMWlV5dHRaak5qa3BEbFpoSnhpMng2dXZYc29uc0FDRUc1endtbUpFdnlo?=
 =?utf-8?B?blZhNGE5WTVVODF2amFFTnhBT3B5WmxGQkt6YlNxc0hGWmhPTGFnSjdpUmNr?=
 =?utf-8?B?cUpwajlvSWpSS3UvUjBRZXcrQUtDWEJMYXdld1RER1JEU0RESnFTMnVqRS8x?=
 =?utf-8?B?cHlJcDE0dUJHTFdDYi9RVTAzQytSZ08zdjY0SXBzNVFGeVMvdDNsRlJMci9m?=
 =?utf-8?Q?ja4Pcn1ZJ6utxsZZM53ujsuvg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082b4fee-5c5c-457d-0f85-08dbd60827f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:44:32.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VryA2CZpir3/fhZbKrEPFC3S2a8ADyIde3kV88R+CdettU2An3m3gpHGCWD4W6rHE/jr+7dyc7kpxVCiW6XRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will send the fixes as incremental patches.

On 10/25/23 22:20, Mark Brown wrote:
> On Sat, Oct 21, 2023 at 08:20:42PM +0530, Syed Saba Kareem wrote:
>> Add pci legacy driver support and create platform driver for
>> acp6.3 based platforms.
> I've queued this series for CI - there were some valid concerns that
> Amadeusz and Krzysztof raised but they're relatively minor, please send
> incremental patches fixing these issues (assuming CI is fine).
