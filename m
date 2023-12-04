Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C273803583
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjLDNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjLDNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:52:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7FF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:52:58 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4DijNW003917;
        Mon, 4 Dec 2023 13:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kOUU5bRA+tI0TaV6ACp7qId8c6Qr5yfZBcnKXpUlHVs=;
 b=flnc7Dr9zz7HAxH/kKRI1UzO8hFB8hgwMsC3Rk+39QrDogTAvtjJnto/I+OdpHVkswxz
 pYebe25FvNm7ec8Ab1tmBhE0BOCGb1B/F5cKRCKhc3g+YMo2JBCWmmCtAlvgyC678xe3
 ODqYnUy7OBPDMinlCqSdeyFGpVsTjltKs71UgDIfBN0mrkHuuj+T0bSBBWpm5C7T1W6P
 9n1n0wnTdndtGBg+zmA2GES8j6+xmHtTwQumzZeqhiSpeBbcdrKTs2abLCwHiyE6afHo
 TtGIK1Vrv/rz+Py+q3pWYtkT+A4imMBpoWcC4CXm5cuVMJMmRfphz4q2ehi2CLr077fP 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usf0mg3wh-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:52:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4CNftM014583;
        Mon, 4 Dec 2023 13:37:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15rxrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgexgvqvoumsgAC+rk03NBfmMN0LtJRBiil1T9d4sU87UAbO63BKD4kO1I5eEROwH2xtXha5lveva1TFM2dF08+cyz5KKA9VDvco8uFkuYt7Uc+u3em7egfF84bACKysWVrIQaDJZh7C107Cw+RoP4b9aCc8muC5IHUJoGYGnxRjKGkZ5HrFf/h6ub9gUlTjNkJnnWouoMtT0aSM0hAB2kXGJ8UFz8IaeUrgoxO78cmsrx1xxicePrA0HFBn1grwohjEV72jXIjdZhyzjNM6ObO/r8/Bc59EOJXRd3Lx+LBH8KvnhnmyJniZfvJUOHtblVjAfG+VQhhUaLRWtp1Efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOUU5bRA+tI0TaV6ACp7qId8c6Qr5yfZBcnKXpUlHVs=;
 b=Z1quLiwdt8IrIiHOrfx/q0DWvl430WJFYrUK+SLuwSh6sWcAOSLmB55/lQ4hfhFYDy/WGc3Ps0sqK6W8Z20ouy8N1d3xtLbA+7p06mMmR3y8Css3EKBzWU6Pa8AhjSjcNyxVsp1NYKpzkQ17C+hP0bR/dLJ2/6nlji3ch0eHCeTJj0I19Zf2gKrYxEXcJD8OFITza27sYTQe6SIGKvbs4gDA7Y+hr0yqFv3MahwOv8Lsuq2T3CqmPLzNQ/AqGbny0uU4u5Ux4UgNRA2KPDDu36lXqSU74hPq1PMuTcB0J+as0nz9EjwHa9O7zrzxnLLTvQ0uy/NCPt4XWQnqx0NE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOUU5bRA+tI0TaV6ACp7qId8c6Qr5yfZBcnKXpUlHVs=;
 b=RHfhYV9fDipbAyz7d19pCD31WmDjxDeQpYtJ3uRKSlnS8+M4q+ALYKsuR/uXJ5I2u3cgY94W/7R1BhAUGz9ZF1yQg/xtb9beGfYgjrn77vH8N0ujklkovB++VMVwJe1XwzFaL4V8zC4w+cwA0STzCBLNw1BwcJw+Osb519mPQKo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB4897.namprd10.prod.outlook.com (2603:10b6:208:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 13:37:10 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Mon, 4 Dec 2023
 13:37:10 +0000
Message-ID: <a0b808bb-a123-4030-9e51-f40226c7ed56@oracle.com>
Date:   Mon, 4 Dec 2023 08:37:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] vdpa/mlx5: preserve CVQ vringh index
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
References: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
 <22981f62-5c57-41c4-8ed2-a11b7b93d062@oracle.com>
 <20231204083524-mutt-send-email-mst@kernel.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231204083524-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:a03:80::16) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: a88599dc-8a27-4663-70ab-08dbf4ce1e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuSDF50JoEuTBTyiJapY4BjeYcg7wXzx9HK+7Q/vI6223b2N+Ej1A5bcV42ItyJTafIhn/kPg1rModekxIzbN1H5S8B62BRdgfKe2zz9lVN1doE55NGIg3GxAPoxV+pRLJpTzFATR441yA5YP26OE/6eH+rjGuq9sIsCIy2TCQ85JsJJsGv0r90XEc7rmZixXyMy1d2TOv0rjRYymtKVr90kwLkctsrx0FbMbOG7LfofTiIcYwoRBbBhnQy+cSXZ15LXwxqYYgCATuH+pnh6uVN0WtiUMy+GNlBzaxLul57Tm7aKbq1zPmGkxSSNhhyvv3EGaYGlpjqO2r4+NUofmtJ9fKiXUosvmBpYW7uQdcRL60jh4u9KYCL2zi8T+XqRl0vYeB54DbVa4np6lWxhna3Ni1VblylZDztFCLZ03OnTr4uPUtjPvhmPo8QjRFmj8bHjkdhyZJdS+PQUshQ9/J0S6jVg7CYB10AgU3bEkaIKDuYTu1noy2v/UVEUmExQ4lz0sM4Ll4toLwW8/M8iQTRWO/EkEzsIXUiiXF9V0X+TgargG4fgUEPEy3dQzvG5kr+lVyhe9UV3mN6ToWLADbyHeKezSc3b6AJthZ25SaQQstUvgGXK+elyDMyyIRPlkld2R0qJcSoG6otUdKU99A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(54906003)(66946007)(316002)(6916009)(478600001)(6486002)(6666004)(38100700002)(5660300002)(36756003)(41300700001)(2906002)(31696002)(44832011)(86362001)(4326008)(8676002)(8936002)(31686004)(2616005)(83380400001)(26005)(66574015)(6512007)(53546011)(36916002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtrQ2x6REloRzhhdFBqU2c4M3ZHREU2ZW5GTHZqYWZOZjVlRXJPQW1jRDR4?=
 =?utf-8?B?WVk5UEJPQlRtTkU4RnB5d3o0eWdZRktZSW82V2ptcCtFM2ZYQzFvNldVcCt6?=
 =?utf-8?B?L2hrRWhEcE1nWjlNYzVwZVJQOHMydjIxSW5pUGJkKzZvMHBqUHFqQ2h3Z2FD?=
 =?utf-8?B?UHozUWtwNWcyQmUwMFRKTEk3am9OdVM3dXpuUGdpR3BiOWJxL3ZjcFFpMDFH?=
 =?utf-8?B?TnU5enVmK2R6ZEFhSklQVVBtcGQyZXlPNE55SzJoOTFLVkY0R0FXcHh6M2pY?=
 =?utf-8?B?cXpoU0h2c0M3Zld5MFU4VktNL2xwZ05RMWsrWHhsUWFCUkh4ZGpwYXJKcm9n?=
 =?utf-8?B?ZkdvaG4rcjJUdkpQY3ZXYjVIL21BaXBKa29tbitneUwvSlU1Y1d0b3ZERnR6?=
 =?utf-8?B?V2REZlZlcDh6UFVMblVMREZVQWpCM2F4MlBNRnlETmQwcXFXTUlvSWtvZjZF?=
 =?utf-8?B?SWFNT3l4UWNKQzg5M0l6K0ZWWjdlNXRRemVLZlVDc1liRDBsSXRxREFwN2hn?=
 =?utf-8?B?MjVHWVJUS1o3OVdHYkhTUHg2dUtKeXhXT2R3UE1VSWlqclcyMjhNdWN4b3BD?=
 =?utf-8?B?eWxOZ3dqd1BXRmJRSXhPSDdSQzlhK1lzUkI0TlAzQkMrMHU0Y2VPdnRrTkN6?=
 =?utf-8?B?OVZ5aGd1K011YnR5R3RUYk4vREdzZTBWT00vTVR5OFFnSENwRTYyTVBtZ01T?=
 =?utf-8?B?bDFaWGNmRWpka0srUEpsVkF4UkJUay95bUkyZ0tQOGVsM2dsZHhSelZTajZN?=
 =?utf-8?B?ZVlmcXZraXdINGprVVU1ZEpReVR4aXFNaWFtVjNkcWpJeDVmejVoM2ZoV0ha?=
 =?utf-8?B?d2M1L3Jnc1BwWHhQM2djMlFYVnJZeHNpTjVvUTduc2pIOTZPQmQvSlEzeEtm?=
 =?utf-8?B?SXdPNlFpT1lmOVkwM0Q5aUVDWEM2REhqMyt2SmNPd05iSU9RTi9VTGFSMEg1?=
 =?utf-8?B?WVF4d2NKaTR2UWRkOUpqb3k3QWxwd3BIczZLOWZ5RDdxdWZLdHpMS2FjWTZO?=
 =?utf-8?B?QWpJbW1kNDhhVUtESUJMN3FEcEdQbnFBNXFMUVJxZ2w5NXM5NlRvRGFWMG9q?=
 =?utf-8?B?QUJxdU9kbzRPMHo1bCtTVGorYy9ERE1hVTVoWk1RSFZLR1lGNWpmdlVoN3R0?=
 =?utf-8?B?OTEweENGOVBUYVFwWU5Ea1FhVTNmUkFxbGxrdUJ1VzkxbFJKSjBBdE40aTB1?=
 =?utf-8?B?aExGUFFaKzBCbXd3Wk1OZ1dzc3ZJTjN4VkEwZUFkd0VrYUVOcWpRQUpMWnNG?=
 =?utf-8?B?SkYxY3E2UEk0RnRLREh5SjI0bFpiWGxIYWwxUHM1Wk0zMGIvMFA5M1dRTHp3?=
 =?utf-8?B?T1dIVmNMWWtKMjIrcEpJSHpOY1daa2V0bVcxc01zWjU5Y2ExdlhiUlYxRGF1?=
 =?utf-8?B?emdDZkpDMlVXVWRiYmxVU1FtR2VoT0ZtSmN5S1ZYWU5sSzNQNkFtTm9aSTNV?=
 =?utf-8?B?azZyZWRpcm92NDhPTGRKdXZiZnBORlgyOFRIc1QvSHQzRHJVMU42QnNCbmVS?=
 =?utf-8?B?djk2cXJnMStYaDlWOE11cWNEUnE5RXhhQi8wbnpxLzJkcmVvSkx2NHhQN3Av?=
 =?utf-8?B?M2pGTmlBVHdHWU9iME51d2ttTWkwUUxDbWFGb3p5bVNEN3k1enA5a2JUZmQ3?=
 =?utf-8?B?NTJoYVlhUk5yWDBBSWVMYlBuZ09GMFJXMzI4dzVjalVWZUtPQWFwcGpQSlc4?=
 =?utf-8?B?R1R0aGdVTkR0REFRbjloY242QWtpOHdPVUJjbGNHOXUyZ2FjRmdwYlFyMlNO?=
 =?utf-8?B?VFlsZURURnZOMDRTNlJ3Uk1Kcjc2bThRN3ZiaHVlZE40enFBSHc3ZG50WSty?=
 =?utf-8?B?Tld6K28rc2NIMlVoK2MwQmcwQ0VhZ3N4YVNIdGtzcFE3V0FkbzhHaDZKK2hW?=
 =?utf-8?B?QWhCdkJFSmJyZ3RCOFFKSGVOTnlPR01UZ2g3T3FBVG9XdjNmSXFGVjE4MnFk?=
 =?utf-8?B?TDhxTDcvRWZwbkZmcFVDbzhkUnV1WG5XUFNDUWFucHlURkJpUDFyK3JtbUR6?=
 =?utf-8?B?Yy81U3VtNlFtYVZIV3krMDhOSDJINmpHR2VrK3JnNW1OUEhKMHI3eFRzemdZ?=
 =?utf-8?B?WGtVMHF3bXhyR0xLM3hFZExDYU9lRlBMK1pLbVYvRFByWExBdVZFZWhuT1RF?=
 =?utf-8?B?Y1V6SmpuSk9jMU9ZY2NOYkhKblBLb1NtL3o4UDBkMERmQWdBTkNzREhZSFdI?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d242cWJiU1lTaHpXSko3SE83VUU3anRKU0xOcG9lazRwT3dTcU9XN0tvenBD?=
 =?utf-8?B?M1NUMktvYnV5SUJVejY4UTZ3SlVpSXJReGZ2QUtWNVJFallFNDE2MkdrTUdj?=
 =?utf-8?B?TUM4dFFWQWdteGIwSkpuMTZOZUh5Wk5sSGoyc1J6WVR2dXNET09DNER6TFdZ?=
 =?utf-8?B?T3BWMmRkbjlJT1E1bm0rUko5TVBod2JhQ3BIMXIwT08xZHpXMlRTcGZ4bVRm?=
 =?utf-8?B?cTBLNFdrNjN5Q2M4dDE2bDF6NHJ2SGFDaTMxQUUxVnpmSHdFaEgwWjNySmlB?=
 =?utf-8?B?L3NpSG9FLy9YWUc1VlpZSmt6SzkyVlgwV25Fc0RBaEVidGdhSDJmbGdsZ1VU?=
 =?utf-8?B?d0tWSkkyazkybEtPNld3ak5wVW5WSzE3eFRibWo0RG5KVjhINVExbEdTOWw0?=
 =?utf-8?B?ZEo4NzRIQXIwcjBaNjVGZTl2ZlNBRVY2aDVhSjMrSmRPUjUwY2RIcFo0WC9I?=
 =?utf-8?B?Y09pOGNXWXV2UjBFc29ML0d5bDd6dXRiL1RrRTNtL202bnM1NDZCVTJRa2tm?=
 =?utf-8?B?QnJrTHBiK1lRelVMeTFRWEUvcDNDbUJ0N0Nnb0pGR1o1VXBhYXNlS1ZGRm9G?=
 =?utf-8?B?V0IwbHBreXpTdkdMZit4b0FCNlBCODk0MHg0MXV5UVhad2E2cEwxNWJvaUZB?=
 =?utf-8?B?ZVhJR2lsd2pxdmZHNEFLUGhjdjJudktxYXRtZmJybDJCQTV2dE9PN3phWFh2?=
 =?utf-8?B?aXpwRE1JejBzRHczRHk4RG5BZGxHMXhteWZQSUZ2Szl5NndMV1FxamNDRCtE?=
 =?utf-8?B?RTNGSkFPd2lhamcxZVlLcUQ0aC9VZXdPV0dFM3BwUmVWNVhCNm82TVEwQXdt?=
 =?utf-8?B?MGV2czBialB2L2ErM0ZEYjlnc3loT2llZDkzZ1I1am04Nmx1TGVIWDZnQXda?=
 =?utf-8?B?Q3VIUHcvZmNHS094eTZGbXZDakhIRjcrTTBYMXNQaExrUHZWTDFaMit1SnF2?=
 =?utf-8?B?a3BweXV0VUVxVXQwdTVHeVFSZjBCVU5kUU9OaDZ2dFgwaS9RTVZpSmRDM2xa?=
 =?utf-8?B?MG95TFVQc2hmVWhQR2lqaGdKcVJsYXN2YWhTRWZDLzBUNmorK1dRZm5EMWdx?=
 =?utf-8?B?N3lBbEFDWVYwZmVrOHRYSXN1UG0zNnNyRnowTURoc2tYM0UvSHRnSVcweG5n?=
 =?utf-8?B?bDMzQmFYYkNCc2h6TWhQMHZsQmhJTkUzSjNlSTBsME8yTEw4alovbER6c2lT?=
 =?utf-8?B?UjE4blFkUTlxYUYzZnM2ZXcvSHpmNDVLTW96ZGR1VGJ3bHhXd2cyNlVPUTJy?=
 =?utf-8?Q?xGvdfPJjJFx/peH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88599dc-8a27-4663-70ab-08dbf4ce1e06
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:37:10.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QOhrgtmQC1JV7J1hH276BWyI3zdLzn5FgVbkMfQlF3uGx7EXJ4bnA6aAX5Vso/iGLSdX3yb2GZ8mGq+hNOwB5qu6eSPle0L93hGYWjPJZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040102
X-Proofpoint-GUID: w_BJDFgaj0eCGUhF6efTO-wUtszyVk9q
X-Proofpoint-ORIG-GUID: w_BJDFgaj0eCGUhF6efTO-wUtszyVk9q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Glad to hear it, thanks - Steve

On 12/4/2023 8:35 AM, Michael S. Tsirkin wrote:
> It's in my tee and I'm sending it to Linus.
> 
> On Mon, Dec 04, 2023 at 08:33:22AM -0500, Steven Sistare wrote:
>> What's the decision here, pull it, or do not fix it?
>>
>> - Steve
>>
>> On 11/3/2023 8:26 AM, Steve Sistare wrote:
>>> mlx5_vdpa does not preserve userland's view of vring base for the control
>>> queue in the following sequence:
>>>
>>> ioctl VHOST_SET_VRING_BASE
>>> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>>>   mlx5_vdpa_set_status()
>>>     setup_cvq_vring()
>>>       vringh_init_iotlb()
>>>         vringh_init_kern()
>>>           vrh->last_avail_idx = 0;
>>> ioctl VHOST_GET_VRING_BASE
>>>
>>> To fix, restore the value of cvq->vring.last_avail_idx after calling
>>> vringh_init_iotlb.
>>>
>>> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Acked-by: Eugenio Pérez <eperezma@redhat.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 946488b8989f..ca972af3c89a 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>>>  	struct mlx5_control_vq *cvq = &mvdev->cvq;
>>>  	int err = 0;
>>>  
>>> -	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
>>> +	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
>>> +		u16 idx = cvq->vring.last_avail_idx;
>>> +
>>>  		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>>>  					MLX5_CVQ_MAX_ENT, false,
>>>  					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
>>>  					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
>>>  					(struct vring_used *)(uintptr_t)cvq->device_addr);
>>>  
>>> +		if (!err)
>>> +			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
>>> +	}
>>>  	return err;
>>>  }
>>>  
> 
