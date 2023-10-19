Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77207D04C6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjJSW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjJSW3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:29:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1366194
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:28:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKxcLf013944;
        Thu, 19 Oct 2023 22:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=K7cMSOGWvUo+zEydsZ9eHRCMnvgHOuEhFNLNdiTrcEg=;
 b=kW0V22kS+FgUciwLsTV1ETg83JQtwG1e96pqIztDLxGC4k3mn01QaDw5/o8DwVO4CpH9
 GlC/PNub/wJwqoyWepatxo431J3rqFBkSTr+IxCiy79k7Z3J2B1vBTtvmbxi9Saj72L3
 zxi/MeXhkeZEHoSUxSsqTZFyEERRblYWP3NATUjb2bpErfEXj5luwdXyGQAYtQtkb18T
 z7nwjgWLWOrP/0foIitKTE+TRuhakxkh+RBIvMlKsK0B5a+lYleZwXVu3kL+rH1ZNMjh
 RbX47R0TWFqULMjNVqD/utk91ITIZOtwviL5jjgSbjO9Qfbuj+n9JmsBHRtg4z/r7YxY ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubwd84jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 22:28:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39JKrc8V005056;
        Thu, 19 Oct 2023 22:28:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tubw2jxxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 22:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2Diy7stoJr736XPcnUK1klh8RQ4LpqwGTzV5sPLvv6ECmWjGU5SkiNYUrNN3+0m9DVn4qvmmXNBDAMQYwduTI76yT4rZ9Bxd4eMRgfl67ITJpbAPeQBJ5uVl4y0Oz0mLoJ6pndr+4g+aMTAU6tzv3ihKL8TrUJv7b8wo86zyi15lf1fK4XK2O6DJrgs7sQ9FsLJGVljhGAIy7ENEt9j26UNk5obw6JDJR01S0nOvO0cG7Fay/697S0D66mHKf6K3ycy42E1O1OC6S+lGAzr+NOPXNsqf/rz2lyGvc3f0rEAA28aovmZA7/9r1HB58To1YF76W2OdBmmhFrV27h4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7cMSOGWvUo+zEydsZ9eHRCMnvgHOuEhFNLNdiTrcEg=;
 b=ByRqB5X29Zs10Qm1rTUcxfxK+asfR7oU0f7fvKoO7eRj4uzH0+USoP/CHWY+dLKmhIrPj1RS0Tu/WYO1iO5BALAISuIoAKbbE4Sak5XEGyFIFFcKoUEKC7WTMNda5DejLcGCWqZ4944JEfkSAVnXreOrn+F70e5cJ1xpg25noJ9gyl9JWbHPPqVCmfUC6QtS/pBkKLG8XrJQltyr8GxDr2a8hDSXlo/Whl4rPKLHZzW8VrXfR14/3olK7LQb6bFhjioCieSjcUjL/144meMOw4NaOHETswIcsHIxDJFGyb/tvaa9pJC7qIfAP8e/A6ltYaRWIfAA/fH87ghrV6APhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7cMSOGWvUo+zEydsZ9eHRCMnvgHOuEhFNLNdiTrcEg=;
 b=blF6YN/o16i5LfxcrvOp4DmH0lHBfgKTSlvkOL/m+db3EvXsDTcCzzFIbjkdBMYcvrzdW4Nf5GoxXsQ1ssK4TS8rEMl9+ez4B6yRk82gULrcd5HTZZYVzhTuUTobUBebRh/Ftd2iLjnKKXdsgWk/EajDs3Y5CMJ8jQ15YckkIAo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 22:28:19 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 22:28:19 +0000
