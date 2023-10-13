Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080127C8148
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjJMJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjJMJBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:01:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2089.outbound.protection.outlook.com [40.92.19.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4762F10DC;
        Fri, 13 Oct 2023 02:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd8CAuU9v/hTOzyvsj0fdB+3jBWFGvHG/p4qIHtOf3exIhg+1KYSIjnjBI8I3dgKETKqZ/IAGBFsdGhE72eiNWjAUe9y5LftD9uQ1uXTlO8iA7waSLh0oeuzKebiM5RKZuFeYDk2gGCqQ/TySa2EczEO/S+OMmqsrycqyBpFMLMLSyg23kT6H1i7HOo3trERDK/CjDFhvxxI5547Ja++Wn3k1Jt/L4dtmegrmgA4Kh+rqO4mt8UwlnmraNLp1s3lUnQ/VYF4ZQ3c1/F/qc+1EAto9B4JehWTtWERILK2iMIKpGQ92ehHtQCnAzoArf+3ldhrKonMUuwGafPvldU+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60D7mn+8FxRb1u3SLmCs4hXDwyMJ6PKH1RJiWuNLrE4=;
 b=TxqIWSpkpAEeS8CurjCZ5RUVRdu+0LBBby5Lze3BIVh2Q6vqO3Ou4piL7torgd3nI8ZpbrsmxcBxbaE23YtRWl3rgp9iE/3JtuJQoyp5SnLnqU1t+zDqCfardh4ydNfhDjUlJxI1tchxv9r3UxGa7Bw1UoaVa0zEr+i3tpQUo2AAW9pf5CeXtyqMELsDFFOl+7UO1ZONBlDSMd7R+9u8b7y9PPOCnKxd45dvYFlWMCizS48LmJQM/jwZkKlVCBKrNCa8E/ZTVa5ott+DjUoiNTrdnKyD/bDIFP5BgBly8q5IRI0tfOm3SWT0zG7S7OFw3hdaDRpB1ArwT0K1UJoW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60D7mn+8FxRb1u3SLmCs4hXDwyMJ6PKH1RJiWuNLrE4=;
 b=BE4GViW7sxkqUejWT9fUXLvk4pWxOgzrA3oAIM9QwEc7YAqP6Fp9WKK2AlSQRUk3oXz4oYo4FB/PbgGweEOJUetL9TQ3MOGTsehWYxIX2aFqek5aAdb8h/tnun/DnikA+Io9sc+oWp6q9CViviwCiGw9+txcYkZPVFq9o79AF+lNIjAXMp2EQazM5yMFRdQoZU547EMDJE83N0h7MRdS/VKZXjxEL74qB0iM7FAnGmhAfeP51ifCRoLZz1bX062/72CRCmAYDiIqh/js91ij6ZSBEVPvjwX5qIu7i06YaNXlrUUQgPFLwuFTbooRM0wCcfciwylTw5n9G6P6yNtqLA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5347.namprd20.prod.outlook.com (2603:10b6:806:24e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 09:00:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 09:00:17 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Inochi Amaoto <inochiama@outlook.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/7] Add Huashan Pi board support
Date:   Fri, 13 Oct 2023 17:00:15 +0800
Message-ID: <IA1PR20MB4953978B9C2C905DBD135507BBD2A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <c3920f4e-9e93-4a33-b3af-cc30cf6c1fe3@linaro.org>
References: <c3920f4e-9e93-4a33-b3af-cc30cf6c1fe3@linaro.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PIFFmjxz+frZ2Olbr2cXNFT7N3s7ywS9xEwDSOkSZPU=]
X-ClientProxiedBy: BY5PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231013090015.143002-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 838b3660-9057-4e96-180b-08dbcbcad19c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e7dSCHKPKDDl8BoB+zWUMKjU+WWiH3xHFsMME5dEH/ic1VKkS/Psr/8yXtDsmGMdzPdDsuK9WXWjoX/sQOKkPl+sTy3gr9r6/jNwEDMMmLwf3XRYZ1OnxbHCAfiGluyv37DYhi+rR6C/zX8PHK99LeRXpDTern1d7JEy8dlL/qt8nkhC30hWYK8tHWJT8O7ZPYokbHkyRi+BXsVgCQjX6lDhB+ho1SryWXjGKypGeah9A8/8TXBeCAnqsQdIthQw+Q4Ik+0PebqOYYbe6IazbuDLWeDQpcqiRM2QKTX8FaxKwtjiUiqNYiWix7h29KlDsAMiW52noXQlIeX2CJysPPvaTFGMC+VkdHA+lCA5LV2KXFLWClfXcHZp4vqZE8mI7DE64AHmCZI7KvqHza6Hlb8o7qjZvoak7/PBjr3S0ONOHK1Aar055HVfcoUojaMQnX3WOVqWiua8f+HTetWABgDw3Vt1552CGH5aiiMCDs+kro0BSyNAZib2Vn/Gv/Qrxuc1l0vbs7UQUUmUusBvw12UGwEVL29qWAoiJ1oynWemrkU5oG/vecoHtoDyAqfe/otp8Xiar0jl3dq3vTIFQK69jcz05W+bOTHZPOF1Im85rWE8c9doJno2TaYRhBO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9LE4bq7mm8hyB2YVlG+i3nzO0WC027gENxBcNtDHFz/SEZw775JNkqgQqeu?=
 =?us-ascii?Q?5VDP098x2ODaaJN1V43CDVB5qMx5eQoihfWErBn8Fvrcvvy/fioIUJbamPyR?=
 =?us-ascii?Q?Vlc31iPo31T1lmEl+WdEHqwJkw2idcgjXQHMsCrL2FdC6NAsEWx4PfO0fqn2?=
 =?us-ascii?Q?jusN+rwQhxPST+OhVcMBtbK6QpQHNxUk4uc4BkmrmE1yH8SqYN1mjS7jA/a4?=
 =?us-ascii?Q?VfPg+DmBzBoh2f9CLoly9aYgxIBs0lo81n3FhsJ5UgYqtzziRNhkSHXNbKvf?=
 =?us-ascii?Q?NF/YmXgaMT6D3KP31oDKb++50DO4kz+c/LVmBUmqd8NnqSBnks2P6ufqDfL2?=
 =?us-ascii?Q?+vkejx3VRR8ondAu7mw6UyRkIY+QBm44sGRSD/BWRxZaiwtm78+FAf2JEcY1?=
 =?us-ascii?Q?2iyCh5qi1xWk7FaP+robpxu+RrwRffYXbouZ8j3GuIGs7uVCbSx2bv+6HNpP?=
 =?us-ascii?Q?fIkJkW1rHajcnEKd2QmuMsxH6m0CzxcD8N83Py3qJhtLoZmatONUweKNrWbF?=
 =?us-ascii?Q?v2z4P6dkjJZvNhEMt/827kJpCS9nAlKJQuSY1gB/27PTOoF8aCsc+MjaFVr5?=
 =?us-ascii?Q?0gJWKHzjMML0ZJgWDLQW2Qc07eGchp83FdJeBnKwbIREjDnUnh8JtrSF+xy1?=
 =?us-ascii?Q?KuBcjXQljS/5AZVDXmaKJvineaSUltBfE0rqIrJgVjWVG6EdvE2SAcfwLBou?=
 =?us-ascii?Q?zCOoPA9f5C1piZIT4hRJYtenhqQpwHtpyXjRbW2/vs9QFfgPI6dZYqMpmC4K?=
 =?us-ascii?Q?nwjnmPbH5Sva76wpokU9PVopTKQ4wTrZ1X0bO4CWtROsGJ+F7eYroEGHJdUS?=
 =?us-ascii?Q?WxAJFpDxmvswHWbeCo1s1KGVNxncTDaQ6pH5YJ2CoytfButS9vX6UNzjhfsq?=
 =?us-ascii?Q?sydlLNsn+vm8yGgXwxC3lYssDt5Udm44eI4MpVov1iTlu2LMNmAnuV+dpTZr?=
 =?us-ascii?Q?LXTr18d2IwbRhS07R0ddccj/n0JnLu93nEqdFZENoyezmkvq6Vb5/verPt4P?=
 =?us-ascii?Q?WeWZ+MdM+z6ATG4Ge6enkMS+Ti+wccEcHajySw+8imDPSK4dUn+O8K+zRFyT?=
 =?us-ascii?Q?KKBBHZtinIU5zYDtPvhbD2qA746L1ouESckP6w5qgBeT85t/MAbkmhHxMYdN?=
 =?us-ascii?Q?sdyx1JQ1U5rnUgoV01tzPRpVvAhC0DE/mXMtoQdHx7+3EgDC6ABS42vBby6F?=
 =?us-ascii?Q?e7WBPb9AXZNDa6yFYUNA4V4d0b6V8dGKCeyNXQYi2E3Fwe0F6l2stTlL8lE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838b3660-9057-4e96-180b-08dbcbcad19c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 09:00:17.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 09/10/2023 13:25, Inochi Amaoto wrote:
>> Huashan Pi board is an embedded development platform based on the
>> CV1812H chip. Add minimal device tree files for this board.
>> Currently, it can boot to a basic shell.
>>
>> NOTE: this series is based on the Jisheng's Milk-V Duo patch.
>
>Which is? This must be clear dependency - lore link.
>
>Best regards,
>Krzysztof

https://lore.kernel.org/linux-riscv/c3920f4e-9e93-4a33-b3af-cc30cf6c1fe3@linaro.org/
AFAIK, this is already merged.
