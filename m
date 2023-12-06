Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA208068EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjLFHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:49:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC0137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5nz8dn+VMSbSfc0GNt4h4+6wlh87lTGv4SvQYGqBSWIgK84+OmYAc/lxaiwnwhE96PXEyU7vQ+Aa5frH31huGgyl3FjI05vlL9YDwLGh+oBGCjDK0+f6+JvCeXxIsVVOcfoH0QBkAJDESh9YsAksVj8lYCuMaO4DB4omkWqmQrA7AchnvDoaK7Ap0Atw9aV9YSg8f/ecYJFnABwtamJNWb3E/hF1QQCZq7EFHbTw/uD18UCZXGrkvLZW5eo8eBVOm00YBYBx6Am9SsGtiKDSwmsjsDDcs8HoO8hS1271V3cq+eziTEjK0MsAAC2Nz8B/CPWhZTbSs9ZxeOjZcYiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn6828m0ZNbbaRaDT2ml6Q+UfQENdycDrvqNQojh6sY=;
 b=Bpb9NNn8ZK5lxnodpJPvbWCvudIKt+ik04HN6hvKyOgT2bCd+4iWVkGQ+G86eon63y3yzzpt+FLqCLsO624pfcveDL+eU7E2B/JH/DiUU8E8qzKJRukUOJKIbEm3q/I9DCYCxnQhnIHEkNmL3WVQaBrI2WWwfOSUlaVKd5fXXrcPkh1eEPoURSrkojrzRWMcDBrjPW360R4izAxg5EJUbPntZp2X/0GWnD+LBTyRyDoHvqo93X525e/TvIZo1XF9hI2d6YgRP8W9vB7jkPeaitkRopRyxSTyjlKVHhO5+rQ9Ceihm4wa1F2zYTygR6PMgtpJX00rfqbNCt8v+WRxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn6828m0ZNbbaRaDT2ml6Q+UfQENdycDrvqNQojh6sY=;
 b=P5k5JWMlc6sRZV8VPbh+nI1oos7qV+r08kM5SVNVsoCebRxSzmAO9lHXIfTXuzv50i7OcBOq4kCe4FySal72NmQCecAMfQ/YVh8iZ5LYWj+BkpH37rgz0RluqXp2cyfzJkNphsDb78CBx0doJS3Jc66QaFj26AJpwwtl4oyaKfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:48:23 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 07:48:23 +0000
