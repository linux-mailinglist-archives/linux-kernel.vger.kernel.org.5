Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F547D3965
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjJWOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjJWOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:34:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6E69C;
        Mon, 23 Oct 2023 07:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE/7j+4tygbDBLZLjRxRszPJKdkU1Q6LCaOweRUaGd+tHjWjTcBmdo1Au6a2hh2Hq9X0LMf4LaZm8pnlIGYLZCF1TtVClnKP0qIyZaT/wRVcXvanvV5rgq1JN4ua24D4CqVRZsOHLU5mdaw5wzr6gPFECNkVnnLgAe89H01sT9i38t+PaomhM5U1DvP/H+TG8SFu/OcNW18bxyW0kLeQmwflXQewRV1phMruj2bEstjpGiRZBLvfJEt/R74gu0/2YqFCXcCxjWtIZZUPuUsZwbqDcj6gPciOiGJ4Mz95EHIyORC0A+kkbr1jT4KFWmIOxkYmtH8APWkvMRs4Efgh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qMrdUbCBUzO/zkGPNrcQVbHghcfxxq3RHgorMVU904=;
 b=OrioABFsTg1KSfy6DmSH/y3Vs8boX2VqyibJrDJ3XjSOPpq+reicLavv1bzwaT0x5csX/CHfoxQMuVhqrSLDjYhl/7BCHz2i8OU3Ptv6NhmkEqt8SiPYtgdgxe56K/+MruogSULFaphrbBtdAciqNy6MlH2+iJBhIYiDhKSRJKeeEIpxGWD8vKoG0OwgrsFA5OUtzQSuwELAPze3GoiFbqBYUjIBUzAyccLxMLn/bfIksVGv4WJ0ZlsccEmGMe1iOIHVj0o/fMJEf4/sHvu3YeX8p4xVylHkDx1c0k3Ons0I4ESteWRWBG+s94KKzvmjsNSHYeLw3qAq65kqhciMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qMrdUbCBUzO/zkGPNrcQVbHghcfxxq3RHgorMVU904=;
 b=Xo5HAH8EA+ObmqcmI/qaqMqTpq+8oa91pysQ5CqnB19Hic5WZ3QIBBuwUS1vX/sLUzNBYY1dqPgAootmH1YE7e0Ff7YQC9qoPX2tCLpAbOYa9zaM2Bc7X/Vakc6mOozyn31otYV2ApDHkfPrg7aQYgOAnPJCTUi1GQJ6RL8tzb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 14:34:05 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde%6]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 14:34:04 +0000
