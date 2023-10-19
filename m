Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF07CEED5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJSEws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:52:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD39F;
        Wed, 18 Oct 2023 21:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2e/R6ptx0T7YVNrQI3HJXnJxt4sqDspqrtQnCpe90f+DQ8ingFyFTwdZ2paiSXLX6iBamq4fSnoSxeWcyMBKNHKhxx2zqahNQBKfBSAz4M4w/rDgkw84AWnv2TVG9cm5bmT2IKtdD3ShopgR12oiGkZFZ4T6upaSjycJ5Uf19tg2V5qvveVZjwtcxKsq4dw6ZQo6vtblZyQEWiw2O3nbJCyngd1YOp+aGpOus+CckGu73dWi8HQpy7SdFUOnPOZgeB6Kf+rDiXZJRFD/SVOttmj6FNiYSWJGujqy39ze498eDG696WmUPzMOOP+3mpNBYt3uRQrmkW1l/gl4HEBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHQRqIjNA0AFrcQyiFOb3rL31W3SNE1gKDXudF+4aV0=;
 b=QhqZ86T+nLHzwx3uMTAPYhxIYcgmTRuAASUCJG5eRx8jqCwmfw+SESM1nSXb6s+0aB32IpJ3FCLRDYpoMGzwk8ePX7oopCyUFGrt/StNuSnOLYnXJWGLUk1Ptr0if3EWnbDtpvWRhJxERpDNBAY8I6xP86VlUXGtube7neXkHBlqR5iwAMYvRUtVtds7fKD2XOVZ+S+syYKMfWDg8K9XPaQfLpCQIMFzw3W5z+yXnX79j/OFuqDgjefzVgZnDiu9JLVulvEjlIao6zTW6Rmus7a1hWUZmmxIRLeq/1KyQHuBsqMluzjj+ZHtSeql5WFEy03MOqZwA/53CfvxGTwE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHQRqIjNA0AFrcQyiFOb3rL31W3SNE1gKDXudF+4aV0=;
 b=qdABdHwgqG4zQO/lIn0i4ylXOBdK0BMorcpLXaDCQakgQlgeZ/gxQOznsV1a62vXbmGonDtiuWRF9I+zyT4VgT5kQdJm3It301lRQ/fqZEr6iWNUHxd7MBqtibT2THAOZenqNljKP3vuJPBMmBMp0FVgT1KfuFkRtY6U1M6kHelyBnwk1DfHDSmOEb1SoLB6iskVajeDlbAvplbG4nwMYIK0A153fXe5dsoWfHV1EmZJU7tPoLeoTkK6S3Yb4SIRsAF+aQcUXzEpTUZcIkHupK8vH7T+7MoO/wXgTawkYVQtW0BeR1ZiecN7pTx5SM1nY/nUgD5Sud+wzWRWnQnDrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB6141.apcprd06.prod.outlook.com (2603:1096:400:343::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Thu, 19 Oct
 2023 04:52:38 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::e9c4:dade:c65f:a63c]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::e9c4:dade:c65f:a63c%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 04:52:38 +0000
