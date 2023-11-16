Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD07EE539
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjKPQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:32:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64103189;
        Thu, 16 Nov 2023 08:32:52 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGSDYg014031;
        Thu, 16 Nov 2023 16:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=84mjtJHYBqx5PUOuH0gqQSq/Lbm7pk1Dj8J4gE3Mwu4=;
 b=qLhQ/dZm2Xsy9oitFMRbe7S1fpAcURPMg69fjaiXDQ+JevkWpxautUlxcSqf8i45JIcs
 QLZgxcrTzPZhfbhzZuw32hGP73Ii04ERbAGcr0apcWz1WwxrosW4I2Fg4nsZJQ7Fk9UK
 kokGD1kLbUib7/AoykNvUo1oMmwVfnlJm17IAVUc7/U0bQDnW3qlNigm+Xe55i+w3X4p
 8MHvuz+Id0IyWMdLfmowcs3Aw5RV829MFAXjfNBGjcvRkcvQa58UiPRJgo3gabX7GoxK
 eNEZmPzc0P3vb5G9fHvL3TGM91nLpT49z3uBhWiLJ+TquumRRAr6nTgm9CDnH1hnGSUF yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stufq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:32:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGV3Gv036936;
        Thu, 16 Nov 2023 16:32:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k755dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIDb6GyeCgY2nMfwUNHohM/qKO7wNmW7eUkggTdKkaQVDV7NHSPXuOTc5BPGpwgHQvzJV1tnd+Yhh9TQBUOQw6Vy7zT3CSqsGiH0h3W0ZJIOkWRDOPggas4K3QNKFaXKmLkpal/rg3y9hGUDa3rTuTZCoH4GyFplzi9RgpmiKbGlBSZnN0CGi6wrj51CgmlzXP4FS5Z0Jl+G4WMpk+3u8b2I/CAN74ZuiRoCmqGIcbc6ERn/Pk68ADyu+PydiKApirli5inWGEYwt5jLP86B7a3TrWjCPNq3aNnuRX+KELcGQdqzk16Dwd1WmYz2SUNZWKyVPPLIp+fHWyzZapK/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84mjtJHYBqx5PUOuH0gqQSq/Lbm7pk1Dj8J4gE3Mwu4=;
 b=E4lJTcPdTvGGspXntwClIp55+1TKQ0mKGtOfwBzaGgtMvZgJkXYSgSQGLgyzOqBdP6l7gg9IMdqGWIRzz2gk02jsposea1fH55QLyHpaOqUh0uuTlmuM45FSfotPXqZ3SwpBMH/jG6sqnInWW+COk1gp7TCQqINPBdYu20HIskLIaS8sV3br1KLkhdd7BsUSTQt+G3HZzwIaNytyUmGL2wmJbJh2E0+mPgt79FJN/glBVu1Ed4JcCtprkhwrQ+uIqjCzu5XbYuLK+JkU05h+PGX8joDdwfdghae/337Hc1YoW4lbKm9W+p+tw+sd7bHuzsD2a4a+9DdIPUL8PLAjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84mjtJHYBqx5PUOuH0gqQSq/Lbm7pk1Dj8J4gE3Mwu4=;
 b=SonHcWCh36AQnmXG+1GZY6xtoA0P3AVTMfcgU+gh/91kBbxVBBoqVJscAN/akk33wgqHfI4kYYlWnXgOW7HAymhn9Xn9i9/FjKY0H/P2XX9H49Lb+wqctGOLWJDXrixyBVYb1vw4akT3v1qjupf6Adp+Mi/9CrsTNAes8ysXgQ0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 16:32:43 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:32:43 +0000
