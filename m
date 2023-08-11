Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F00778C37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjHKKp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHKKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:45:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C171127
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKnLqrXchq1EMsuU5zixwFrk/wBIfrCoA36yCSko8+kKr8vJSmdRa01ZSptaglSbkjmflCCo0IJ4xTrtAsL9efO4OHeKr3jwb7wE5FfKmLo95PyWDkVTphCE/krPBeUBwSbrDWKZ6zDujCIpwAxLlxtlikswlAl840dXealOucdXVTF9EAsjnkDgqVqhSdYHr+K8FFxcYGZ+TjHfy873kpJaJncaZRxJKZe+xzaAxr2wgOjIk6lbujQnppZ0Zn1SS1ohvP1RgcqXanF90qBDVJRiwbofRWbSma1Kibxx5vptMHKzUNZLItR8bDU6zkmwA85u6ugaZOyq2uDMdlA7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDDSFNrhNXHGyJrr1F+hqGUS4viuay97WHqAc9Iy+bc=;
 b=T3PnprcJ+x4xNSYSTfgWfJqDOnHzjNTIeL6eB+Q2z99Q8Bxc58k2tP9jguBsBwett79TBjZKpksZQ7JhvqAZ51kZoEq8IpdSzPKR4tDkQnrF++8qLAgcsXWvWI1a+Pyva92LDqg3fpE9VIWCRoRQ4h8uPsJ3AezyxpLRARdUYWrhQWLoUouFjdtyRZW/TUc2xfZ1p+akabuDtiuxiIBwcmCONL08E4utcUkG/1a2Z75ANtAlEOQd9DKF19La2nBal7Fack7IILhKLUuSVzGrxbuyvLKvhRzuhb5ftXEJSjHs/X78aLPFin7UWfI/uRYpnENq0uEZdMV1wN864cFIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDDSFNrhNXHGyJrr1F+hqGUS4viuay97WHqAc9Iy+bc=;
 b=pyAEF7eaMt8/o1zjZ4Dhs2YshqHpROM98A3B0y5lkq94t+db0U+3ThKkDwor7R51JmY4LIOo/4PdrPTaNALKtAzEB6NtWgqyUhJEgS8aSpVFTPAArvENoUl//KpSI4h7d1/KjCoZDPjULtKQs/haOPouowqUx8MGyarcStwlzY0Ui92MQWQQgfEVbP92ziJ8ZLxdcTmGUhpru0z+wWfFVCkMO1WKQ/jdc3azTv7dhkeppG2bYe0WoryuCbF09C6CU6cK+/p8/kIeNEzOjHtn3Inl2kjut1NDmLPAIy4yZda+7LItVsJPivp8oJ1tS3JEdMHWkCAXrxINDOofYF5Pfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 10:45:52 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 10:45:51 +0000