Message-ID: <86e5cc25-80f7-451b-9067-a220c7a2c39e@vivo.com>
Date:   Thu, 19 Oct 2023 12:50:32 +0800
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
From:   Lu Hongfei <luhongfei@vivo.com>
In-Reply-To: <20230911055810.879-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b57771b-7a1c-472a-a0b1-08dbd05f3814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anTSbKCNa5CUKUsGiZNFwmwqsX8yfGFb0FyKEYTVJeqk8nhRqCHQljsklF64fb/UkFKEu81J/fn81iQNrR85m+crcgTLJxSkhywwsjhtuIydqyXWoG6b6i/YW4ArFusftgZSF/lhYQbc9/qVXdsEdE4IIyAzKW1Tk+MU/wi3PjYYVRwPCJ5hPo+xDffRuDtJDYVjIt7YRsaPD8Ju96/JooO3UZApwtQx/OyHn4Gj2eOYJfBK1X1Wp+G8uyUmA+bT3wAlXZt7iBW3J6YPv2tyz5ca0s5u2uiAdFXlutDZ9Jjg6jW73ndWqDAHoHCtQuRaWcerAry3tT0QERmzSaUV3wui5vVXyHxtpzF2uaIpgbyIIhJdl5JX/Tg9S1SXaeToOuym3mHabLSXyzXjVN3/kYEg/U+g3aodJUfcRb9kksH5JCDS8G6bPMXDfLS0cb8TBDukJbm5LeVkKm+4OTwDayzhjJMDQwqezh9NTGriBI4DELpGVvH4XQYfIjOtTTfKwCmnjPc7qiDEThv5v47l24gxu66VFMyRy+FtBpc8hfK2nE5jTWZ9ZsQ7Z8Bw2WfweCCvj9BWmjUtEul5BDwkQ1fWBAISXNW5CJSIgZNzZnbSVsATPxpNnJJf70t1a+dkJW69zckJDwacEBCVBHEa8h8yDQVmRbb56xjWRA2eqf6P/tuOtCtCytO+ZY5IBpSK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39850400004)(366004)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(7416002)(2906002)(38100700002)(6666004)(110136005)(66556008)(6506007)(66476007)(86362001)(31696002)(921005)(66946007)(53546011)(6486002)(52116002)(316002)(83380400001)(6512007)(478600001)(8676002)(2616005)(107886003)(4326008)(26005)(5660300002)(41300700001)(36756003)(8936002)(38350700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2VzeERKeWU1dGhVczdWZDVDMjZmRVYxRDVlaDhNMXRGSkp5M2ZERTJLNlpL?=
 =?utf-8?B?Y3JWUGZHd0NIN3MrdlozaTNqRytRVXRzVGJ1WW1iYXJXNGE1Sjd2ZEIrbmNR?=
 =?utf-8?B?cGs5Y0hWYndOSVdMdHE5anRoL0s1ZVI0UGd4VmNPVlVIMDgzTEEwZ2tGSjI4?=
 =?utf-8?B?RjEzNkkxS0syUllWK29QN1Z6TGJpTmYyc211MkwxakIxZXMwWWFWZUZCaUpH?=
 =?utf-8?B?WTJTVXNJN0NONUoxUlQ5UHYyQituS20xRHk1c1FOUTc4SzNzNE4wQTBpVkNn?=
 =?utf-8?B?c0dNMGlpZDVVNDRyeUhJMVNuUHlDemtLK3IwVjRweEY0Y1o5dlJaQzFleTQx?=
 =?utf-8?B?MzVqVEZDRkZOQ2tXeHd0VlM2OWJUZDFnVVI0ZGQ1U1FqR2U5VnJsM040eEN4?=
 =?utf-8?B?K25qQXo2b2xxUGxjZlYxZWhuVmxuWlNybjRhU0Jza1AzMkI2dmlNeFBLUUJ6?=
 =?utf-8?B?QzBtakc3aDVTNVNvQ1dZVWNIR21hd0k1MndySDRKRXVQNk42K1Y0WVJicHpE?=
 =?utf-8?B?Rnlab1hMZGJ2OTZjQzJtYUtJQStzdDRtSzMxVVk3VGdiTTNKZnZrYkpnMzN2?=
 =?utf-8?B?dlg5MHF4THlpMGdvR1FzUjVTdW13SFJGRk9pNmlETjdPaHgzQ1VtdE9PczQ2?=
 =?utf-8?B?QzdNa2crWFNwbGMzTGkyQzRkSUk4Q25MK3pEeWFMU0FESllKSnRDQlJla3ZH?=
 =?utf-8?B?MDJQaWJkdk5Pa2VmUElqbGFnZmt6ejhyR0o3Q1FWZEdWZFRuODlyWTZXcThV?=
 =?utf-8?B?TldxTDR3OW5idDZGZUtTL2hmZlNYaS9PQmJjYUZ6b2xGM1E4MkJPSkJ3dnU5?=
 =?utf-8?B?VUFudDRxQVhoRjlPRUI5SEM2cjQ1S3pqSUJwQWdxMzlWMVNHM1FrdHIrd2Zm?=
 =?utf-8?B?UXB3alFaaXNKMlpqYUQxOGxEVXRHUVU3c0s1N29xYTdNdEkzS0s4RGNUdUNi?=
 =?utf-8?B?eFFlWEkzZUhyUEdKS3FObWJDd3AwQ3dpWHA4WjJ6dWV1dFM4R0RmSWRHZ3dX?=
 =?utf-8?B?VXFHdFVXUU9Fb0JEeU4vV1cwL3BUNWhFenFNYlBKdWgvNW1GaExCNmh0dkQw?=
 =?utf-8?B?VHRoQnVydzB0OGhlZUpJeGFKZzdrWmRyZTdhakwzSUNEaU9HdUZDNUtGMXRt?=
 =?utf-8?B?YlVIenVxOExhZHlJL0NUZ04vNFZIY2FLTEJKOWxBZzVBVEN2a3Nqc2laWXJJ?=
 =?utf-8?B?ZlhxbXhjeFoyb1draDFtb0cycnpHUzhRUUdZT3hoUlJwT0wwYk5lTzA5cUox?=
 =?utf-8?B?UnBSK25ubFY5UTRpL2YwN2VjTnUvVGFnMXM4eGtteWd2b3JWbk9UMU15Q1VD?=
 =?utf-8?B?ZVVkUnQwM3hDRncvejc4MVEwT1BVa0NPanowT3Y1bzZtUSsvRE0zSFRnYUxO?=
 =?utf-8?B?eC9FZkhJMHdFdUJwbGdONHZiUXFGMXN5cy9zNWxxM3NTWUJ0WUoxZFU1bTlB?=
 =?utf-8?B?alNEV21RR0tFOTBlczMvQ1BNOGI4TEliWkNpS1VKaWNTMEE1aFJVUmFGeUdH?=
 =?utf-8?B?TG9qeVk2MllaOTJtcXZ5VzU1SDR3enJlRW02Vnkxb0pIdmVBRE1pMHMyMkJM?=
 =?utf-8?B?d3laa25KME9nY2I5VWcydTZ2azUzbmtrU0xRM20zemFFVGh0K3Q3TXBVWWVK?=
 =?utf-8?B?VHZpZzlJSEc2enpLcjcyMm5JOVJkN1FJNEFTV25MTk9mOWVnaDFOV2dBZmpv?=
 =?utf-8?B?THI3UE03MEFYZVl2Ym1vcVI5VVhDb0pBWjlpWTY4a1loek1tcE9maGNSWTNh?=
 =?utf-8?B?a3ZoSTRFckFUMmxZM2djYkFLRTBEdUp1TzRQWnRGSyt4ZlNRVW52SVBSVy9M?=
 =?utf-8?B?OWlEOTA2emZ5MEYzRTVUNldkOVJmMkluOTZ1dzNHS2tSdndRem1obCtlcCtm?=
 =?utf-8?B?dlplZ0lteGZ3VVVnYzJrbjJCaVplK3hIcExYZEljV1VkRGZvZ0ZRZVQ0NXRE?=
 =?utf-8?B?TlVTRFlWM0VxaXFJN3lhY3BQYk1hR0NCYVRFZDJuZTBDc0tBdTQ0ZFU5Q2Q0?=
 =?utf-8?B?Wi8ycWtYWU9CMFNpZGNRUDBHWWpKQklheGh2MFVQQ04vTWZ6N205Q1RrMG5j?=
 =?utf-8?B?V0IxWlpGMzgrVGhlOHNWMEpBb2U2K2U5S0x0TnFDK1J2cVBYUzYvSEtyMEJC?=
 =?utf-8?Q?2xnSDPM60al5+jV6aLmrDClMw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b57771b-7a1c-472a-a0b1-08dbd05f3814
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 04:52:38.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K5D7crgpasa5Qhumat0AlYwpF/YW0Cj4PwpuJWYf1M093oSPwwIPgMV7PhSqpxwZ6aGXIHaPcTM/sda0ZcL6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6141
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Hongfei.

