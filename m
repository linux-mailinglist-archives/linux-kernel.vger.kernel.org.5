Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4E79FC40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjINGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:42:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B029E;
        Wed, 13 Sep 2023 23:42:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E58VaA014705;
        Thu, 14 Sep 2023 06:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=I+MStxCT3HqtsuA+e3nDjuPFQCEPLEQkKJJ6a5T+q20=;
 b=GvapJYenGvUyBLzrs/dAX7EF9ccDzAvJFexPbzV6BMeCtm7ssPuHAKBiqBsS+D0LEd02
 r+NMhSUzM2+sHf3b/ARLPPuhFtNkzIXrwpT3i/pqUt31G3u3bVii9g9UB+MfUHl8iJd1
 JCT5HxJZcd7hm14IyEVaIp7ymnGcQafB2L51cOVGFQaIfSvzbS6QxfgxoWN6zUJBQGWz
 SlHZDZu8IHBiJliKLGeKLr9eFOZIDD8/m+v4GzPgypu9xwoaGeG9QUUc58YBNFeaDa/Z
 SgTjLz9d20IIl5wMAe3l5hiw7v5zUXg56B5KujdUr0Q0mRCT2dR0S4bAQaQdsz1w7nEq qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pm9m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 06:41:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E50CVu023084;
        Thu, 14 Sep 2023 06:41:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f58ha9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 06:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrbyxBqnhT9W5mNQBqxn2DlXBlvdwVzCcfv24Q0TH79ZLWHRnlOohi502WVg1EATV1SC1lSWw87muJFi2cwioLfJE6E1b6lqsb9VqThK0pqCvjh+QaD0NGWta9XeVy5d3sxsdeeuK41KFOtFf/ohYoQVFPUukyLQjt+ebXmLBdYVaZb+go2F53ZmuitZuRRGnIq6xaICsjvUDBdeZ+ORuZisxCBiZUriUHWToKkWaoFVARkbcvkfnwzPoxD5M5QBfKXGyEkdthVI7oz6jQK3fgX3GA12uuA/ZVVsPiKmOc/91ax3tAa6ANE7aT3Ehc6n/hAUKTcbK9X4Rs36xbafdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+MStxCT3HqtsuA+e3nDjuPFQCEPLEQkKJJ6a5T+q20=;
 b=X3ruim3pa1T42C3sgHDkZZ3mov4gbUG5vsDKHbJ8/bnvMPfX/0A6nEWa51G480pSoQdw+AtRfFarSKjVsFPuOF03lrvFyMveOPtWCZ5nsHZ2mE0Cw/M7FxLaYfWSFV38Dl3qTlGDKUDBL2yhSKGCB44+V1dkYITDL7VerxN/GTfYqJM9BM5EOKwGjKOjL5IgexXZwcWVfy5dyGfSgY9bsMhBSrJvRJxltHveNbF3Fl4z5DEzVl9Pvg6Fy/zn2Gvw12z11CmwcaxVvUHlXGmD7EipCPW0CbjheG6FFhKCm0mLB+zaPcSmZFIYUGGHAUvzGDrw1fVFYyThDUk7LKbZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+MStxCT3HqtsuA+e3nDjuPFQCEPLEQkKJJ6a5T+q20=;
 b=wTeP76kKfeftmmCtFF12mSDWPHeIIMWhkHPys1nRzlesMVNOEDJdCOqmyuVFDZKU5GuhRDhgIUXp5V4ePKIm/aGVO2sroWPUqHoI0JsM1Lj5s/NK8w/PE/eeDRJ2nZcaGXUB0piEmMSTrT2aL2ZAaNG/wu7Ja2d5nyXWHBSP6TA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4286.namprd10.prod.outlook.com (2603:10b6:208:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Thu, 14 Sep
 2023 06:41:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 06:41:51 +0000
Message-ID: <5976613f-8c7b-81a8-3200-9f0603f90743@oracle.com>
Date:   Thu, 14 Sep 2023 07:41:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/3] perf pmu: Remove unused function
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230913153355.138331-1-james.clark@arm.com>
 <20230913153355.138331-4-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230913153355.138331-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0060.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: fec42840-1486-4706-7756-08dbb4edad3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFAPY4YFve3LfiQORtXMCjnu0qnec3UOKNwYDgiC3a5syL54EHV6ISQgToni87dJeGN/8Tvi9+IvMhc8lmjEkqkUXeNYFdk1GtgFKVuvDaTfwnrKRIoyHQpmOuO06o3TVDM82Nacb6kBkun8mFDOt8/E3ZxSF8eSZ1TBcsqYIqQvatbMXbBAewwqz/k8YZp4Mkuuy1rabcbVJLu4x9QSr+FOsyB9q2111jYqT1gIK/xLhla089UXYaJr0rDSC4n8h7H2Es7MAHfOqy4Y4GJ5Ya4NAnSJiNkT4yy9cBOGIQxk35orL+cyzTYcpuaBkw571kXfBBRuc9ZtAOQHKJ98fKnhG2bvVuAXjJIl6PLpCIBuLjRitUK0HpGlKK4elMBIwKg1iOt2du4vCt1kHg7nXSYO622ms9BAr71IkExqc2O9f66S4rOSb8q3BfG1ajDSadGNA39C3OL9OzGnwRrxxixHwFWcJ2GI39G+l5sAUYj6mSc2bsdWOvdKKwVRe8wg5YGulbKGWx3hz9PMBoUBfwv89GLaOCzLDV7VvwxwatSM6a6tU9Ikff+kEcPvhna5GeTQYvQTnoMwqBjkYmRZks7o3XIY8Y/ZiLsT/WlimVxmK3akc8eYFLprmfb3ayei0OdKLNz1+BvfG6Bl6WRRYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(31686004)(6486002)(53546011)(6666004)(36916002)(6506007)(36756003)(31696002)(86362001)(38100700002)(2616005)(478600001)(2906002)(83380400001)(6512007)(8676002)(316002)(5660300002)(4326008)(8936002)(7416002)(41300700001)(26005)(54906003)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW50ZEF0Tms5SUNOK2M1RkxwQ3RrRkVVcVJsVGRIRUlRdWRLRGlYR0tjRHk4?=
 =?utf-8?B?ZzI1NDZIQjJCMkNZaDZqRU8yYnRwMUZsV3ZmZU01NHZOYzlqcENINk15NStn?=
 =?utf-8?B?WnNXZ2E4ZWN5dC9IT21YY2FKUnVnR25KeWtGekU0YmxCZ0F1QnVtNmRaZVV3?=
 =?utf-8?B?YXU5aFV0d3d6L0c5ZzhycENjN3lHYWMxb1kzeUhoblEyd1NkSmtVVE5TOGta?=
 =?utf-8?B?Q0JMd2xLWVU2bXR3MUttcDVMa1ZzZWxhd0FMRE9JSTZ3YjBqSTBmZ0d5ZlBL?=
 =?utf-8?B?VzhhZ0pVdWl2SHZVUmVORzBVU3BqbjhONXpaMWpnZlZNQ2JSOHBHdWowc2pG?=
 =?utf-8?B?OHhleDVjdDhMdnFmSlIxU2E3cjVUN1BQNlZ6RkZuSGlKVlI4SXovQ1ZRWHFO?=
 =?utf-8?B?MHdTVmdKSlFBcVBUUklvYVZ1NFdnZEZ4WjdaVHhDeE5rRTJGSndFU3ZoZUgz?=
 =?utf-8?B?SEgzWUVuME1JODlVVm55S3ZQc0I3Wk85aldUeDllVGd3RFhHbDRvZEdESjVG?=
 =?utf-8?B?ZnYrNitqMm1vWTJTejR5MmNRcVNQdUxiTkc4enlua0pFSFIweGRjWlR5aG1i?=
 =?utf-8?B?YS9NQzZMOFlteUNhcytHdlpqUnJGczZIOXVPL0hmWjJwUTJIdHh2Sys2N2du?=
 =?utf-8?B?UEJ3Z1BpWHE2SFlpRThPOXB2NDljQ0tNbkx6RnYwYzBJTjNWdTRNVWw5UTM1?=
 =?utf-8?B?bmhUYVZhMnFZditzRk05dFFpejVxakp1cGw3VWtQcElnM0RBalRaeU81NGdB?=
 =?utf-8?B?Mkw3aitTUVNDMytSUlB3UVBRY2d0RzJNWWo4cWl0cUtNK3RIZnlUc0wwTFNJ?=
 =?utf-8?B?M0hGOWdvVWtzMjdxRnRVbXd1TmhOS1VzMklmTWgzSWh5d3lVYW5teHZjYXdG?=
 =?utf-8?B?alluMGVKbWVpbWRvdjMxRFhsODJjOEphUENmR0hVYzNBWjhWdllHczZMU0FJ?=
 =?utf-8?B?RzVkWEFhOUFhZFZCQWpjS3JWVFB4VHFjbmpuTlRYWWM4NXhzMDNMV3Y0RFRW?=
 =?utf-8?B?dTAwTHpBWlBUUCswMXFsQkVHaTVSTm1yTVk2OFZ0RTl5Qi9ldHYyLzFwbVVI?=
 =?utf-8?B?UXdFSDhWM2RRYTNab29jK0dzSDFZM25wU3lEbWhtcmhPT1YxcVBpbGs5d2tp?=
 =?utf-8?B?L1I0TC9GWTNiVVN1SWtaeUcrV3NFeDFsQmc4Z0dVb1ZydTM3amdsc2crNWJD?=
 =?utf-8?B?ZW5wNlliQkVsUmxHcDgxdW5PcmNhVTRZYnBkMGovUks4YTI1OUZkSWdOTVBn?=
 =?utf-8?B?VmdiUU9SZmdaN3QzU2FhaG1WVEVQWWt6UEwyNG52bEVTdlN6OFpCQnc2a3U0?=
 =?utf-8?B?cFkxRnZLRVpEaXJYYW9UUCtlYkFlMVo3QWVBQ3VWMGVUdGpEYm5GS2lBOUNt?=
 =?utf-8?B?ZTgxREtVNDFuKzZkeHVZODgzOVU1QnpHR0FLOXNPQ1pTU2lUaXp0ZGdqZTgv?=
 =?utf-8?B?amFRNEcrSmpkaFVpSng3TlpsSVFHbVBCK01wSWlabEhDOFpzblFZT1lNZmww?=
 =?utf-8?B?aWg4c0VyQThiUnRqd3VSS2lXTGh0Y3JIUFlZT2ZQdXB2SVBhejZ5VlJqQUFi?=
 =?utf-8?B?OTFFMVdEQnIrTUpSdFRkSUM2ajFrWDZ3TFNYQnpSYTNVbnJCcUkyRmRQWmpS?=
 =?utf-8?B?RjhnQ0cxTks1Y3ZXc1pEcUFIZmNhSHBnM3o2NG04SWFyUUducXZ3akl6QjNU?=
 =?utf-8?B?T08vZ0ljMXV4eldiR1M1TTAycklOSndMSUVab1F0aEN1MjZpWmVpNTgyc3Bi?=
 =?utf-8?B?WkZCU3hLK1JCVXN0TkM4N2xPc3lKMXVwVDFvWkdPY0oyVjJlMkxwY2N4Mkpl?=
 =?utf-8?B?WWs4NGFrNnpXUHl5TWFoQzR3eUxCTC9jWHVBVzJ5dVBoenhMamgxclpGVXJR?=
 =?utf-8?B?UlpZSU4rL1VQYkVZRzZwQllrRVVFZnV4QmtiN0RlaU5aTVVrYXdRUWs1QUNK?=
 =?utf-8?B?czRVc2xNdFFJT0g5b3Bvb0x0WThOZGxURkU4d2tPRlhvTXViQlBqWUt5QUtK?=
 =?utf-8?B?WUY5YjVsY2pOU1l4aXdUQU90TUVKMlJDREdDNWdGTUErcnpPcXU1blI0R0Y2?=
 =?utf-8?B?cGJBQnhmT2ovUXNYZ3RYMExrTWhlUldzMnBrTzJXSUgvazBCUHV0N1hCQmVs?=
 =?utf-8?Q?37jk1lRrv8yEcukisBjPdsPph?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dm53Vml4U1FtcUYxalN6bmhPbDZ4N2ZHQkxVMGZ3R0JYY2xqaHl3RVhPMldB?=
 =?utf-8?B?S0dNVUFTQlFmZ1Jpbk5pR0FERDZPUXdmbmNabDZSTUpHZUNuTjgxTkU5aHM3?=
 =?utf-8?B?b0RWanJEbDU5WXI1NDkvRjJ2Q2I2OVJQRUFpSmZFUE5IYkx6SVVaNU1FSWZr?=
 =?utf-8?B?SDk0eE5aZ3ZESVF2cjdPVUkvNVZEN2FSNE9QckRZMkx3RDZaWVVrYktuY2dX?=
 =?utf-8?B?eFdLSzZicUMyeWM5ZlEyV0ZDcHU0QVVoTXdxK0VaSXlVY2pFUk1RY3gxeXpy?=
 =?utf-8?B?MjJTZ1NVMkJFMW5pY1ZqQ3REY0N4VDhncGdjNENhOWsyM21BU0Q4MGNBdW8x?=
 =?utf-8?B?d21ieGNNR0hoYythRFpkdGJ0RFpPZk5rdVo4aXNhcWd1aVFBZjlER2tUZ3Vj?=
 =?utf-8?B?RnpIanFKNXBpWWZJeVA4WkRHL2RMMW14QmczUFQvZ1VjNUVuTk9TSU5WK2tV?=
 =?utf-8?B?ZXpBTWQ0K2lkOERwV1BFTldqRHNjVDc1Z2ZFMDcza1dmZDZiSjNFZUpGWjRj?=
 =?utf-8?B?MzU4bGcyNDVjaFkweXorWFFadVQxZ1BVZG5PdjhqTTBwN3BEQUZ4akplVkk2?=
 =?utf-8?B?b2M0Q2VGY1pBck9LOTdNVmlZdWFMcEZUaSsrT0hDRW80UlpvVTFYQ0ZSTldp?=
 =?utf-8?B?K0w3VjJ2aVN5WkVEb3hkYW15LzV2Unk5SEhvUzAwdGs3YldiNEtDQzhRTEts?=
 =?utf-8?B?MnE3OVRIanBwdjB5T29kN3BYYWpzZUVSZWZPc3VWRlFHTEFyS0dtMEFVYk10?=
 =?utf-8?B?bExXcTRPaDRrVjMvZTVIWVVrSVM3R1FkaVRUVmRZeE84eTNUR01OVTdLcmQ5?=
 =?utf-8?B?Q29SdGNINWpBR2FqbWpVblZMdk9sWGh6QTdqMi9pdEt0eWVqdS90MFFvK01W?=
 =?utf-8?B?WWNWYTI4ZWhic3BaMS9mdkxpY3Z6WU9mUzlMTG5uc0VJMEUvemluODNEQ0Fw?=
 =?utf-8?B?eHVrMjFxZ1BDenY2bW42YmRiV0ZmaHdGVm5RNmZKL213c3pEaXp2aW5NOHV5?=
 =?utf-8?B?MG4vRVNpaTlMaFh3dHYzeTI3MDN5ZGJnVVZFbEw0WGlBdEk1ZXZMbk5QMHls?=
 =?utf-8?B?aENQSUtsb0JaS3dWby84MGViYkxUYUtqcVpReTJwUmtZZkIybGkzWjVIeW8z?=
 =?utf-8?B?czdocnhSVFIvUnFaVUJTc1pYR2lVdnBSME1Ha2FPRjRkc28yalYxbDY1VTh5?=
 =?utf-8?B?UkxkY3grWGNlZTVaUkFxcXZhbkdBZ2NraXFoc3VJRnFISkY0dG8wSFh5MzNv?=
 =?utf-8?B?MTJ0bjdUS2dxSll6V0YrRUFyUHJJT0xEOWlMMHZ2dXhuT0FVOXNabWUwSWpV?=
 =?utf-8?B?MHgzQjV2S0xYWHBXQ1lCVWxGZDVuQjNwcStQMnNDdkU4KzJxS1Y2Sy9zODlt?=
 =?utf-8?B?VFFrSDdoL0VOY2ZCMFNIaUVEV3JMbDBkci9VSzlmS1Azcng5TUZESW1VZGFm?=
 =?utf-8?B?V3BWMU9HVTh5ZHc2ZjdBMWVtZk1GSlhaSFczL1I2K3htdzcxV3RHcGtyRTZS?=
 =?utf-8?B?YTVCc0h1RTZJbjhkclBPby9QZkUzTlh1QlZRM0g2alc2dFZHN09jdTY1V3cr?=
 =?utf-8?B?Sk0xZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec42840-1486-4706-7756-08dbb4edad3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:41:51.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjOXvmKfbk7PvtAybSQ58uRlptP9tKr4teFhuG/Ikpzc2Y+90oMuT/ASAsRhlh4+tHJgfz+F8TvV+SObfXsnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140058