Message-ID: <b0552a30-c94b-4877-890f-d3f5bbdeaebd@oracle.com>
Date:   Thu, 16 Nov 2023 16:32:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
Cc:     "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20231114223810.634200-1-kartilak@cisco.com>
 <09b84161-748b-c1c2-e4e8-96df5d2b01e5@oracle.com>
 <SJ0PR11MB5896F9B7FA37D78B91BB1D42C3B1A@SJ0PR11MB5896.namprd11.prod.outlook.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <SJ0PR11MB5896F9B7FA37D78B91BB1D42C3B1A@SJ0PR11MB5896.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0589.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c75fa4-63ce-43a9-dd11-08dbe6c1a84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7e57ckHIN77hcBlOsjgqcfdfgJPmGh35Rxw1DpmmKJhAYCtGpGXCpvhNAWayGQ7nIlWflOPQ9aGJoKXiA/v08Z99iHnRGlp6/egwKgo9QX6RJZl62qnN7z4xKiJOhPwBpOTD5x6Z9WuMRnFIBuP99VPKQBaRIayskTfyb5WUeZougxMtBVYqzAP8B3jI6/BDfA0Br2uxqlulMupGdOJI5EFOml09dleOBA+S3KgNIGdgepWvXH7GcF1qJbQTqmCr/LLCFvgvN3MUqgIsghfDzKJ0f3mKovBcyGLnAsbDwcSfQMeidEuD8xH4yHq3JqTMNEf9mhGcUKimI5FEnv5FeWsdYd8gV7kk5H6NxC5ymBVe8AThFSN4c4EieTTjHYwjio7Qq39k466bdZIDRKYHG4pXl317v5R+lSIPL5hBu6/7uEdBsFxU4EV7FWP4CBoTciOPwndJhAzE+6qlH7so3KXNyFZZ5Qis0pNlNWHFFjsPvFvMn9LSwdi0rmKEeZxv5nid2QZmgEuBxOTfIOGZq1TmW76+9rDXDjm+Z+yUtfVdJr+1kwOvq8b3FlXyIWf/EE3GrLXhZDKkiZZV12qx40sGjykPI2an1RbnODW8oH4o7f3JsKHEjAPf+9zICHHLNyk5DAyTzb81AqDn0NlhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(54906003)(478600001)(6486002)(31696002)(6512007)(26005)(2616005)(6666004)(53546011)(6506007)(86362001)(36916002)(4326008)(8676002)(41300700001)(7416002)(5660300002)(8936002)(110136005)(2906002)(66476007)(316002)(66556008)(31686004)(83380400001)(36756003)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJiYXNZZU95NTh6ejlTY3dpcDhIeUFWazM2SUpaRkE5eVhrcmF0YlZKR1Vp?=
 =?utf-8?B?NXhBZkVSeEdEaVFFNFlxanZhTVE3elpOV1FRdmRHbzVLVlB2Tmd5L1E4OXZR?=
 =?utf-8?B?QW4vQ3pUdXhpa3h1SnhWSkw1dVpFTHFvOXExbU0yQXFSUmVLTHIwak0vbFpl?=
 =?utf-8?B?QWNlUCtHQkhrQkp3RHlQNFJlUEpEdFFsL3RIa0doOHRDRndudVQ4bktNNXQv?=
 =?utf-8?B?Mko5bDJMK3VpWWQ4UGdhRGVqVDdPTE54UzJ0bVh5dkxSOFIvcHA0WEt3NEhj?=
 =?utf-8?B?cGdNaVFjMDhCbmJmdE40KytaWHBmbmVCL0YzWFB5eFRoQ3BsRys3TmNWTFhx?=
 =?utf-8?B?QkpZTkFSMVFaWTZCcU9Gb25rREhWMVhZYTVwK1BTaysyRFI3OXVzV1Bsemg1?=
 =?utf-8?B?ZU5veERmeFQwcTkxZGtTa0pHa3EzY1R5SnpVa1c5eUpNTk9jcC91OUFjcTFr?=
 =?utf-8?B?bDZZaE15aXlrZjhQMmFNbXN0N3ZlQ1RwSlJ6eUpycmZGVEtWSzN1aGRuc01o?=
 =?utf-8?B?VTY5UnAwQnBXWm9ZbDdLS3k0bFFScHErZENIWmE4bFVoQWNHbFA4ODBYanB4?=
 =?utf-8?B?aHljRVExNW1DcmNBKzZacnhEMjBqSWR1ckIxMHVmZExPUmpKVlFhdWhaeEpN?=
 =?utf-8?B?SGl4cmx4bW8zWkRNaTNDUVlHKzZZK3Q0Q2VVWXNSU3dsOHN4RjhjMG5aVktk?=
 =?utf-8?B?M1E1aExhOFBVeTVldlRDVzhCdWFRR3IvdTdOaUhLQ2NKNTRHOEtLWWVqRWNS?=
 =?utf-8?B?NUdwM2ZLWjc1cVlzd2p3bGFGT2J3R1VzVnZ1SnF6UGt6WE9ONXZuM2F5Ync4?=
 =?utf-8?B?bUszaHd4U25PTE84YVRUQ1Z6NlRJY09vRzJlZTJFUjFvYWhsYWVLUE9wRUFB?=
 =?utf-8?B?OW13cTNYY3pFL1p4SWlZdlJBL25RdEE4SUhiRzJzZmk5SnQzVFNxNjhkSlVF?=
 =?utf-8?B?eFRJTGhRdUJDQW5YTld4WUVvbFR0SVdVbGxZbEJkbGNXd3c4bGFhdDN2YnNJ?=
 =?utf-8?B?RUh6VEpDNXJPdHBzMGZLVlVldzArVFZJdUNtTG4zTXp2R2dzUWpvbXo5VDRG?=
 =?utf-8?B?RnZQVU1laGEvdmRucFhoMnFtZE80NUZ1WDdmY2c4MkhSWEMyVklrWnpEMjMv?=
 =?utf-8?B?K2x5V1FQdnQrYUcwRG9FenQyS0xIWG9jbUI0dG01RkYvMTlPM1YrUUYyNXho?=
 =?utf-8?B?TE9RSlBYbXdtS3VaNDRFaGxIU2NzaS8xYzJvN2o4M0FwalZHaDBiMmszK0Y2?=
 =?utf-8?B?MWtpSms4bXN5UDVoUFJ1eEc1V2VPQlR6cllwYTk2c00vUklIRXJTcEdhSWwr?=
 =?utf-8?B?aGlUTmNRRVlmV2VSczlaWlpOQnNjOFBtZHJYRUVESXp2MWtLRVg5RWpXNm84?=
 =?utf-8?B?NjNDMzh4NWdaY3NSWXI1V0RjaUwyWTRuaGNCemhpR1hYbHQ0Z09DaVpxRTlO?=
 =?utf-8?B?TThEaXg4MnppektjRmFLbGM0UWZkd05hNi91VUJBNWttaFhPZ3pFcHBNQlp3?=
 =?utf-8?B?TDVEL1NoREMwdjZiUFprUWxQanREZzRCM25hRCtKT2dPV2I2QU15Sk1vYjls?=
 =?utf-8?B?ZjdiOHJvbnBsMnl2eUN5dEllVW5OUmhJcGNzVHpaT1RQdVVYTWlGTmczYVZY?=
 =?utf-8?B?UllNUjRhSU1RZ2JSZEpGMitaM1JCMFFJTmNCSCtTTlEwMmI0QUlGYUV1TUxZ?=
 =?utf-8?B?aUlBa1NSN21oMVM1UW54bHhYbStqZWRiVXNOc3N5WWI4MGJQOTYwZnYyNjJK?=
 =?utf-8?B?ZjlJMDdyN2xWZnI0RWZ3TTFVRjQ1ZkNVa3h4UHpyZWY5Y1Y0aHFxekQzYi94?=
 =?utf-8?B?RkpHSTAxRnFiWEtWOEZhdHVUci9KYzhHTGFDcEFNRXRkTzJ1VDFQRGlkZzhR?=
 =?utf-8?B?Y3pzNXdVMnBLQndEd2Nzbmt6R3ZtTzZUUUFrUnR2VnBJbXRtUUNMWWtDTWlW?=
 =?utf-8?B?QlArQzRYVWR5cjJQcGdtQldYaTUwdE53WE80c0dCUWFyTXhxakNlL0NxOTlY?=
 =?utf-8?B?QXdKaG1USjEyVFVWK1dWZERXWHI2Sk1wcnZ4enFnT2RwMlZ2dWYvbXdkT1dZ?=
 =?utf-8?B?RXMwa2F0VXpXaFkrVTFHU0l1ZWlWVUl2WGIwRnc4N1ozNTdkTEVWMXllNDZv?=
 =?utf-8?Q?Ubk/R9giH08B+mjzIWeNnZdg5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dOESJwRlw6purz+a1w8qNpA7UAgg9pGWb4ARIPl2B38BR/Yroiv+qP0cCqyTbWYqefOQQlcfN1AjckLgDyFM4gUothKdB38aFNp8rDoVhDoW3/m7ZKb0MEQIlq+/Fl4z1MiPWiaDHhaLa6Oamb9bfBILwIm/EKNsRT7e8j2vDYJl/6aIPi1t/2zgFChLYdUXKuatGdmmE29pRhJ9U7GoCLjgX7T39WbX0gAlQAI448XoiA48kHytHgA6CTMEAZjPGtjrU9i3/WzcM4dlRHtbgdBYS1QrgNIj16eJTRZU60s9XY3iiekhjfPRJq47BHtIcMLn+Qw5UoyiBaWGyeKEpOMEIUcFPC0vlyFhfX6xFsq4IvfeKazopbalScfD4PdJwhTwpI0zW95oX8QilDBXW72Lc6N0GvQ+hY6clxX0cNxQ6etLRW6Mjq6MTUa2xAvEIW2We6IaHbNuHsNIAu57hCLNcAs/W/lXmb2WWdlNA5GfUc1pz28TTxnmiNr9acDwTecpe/YbSGjKUvtlaKOXD9xco960AoQtxkhcFhHHGw0kbceg4LPfwqjtKkmyH7de/rp4Hi2rSQkD/DCnJMezhtWOB39ZL2ipdl0QzqIQMvjpnL/mqNcTcD9fgAOPDhKMio8OhvJIUiKKRq0H0ZOv9+CmVmRBMkQUSbsufGwoRjrngxpNBCB58x0bSnWA6oNjXZOvnEBdrDZettnEeSN5xfwya/doGRTWLw5nBotFSPC3QopTzCXxRHoD/dklk9z560fg4AhYAWoKFPtzu80tk/7iCLOcWOIWIQdAaG6SY4xEIPWWtET2MmhDIGsDRZR1KftbRB0Mg37U1of/7DbZSmcRGOFTEXVsklemr+7mvUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c75fa4-63ce-43a9-dd11-08dbe6c1a84c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:32:43.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wudiQGyNVjeuKhykx+ryCZUHeTUue8vEs1Dp2WkZgAclCX6TZjASTV95GuKIf9BVsbZQszqv4NvO95HmYl1Wzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_16,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160129
