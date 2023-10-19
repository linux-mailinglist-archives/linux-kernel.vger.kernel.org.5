Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1AA7CEE82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJSDxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSDxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:53:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0546B118;
        Wed, 18 Oct 2023 20:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs9N5EhttSC2FgTWxGr8kvtg+GjsatpUp2VozEkvyS+cO8eDFfLlcU0SIPlkna8C1islSDSAMh8nSji0RSeMuFATmIn9NtSQFcfCk7M82XzXODdO7rPsicXI0WomoINv2t2CZHGpY20qasc/0yKrRGrxFsu/NYvpN6pRycqhnzJaOdYDqK9yhESMdP8S3xmmAwXiDVztRxKOtFnsdIWkWtbdzUZVJxQLG4Hjl72q76zF+iDvXTMhFciFC8ofdz+4BhVAfSMGduuah3PJ04QpYdBWU2j9YNL8kZWc9IkPXJzuappKwDKUIV1mRncCJs0C724jCnwr/MgjnBVNjO10mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jLO54BQpKH4RZATbh0sVnF5E5i2lP/lwfyUwhNCUCc=;
 b=n0tFOlGmPKEN4ptaUhp6VdclTjPmtGitXU5q2Ovtzk/OC2+lQ2zEyUesY3GZMGdJg16+s0n9xCQOKLROprcrymdrGyliJi8YGlSUD0pssdbMvdwR2aRKgLKi2eSpOZVzdNEkkQksIMDMutmiGNVslzGXkKuPSccHG+nWcNwhZVsAW5gY6zMl1Pi1cozEm3xKdoN19rJ63KFVsEzXCa2L36I2w259pVsXz7xcpc4uuF1mFTQ7RHWs/GNtRR7P7HPULN5A7ZxdE0bX9TU4ARlUKrsmufF2s6g0LOYnH7bKQ5rMoMgIhsYzD+zAeBdPHpy30SBhLqu5QSTYnM7eONmoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jLO54BQpKH4RZATbh0sVnF5E5i2lP/lwfyUwhNCUCc=;
 b=kOxSWtZJpmEYHq1rwjxFp2ZvCep8g9BcJ7XJpUkdUhd4JC/ql4X0CwIUtrB287nesQSdUKmbrFj3D9u61LVOwm9wkSvp/7OzRvtX8p8DQNP7UHqg/dneQEJ2BFOlh5b6HP3UeC1vJemn/UWP+MiYF1UujIA+cIQLbmTHa4JDtjOOwL/gVR+nIwqBejQUub4ruWycOyyzGVeQIY5tlf/my4enFsjoAm9O4Nya8gPDQMKFUHOgJtcgRmZaZcCZbL6ZWoMWqYPUL9iqtcuvqFzpV9g+w1nkqVyrg51E+1PZpkH/YBCOJ2O2R78tXH5UVCpTe3kH78mhlFo4nhO7yMGqaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEZPR06MB5990.apcprd06.prod.outlook.com (2603:1096:101:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 03:53:27 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::e9c4:dade:c65f:a63c]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::e9c4:dade:c65f:a63c%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 03:53:26 +0000
