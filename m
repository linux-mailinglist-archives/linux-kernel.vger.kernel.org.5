Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9067CFFDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbjJSQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjJSQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:44:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868811F;
        Thu, 19 Oct 2023 09:44:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JGDvbS001073;
        Thu, 19 Oct 2023 16:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bS5/w9QsqSwuyuHU/NdG5FlsP+46H3AYPKDf67jaLQI=;
 b=NdSVcfhxRA7KT/JxkYbx/VxMDA+wF5V3YzjbqTlDaQQAJTCf8q9456cMTpEkzr4g/onJ
 OrzzsIpkIKIMRJ5A4C4TjKsZGuSdDZ6pSex5zPIaqt3Zd+HdGCUqgzkrA6ZEnRz6ElsC
 iM2Z8whuG30Vwpd42HEU6HnPsuRn7pzuX79LqIofy8LtMLxRXoCi+WkXC4igmEkHqz/e
 K4MrQZyQm9WD0Q4atMQ9bJDYZuZN/I+uOwpSyvLpaWzY/gjhnhPb//aZvHk0t1ygnX+y
 0ctxixTlJg3CDK7f/1mZdBx9JLPZ38AGQjhuNJ3SKgi6c4NKsjN3TwZt0RmvTRvW4mxS Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1bu2pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 16:44:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JGKDh8021568;
        Thu, 19 Oct 2023 16:44:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg545g2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIPXakxJYvZnDyW/txcps4KIG7i5cgBrbZucjeRHOqNRtJRXFIXi6zh0oQA0wYh6fj7VrtKqrIp9KojlDBRS26cgxQrvyYJOhnv5GU3p7VxT+W3OtA9/RAD1QxBEzvXZk1LIE0qf4B9CWBL1t6qMOHz3XuXYJCeLH7WYyWoNE9grcayv/W/Fyz/V5xI7C/eXAQtfudm28zFbBwu0w+3YI9e4acmGJk5bJTYFAJkBcYZhFoPMNd4BZiQveaIsjHqOJuplnEfSeWFtEnVZXijcAZ7EmXQgdIcQ0G6oKTlngZM0fwprw6SFkArf53B+mksNqwAbjuBmeRHn6COFudCoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS5/w9QsqSwuyuHU/NdG5FlsP+46H3AYPKDf67jaLQI=;
 b=VEDFKntPwvEXilgg4ow2oGgSdBG+kldr7PWFF7X40EttN0FVxurxPEaf6qiQSdkX7iPLanZFvU9CjdXSZRD7/CHXJXNUAh9d4QIZ68mUxt9xLmgHv+cxRL6H8gia0pzJFxMjtFCsbg6nDdD0sE2IUfV2fF6zpF2nTtxtgPxhnBCeJ5JWiztX0XU1CiE/pPCH4FtHAGCW+12AwvDi/ivvnHgwM3AjT78Gd+Z7EkCHIHnJ9inuK3jWUv0PTyNdKrM7F7JLQQMRhTTnwItl4gA/15+VwqbyabosPH0oIcbPdJ7gCEnWVSQtildLu2ehsAh8Dh23p3W/l2fUNyBUORv7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS5/w9QsqSwuyuHU/NdG5FlsP+46H3AYPKDf67jaLQI=;
 b=Z0tJWVxZm85kc8/yQpQQ1cSwg2O+Im5fYUpyXaycfxEZtWvt5RfPVobLzIFt1lx50VTycxfmXc7uPX39hEWfYq4IRX16kbP9Lm6EWQBIzgjPtedYcXuZ5WLuAwl76O5kUuGsqA9gZvhNZd82SepF8l7m1M6vT/u56ZFJnWQm4rs=