X-Proofpoint-GUID: rFjlRpiCmD9I8ddagmBype_sPkLmJJ5p
X-Proofpoint-ORIG-GUID: rFjlRpiCmD9I8ddagmBype_sPkLmJJ5p
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 23:20, Karan Tilak Kumar (kartilak) wrote:
>>> +
>>> +     if (intr_mode == VNIC_DEV_INTR_MODE_MSI || intr_mode == VNIC_DEV_INTR_MODE_INTX) {
>>> +             FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
>>> +                     "intr_mode is not msix\n");
>>                        Are these checks just paranoia? I mean that it is strange to have
>>                        fnic_mq_map_queues_cpus() called but not be required to do anything.
>>
> Unified Computing Servers Management (UCSM) is a GUI tool to configure Cisco Servers.
> There are interrupt options that can be modified to INTX or MSI or MSI-x.
> All these options are still supported.
> 
> However, we do not support multiqueue (MQ) on MSI or INTX.

By this I assume it means nr_hw_queues = 1 for MSI or INTX

> These checks are present to only prevent an MQ "misconfiguration".

If you check blk_mq_update_queue_map(), for set->ops->map_queues unset 
we call blk_mq_map_queues() - I am just wondering what does the 
equivalent to blk_mq_map_queues() for you in these other modes.

I am concerned that it is not proper that we have a set->ops->map_queues 
method, but it does nothing in some scenarios.

Thanks,
John