X-Proofpoint-GUID: 2JUBd5-FhOOCo4yGI6VHqmwPuO7VPtOi
X-Proofpoint-ORIG-GUID: 2JUBd5-FhOOCo4yGI6VHqmwPuO7VPtOi
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 16:33, James Clark wrote:
> pmu_events_table__find() is no longer used so remove it and its Arm
> specific version.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---

You really should put the name of the function in the subject. Apart 
from that:

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   tools/perf/arch/arm64/util/pmu.c | 10 ----------
>   tools/perf/util/pmu.c            |  5 -----
>   tools/perf/util/pmu.h            |  1 -
>   3 files changed, 16 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 3099f5f448ba..2a4eab2d160e 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -24,16 +24,6 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
>   	return NULL;
>   }
>   
> -const struct pmu_events_table *pmu_events_table__find(void)
> -{
> -	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
> -
> -	if (pmu)
> -		return perf_pmu__find_events_table(pmu);
> -
> -	return NULL;
> -}
> -
>   double perf_pmu__cpu_slots_per_cycle(void)
>   {
>   	char path[PATH_MAX];
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f50a5636633f..0d81c059c91c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -776,11 +776,6 @@ char *perf_pmu__getcpuid(struct perf_pmu *pmu)
>   	return cpuid;
>   }
>   
> -__weak const struct pmu_events_table *pmu_events_table__find(void)
> -{
> -	return perf_pmu__find_events_table(NULL);
> -}
> -
>   __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
>   {
>   	return perf_pmu__find_metrics_table(NULL);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index d7b46085642d..04b317b17d66 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -238,7 +238,6 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
>   			       const struct pmu_events_table *table);
>   
>   char *perf_pmu__getcpuid(struct perf_pmu *pmu);
> -const struct pmu_events_table *pmu_events_table__find(void);
>   const struct pmu_metrics_table *pmu_metrics_table__find(void);
>   
>   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);