Message-ID: <1fdcdaa8-5eb4-4a03-ad34-811c3ad7efd0@amd.com>
Date:   Wed, 6 Dec 2023 08:48:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: cadence-ttc: fix some kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20231205230448.772-1-rdunlap@infradead.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20231205230448.772-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0038.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::27) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: a15b8f6a-34e9-43cb-a53d-08dbf62fb8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2GhBLbt5OV/iKjBFdIvrUPKg9UhNfVxvsTIZQh4QZHY7rt/YAowuRZJHE+Av/PpuL1Y/XIxrv+pEm9z83gY65aVVlxyR1o7wzKn6aXgn4xBxbGGb1Mc0J359Bik4sKJ01R36L6ZiAGhAE2RK7iCEuF2TMfhWkPOhkoaZlyW/SSXMHjDlB/uYl2hSgjxSo98nYIhzuxDwlJE5lW8sZhDufbknRehbnN8dkf7iQKakYTqslVjOo9UOpGV5/oOEcBmobZkX+EJbphKjGIUnkeLPK8Amg9VDVLexllEuKo9t/PNNr51+XVC9faGCNPlEOfgRCpZxR1eDmSDmlkGLXGL7dsRZbcUrOBv7Zw8C7asJDYIi7ucKK3LU6Csv3TT5hJLhkpM9C1mON1QCQlyDiX/qW+pEKRUKTgkvNLnf0LJVPyjAbY+KE4EbN55UWhX8vv3Ya3WjOqL1ZfMcIL2WJ6CrGb52ZklMXZ36/jB2+7x3cVw5tBNn+3q61tiJyC04rZXrd+Xfg0rv0/R73vEvYj6+C0FVcaudQVu/5BHYL8khatUqXkegJQ6xsclee4oSQIKCCqdjCrEwm9EJ37zwaYgzGFr2wDcnZ8EPeIYpzs7A8K5R1WN6EXAhNQyXTBhMw5pJq64RRxEK8RnLLTdfwrchaCVFsNPkWlLw7MCarelZwGoQd6JHQ2GMsQyGNSo53Ya
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(6486002)(478600001)(5660300002)(6666004)(53546011)(66946007)(66476007)(54906003)(316002)(66556008)(8936002)(4326008)(8676002)(6506007)(86362001)(31696002)(44832011)(83380400001)(38100700002)(36756003)(41300700001)(31686004)(2616005)(2906002)(26005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkEwWWlpaFdpZTd3VzdrKzNGRStSK001KzJMMGRYaG9YV29NL1JNL3lGcGVG?=
 =?utf-8?B?cUFtSmtjZkNiZW55OGdRZXNaMTFDczkxT2xWV0hVYkRwcmt3NHgzbHk5OU9F?=
 =?utf-8?B?NVFvaEY1azYzTU50VFV3b1BZakFFRElXSzYvaForSHQ4TG96Vy9jU0V5M29q?=
 =?utf-8?B?eWRkL3Uxa21HdDcwOHNyaDNPelRxWGdKMXliWUJUZm53K3pvRkZjWDZUc2F4?=
 =?utf-8?B?UXF0OUFlUEFHS1FOQ0dITkZoZldMUWxvaHh0ZDkwclgyelUzd1lMYVBXeFg5?=
 =?utf-8?B?cTl4NGJCeEM4R2ZTVnJrQmZudENxWlFTQU5CZVU1WGhCU0pnaWVBWldUTkVr?=
 =?utf-8?B?NTZqTS9wZjNqaG8vYjQ4UlVFTHp2dm9UcHlKR0dobndTRlg1VkhldjdxaGFO?=
 =?utf-8?B?MzZiOXpuVC9lY0hlZ2xhVlh0Y3BHRlEreTJqWHhtczVyTEVWT1d1cnVVV1ow?=
 =?utf-8?B?RnkwVzBRWUJmbDhFWlE3Z2xobFJ6Rlo5TlpQMFdtclI4dE5OZjRTTG9OTUw4?=
 =?utf-8?B?TEdSWHpPTGtyUnY0S1pWWTYyMzhCWFpnWUpjYjVuSWEwZFZVS3hkNGZscWFZ?=
 =?utf-8?B?cVNLK3N5eHJpT3JSd1VVSkptUUVwTDJoRE5mOHlDYWo3VmlUaVRjV0RGdHNP?=
 =?utf-8?B?L3dxVUFpRjFkYWgrcG9BMDhXcjI5Y2hJaFhSVmxwWGVBMlIxdjNTODlIWU5U?=
 =?utf-8?B?SDh6UmxrWlNoRHJqTWs4OElwa3o1YmVDc3lVcldydUo1V2xXNXJPNFRoT09t?=
 =?utf-8?B?NFp0NXplMTBDZnF2OFJWVEJSSGh1ejNkQTQwbVV3dzlVYkE2NEQ2aWlDcklM?=
 =?utf-8?B?bS9abnFDTUNRN0daT0h4YkpBeEVKN2psd2xHQU9RcjdmbkFNeDU4QUxFWjl3?=
 =?utf-8?B?eXArSFZRNG4vWEhNdkpvb2IwTURzZWgxTVYxZkV1Nks3Rk1iSzBNVERTa1FC?=
 =?utf-8?B?T2paaWdzTVhVVXRJNlk0YlV2QUFzOWZ0WDhIVmdSWUdZK3pCUS9LWmI4UEx3?=
 =?utf-8?B?aGV3L0YvWkM5ekVRNTJhUGI4WG1uSGU2S0JqRXBWRkVvRjVOdzZxaDV3cDdE?=
 =?utf-8?B?aWxIZ2k5NkZyU1g5S3NKSEU4KzNSbTluOWxiOFh2NHN2MldEa0dEOGM3eDNq?=
 =?utf-8?B?VTZvODIzNTE5V0FKd0FFczFkK2E1VkVWTzFOSnRGQlUwVjQ0NFBBZGVqemNF?=
 =?utf-8?B?NVFjSDBLYzFwOXFmSUsyZXdmTXN3WDcyaVdWZ0d0SVZlSnV6YlRPcHJSU3Fo?=
 =?utf-8?B?bEEzNHRXR2NDblYzVFNTY1dSTHZjSWZ6NGt6TklxVDluN3RpSnR3TGM5MmRC?=
 =?utf-8?B?Z0hRUVZBSG9jMWdHY0NtRWZKREtkN0tnamIvNkQ2SFBEUm5zVVg4RDlNWDJ1?=
 =?utf-8?B?SllhT1BUcTlVWlBYQjErOEttbkI1djVlczdPVVVpbzZmeHZ3K2hkWTdIdXJM?=
 =?utf-8?B?akpncmhBOU1RWmVRb1BnVzZwaUVlS1ZML3R2aTQ2MDJETVh3Y0IxVUYyWC80?=
 =?utf-8?B?TjVzSlE1b1JyYjJEazUyZGFISzZlMHhrUjZwMjM0QWFkRTNBRGdvTUlmZHU4?=
 =?utf-8?B?d0ZvV0x0d2krOXRrcDkvdG9sd0NXQ28remZRcmw5dXk1S2tQUHY2RG5rV3lE?=
 =?utf-8?B?SVc3QWJlQ3FBUkkwRlJCc05jTTl5VGlkRkRyaXdKclpwUGU5YnZyRGM1U0cx?=
 =?utf-8?B?ZWt5aDV0NkhIK01zU28zKyt1cEp1cG1BRXhJMTdDL015d1lwazNURG1ZZjJj?=
 =?utf-8?B?dzFPVDNkTVBKZzJKMjJLbWFxL2xraHIvNzdhWlh1MGx3a1BCTWZrbFVFM3hS?=
 =?utf-8?B?Rm44NUdnaERXamdqSkFzanFwUDdZSHdaQVJwN0Z2U3h0VWhqOTBpZGNXaDlU?=
 =?utf-8?B?RWF0TjVQMlhVRnpuRDZIb0dFWW5SMktVYkp6QmQwdVgwMlZIREpYNUhzZG5V?=
 =?utf-8?B?K0l1QUFCYytCUkJhNnEzcVYrdzBBTjhyaUtKc2NxazBjdE0zU1IrWFl1dmxh?=
 =?utf-8?B?dkQzODNjY0owMzhlcXpNaUZuaWtwREJWQWw2cVNhY2pnWnpHZFlDVjVEaHpa?=
 =?utf-8?B?V3VobnhGTEt5RDkwQk1YWWJWdEF6QUwzaDFWTlJTd2hoY05ONFhsN1dCaWVZ?=
 =?utf-8?Q?jpwslh9eIGM1deFTluygMW9+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b8f6a-34e9-43cb-a53d-08dbf62fb8bb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:48:23.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwQbPpHfUF98QYyPwjb0jxK+borMeX31PmTWI78Qwyni8k6Zrw4CEOwbkabRU979
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 00:04, Randy Dunlap wrote:
> Fix some function kernel-doc warnings to placate scripts/kernel-doc.
> 
> timer-cadence-ttc.c:79: warning: Function parameter or member 'clk_rate_change_nb' not described in 'ttc_timer'
> timer-cadence-ttc.c:158: warning: Function parameter or member 'cs' not described in '__ttc_clocksource_read'
> timer-cadence-ttc.c:194: warning: expecting prototype for ttc_set_{shutdown|oneshot|periodic}(). Prototype was for ttc_shutdown() instead
> timer-cadence-ttc.c:196: warning: No description found for return value of 'ttc_shutdown'
> timer-cadence-ttc.c:212: warning: No description found for return value of 'ttc_set_periodic'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/clocksource/timer-cadence-ttc.c |   22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff -- a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -69,7 +69,7 @@
>    * @base_addr:	Base address of timer
>    * @freq:	Timer input clock frequency
>    * @clk:	Associated clock source
> - * @clk_rate_change_nb	Notifier block for clock rate changes
> + * @clk_rate_change_nb:	Notifier block for clock rate changes
>    */
>   struct ttc_timer {
>   	void __iomem *base_addr;
> @@ -134,7 +134,7 @@ static void ttc_set_interval(struct ttc_
>    * @irq:	IRQ number of the Timer
>    * @dev_id:	void pointer to the ttc_timer instance
>    *
> - * returns: Always IRQ_HANDLED - success
> + * Returns: Always IRQ_HANDLED - success
>    **/
>   static irqreturn_t ttc_clock_event_interrupt(int irq, void *dev_id)
>   {
> @@ -151,8 +151,9 @@ static irqreturn_t ttc_clock_event_inter
>   
>   /**
>    * __ttc_clocksource_read - Reads the timer counter register
> + * @cs: &clocksource to read from
>    *
> - * returns: Current timer counter register value
> + * Returns: Current timer counter register value
>    **/
>   static u64 __ttc_clocksource_read(struct clocksource *cs)
>   {
> @@ -173,7 +174,7 @@ static u64 notrace ttc_sched_clock_read(
>    * @cycles:	Timer interval ticks
>    * @evt:	Address of clock event instance
>    *
> - * returns: Always 0 - success
> + * Returns: Always %0 - success
>    **/
>   static int ttc_set_next_event(unsigned long cycles,
>   					struct clock_event_device *evt)
> @@ -186,9 +187,12 @@ static int ttc_set_next_event(unsigned l
>   }
>   
>   /**
> - * ttc_set_{shutdown|oneshot|periodic} - Sets the state of timer
> - *
> + * ttc_shutdown - Sets the state of timer
>    * @evt:	Address of clock event instance
> + *
> + * Used for shutdown or oneshot.
> + *
> + * Returns: Always %0 - success
>    **/
>   static int ttc_shutdown(struct clock_event_device *evt)
>   {
> @@ -202,6 +206,12 @@ static int ttc_shutdown(struct clock_eve
>   	return 0;
>   }
>   
> +/**
> + * ttc_set_periodic - Sets the state of timer
> + * @evt:	Address of clock event instance
> + *
> + * Returns: Always %0 - success
> + */
>   static int ttc_set_periodic(struct clock_event_device *evt)
>   {
>   	struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);

Acked-by: Michal Simek <michal.simek@amd.com>
Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