Message-ID: <07174d80-afad-4017-9088-02f2133e64b5@oracle.com>
Date:   Thu, 19 Oct 2023 15:28:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
 <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
 <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
 <4ba8b63f-61e8-44cf-8e01-e467bd27ed5b@oracle.com>
 <CACGkMEuTchn+QU1QFh98E3YfUJaUM6Vnm0ECtRbqMsA-uCR2uQ@mail.gmail.com>
 <CAJaqyWdMPVUd_zjd0nkQKvDmG2HPe5DBS-w5=mx4qSPCqtDJwg@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdMPVUd_zjd0nkQKvDmG2HPe5DBS-w5=mx4qSPCqtDJwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 9800279c-b536-4732-defc-08dbd0f2b24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpLcwWriM6QcrUh15dLQJ6mPAIrw3T5Hk/unBg4c4aR0qTjUTCEW0QehRyI1WkF87MxF1I8kPvEccOZnaXfvpCshJdUt94WJh62jS/B0G793SLLgN8FKCFIruI6vJh9bU2Qq3YKvu5YqHULvK2mBNHcNRDnIEyAwSlLx06QDKrBPEyzpAkqEQn94nljt5owPgBhZ6xPaRGT+gl+Y1a24qxMAJ/We6hK+1JJrX6N8Ssp1JwwKe6JpkUqUW3vrWBu0lVzoFBMRz9+NG0HH1JIBUhH8f9Xdv7Ll4I9owIHZ/X+Y3466mTh7Z20mX6gt+WZMTHaYOtZCeygBc6D/+0QOqUypvqkvKxamcXZ7PWRxY5cvEy8NTisLDzRhpRultoR//vEJ+L1B5GkUivTJmj27/gN1XlmBoXlLGGvEHoCuyNseLoomMFXWHRDt52tFmj3RXFMp0bxpEExI1xSWfeIzmye2yEQ2lX/8toZTdCryD9VDosepjp/On4P4WyElmjrjSTjl6OvrRarTsC1XUkSNIXYPNpMbq49KOD1ecTS0qO8WEHgNgo48sukIhP70Ze5iaGmY2PbQ/+qno71VyPRMtkPFK48xrrIYUg3Zay2sXt5Aab7Xjq7qsti72WukV/By74xT4ATH04/oRZZC9B7kyKSYtDFUyKK9zrudf+ipfFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(86362001)(66899024)(4326008)(2906002)(30864003)(38100700002)(6506007)(5660300002)(31696002)(83380400001)(6512007)(26005)(53546011)(36916002)(2616005)(36756003)(110136005)(8676002)(41300700001)(966005)(6486002)(66556008)(66476007)(66946007)(478600001)(316002)(6666004)(8936002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEErVFpEU1BiMkVmOFZraGIyeDhlSkZ1c3FDdXJzL1hQZEdZclJNRXhSelhx?=
 =?utf-8?B?TlVhTzZYQkxhTzlROWU4OHNpdWE2dDVrRDNhOXJGcWJ6MmlLRG8rS2lEazEr?=
 =?utf-8?B?UTBEdzZOTkp6NkVkTW40aXBXZWhEMXpUazM2ckY5ckF2ODNtM0VCVTBuU2ZB?=
 =?utf-8?B?ZkRMVlZPWVQrYnByZjNZaURHL3VtYlNoTFFHVVVZSGUvZEIySTJreUs4TmFK?=
 =?utf-8?B?OFRnR3BGa2ZlaWVXdlByWkVGNGNWSlZoMXlldUtLeXJ4TDR6bjIvWDN5NHZB?=
 =?utf-8?B?NUJBR0duY2FTTTcxQ3gyT3lFRTh0dUZINjRJbkRkUitRZjhTdVNGdDBwMEZK?=
 =?utf-8?B?Yk9lUGVRTmpNbTlhaUg1L1ZqT1Z2eE1WZjVtVGszUU5XYUVvT2YrRjZ5bWM3?=
 =?utf-8?B?VDNEc3B4OFI4VVhSbHUza0dZMzVqYm9OWW4yVCtZSzRaTlU4eXVqUm5PWWZX?=
 =?utf-8?B?U1lVekJzL2VwVmZHYTVKaEROVzU0UnZ1a0VWdWdZMVlRS2h4MHYzL09UQzI5?=
 =?utf-8?B?MTJDNzZ5Qm9NT3NWMkVxMzZRbUZFNHBhRlJHNXhkUEw4TExIZ1ZoaTRHNCtz?=
 =?utf-8?B?SnExdG0rQVEraHRpR1AxWGR1Ty8rZkhkR21YWlBibW93YXExc1pQLzJOSVl1?=
 =?utf-8?B?TmlvUndxWEE3QmdoUkFOazBvK1RDN01SY0VCRFVmMHkzc1cyU0NFbU1vdkFX?=
 =?utf-8?B?S1BQbVFiRncwNW5oQVNYTDZyc1BBNmtJRzFac1VQNVJDL1F1THppU2Q0VStm?=
 =?utf-8?B?THVpaXVEK0s5bmlLRWZ0NGRLamRTWWVPYVhpREJWamNmb2N6UkdwOXNCeGZY?=
 =?utf-8?B?M1psNUNlcjdLTVRZQW53Uk13bm1YaStHTVlqNU14WFdQZ3VTdzRVUU9YOE84?=
 =?utf-8?B?cFphZ1dJY2hpOWNnQjRCK25neWpnTHRtMm1FcWEzQnU0OWJiQk90dkNQbkVJ?=
 =?utf-8?B?Rms5MWhlVEk5OXNEZTU2VEZxTkNMYmlqcVVKNHBRVENwMFFVTnZhU25xUzNN?=
 =?utf-8?B?MEpMeER2bzBzVDYzS0Z3NFpOU2xGUE5NWFNQek9pS3NOS3RoMnV4Z0p1Z3pL?=
 =?utf-8?B?b1B1d0YvNVhYME1YOWhXV0lWYjRhbjRaVnBlemVqN2VCcXhBQTVTOU5iV0k3?=
 =?utf-8?B?VkJoaTJITkJYUnUyUFBVY0Y0SWhrMDF2OFpDRlJWYXNlM2RUV0NQM3o0N3FK?=
 =?utf-8?B?aHhaa2M3QjV1enBIeXQ3MEtLVHZEcjhhZGsyZnZPYW13RjMwZEV0NERUQkNO?=
 =?utf-8?B?RVFRcXlMb05sQW83OTEySktNeCtVaTNlNUpiMCs2Zjh0Z1h5T09DWkI3UlBY?=
 =?utf-8?B?VGR0QWdCZjk0eDVNWmExQWtlcG9ycytLbE5TSDRFT0NxZW55UjFWeTdkRTNM?=
 =?utf-8?B?MHlNUnp1L0crS2o1aGNoVU90Y1VpeFZkcnVYT0pRTXpaMHZQZXA4bjczK01B?=
 =?utf-8?B?cVdRZ0UzcnA4QVN5aVpRNEgrNVRWbFhNMy9wMGFMWGZudmFBbUFIVXBJeDRO?=
 =?utf-8?B?RU01ZGdNU1J6bW8zaVF2SG9TdFRXMmNCODY5SlFWeTRTc0pmN0RIYmVPRngy?=
 =?utf-8?B?S2Q5QVl4U2FpaXU0dE1rZXlBbzd0Q013SWN0c2dsUlpUaWZ6bG1HUWtmT1Fz?=
 =?utf-8?B?KzdoQlk4L2ROWTZQaUsvWXkvZU5kRXpzN2NObkE3am9haTk5VmJpd05hVlZn?=
 =?utf-8?B?azNPRHAxRERuNW5ucHMvenlvMUgva084VXRpZS9XZlNXTTRsd2hVZTRNK09u?=
 =?utf-8?B?Zm01WFRRcEtaTm1PNWp2S3JGU0kyT0lOSi93c3dNSDNzdnFGZ0lKbzhOdndm?=
 =?utf-8?B?cFJUT1ZZdG5kNVRjaGlUK24vbmpabHo3MEh2Z0JBQmJFa0hiRExCVUxHMSti?=
 =?utf-8?B?RDZ5TTZYb3hEc2lhWUZNZlpIQ0N4NUR6T3hEb2taR3FGS1JSbWtuNjQ1RTNu?=
 =?utf-8?B?dGtuOEdBdzZLVUdBTnVkVzhsczdpRVBoUGRSQXdBZE41WTNxZSsxTFovQkJJ?=
 =?utf-8?B?NHgvQU5ZNlJ1L281d0xUcTdHZFBjbTVYZGduekFiekUyVWpBOEt3M0V0M2pu?=
 =?utf-8?B?K1QxRi9LYmpXM01WaU5HdUtidzBSaG05QlRCaDVrOVVYQ21lNFdBb3FJc0tr?=
 =?utf-8?Q?7SRKodn0lbn8Dvq8JPsSlY2DJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Z1dIdEhTc2V3T0lkdFg5ZXdBR2FlRkdxR25RVkVkTkNyZDk5K1hoZk9PNG96?=
 =?utf-8?B?eFJzZ2VHemdYQzR3QU1ycFliMk56dDZ5YnIyeUd6Q2tNUkZvV0V0TFhVeVc0?=
 =?utf-8?B?cUNoT0xlUWdpdXhYaTJnVWJWS1U5ai9QYm82M3J3OERHNDZjK1A5VnR1enZ3?=
 =?utf-8?B?TmRxQU94V1NmMDcyMi84N0N0SkF5TkZiRnp5ODcwMjZFY1NoWmNZdjJUWDlF?=
 =?utf-8?B?K1g2SEZTQnp4RTh5UFBpNDh3dVM3cWh2TURtcVdlcUs3QXRBM0ZXdkIyVWhz?=
 =?utf-8?B?M1Y2YVc5Y3RpclQzTC90OTlWVms4N1pENGxrMXArZzB3R0E5eHN0SStncXZu?=
 =?utf-8?B?TEJrTkp2OVFjbFJVVEllSXVMRmNRYTU4dk4rWGkyTXE1dFlVRTFnYjV3NVlG?=
 =?utf-8?B?S1Z3S2ZidnQ4UndBeVN4WWw0OUhsUGFFM01zV21YdmtOQ0ZrbTZVOVNyOXZm?=
 =?utf-8?B?cnA5aGE3MG1xcTBPclFOaHpmNThLNThsRkdMSTNtc2pEMTMrWC9DdnhRc3pZ?=
 =?utf-8?B?K3VVcGpFNVZzcGVTVFZnQVJsSXhnVFhwcWxBZlVybldYbWw3YjAyNzBMd1lu?=
 =?utf-8?B?aDZVQnhROERMVVZ6SG5hT1RRclhydGgzMXJuMWcxMzliaGQxMHYvS3daNTFQ?=
 =?utf-8?B?S2dGekdJNitta01UaWhhdjdrZFY2aVJwaXVNSnFsQzFlUkhFdVJIUDJaMjIz?=
 =?utf-8?B?RHhlU3dvVlFyRU1RdXRuUnJocExXSWxvMVBmcHJGdVZLdjZlZEJweTd5d0hx?=
 =?utf-8?B?cHJ2emtCb2ZsRlF4cHFnU2ZseFVhMzB1NE9XWkJnendtQ2E0WVQrWktDdytD?=
 =?utf-8?B?dm9tTEsxQUtLaUdtMEFYdkRMZnNvamFyWnNiK3Rxbld5ZEJVT29QVDBySDFx?=
 =?utf-8?B?Z3NQWEU2OVg1eGNDRU9mcWZFYmdFZjhqRG9SaDJaMjVGNHJLbnFhY3MrbGZN?=
 =?utf-8?B?SDdWcjlHQ1V0K1BFYllWcGRCZ21oRXc0OHNyTGZvZHZaNnlrTTBZb041aFp2?=
 =?utf-8?B?d09ibmV0SXFZNFlqRVk0b1J3TTRFZmtlMnZPZGM4NVAvVS9BM0laSm4xbFVn?=
 =?utf-8?B?NHZhVEo3R0UxMXJhRkdXcWt4cVZENTdHSjdsVlNPck9mSk1pazBwN2F4NXRM?=
 =?utf-8?B?WDlUd3RRLzA0b1Q0QUtzUXBKTXFrU3FSam9CNW82d0I2K2tvOEpaZ1lBZW5z?=
 =?utf-8?B?eFEwSzZWcUtDcHFISWdSWDdoUFFMdFpRTFlKTG54TE81ZSthV0l5MllCNkJZ?=
 =?utf-8?Q?hWeKOgxBpW6/u65?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9800279c-b536-4732-defc-08dbd0f2b24e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:28:19.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZyB5cNGkVC45iXOF2xyT1Yju1fYUYsbFd2+rSFmDsUU4peavzYdhLgl4gTuvedAUcFp3MF3c4lFpWHpXiVEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310190191
