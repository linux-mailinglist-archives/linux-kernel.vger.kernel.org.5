Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228475DA9B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGVHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGVHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:30:13 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F152691;
        Sat, 22 Jul 2023 00:30:12 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36M7HTKE006323;
        Sat, 22 Jul 2023 07:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=subject:to:cc:references:from:message-id:date:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=VEUXDNMa3qNfYpQLgWGzHpmh/4ZO3dyx4+hTuZ9irTI=; b=
        qtNxw1zvrEe83GpjTEyTujoXKF5xQVTfT02dNUojY+a302229oMa7KfU/yBMDaGQ
        RZeWDh9fe0gsL+9mpbqBQ1x1d2ReY/tO2yD+lXFgLwiv2LpMrI9Ql6x8Siu55UeJ
        GWrc60++snDGtbxMnvYZx6Vlqt5nrFsjwxlCeLKjCzqUIQ6WkXdDzeKEiEm5vqB0
        PXOTeYOcdImFAhsT6rb872wG8DC6EL3ENQ5+Kd4ykr62uBBUnGXMfWSVSvaA4wKw
        nSb3nGcYmFDsGGculDIxAbwUONjICdkxHHMo1QksoSyQMZDtJkoVo8eJNwfWL6J6
        nyLiCoPM5gyeQe4aPrPiKQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s063684de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 07:29:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coW8w57njFdALWJ2iI4XBaQNU7GHQsaztn8tTYYDvGxCRmG90TVndLWVlSdsSkbKVYeXc9xymiSm2r10KneXl/VVFgElqwKPXPiG1DIUPU2NaSfmtYVicPUDre8hFc++0HDwMm847ecrbHpCOxzsQ8M7e9j6AbbOuQiLZr+YwDyIPk/dO0SvK6D+bc+Qf3d0/Km3o7s7QAYfQ7qBo0Yf2UaD+v/PYmb83cf1KVPt3tr6Yz+pCA3f1jD3I3sWeR5OW5SVU9qsYNHfv7o5QhFrenveXvtWLRP07FruIZcu5geCMCf5XNifChUiIG5bgftWwAXwpEvB4KYyTMdErKElfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEUXDNMa3qNfYpQLgWGzHpmh/4ZO3dyx4+hTuZ9irTI=;
 b=jWFFdHP4XZU0z2ovyqBr4gWsddSZjFE8DP4EHNo+z/ZkGQd5NOHfpJa2CLw8iJC5neog2vz5aMEtNsTxSYUD36qgkx1Z1iPXHXYN3YDrUbf40OFyEmoYCIzzGK7/AfC9mjwAaFfDqF/5sfdek9x66j7gCaYH2oftZSvSF+o0UVgNthpJftZqtXAd85gvgLfw1o5ME7gd2Hm9lirfWr6HgYMFXGeG4UZcPpsLhGKhd/05k7q9DZVmzttCpJInmGIHnPtWgphjHXD6Nj+DO9RptX5KG5shJsxamESklLSwGK1brkMaNLncCK+GOEpmWBOxY9nUhzDKV08dNFlZfQji+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 07:29:46 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6609.024; Sat, 22 Jul 2023
 07:29:46 +0000
Subject: Re: [PATCH] ARM: dts: imx: Set default tuning step for imx7d usdhc0
To:     Fabio Estevam <festevam@gmail.com>, Bough Chen <haibo.chen@nxp.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230721232123.2690960-1-xiaolei.wang@windriver.com>
 <CAOMZO5AMDvERRaSUYtuf_zq4foSqUuo0kErhj+hEZUuZRPXv1g@mail.gmail.com>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <13c51031-ed91-d641-6336-206298f1b60a@windriver.com>
