Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67553769744
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjGaNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjGaNNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:13:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA16126;
        Mon, 31 Jul 2023 06:13:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VBtb9R019856;
        Mon, 31 Jul 2023 13:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kAERs/bCahQY20Wiw++AK74p0rcQdAuthiXc9uROEyE=;
 b=bTK+aCsOnxZ14S6XTJIAh5hg0t40kdVv2Gbz4BZ/4CwQpCFRIcQsgjOgSj9Huk8+4rDT
 rqi2Dle76H1fAth3Pd7dPgVG17VCZWqOmGwZoNhndlfDegQr2wIoCahkr+BBqn4/3LOm
 JR61Nq7zLypqDzd1kTS9p5pQ66y1Y482TQH4Hu47FSjARvPUu/1mGXEykg1xQFEVRGzD
 ZzldYQnTIP2eJnPxF41P+bFWrtoTQYvSFN7BGFFpyV4QLLhqXHHDA5Wlvh+10MSoTTK7
 nmTcG4PSq1Yr+PQR2Dd+EHlg/97uWp+c64vJjKAklLQYcBu4l7F901Pa4MCWTjIvt3v5 iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2ahwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 13:12:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VBZ0DG013884;
        Mon, 31 Jul 2023 13:12:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74swju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 13:12:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILJmg/PPueAMWd/F5pRUOqY6Zqd48YwtC7EUpTNXd4+bEu4W0npkUCv2x0x1YFt1XUEYkPoi7DS8j3l6Y/DpkOexWcfOFf3znwsR3QkD+9kC4rkUdBqkX7vRPN99UXJXQbif1EQjs+Q1Ep09Hq1+jEmOIpHKItGMIXDwms9oRK2MRBPnBO94sSftrpOHDR2QNvqHtd+la/Xi4K4rrlGjEhjCBRgxyn91E+PlfXB2M9d7jr/f4+O5sQs6P2lHAo+3dl4p69OsElRA3rQjlr0R4GCu+uPfGa6PN8VE7CiXM9j2EPG4TmQnPSTXmO97nofnFLHW90AwxMBbe2TG5NJsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAERs/bCahQY20Wiw++AK74p0rcQdAuthiXc9uROEyE=;
 b=FlxYtQEYoEXS76/WYAO+QTdoMPhLwcYYb0JlZgJEeqLfiEP/83fRCd8ogAKginjMfa4IncgZ5Q5GrjcbKwb1M8O9REhUnZ508x8/8eMUmf14iGRxV1ekQDAB/jwMJ9554uEmOZ3FG81WZE/zOoVrtfV5UnsOxciQPEcm/hOxe10IvU9UpKw7KYLEDO48eM1/Fl5Z4xt8m+iIWcRism4mjGpyK6ltzXCr50mbINFN6qTvNXs6gs5T4lMsLrs2/sf7P2y/JtyMtl2yqG5mCIg/xBI/8Po0w0J4Hh+PhWky28SNVys7nt+H93UhmrrWu3siCiEdNZy41lB2+H9QCjC0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAERs/bCahQY20Wiw++AK74p0rcQdAuthiXc9uROEyE=;
 b=Z+QQF/6tyDo/5NoEaIPKcQ08Vvr0AtwOe9h4UZ7Q+d65zJjMq7DyIDb/KRZ+xoFIZTry82R+IR/WRuNBJAAPEUWNMR/aH3rZZlWuVLKwhHwRkNmbVcmGUwcEO8Vfwts8RP4we/fRtP3w2pAJUfggZHoT+gX2i66cQulaA9dq8ic=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5999.namprd10.prod.outlook.com (2603:10b6:8:9d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 13:12:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 13:12:32 +0000
Message-ID: <bbf54737-ed49-5be8-722d-85906c803410@oracle.com>
Date:   Mon, 31 Jul 2023 14:12:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/5] perf test: Add pmu-event test for "Compat" and new
 event_field.
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-4-git-send-email-renyu.zj@linux.alibaba.com>
 <abeaafbe-2290-d272-ddd1-f358f7271edc@oracle.com>
 <2dc21269-2fa0-ea39-454d-5f12a414bc13@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2dc21269-2fa0-ea39-454d-5f12a414bc13@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df1b40e-16fa-41cb-fff9-08db91c7cce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYCGtI9GwsfjvywWhohLNX3c/ZR0vnvzhNKqNsHXigeZjzhNutO2Tt9hU58XQnonoRBcmmk1BQpYNNOv4Dv+OT/9k25YqyHrjMjuwzVUNzx++ljsrxqqYM/BsHHK4nGeVEQXfRuv5CBOFg26/bVLh3lhjg83diDrZwrBsu5tzghGIl3bOxh8zFW8EhirfIToiEiZqPoc1ZBirDvxyitPImGULsQRlz2W1tq2TUjX8ZfSspA+v+BQJkPOsShH9KRJMUfIDh8hy2scojF4UT8B77VVP3K/VLDKWfrzbe6u65y3TOtzWTi/5vTS/cOdc8dYtwRWrY5mMOTqHViYDvw21vGbbdCZ6lf8VLoBqTZuxbsTU3Cv6sTzOrRs7ONlXNxIwJlSauvfas09o1CoK904cRAwG7hsjT1ayCSCRmwV70Nz+GlM88J+p2ZV94/3xYsD0tYT8bPnexhxiEc9ZdvHadcjOG6esF5e6UQMc3dDhgVkVZnoAfwOH+nVOjGMgCJLqjOLtpihzaWvlt0XSJJsEG1O2ogPYE1j1z4NtNpR4cOCuIchi/0x1JRgE77Bt6LHXlusoQD4TNWwRXm8OTrhuXRQvV2qx5oo9kF57PsH06nZ/Zq0pMgru+pTApyYeFaP1PaKr5RplQ5fsd4t2sMegw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6486002)(36916002)(36756003)(53546011)(2616005)(26005)(6506007)(186003)(66946007)(66556008)(7416002)(41300700001)(54906003)(110136005)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(31686004)(38100700002)(2906002)(6666004)(478600001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFTVGpQZWtQSjVkQTNjQThJTUthTk1xcGdza3VxK1RnRUZtVDdOQkk1ZDEw?=
 =?utf-8?B?OVdWSzJWMS9zenJnc1QwNkxHcXNnR3FXbU5tU05oWWxzbjhzWVRvTGF1V3lT?=
 =?utf-8?B?S0xLc09iUU16VVJHOTduM3lRYlBhZ2s1WU5VRVluanNFS29wQmhib0YybWYy?=
 =?utf-8?B?UGx5aWU4NnZzMWhtOFpvUHVoZzRTcDZ5ek9JZ2E3VDRhbU53V20xZHJvVCtj?=
 =?utf-8?B?Sy83ZkVXSVNsZ21QZ1RsZTF3VWNrYVA5Z256dWxVWnVWMERDdnMvdkN6QVRx?=
 =?utf-8?B?QXU3NW1hRVk2bHdLdGZWWmR1SjFEK3Y0STI0TmI0Y1FENnRhU2xwSHdlbFpo?=
 =?utf-8?B?SC9LQXRic2dNbG9IdnhYU0xiaDEzNldIR1FWMm8xRXRrYml0V2gxa3B4czBQ?=
 =?utf-8?B?Z1VzbStpRHpLS1Y4SjBWYS9LVGY5KzR2WWxqWm9JZzFVVHpUdmVRYkxjYjgv?=
 =?utf-8?B?UG43MldtMmUySjlkdk53bEJFWTV3UUhPRkZhLzA5YlV4eW9TZ0xyUVdibGFq?=
 =?utf-8?B?TEdQUVdhOHEyVjRQdTBqdm5aT2MxVU93ZzBVMFlyVkZHNlRNdHkxd1FVZUk3?=
 =?utf-8?B?NEN0dEN5cVYwYjc0eGY2eGJMTTZIbWtXbko4Zm0vWFN3di9ObWxjbURJbjR4?=
 =?utf-8?B?NnF5WkZOd1hSZ3B6UFZUV3BYc092T3BCYW1mclZlSTAyb2hFMEk1bWZsUk5R?=
 =?utf-8?B?alc3VmVCNHFLQmxNdURZaDlZdWc1c1BGSGpjNldUaDZXTkdXYTZ1SisvMUND?=
 =?utf-8?B?SS9jclVsS3JwdHBqUk9QTk4wT0hvR3orc1JZaURMTitRVlVXZlQyRDJNaTVE?=
 =?utf-8?B?WnNMbE15SWlrWnI0ckV2V2JXNWNHV0VIRjFWd1N6eW5LVGRqbGE0TlFGcW1V?=
 =?utf-8?B?SmRDM0VHTmwyMjdDT29uN01kS3l4VEgwUTU2cnc4Q1JSUUppRkxtcndsWFpk?=
 =?utf-8?B?VTc3UitWMU5kczRXUnhyUk5WRlE5QWk5bWNLOTVJT05Sb3JlbEdXdlBXLzRl?=
 =?utf-8?B?OCtYKzMzM2sreWN3b1FtajNQaGM4T3p1YklPTXpVY3hlVkpPaEEvcWxRd0xM?=
 =?utf-8?B?Tk03TXhDNS9qek40eFdRb2dvZStLOG4yelNvd25vTkJqUVlrVVNxT1hWS0Ja?=
 =?utf-8?B?WWFpeUtncENzYkdLRUluM1hWTEJFZElsT2Z5b3VZelkxcTExTUhMSys3eDhO?=
 =?utf-8?B?R0szMTk4OGRuMnR3QXVFZHBvUDRrR3h4UEF3YnBYYnZFVmxKR3N5dE5ZL0pS?=
 =?utf-8?B?U0dNUTJ1a3JjOUtlaE9OejBsWHNmMzJENDlHOXV1UjV0UWE2a0hxdEpiMFJY?=
 =?utf-8?B?Q0xCb2tWOE4zNGpyV0JtTHZzNCtCdEFwQ3grYnVYbHZLcE5qMjh2UW5zWWc1?=
 =?utf-8?B?citJUHpPYmM5RUF1cE8zays1dFRicEVYb0M4U1AxSnVDYmV4L2FkaElycTRp?=
 =?utf-8?B?R3ZCOHJDNURNTFRDNXlqYlA3QmVsYU5YS0duOFFGZDl1ZjI0VUJSQnFNN1Z6?=
 =?utf-8?B?Y0lFV1VEaDkrdzIrR1B6K2xucVB3RDVyU2ZkNXdOejh0a0t1MGtMR2pWZUw3?=
 =?utf-8?B?N0tzY3FsNnd6V0tLekhYaEtjbTVkMTkzQjJQdjUzQUJMNmFWMlJ6YzAzUmk2?=
 =?utf-8?B?MWFzeDlnL09PTGY1MlBFTmJENE1YUDlTM0ZlZjRaNm1FbjlSS1pER0htVVZT?=
 =?utf-8?B?bkJyM0dRcU5vdmd0T1ROQ0VRN2poK2tDdDcrVzhxUlBobVlVMWRUVHFQNUhu?=
 =?utf-8?B?dmE5MlZNSXcrRjN5RkN4dDQyYTM3SC9jVWNZOFJmbjQ0UjJLODhGWkEvTitR?=
 =?utf-8?B?QWo0QVpZVnJ0dzA4SWE0bk9nby9RNThOaXZ6UGJQNDJtN2hIbnZ2MC83OWI4?=
 =?utf-8?B?RW5wblE4ZTBlMHNYOFA4SHdwUWRLNTNGcXBnT1JsdXhYTGtvd3Ewc0xwMGF5?=
 =?utf-8?B?clpVSGlNU3RpVDg3bjFNSXZsTnV4bmVQYWtCWHBmMHVXVGduK1UzUXVpL2lx?=
 =?utf-8?B?ZWdFejhXOFRNYzRsUklpbWR1TkxDZ1Jia2drMHc1RzgxVlJteXVvNlRQYUgy?=
 =?utf-8?B?YnM3c1QzZTR2elFDSU93dUUwVjZQRGZORUEzRW5RS0Q3ZEZyUkJyT002Zm9x?=
 =?utf-8?Q?Id2MAEyKOpzd/erwvTyvyrQFB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b0JZQW1mcm5aNVF6WjNUTzFqTXV4a1MwRGtVRUNjVmpSQVAvdnppQWxJQmZG?=
 =?utf-8?B?RVN4NGI0OC9VUWVEM2ZIWDRVSWgwWHFjcGhEV3ExUzNKT1JVM0FxdUkyc3Vp?=
 =?utf-8?B?Vk4xM3FJYTZLV2o3Z2F3Ulp6bHZlaGZhZFcxeEVMTVBHUzhieTlNMUhLOWYx?=
 =?utf-8?B?engyOWIyMDJvcFRFWmNiN3h3V3FtV1JSdEV3MURma3l6WnB6T0VCeFNRZ0JB?=
 =?utf-8?B?VWtld25YOG1PNlgzTzRrZ3hyNE1LRUc0RVFXM09XWUppWHJqL0QrMjY4T1JQ?=
 =?utf-8?B?NHFBbnJTTHg1MWFUdHlyVTI5UjNpYzVZWHdEby9lMnE3Z2JlTnVuWXVpRjhm?=
 =?utf-8?B?YWdyNm5IenhNb2QwWGMvdlN4NTA4ZEVNVTBYLy9MRUo4UzEybWxwOWIweWl3?=
 =?utf-8?B?WEhvUDB4WDl0RXV4bGoyanZkV2cvTXZYV2hMaTgydFJ6ajgwUEFDU09nM1lJ?=
 =?utf-8?B?endvRUhHYTBxVkZGVmFsME83akpYbU1EblpBZGNDZVBQN0piYXNjSVhDTEt3?=
 =?utf-8?B?K2tpVkxlbHFTblhmOFc4NzRFQzNUdjIxUnd0K1M5a0hRUFFRQXVaTHZLYWlJ?=
 =?utf-8?B?b3VHdWt4bzEva0ZUUW0yam1idGRMMG9ibkdiZU9Uamh1RDQxL1MzMFZ1NWMx?=
 =?utf-8?B?Q0VCMkN6a2NWSFJxbW0rWGJEd0FQa1JrSnZDelRGRlMzVk5QT3hlNlAxT3FN?=
 =?utf-8?B?TU1ma2Yxd1FkRFF3MGYwcnJFREs5d1YrODZiTU5YazVkcWtNVEx2c0tNTUYw?=
 =?utf-8?B?N1o3bFEyeEdNcnRtVDFoV1JSV2RGRklubG5rcDRvVnkxdzJnNG51QUNCK1VP?=
 =?utf-8?B?ejhlQ0xwb05XUktJaGJLbjIxa3plUU9IVGVaVDV1emFONlZDSVhzMFFYU3Jj?=
 =?utf-8?B?ZGMyYzI4QWZpUFJJN21vbEtOQlRZc2tqcTlQWEZDMk15MWsxNExmQXZDZGFQ?=
 =?utf-8?B?S2hrUStORHkrUm56Vk9oQm8zSHhFMyt5TW8valRLUHpBRGVHTWhIQVhnZWdn?=
 =?utf-8?B?RmlmSXo4VlVRU2tLSnZ6Mi9TOXJUQlhUU2FlZy95YTlsanQ0WkhwM1Q3Uy9u?=
 =?utf-8?B?WmY4Y2hJY0F0dmxVNlF3bTUyQm1nRGNoWkNicWhpMUdVOUlpemxJZWV6QmFy?=
 =?utf-8?B?WTV3V3VaMk1jbDFRQllMT0VZSjB3TmdNS0cwdk5qZE92enNFdU4vZy9JYnhV?=
 =?utf-8?B?Y0g3aXVYakZQalJENWN5S2FOUEdrZzlqelQ4VGVUSXdOcldUQ3VpaFplck9s?=
 =?utf-8?B?VnA5RStDMjBIeVkvOFhRK2gzdW1YY1Zuaks4eWdyQ0llZVY3TzBEY2NFWnhw?=
 =?utf-8?Q?cOOGhDQ+iTH1mmWvtGMMNyZuUrDHsfcoVJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df1b40e-16fa-41cb-fff9-08db91c7cce8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:12:32.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTDOgf540+8qEp5U/Q4dB8hD9e0Cm4w6dt18KbrIpEUZQl9QbCIawyFhvKBluIX4PtACV4YljXghb5UtudKv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_06,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310118
X-Proofpoint-ORIG-GUID: iy59QjJgJUSyt4REa2mE4Wh-xENf5_CH
X-Proofpoint-GUID: iy59QjJgJUSyt4REa2mE4Wh-xENf5_CH
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 13:30, Jing Zhang wrote:
>>> +        .pmu = {
>>> +            .name = (char *)"uncore_arm_cmn_0",
>>> +            .is_uncore = 1,
>>> +            .id = (char *)"43602",
>>> +        },
>>> +        .aliases = {
>>> +            &sys_cmn_pmu_hnf_cache_miss,
>>> +        },
>>> +    },
>>> +    {
>>> +        .pmu = {
>>> +            .name = (char *)"uncore_arm_cmn_1",
>> Shouldn't this match some perf_pmu_test_event entry with same matching_pmu member? But is perf_pmu_test_event.matching_pmu member ever used for any checking???
>>
> I need to double check because I was testing against 6.3-rc2.

That 6.3-rc2, was for the the kernel? Or baseline for this series? See 
see maintainers for git/branch to base perf tool dev on.

Thanks,
John