Message-ID: <56583454-17e7-4a30-9972-9d980148ed9d@vivo.com>
Date:   Thu, 19 Oct 2023 11:53:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] scsi: ufs: core: support WB buffer resize function
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <quic_cang@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230911055810.879-1-luhongfei@vivo.com>
From:   =?UTF-8?B?6Lev57qi6aOe?= <luhongfei@vivo.com>
In-Reply-To: <20230911055810.879-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0117.apcprd02.prod.outlook.com
 (2603:1096:4:92::33) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEZPR06MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da08842-a584-4151-c8fa-08dbd056f2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xg/GXkAcVvgrsO0mSWdaqwlZT9YvdWEz3fjOy1e3GZYLxtiR+z8fNK3tecLcHPscTO6e1c/7khT6i0/4WS6LXqWXObxwZ0xgg/eYGdKLJSkB960aN2vxgSA8BRDj9vbTORTavInRdVldrengX8fSraxKn+olN6V3kJqEFvTNHJh6V65baPb/C+ZihSibx1o8vTXsRj0xpctNzFJ7Zm+juXdFCzoJnoCKF4MRyHdXiEUzKqr28Owq2JZ5ZcBknKUlOBYvxQjkJT0YBKe9qwKy3zzWr7VEsK3rSkwrV8oS68CQr3wpcEDM5FvkZtY6jd/nWPHhR5CCMt4eGs0NSXnpFtcSBpt/+5UpiG6iuZFtoDaHRZzVq/szImkOxSaS+UqopnhtXrJ1jdMYInYrYFRuYVvBDORaZDRM/zR8aNJAjqSRshLCxh8OjYcjTHHUKvWeM6kt85aqnN+edL4KesZbGknJvlVctP8UIRP5RlvkZFEiFPwsYcdcvYO6/MgjXzgOryhqSB0dudCdR0AcJe9IsQYEKsrc/lB+ZmN96m8YLgz3Aue1ZkpUSSy26w3U7ll4/MQoxYE3TdnHXYv7rz6feS58XuHJKdXVdPawD9lDjFiKD64iaNK5ans79jvnu5/xprXLFK322ebGgSwpclnZdQjIJWjGstBc405uL7AdiZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(53546011)(26005)(6486002)(478600001)(6512007)(6506007)(921005)(316002)(110136005)(31686004)(2616005)(6666004)(66476007)(66946007)(107886003)(66556008)(83380400001)(8676002)(5660300002)(8936002)(7416002)(41300700001)(31696002)(2906002)(36756003)(4326008)(85182001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amgyMnZUdGdYYnFMRFdHb3kzSHoxQUpXcFRhTnltNHJTSmRVR0k2K2xaVkJD?=
 =?utf-8?B?ZUk2NlNYRmptZGNEeHN6cmpXKytCZCtPYmlxMXIyb01oZG8wNEJCMlJnQlhQ?=
 =?utf-8?B?TGt3ZUZQMjRIK0VlVXJ2Rm1uQUZtMjZZSExJY2k3cVpHd0phbUpIZ3drbkZB?=
 =?utf-8?B?dFloN3pFNGwyL3NMeGFqQ05IREtqdVgzZVkvVEtTbk9lUS9rV2pubFVIcEpM?=
 =?utf-8?B?VEpsRUIvNUNncUZFNVN4dHlTaHNUdTlqT2xzclpMck5SY3Rlc2xlZ09vWk44?=
 =?utf-8?B?RXVwelJrWVgzcWNUeVd1Q2pLclJDaXU5ZHF2dGFwR0pQNzFlYzQzZjgyaklN?=
 =?utf-8?B?RE5rcXhkYmxFTmxNRjBLVlFJdVRtRTVUT3RNTzZqVlIxTmZmdlRWZUtieDRk?=
 =?utf-8?B?cW5DQ2Y3VHBBREh6VXVZemY1UStNSEcvVVZLbXV6bG5wRFFuNFJuWlplZi9T?=
 =?utf-8?B?Y0JRRExFYWVqNmJqOUtGak9BN0RIVVcxRzU1eGg4YkpnQ2FzUkxVL0ZmWWZI?=
 =?utf-8?B?ZjhDTjZYV1haQys0NjlrWlJNaDBMNWpMUWs2dngwUUJjbWsvWXVNcklvMFlt?=
 =?utf-8?B?YTJSdyttZDQ0aC9VYktPbWNCSXpkaU9pN09IMUIvY21VbUUwU3NCY1ZwTUpR?=
 =?utf-8?B?bVJZTkxjaHpDWE0yUkFpZnA5ckRYSVpXTHlKMk9RaW9kWGdLRlpqYkh4Vnpm?=
 =?utf-8?B?cnN5aGtsWndXY3BEZktSRW5RMi9yaThkSURQdnJVZ1o2dUNxOWFkQ2dGT0ll?=
 =?utf-8?B?cDZteSt6ZzJ6YzhEeTVuL0w2MjUzKzBITzgwWHpIOXZlRVV1WGVzRGFaV1ky?=
 =?utf-8?B?dXpvQ1podGJFWTdqNmxYaTQ3ZnE0alNkTzk1VDNWWm5zb1hkbTRBRkUxaVN2?=
 =?utf-8?B?K0thcVYveWxUNE91UXRRR2lqanVqaFJXSEFDUVhpakpRTXl5MXBKSWpFNHNn?=
 =?utf-8?B?RjczOFVUbktIOG5tZUdtSXlQWnFJSzN2M3dOVzc0SUZpRDYrYk9xRkZmVFZs?=
 =?utf-8?B?Tk1NdUh5M1Jvb3JnREpzT1dpZEU3SXRYVjI2YXZFYXk1QVZ0ZjVWa3RsejRD?=
 =?utf-8?B?U3J1dVk3N05ITHlzeFN3SjB3RDhsRzJQQlc4VURjQ3FwTHlYcEQxUDdoMXNT?=
 =?utf-8?B?WittU3lhekNDQVl5b3lOVmkza1VVSGE0bVJrVWdmRG1wbHNJUlpEOW9jbHdY?=
 =?utf-8?B?Z2Q3eFVHa1FtQlNXVUNYQWRlallOc1dDYWVSN1FSZkFnUXhaYnVYRlltMTU0?=
 =?utf-8?B?dXd2L3lXWG93dXdWRVZGRWZ0UkMxcU50aGpWei9VVnFSTU5Lbmx0czNIUnh2?=
 =?utf-8?B?WVptMkVhd3Y5K1N1eFR1YzlzeE55TThyR1gyNDdFYXFidk1qYkp3bEY0VFNK?=
 =?utf-8?B?WkQ4Q2RYWGpPMCtrVnBtYUM1aGM4dEtsQWRUZWdqV0llVit5dTEyMmNEWTJ3?=
 =?utf-8?B?WjBaUWdqYXNEcGQweFY3TjV3c05NWUtxU1VwN2xkRWY3YlVYbFBrYkJnc0Fh?=
 =?utf-8?B?SDFmWi82bHVpS0ljYTcveTUzekJMbmYyQnAzanNvOVZaempPcmQ1QU5meXlS?=
 =?utf-8?B?NjBISFh4cFZFS3p2d1prWElENUFCeGhZTTl6RjNVUXJqSDJFQWFDL09wamx2?=
 =?utf-8?B?cjVvS1hWOEpxdFh2UC9RU2NCM1FjeVRHdi9tS3Vtc3V4WGQ4YmVrdG5HMUMv?=
 =?utf-8?B?bTFPMjV5aFlxb1JmTlJMTUtSK1RVb1FQTndWUDFhZG52dFhudkJIUUxjQW40?=
 =?utf-8?B?S3NtRVpraHVtRkVabDNkeW1ud1JmMmlBTHcvN2JRNzVrS0U1ZU9pL0l0bThz?=
 =?utf-8?B?YVdRK0Q0TnNwc3FXU0M4L3pISjJxd2g3T2hKTm43bytLRHhQeHFkL3RUZDFL?=
 =?utf-8?B?U2RqYVphbHNwQkZCVlB2L0NiMGhpaDNkeFZZcGZuVVZJNnM5Z1ZCZlVqZW02?=
 =?utf-8?B?VjVxRTVURXZka0hnQ1M3SUF4cU1VREZ1LzhTZ2tWTGJMbmE3Nm03Q091Szlx?=
 =?utf-8?B?MHEvVGZWT1VqUVNzaExFVzJCd2VFNWdoYmZoVXZORE9GcXhHUm1hSGtmbXlF?=
 =?utf-8?B?RndQRk1aQkR5a0lMc0FDZUJWaU8yOVNESWtrT3d0b0luQko5U0ZweW5mS3NK?=
 =?utf-8?Q?AaKVgNKTuFaJ33Rb9z5Th4+5D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da08842-a584-4151-c8fa-08dbd056f2d2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 03:53:26.4657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbAE4MZkADZSJoC2ge0gG99CzFUi8pmx0o0aXVmiYG/NWLxL1432R1ec1VJ1oIq29WbNISWn45p3jlnU4ZojFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5990
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/9/11 13:57, Lu Hongfei wrote:
> Hello,
>
> In August 2023, the ballot for resizing the WriteBooster buffer has been
> approved.
>
> This v3 series implements the function of controlling the WriteBooster
> buffer resize via sysfs that will be supported in UFS.
>
> version 2 changes
> -Using sysfs to control WB buffer resize instead of exception event handler
> -Removed content related to exception event
> -Solved several issues that caused compilation errors
>
> version 3 changes
> -Removed UFS version number check
> -Optimized several function names to make their definitions clear and easy
> to understand
> -Fixed several formatting issues to avoid reporting warning information
> during compilation
> -Removed the ufshcd_scsi_block_requests(), ufshcd_wait_for_doorbell_clr()
> and ufshcd_scsi_unblock_requests() calls in ufshcd_configure_wb_buf_resize.
>
> ------------------------------------------------------------------------
> Lu Hongfei (3):
>    scsi: ufs: core: add wb buffer resize related attr_idn
>    scsi: ufs: core: Add sysfs attribute to control WB buffer resize
>      function
>    scsi: ufs: core: Add sysfs attributes to get the hint information and
>      status of WB buffer resize
>
>   Documentation/ABI/testing/sysfs-driver-ufs | 52 ++++++++++++++++
>   drivers/ufs/core/ufs-sysfs.c               | 70 ++++++++++++++++++++++
>   drivers/ufs/core/ufshcd.c                  | 15 +++++
>   include/ufs/ufs.h                          |  5 +-
>   include/ufs/ufshcd.h                       |  1 +
>   5 files changed, 142 insertions(+), 1 deletion(-)

Hi Bart,

         Are there any new developments in this group of patches?

Thanks,

Hongfei