Date:   Sat, 22 Jul 2023 15:29:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAOMZO5AMDvERRaSUYtuf_zq4foSqUuo0kErhj+hEZUuZRPXv1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fae5ae-959a-4ee4-3675-08db8a856c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oN89LbzvkbympAcYNyAni0S8OoTU+wwze1i2PDAZgxax+D2RB0ercMnY274r4XNdrENVKmgfLiOWw13t7V3agYNoD6Nkm3fWx4L7a4iiSy4rEomV4WIpc1k3ka7ejk472Cgrr73lniOLkfTIZJV/s+BuE3LmuXl+OyZavIrDzt28aAzYvF92M3POZwy1qiVcxY7MUNrI4PjvIpTWqrdBftsIwBBWREGbqI8ytJOfltFcM8sI3qJybcjDd3o84CQNkhtPQTdSMpxxSJ1JYZnhN7PzHWTP+o5yMcf2Z33Fil2VAdoE13n+5osEutQqVAqZfxhJRM8m8n344nAC99uXv11VBR0ebz08XSiU/sMFe3Y/23Qgxn6xiVAxrlV5WnXKBdjBUZqnfAkfyZYZGn98kb95ASGhKv8MCjtSxTUCEMLsVAmLKLsnfPNB3F7T6CHa18GCdLdPl6VACXIsX8UiS2+qvMk0udoTSxKvacDKekG5zPCO13cdB6RltgOR/3EPuZFIULApjagoGhl7gB3y5UQEQaxhxPuwxVnB9Qgfx8hUWf/ctIsyI7J3quefj9E4j4jTBlP6cNNAqT35RkXiICAkCsm3b3tzJ2z2BFOAkQNtOvuJnFKUDmBECjG378zfXBFsOZ4H/MaiQcgol+O78r1x8Ptqzp5+soZE3E/7vx+4H4k3F+P93A3Wtj6XixQp/giB6QPs2P4IVta/aB6xhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(451199021)(66556008)(66476007)(66946007)(2906002)(83380400001)(4326008)(36756003)(53546011)(478600001)(110136005)(31696002)(26005)(6506007)(86362001)(6666004)(6486002)(6512007)(966005)(38100700002)(2616005)(41300700001)(8936002)(8676002)(7416002)(316002)(186003)(5660300002)(31686004)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS9rNVQwUmhmQVc1dzdlTDFhYUV5YzRXQlVhVUE4b2JrTEdxOHdmRjErWUc5?=
 =?utf-8?B?bDh6QU52SFZlWnIrSDkra3JrWHB0bTNxZUdVTmZRb3YwWGprQ0lBdjJLbWk0?=
 =?utf-8?B?WVhjNTZiNnBYRTd4TU9nZE5tTmFmTlhOQVF5eDZIR0tYYnIwSndYUmJiSENQ?=
 =?utf-8?B?SG00Yi8rWDkzOFFmRmZkUW9Ub2NUUGMzZkNucnJNV3RwUU5HVnhwbVRDeHBI?=
 =?utf-8?B?QnZqWS9ZTHNtMTAxNzRjQUV2bVc0cjZaWFNZWVJiczVJQTlVSTYwV2NrZnlI?=
 =?utf-8?B?Z3J0WDZtLzJCL24xRkFDOHZrd1RBNllTdFhYQlhLVURMN21nODFhaEJTV3VR?=
 =?utf-8?B?QkdGZjZxT3pvQ29zay9wNm8xVjZ1SmVVcUdWLzdPVnp1Y3d3NXJvWFBWRFBP?=
 =?utf-8?B?b0pqMkRWNDNDOStMQTJFSW1qeE01cXZ4M3dRT0QxVkJLT05kQTMrcjFJM20z?=
 =?utf-8?B?S2dYY3A4SmRIcHZOYnN6aXpkeTJxS0NrSUNRSVplK0Z5VFZoUVdyOXFCMDAz?=
 =?utf-8?B?TWpuNHY2aDZRdkxKTU1zYVdqclcrSnR5ZGJJYkxJSkR3U25KUzZEc3NoYWNN?=
 =?utf-8?B?aGNtSit0VzVxNWR1azNuYkgrTzdZUno5cVluY2I1TVNhWlZ0N0FTTDdVWW1Q?=
 =?utf-8?B?TWFMMVI0STVReFI3Rk4zbWxrbE9iK2psWkgwN0VkK3BxUDI4c3p4K2k3eTNS?=
 =?utf-8?B?ck4xamxselcrcy9ER3pNdDh2clNuL3NhRWY0VVk2QjVESHo4dld0VnNjakhR?=
 =?utf-8?B?UnVSMkJ2Y2FKTU16VUpXSU1uemw0cFZLUmcrUzk1VjFIMXNGY2ZvWjlaOFRX?=
 =?utf-8?B?QVBTU2V6Y1N1eUpmQWpmbi9xQ3lEd1hpT2hIQWlYVzBaajEvcU1zcVUzQzdj?=
 =?utf-8?B?Tk1nVzlUVTllQnZRK2hGc2tEM3k2YisvakJpWCtnbFVRUk41bFQwUko4UHpj?=
 =?utf-8?B?ajRTTUZ4UzUrakFWUEl4ODJoQkp4Yy9xdjNZTUtUa2hWNGI4OWM3Z2dRQ1Z2?=
 =?utf-8?B?NnJQTmppd09xQjd5dkc1OGpDZGlPLzEwSHJrNzBOZHNPWHIrZUpydzlBQXBQ?=
 =?utf-8?B?UFRZUE9kNHIvQ1haYVFCY3kvSkQvQ2V5UEloU2Uvd1BqN1lHeE1qa3k3RGtY?=
 =?utf-8?B?YU9YQ0pxK1RwMW1aYjZHamJkSGVZZmZ2OTc2UmF3Kzg1c2hQMmNOZ1pqNFor?=
 =?utf-8?B?K3RTdGJQZEFEaXY5dzB2OXcyVEJjZ3BCdkl6azJISmZtUUZqcU5MTlVRLzNB?=
 =?utf-8?B?Vm9DQzZMcjJ2WWhZOCtPdVh0MTNGK0RhdGFkM3JKSGJleWJQZ0pBM1gvcVhw?=
 =?utf-8?B?aHZjSmFITENacGxYN01lU04rRzN1Tm5nK0V4Q1lpMGRsQWNjL2lFNGVWdkZG?=
 =?utf-8?B?VmRGRU5nY0tZRGJYb0kzNi9Ua1VQZkRxdnErdWRYRTExeDNsUXBoekhQTGQw?=
 =?utf-8?B?c0hORWtrWXR4OEYvZ3YzdFFXQjM3dTJlalNIQXNrM0J4NzA1T0ltdE5qZFA2?=
 =?utf-8?B?RVhuTmZ3UFRFRDR5Ly9IcHhVanJmN0p0MkZ0ZlVEMjhXV0pHbXM4elhlK3Y1?=
 =?utf-8?B?ZVM4M05aZnFQeDRpaWcwMnVFcGgvVlR6K2tYYVREcC92cEdPWmhvLzFNcU9p?=
 =?utf-8?B?Sms2a1pSdU5vTXdWTTUvcU1BalpJR1Byc1J3Wm40TFlFbU1IanlHRWZzTGp3?=
 =?utf-8?B?QWxKSUxxbHgzcThUYWhRUjB0elAya2xNRzBIUG1uK2JpdFhLcUs2RkNaU2ln?=
 =?utf-8?B?ajRxK3hLb3R1d3ByNTVqOE4zSUhjTFdOZUQ0UlR4QVB4UkVFdWZOOHhHenhE?=
 =?utf-8?B?UEtPZEFkZ3g4d0NpYThockorSmhiRXlpa01VaEVucWVjdkpyZ0lTYmhhaUFi?=
 =?utf-8?B?ZEZleExoWXJJOGhIQk50dkRFUU1WOForY0h6dFdTNkVTaHRoUW5VMlB1RTRu?=
 =?utf-8?B?K0NPc1czY1JQRlVrQ0RFOTl2OFdRbUp5OXo4am1KWjU3a1p4OVN2dmJRc3Na?=
 =?utf-8?B?aVpLQ1ZhSklyVThQYytCOXQ5OE1qZmhvYUZBaVNFOVkyS3cySCtMVm5heklp?=
 =?utf-8?B?TkROYnFJZmorRG1pSGpwTTZuNzVkZmhQVGovWDBFejBXeUUzTGhER2VNYTBr?=
 =?utf-8?B?Mjd1eHhFNUY1UjZjZkRpU205VzZ5am50bmdGbkpScVdlbkw3dTUxV29zYlF0?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fae5ae-959a-4ee4-3675-08db8a856c95
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 07:29:46.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT9sFwNyJNNb61S1luuZ0GLWTlCyBBxD07rWH2waRqYiMQYCEHlwnjC0MHb4EQ6AMrtEQ48Wlmc1hylfZU452fdEaERr0/Z/jPdTVL2/dh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-Proofpoint-GUID: ZzViuZkJNF2U6RR5o4njJ49lhXM4Gk8_
X-Proofpoint-ORIG-GUID: ZzViuZkJNF2U6RR5o4njJ49lhXM4Gk8_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307220066
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/23 8:16 AM, Fabio Estevam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Xiaolei,
>
> On Fri, Jul 21, 2023 at 8:21 PM Xiaolei Wang <xiaolei.wang@windriver.com> wrote:
>> If the tuning step is not set, the tuning step is set to 1.
>> For some sd cards, the following Tuning timeout will occur,
>> so set the default tuning step.
>>
>> Tuning failed, falling back to fixed sampling clock
>> mmc0: Tuning failed, falling back to fixed sampling clock
>>
>> Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
>> index 75f1cd14bea1..d7396fbfcaf8 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
>> +++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
>> @@ -493,6 +493,7 @@ &usdhc1 {
>>          vmmc-supply = <&reg_sd1_vmmc>;
>>          wakeup-source;
>>          keep-power-in-suspend;
>> +       fsl,tuning-step = <2>;
> I wondering if this should be a imx7s.dtsi property instead.
>
> NXP vendor kernel passes:
>
> fsl,tuning-step = <2>;
> fsl,tuning-start-tap = <20>;
>
> https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/arch/arm/boot/dts/imx7s.dtsi#L1216-L1217
>
> Bough? Any suggestions?

Oh, I didn't notice this patch on linux-imx, I refer to the settings in 
https://github.com/nxp-imx/uboot-imx.git,

but it should be the same, I think it is better to bring this patch in

thanks

xiaolei

>
> Thanks
