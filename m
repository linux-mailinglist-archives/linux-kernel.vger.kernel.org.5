Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE47FEF21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345427AbjK3Mbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3Mbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:31:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425C71B3;
        Thu, 30 Nov 2023 04:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEoikunJrgnm2Uj78oCnb65gz0bpOlFoiZZ5qtZMaWXj1QdwaBZ3n1oFQ2dt+290kwr3sInPXagU344+FR5ACkH3PrH4ijBD7lbS/87JVni+azf02KPvos8C2soE5hKrwb5i+YzteqFRY5RVeuIFLLh4J7bTcTVCZU7QGxmt/7dDyJxNfQ4KnDMwELLZz8g1QTVeZkVH+zPBYMXMOEOnbyu58FaC7W27icjWdBy4RI4NjOFGi+ipcPNpXF8n1gLOcEkpu1R1ME2dnWwZdh1dAIQvW5DjstczLqgT04DCsbalWtCU1QJfCkX15VrPLEMuHxt4BunKzcW8Q6t7Ela4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLY6imZlpcFd/2/Q/j0Q9FTyVg1Cj7UY2Gu2cJAB+68=;
 b=KZqyxbfoR/RBIGTxef+w0Dxc09UCDeNSMjHBqdwPiBdBdfptzIkNdax21hN646M8fWHwmJBxJs8+m/DYoceK5rEJMKu7Rd7PtJs4eazJCUF0RmcCaf4lLLK3Jx/mNtaVwwPYIz2D8o1qQmTRVR+T0bhcSksN/zfRbKIG4WPDZOTfcuWZbT5qBnj56ygJJeNXSlAXTaCEC55Vs56lDTZHkBfoAtVPfcaTWcQ3mJVDvSjSoZLrwnalrfcJXN/z3gVdqhycB8kMN7CUpa+ZNul3Ml7oip4fFgN12FlxaR1XHNGFNCZxw2xuQLtveC5fS1WYqvur+xbEuznfXDLek32B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLY6imZlpcFd/2/Q/j0Q9FTyVg1Cj7UY2Gu2cJAB+68=;
 b=q3gAR2pY12LgPTmpOhxouZ2/J5JohS7+g5WLQN1I6YX4HdZT+0LQwKyreJ6yWxPKhsFu8N2B/9Okl3PYxhI7BWhRLNXI47N5Jd81NeeJ9zRCd4oShptDiTi+x0b1KbO313IQOiNiofjPTiOmnDqlZAXKG6uhBOEp8Omqs2c8U18Iyum3+4be9SsYldwFLsRyiuW7WwqAawhj123CFIKxsy2ND4GM5G4Rtu7i3W7Ucu1mkjX+spYaAAlmO0hGlEdSwh787Q1ljVIelg3IigWxKkL7zomYppkMZFtPenkeMlt3NvlQ5QgN8OnrvzOGvr8AE9YjrBwgvHGIWVKEFebJfg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5125.namprd20.prod.outlook.com (2603:10b6:806:251::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 12:31:42 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 12:31:42 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Conor Dooley <conor@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs
Date:   Thu, 30 Nov 2023 20:31:31 +0800
Message-ID: <IA1PR20MB4953AAFDF51FFF198C7F9FCABB82A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAK9=C2UWwHVCvgXG0kNLt86JTk7P6p-EdPLS3F8Z5qnSpCPLkg@mail.gmail.com>
References: <CAK9=C2UWwHVCvgXG0kNLt86JTk7P6p-EdPLS3F8Z5qnSpCPLkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN:  [aKV9JTU2CKlQnxHoIv8eVrUwXrD43LEIwaH8XKrgvYU=]
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231130123132.376154-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a9458a-0453-4543-98f6-08dbf1a04e83
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEOHYi3VgyJmY9kK+MDzBDFOVI/ySTWYmEcNJ1J364oHaCmSsInRiQ+RlzpM0uXK9sxD6ZTA6P8vDFXVxAPPeHx9Ygg8Oas9a7g6g7Xwp9IGsV44z0BNdGsYote7FIr30JnIyNedBxWgWgGtukQNFO/4kzVM9SIYTF09uMu9cD7qy5yXH2+HTIY2csfs2NADvP1NFHsCNqPLIWBtAKqDozQyG0zUUGa7elOMBjZK1fDej5F/VgK2Mx3tqxzxNMj7ARcx2KaBUAoOwVGMsvi/TgwQ6SXqsE4InHL+C0b76DTvXU6QmDHJViwtU4gVe3aWVYzm8IUHHe7KX+E0DQMaucq0CB2e1PIQ6NptUrGARQGSxTs+0GM++u2fXKjMP1gFUdjfYxp/JREj+GuQHfdsno/n5ETEWESfphWZmn4KvnuwYfBWuXzKRiZSLis5Nf+mprBeyKqydqRSS00OSIlx4OGz+T7Xeo1fghz5GC8QSBSLxaLQhUyK03bZvoO3VDrGOqqhGXqZLSqjelc5uhlMSyy8Vi/Ddpan5R/6eJJcbalcmKfIFCTwjI3HkhHsCB3lQqf4BKY6hxxY0LiJnRxHLB1S5Fy0y2Ao4ftF5IKoQP11FNZVPWUoqSmtEd674h1x
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lLNTdxNnJhZE0xMlVVUnJYWGlDa1c3cnVZNGoyUkJPZGxiYkxvaGFwdCta?=
 =?utf-8?B?TllXRDFRS3hmVVNiajFOSGxpRG1RWS9NRXBQNDd4cSs0d1dPbFZLMDg2aHo1?=
 =?utf-8?B?MmpaQmJ6dVJEVklXSzByWHlubzMwdWJzeVlyZUs3TzhPTkJXMC9tMjhTZklt?=
 =?utf-8?B?RGFlWFVFNlJqSGc1aEhTcitUd2JyR1o1Y2lTUCtHazM5WC9CUXZrY3dnVjE5?=
 =?utf-8?B?QmNYbk1ucnNMRGVaOHNDL0wyemcxaGVydUxQMkYwVFNVL3ZOK08vVTZqWEFP?=
 =?utf-8?B?Z0FVTXJNTlRZdTRSaklyQ212K3BPc1hrRk45WGd2RjVxa1p3UzQ5MTV3QkFP?=
 =?utf-8?B?ZHk3cTdJc0lBc3Vvd04vNVpPZkVra3JOd2pVc3VZeVlUZ3ZwU3c0aHF0aFV3?=
 =?utf-8?B?aDY4SnFNZVU1cEliVFdjSGhGVEo1dG1XY3VodEo1bjdpOTVDalJtTytvVGxL?=
 =?utf-8?B?WnhQOFFCaHdTU01wdlUvN3g0UUVIN1FjbElxZVhVZGpScytjSCtNYXJHOVl5?=
 =?utf-8?B?Y0p0aU11a1AyMUU3L0E1M1Bhd1RoL2QvYm9HOTJWeWpQdlhWYjU4M3VhanpY?=
 =?utf-8?B?S3JHR1UxTTlRWExHQ3NCeWJmTzVoMWpqSDZKOXdmNXF6bDRGV0xobCtCNExq?=
 =?utf-8?B?YWhoeGNHc0t6UjVIZDZpSFFqREYvZUsyTFRKS2FzekRGRFZJTjFob2JSeWUr?=
 =?utf-8?B?VmphQ3JidENTK0FJTEVSK1pXVy9uQVp5Uys2ODM0ZU1VUjFYVjRSRm11OTZX?=
 =?utf-8?B?RWxTWTR1MFI2cUVHU1kreGQrcGFFYi9rUEc5RDNVbGZ1Tk85UlkreTNKdTlM?=
 =?utf-8?B?b3lWMVJoWENxUW9qWEpaSW1kWks4OFpRd2ZTSjZnRnY0bGl0dXJrTGI5elQ5?=
 =?utf-8?B?ZVMvYkJDZlcyRU9ySXd6MzBEWVUvU0EvL0tUWjE3bkNZVEF1OUxmUVFoMW8r?=
 =?utf-8?B?OUlvNUZ6c2lYc2NIMURVUkNQTlNlcHpxU0ZrL1ZQeXhKR1VKVGNocllQeEI4?=
 =?utf-8?B?MmdLaUhQaVN1R0R6TnVDU3BoK3BtOVB0UnpQRXQycE9sem55NmxzU05TYjJH?=
 =?utf-8?B?SHpzOFJSWGNnUHMzUWZ5ajZ1NlZVdVQvcVJzM0lKUmRMYStiQml2WmFxYTVr?=
 =?utf-8?B?TVU5Z08xRUNKeG03VnAzVXUvOTFEQlhaZXB0NGJnK2F3OFVRNlVCckJIS3Z2?=
 =?utf-8?B?a3JVN3ZQaHFwUzFnRnlPcHRnUGl4d08xTGJ4bkliaWhPbnhnWFBHVVFxZ01t?=
 =?utf-8?B?bkR5V1hKWFZueFRvYk1HeHNqRjgvTnQ0MWdqVXZDdXMwZHFDSW8wcCsvSWMr?=
 =?utf-8?B?MzlNeHBDVG9wQjcwcHh4Q1orcHF4WjNDOGs4WEdzRlptZlBkRTZVQnRPN1dP?=
 =?utf-8?B?M0FBaDZvNnNraStzN0NHRE5EWHFYbFNTTlphckVramI0Qkxxd3BGZHgxL1g4?=
 =?utf-8?B?Mms1ditmcktmRkdENkJsZGRCdldoU09wNlJGYWxkUHR5RzlKd04xNURnd1o3?=
 =?utf-8?B?VW5wQmdxZ2hWeEFZeXRSb2JBZjhrN0x2b0J6NitiR0k3UDQ3UFVFWDVwR1E3?=
 =?utf-8?B?VlJyczRhaVFNSkx3cEhyWlhFTkJwUzZUV1AwWmNWSUVuZGlJQnoyamIzcmI2?=
 =?utf-8?Q?qIlIEIStWkbdpAAlnIYg7SKd+BvMrEdE8lo+UxZ0TOXA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a9458a-0453-4543-98f6-08dbf1a04e83
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 12:31:41.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Nov 30, 2023 at 5:40 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Thu, Nov 30, 2023 at 05:18:15PM +0530, Anup Patel wrote:
>>> On Thu, Nov 30, 2023 at 5:15 PM Conor Dooley <conor@kernel.org> wrote:
>>
>>>>> and add separate "riscv" prefixed DT binding for RISC-V mtimer.
>>>>
>>>> Do you know of any users for a "riscv,mtimer" binding that are not
>>>> covered by existing bindings for the clint?
>>>
>>> Ventana Veyron-v1 implements a mtimer per-cluster (or chiplet)
>>> which is compatible to "riscv,mtimer" (i.e. we have both mtime
>>> and mtimecmp MMIO registers).
>>
>> Okay, thanks. I guess iff veyron-v1 DT support shows up (or other
>> similar devices) we can go ahead with a "riscv,mtimer" binding then.
>> I had thought that you guys were going to be using ACPI though, so
>> I guess the "other similar devices" applies.
>
>We use ACPI from EDK2 onwards in our boot-flow. The booting
>stages prior to EDK2 (such as OpenSBI) use DT. In fact, EDK2
>also uses information in DT to populate static parts of the ACPI
>table.
>

Yes, And the EDK2 implement of sg2042 shares the same boot flow, which is
already in the mainline EDK2 repo.

>Regards,
>Anup
>
