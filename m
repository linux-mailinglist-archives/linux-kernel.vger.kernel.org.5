Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220D97FC36E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbjK1Sgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1Sgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:36:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69F4A7;
        Tue, 28 Nov 2023 10:36:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI179d000661;
        Tue, 28 Nov 2023 18:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pFn0b4A8OKg3gvfIZoJNAal/BuzcXtiRl1inVOp6KEM=;
 b=DHG3N00uC+QA+oTZhylqCb3rs01n/GxNTaGQTU26YZgjneW3JC6PLgqOKfkyAqQJpuGh
 k7LMoMyu4O0uM7eyPDvozf5ulj9gsn3vMz9W9uwlS11FduyO/+zGiyMa1JYir1S+BxfS
 EcSjKtQG6NvK36/WBu/WLVpL8ISUEAG5fPWVqGy0d77XlbquGFlyqWr1BrkBSKRoipWZ
 q9qRDz1aQ5DHf5MLlNPqIRyaX92kPNQceDjjTiRarZN69HDYxZYGftVlHBDw3I6bvsYS
 SIMpjxkmV4aH3AlXD98FxnhSSgb5kHcKV/HPCtzmUlDwbu6deh/omJBlAUSk+YHT/M6a Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un5txt3yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:36:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHq32d027211;
        Tue, 28 Nov 2023 18:36:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c730vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH9KjGbWn0XdgwLo6/mPMH8iupRywmg138p2pzUvLEtAPOcHTzbh491vdhPZmHoLuK5MCOnu3zlA4f5N6QZKFnlOqpos8tVoWd1Ch1oBarJx/zGkx766xp+B/nM3Zil5HjL9H8TdhYW3XYEc3KkgbQbAhH10PWLEO2ff/PIoTxqh8CEZwVYUy3f6Z9P6qlYrczUB6mfW/1h/oeCluIERM6F8lvoi7E0vwYhLoEr65JEz5sjqPBtbunRsob+rthLgHO+YhyQBKqTT6qr4A3PGuV+uKHmEeltqZp9ZF3uYUdqKV29Uyi8rB15DJEBsTU5GImuaE3E/mQpuKfoyhsvOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFn0b4A8OKg3gvfIZoJNAal/BuzcXtiRl1inVOp6KEM=;
 b=Pl8Z4Z4q0EkINiI297FpSe56Zoevr4Jbtoc30C2qOOizpTwaoY1PPYyXIdMSvt7bU+zxYkW0uectQoU4hOQ8e6Iqi8G6v5nW6f2s2Wapuf6X0Ezd2vcLEYhx3syUQcamovPcTX+HbHM7Y7pwd/33QuaBSPP2zDU0NUqVvXBEtrzP+xGDd09vvKibgQXLiMv/gQVtG8LtlJuygEFnBJb1mP5jkqiuRtnVI6029tiVpBOGxjHVJuUm4RKRBUGkjDrHf1qDp1B7CzNEsBcFcJ3DlMWK6ZkVCfTWvJoSbrPLEpqGyjEW4arUd6AIFyYfMcnbJrqjQtrL4iHJrhy/PefvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFn0b4A8OKg3gvfIZoJNAal/BuzcXtiRl1inVOp6KEM=;
 b=gPcNBpRkfMzYDdVcfQiT1dnOSPGRTDlG4p6lkBXauu7Np886nAa346udCu7fS8dinaQdxdky02ljUGRRUh2L7l8Nn4M9ll6dCcA9hsQ4rP1F2AG0dkoYBW0TRIpSL9mEbpRp8FsBqLUpw1jCGNH28X54uzzrMi1y2fXvPU4Himk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 18:36:25 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:36:24 +0000
Message-ID: <abfe20ea-80e9-4688-a689-110399a900da@oracle.com>
Date:   Wed, 29 Nov 2023 00:06:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/sysfs: Fix calling kobject_put() without kobj
 initialization
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
References: <20231128130952.3372794-1-harshit.m.mogalapalli@oracle.com>
 <2023112824-cupbearer-salvage-b064@gregkh>
 <b1fa28b5-a93a-4580-8f50-b27f975216d3@oracle.com>
