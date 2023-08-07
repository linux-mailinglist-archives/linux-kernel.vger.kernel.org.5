Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD07D77295C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHGPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHGPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:36:12 -0400
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB94A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691422571;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gTPdEMAHqSMNznZZsX8VhGpT0RrYt4PNdlo7vSUEIfM=;
  b=D1j66RxFXB5/k7h7Kzx6rUrTnWW+hNOO1KRNChbNBmwxpZ1Ci3ukv25n
   mNgrMDuPpwVnon7s3H0EEDR+F/Ix9oa0OVKzSD2YGueoNN5Qo80zpaZ5m
   vkdw69ls6a8Ksf2LMyCzSfWRq5gVepPdje9mX4TOZc4K7lrZn9oa3z+j5
   0=;
X-IronPort-RemoteIP: 104.47.55.101
X-IronPort-MID: 118620124
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:H1IVW6tmn7AqTV8rIbtLq4Gp3OfnVLBeMUV32f8akzHdYApBsoF/q
 tZmKT2HbqqCM2L9Kd9/PYm3/B9QvJWDnIRlGQVo+C9jHylE+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Vv0gnRkPaoQ5A+GyCFMZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwJw1cUjy6oOON67vhEPNd2JomE8/nFdZK0p1g5Wmx4fcOZ7nmGv2PwOACmTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osjf60aIO9lt+iHK25mm6xo
 G7c8nu/KRYdLNGFkhKO8262h/+JliT+MG4XPOThpqAw2ATJmgT/DjUKD0bgrPLmyXehStUHM
 xQap3sTsbIboRnDot7VGkfQTGS/lgYRR9dKAcU77g+Xw6bZ6grfAXILJhZZYcEiscQ1bT8nz
 FmEm5XuHzMHmKeISDSP9r6SohuzPzQYKSkJYipsZQgM5Z/noYg1gTrLT9B+AOi0iMH4HXf7x
 DXihCsmnbwPgMMIkaOy7FnEqzupqt7CSQtdzh7QXmOhqAZ0ZJKsT42u9VXfq/1HKe6xS1iCs
 XwAltm26eEFF5aWkyKRBu4KGdmB6fuDP3vAiFhgN5gn6zmpvXWkeOh47DB7JVtzM4AfeCHgZ
 k7YuStR/JIVN3yvBYdtapP3C9kjy6fIHNHpEPvTa7Jma4JzfQmv+CBoeF7W3mbxnUxqmqY6U
 b+HccGpBG1cDalhwDO9RPY12LongCs5wAv7VcCl5xeqy7yTYDiSU7htGF+PaP0pqaCJugPY9
 /5BOMaQjRZSSuvzZm/Q64F7BUwFKWgTAZHwttBNceiCMkxqFQkJCfDLxqg6U5d4hKkTneDNl
 lm0XENJ4Fv5i2fOJQiDZjZkcryHYHpkhXcyPChpOEny3XEmON6r9P1GL8JxeqQ7/ut+y/IyV
 +MCZ8iLHvVITHLA5igZap7+6odlcXxHmD6zAsZsWxBnF7YIeuAD0oWMktfHnMXWMheKiA==
IronPort-HdrOrdr: A9a23:GufaaqyQr36+dGG5unNfKrPxSugkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67SdC9qADnhPlICO4qTMqftWjdyRGVxeRZgbcKrAeQeBEWmtQtsJ
 uINpIOc+EYbmIK8/oSgjPZLz9I+rDunsGVbKXlvg9QpGlRGt5dBmxCe2Km+yNNNW977NYCZf
 ihDp0tnUvdRZ1bVLXzOlA1G8z44/HbnpPvZhALQzYh9Qm1lDutrJLqDhSC2R8acjVXhZMv63
 LMnQDV7riq96jT8G6Q60bjq7Bt3PfxwNpKA8KBzuATNzXXkw6tIKhxRrGYuzgxgee3rHInis
 PFrRsMN9l6r1nRYma2ix3w3BSI6kdl11bSjXujxVfzq83wQzw3T+JHmIJiaxPcr24tpst13q
 5n13+Q88M/N2KKoA3No/zzEz16nEu9pnQv1cYVknxkSIMbLJtct5YW8k95GIoJWAj69IckOu
 9zC9y03ocfTXqqK1Ti+kV/yt2lWXo+Wj+AX0g5o8SQlwNbmXhopnFosPA3rzMlztYQWpNE7+
 PLPuBDj7dVVPIbaqp7GaMoXda3Inale2OMDEuiZXDcUI0XMXPErJD6pJ8v4vuxRZAOxJwu3L
 zcTVJjs3IocU6GM7zB4HRyyGGPfIyBZ0Wu9ikHjKIJ/4EUBYCbfhFrcWpe0/dJ+J4kc4nms/
 XaAuMiPxasFxqoJW9z5XyMZ3BjEwhubCQrgKdKZ7uvmLO9FmS4jJ2sTN/jYJzQLB0DZkTTRl
 M+YRmbHrQz0qnsYA61vCTs
