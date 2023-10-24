Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA137D4F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjJXLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXLv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:51:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD2C1;
        Tue, 24 Oct 2023 04:51:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O9G9r8030413;
        Tue, 24 Oct 2023 11:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=M5WUsNvo18W8Lm0TQ9m/wiMxqHCYw9YANwUKMObAhUU=;
 b=bZGJbMJQNIcpwp7iO7oRfsHSQrWXtjmWVZ1lTD6bqWJF2Otv8M+z3Lg59JaIh9Z/v6i0
 v8AD5P/4XMyezvBXGihcyfgS6xkUk6nHTKWol1z/KXG5mXP25MwpH67aiUwrgFeLl/tb
 DBzj6+r5CFhV0mJXrAfAz9PBVDb3Z1rMCu4RdJPB2PCHNapwir8jUrB1/7ga8dmEGEnz
 6vo708x9wuS8poeuhVw5td48r1Lyg/iF+2l2zcD6hFlzKM06dUfYdN6tOoKJN4EmxFR2
 FLN2KwqhEZcCbWv9F2JadtBNV3/iJ4Ocpy6+3TFmvh7fEvqeyDnhqK9cEWs53d4qkRDV EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbda9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:51:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39O9I1J0034598;
        Tue, 24 Oct 2023 11:51:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5355ap4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg3+lfi5nQIe3tInFIweJmaAnb0z3HulERSMc+ilbFfkLs/0BtnML/h/grWYZ12ueLr9Nea4Me5/ojLd/rbEuhejYZPb+r+KHGogsW1fj9uSo8or6T4EF8pw77CDVRAZDL9fX9ppmmNzgLuQ9AxfIarabDa3mfPS2x1OhNKnPbTEkctIbCxSsMJ+5A52+4wMqsHD6xBAfu9pBn7wxS82l6wnYdyGlzeFeq/XrhhkETX6lv3h6d2n3DEqFwO+00vy5zXve4EKSYPwBUmUwyCYSAxWju0LJnhId8Un9Hxrdn8VBDkah3KN7E04YPJ1E1SvLk52luUTn24nNzV8kB3beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5WUsNvo18W8Lm0TQ9m/wiMxqHCYw9YANwUKMObAhUU=;
 b=jXpNwuo1H6kXDxg+M3j49cMF24Ck/Znro1sKr4ReTpxjeT3Zllr/HYDki98MlvO7HiwkR+MD+ZNsrBfj3cGBEmRwFw8OsepdVP0dlBz19Uks1/mcJ0ARxDfvcFvKOav+WEBa0wS2R5LS4F2HqAbgrpbFe7nLoINiJcKWs48Nxv6D38G5BHztTX47QcuQ9zeIKjCYot7eULfbi9NliOHIWrNiFjZljChpZZINugZ5kQOEtu2KkzwDj2lBXUUSwwcdY5c4ONV2JESKVkFRG8ZED5y104cLVvhNhSFsHCL7pozjg+cARK3nFlpUeSuQAJuaO5Sq/YG5oW5/7sOecjKZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5WUsNvo18W8Lm0TQ9m/wiMxqHCYw9YANwUKMObAhUU=;
 b=DGwCoYj6gi2lTgl5bN3J2BipaAhnAJtu5jbBBGFWU4PgwsOycjO7IjH39wHnH/u1uj3l0IEvm9Svzpyv89riFI7UvaatrO9tX/HqjgO5Z5MH/hcOtzcrb76ooh3996ewnbNgSTFGSdpl7+Joi7YY50difMvZueloVB/nGLeZHuE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 11:51:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::2c06:9358:c246:b366%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 11:51:51 +0000