Message-ID: <dcb9d0bb-67a3-2f50-9d17-251baa24b066@amd.com>
Date:   Mon, 23 Oct 2023 09:34:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] docs: rust: add "The Rust experiment" section
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, andrew@lunn.ch
References: <20231018160922.1018962-1-ojeda@kernel.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20231018160922.1018962-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:806:28::25) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe2b0a7-c255-42e5-7adc-08dbd3d51b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE/8ZVzrxQCe9YCVc2Jdg9wqthrOi/i5FD7UI8RDlKOylLjSnj7gbkRnrNWz8EZHxRTaf2twERjeb/gQS44TM6NWj/GvKqsV4zfxWbP649qeVsl58Ki3YiP2T4vrs0LK9nxmw9qvXZOGIBbSMxdG1+SqOx7G+8O3kH7n619eiwweVKp84LN5DR9JBHNzjGWNkdEL5ZHLIdzVmO/1JftOhum2KwyzseeBtAf27AyYEZKBWzWT66oOC8jJnaeEt5zT2Y6vdL8EXn+JZfITVOmPsaq8raTYzqSDSZ0qi2gKIZj6s7lg80o+mVEdeey0Z0XNFwdqAb7nZbiclRgf1Gra/9YxIMW/jOaO3CWkxFEcpnHFnoOX96+4c3q2bGiCYtiNnZY4IeSQuyNjHkCY/TaiuU1yiYdyWsqKz38KUJxc5Mz1dlMlT1X/9T0UcEj1fXFRd2LqFYJPbTivMsSu+twhLP68xRgL5ZiAt2MNwHiTVeUOutGCSvKrOG/iG7RtcN7R2jXvZYRW8j1e4wQpFV3MbzB9tLotaU7O4W875wiZBsTM7/PGbzLdmLkcZADxQc6DiyLaAn2TLUN/PoIenIG59Qq09/y6vkNLalT5TPx+TpIUnONen4oCqtWpS3ybZN00Q7801q42JHzRSPXIkHgXyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(36756003)(316002)(66946007)(110136005)(54906003)(66556008)(66476007)(86362001)(31696002)(38100700002)(53546011)(83380400001)(26005)(2616005)(6512007)(6506007)(6486002)(2906002)(8936002)(478600001)(7416002)(5660300002)(44832011)(8676002)(41300700001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHByNzhEQ25JNWtnZFJSTG8vUFp5TXJBakhnNzRqemptWHNXRDhIWXBUTVdk?=
 =?utf-8?B?dDhlOUFYZy8wMHM5bDhPLzRhUSs5citvUlF4T3hidTRVaVh3UThqKzB5UUM4?=
 =?utf-8?B?S3ptVGZibGg5alAxRjNLekI0NG5oMFhpTnl2NzVPTnh5L0JHWHJldHFOTFc2?=
 =?utf-8?B?Y2JESXNPQWd1R0JKdmxGUFQ0S3BFQU5LNTBzVVFqRTU1UXNUZWQvc1FTK0po?=
 =?utf-8?B?VlN3QzgwNFMxUE1LZ0I2Y0kwTko0Y0J5M1JNdlU1bjlMVTBWK1ZLMXRiUjhx?=
 =?utf-8?B?Z2F1eXM5SDV1S1JneUtsQjU4NHFFQ2oyL2xySkNJT0U2N1pYTVlJVUtadEg1?=
 =?utf-8?B?eWFyUzA5RDNIc2hNZHgrVHBHMHNOWll1bmlacmREMWRldk1vb3puN0hXYjNp?=
 =?utf-8?B?b1l2YjZRS3k1SjJEM3F0ekZqRk85UTRWU00yRGVFdnZWSzFCaUthZFNIcHpr?=
 =?utf-8?B?NGtYT2lrblV4dXdRY2VDQkw3b1dmbFRGL3FlM0dLS2dNZkNRUWJ1SHh1Kytp?=
 =?utf-8?B?Tzd4cjY4YXhlL3dkYVFSRWFXbHBQN2tyRlNUcFJ2bVVNcCtWY3dJZGIzNkp1?=
 =?utf-8?B?aXg4U1o1ZkJscXlMT0lQcnk0MUdDdzl5VElvRUJlajRHb3hnMUZBRlplUG5z?=
 =?utf-8?B?ZjZ1SE8yZGM1bU1pVXJ2cUl4d3Z1S3BWQ3J6ZmFiSVJMN21VSTRwcEkyUCtK?=
 =?utf-8?B?ZFlTMkpHVUZkd1crcTZaelZBekFTc1ZxVFdVOTNNTGROc2M4dXRrVS84UDVj?=
 =?utf-8?B?emNpS2tvbW1uOTlZWXl0akpKOGtMQnY0MGcwV3BQSGxNUDBPYnc0YTRzYWZ4?=
 =?utf-8?B?VG1wYXI4bFYrYVhQMXZLa2NkT0FyRGs0YTB5aEdRaWJDSUtOWVdZVi9JNlph?=
 =?utf-8?B?NGZ0Yjg2Y2xTZzl5amxqWVM5aDYyNjN6VVEySm02VjZLMlF5VUNydFFNQ2lr?=
 =?utf-8?B?Y0Q2MFd2Y2dwQjBZZisxa096b2lCRzVmNjA4NVVyOHFHdnhORzU4VVJwekVP?=
 =?utf-8?B?RXQ0aDJhRkQ5bFhyeUNKeWxyNm5JQktUeDNqOXdCTktSelJPZTZwbmt3cnll?=
 =?utf-8?B?NkVuNzd6Sy9XcUo4Y0FXdTRUOGsveXJQM0NhZVg5ME9EY2djdTJGeVJqSWlX?=
 =?utf-8?B?dndSOTh1RzdaZHRBOE1UWUt3MTF6dWVYNWhpNGNFaDhBbzcrM1VPNTM5dnlU?=
 =?utf-8?B?TTJkRGtsQjlIVVdKTXFUSE9OQnBTV0pVaWQrVCtzN256RUo3VUJZZXRuMDA1?=
 =?utf-8?B?d0loc0tOQ1RjUzFYVjgzb0lRYVZEMGN1aU1BaG1jbkRpWlp3bnpHRjI3a3I5?=
 =?utf-8?B?MjAzMlRsMndWNHhjZmF2NTdONlVKR2MrcjZlY2M2K2lzcDRwK1U1c2FtZDM3?=
 =?utf-8?B?cmhwdWtpR3pSSzVxcUlnSUFVSCs2cUhFYndKK0E5UE0wdjA3VVRoWmRxbjlN?=
 =?utf-8?B?UENRZ1ZRVU1GMDdUV29TRS8zZVJoTXRHMThKQTJrblVvbUplaGZCWldaYkFR?=
 =?utf-8?B?eFlOUVdJZUxnVFFSaXlyS2J5WTZNbFlLbFRGdlJTWXpsSzFmRE0za3JnYjgr?=
 =?utf-8?B?SUs3cGtwbi95dmVWOS9jQU1GQUJsMk1lYXc1ZDZOSE9GTnJ3WmM1SEh3bVZB?=
 =?utf-8?B?V3ZFdFVPYlF3c08yak5TZ2dWYTBiOTYxTW9zUTNhUVlGTFlmYm5FT28zREV4?=
 =?utf-8?B?ckRVZ0d5TTMyQTlGK2MrOVNmc2RjUmgvQlVJb1c4WVZ1clZYeG90RE42MWJC?=
 =?utf-8?B?U2tPSVdTQmIwOTdzTGhiT0VvU1FiRFlrQUtLL2NqSldlZ2czYWF6V2VBQ0VS?=
 =?utf-8?B?ZklvYjZ4b3FPSUJRWnNETFlSZU8rcUllalJkYkZhR0dPVEV2aHpnL21Sdi90?=
 =?utf-8?B?YTNpMnQvbFFhWTdzZ25zNEF2SWhDSS9EcEdLRWZoUG5PRDFORHZJVGNobHdW?=
 =?utf-8?B?UmlwUHExUThzSU1xUHNPNWlvL3EzK1B3TlRxSXlMazc2SHJ5MHFrbDl2UEY4?=
 =?utf-8?B?MWtHeXBMdk9YbTRHWXozU1k1cy95cXROMmtiOXRJR0ZUeWF0Ym5GM0R3d0ZK?=
 =?utf-8?B?eEozejRyQ0xOdFpRRUJVUURlM2xvdmpyRnJtalJhMmNYR2E0cEFMbHRDQkZq?=
 =?utf-8?Q?TwX4NTqEfv6nHyD2bzj+eH5UA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe2b0a7-c255-42e5-7adc-08dbd3d51b9b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:34:04.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BAdX0XR1BV4XQxL1UaYUDmf7XzBH1Dn9AmUPQ3GCrfLkmI8CkjXR49/gPCZTfUYKDjCpIO0kk+FMrNlSx1Fkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 11:09, Miguel Ojeda wrote:
> Clarify that the Rust experiment is still going on to avoid
> confusion for both kernel maintainers and end users.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Andrew: I did not add a `Suggested-by` just in case, but please let me know
> if you want it, of course.
> 
>   Documentation/rust/index.rst | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> index e599be2cec9b..aaed36af15ce 100644
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -6,6 +6,23 @@ Rust
>   Documentation related to Rust within the kernel. To start using Rust
>   in the kernel, please read the quick-start.rst guide.
> 
> +
> +The Rust experiment
> +-------------------
> +
> +The Rust support was merged in v6.1 into mainline in order to help in
> +determining whether Rust as a language was suitable for the kernel, i.e. worth
> +the tradeoffs.
> +
> +Currently, the Rust support is primarily intended for kernel developers and
> +maintainers interested in the Rust support, so that they can start working on
> +abstractions and drivers, as well as helping the development of infrastructure
> +and tools.
> +
> +In particular, if you are an end user, please note that there are no in-tree
> +drivers/modules suitable or intended for production use yet.
> +

Personally, I would rephrase this to:

"Please note that, as an end user, there are currently no in-tree drivers
or modules suitable or intended for production use."

Also, I believe this should go here and not in Quick Start. The average end
user, to whom this sentence seems to refer, typically begins his/her
learning journey from the index page of our website.

I think this will be helpful.

Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>

> +
>   .. only:: rustdoc and html
> 
>   	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
> 
> base-commit: 94f6f0550c625fab1f373bb86a6669b45e9748b3
> --
> 2.42.0
> 

Thanks,
Carlos
