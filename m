Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADD7E8100
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbjKJSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjKJSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:17:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76033821A;
        Fri, 10 Nov 2023 05:54:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAC6vh6020650;
        Fri, 10 Nov 2023 13:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l3dA5V2r0fu/84VjGdOLF9O2dAjwaJ7ZO9B39VuW9as=;
 b=JRe0al1ko3JdFF49527r1jOABXix8ZvAkbqI7rQ6VAHlYY6I9lJgSXmj6pGK4J18XHZm
 SKYLlT15+hbGUt8nvRke1tveSn20b9oFLNZ0Q3HQ4JtuVsfu63NFzoGDYDFLv4FhBv5y
 sFAXuWJzqfXNIBtHXF6hxPOxlMESmXpinGJZOlqELXHjc9hq4bxEw6nKJV3c5b89wcgH
 D+4VDpqDXwzTBMqzfG4sjcr6X4Rwlr7I2Gj0mKRU3rxIcpwUMY9PfU83jsR+NuEAeu0b
 L9N9tp4yrIHhqZr0J0rFTQ4o8EpyTaVoOl84TCjjZf50rFwALygJmIQesSzpUzEQEG13 mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w226e0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 13:54:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AADSolQ010967;
        Fri, 10 Nov 2023 13:54:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1xxee9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 13:54:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvWC/fiVpQOO7weKGLn8L8IDsYxr5xvhHQScMRtuikh/BZWGPo9T09ku8j4DmKCIUuMDhpvA9aHv4CDNwVFpx+UhvKy/okyfhiue59C17PmGwC57MqKCvflL6ILJLePAiXKFcNCqyMgFQOKevesdFLLbcyBhrKlKXBqrAbibUV8ZAmVAeY/a4Ephg3L1IgiWkAhDeOcgQqIucPcV08T+92REkOQwWD+N4G0AmZ3QGXbyG/JTFyY7mnSpm2cgnnkU6QZA2rRnVGglh6zzE12ij1Y42h+jhWClcuP2NqnQkIVjOZmnHi0JwA7H15ztrqUzxgpY339TCyHepfg3ibI7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3dA5V2r0fu/84VjGdOLF9O2dAjwaJ7ZO9B39VuW9as=;
 b=FM+B20yTSZSDv2Wxy0yagX712D9fwnPv+bB85SNb43qGWQa5YlRiK3QSBPFb8GN23r1DDy7Mxavw5rioqqJfHFQlQXfFZ+6OZkBZTasB7uJK2HWVJ335SS6kbrX1daGi4k18EwfrWOsSoSnTZjyN7R/oiheOgnTjbGWlCLsWeePgjmy7R38wVPrEi3gwztZKjs4jmF3GpyjeT9moleRlKMMRV6gfKh2KBMBsF0Yv/nz36R2BvITrBY/jpKtHHKhz1RDOCL0qPCCbZJTfmjmq1altn7In1+b9yh+O047j7HX66jBwvxlpGbO2l7yEDForiHM6DquJTeHNzsrbC77vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3dA5V2r0fu/84VjGdOLF9O2dAjwaJ7ZO9B39VuW9as=;
 b=f3ESVPrZhgR2izDyfGdyOuq+GatNGCGb+o8/E+AACe4zyLKW4YOQbBG0pUMZBs1uQmjAN6Cs0D8rgAsACTkmn7/aGOp9GA9jbgXjweUu8EivHBhihtiKQ/boMDf2bYeweizi+bsrk13bxoaTKPsjVL4zBxhMTFoqL4ujmEeBF94=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 13:54:10 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 13:54:10 +0000
Message-ID: <2471a906-1211-4784-ac49-24f5ff313cc4@oracle.com>
Date:   Fri, 10 Nov 2023 19:24:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Fix error handling in
 hp_add_other_attributes()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com,
        kernel test robot <lkp@intel.com>