Message-ID: <20be5bf2-13ad-df49-174a-b9c0e68b8efe@oracle.com>
Date:   Tue, 24 Oct 2023 12:51:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] io_submit.2: Document RWF_ATOMIC
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        martin.petersen@oracle.com, david@fromorbit.com,
        himanshu.madhani@oracle.com
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-5-john.g.garry@oracle.com>
 <20231009174551.GF21283@frogsfrogsfrogs>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231009174551.GF21283@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1573557e-3b02-4e3b-2bd4-08dbd4879c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhqUNjL20jQlXRMr19jfSFu7uIsZEBc6soTdvQ55TiScSEcnObif5MQHm2ltoP5cPbOVV6TgXKjiONHkNWAEKTLTH3XFMGUS7Vykaq9AUqtCQZjhLlHlLocGWvc9/qejsyDnM9q5/BnLgMcrejOo8r7HtL3k1Wz3z4I2E/4elIK6QR8XE0iMaSbUxDIRPv0pV8jHX0WgcW6ddE0rLiZm/elR48FvoQ68B899maekMY+0gPyNsDOuKLJYwA5ssXdbYXbWbYE9FJSnWMB5f1lyEvFQg8EsQ86fuEwYBrYrlszK56Lj08hQfzmyUdX+JHAyfInuYs6XGfkCDHlpTyZpQBzMexZbG8FDxWZ5yDIEG4QGaY7+U4vzFDkQLOsl1us4vziJnS6H81603b4jFtxJ0V3x3BHh/23+v5LkGzkj6yR4oVX6gXUEAP4cCgAfBZo5YuP2fMVFB7Xqdz6qzxdpDCTm7+J1kGr6Dr9QxfKYqXmdHXdi9h+tUBIUWBAyKjKcAZQRWOry/90calS6fpds37rUzgVszSI2dMuZdkOuru+Ubsp4k3+hUbyqms8QuUhWNDTKbgRzXQY6NNrzgW4/d9XtFghaq1E0TcrQrjnj0pqdGwluE6DEGUJEgbCaA0O9uedm60ygMRlFvvKG8iWn/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36916002)(6506007)(53546011)(2906002)(6666004)(478600001)(4744005)(31696002)(6486002)(8676002)(4326008)(8936002)(5660300002)(41300700001)(66946007)(66476007)(6916009)(316002)(66556008)(83380400001)(38100700002)(36756003)(26005)(31686004)(107886003)(2616005)(86362001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVWc2NkZ09nUk1FK1FPaHFzQXpGcFE3c3BWWUNRWkt2dkxlbXcyZmNWMTFr?=
 =?utf-8?B?M21UUkV2SXd1Tk1kSlhPYVdhcEQ0bjd0M0ZrdkdnUFpvQUlER21pNmFPL0Rq?=
 =?utf-8?B?UFZKNGZYRjRmTFdZdlZBQ0dLOWZNSnR2UGlQdTMwSStZWU1meUtxUlRqNmpv?=
 =?utf-8?B?SE9XM3YydTFXUitiekh3Y0oyS2k1UWxncDkwa1A5UUdETlF4ZXRiKytQKzk3?=
 =?utf-8?B?UWJkR2ZpK0FpcE9NRCtGTlZuRXVrSDdCcmtJeTBETXYzTWhKM0cxaGM3eUd1?=
 =?utf-8?B?V2hYOGhNazBvS0Y1aUhYR09hYml1QlBrNGRBWDRJT1cwRzY1R1JsOUFXRFR2?=
 =?utf-8?B?b25zQnU2VnNEQjhJc1dOVjRjdWx3TDRkUmY3bFFPNGlQSVlJbU1DODFTNkV0?=
 =?utf-8?B?R04vVDRwaVdhVzhRNVZpUWJlUFQ2Z0tsMEZOT0ljdU4rb3Y4QkF2eTZnVm5T?=
 =?utf-8?B?Y2t3SDY5MVd4N1c0d085eTFWTlpHRWYzQkFUa0hQY05iK3locU95Rzl4dUhJ?=
 =?utf-8?B?djlHOGZaLzhKTFFsaC9qdlg4YXF3N2lMSzNEbjdYMElKU1ptWDhIelh6QlJl?=
 =?utf-8?B?dDFQbWxuL2RsaU82SUk0MUYrSEY5TTBDV1UxeTNlVnVsWHBSS3F2dVJMM2tq?=
 =?utf-8?B?cld0QTJQa0xXZUtjUk5jeE10bU9XdWp3ZEFxMEM2UTlySHNjSTh0Q2VFbHQx?=
 =?utf-8?B?RHhrM3FVektXNUZEclNCUlVFalhYc2loUWlldnY1ajFMYVdqT0RYNWhRSmVK?=
 =?utf-8?B?NnRCM0RsRTN6S3BNTHIrR25PcUZPL2lxRzRFNEVkOUZzR2JSazhjRmV4QS9h?=
 =?utf-8?B?eXJFSk9YZ2haR3RsYVBYQzZ3Mmk0dDRWSS9lNnl6SmZ3NzNaVU1DOWlabEtZ?=
 =?utf-8?B?V1NNek9BbGlaQ2Jvb3lMSDZDOWFjOURSMEhERDdhY2pNSlQ3TXczcldzQXow?=
 =?utf-8?B?U3VHVHc5ZnYrY25mSno3STh1Skt1ZlNGanhJUVFjWTlOM09HK3NpK21pdXdL?=
 =?utf-8?B?Vk9OOWJRcXdPRENOb29temhGVDdVRTg2ZVBzTHljNGZmc3YzTWJBd2hEbjI4?=
 =?utf-8?B?WUZJN0thNjZwZ0d6eG5FQWlac3U4c2hwS2NMU1NxNm1nRkNpdERVQ3RydytR?=
 =?utf-8?B?eDhzVUNLMUJKNkVaeGVFNGF1eGhVdWVENE1qZWFGNkdCR0lzcERWMUsraEdq?=
 =?utf-8?B?cHA0QVprYzYzaVQ2dFY2WmF3ck5JOEFma1JCMnhTYlJhalF2WFo0cEJKTDJB?=
 =?utf-8?B?N0NDZVFYQzdSN3BnMForZVl5MmxQSlVBNmZZQnN4a052Q25mSXhxMW1XN2tM?=
 =?utf-8?B?aTNnQTkrTVQ2NENiUmtTU1NhaVFHa3lLUnBKWmhWZWY5RC9PVnVjWlhnOFZD?=
 =?utf-8?B?WjNxQjRjSUJFSVpoSzlHemhkajlUcEpScVB4S0llVklpV3BEQ3o1MW5FRFFq?=
 =?utf-8?B?QXgybU54dG5MM3doTzBlNFVUSktuRC9KdC8zZC9ZQU5KMEhvc2FLME8yWHVw?=
 =?utf-8?B?TW54TW9NV2JaR3BMamN0cHUrRzZIZS9nd0QycEFzdTNzZWFMeTdJVmhaVTBj?=
 =?utf-8?B?aGtvOGNNb1B6UmVxT3RsZUNURGZFeCtZRkgrQ1JjWTFDa1RxNUU4enpIeEYr?=
 =?utf-8?B?QnBNSWowazF5c1E5TE94Q1h0U0dXUEpmODRlK3RtZzZnVDV0Q3UydWo5MEIz?=
 =?utf-8?B?S3p5ZDZFa1hxbHg5Mjl3eGkyWmx5RkJFZHJkMEZVNEVDWjRvTnZZTmcva2d1?=
 =?utf-8?B?N0prR2libDVQMlNNeTJ2MXUxL1NkNzNTQ2FtWFkra3JVVWtiMkQwZk56K3hp?=
 =?utf-8?B?cjROcTVKRkx1VkhvcHNkcjF0SWdSUlVmMmsvUVVTZTh4a3JUMXNPQk5wR3JT?=
 =?utf-8?B?WGhaWlZ1eEtkSkhJTVpGUVArU1dDWTFqcnVJVVgyMzF0aExXeUx5QlpYY1ZI?=
 =?utf-8?B?a1BwcG8wd3VteEt5S05KNWhnN3pJd3E5MDZpVFFDaDR3SDM4K1VVLzNZc2ZB?=
 =?utf-8?B?RzNjYm9TcG04cTNIRjZxOWc3aEExR2N0WXJ6SHpkYWNKYXdWL1dwalFSbXNM?=
 =?utf-8?B?UVg0dXFYdXc2Vm44SWV6Rkx2cUlkUyswTU9iR2FzSkZ5WjRYN1F4MG5BUllv?=
 =?utf-8?Q?QXZIVWLRaRYa5/EeRxyK8jpKk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HMlK0TCzyL60TGoZeX9fCCtfC81RbxZbEAenUXd0z73WuYzXPxVBEhGaxqL7i1ndbbQtoUPUq1Rt8iu6O6DE+u+fqEqp2KSoa+G6SKVWXxjDJs03Egqc64NYuiMyVN8ysZwsQBvMFGjhC2rOFanuIMxAv7GdXISyi6vjrIklfdc4ZSkgmapJIBH1xCG7U3hvlFkhESpP4dsCmN8N9gontl/K7SOhWT0f9/BUNEGVAcMjt4IRI2PbgRS0ihd95p0YFo7z1tMq9yLcOJcqCuSdDEugJ9Lg85QhrME46L/NUbVaFxVOvzGHZrmmmq2C+dE+umA2aZGwl5JGOB/5Tl+k/b9hC3BuLtQXED6YaEcSyoC6srUWpc925V2h2m0aZtTumRSKtk2zVRlm58SNNpQN5ZebS8O0RmCD659onCAcOQEOrSoMkKgQ5jExeXhrJzTBzKOw3faDq+PKPPlbRvK1nH7fm49YlF50bmsOtIaK0VREyKNak0SkiPaPaeVzkvZIMgsodCFT5jIHIpCcC3VId7eFiCAI2kijlTvSDdhCcQniNBAV1yKPwUKjM+9PWUcKuRROKN2tbMZjVFI2R3nGXXV7SCRZsMBEPA/rhKRy7elbJoQKEQyW2v51vkcOdtNNWJaI1IavjE8QT0xZNraEsjJHJrom3badlPovLEPzBXT+FAc5v2cIPUv8UZcX8jEsDgQexwUHU9Z9TwiMcWnXT4xwNxYEdzjpHk4RZRsceld7IT43W5EeF6OygGbMo2wecWeP9U3H2PzwE6nOfVwcsW06sPpRb7Df0S4KzkRI5KdMCr7B/Gm+Jk3tSB0s863N3vVjkaIMtovaumrju8nGXg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1573557e-3b02-4e3b-2bd4-08dbd4879c28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:51:51.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6Mu6jPyFljDjd+GofIhiiR5lRwnK7ICG7ckUKJ+53pdfkRwsno9rNkf6tmXJjIpExV12WaMCSGxk4f9Z5+dXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240100
X-Proofpoint-GUID: dLNw0F7kPWEs1NCvv29MUSoad08o4L0s
X-Proofpoint-ORIG-GUID: dLNw0F7kPWEs1NCvv29MUSoad08o4L0s
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 18:45, Darrick J. Wong wrote:
> On Fri, Sep 29, 2023 at 09:37:17AM +0000, John Garry wrote:
>> Document RWF_ATOMIC for asynchronous I/O.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   man2/io_submit.2 | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/man2/io_submit.2 b/man2/io_submit.2
>> index 1030bb6cd965..beba8865ac2a 100644
>> --- a/man2/io_submit.2
>> +++ b/man2/io_submit.2
>> @@ -140,6 +140,11 @@ as well the description of
>>   .B O_SYNC
>>   in
>>   .BR open (2).
>> +.TP
>> +.BR RWF_ATOMIC " (since Linux 6.7)"
>> +Write a block of data such that a write will never be
>> +torn from power fail or similar. See See the description
> Nit: Double 'See' here.

A bit more than a nit, it's something that needs fixing :)

Thanks,
John