Received: from CO1PR10MB4563.namprd10.prod.outlook.com (2603:10b6:303:92::6)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 16:44:21 +0000
Received: from CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::b0e5:a37e:64a0:6866]) by CO1PR10MB4563.namprd10.prod.outlook.com
 ([fe80::b0e5:a37e:64a0:6866%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 16:44:21 +0000
From:   Gulam Mohamed <gulam.mohamed@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] Consider inflight IO in io accounting for high latency
 devices
Thread-Topic: [PATCH V2] Consider inflight IO in io accounting for high
 latency devices
Thread-Index: AQHZ/hoaiR7GZT8ggkid9oX8ZtKxUrBM2pawgAAVLICAAHNRMIAAq74AgAHbHvCAAANWgIABbT2w
Date:   Thu, 19 Oct 2023 16:44:21 +0000
Message-ID: <CO1PR10MB4563810AA52A2928DF8C80AC98D4A@CO1PR10MB4563.namprd10.prod.outlook.com>
References: <20231013195559.1306345-1-gulam.mohamed@oracle.com>
 <35e3e173-8018-42d8-a6e8-7ba994ff6b17@acm.org>
 <CO1PR10MB4563B1B650C89FA32B60AE1298D7A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <d10c329b-85c9-4bc2-be00-f156c48639e5@acm.org>
 <CO1PR10MB4563AA8AE670E9EDBF3AF32B98D6A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <8f239910-af73-4363-abca-d35c5d6d3216@kernel.dk>
 <CO1PR10MB4563F2D918EF5BBAD98FC87098D5A@CO1PR10MB4563.namprd10.prod.outlook.com>
 <eed61ec8-607c-46e2-ac3b-9121ba64c376@kernel.dk>
In-Reply-To: <eed61ec8-607c-46e2-ac3b-9121ba64c376@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB4563:EE_|CH0PR10MB5211:EE_
x-ms-office365-filtering-correlation-id: 7b9d53bc-8399-485c-6466-08dbd0c2a521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNAhge4JleR7O2oihefVsnrxRQSgZ1cXnwNbiQFX/s2Hu2T3p9O++jnEk0WK9fU+N4w30c53pKstme/YSHszSweciJ+zQeXlLKTBp20NGM45W18ymP2ShJYIccRl7LB2dLRXMzoEYZH5pRQAjQzg8ba8IxoAo/1lZIaJfhahCgTDKYPs99p/rnqlaRipDrdAwK4RhrSls7Zjii+VKy8UCie6GZooq2IKDjG68mL8wgt5PI61xNIgMqyQPOWL57YNAU3xSZJlVzf1aQz4+IjcKdOhMk3cmrl2DyKflqVcJJtn8UfhxSwSifltEJkKSvmwy737wxXEz+0gzxqtqtehGFJ6snbTsxCNViElFT50PwAnjfniEEdxffSDLUQY/IrYKF3DSBeRvpGgnUIvod8rSuUPi0P7oBE+oNzh9KCjKtMf5VqcN+boFnS921mEYPeI9aquTbcl1cbCti6terW8/wPoOxj5FTxsg9fEuVPYnVKGg7cLoKWv2KlXYsSbkjt+o5hX1UYKSs2qhWqPpYtxZ/DeEs6HdM20q5t3OBYUmfuCmCHK0I9nSmwJa9HoR6ZP4XoW+FvJGICo+pVwUgOFG9wFvcxFJMqM0PlHikFXiHIe7tmpnBf8IsvUa7CfECkR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(86362001)(55016003)(66476007)(66946007)(66446008)(110136005)(76116006)(66556008)(64756008)(316002)(71200400001)(8676002)(478600001)(8936002)(33656002)(5660300002)(44832011)(41300700001)(52536014)(15650500001)(4744005)(2906002)(7696005)(38100700002)(6506007)(53546011)(83380400001)(26005)(122000001)(9686003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmVPTWVWU0RzU2QveVZzazlQdE5tL0gzM053ZUdPTnBZTko4ZExVdDd6Nlo5?=
 =?utf-8?B?NExGZXdkOXEzOEtnV1hxRDRKeHp1VmllZUY2Sm9oVWdzNmJjd1NSUUZ4VGRU?=
 =?utf-8?B?SXVnK0JxMU9BS0k1bis3MHYzb2lpQ2VSdTM4V3kzUEc5blVtUlZDNVhJb05E?=
 =?utf-8?B?RU9MWU0ybUozdlV1bWZIdzQ4MlN4OEVaSHB6eVpQeWgxcFZEQzhud2pTY0o5?=
 =?utf-8?B?ZXJCZW1BamkxMWhzaWdncDJrVm9BN3BzWDBxWTR4bFBRMjFsK2sxd2FLZ3hW?=
 =?utf-8?B?clNDNkxCOXc5ZURKUDIzWmZ2ekUzankra0d6RU0wSm1HeU92a2M2K3UxMkVM?=
 =?utf-8?B?aTVzek9vYjlXcFBCYnovYlE4RTM3ZU5JQ1MrTEhHVGE5OVpjRXluYmV4RStn?=
 =?utf-8?B?UnViZkNoQmY0WXNVc2U1c24wZVU1VDRWNmRZZ1VLdFhJQVMrWi93cjdWc1k0?=
 =?utf-8?B?V2tCdDZxbkgzZUVmdlFjUHNDdVBYL21QV0NXYWZpRkJxSmxOeC83bHg4cFVl?=
 =?utf-8?B?ajdqMmV0WWZ6VHUwa0ozaUZuakIxaHYzaTdhUXlUMjBlVENGaFFLMWNpekVW?=
 =?utf-8?B?RU5yUmpnUlR6QmRmdU16bDVLMTFnK1RwY0hJdnF4OHZnNVE2N01FYzk1QmYy?=
 =?utf-8?B?S2dQRlEzR0JnWjNUNzFEMzJ0Qnc5dFhtN3hLSHNrMi9wcUZhckl3QWVDRVIw?=
 =?utf-8?B?RnRsTkkxYStqWW83OVR5bmFEODFEZlJXUlRHUmZKazRvbFpxQy9Fei8wTjUw?=
 =?utf-8?B?NjZISk5JdmQxSkljSkpsNUxVelVhVmcrOExQWlVHQTFudDZGNWEwdlNJczRr?=
 =?utf-8?B?TUFwVXBlay9WUGZSQ0pkT21kVmE5b1o1MGdtVGIwQzJ1UXg2WTV5dUY1akF5?=
 =?utf-8?B?bkhMZnArYTZXL3JyS2MxRlByOGU5K0dMcWtGNEtvR3MxbTVFVEpmSnlaTldm?=
 =?utf-8?B?TCsyTk0rckZrSFJrMkpnMEhrWFNPYVpIYWFTQ1dOSGtXN3EzOW1GR3JLeUs2?=
 =?utf-8?B?RGZhQlFmMkdSemFkUGtUYWFYb3JCc093WlJwd3E5WDdqL2tRZzIvR21qa0x4?=
 =?utf-8?B?cGNGV3lBSGNMTTRQZVEyK2tCTkF2T29OeHV3aysxc01mRk92VnpxOGFScUxm?=
 =?utf-8?B?ZExqblM2OW1Mc05GOTZJS2QrTE51WGJ1cWNKUS9rRE5EcTE4TGRHbmtjL3VX?=
 =?utf-8?B?R3g1dWpTMlF6S2ZCcEZWbUlDOUYwNjBGaG13WXBwdVN0MjB5MTRMSlpVR3F6?=
 =?utf-8?B?UHlYWjVTRDlWY1k1V2dVQjRoem15NHBYVnhHQnZmWWcvLzR3K0IwaHR0N2dk?=
 =?utf-8?B?S3lzaHZxS2UwODNOMnRqN3U0VDM4VGlYZ1pIUkNVSkdnY2ZjcmtZbzlTOHdK?=
 =?utf-8?B?dGIwNHUwM3FHbTc4MFNwWDlXYStVVmxOYU95NTZCell5enBUQUh5YnhsMGw4?=
 =?utf-8?B?T05ma3BSNlRJcCtYS05nS1M2WHo1Y0tiTnVUc24vTWFjV04yS3pWbDhCai9k?=
 =?utf-8?B?SlBZQUx5SFBpVFZvWFlVeXU0cFVTb2ZGLzAvQW16OGpRVldJQ21rUmVFdlQv?=
 =?utf-8?B?ZWFOSFBtdGVKcU5vc084V3hoZ3I5WVBCSlBOcnJ6NHUwdTBPK0xOSFV0KzM4?=
 =?utf-8?B?ZGRyQnpncUdQeFNGRFh4emNTKzEvMGYxb0xtWFJFM1ZxdnI5RUhpTGIxVmFx?=
 =?utf-8?B?dFE5eVlqY1J5ZjdnQ21zdEtUeHZmUU5mcWFGUlRWVDBIaXZIK1dRVHpXblls?=
 =?utf-8?B?aWN1aEtaMVpzTmJIdWNsV3hzRUdId0Y2STNkUHpuWXNjY0dKNXpjeUZrakxY?=
 =?utf-8?B?Y0pVbHBLU2pSM24zMGtnYzZ6Tmd5SThMOXUrV25zcHpLTDlnQmRZWFBkc1NQ?=
 =?utf-8?B?WEFpOVZxWG1rWUliUlRWRU5DOVM2eklGS2xMU2RBNlE3MlI2dW5sdDJRNFg2?=
 =?utf-8?B?UkpnQkw4TVdCV1FTTVZpWjlSUUR5U0UwekpUZkRuWEVQVFpVSWhDK04vRE4x?=
 =?utf-8?B?eVBWNFVoM3AwMXh2WElreUZqeXk0d1ZGTlE1MXBaem9La1RXakd6dFN6NWJV?=
 =?utf-8?B?VWJ1dkwrejdha3lDMEFOWW52cGYvUERpVDkyZWkyYlY2WW1vV2Z4UGx2M3VC?=
 =?utf-8?Q?EdpSKXgKF9SNO6jZDHyHVj0pJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M/IYYfGqs5lmOAZsdDHfR/Clp7ZHpGvjqcMqUUZhq+564TAAMAlgZ6FqbZ1jSLwKrAIZX4FSIrmYelr4O0/CiMSHtbcsAEBgNf3LO7Ti0uZUBSzczjqNbMuDSvhDmmHd8YMTBg+oLEgP0e8zZA2iRkvJoPrV+hVxpjhoBL8SrAHq+CMm4sRMiG8mOVzd043OsaMf1z+PWqLw9Jnh8c33dKoyEu/TSucawXjm9Ij1FW+5yIS89vN2Npr1QR65NS4zDyuTMRuW4gYGlgJtXYOIOreFcwHfie+jnidbS2lnIb6/Q5Tt5RDO1RERUyCqhjB5GiKvx/UDu7ZuCKiQVkfvSC+YoO/XmqfSCzo2i039InLstDms2D2u9pjCYpnsLvT6+hlMoz8OhA/Y0RRhhmcElqib7LwC2TCYIO9bAYTyE6eSyIm0zW1peARDlJr11L4tlruMGTwPHs1kCOYIcTIV7a5gFLvkmz8lWcHMdL40bUJ438Rt5UviBHdmyLckT6T3/1RAtVDvF0U7Ct1Jy+91mRT3ZbUgLH7t2BU/aqujVCi6hOzv2+TN98YBzCJAeeTBQd2NNhJ7L4x/GxMG81XsJphuiD1CMZBK7xyz3zqHUk9MntT/dOyvQtdXXeXNnI6xvN6XX0H0Q3PzkxcacBOv4L0CPNVM5KGpCaaDXPMROCKRPCLROGIHCBYQ3MaQIGbzIhlp29d5jl8fiCTWeVl70oUNL+9s86wm9avdH2syB8d9yGL06AVdw8EwDfKDl2UxOgEywzZpEkZR9yRcS319DrhAnqhYK34E9yhCcppSs/rP9JOtLHudstKvtAb8eGw5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9d53bc-8399-485c-6466-08dbd0c2a521
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 16:44:21.5283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6lvcKcVkmUtluA3sGyih+0HCdBkKzldJPGrphx4uHnISWPdgRF9ahngzXHiUVO7njScAjzC8uf9KiWJIYJZlVvg3Dv5gkE2z3e8+mhotQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190142
X-Proofpoint-GUID: vHgfyqI-ClEALchs_AqrM_MOWby1Z3Kp
X-Proofpoint-ORIG-GUID: vHgfyqI-ClEALchs_AqrM_MOWby1Z3Kp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmVucyBBeGJvZSA8YXhi
b2VAa2VybmVsLmRrPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxOSwgMjAyMyAxMjoyNiBB
TQ0KPiBUbzogR3VsYW0gTW9oYW1lZCA8Z3VsYW0ubW9oYW1lZEBvcmFjbGUuY29tPjsgQmFydCBW
YW4gQXNzY2hlDQo+IDxidmFuYXNzY2hlQGFjbS5vcmc+OyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggVjJdIENvbnNpZGVyIGluZmxpZ2h0IElPIGluIGlvIGFjY291bnRpbmcgZm9yIGhpZ2gg
bGF0ZW5jeQ0KPiBkZXZpY2VzDQo+IA0KPiBQbGVhc2UgZml4IHlvdXIgcXVvdGluZywgaXQncyBp
bXBvc3NpYmxlIHRvIGhhdmUgY29oZXJlbnQgdGhyZWFkcyBvdGhlcndpc2UuDQo+IFRoaXMgaXMg
dGhlIHRoaXJkIHRpbWUgSSdtIGJyaW5naW5nIHRoYXQgdXAsIGJ1dCBpdCdzIGp1c3QgYmVpbmcg
aWdub3JlZC4gTm90IHRoZQ0KPiBiZXN0IHdheSB0byBoYXZlIGEgZnJ1aXRmdWwgZGlzY3Vzc2lv
biBvbiBob3cgYmVzdCB0byBmaXggdGhpcy4NCj4gDQo+IC0tDQo+IEplbnMgQXhib2UNCg0KU29y
cnkgSmVucy4gVGhhdCB3YXMgdGhlIHByb2JsZW0gd2l0aCB0aGUgY29uZmlndXJhdGlvbiBvZiB0
aGUgbWFpbCBjbGllbnQgSSB3YXMgdXNpbmcuIEkgYW0gZXh0cmVtZWx5IHNvcnJ5IGZvciB0aGUg
aW5jb252ZW5pZW5jZS4NClJlZ2FyZGluZyB0aGUgZml4LCBJIHRob3VnaHQgdGhhdCBtb3N0IG9m
IHRoZSBmYXN0ZXIgZGV2aWNlcyB3aWxsIGhhdmUgbW9yZSB0aGFuIDEgcXVldWUuIFNvcnJ5IGZv
ciB0aGF0IG1pc2ludGVycHJldGF0aW9uLiBOb3cgSSB1bmRlcnN0b29kIHRoZSBpc3N1ZSB3aXRo
IHRoZSBmaXggaGVyZS4NCkkgd2FzIHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyB0byBmaXggdGhp
cyBpc3N1ZS4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSB5b3VyIHN1Z2dlc3Rpb25zPw0KDQo=