References: <20231110090408.3383881-1-harshit.m.mogalapalli@oracle.com>
 <e8f9ec8d-8920-2334-62d9-bb522f5e3a63@linux.intel.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <e8f9ec8d-8920-2334-62d9-bb522f5e3a63@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f847c1a-2e5d-431b-b272-08dbe1f48393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcA24LqL9l2xT4PCGTHOFqQfNChJv7gDWSb8EJrSFjFaBwJW1Tob314yVgy5GI1XGZxpjqixpH9Xun+A2llKNszEciVD33lpNmkN8QcvvWdtPGI/AIBkhVVb7R2oyf9dUfRQSW21VO+UgBfncw/frO9NL6tajEjwrXgpUy1lvR6hNHf+F5gAOTQbJKszjlTzCy1CUoXCcmCMHVyeMpGU4F9YQ857DZWFEcWlAQOVqaIlOKND0J/T642GeT7QiheJD/A06VHAm5dg+r4DoU9AlnfEPApxZQHNj7PLfiTSYKkAZGtlQndIqE/bvh5LWwSHunmrHRdVOJHq04hZICRYHLMBeYlX0WI5RSJxzvcdgBFfWFDwBAgYZoHc8U869vjOPr/sjfOOFjp/DubYUiRQUewcNWyz4+w/TQ57Uf3hy+jxC8gwMQvJX7RifOCrvDyu4IKTcR4j3h7BUGUSuGrvBtgO1ZJ/2KSVHF/HgE0XxC+rqPYeTX+0y9wLHAUg6QhD+w94sO4RnxzxS7nIx7DGZkkK7aXNagLpCoukUKLfvUb9saOkx8BgczNMv2ZTHum8kDnMp63PAQDOeQysRK2w7AugYx3SHoAAFxmnwE58BF14Y/Nj23cd1Do7NJYS/9LME1TrjvTO6TjGPvrr52/l+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(38100700002)(2906002)(86362001)(31696002)(5660300002)(7416002)(41300700001)(26005)(6506007)(6512007)(66574015)(83380400001)(53546011)(2616005)(6486002)(478600001)(6666004)(36756003)(966005)(6916009)(316002)(54906003)(66946007)(66556008)(66476007)(8676002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVY5bVo5N0J4VDJhVDM3cGFobk9VREtyUm5PVTlRWUEwcGRVNGxYbm53MzRt?=
 =?utf-8?B?VHpBZEQxN05pL3p5c3hUT3gweTFyMTVWTzlXUjhCOVhIUXZtS0dXQi9zL0l0?=
 =?utf-8?B?VWNET3c4dU9ibjEwNkxxWmFCWmNZSGFUUGZnMU1RdG9OTmhaeFVrTFVIZ0sv?=
 =?utf-8?B?ck5QWXgwVm9VRHh5bmJ6UU53NUY1THlyVGZWT1NGVnBsTk5KaGY4UlVmZjhT?=
 =?utf-8?B?RUJVMSs2RHY5ckpiM2cweXBtOEFKTndjN01DQ2RITXpGMUNFcEk1NUZEaDk4?=
 =?utf-8?B?RWFoR2ZUWHYvWmFJdXJGdHRjTFZqS3JaNW5KNm1rcnducjRFOVluSzhQaXJN?=
 =?utf-8?B?ZmNyUUVpYmdEOFBnay8yVEtPRTM3QkMyWHJGbXRFcytQbUVzNWZDajB1T2FH?=
 =?utf-8?B?Yk82bEh5MXRWMU00Z2tTQVBDWjhNQmpaRXZjUDFDU25rL0JEYmZ3N3orRXVY?=
 =?utf-8?B?OXhvVllUUEQrcys2SXRhdzVtcXdCY2tDZEZPZTNkakRsd1VoNitlVjhWOWpk?=
 =?utf-8?B?aXVHcWJlYU5jNEVZTWxyMTFrbFNlNklJaGRvcDNSaFpRS0dnNmZkV25WallV?=
 =?utf-8?B?STVGMHp2cTJDRTl3blFZMGxyTFFmcVFHd2dReDJ5QVNxQ2hNaU5nMk0zZk1q?=
 =?utf-8?B?d1p6eDR6R3B5U2Q1M3FjNkIzRDN0NG1Ydy85L0IxZXV0RWY1Q0ZlRkNEM3F3?=
 =?utf-8?B?Zy80WTJHZkV0UWVWd3p3M2hpQ2E3eTVtWVUxaHpwNG5tdXlkTFM4SUl5Y2Ev?=
 =?utf-8?B?SGRrK09Tbjg1YkgwUENiQVRsMEV5NDlpcWdHTHM4K1BobWE5TEFnaTNpa3gy?=
 =?utf-8?B?RmdmVFZ0ZDBiOWVINWNVSVNSV0lmUEpXOFhQdEVHUElFSE94U0MvTDU2T2FU?=
 =?utf-8?B?Y2FVQ21pSWM1TytCYWJYS0kyN2MyVG9adXRlbGhxQTZIL2Y2Rlk1QlZMMGs3?=
 =?utf-8?B?L3dJVmFZRlR1OHd2S2cyTGRuNG5VZU9wWmtFNFFaTnIwYUR4cktBZmp0Y3Vr?=
 =?utf-8?B?U2Mya1VFbTFXTzhJRmZPMEJxTzJlQXR3N1F1djdZK3VOVWVhYnJpbG0yUUds?=
 =?utf-8?B?ZzNHYWlEaEg2V21ZcnJtYjhuaWRVaDZuK2Y0YTdyY3lWbGVKcjlwK2ZEdnho?=
 =?utf-8?B?QTRPeUxNbUFQY2kvazY3a2taSXlramJSdkp6QjBwaEdCTUdzZ1hFb05GUHAy?=
 =?utf-8?B?WmVsZ3RnWGNlUmVPcGNTWUgzWFh2RTB3TzVkNXhMSmQxOEEyN09EeTJReE81?=
 =?utf-8?B?TzFWVnRDS2hSdmJ2WGp0UDFYUi9xSnFiaDVYeWdOUThMQ3ZvTVZyZE1neURi?=
 =?utf-8?B?dGwzWC9aa0JvTWwxT0M3SW9ONitmQ2FQVnRFOWZkVUFVcVNocGtCMEs2UlFa?=
 =?utf-8?B?Vkd4eFlZTStFSXk3c3ZncEMxRUtNT2xseU1WWTR0WTZ5c0dtNEpnU3EyQWV4?=
 =?utf-8?B?SDdnZWVKeG9qQ3lLd04xaSt3YXdISDFzOTRITXk1MjdRQmVGQi85VXRoNVND?=
 =?utf-8?B?NXRWYy9MRDJrdkxpRjlydHVpOExSQkdZODhVM1k1SWN4VnJPa2lRNEh3WmFo?=
 =?utf-8?B?b2lLT08zTDJRb0lWZW9pNEdNNjN6TzN2MFdGUktvOTNRQ2hranZ5b3E5NEs3?=
 =?utf-8?B?d0hRV1YxOS9KK3ErZGVYQmhPMk1ObEFtdzlIYWErN0JBc0NnK1dkdWRxdXJO?=
 =?utf-8?B?SVNnSlhxMWVmZWJ0RkFYbFo0UzErTnp0SmJQdXBWQ3ZJMi81Y1k3VTFNTGxz?=
 =?utf-8?B?b241dTQzQytTclg0Q0p4YUNvV2NDSWEvZEhvd2lSSVVrK1NQZzYyd1d0Y2RG?=
 =?utf-8?B?SWZQbmFTUnZoZXFvMk44a2pCN3NPdEFEVEFLeHdEalBZclNaU21aNlhBWElT?=
 =?utf-8?B?Vm85VnBjTkUzNDRLUVNTZldIc0QxK3A5azVUd2Y5TVFUVkxGMExBRTR0YjIx?=
 =?utf-8?B?WldpNStOWVdqRU9Tc2ZyOG5pL2g0YVlVK3pFLzVPcHVVdzB1dXpGZ0tUNEI3?=
 =?utf-8?B?eU95V2JPOVk5TzJGUVplZDRERWdvWSswR2R1c2lFRURaSDR0L3RlRVllSy9L?=
 =?utf-8?B?d0F1MVIwZ1hjZGF6WUQyR3NuMElyYU5pT1g2MjBKYWhPZ013WDNRcHVUTWFv?=
 =?utf-8?B?a1BLWjZ4UjE4WURsUGVEZjRreEp2Wm50T3hQUmJOSXFiTTFIS1NQOTV4ZVJw?=
 =?utf-8?Q?aQMoTE53+3PeIbben/uVIfM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MGRJSXJhb0NUTm1QamtVTmhneEY4LzEzU004Q05JUWQ0aW5IT3RkYThRVXF2?=
 =?utf-8?B?MEplckIreml0aFU2VXhud3JrRkd6S2IwNXozSElpajJrQTd3VlIwRXFqQU5J?=
 =?utf-8?B?SnQzNk1vd0hGYXFXUFZsaVIwcnV5cyt3OHVUTG5SWmp5VjF1cXppVloxZW42?=
 =?utf-8?B?aXVIMnJDNXVXTDVvcHVIeFRIWGFvVk9kcUI4cGxCT05heWNUcTI4aXBiWTZU?=
 =?utf-8?B?MXo0bUJDQklyZnROaTl2VHZtV2xsTGtyaUdLL1BLYVdjOG9QRU50eHRMQ3U3?=
 =?utf-8?B?eTNYeVJ5eFVDQ0NlVXB5eEg1MS9OTzJ3QzlvQUkza1FJQjc0bDJIT3ZMRVlQ?=
 =?utf-8?B?UFlRNWtwemEwZm4vL2Q3QTk4cHNoOTNJeXFMMWlDU242S2Q5VU1YM0syUFp1?=
 =?utf-8?B?WG1PbTNnQnh6c2ZGUmxEenpCL25ENExCNHBNUlJodlNFdlYxUWl3ckpqRVha?=
 =?utf-8?B?Wk44Ry9WU1ZEc1k5YXpRa1ZteXl3eUNVTlZtQlJXNHZFQ0tPNGJPU1dnNHdh?=
 =?utf-8?B?bzVlck0ydEd0bXM0bEFXcEp2c3d2NVhNSEpuNHpEbWxjcUpxODR3alV0VEhD?=
 =?utf-8?B?b2VpY0lWWkRYc1JyTzRqU3l1K3FWNVB6SGVrOFlsT0h1a3ZPbVptVEJWWUpS?=
 =?utf-8?B?T1ZBc0U0VXFSV1BGSnpqbGhReUZnUlJldVFhQjljNGtCNDMvNHdBdHJCNDNV?=
 =?utf-8?B?aktaa2FrUStwN0U3OEZobEJtMVVnZmJuVzNBWFVtWkZmQjNFVDFCRDdNdE9x?=
 =?utf-8?B?ODhuTk13cTlpMk9qZWxBTDlyUUczSURGU3MxUGczd3J1c0ZVRWhmSUtQbE8z?=
 =?utf-8?B?UnNNUnMvelJ6UEwxWCtJUkdhV2JVZmw2eWFvR1ZqWnhrVnBpUHVxQjhTNHlC?=
 =?utf-8?B?ZS9XaDBxOUw2VXUwV1YyQm94YW8rMiszQkd1V2FsK0pKZUVIVVRBUW1VVmFV?=
 =?utf-8?B?c09FOWJRalpRRFVWN1hJOFYwNWFKZk5taHdhN3VMdXg1YUNITDBiTVptd3M0?=
 =?utf-8?B?Z2Y2YW1pend2U1ZKV29BY3E3K0psK2VmM0tLSk5UMzBKSWwwR3VaS1pieSt5?=
 =?utf-8?B?MXZiUUhyaXI2aWlxdDZUNTE3WU5ZTDB0dkNpeHlMR2MwZVBoMnNwcUFPblN0?=
 =?utf-8?B?bStiZUpWMUR1Mi9iTTB3aTdFTTNKQ2VjaGhrQjFCM2pBdmVGNW5weXlmUStz?=
 =?utf-8?B?dEFTUHQzSVFkN1cyS1ZEcWRtWFZ1QlY4TFdYNjRydG82MXdwaDVtVFFPcVNC?=
 =?utf-8?B?SXRtTk9yZTUyUmVrSGVkVWZnU0hPZ1d6OEwwS204SlFCNkRWdGtpckVrbGYz?=
 =?utf-8?Q?gs2l5MamUfNyqCRd/f/926XAPrpSpim2wm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f847c1a-2e5d-431b-b272-08dbe1f48393
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 13:54:10.1172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKNfzviOxLAnwKznCYbtS48aqwGxEJ+DIPSik9zRVG2cRtHEmrViXxnoZyuFVfOk1WeH8rEdtEC4kFbktQLn/f6a9s5gUBEqWaMNthofeFp1Ze0MquuSr0pNfTSxHib6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100115
X-Proofpoint-GUID: Wrl09Qnun3fPnI9fOpkWTrQCB2gEti6p
X-Proofpoint-ORIG-GUID: Wrl09Qnun3fPnI9fOpkWTrQCB2gEti6p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 10/11/23 6:45 pm, Ilpo Järvinen wrote:
> On Fri, 10 Nov 2023, Harshit Mogalapalli wrote:
> 
>> 1. acpi_object *obj is unused in this function, so delete it, also
>>     delete a unnecessary kfree(obj);
>> 2. Fix a memory leak of 'attr_name_kobj' in the error handling path.
>> 3. When kobject_init_and_add() fails on every subsequent error path call
>>     kobject_put() to cleanup.
>>
>> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
>> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>> ---
>> This is only compile tested, based on static analysis.
>> ---
>>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>> index 5798b49ddaba..b28e52b64690 100644
>> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
>> @@ -588,7 +588,6 @@ static void release_attributes_data(void)
>>   static int hp_add_other_attributes(int attr_type)
>>   {
>>   	struct kobject *attr_name_kobj;
>> -	union acpi_object *obj = NULL;
>>   	int ret;
>>   	char *attr_name;
>>   
>> @@ -596,8 +595,8 @@ static int hp_add_other_attributes(int attr_type)
>>   
>>   	attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
>>   	if (!attr_name_kobj) {
>> -		ret = -ENOMEM;
>> -		goto err_other_attr_init;
>> +		mutex_unlock(&bioscfg_drv.mutex);
> 
> I don't understand why this has to be inside the mutex at all, cannot
> you just move it outside of the mutex and then there's no need to unlock?
> 

Oh right, I think this allocation can be done without a lock.

Will move this down in my v2.

Thanks for the suggestion.

Regards,
Harshit

>> +		return -ENOMEM;
>>   	}
>>   
>>   	/* Check if attribute type is supported */
>> @@ -614,15 +613,15 @@ static int hp_add_other_attributes(int attr_type)
>>   
>>   	default:
>>   		pr_err("Error: Unknown attr_type: %d\n", attr_type);
>> -		ret = -EINVAL;
>> -		goto err_other_attr_init;
>> +		kfree(attr_name_kobj);
>> +		mutex_unlock(&bioscfg_drv.mutex);
>> +		return -EINVAL;
> 
> Add a new label for unlock and goto to it instead.
> 
>>   	}
>>   
>>   	ret = kobject_init_and_add(attr_name_kobj, &attr_name_ktype,
>>   				   NULL, "%s", attr_name);
>>   	if (ret) {
>>   		pr_err("Error encountered [%d]\n", ret);
>> -		kobject_put(attr_name_kobj);
>>   		goto err_other_attr_init;
>>   	}
>>   
>> @@ -647,10 +646,9 @@ static int hp_add_other_attributes(int attr_type)
>>   
>>   	mutex_unlock(&bioscfg_drv.mutex);
>>   	return 0;
>> -
>>   err_other_attr_init:
>> +	kobject_put(attr_name_kobj);
> 
> unlock:
> 
>>   	mutex_unlock(&bioscfg_drv.mutex);
>> -	kfree(obj);
>>   	return ret;
>>   }
>>   
>>
> 
> 