In-Reply-To: <b1fa28b5-a93a-4580-8f50-b27f975216d3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d72c4f-7cd9-4ea2-7855-08dbf040ecf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0sPmP9voTpPLbWhZ3psgBMOm/1P7dzO/6OVdZpcwtN9AjKv22Aj+CVEzoevkZDLFL/ReZ7nUgs5L/BBXfkcfCwMHgNcyA0R8lrKLas+c6O/EmzD0EJQcpDnoX51B3hSCjrbog2fdsAfYaaDZjljUrUpotzOK2v1xlo48leQnrEOkgTG87Khdd6G4rn/IvjChI3LT41qHmGLt9xzG06W9pWeWG/dbaEMbZsCJ5fOP4r6Trl0k0DXqliHJ+dBEFPxOyaTwO+9OVUZOgAPNb0BdET1JN58V/2ZHlKeg1cghRaEEY+UCzmYYxl71Xgwjyp8AP2Q9F4xqwWYjEZQmVAMBnvgztF5tQQP6RDmJABQzaVaSVOoD61Sr7GojV6Q5gLqsmYeih4Y8UYaCWjDLsQzxP10y7OBtfbBGgPABuTCnEOUfTdSj8CWeCRtzsBycHFNfyidbdXMd6K//48YQxHGDM9XXrJReut9Z9RuC/CWhszIxu4DLJONRlXHnr1tH5Fo398nARlyevKHfl7g/iPWpDuRpa/CxUkRWeQ4ZTcyg6PKeXeoRSSvqO8/p0gN9LRf1hj0w2gDFOd7YRxvpSeTD3/5PktPSNJJl9ZiZOThlC0upHJ4d027BFy2Mqakin7NGYwFffg+9cI1opfaajdJyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(66476007)(6916009)(54906003)(31696002)(316002)(66946007)(8936002)(8676002)(4326008)(966005)(6486002)(478600001)(36756003)(7416002)(86362001)(5660300002)(2906002)(41300700001)(38100700002)(2616005)(6506007)(6666004)(53546011)(26005)(83380400001)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZvT1J2VDMxNmkrMVVaeW1SN2p3OG9CYlRVcEdQUzA3cVVnRDBmK084L050?=
 =?utf-8?B?RDBTU0N3N2N3Wm5nVzFKdWNJZE5lZnZZRkgxTFA4NVJOZmdvelorUHpocVRq?=
 =?utf-8?B?NGVEQjduN2pjOGdUeXVGQ0Z4VXhudnZRYVRlOTNVeEVQS0UwV3E3TkFqanN3?=
 =?utf-8?B?OW9rVU9LWmxjN3lmMUxCcVI1dGo5Zmk2ZFY1YWNQaFJ2Q2lqcmJMaTd3ZkVq?=
 =?utf-8?B?bkdIWHNFZFZ4ZXUyR242S0pqQ2NZZWtub0Z5eDFwL2YvTnY3Y2ZkZmQwMTUw?=
 =?utf-8?B?b2ZydlcwS3lxbTZmdklrNVJUejJNR3RleUVQZzVUaHdMRkdEUEpBMXJwNWtX?=
 =?utf-8?B?bEpidEEyYTA4UnRpbzBBd01oOHVoZ1RJaHRGTitkY2xyN3VGejNvQkltc0JG?=
 =?utf-8?B?eGZTdVNHN0Y3Q2ZDMEQrcG5HM0tCV0ZsT3ZKMkg3Mlo3L2V5dVNBQ09nd1BY?=
 =?utf-8?B?WjJyVE82cldhRlVsbzhBMzhkR3krS2laaUhwL1U1Nm82d1IyN0FDaytSdEla?=
 =?utf-8?B?Rk9oMnBnd1d1aVdGeWZKQjNsM1c1SWxEZXVLdysvbXovbGVCMWhYdzlnK3Zt?=
 =?utf-8?B?MmlzelpCcFBMYytYcFg0NHpjK0pnUzlNeUlPK0U2dmZXMXo2a3ZNTzRvSDZX?=
 =?utf-8?B?TnUzbitoUSsrenFwWC83VnFwSUp5bEx0cVk5ZzYrV0tlOE9vZm9Wdi9OalI0?=
 =?utf-8?B?QjRVNzdrUU9yV2NtNmZzcS85K2xyL3NqMXI3QWNIY2VlcVl5Ry93TC9QeEVF?=
 =?utf-8?B?cFNoTHBMNWhsak5ERm9OcWUwRjg1ZXAzOExNblJBZ2RISzI5SWJpZ3BVUGpo?=
 =?utf-8?B?V0JlSzEraWRtU1p3QXdzVktocVlEYWRiaUxBNDFkeDl6OFdzeC9aRG1lN2Nj?=
 =?utf-8?B?UFhJanJXSHJKYVhvR1hwSGE5UC9BWlZtb2xFajh0UXBJYVd1SXBJOW9zbUlz?=
 =?utf-8?B?VlFYQTlLZW53RThnQldTYUM2TnIzYXZZQzR0K1VrR0hyWHkxOUxOWWNYL2I5?=
 =?utf-8?B?b1k2SUM2cUhpangvVnlsc2VhMGU0MjVRTDBOTnJDRzNQOEZDSWM5UERUZDg4?=
 =?utf-8?B?UmF3WmpOV1FjS1JlUlVBV3dTMmVGbG94Q0lkMWN3UEZPTERRQzBxa2diQnRQ?=
 =?utf-8?B?d29SdjdKMkYzTEYybUJpOVZZRFlXMHhEYzdXWWRDSTlxY2gxYURibXg5UW04?=
 =?utf-8?B?bXozcWxvZVlRcGRZMEdRRFVyckpSejB0YkF4RVhpdzV2eGRaKy9vSnV3MzlS?=
 =?utf-8?B?WU96WUFxOXpROEduNFpBejBCd3dYRnR4amx0Z2hlRTVCdlZkdCtJdGxMQlcx?=
 =?utf-8?B?UlptN2xwZE5vL3Z3cmptRnQ5OXl0NFp5M3p4VzVFNHEvSWhLWEpMbUxGU2Vw?=
 =?utf-8?B?R3ZzYnVQQ2V2S3hodFBmQXB3REhyZ3ovWHZSWG5IMEtNeUdJQTg1SHROWVpU?=
 =?utf-8?B?WENUSFZXQmRQR1dSbGh0QzFYQ0U4V2NvZGxZbTRBSHJnVUE5T1dCWVlPVVk0?=
 =?utf-8?B?bjFKdzhadGQ5bDNVSkEvbnVxcmdUc29CNDlsdTUxcTRGcUZWNXZ3VnZ2WitI?=
 =?utf-8?B?NEVnUFpEQzVaN05pZDNkMEM1SW85a0p2OWI0RXF0M0kvR2MxUXVxYnRRK0Zq?=
 =?utf-8?B?UHgvQUlnbW40eTR6VUZSbjNQdEhVVDhjaERTQ3FnaUdOZHBWVmhWQ2lhKzNr?=
 =?utf-8?B?THM2NkN1Yk9CV0tIbURhckZmWnhtcTEvNzZHdWo2WWV3QmVIVWpQaFdnMHQv?=
 =?utf-8?B?MGxoV2liV29rWGx1Qm51cVd6RFlidnEycm5QQkxjYUR3WUhWSTZNVGNOL3Zh?=
 =?utf-8?B?M0lFeVB5WC9yajJlWEZSK0RtcXBSOUhLNW8wSnlqRlk4R2tJZUtYWmt1SXVF?=
 =?utf-8?B?ZHVEdEw2Rk5Ya1JUdGxKemNwQ2ZwaXEyTllEL1VrQktXY3lOdkNmUE9wczBv?=
 =?utf-8?B?c1FNMm5SbDRCZm5vTXZFekcvQkduTGFaUC9aQWQ0QnEyQjlwWE1HS1lvZUpj?=
 =?utf-8?B?cjhHVXRRYkNaYVlRVkVlUG45MHpCOEJBOGdJNTRuNkVUTmZPQ0pFT05Sd0M0?=
 =?utf-8?B?OXpOa25TcXdNUHJxVWh4cWt4WVNYdnE5UVdPQ1lSa0lETzgyQTB5dDMyZUZh?=
 =?utf-8?B?UlF0RFFkSkVkdUpjYTlEUS9qOGJwNkF6VGR0amVhRllnQVF5VGduQnl4c09T?=
 =?utf-8?Q?P0qdsBHWHWM0o7j7r40oChQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UGtXMGw0cUJrdFlkOWFpNVRBZUNOQmUxRkVwRkFJbGNrVzFseS8rT3NIaTh0?=
 =?utf-8?B?SVFwdEF5bHg5L2Z0MXlUTnJXdGlGd3QzZXlDZXVyNDgzTXV5SjZDRXNMM3c1?=
 =?utf-8?B?ckxzVVZ0YWYwNkZGQ0hwK2NxTUgwOVFnenlqb0NiUWFZNUFqVklFK1JhYW5C?=
 =?utf-8?B?cDNoaFVXaGNmZDFTRnVnenlNRW1QSWVac2ZvMDU5eTJJMndPd1JhR1VOcXM3?=
 =?utf-8?B?Q04vM1ZaS3pXK3R6eXQyUDFiZFpDN1hFQmQzdHlQSHF2QzlzTmZuU2N4bkI1?=
 =?utf-8?B?Y0JNU3Vmd1llaC80YWUzM3lmRExMMHBkMEkzMXdrQVNFa0gyR1Z6U2Q1Q3Bu?=
 =?utf-8?B?QXNZQ0NBMkVETFZCQkVVR3NlcDhSTXdKUCtXVUZkOGtjS1UrN0lUKzd6TDBX?=
 =?utf-8?B?TTh2bXM4aWFlQWcwcGxOWjBWazFTalh2a0ZYNGhTVkJxbklZU3JtbHV0VURm?=
 =?utf-8?B?MXlibitYVXZDYXl3U0lsSi9sbjNtK0Z5eW1qcDVvc2pJNTJlczBhbmRabWk2?=
 =?utf-8?B?VUJJRW0rUFVvYm9GTGNRZUo1dnBnNjFEN21OSjJpWnZBWjRuZVZaa1JyTzZI?=
 =?utf-8?B?bWg4a0tQYjgyd1MrRzB6NnRUVTJVdjgxYkNPVEM4WS9zblFPbGZhRjFkWG80?=
 =?utf-8?B?VWljSkVZTEFoRFJqVXd0c2hxWERqYkUrVk1lZHVVdUpidVpLQ01oK3Q0UUV2?=
 =?utf-8?B?T2RiUzhaeWdKK1BaM3EvVEpoUytESTBwSGthbHU5YUdodDJNeFYzZlBjUVVI?=
 =?utf-8?B?eFE3NStPZHhzZnJkcUV2ZDBVR2VHZzZ2MWtGc2djdlhBRXAzVWs4TUoxY2NV?=
 =?utf-8?B?WldoQ1NkbjFBZ2hmc0pzTmxoL2dFdkFaNUxUcnMwMU5LV1dpSTJWQVJEQnpG?=
 =?utf-8?B?S3VzYjBxVEZwcWdvOU5HUTlyWFdZMk9ZdTQzaHdScXpGMjlIRmRhTllBcHVN?=
 =?utf-8?B?bVI2eXV0K0M3WkloRlZuTzZid2lTOGVhTlB1cDJuQzc3RmcrVXpYbmM2bEtj?=
 =?utf-8?B?VE81VmZYQnBTL3BUYWQ3U3N4S2NZWWZDSjk2ZnBtUHFXdnhnMHRCMzN4a3Mw?=
 =?utf-8?B?bm9ZMEJSYmhVbDl0SVVhUUZrWFFBTnQ5cnpKV3U0cUM2MitvN2pKcU0xTFB4?=
 =?utf-8?B?UXFzVnovUFZ3dFJyeHE0M01xeVd1MVcxaUtwUTA4elFqK1BQZDJzdEFmYWNZ?=
 =?utf-8?B?endVZ0c4b0d6N0VMYzdoZ3Q1aHRLdHpRN25EVWsxcUtMdlFSKysvTS9QUFlM?=
 =?utf-8?B?NTdQZC92TUVqYmtJLzFkQUFXSUxlTXJFWkFkcU1vanBVUjA4b1pRMWdXMXBa?=
 =?utf-8?Q?lxrw0RbV4d+IQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d72c4f-7cd9-4ea2-7855-08dbf040ecf3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 18:36:24.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhIsClvSgjlMbTUuu1hGkELbVW1oI2pFDoVw5q0S87Sk3jMCY8tnDsxQKzw2K6gh0kbebNWoT9QcN+BELXvDznfjID45gUzHn3IXgnyJE/bZ1273owgdyy62D4B3/mL6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280148
