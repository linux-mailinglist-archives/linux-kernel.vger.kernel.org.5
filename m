Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E777EE15
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbjHQAGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjHQAFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:05:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A12133
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:05:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GNfr5J021114;
        Thu, 17 Aug 2023 00:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4DtpvQ4Kp6TWmhRO7LooPXBfALBcKql/I39PzfAdQVc=;
 b=yHdxS9F6u9Gh1lhe/X96DkDw+vJ+JpDUg02uxPEgjpztvfhyGJXqz12duDmYHJjU4qgd
 LHDMGecW1re7JfmzK/6DBRbQVIwwndphnXuObXgidG7EG9+LfotYotmzRk+uJqlgq4a+
 GbmH9/XjS1vM0/wkrSz/GgXNg/hcRlpbEV/U6V/43HyPmBFeUFMDmNh0IeEuzEL6FLv5
 snOP6wwVglNE0H+EwzWvr0fy3wsRy8FEBRftCmKYG5c8K586KneNV/xsykV0BLEuvGLJ
 TknGra4uDj7b1+ugpkUFHe00YPzCUFsA231HYli/KG0AbJoVzrssGCCbWl5pm4CD0kWK 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfr850-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 00:05:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GLVaZe040114;
        Thu, 17 Aug 2023 00:05:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0swdu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 00:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUvrCQ4GoXZ/wyRVlDkEEVR5pBmg4EBzZn8O+RzGNy2SBflyU0my4sdIUBW6kd3BMwjcIvERXgi4+UgNoFiqAI1TdFfS9jvxU17/hAE1Qfxdvbf10eByIpSD53qKXVUvJP+qY/G3fkAyW0N7B9LMM198RscOs/K5iqCgSM/brz7Za5Yp5IB/viLRf8AN5COlatxI71iV2hvp9QslPvjR038VR9UTuDsVNTxt5upmyVI2WYBK7Zh+YscK8AGA080nlnvOzCfLkaoH2KTQeAEpYN4Va8X4E0PR8L7mDJ++MIV4dihtmkAaa7BtmY9O2MHxXfr7Yefab3aMJLNQna8q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DtpvQ4Kp6TWmhRO7LooPXBfALBcKql/I39PzfAdQVc=;
 b=H+aIPGiL7B8DO1FMFHi8p/ktkCfl/39ar1m4bkmsTBdeljzZQ9sC4GNY3rVDtWQBB29OMbM0/QhKfi5GoMkpNf2Q6FsNalqVbyf3pFMJnKmc42+KcKxKK6jJ7sIjyx94x+VyH/TdrJ6iL1bGgp+m1YUKfeVJonnDrSR1PZDo3JxKDsfUraBJZFLwoD2oIG8LZtYcWeiAEgWt1vTjUfqrNuMywpD3/DITZ5IhhWtQ8sO9srLTVyTsu27Yppp/4nIobhjLxIAXsq1Y/WRjkg9xhMdP8tw6YO3tG1g75Cqi5LdNo9fzaCBKnmjAr7e18Piq4BGJZYbU//XNGTXQh8DcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DtpvQ4Kp6TWmhRO7LooPXBfALBcKql/I39PzfAdQVc=;
 b=ZlLGT7SrO35kPxpT8rU5Go6d9JrgBDrzcpTNGSt2q/AaM6R8ohxmcHzxKL62M2I0Yl66mpV2qBvntc1aKjUUnzWGJqKkNfcYXQ+cloJvZbQujyO+cSSVaMMLNfVw85GtsnMicDWQrNYMdhlk4GjHy+bAgUzbhUYo43Yj/hRp/Dk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB7220.namprd10.prod.outlook.com (2603:10b6:930:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 00:05:16 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 00:05:16 +0000
Message-ID: <46bd545d-6a90-fb51-3beb-dc942f9609af@oracle.com>
Date:   Wed, 16 Aug 2023 17:05:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuGeXYo3s6Ytd-Nvp7EXU6td1NY6LrLcVgntprXJwBEhQ@mail.gmail.com>
 <ebc38dc4-ed43-6a1d-5368-ae75269e6b43@oracle.com>
 <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEscjR_bTVfwaRcQ8qxpiOEJAT35Y1uoj=kBptYkbijDbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::25) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d299b98-4db2-46e8-22e1-08db9eb5a248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuFcQCCB11ksQ+MKPKgdsCcu4yt4LH6B+88JjDHqb7l85w4dO2Mkqp3wwxhJ5nfD28KuurJMhkKzr6tYhUwscXDld2bR+4L4ectwMAoZ25CjgEMfmI6jZf7+ADLr3dPiOsCw2spDr0vOyfrvwr+xcN+6xNMIwInl7dAGdv4svYE2glzV3mAJ4O/iYWrGbAjjB5Yt1+c0xP3PzlO6IitiMpAM7Ejn3OLeW8xmGuNVe3OSRJ+Ow0xgOUdYQXJKCtcwrXmrEsPKkFx2mBXRokcyRuJHu4sJhlb2RoLGJD1rmAmwvMIeStNlN/cP7wWogyolO4GZ9jUyhTCqEih9Y1e7sUMZzHjlYPPp4nXmAbE8ZErvlN2ZDje5BNQ5KgwICKfr3EN/VRcTnVcdLnD9IJ7qnEgfEof4hayNxcuFFjLAQAph79D4diFBgoKO7nr7lZVGnhT0GQYd2UAJ1uO7Q/MrYAoGPHbx3Oja4i+JVi8olnoMyNqsnLW0f3kfCiEXIHuqaskdoEGw2HymdoL2l6vFIXT0J0iPLCo1M0Nj4JZEBqNZh1n79rRli0fcpnjTT2DzmCErFtLzgurZluK/D63UdIIJNiCGtS3G+bmP0DyHIX+Vuu7xnBUOzDIDdVDQ0J/h2+S7yj6T+JGU1WMfobBHtDUB6W0vf4QobachR5L+60mqiRaNHcUugJtYju16MdAu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(1800799009)(451199024)(186009)(2906002)(26005)(86362001)(478600001)(36756003)(6506007)(6486002)(36916002)(2616005)(6666004)(6512007)(53546011)(31696002)(5660300002)(41300700001)(316002)(66556008)(66946007)(66476007)(6916009)(31686004)(8676002)(4326008)(8936002)(38100700002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xRdktqTnpkYkl6a2Y0eFFrV1M0Y0FTQzQxVFBKcDNSOTRlc0ZqbC9NRERi?=
 =?utf-8?B?YkxGelNxVTNHcHJYMUk5WHRJV2xGL0hWMUZnSHpDdm9xbE1nTzNHQlhOR3BR?=
 =?utf-8?B?N1FNNHM2YzhHZzVtNDVXVmQ3MzV4aVlINC90N1k1eTZTYi81bzlGWElDN3JK?=
 =?utf-8?B?ZEhVYk5mSExHQ0RZSlVjYjJ5QWF5RUFrYnRoT3NDOTRTZVpQR0JGZ2U0dVlm?=
 =?utf-8?B?RktBS01pRFZTMWE4NE8yakpqc0d1T3VhbE9tVUowK0loUVNBcVhKMlgvYjlB?=
 =?utf-8?B?Vm9IbzB4NGRCSmZTYzRpSWdHY1E2SGZtcTV4Y2pnMG4rTER6QlVmbGNmWWpP?=
 =?utf-8?B?eXdzaFZsdEJ4eStTRkdWSXIvQSt5aEtBQy9XRnU3UW5pYTl6Z051ZDVETUYw?=
 =?utf-8?B?Q3dRaWZVY0NaMDEzeFRXSkNVTmJIY0tiS2tTODdtUTU1T0hXd2kybElGOGxT?=
 =?utf-8?B?WHlwK1FnbkcyTDNOanNCcVpJbGhxaXk5T1RqTG5BWjZyVGZjOWRhUWN4Q3py?=
 =?utf-8?B?OWdjZ3NVUnFHL1FxckdCWjZnSnIvM2NQUFc5T3FvQnJ1U0YzVVBHanZRT2xw?=
 =?utf-8?B?L1FnbUxBR3RxclArSHN3V1hFOHZNd3c3TGpDN1ZwTUNqcXdOZkpTQnBHYlhU?=
 =?utf-8?B?SDJWNVh2OVZqZDBOVFAyV0dKS1JrNjBUYS9HTVM1RG9CRG9zcEVPNGROVmxO?=
 =?utf-8?B?YzArY2pVSG13YVFTbTNtd1luUEFncStEM2owVnVVWEdzNHVWOVpTVkZ5Z3Q0?=
 =?utf-8?B?S2d1YnJ3UmdvTittWit1WUNNYjNOcW1mcEcvQlpFQmRUKzltYW9vNmhDbENy?=
 =?utf-8?B?SHBRbmt4TW5zR0VqUWk4MHc1RG1NTHpMb01PVnNzVDc1WDF4M25ieUp4Sksv?=
 =?utf-8?B?U0tuOFN4ZFFmQXAvWXU3SHNMdmlvbllIWVFqL1BUU1YrNi9OZjhsR0FjcStD?=
 =?utf-8?B?b1gxNEZOdFJRaFZGb1M3cUpYczNzc21LOTA5czhkOCtkbU45cXBsNW96ZjQ0?=
 =?utf-8?B?WTRzMk1DNlQ4M2lRcXNmeWU5N1J2TmlSNHZVZGFCZ21wdUtxTnY4V09NNm4y?=
 =?utf-8?B?UURmRFpzeGdudXl3d2RodHZBR1NXOE8vcVAxZkJDRU9OdHNMUUFnOWZKanN1?=
 =?utf-8?B?cGVpaitWZTRQckhGK3FjRXpzN2hjYUZvNTg1NEY5N09YRzkxcWxNQ2dpOGNJ?=
 =?utf-8?B?ZE5RN2JpbSt3RDQ4eElBd0RxZWhjUmpPdC8weHpSakpWdzc0b0ZIWUJvVS9C?=
 =?utf-8?B?bFV6cjh4aUZwNGpEMjRLdDJROTM5QzRXTUZQRGdQM2Y1dmJQSWtJTXdINnA1?=
 =?utf-8?B?WVZHMGM0T0NhdTJENUdZRzVBZ05GNkNEOU9pTzFlbERqWEpmWUl0c29NZXRO?=
 =?utf-8?B?dWREdmZ0RTJORlNEZWNuK05SMGdXK2NCN0VDVHp6V0tGc2dpWWVpNUp5V21S?=
 =?utf-8?B?elNuMENiRlM3L25wUnZZMFN6aXJjdEJLMUFVMFczc3NNRVB1WVN3QlIxbzI3?=
 =?utf-8?B?dVNiUnA0ZmFPc1p2MmFKdFBmbDJZSlJnYUNhVGJPa2xIbzNYR2ljVGttRm1U?=
 =?utf-8?B?TUt6WHVwaktkTDBWbEZ5UEpvQkF4SG82Y1BBRlRIcHd3YmViNDR6QkhBU08w?=
 =?utf-8?B?eGROcWNSWmI4ay9CR0NtM2RsYTd2ZnJxclQ0NDhJM0NVNnVKZEZFL2pqSFB4?=
 =?utf-8?B?NVJ6YWkrQjRUSVMreUlEdEx2dXc3MFdCKzF0aGlmVlpyRXFQZUR5eHpUUlVq?=
 =?utf-8?B?ellpaHNWV2ZjTjh4OFFZellRclRvZngrYitTemw4KzJBcFZMbUc1cG1MWkJq?=
 =?utf-8?B?TlIrRjRBaWlWaVRyNVJoQXJKQ0RLMG1yU3d0b0p3M3ZBMlI5Q1lYb3hZYndI?=
 =?utf-8?B?VnRUUWtkQUx6bnhzcXo1eXNudGUvVlNvcXE3Njd0RHUzdVZydkpQTEp2N0pn?=
 =?utf-8?B?YklaUkZjYkJnRGswZWF4a0x1TTJxRjRaNXVobHhDZGdmNWZmWG5sK0xQQ1Bq?=
 =?utf-8?B?a1JKOFAwWVRsTlVHbEp5ZDBhd0htME5rMTRPWDB3M1AwTTB4bUFYMlduQ0lw?=
 =?utf-8?B?YkdTTDRxbnFOa2tZNkdMdldNUENPVHFrZ0VlTlYyY29SUFdwdnROYnlaUW5K?=
 =?utf-8?Q?EV3jd+5VRxZSnC4F/M40Q5m+J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUUzMlF3ckJvNFJSd0ErTnphekZRK1BiTU5zcU05bDlCTUxDZnJZMmszNlJX?=
 =?utf-8?B?VVBuL3BxSUFSUmlsczJGWXFRTzBCN3M2SHgwTlU5RW11anc4b0hRRFkwYkhV?=
 =?utf-8?B?dFlNSTJiSUFSeURZZjZUYmdWdVJDMFhaeHlnbDRqQUx4WE1QcCtPdzNNeHE1?=
 =?utf-8?B?cEJaMVFzbHJRSitlTEhSRmpET3V6bmViTTRteC90UkcwMUorTzJiK01WMjR2?=
 =?utf-8?B?bnlMemgyZWYxK3lVam5IdGpuNUtVdFN3NXlVSmYxbE5pcXBJY1h5UWhZTUpV?=
 =?utf-8?B?T3psVXUySWlndFFnaDhUUWZ2WnJ3TUhkdURPUFRtdVJWZGIwMUtJZnVHci80?=
 =?utf-8?B?RzE4aWprRlhCaC8vRXg2Q3J4ZFFBYVc0LzdKeWhzNTlMdFBHTmJzYWNRYlFE?=
 =?utf-8?B?eXpSc3VxTStnNDlJQTB0QTBSTnRUL2JXTzROZWNUb2UwQ3F4eG5tV0E1bUo2?=
 =?utf-8?B?M2Y0LzF1V2hXNWVEVG51QXlicTVNakVoSWZDdkdCRGozbEhyWTlKU3hkbG9y?=
 =?utf-8?B?S0hYTTZwbjNvb0trRzE3a2VHampCRHNyVllEU1ZZbmJiYWpXUFdCdUEzWWh1?=
 =?utf-8?B?bG84SkZ0SzNSSEZPelFaR3BLTzczdG14Y3Zvc25sNFlKZm9NeTJKcWRaUkxn?=
 =?utf-8?B?eE9aRlZwR2wwTXhCcUVsem9MYzB2U3VFK2tQUXlwZUlXdGRTM1BBT3dYNllm?=
 =?utf-8?B?UmNoeTE5aWk0RTFTWEs5QXpaQkhiY0ZBU3ZFWEhST2M0enltNlZXSXhjRnJQ?=
 =?utf-8?B?V2FBWk1aR2RYdFYrcWlWUWhReVA4Rk52Ym5RMElIUWxMenk4RHRkNG5nUFU4?=
 =?utf-8?B?NlkxQVBpbHpIdEwwdCswT01zaFdnc0FLYnJucmhIMEQ0cnRSdWJLSTg0dTFh?=
 =?utf-8?B?Z0hYU2wzMmgyUkwrYkNSY0xTNU5EUHFmdUYxdXFzRjVGWEJNYVVDQitONHVB?=
 =?utf-8?B?MVdqbHgrenBaWCtGaWhuTUhzSm9VVkR6enJ3OVBHQWpnNmRWeGExaC9DR0ZW?=
 =?utf-8?B?K3FMRjk5OW1hRGx4YVk5OUp3ZFcrRFdSNDNQUkFOSVRlT0JvWk1nNUh4dGtF?=
 =?utf-8?B?QzkzcjhlQVpON0Z5VlUraHJSK1hRcnVTbEF3VElrVmdHT01IaEVYRzkwN1Fx?=
 =?utf-8?B?NDhDSUV1NUtBMjhqYlpCRW15Ryt2NjRacjZaZTliYVNLaURIbmxSYmI4R05V?=
 =?utf-8?B?MS9rU25ObnpwRUhJQUVoOFJ6d0F0U1hQYm1lRWJTSjg3RHEvWjlNLzcwRWxh?=
 =?utf-8?Q?8sz7ksr52Veumij?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d299b98-4db2-46e8-22e1-08db9eb5a248
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 00:05:16.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePkY+Y8zfBpX/D/1DrN+vt7rI+9ZZ9Rbkh5DqShQz3NSWkdOZeNsnAFq95NoOgpOelFEJFL4laUHj6M3RQAJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160214
X-Proofpoint-ORIG-GUID: FM3gB0iDbAVrDpGwNrHlJiU_SJIXtKnF
X-Proofpoint-GUID: FM3gB0iDbAVrDpGwNrHlJiU_SJIXtKnF
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 6:55 PM, Jason Wang wrote:
> On Wed, Aug 16, 2023 at 3:49 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/14/2023 7:21 PM, Jason Wang wrote:
>>> On Tue, Aug 15, 2023 at 9:46 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> ---
>>>>    include/linux/vdpa.h | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>>>> index db1b0ea..3a3878d 100644
>>>> --- a/include/linux/vdpa.h
>>>> +++ b/include/linux/vdpa.h
>>>> @@ -314,6 +314,12 @@ struct vdpa_map_file {
>>>>     *                             @iova: iova to be unmapped
>>>>     *                             @size: size of the area
>>>>     *                             Returns integer: success (0) or error (< 0)
>>>> + * @reset_map:                 Reset device memory mapping (optional)
>>>> + *                             Needed for device that using device
>>>> + *                             specific DMA translation (on-chip IOMMU)
>>> This exposes the device internal to the upper layer which is not optimal.
>> Not sure what does it mean by "device internal", but this op callback
>> just follows existing convention to describe what vdpa parent this API
>> targets.
> I meant the bus tries to hide the differences among vendors. So it
> needs to hide on-chip IOMMU stuff to the upper layer.
>
> We can expose two dimensional IO mappings models but it looks like
> over engineering for this issue. More below.
>
>>    * @set_map:                    Set device memory mapping (optional)
>>    *                              Needed for device that using device
>>    *                              specific DMA translation (on-chip IOMMU)
>> :
>> :
>>    * @dma_map:                    Map an area of PA to IOVA (optional)
>>    *                              Needed for device that using device
>>    *                              specific DMA translation (on-chip IOMMU)
>>    *                              and preferring incremental map.
>> :
>> :
>>    * @dma_unmap:                  Unmap an area of IOVA (optional but
>>    *                              must be implemented with dma_map)
>>    *                              Needed for device that using device
>>    *                              specific DMA translation (on-chip IOMMU)
>>    *                              and preferring incremental unmap.
>>
>>
>>> Btw, what's the difference between this and a simple
>>>
>>> set_map(NULL)?
>> I don't think parent drivers support this today - they can accept
>> non-NULL iotlb containing empty map entry, but not a NULL iotlb. The
>> behavior is undefined or it even causes panic when a NULL iotlb is
>> passed in.
> We can do this simple change if it can work.
If we go with setting up 1:1 DMA mapping at virtio-vdpa .probe() and 
tearing it down at .release(), perhaps set_map(NULL) is not sufficient.
>
>>   Further this doesn't work with .dma_map parent drivers.
> Probably, but I'd remove dma_map as it doesn't have any real users
> except for the simulator.
OK, at a point there was suggestion to get this incremental API extended 
to support batching to be in par with or even replace .set_map, not sure 
if it's too soon to conclude. But I'm okay with the removal if need be.
>
>> The reason why a new op is needed or better is because it allows
>> userspace to tell apart different reset behavior from the older kernel
>> (via the F_IOTLB_PERSIST feature bit in patch 4), while this behavior
>> could vary between parent drivers.
> I'm ok with a new feature flag, but we need to first seek a way to
> reuse the existing API.
A feature flag is needed anyway. I'm fine with reusing but guess I'd 
want to converge on the direction first.

Thanks,
-Siwei
>
> Thanks
>
>> Regards,
>> -Siwei
>>
>>> Thanks
>>>
>>>> + *                             @vdev: vdpa device
>>>> + *                             @asid: address space identifier
>>>> + *                             Returns integer: success (0) or error (< 0)
>>>>     * @get_vq_dma_dev:            Get the dma device for a specific
>>>>     *                             virtqueue (optional)
>>>>     *                             @vdev: vdpa device
>>>> @@ -390,6 +396,7 @@ struct vdpa_config_ops {
>>>>                          u64 iova, u64 size, u64 pa, u32 perm, void *opaque);
>>>>           int (*dma_unmap)(struct vdpa_device *vdev, unsigned int asid,
>>>>                            u64 iova, u64 size);
>>>> +       int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
>>>>           int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
>>>>                                 unsigned int asid);
>>>>           struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
>>>> --
>>>> 1.8.3.1
>>>>

