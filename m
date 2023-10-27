Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C077E7D8EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbjJ0GwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 02:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Gv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 02:51:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2125.outbound.protection.outlook.com [40.107.7.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA911A1;
        Thu, 26 Oct 2023 23:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+MKFdhOT/Tk/BE3B+ErTYGY8dcKgGYw6Ex8xFZCuM1yWV75vb0euP3HRGqt0Od59y0KwvwdJdGY2KuRcQg/m9dgrGGtCvxzbgmAPmtE6XTHaiFX9D5yn39f+FpuCPvy8tmMuBuBJCMmRGc6kAMwfdpTQNcIWMzgEy7vfgiuYudwVF7fIGz903sQu63TVUXDu/lcpGqLk/8fUVsIG1Ln8lshV9/MVPKNpXSos/PWZ2JThlFdVQF6BZ8F+1mZPfYj3/Cdk8brT5BiWySdYHtRrTx2jlbU/LxitB9qrsru6/qbJ5NbTvu5xA3i7WkGr+euGBJhdfBTQ+6IjnRrPRqsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2MRnDrbb5KyElhHtjuWNn8Louiip72gKgPmSRe2XbQ=;
 b=gU67u/0BVKyF0c0h8LWn/IA2enlxXQoLIzroDLnCOr2eADi4Qq2fqKr9ku2P505xIDeQnOvjGkiCkrXAxNQQZh03VNRCOu6aS3ZvDCJp9OZwSr6sl3CGQoIubJYVwwssm1pHwYld6zyufZ7gieucoURFMEW28NUrcojpfwUtb3nLIT3qyQyPwrvK4Q0BT5gM/gKZkfWDkSDbVLnOXcLO+Ra8ZDBK48hAFXqosJzek4N/gLViCbAKZmn/0ijRQiEOcvMLgFwOoCtN4HMNZCcmeXQ2lF9zMAtLF/b0BgvKSzMYW45E7ChbeP56PPVW/85O5DxRg+TjNMwJMiCEpeqgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2MRnDrbb5KyElhHtjuWNn8Louiip72gKgPmSRe2XbQ=;
 b=Nxgxyw8hjf2hj3NzAsvAqyDipssPhgQb2h8gF3D0Cly3SBIVgopzAhdeHMKjyTXs+a2Epu9zRlVTF6+/zGyuMGfj32tZ36wPRm0we8NT2WUfgo6G3zPt6o1fJPBtuPNZLyRw3HUpISAMN+88Rf2w+PIMM6bxjjfoP7CoUHCgrE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA4PR10MB5513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 06:51:54 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 06:51:53 +0000
Message-ID: <abf335aa-1366-4c66-80f1-86e273143702@kontron.de>
Date:   Fri, 27 Oct 2023 08:51:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spi: spi-fsl-qspi: Add support for rx data sample
 point adjustment
To:     kernel test robot <lkp@intel.com>, Eberhard Stoll <estl@gmx.net>,
        Han Xu <han.xu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Eberhard Stoll <eberhard.stoll@kontron.de>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Michal Simek <monstr@monstr.eu>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20231026152316.2729575-5-estl@gmx.net>
 <202310270332.mcbckKCr-lkp@intel.com>
Content-Language: en-US, de-DE
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <202310270332.mcbckKCr-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA4PR10MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e8c010-b281-49f6-a471-08dbd6b93438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uK3TAe0YUJpkGvHufF6TO6BqQns6UsYdT574+u8LFlm9Pro83CWZcKLAuG2Vec8bZseIzKnlMHyTjlFXGUso9e8hn2HC9xwc92BqaU1RW5+yp/IiGVED0Xpt88zubXHw/gMu88YjDv1pE3y9AAq5IOtYvrPncjEZDfuwqkRauHOlD4/v3ZbWBIAQSJqcp2nrGSCWSnWLx1u2F0X1UlnDEMBeQ7YZL9OSbzQTrr24EdMyaRNAqhLBi2s/UfG7gD9zKNU2y+ECIRhNks8I6DW8bBYA9rcCj5o+uVOB18M0Ms+E+zF1wFb1ml3MWNnOvKzxH6LicD5fPBQTPZ8eW4f9qTlq29mklSg5NDuu1tTZLjVjTGUJEgqn+rhwMmF3zURAMNY4tWFaXmn/DT5fF4KuWcIIJ4tMELV2gDdtywz1K5wqHJL4YPeZpvBq9aEgjiR32MX3XGBeThyHcLSzCemyTqDUQWFRGlM3NqSJkB5Y1z7kDFq6swjcI2MWUpL0uTJ/XesCXW1HSYF3Ijke/9b+7W77G/D99bl37sCRBYPcH14qpbns7eMDeajV+ayki2K6Anq1KaPD6dChmuBF4cVIZ9m2RGnHHw1w/b3tf7G+ESkRou02WczulhIQmVZ9b8gCqZ0Epuj8l2WlWy+jXtnbEjLS9jpxAZcedpkOw67AYZP8RhGJDUAIsyL5Y6RupXot
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(53546011)(45080400002)(6666004)(6506007)(38100700002)(31696002)(86362001)(36756003)(83380400001)(2616005)(6512007)(26005)(7416002)(316002)(66946007)(54906003)(66556008)(66476007)(44832011)(41300700001)(31686004)(5660300002)(6486002)(110136005)(2906002)(966005)(478600001)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZQRUJuZnZRc1JhVUlLL2Rqdms4SUlQOFh1UTBKcVRYTGFMaU5TQ0svMmRT?=
 =?utf-8?B?K2NaV09tQ2laYnBIV1VZK0ViYUVhV2FiWGVzT3RzdU96U0lhV0RYNGVVRWZy?=
 =?utf-8?B?d3ZJQ01YbTM3ZDhhK0p3azVvcnI5SU8zOE1IRjZiOHdyRlRBelJOWVJ1bGQ5?=
 =?utf-8?B?WkJsMjJVMWIzVEE2aytEQjlITEI4QjlHZVJNM2tLL2lOTDM3dUVyeGNvL3Fa?=
 =?utf-8?B?WXUvNlBmZFkxaHdOc0tYVUR4SVFzbW85V1pLQWd0TklRQVZNa3JSNC92aWQ1?=
 =?utf-8?B?SFc4bHhBNlByV1hJeHRla1k1OWlLNnlqRmd2YVRuUHBUWVFIZ3ptOEZKQklu?=
 =?utf-8?B?S1gwZ04vUzdxVzZyaHJwZkYzTEhlanFRTW5nSXdKdEFWb2lsYkhmQ3RoWmtv?=
 =?utf-8?B?Qmg2eEhlWUFMQndqTVQyTURzYXJQWC94NHdiVGZoOWFOTVN2bDVVcDUrMTVm?=
 =?utf-8?B?RlI4eFdDcUlMdjlZbkdQbzdTYW9udjZOcmQ4U3VVTmRxUEEyVmhIODMyZXBL?=
 =?utf-8?B?c2cwcENNQm90N08xTTYyaG8zaXA0SU5ETnN2ek5PR1Z3NUZrUnQ4ZWVaYThJ?=
 =?utf-8?B?OVRSL3ZKcGJVV3hYMEwxNlVGcVVEN2ZYSHFPUFh5TEtIVDFqVFZSWmp0UG96?=
 =?utf-8?B?c1NGME81U3RlUThBWU1UUWhXWlBlN2VQZUNaZlNZSmZSeHlWVWNjWmxkK1ZF?=
 =?utf-8?B?Wk1zTGlGVkVYMkZwd1dVVEM1b0xFMEhVYW1oekxnajV5alAyQUs4ckRnalhk?=
 =?utf-8?B?bDQ1dk9uV1BHTUhXZHRPN09JdlhaREtJODMxaTdZdld2UWNLKy9yc1VVVFoz?=
 =?utf-8?B?U2ZxVFYyamdyUTlBc0V4NlRldnZzWkJEY04zc2tDOXFpdGNMQmRoYnBWSFQ3?=
 =?utf-8?B?U1cwalUrbGVia1NLQ3JBN0hISjh3b1BGazVVaWF5V0tkT3pjV0NzY3N3WmZS?=
 =?utf-8?B?M3llaXA3M0Y3ZUFMQkZvVGtzN1VONURGS3B4UU9WcWc0ZDErVEw5RFc2UC9O?=
 =?utf-8?B?OXlCbHhwdFJ5ZytlRlR5Vkxxc2NRakcwVXlmWTg4MUx1REEwVjJ5bmZ1Wk1I?=
 =?utf-8?B?WjVDNVV0SmwxYk05b1lzcTNFVFlGVWJzSjlQa1BpUWhUWnlFcUROQWFkaG13?=
 =?utf-8?B?THdwZGtyZk5VKzM5VTlmQnJCOUpNeE5hU29vMXc3QXBDM1BNUysxRExSc05Y?=
 =?utf-8?B?aENQemVCaGIwNXRSWUNQN1NaVmtRVDZ3cm91LzAwTXpNOHZGS2t2N21RMFN6?=
 =?utf-8?B?QVc4ek5BNkxEWURrbTJtNHhRV3c2ZmhGdzBUU1hJaG9BK1FRWmp6SDV3a0JZ?=
 =?utf-8?B?V2tDTHNRajZ1ejNMS3M5cmZGVDJCVFVqZ3JEWnFGdDkycElZcldHenNna01W?=
 =?utf-8?B?S0hFU0xlaUY1RUdwbjZhRWRNWS92UUxaSWRvZUwwSVZwYnVFS05vRUpPWnVa?=
 =?utf-8?B?bjFRWWVYMEx4ZTg5L1g0Ui9CdjNWcTJvVVFnK3lwMEtkQXYzNVdqTmdpWHFp?=
 =?utf-8?B?UVNsRGUwTlFaS0FOZzJVQTF5dGNtOTJ1T2Y5Q0U5Ulo3dG8yWVdUNVl0U2t3?=
 =?utf-8?B?SGtzWDZjUkRyMmltdUZxSVNuNGVTK054TTFFaHhiMFFiOUEvWk84TFlWRmo5?=
 =?utf-8?B?NnhwNUt4Mi9tMHdLRFplRXN6bUN5VzgzQVY3QjRaT2RnZ1Yzb0g0ZnNqbnBz?=
 =?utf-8?B?OGhFa2k1QURFcFk3L2JKQk1SZ1NYM0srY2llUTQ2eTk5UmdtZ2ZCVlpDamZk?=
 =?utf-8?B?ZjBiYmJDNy8zL05EZndaUWdUbUplaHcxbWdpT3VQYjNYZ1QvSmgxNWl6eFpN?=
 =?utf-8?B?Y2pDVlNoUVFGTjZFK2dpZWRncmt0RmRBZmsvVWtSdCt5ckF5WmR4MDlTRHdS?=
 =?utf-8?B?d3h5am1wVTdqakdwZXVpcndaaVc1UWQvOXJzMUJuTGNnaDJPZlhxcHVIMm1N?=
 =?utf-8?B?MmNBNC9hTHVUODF5OUNRTHRFVFh1NjlNZWVwTSszOW9KZmxuLzd5UWQvcE1O?=
 =?utf-8?B?UkFqK1lXbTVIUXdXZ2I1aXpOdWVYUEd3RTNxemhKM2NWZTROS3ZlcHo0WVpq?=
 =?utf-8?B?SkRyeHd2QmxjcXBYSUtBRnF1K2o1TzRjbFovS0lQM3ZMdTRiUGZBVXFzeE1Y?=
 =?utf-8?B?QUl3aWdGQ0JRc09LUnNQbDdlWUF6VVRFdUNPRmZoeUo2MHA5ZXFLSGtlaXR5?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e8c010-b281-49f6-a471-08dbd6b93438
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 06:51:53.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG8nkqJB7hlRN0fqA5DbGmNMalfvhOkH6EkGiWYeI1dg1hxBLMhQqFKBt6gmJLQ/cVvVzUXZ5Q3gtgyE8wJolH9I919o2GEDhEamDInFkcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5513
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.23 22:03, kernel test robot wrote:
> Hi Eberhard,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Eberhard-Stoll/spi-Add-parameter-for-clock-to-rx-delay/20231026-232547
> base:   05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> patch link:    https://lore.kernel.org/r/20231026152316.2729575-5-estl%40gmx.net
> patch subject: [PATCH 4/4] spi: spi-fsl-qspi: Add support for rx data sample point adjustment
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231027/202310270332.mcbckKCr-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270332.mcbckKCr-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310270332.mcbckKCr-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/spi/spi-fsl-qspi.c: In function 'fsl_qspi_select_mem':
>>> drivers/spi/spi-fsl-qspi.c:558:38: warning: suggest parentheses around comparison in operand of '|' [-Wparentheses]
>      558 |         if (chip->rx_sample_delay_ns != spi->rx_sample_delay_ns |
>          |             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~

IIRC, when I prepared the patches for sending "checkpatch.pl --strict"
suggested to remove the parentheses here. Seems a bit inconsistent...
