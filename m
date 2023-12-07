Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24838082FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378248AbjLGIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:30:12 -0500
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC08C6;
        Thu,  7 Dec 2023 00:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1701937816; x=1733473816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wcEOLQVmkKDA+XEYd/SAbA8duB3DUu9ftoqtGIffFrk=;
  b=V7xwejYTqR0DHJTNdRxnTkaswFxAJiTuoxl43CpMa/M18+YAIPZ0mWsw
   xXWbIfuRqskhJJCvHHRBCuenOrnlqjA7wQ/V7zOz3GVQAagkUTukwg4rz
   frUlliae9hj7QndQ8HwkMy/CDDbtGle8MJpbF6aBsONQKVUqebFo5hRh9
   HLyGvTAWduU13oNzD9c4u7o1qImaCuKNVeI9qC6r79UQPqUlBJSP+dJiD
   gkzdSVt5jhmwbdFraZNfU7b6H7AZq5h63kFZ3JWhxTZjksMKePDjq0Ei9
   nA+sq5gS9uaZicwG4jbFh2ov0f92HNtcQt+OgeVdwG8yzXODbiD3dYNBK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="104979684"
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="104979684"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:30:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7VKf3ug/TVsQ8ILUhiW+EkT1X0hxzpROJUCFdkmrGwUWptjEQu4xXPm5SxzYVnM6YZjsuxBMMk119AyYCVwVbOAnpBpu/w29EWvI1j3yejevKSmW3X7d886GPDwnu4mpK0BT61RsBwOal4dyeO1lVLN8DPhitxzn1keRepfVujvag19fVS6IpdHqecgnppi1zjeGlgYSPUYYwEnzXXgkM2b+50tonY/EyF8ToIGoH1MUVkfTP79GvUStrSrYnySIwoSkU61VOoZt4PO0peQet4DXhNwJd8kJFy5l2zAz4nUhTcBcIEd4UWEeBEIe+rxbrW1hm7MEN+4LcQohuz3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcEOLQVmkKDA+XEYd/SAbA8duB3DUu9ftoqtGIffFrk=;
 b=DxERTv1/sD9znpMqUoLe1A1tNtEpB/SY5eG1d17cZfGYfgEQ2R0qEUSajM9qnQuieQo5SoY3xW4XHrBPAeDqfGd4hxhRBIIzK9/4pfT0UmEFKWOLtze5hdy2xW+UxtBCHesNg8KZAWe/8kHBzxloIVwGMUo6HPeI0c0m69mxODASvtkLoUjBK4s0WtfcJzvrdhsnIcPqOIFjiYr43ONLs5MLIXAbwiWVQT/mQCw0esTjTLHyU8BtSjYl8e2EUzXcYGS130o8V78q07w/EjCQwtORua2CH5MVAy5rVmCselAgYVbHL/48pB1O13cNxMOazQD3UADatTYZZVUGSh6GqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY1PR01MB10704.jpnprd01.prod.outlook.com (2603:1096:400:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 08:29:56 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 08:29:56 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaKMb1Ze8I+hDKSk6AX1Jl5zz+7bCdfY0A
Date:   Thu, 7 Dec 2023 08:29:56 +0000
Message-ID: <4b1a415e-6a56-455a-a843-277cc08d05a9@fujitsu.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
 <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
In-Reply-To: <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY1PR01MB10704:EE_
x-ms-office365-filtering-correlation-id: 9914e4d7-3125-48f1-a917-08dbf6feb190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZ+zb/vWsAWXumdA5Okyt5fT481p8r5nJOHQWbe4hlny2WqXerkuwYNGgEcEuHJH8jjOy0WphuNKA94U7KLrY64mUQ7x7jOTzsbjI9jmLOUL7u+JRcQLlwoXT29hSTEEf2va1uz9n/DVeZgGcWpQNhlqLp1kPscBx2XjB3psSJWfVFoMnUsR6QA0EGlRL6juGJ0q2wUNCCLPD3hTXINQYw4xqCXkAbVPcUAbgFWlux+8agxZLrOgJMtHomnkMXvkX15BqJI+uqt6umNQTjMHF7dCY3wYNm9Yral5BmsGPoOLgCH/0QRNtpImKbgZc4wqb0Mk2EopbPDxoXjHE/N4ZGCDGSynd1bl14oZvlOmgamkhwg83iQ69L+Kok49hcWn813WJ7jf+BUKKbu5sgzj4TkZa8xt5XSWgPyyNPc64i7ebu9AM6YFvT36Czt9Ocj98GOlmwwjLVItEe5Q8dFNfZlfJHj2iSFg4wUfcelMiUGLLaXBGQMpRAiP0gNE0po9djaSHKIZ/pc1Zi5/tktXtXJLb6OuBL31D5msRUpDirwu4Rax1W1riol00MpD5obAwF1Nih9Rpku4cOk1ZcHmVexyIZxJQT+nyvagkQ5kLDrZ+GiJQICnyowl8WXduJhTigV1N340eIq7vf8/hcZklDtg0E/7ewwDLBZMpxbi8Se2E53//FS33YiS0Fg+lPBWi24wCvgUelTVPKQL2Kdvgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(1800799012)(1590799021)(64100799003)(451199024)(186009)(26005)(2616005)(38070700009)(122000001)(86362001)(6506007)(31686004)(53546011)(31696002)(82960400001)(71200400001)(478600001)(41300700001)(6486002)(6512007)(66446008)(64756008)(66476007)(316002)(66556008)(36756003)(91956017)(76116006)(66946007)(110136005)(1580799018)(38100700002)(2906002)(8676002)(8936002)(4326008)(7416002)(5660300002)(54906003)(85182001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wlh0ZmhnUnhLc2NRM3I2ckNhSjQybElKT3h6UTlNbXJVK2YxbkQwRXZ5Q0Vh?=
 =?utf-8?B?T1ZXSnhncThtNnpIVlJNZHNBM3JRVmpLUi9JSUt0aCtkdmRad3l6ZFFpSjI2?=
 =?utf-8?B?dElQM1ZUdHUydGNMM1IzQU94M01ROXI4Wmd5K0FUcUh1aSs1NWlhNWZZNk5Z?=
 =?utf-8?B?UkNjakEydEUwcTlZZ3AyZVNyMmx3SlFkSjFSeS85TE5ZUGltRlhwdzRicDRw?=
 =?utf-8?B?dzlpeFZHNlgxMDZQb2FpYlM5STE0Vy9UU2NzcTJXKzhTUDVtZzFkdkF0RVdo?=
 =?utf-8?B?N2ljRWFLQUFGTEdWRUNLMDJvOVBlNk9YaFFmNktuMXdBdjZWV0E5a0xEOHhm?=
 =?utf-8?B?dHBFSHlPNkxFZVJCWEkrUDNpNzBmVzg5NERzK2xlYytHbFNwaGlTRkM2QmFK?=
 =?utf-8?B?NTFuWTFCV00rOW4walYzUmIraWpNWUNvVTRrRnBPMzVRb25heThtZzRNM0Fl?=
 =?utf-8?B?R3VUOFlMck5mekdnQ1JpcEZTSkEvd3Z6Vnhoak1SeTNlZXhwS010Wm9mUDZk?=
 =?utf-8?B?aHlkeVZLcGpROUltZzRwTUtqMEwrUHVFMFRqOEFIcm5rZk1xdU5mclhVdE14?=
 =?utf-8?B?cE9FTnByTmUvcFdaZi9HWWZFQ0lBd0thcHd6cUYwb0NGc0JCTlU3MlNBaDhO?=
 =?utf-8?B?d0oydnBBTkk0TWdLVUtTV3BxMGMwSVlranYxLzYvUGMzbThYUFZ6SXlnajhE?=
 =?utf-8?B?eTBOS0dxVGJWb2NFMlFqbFYrY24rckttMGc0ay9aUlN2MkNzSVk2dUhrWENu?=
 =?utf-8?B?NVFUYzlGUitZYytnaUxDcjhldW1CWWk2REZpV29kTWsyQUNTaFZnMytGc045?=
 =?utf-8?B?UHdqdyt1aEQyZEhyUHFxN3dYMThVK01Nakd3M2YyN0Y1OGZTdVhnRUwzWTNu?=
 =?utf-8?B?cXVWUW04c0VmU2V5N3pMVW5kM3FTNWdVaUJKWHVCUVRBNGZDZXRHRTZZTmc5?=
 =?utf-8?B?MmFkaHVWOTlpSVJKbmtjMFZpcUR4RWRuOVB5S2VBZUQzREYrWGs2dmZvdUE5?=
 =?utf-8?B?ZVl3UlNSRWxVREphK3huaXF0K2ovVFNUelpvK2J0UHovQkZXVlEwV1hEalhR?=
 =?utf-8?B?ZzNWZDRab0xkSFZuYmRxTUp4ajJRcVRCZGEzMWRmWmNVOElzMVQ4M2l5REZR?=
 =?utf-8?B?Q2lST0szb1lUblRQMmpOSHdIbmJQOGFUSFVWekltN2tuVngrQnZMRThmUkZU?=
 =?utf-8?B?dnlmTjJ0Zmx4SUk5OFJyT3pXak1xemtyeGxQalVhWTRJdGtNOTk0VVlFYWFq?=
 =?utf-8?B?eDk4a01qNGVGRlpLTi9zYndkdXU0NTVHVnU0bGdZNUIrUEc5L3oxZkp1Y2Fr?=
 =?utf-8?B?ZlNrS1ZIdXFCdEdZdWM2aWdIWTFCS2lkYTdkVmI3TjhvTytYZWgzWE5lYmto?=
 =?utf-8?B?VFNMUDRPb0FwRVNEeTdVcFBmdWgwR2NDSnFrblZpWFlITFZOQmlRNkkzTVRO?=
 =?utf-8?B?SEg2ZHE2NE9wWG90NUZmVVR2VkRLeng2VW1hWnRPbXBSejlidHFtYmVOVU5N?=
 =?utf-8?B?VlFhVFVzcnFvWWluODJqb0dkR3lJRjF0SUMybWR0ODM1WUlFdmFaL29RUkV4?=
 =?utf-8?B?eDZXZjhqaXkzMVlDQ1UwZ2lIcGtnU29iUG1qMFB6bkdJaXYreVpDM0djeGdR?=
 =?utf-8?B?ZEhmSnhZMlk3UVZ3dHh2b1BSSkNURTFHelpXTloxYTJUaHU4cVB6Sm1RQmFH?=
 =?utf-8?B?Ykx1VXBLRFpvTUlWc3h4bEtCWmYxWTBjYlk4bU0zRkNkOVpnUU9iMXIzZWF6?=
 =?utf-8?B?U2t2VnkvMTErWnphckM4bG5iN1V4WlJNdlI3VDI1YU55bGZxNDBhbXZkd0ZJ?=
 =?utf-8?B?dkpUaHRydmcxU2hZaWRncmZXTDhYSkJwdjNJQmdyUzEvWFFvdU5OMWcwc0U4?=
 =?utf-8?B?MFRnUVZnbFZKYnVUclhNUGxZNHN5N3REcGh5V1Zna3hMeFl6Z0hPQTh1Wkdx?=
 =?utf-8?B?MlZyOFZUU3NDc0xNSWMzclpqd0NHRURoV0EwZTUwQ3YyUDB4YVZObjFCdW1u?=
 =?utf-8?B?OURicDNieFR2R1NkaW5Xb1pmZTJHMWpLUXRwdjl4cnJweGhJb3dsSGIxSnBJ?=
 =?utf-8?B?M2g1ODd1WDkvaWp1WjZLMHcrNlZSL2R2Ri8rYW1sbXNWdm9CQStlcG5sNWR6?=
 =?utf-8?B?S2lRRGFjQitldzJ0SU1mTC9pZEZvMlR4WHhZM3Frb1ZwdzRaRTIxTWV2ZTZF?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44AE9ECF4B9E7249A16049F4EBA8464D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZndMTDlSZFZWYWNaRko5L0I5YjJsSjNEMzdjekg0a3lIUTJVN3JibnVNWE9z?=
 =?utf-8?B?SlVJb2xjZ3FzMVhYM29RVjA2Nm5zSzJzZ1hTeWhiN3JuTlB2VEVIQm4zMzk2?=
 =?utf-8?B?ZW1zVllENEJkMTBKa2dRUnJGMitaUzhLZy9SY0duM1h1ZmdoMFlvbUhmNXp4?=
 =?utf-8?B?UGUxalJUSXg2dkVYNm9ZWlZaVkx2ZEdwUlJQZ1ZoUmNueSt0RGU0WFJyUS9w?=
 =?utf-8?B?NjViTGt6cTBOQ2pZendORzR4R2dUZHZaKzl0Z2pmejJJdm5GQkpWN2dUZ1FX?=
 =?utf-8?B?OG8rZFhEMVhmUkNObmVsQk53aHpUendORW1iMFNYdzl3NHBiS2hTNWtnNHVy?=
 =?utf-8?B?UVEvOC83UXU5UFI5S3Z5L2ZJc2tPSVJKM1BSTTZRTy9GUUdmMGFucHh0eW9D?=
 =?utf-8?B?TXZvTjVYRHFtVVRXOERqREdQSGhId1lqNk5EOHN6SURMVlZSanNxY1BhOHgy?=
 =?utf-8?B?RzFpOEhraEVqZlpuTnRIRC9YYzljbUpScWpTR0s5Ui8xRjNKOFhlb1FJZFVs?=
 =?utf-8?B?cmlPV2xBeXV6akhzZ25JYldEaTNUNW1EbU5peGIrdDBqcDduRlhNUXlMSHQr?=
 =?utf-8?B?bVB1MjFXQk5SS3g4clRCTVpEUGs4QVFVZG5hL3NxY1VtcWlmQjJJbGJYREl6?=
 =?utf-8?B?YzQ3aTA1NXhvWWVmYnV5NHU3SXkvcE9taHI1SVBRQ1l4WFp4L0lCTmRjZTdo?=
 =?utf-8?B?M2gwSWxzZEpPcWgxQ25KNW16V21mNzJ0MDBCM2NKcUtJZ2k0Y3FjTHd2UmZV?=
 =?utf-8?B?MFkzY2VDdmlhRU5Rc2NhSlVvSzBJUm1ialJuak1heUc0SEgwR1ZNSGJPVmJa?=
 =?utf-8?B?aUZCSlk2VGZHbFFMSmNNR1IvTWl4T1p6UE90VldxV2VJNVF0M1RlUDZMM2k5?=
 =?utf-8?B?c01yWkUwNzNScDhTUlBjdlp4S0ljNmlZdHFvOHNkT1BET2Vkc2lMSXJxd2Vk?=
 =?utf-8?B?M0l0RFlTcTJybnh6UE5KZWxlbGFlVGxZcXJqQTRvb051ajlOalN3cDJuR0Jn?=
 =?utf-8?B?SllVYXlzQlBmdC9Sd2loMXR0QXBwSDdqMzRnQ3RXSkFobkNJeWwyUTRjRFN0?=
 =?utf-8?B?QS9CM2lrM3FwQTZRNXhOTkY3TFlhU01EcjFzeVplZElKNzVEM005eEZmVmph?=
 =?utf-8?B?U2lieGN0U2VFRERGbERsSVlsWjM1azg5TjVlVjk3VFE0MWZGaHJkR05OMkQz?=
 =?utf-8?B?N3NMS0hVRFNvMEg0TThNVE41SnZPbWRrVmMrNkRodVkvZlprZTc5TXhpTTU5?=
 =?utf-8?Q?XS3ElLdhZUB6JZQ?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9914e4d7-3125-48f1-a917-08dbf6feb190
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 08:29:56.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2dBKgeWac2qRqEYwfzVu7EOxoreSowOZI9qntyrmyn/rr7iNEWcUFrPPGxNVIllZGw2hxw6uN2dY1bUkWsFlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10704
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlzaGFsLA0KDQoNCk9uIDA3LzEyLzIwMjMgMTI6MzYsIFZpc2hhbCBWZXJtYSB3cm90ZToN
Cj4gKw0KPiArV2hhdDoJCS9zeXMvYnVzL2RheC9kZXZpY2VzL2RheFguWS9tZW1tYXBfb25fbWVt
b3J5DQo+ICtEYXRlOgkJT2N0b2JlciwgMjAyMw0KPiArS2VybmVsVmVyc2lvbjoJdjYuOA0KPiAr
Q29udGFjdDoJbnZkaW1tQGxpc3RzLmxpbnV4LmRldg0KPiArRGVzY3JpcHRpb246DQo+ICsJCShS
VykgQ29udHJvbCB0aGUgbWVtbWFwX29uX21lbW9yeSBzZXR0aW5nIGlmIHRoZSBkYXggZGV2aWNl
DQo+ICsJCXdlcmUgdG8gYmUgaG90cGx1Z2dlZCBhcyBzeXN0ZW0gbWVtb3J5LiBUaGlzIGRldGVy
bWluZXMgd2hldGhlcg0KPiArCQl0aGUgJ2FsdG1hcCcgZm9yIHRoZSBob3RwbHVnZ2VkIG1lbW9y
eSB3aWxsIGJlIHBsYWNlZCBvbiB0aGUNCj4gKwkJZGV2aWNlIGJlaW5nIGhvdHBsdWdnZWQgKG1l
bW1hcF9vbittZW1vcnk9MSkgb3IgaWYgaXQgd2lsbCBiZQ0KDQpzL21lbW1hcF9vbittZW1vcnk9
MS9tZW1tYXBfb25fbWVtb3J5PTENCg0KDQpJIGhhdmUgYSBxdWVzdGlvbiBoZXJlDQoNCldoYXQg
cmVsYXRpb25zaGlwIGFib3V0IG1lbW1hcF9vbl9tZW1vcnkgYW5kICduZGN0bC1jcmVhdGUtbmFt
ZXNwYWNlIC1NJyBvcHRpb24gd2hpY2gNCnNwZWNpZmllcyB3aGVyZSBpcyB0aGUgdm1lbW1hcCBi
YWNrZWQgbWVtb3J5Lg0KSSdtIGNvbmZ1c2VkIHRoYXQgbWVtbWFwX29uX21lbW9yeT0xIGFuZCAn
LU0gZGV2JyBhcmUgdGhlIHNhbWUgZm9yIG52ZGltbSBkZXZkYXggbW9kZSA/DQoNCm5kY3RsLWNy
ZWF0ZS1uYW1lc3BhY2UNCi4uLg0KICAgICAgICAtTSwgLS1tYXA9DQogICAgICAgICAgICBBIHBt
ZW0gbmFtZXNwYWNlIGluICJmc2RheCIgb3IgImRldmRheCIgbW9kZSByZXF1aXJlcyBhbGxvY2F0
aW9uIG9mIHBlci1wYWdlIG1ldGFkYXRhLiBUaGUgYWxsb2NhdGlvbg0KICAgICAgICAgICAgY2Fu
IGJlIGRyYXduIGZyb20gZWl0aGVyOg0KDQogICAgICAgICAgICDigKIgICAibWVtIjogdHlwaWNh
bCBzeXN0ZW0gbWVtb3J5DQoNCiAgICAgICAgICAgIOKAoiAgICJkZXYiOiBwZXJzaXN0ZW50IG1l
bW9yeSByZXNlcnZlZCBmcm9tIHRoZSBuYW1lc3BhY2UgOjogR2l2ZW4gcmVsYXRpdmUgY2FwYWNp
dGllcyBvZiAiUGVyc2lzdGVudA0KICAgICAgICAgICAgICAgIE1lbW9yeSIgdG8gIlN5c3RlbSBS
QU0iIHRoZSBhbGxvY2F0aW9uIGRlZmF1bHRzIHRvIHJlc2VydmluZyBzcGFjZSBvdXQgb2YgdGhl
IG5hbWVzcGFjZSBkaXJlY3RseQ0KICAgICAgICAgICAgICAgICgiLS1tYXA9ZGV2IikuIFRoZSBv
dmVyaGVhZCBpcyA2NC1ieXRlcyBwZXIgNEsgKDE2R0IgcGVyIDFUQikgb24geDg2Lg0KDQoNClRo
YW5rcw0KWmhpamlhbg0KDQo+ICsJCXBsYWNlZCBvbiByZWd1bGFyIG1lbW9yeSAobWVtbWFwX29u
X21lbW9yeT0wKS4gVGhpcyBhdHRyaWJ1dGUNCj4gKwkJbXVzdCBiZSBzZXQgYmVmb3JlIHRoZSBk
ZXZpY2UgaXMgaGFuZGVkIG92ZXIgdG8gdGhlICdrbWVtJw==