Message-ID: <21fc95e3-2459-6a75-bd92-cfbf5232bdfa@suse.com>
Date:   Fri, 11 Aug 2023 13:45:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 09/30] x86/microcode/intel: Remove debug code
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.480445927@linutronix.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230810160805.480445927@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::16) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b98ea9-b140-4b88-54f1-08db9a5821b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fYF484CDGbGdg2I2ocl644x2V1bpU03Yx7kVNdXwnYkUEkLjp0i/E6EnH9ZK5RlutAdGZGCRLKd+e76LkBPosdXbMpkIqa8OIWrL7uu2+CNv+zz34Lk4gPw3cqgGMdP/bf2i9Aiqj4NaLP6NrBYmNB2X5SjDn1mu4YtIxY+BfgsboRjZGF5z+jGX9usQiFWH4FpMPznP+rKcll7zBVfS8KPIOLcU+9Rclws+NDfRyS6cnX5URA3MizaxjqqF5j3lTI+oDfL8ow/PE/zsMc4XK3Y7BcrFpiWXBXN5YqsvSC5PpS3+hfJu5KA7obvnCBAzQZ0XaL8QXU9OdaS0/W/KntIed7cd00K0YAgWUJomcx/XmyD+Z0K6tZyRA4gfZbN7x+1yN2fEoV0rGw0YgwNU+ZNINrO5nH5lED0B3/VcGto7jy331kazm/QutfkcuOCpQBvlz1k4hxjoZiUy+kWgSzsAQJ42dtoNK7BHufvyNg4FByJIttx2Qfw/tgwMwrMsXDnO6hbxn+OpACmJjtCTLTIismewQk3YHa6Y0IK1IM1+n5X8fumFEo71E9hoAoLsz5zwbpoT98sn8ogXSYR2vW7PehpL0LtJoGW7Fw4c0pLI4ioVOca4kLHBKnRJ/OUaVwcaXjM5fwF61r14DtrRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(86362001)(6506007)(6486002)(478600001)(6512007)(83380400001)(2616005)(26005)(2906002)(4744005)(110136005)(41300700001)(316002)(66946007)(54906003)(66556008)(66476007)(8936002)(4326008)(5660300002)(8676002)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eStvR1JIeFArbkdTaFJpZERwNUV3SFpaZG80YUxtN1FMUTBhZlJPbGN1QXN1?=
 =?utf-8?B?OS9pVi81ZFlnUVBSaXVYd1pSQnAvQnplTWRhOHl0ZXFFem1rTFJDeTV2SDYy?=
 =?utf-8?B?bG1nNzJZVXZCYk53dnVMcHRDaWRRTTlSSy9MYUdrYXY3WDRXWHAvcGhuRndJ?=
 =?utf-8?B?c1NmbVdNWlVyZS81TjFPSno0M045dEZMWklrSnJKdkZwUGNUeXA4YWNKYzIv?=
 =?utf-8?B?VE81RmwvempUV0MwcURtOUVSMmthUGRpQkpGblRRb1UrUndhR2FLbVlMa09i?=
 =?utf-8?B?KzJLanpaS0JBdFNCVk9IS2g4Q1VBLzNrR295NStxK0FJRFRDeHZMTTBsYnpz?=
 =?utf-8?B?dkIxUEpYUG80c3loRmxpNmlUR3Nla1hITW9OeGN5YUN5c01vdkdaN3RtRGZH?=
 =?utf-8?B?MmJ0SFg2TythNjBoR1lIZVdXYUhEbkJEdVM0UHRFWHhCR0FWYUhOeUpWKzlW?=
 =?utf-8?B?M2RFRUFEbkUzRk8vZk5sTFBrSi9uZEkxNkp0Rnd1NFdMMDhCUm0rTjRJZTRM?=
 =?utf-8?B?UDBjTngrUUQwUEE4OFBTaVArRDNGRCthOWQ0L3FONFkzeWgxZnFIQWV1ekxp?=
 =?utf-8?B?dWhoNVkxUEhLVnRyVGxpVVcwMnFzbnBmcXJrUUFjZFh1WDR0dXVEUlRFSkNx?=
 =?utf-8?B?Q2x5VURjaFVGNnA3bXo0eDFhSXpxU3JFSFhmbmdoZm9KQ0k4UXM0RXFZV0JQ?=
 =?utf-8?B?Qk9CRkgrZUp4V1JHNzdSMGVmb3kvcU9vR0VnRnFzV2RuU2hOWU04ZFNGeW1Y?=
 =?utf-8?B?bHdPQmJ5M0hFT3R4dGlVVHg5ZTdjM1pqOFpkZE41bW9uS1NNc0FsbE1iR3VU?=
 =?utf-8?B?bVVGVUVvM3paaEV3U2lkUC80NWZmN2lsZ0JOOUhEZ2FmeUxFbzhmMnM4N2I0?=
 =?utf-8?B?VXI5VVQrOU92ZTYyMmlxeDUrdkNpNmRDNHIvMC9oWmJGd3Y3djJxZ1BJbGh1?=
 =?utf-8?B?SFRqUHhxeVlYYmFMK0Z6WCtmd1JMODdNdWx4dFF4c01aNXZGSytJdWNVZGho?=
 =?utf-8?B?UWNGSUF0VG1ycitORjhrVGlkMGdndk5jaU1yWUFnTGF3ZkorN0oxRzRIdU40?=
 =?utf-8?B?WnJVU2huOWhJYlRieTY5YUlVUXFpdUhoZVRBbmU3VXY2cDJ1S3pweTIyZzNF?=
 =?utf-8?B?aEU1TkVJQWU2azY1c3FiYndlRUM1SWI4WDNFcnZRNzErOXdNei9hRjdvZ2ho?=
 =?utf-8?B?Q0grREI5TjlZWWV0UytoQmJhZS8xaGxhak8xZkgvaDlnZmpHeWFwNndIdDNM?=
 =?utf-8?B?RzRuY3RPWnlUNDZnK09ieEdUWFNTaXFTYysydjdrZGhMd212dmpCTDQzNDVB?=
 =?utf-8?B?eHRYVGFqRmUwVTFyVEFMSWp5UW9EUFVMRzF6d0prQWloYlg4NUJrTDRFL054?=
 =?utf-8?B?REpvNE91MjhFK21QNFcwSzE0NzR5R2RRZ0ZSMFc1bVMrVFFWY0gwckYrb2Zl?=
 =?utf-8?B?bjF5QUxIeUdJQ0tuaXVZcGdzVGd0aXprTzY2WXJPVlJ6dDBzemtJelRpUkJW?=
 =?utf-8?B?K0xXZVFCQ09rTU9SUzhvcEtIKzF4bkR6WTU0eGJzZTRoekFZUHRqL1hJNUI0?=
 =?utf-8?B?VGZIcG03V3QwWW1YMTFCMzgvam5IVlhiSlVrWUdBSUcyaFI5TEl4cEFlWklS?=
 =?utf-8?B?OEVTdzl2VXVVOUJQcVdQYXJxdk9nZ2V1bWcxK1VnOXhqcGJKaVhrQkJDeW9o?=
 =?utf-8?B?QjROeHBHSm5sUGdiTjJoa1BhMDZaZFBQVXA5L0dENWJJY01SM093UFVLd25W?=
 =?utf-8?B?RUVjQ01lWnhyU3FFOVNOak5rS2YyOWkveEdpS01JYVNLTkp6YWx2cWhKMld5?=
 =?utf-8?B?Tlhia1dBK29TUzVFUlNkYUZPcWE5ekh0dGRCcnZtOE1MUlRCVGJCNmsvU0lv?=
 =?utf-8?B?L3RmZmV5eUpEWjkySGY4WkhSS0JSRlN6VGNBckJtNVMrTkNocWxvci9yajRD?=
 =?utf-8?B?N0YxeTRoWUxlMmZCWi9SZ1pCR1cwViszWC9FY0ZCUWtER1NYNjVzYlRaSVl5?=
 =?utf-8?B?VDZQN3dBcStWNUFpWlQyVWlsalVhYVI1RXFWTFNzVUFhdFI2Uk9Xd2VsTVZS?=
 =?utf-8?B?OWpWM1ArSlcrSzlxUnJhY3R5R0c4WkxHZUNwOHVEcTlyRjlMWWZNczBGYjVo?=
 =?utf-8?Q?HfM5NCmFX5C55Om+hqAym5kHC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b98ea9-b140-4b88-54f1-08db9a5821b8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:45:51.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSoOiJxOCbT+I6Xb0dlknewtXJxALsSK23vPwtCf5F0cQkIyzNuTujrfjgB0BxlJmpZhPt5rkvDC6+tp85I5/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.08.23 г. 21:37 ч., Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> This is really of dubious value.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

If this patch is re-ordered with the previous one then the diff there 
will be smaller as there won't be any changes in show_saved_mc