X-Talos-CUID: 9a23:+58GG2y3QDxLANjfInllBgUbJ5EZXkT6zUz7KhXiE1c3FriqT1O5rfY=
X-Talos-MUID: 9a23:2hasMASXh3cfjXFORXTw3iw5Ocw3oJ2xGUdVic0I5pi5KTZZbmI=
X-IronPort-AV: E=Sophos;i="6.01,262,1684814400"; 
   d="scan'208";a="118620124"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 11:36:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOiZ38M6uX7/Up8o0TRJuflpco73wYeEcX/I97GXqNMXVaKf5gFaqHguZzO3ifNuYgFbFKTQRZx3NKljHATFU27ZplCzZXJltJO3W6pNbwWTy4Hwb/AYcMm0mHOFUf27cdDAUAXYOw9eI8FRhatz6azEbCYwZWIyu+BN1pvKifs0QErDVIY9bTtn/cB7ycpVE3kHpm6zYuNVBOlDSYyw0WHeHZISv23rqGqSmhyjotEEC7vnZbHuR+wyHObf+9eAXKfGOrrFKrI7BnIGHUbSVTkjTPKT3U/s+CWR0nXavvFmlsHbh44s5oBszJqiXTJwm6pfm7+hGCrz9ZJtkOHHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTPdEMAHqSMNznZZsX8VhGpT0RrYt4PNdlo7vSUEIfM=;
 b=h7Rh0uODDncqIj9apt9e9fnUCIZJAEacmn02HPAQBY9sQmfgCq7bMvkl+j40XZ1GQpU9tSrlKP1HWm8x7+HU6DmpidkH94ZvqjJ1lnqnkt7qB9VLvHrmgtyq/3jC7X3wnXQAKkgK7RoE+1jTvvghBagW3xVeQ+99I5PeqE8jWS/hrzXRzvePF4WfvAMOuu44MjPV2mVzoN3rl5KRy0Ql2qMv9R0TGOIKjtdamasu71dy5bjLGiSGUHoB7VUJiA8f9LRyL2/rOEG7rLWDAne+HqXc5lLlN0Q0a7hi7IwyWEJDYBc+u218Zr6t35+D0fl2IXym/fCKLxenb1I0UssPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTPdEMAHqSMNznZZsX8VhGpT0RrYt4PNdlo7vSUEIfM=;
 b=TwhtqXwp6Fo7GxnVyS83F8paUalVq1Wsy1YsC0B1ucjhVh+KHOGaR8DhI986keMKbHkOib89eCJcUH0r8mQ/IYtJtHDpidAC8o4AArFeeIDwM+iY2pgDnzRsuxoHixvYOdG3qi0etNkKPyPQm3HQXazSRC3fdteQ3eHfII3ajiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH7PR03MB7193.namprd03.prod.outlook.com (2603:10b6:510:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 15:36:04 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:36:03 +0000
Message-ID: <d56da35a-e30b-b118-886f-add6f500d85e@citrix.com>
Date:   Mon, 7 Aug 2023 16:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [patch 25/53] x86/acpi: Use new APIC registration functions
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
 <20230807135027.744726431@linutronix.de>
 <20230807152706.GC569857@hirez.programming.kicks-ass.net>
In-Reply-To: <20230807152706.GC569857@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH7PR03MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 84324702-1138-4905-5618-08db975c021a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9gytQeITHIEJ1WogN79jL8BnSKIjWf54EMdvmnMs7A1//L1p/q6sMAX6RkPQOr/7z25SwYtjN2KRLFX5AH4kz/IR6Q4XBzzKBcAdWzLUqrQ58ohuWUEqme+jxOmhO2CdvM2DuQRUL5QQ0j32EIxv2ms0JbbgquKXiEfQX6uPiPoIPz4a2Y6IF+bv7oZaz2WSz4z3O6lSeEUcCg8aZMUnARyoftZWmf4QMS1JpK36QaHv0VbSmbCMc+nc7UhBfAcKjpeify03eqSuVJMs7R2GWhHLZKjtILvgagyvCMyqKury7pQplF+PbhNymQf/pdrxuIKWngbeZ+O5TpGDG5MZRMfR+k7sFUc+CEh7KWgoZgQtS7n5hyVU6paWDqVNU+YtCzrPlkAxmhZ0viEE8Ih53N94EFCydUK/ct03V+mDVf+voRE9l8T+tmgTlVXHtF6bhmdRd6EmUcqb8oBXJwYYGnc3jKbisQYhLg0YHHideUh2c+7wljTv4w5XXQBoe7tdakrIeOGxrjXgK3jB184Rmw7XHTDATgfDNhnhhyoxvWMMmGzENGwcrdvBuU4g5e+t4/rWthT3WpaQ99ZFNUI3jmfSYvpRCgIcnJehW9o7P71BRxwwneIJ3XzawyJylkncVt5bTkiZx1uTWkizAMyWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(1800799003)(186006)(2616005)(6486002)(6666004)(478600001)(31696002)(6512007)(82960400001)(86362001)(26005)(36756003)(6506007)(53546011)(41300700001)(4744005)(5660300002)(8936002)(316002)(8676002)(7416002)(54906003)(110136005)(2906002)(4326008)(66476007)(66556008)(66946007)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW8rV3h3UXlxN0hPbkIwS2x4VXhaNUp5UHNxVnpRVFhmaXplU2UwMmF3MkZm?=
 =?utf-8?B?RjdDd3JsQ3dBU3g5MjhQbjZ5VWlDMWY2bVl1Y2JEeklJT2xuYW1KZnZkQ2oy?=
 =?utf-8?B?RHo0Um5lWTlsRW9RNDBXdmJ4QzZBYVY2R1RoL2xZaUY3cUl6cDVPc00rK3Zi?=
 =?utf-8?B?blJlNHlyTzduNEl5TXEzNnZScTFVVTVLSWpIdlhjUCsxWUZSN0tFMzBzbXdH?=
 =?utf-8?B?VERYaytYSXpIa3BBSHMvTEF1cmJTdXAvWW9kZTNGMk1IYktqVUYxV1dab0Vs?=
 =?utf-8?B?SzJhSmRrMytsSHl2a0NCNHRUQmx3SFNWT1VZLzVxcmV3YnQxSjljdnBLZDBu?=
 =?utf-8?B?MmNtVTNTSm5BNnloSTJTTlJnd3FDeUZBbExIODVjNm5hOVRoUXE1aGxkWGZa?=
 =?utf-8?B?TzBZYWhmRlgxSEVDMy96YWsrOENualJIRWZTaEx4L2RPUGZBWnYxV09qWUpx?=
 =?utf-8?B?WW5UTDVZRmVDYzVzQ3V5QW1hVUhSUmVSemNVRjNBcXBjemVRMzlvSUlHZGsy?=
 =?utf-8?B?aDFYbnh0Z2RFeHZtOTAzWjFLOGJyOXNiVmlDN3VFRlVKNUtjbVFDTnI1ODFa?=
 =?utf-8?B?UTUyZmpuL2huNTJUUXVxMmIwdzRFS0FUUUt4dm5ua2tLdlBrQ3ZqeHBWV2t3?=
 =?utf-8?B?eGVXOXpZUk1TdFdsaW9Ed0lGTTgyajVhL0dLR2ErSVVSZEZlZkVYTTFXVmJa?=
 =?utf-8?B?VHkvUTR4ZUhqWkUxMjduekdUQWYwb0JJT2xHZ3dUOGtTcU1pa1RlWlNiUExV?=
 =?utf-8?B?SURSK3dMQk9PeERjTERITVhzRVJjVVZVQUdOejM3UVR6RUF5QS9HdFRqcGx6?=
 =?utf-8?B?aWZTaWdyMTVmVTdRWXVSa3Fqd3lXTW9Ud2FFSnJ6eHRNc21hcmNCYlovbVNj?=
 =?utf-8?B?c0Q5MEg1ZWJCMTBjcUxLcnpEaTAxYWh6Z0pjNXUwYk9IckgxWUJObSswWXI3?=
 =?utf-8?B?Znk0dnlQdzZEd3hNblMvV0gxa0gxRzNHOWVVZzlCS1NJWnF3RG9lVWVOYmlO?=
 =?utf-8?B?K1pLOHJWQjBnTDdxRHVYTHlnYUdTdis0UUlLNkNBNTM3MkJDMENqbWNrWXVL?=
 =?utf-8?B?K0NWRk5UeEV3MTNxallLekoyYWV1QkJUcTR4RjdVRGVyVDZEeS82d2ZYYTFK?=
 =?utf-8?B?cUI1U3VUN2d3aDMxUGN5S1Bkb1NsZ0llbFdKaGluUjhvMkEvRzdkVHZnOTRz?=
 =?utf-8?B?L280a1RvMzhQc2tXM1h2NTlhc3pxU1ZiNHc2Ylh1TDdtTjVEZWovZlVQcXNn?=
 =?utf-8?B?WnZYVjNDaWFxVnMzMXNSeFd4MmtRaS9tKyt5MXJxT25MQ3FCL2NMZ05jYmZv?=
 =?utf-8?B?d0V6aWVSVTlRMllQd3JHSUo4dHdWbHhpN1FzMU55RGhpMDJ4S2U4c1RHbUNY?=
 =?utf-8?B?ZUc2NFdIRnJDdjcyeTBQVy9FYkkvenNOYW43YVhyVjR6S09WeThmODFxQU9i?=
 =?utf-8?B?RkM0MUl1dDZ4Nk5UcTJ0bWI5VUhYSjZDaGdhUFlHaU1hZkpFV21sdFpPRk1q?=
 =?utf-8?B?Z0J2SWptVmxaQi9DNUdBeU91cUNkNzE5VXBtei85eGpkRko2REFSSGFjTTlh?=
 =?utf-8?B?UWxpRlE3WlRoVjFLcHFpTnhiK2RBd3lNUXVUeWZqbGFZSDdUekJJNnBTcGJ1?=
 =?utf-8?B?NWl2ejBUWVNaQ1VwRHhiUUVOaUJRc0tRbkN0K0tSQksvSi9aSUZSQ3BCZHdz?=
 =?utf-8?B?RlBrMVpydWFUQUtRK1djZWdmLzI3dGJaZFh2MGZmV3pEUVlKNjBVcVRIVUVS?=
 =?utf-8?B?NDJvMSt0ZC81Yjltd3RYSHlESlF6NDVJamVVK0ZpS1ZSWjYxS0JvRDlUeUM4?=
 =?utf-8?B?aFlmeVRCc2hRbUxSQm1HV0txci9kTDB1WjdWSktjYW9hQWp2bnl5UzRkM0RG?=
 =?utf-8?B?cjJBT0NMSFhaMk5qZTYvUzh6eEFKSnBZWEYwTzJveUtPbTdwVC9reXdmOE0x?=
 =?utf-8?B?Q2dDQ1dIWndlMXhxMkZlZm5kY3E1Y3RadG9XYk91MytENmwxeXg1RVJLZXZp?=
 =?utf-8?B?Z3g0d1RjaUJrQklQQi9saGdyc256YmU4K21VcXN3ZWRSUUw5YkowSFE5VXF6?=
 =?utf-8?B?RDRTa3FSZWdWZ0hONE5zNDhScWdMd2xpelI3NFNjNSs3YUNXQWR4MmlTb3Aw?=
 =?utf-8?B?ZndadXZKbTl2emRPaUNKZ2FhdWFDU0NMUUhXUGlmOURTZFRMRkUzQWZnN2JU?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eXRDNWlyL1JJbFlIZGVrakU0QzI2YWlvcDJCWXZ3T0VCYURRL09aU1lEd0VK?=
 =?utf-8?B?bW42RTRFRzNOdWN0aHVOK3NuTkI2cHB2UzI5M2thcXN2d1U4NllUSmtSc3pN?=
 =?utf-8?B?cXB3MlNUMDZIWk8zVlJUSDRXUElGdnpZVkNwZlBxQk5ZdmlrcGtvVkJyM1BE?=
 =?utf-8?B?UDVyTUZONVEwRm04RUZJTG1CZllMT3lVS1VBLzIrUW81eGpNNHdrUWZhR1Ba?=
 =?utf-8?B?b1haVmxSTnI2dERpZ1R0VzZ3V25pQzE3VFlXTFlnL3A0WE83QTRHd0xyN0tY?=
 =?utf-8?B?cWxpSXhPZkZwZmxDRU5SdTJEZVRMbmpna2JpaTIxeFZxcW5tMllQV0FaKzE0?=
 =?utf-8?B?d3gwMmRCYTlTUWdQSTFCa0hIVVdEcnhNdUxmWHdNbkdxQXdhdnJPV2RKR1pm?=
 =?utf-8?B?d09UMFBmaVoraFhuWEM1M29pb1IrVGpVSGtYekt6ZHhCa1VIRkRIL0dsS0ly?=
 =?utf-8?B?WWxVa3k4ZDAyRURXcWM2UXFkUk5tQWxZZ0pOUmMyS2IvaUU0dTZZQ3U3OXpJ?=
 =?utf-8?B?dnpXcUZtQTE3b0MyYjl3cUtOVk9uVi9WZHZFL21DRWxHTjd2cmlMeHlIam5W?=
 =?utf-8?B?MkhQY2NaZm9vN2o5cnV6VEw0d2k0Mk5yaVZGeFFyWGNMQVcxSzh4ZDIvelVM?=
 =?utf-8?B?dmt3M3EwVFNNYzRpWDRGb1FvM1h6U0diMFZjY2F0V3JrV1IvYnhwWmJ1bXFN?=
 =?utf-8?B?aVY5ZUdwWnZZeG1sVGZGK2M0T3J2azVCZ29idFRxK3BJWGhHckN3Um82eFFs?=
 =?utf-8?B?MFBKQnZsVXk0Ynh3Y2pJWTdvYUc4ZVl5blpjUmlMcHFqSGRpT1lQanhjUXdi?=
 =?utf-8?B?ZitNQVVhZVVXRjRSeVkva1FHb2t2b3dEQ1lwRHFFRUxVc3NFUTd5S1JQNzAw?=
 =?utf-8?B?OVJIMkZyN0x1eEJBRWd6OUs5TWUzRU55Mm05Ti9KdDBTbUtROE83N2pxWG9l?=
 =?utf-8?B?cVFvUE9MN3MwWWZnQ3ZvdjJrMkZEOXBmcWNCVEhBY2xIYU1hK1U4VFovQVhx?=
 =?utf-8?B?QUVXMGZHQXUrcGdkRVdoOGwvbGdiZlBMQ3dUMnNHdURmTGJzQ3BNS24rN3g3?=
 =?utf-8?B?WVNJRFZOZjJTb3ZrNS83N0pyUlA2dCtmVmREK0JVSXdHN2wvYUt2dGVpcHll?=
 =?utf-8?B?dGYwUUNZaU9CR25VdGV0ZEZqYTZvRUQ1MnNWdWZVWW55dGVScWUvL3BrQlFT?=
 =?utf-8?B?Y0lINlFpS2hOazJBR2pWVWt3WnR2OTBjSFczVVo5NTZEK0dHU3FEVVBaMlVR?=
 =?utf-8?B?NkNMWExCT2NlZnZzVE4ybmNVSU83cE1PVlpBSmtHcmxXK2UybDdoWUt5NDMw?=
 =?utf-8?B?dkc5dGw3Q204MW4rbWlPbE0rRk9DaGJQSW1EM1o4eC9IY0lxS2VLTFNpYzNt?=
 =?utf-8?Q?gWOO6Btlq9WO2MeZIFrdgMOurcdRS198=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84324702-1138-4905-5618-08db975c021a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:36:03.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWFolSolnpAI7XHe77Yp68pI/gZ3lTVNp2zOd8lYTpIyoTZeLEqa/r/2TR1ExzIYnRB1k3ctujtvuf5kaoyksQSuyItMsb+yWvEt6ecZ3Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7193
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 4:27 pm, Peter Zijlstra wrote:
> On Mon, Aug 07, 2023 at 03:53:12PM +0200, Thomas Gleixner wrote:
>> +static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
> just stating on the record what I said during review last week: whoever
> caused these APIC and ACPI names to go together was a sadist.

My feedback was surprisingly similar.

I still look at that and think it ought to fail to compile.

~Andrew