X-Proofpoint-GUID: Oau6cJ9oSFMwlJyIA0Y-VSAtxVwkC_bT
X-Proofpoint-ORIG-GUID: Oau6cJ9oSFMwlJyIA0Y-VSAtxVwkC_bT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 28/11/23 11:25 pm, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> 
>> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>> a patch that has triggered this response.  He used to manually respond
>> to these common problems, but in order to save his sanity (he kept
>> writing the same thing over and over, yet to different people), I was
>> created.  Hopefully you will not take offence and will fix the problem
>> in your patch and resubmit it so that it can be accepted into the Linux
>> kernel tree.
>>
>> You are receiving this message because of the following common error(s)
>> as indicated below:
>>
>> - This looks like a new version of a previously submitted patch, but you
>>    did not list below the --- line any changes from the previous version.
>>    Please read the section entitled "The canonical patch format" in the
>>    kernel file, Documentation/process/submitting-patches.rst for what
>>    needs to be done here to properly describe this.
>>
>> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>>    older released kernel, yet you do not have a cc: stable line in the
>>    signed-off-by area at all, which means that the patch will not be
>>    applied to any older kernel releases.  To properly fix this, please
>>    follow the documented rules in the
>>    Documentation/process/stable-kernel-rules.rst file for how to resolve
>>    this.
>>
>> If you wish to discuss this problem further, or you have questions about
>> how to resolve this issue, please feel free to respond to this email and
>> Greg will reply once he has dug out from the pending patches received
>> from other developers.
> 
> No, this is a similar bug but in the edac_pci_sysfs.c file instead of 
> the edac_device_sysfs.c.
> 
> Let me resend these two patches as a patchset and change the subject to 
> make it more obvious(EDAC/pci_sysfs, EDAC/device_sysfs in title).  And 
> add a CC stable tag.
> 

Sent a V2 here as a patch series:
https://lore.kernel.org/all/20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com/

Thanks,
Harshit
> Thanks,
> Harshit
> 
>>
>> thanks,
>>
>> greg k-h's patch email bot
> 