X-Proofpoint-ORIG-GUID: aktILu1tKtH3m8mfmRp14eILG-P_qjlg
X-Proofpoint-GUID: aktILu1tKtH3m8mfmRp14eILG-P_qjlg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 7:39 AM, Eugenio Perez Martin wrote:
> On Thu, Oct 19, 2023 at 10:27 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Thu, Oct 19, 2023 at 2:47 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>
>>>
>>> On 10/18/2023 7:53 PM, Jason Wang wrote:
>>>> On Wed, Oct 18, 2023 at 4:49 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>
>>>>> On 10/18/2023 12:00 AM, Jason Wang wrote:
>>>>>>> Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
>>>>>>> don't have a better choice. Or we can fail the probe if userspace
>>>>>>> doesn't ack this feature.
>>>>>> Antoher idea we can just do the following in vhost_vdpa reset?
>>>>>>
>>>>>> config->reset()
>>>>>> if (IOTLB_PERSIST is not set) {
>>>>>>        config->reset_map()
>>>>>> }
>>>>>>
>>>>>> Then we don't have the burden to maintain them in the parent?
>>>>>>
>>>>>> Thanks
>>>>> Please see my earlier response in the other email, thanks.
>>>>>
>>>>> ----------------%<----------------%<----------------
>>>>>
>>>>> First, the ideal fix would be to leave this reset_vendor_mappings()
>>>>> emulation code on the individual driver itself, which already has the
>>>>> broken behavior.
>>>> So the point is, not about whether the existing behavior is "broken"
>>>> or not.
>>> Hold on, I thought earlier we all agreed upon that the existing behavior
>>> of vendor driver self-clearing maps during .reset violates the vhost
>>> iotlb abstraction and also breaks the .set_map/.dma_map API. This is
>>> 100% buggy driver implementation itself that we should discourage or
>>> eliminate as much as possible (that's part of the goal for this series),
>> I'm not saying it's not an issue, what I'm saying is, if the fix
>> breaks another userspace, it's a new bug in the kernel. See what Linus
>> said in [1]
>>
>> "If a change results in user programs breaking, it's a bug in the kernel."
>>
>>> but here you seem to go existentialism and suggests the very opposite
>>> that every .set_map/.dma_map driver implementation, regardless being the
>>> current or the new/upcoming, should unconditionally try to emulate the
>>> broken reset behavior for the sake of not breaking older userspace.
>> Such "emulation" is not done at the parent level. New parents just
>> need to implement reset_map() or not. everything could be done inside
>> vhost-vDPA as pseudo code that is shown above.
>>
>>> Set
>>> aside the criteria and definition for how userspace can be broken, can
>>> we step back to the original question why we think it's broken, and what
>>> we can do to promote good driver implementation instead of discuss the
>>> implementation details?
>> I'm not sure I get the point of this question. I'm not saying we don't
>> need to fix, what I am saying is that such a fix must be done in a
>> negotiable way. And it's better if parents won't get any burden. It
>> can just decide to implement reset_map() or not.
>>
>>> Reading the below response I found my major
>>> points are not heard even if written for quite a few times.
>> I try my best to not ignore any important things, but I can't promise
>> I will not miss any. I hope the above clarifies my points.
>>
>>> It's not
>>> that I don't understand the importance of not breaking old userspace, I
>>> appreciate your questions and extra patience, however I do feel the
>>> "broken" part is very relevant to our discussion here.
>>> If it's broken (in the sense of vhost IOTLB API) that you agree, I think
>>> we should at least allow good driver implementations; and when you think
>>> about the possibility of those valid good driver cases
>>> (.set_map/.dma_map implementations that do not clear maps in .reset),
>>> you might be able to see why it's coded the way as it is now.
>>>
>>>>    It's about whether we could stick to the old behaviour without
>>>> too much cost. And I believe we could.
>>>>
>>>> And just to clarify here, reset_vendor_mappings() = config->reset_map()
>>>>
>>>>> But today there's no backend feature negotiation
>>>>> between vhost-vdpa and the parent driver. Do we want to send down the
>>>>> acked_backend_features to parent drivers?
>>>> There's no need to do that with the above code, or anything I missed here?
>>>>
>>>> config->reset()
>>>> if (IOTLB_PERSIST is not set) {
>>>>         config->reset_map()
>>>> }
>>> Implementation issue: this implies reset_map() has to be there for every
>>> .set_map implementations, but vendor driver implementation for custom
>>> IOMMU could well implement DMA ops by itself instead of .reset_map. This
>>> won't work for every set_map driver (think about the vduse case).
>> Well let me do it once again, reset_map() is not mandated:
>>
>> config->reset()
>> if (IOTLB_PERSIST is not set) {
>>      if (config->reset_map)
>>            config->reset_map()
> To avoid new parent drivers
I am afraid it's not just new parent drivers, but any well behaved 
driver today may well break userspace if go with this forced emulation 
code, if they have to implement reset_map for some reason (e.g. restored 
to 1:1 passthrough mapping or other default state in mapping). For new 
userspace and user driver we can guard against it using the 
IOTLB_PERSIST flag, but the above code would get a big chance to break 
setup with good driver and older userspace in practice.

And .reset_map implementation doesn't necessarily need to clear maps. 
For e.g. IOMMU API compliant driver that only needs simple DMA model for 
passthrough, all .reset_map has to do is toggle to 1:1 mapping mode to 
the default/initial state without taking care of maps, as 
vhost_vdpa_unmap(0, -1ULL) earlier should have done the map cleaning job 
already.


>   to have this behavior if they need to
> implement reset_map,
>
> What if we add a new callback like "config->buggy_virtio_reset_map",
> different from regular reset_map callback at cleanup?
Right, separating out the need for old behavior emulation from 
.reset_map is much cleaner, and this is what individual broken driver 
has to maintain without penalizing other good drivers. Good to see what 
I said earlier is heard.

> Only mlx5 and
> vdpa_sim need to implement it, with a big warning, and new parent
> drivers can trust they'll never have the old bad behavior.
Let's see what Jason will say about it and try to converge on this 
first, I think he seemed to imply that this is part of ABI that every 
driver has to make compromise for. I'd better get it ack'ed before 
proceeding to the rest.

Thanks,
-Siwei

>
>> }
>>
>> Did you see any issue with VDUSE in this case?
>>
>>> But this is not the the point I was making. I think if you agree this is
>>> purely buggy driver implementation of its own, we should try to isolate
>>> this buggy behavior to individual driver rather than overload vhost-vdpa
>>> or vdpa core's role to help implement the emulation of broken driver
>>> behavior.
>> As I pointed out, if it is not noticeable in the userspace, that's
>> fine but it's not.
>>
>>> I don't get why .reset is special here, the abuse of .reset to
>>> manipulate mapping could also happen in other IOMMU unrelated driver
>>> entries like in .suspend, or in queue_reset.
>> Who can abuse reset here? It is totally under the control of
>> vhost-vDPA and it's not visible to uAPI. And we can fully control the
>> behaviour of vhost-vDPA.
>>
>>> If someday userspace is
>>> found coded around similar buggy driver implementation in other driver
>>> ops, do we want to follow and duplicate the same emulation in vdpa core
>>> as the precedent is already set here around .reset?
>> I think so, have you seen the links I give you? If you want to go
>> through the one from Linus thread[1], you can see the one that unbreak
>> virtio-IOMMU[2]:
>>
>> 1) Someday, we spot invalidate with size 0 is a bug
>> 2) We fix this bug by not allowing this
>> 3) But virtio-IOMMU userspace find that size 0 actually clean all the
>> IOTLB so it depends on the behaviour
>> 4) So the virtio-IOMMU userspace find it can't work after 2)
>> 5) Then we recover the behaviour before 2) via [2]
>>
>> Another example is the IOTLB_MSG_V2, V1 suffers from in-stable ABI in
>> 32bit archs, most of the userspace survives since it never runs on
>> 32bit archs. The fix is to introduce a V2 but we will stick to V1 by
>> default if V2 is not acknowledged by the userspace.
>>
>> I think the above 2 examples are sufficient for us to understand the
>> case. If not, I can help to clarify more since I'm involved in those 2
>> fixes.
>>
>>> The buggy driver can fail in a lot of other ways indefinitely during
>>> reset, if there's a buggy driver that's already broken the way as how it
>>> is and happens to survive with all userspace apps, we just don't care
>>> and let it be.
>> Without IOTLB_PRESIST it doesn't break. With IOTLB_PERSIST and if the
>> reset_map() is done unconditionally, it can break. That's my point.
>>
>>> There's no way we can enumerate all those buggy behaviors
>>> in .reset_map itself, it's overloading that driver API too much.
>> If it is not noticeable by userspace, we can do any fix at will. But
>> it is not, we don't have another choice. Especially considering the
>> cost is rather low.
>>
>>>>> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
>>>>> backend feature negotiation in parent driver, if vhost-vdpa has to
>>>>> provide the old-behaviour emulation for compatibility on driver's
>>>>> behalf, it needs to be done per-driver basis. There could be good
>>>>> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in
>>>>> .reset, and vendor specific IOMMU doesn't have to provide .reset_map,
>>>> Then we just don't offer IOTLB_PRESIST, isn't this by design?
>>> Think about the vduse case, it can work with DMA ops directly so doesn't
>>> have to implement .reset_map, unless for some specific good reason.
>>> Because it's a conforming and valid/good driver implementation, we may
>>> still allow it to advertise IOTLB_PERSIST to userspace.
>> I would like to know why this can't work in this case:
>>
>> config->reset()
>> if (IOTLB_PERSIST is not set) {
>>      if (config->reset_map)
>>            config->reset_map()
>> }
>>
>>> Which belongs to
>>> the 3rd bullet below:
>>>
>>> https://lore.kernel.org/virtualization/1696928580-7520-4-git-send-email-si-wei.liu@oracle.com/
>>>
>>> There are 3 cases that backend may claim this feature bit on:
>>>
>>> - parent device that has to work with platform IOMMU
>>> - parent device with on-chip IOMMU that has the expected
>>>     .reset_map support in driver
>>> - parent device with vendor specific IOMMU implementation
>>>     that explicitly declares the specific backend feature
>>>
>>>>> we
>>>>> should allow these good driver implementations rather than
>>>>> unconditionally stick to some specific problematic behavior for every
>>>>> other good driver.
>>>> Then you can force reset_map() with set_map() that is what I suggest
>>>> in another thread, no?
>>> This is exactly what I was afraid of that broken behavior emulation may
>>> become a dangerous slippery slope - in principle we should encourage
>>> good driver implementation, as they can work totally fine with older
>>> userspace. Why do they have to bother emulating broken behavior just
>>> because some other driver's misbehaving?
>> Please read the link [1], Linus has explained it.
>>
>>> And what's the boundary for
>>> this hack, do drivers backed by platform IOMMU even have to emulate (if
>>> not why not, and is there substantial difference in between)?
>> The boundary is whether the behaviour change could be noticed but
>> userspace. And I've shown you it's not a burden with the pseudo codes.
>> If not, please explain why.
>>
>>> After
>>> getting through all of this, do you still believe everything is just as
>>> easy and simple as what thought to be?
>> The truth is that bugs exist everywhere. We can't promise there's no
>> bug when developing an uAPI or subsystem. For kernel code, the bug
>> that touches uAPI might be fixed in a way that doesn't break existing
>> userspace. If you look at how downstream to maintain kABI, you will be
>> supersized furtherly.
>>
>>> Btw, I thought I was expecting but still haven't got the clear answers
>>> to what was the goal to do all this, we spent a lot of time trying to
>>> unbreak userspace,
>> The code is pretty simple. But yes, the time spent on justifying it
>> might take some time. That's the community. People need time to
>> understand each other's points.
>>
>>> but looks to me as if we were trying every possible
>>> way to break userspace
>> How could my suggestions break a userspace?
>>
>>> or try to approximate to the same brokenness
>>> mlx5_vdpa may have caused to the userspace. What we will get eventually
>>> from these lengthy discussions?
>> Siwei, I'd really suggest you read the link I gave you. You may get
>> the answer. What's more, It doesn't cost too much then we know for
>> sure there would not be any issue, why not choose the hard way?
>>
>>> On the other hand, if you think it from
>>> vhost-vdpa user perspective, you'll clearly see there's just a couple of
>>> ways to unbreak userspace from the internal broken map which is out of
>>> sync with vhost-vdpa iotlb after device reset.
>> Patches are more than welcomed.
>>
>>> If this brokenness was
>>> something universally done from the vhost-vdpa layer itself, I'd feel
>>> it's more of a shared problem, but this is not the case I see it here.
>>> While the long standing mlx5_vdpa/vdpa_sim issue is 100% misuse of
>>> .reset op in a wrong way per IOMMU API definition. Why leaving this
>>> discrepancy to the individual driver is not even an option, I'm still
>>> not sure?
>> Sorry? I start with a switch in the driver, and then I try to avoid
>> that. And it seems you don't want a burden on the driver as well.
>> Where did you see I say we can't do that in the driver? What I
>> disagree with is to use a module parameter.
>>
>> Even if I fail, it doesn't mean we can't do that in the driver code.
>> If you read the link[1] you can see the offending commit is a change
>> in uvcvideo driver.
>>
>> Thanks
>>
>>>
>>> Thanks,
>>> -Siwei
>>>
>>>>> Then we need a set of device flags (backend_features
>>>>> bit again?) to indicate the specific driver needs upper layer's help on
>>>>> old-behaviour emulation.
>>>>>
>>>>> Last but not least, I'm not sure how to properly emulate
>>>>> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no
>>>>> .reset_map op implemented, or if .reset_map has a slightly different
>>>>> implementation than what it used to reset the iotlb in the .reset op,
>>>> See above, for reset_vendor_mappings() I meant config->reset_map() exactly.
>>>>
>>>> Thanks
>>>>
>>>>> then this either becomes effectively dead code if no one ends up using,
>>>>> or the vhost-vdpa emulation is helpless and limited in scope, unable to
>>>>> cover all the cases.
>>>>>
>>>>> ----------------%<----------------%<----------------
>>>>>

