Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E897CEB19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRWVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:21:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3689113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:21:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn3kI027695;
        Wed, 18 Oct 2023 22:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=c/zqi5RjWLv/MzsUcV6dhM3h9Rh6e7LfI+kcbDt+Ggk=;
 b=2BFTKV9U7HtyCHN/eL+Jv8hdawTmvkkjMLK5BccZB+4zirbR7rzsyxFJR7HdhldNEw30
 HlKTkvlv1QMr4snjhTgTRdrUUqUthNCgdNirhk2Fo0+0yDBOgS+wf3Y2/YrZzqc3788T
 IW9nBK02P01guhH7AUG2Ni25DfsOdlHXwD2C1jKhyC9TFe7b8Y4MqPJODqCTRXdaMVeZ
 ktvxEAg0TVnf5qbl7AYzR7ygLr+fm4whB2cGjoux+ywS49tdwzEi+QkbF+wcR6/1XSoM
 yVsnQVpwbmGw34WyRuAEXvoG4t8ea6WWwMz/AlKfnHMSrqPIF/fAuU2aqYFfoDx8CQZE Pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1brmfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:20:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKHc6B040509;
        Wed, 18 Oct 2023 22:20:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypcmcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKATT0Jjg+4PbP0XXfnsYEUhXIs0ItOcuUTXdBNwWUxHEvpIMTIspdBFMYl7yv2M60jPbJAJw4QMQfEQ5EEpVv4+OjeK1mvYESX9kL2iQJIy/hvUAXwRetCTUKiNdBMpt8eYEP34qrJOVPynnBwWTV1DNbonskIjr88EZFU20rEkbEgqNJOVt7h08/WRJ88HSGeUbW6ipxwJSZNvEGLUoei7iXt3jj8fMOtziHCZu5Rcw/hCrSVs3ZTWbM7Um09gvt8BZSgUc2HIfNTZ/cKS6+/HoZmZ6DpyOX/Fv3VDVhEOCRwBhQFmH5mcjcTpnp1YOTvFkMBRKexWYBlMKx3JtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/zqi5RjWLv/MzsUcV6dhM3h9Rh6e7LfI+kcbDt+Ggk=;
 b=HJVjMYWH6Gc4LwbBWBG75VXSEe89bTf46TwjHwo0iza0Jkwc+n9X4Qm0/RRicLrsinxTW44BiU7V0hym2PU01rtvJ8LreySSBNvX31M5PsKzOJt+O/RIvwjY/rgYY33i+INZ+WvJKM7AYpsdGbQM6+6XdC40F3TI2GGVQ4AVoxQlJRUxER9FlQXHFEyRS/7pQ01V2xVykOMdTopAu29yCA+cpWdxSEBZqNwbo8D0HuIJ4R54k+599FtkB/CeWy3th/QGjF0jKUeXF3kWY7/B0uqNzK+B19TGT9Pd2oScTXD0RdvFQ+Uv6qVC+MdOl28+58Zz03F0Yf7cSsChGpiBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/zqi5RjWLv/MzsUcV6dhM3h9Rh6e7LfI+kcbDt+Ggk=;
 b=iPf9YPcpmibEVL/55s8F9P0BK4Ng1ls3UFn1zlH/kcrEDRqbxgjiXO0oa92KF1Bc6Js/N30qMhqX1rZOBiL+yd9e9WvDa16YDU1BQ5Qm6iFtRPXIgyTohbw1Ov/sqZf8dlV+rqg3zbDiNiQGSii4gGTM8fDQr3DmIDFx0nNtlxw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 22:20:07 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Wed, 18 Oct 2023
 22:20:07 +0000
Date:   Wed, 18 Oct 2023 15:20:03 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231018222003.GA21776@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
 <20231012000327.GA1855399@dev-arch.thelio-3990X>
 <20231012145318.GA5127@monkey>
 <20231013001203.GA3812@monkey>
 <20231014000450.GA253713@monkey>
 <CAKwvOdm9xKGQzi6_j=gGZCEmKJe6b9o8+jen1oEeAhyjcaSnxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdm9xKGQzi6_j=gGZCEmKJe6b9o8+jen1oEeAhyjcaSnxQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0235.namprd04.prod.outlook.com
 (2603:10b6:303:87::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: ea836d40-90f9-45e9-9da0-08dbd0286237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5FVuyD9zeC9g3FYG0hio6heK5ciaTwLbDQpMLKMYb0Q/42AmcsGEP9mtwjeziFbYntRjSpmkZ5e2yXNySlU9ykFWHzmcvWvEPooU5ov2eQyIqA8Lq8kEdvXcG3ovAx6TWR6U2nSebEP0JWkQJhdR3wSzJ7HpK+bXrtbqL5RXiRoiKI36aITMRD/+jFCCP/+Ughm+DgmWnFbkaJhwSarIPiKvERZLpck0o7TdJT2Gv/8aTQDMp3pCcNycr0R5sVNTBANqKS4oolKcc7G6jCElX2c0BLTc3Fe2Pe5h2aDDfUk6zCmV4rA79dtBHO/91YeR+5Ms4pzUR3jIY/j2OBwm03t5oDSekSatd+Xf0dDYOKpBOrEPLKYy6r1ZYFBZsdT1T6w//fDqPzv5FUUUGB1WUd1a1+SoCfUIciN50aVoDB/2B7TyEs6AG83CZzmO5z7UbwGLL69sAKDccRB+3Hvu3aCUXz7hsaWDdUi9/+TQjjrvxfsfPviIS8pCxcGsZWazdLaPTqA3uRDc3yJBJMPUigOTckqvgSPsxVR8GW632A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8936002)(8676002)(4326008)(41300700001)(44832011)(54906003)(478600001)(66556008)(66946007)(66476007)(6486002)(966005)(33656002)(86362001)(2906002)(7416002)(316002)(6916009)(5660300002)(33716001)(6512007)(6666004)(6506007)(26005)(1076003)(83380400001)(38100700002)(9686003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkZwWmFaZkRzRmh3YnpCRGFOc3pDYnBSL2ErTU91R2tPUUNOQWQwKy93THF0?=
 =?utf-8?B?OFBlUEZkZDhrRkczWmdFZmdXbmtmWFU5OG9IaTNiNWFXMXpnNTg1VWhXN2Nx?=
 =?utf-8?B?SVAvQVhNSXBmRXJBV1IydDF3Tlo5SWEvVTFiYlIzckx0K3ArTTQ3M2xJK0Iw?=
 =?utf-8?B?Vk1wSm0rOFZZNmNQUXgvZDR4UnRweG1mY0JEeXZiaFp3eEEvclhlVFFFTzJH?=
 =?utf-8?B?VDZuaG1rQUFVREhwY0dIY095QnorMU8zbzdEVVQ0SnA3TytDRTJpMEZBZjVh?=
 =?utf-8?B?VDcvdElDV2VDd3BnVVBEMmloMS8zTEZ1Z05KY1FGRTZuWkhEOTk3dkM1ejAy?=
 =?utf-8?B?cnVNdmh6VXc3T3JPYjIxNEtrdXJndnUxOEt3OUQ3QlR3TnhjR2NWdTh1MS95?=
 =?utf-8?B?cU14aW1CL053QXNVRGtyK3U0S1BtR1dtMnhsTWJMcDYybHRTQWV1RjJUWVE4?=
 =?utf-8?B?MVEybW5QajJsTUV3cy84emRRZ0RCQTlMallsRFJtUGFncVBLOFc0YlJwT2pC?=
 =?utf-8?B?VXZlU0o4SG92MWRxaE1UL25qWHhZRTc3U0QzTHRiUlZlWHlUSFp5Vlk3YWlR?=
 =?utf-8?B?dFRJZkJwTEFhVVVkYnY0L1B6Q05XVkR6ekRXY08vR2EzamlaQmorTi8wT0Jn?=
 =?utf-8?B?QnlYcDkrbDltRzZpeEhLSkdkOXVxM2Myb1RoTFRibHB0SG5QZFJkS0ZYTVNq?=
 =?utf-8?B?VmcraU9pZzNlNkFrTVN3eE5XQWVzRG1kZmh3WXhmNjFHYTdyS3ZwYXhOUHU0?=
 =?utf-8?B?b0o4TlAwUUhXM0ZSVC9sOEtRaUs2c25DTEJIclAyaFRuUllwUWFpYWFUY21S?=
 =?utf-8?B?a2FZVTlaZHJNNG9vNTFPYjI5ZVdzeFRTM3g2VmViUk1zZTF4bG9FempmRVJP?=
 =?utf-8?B?MkNGSVRmRG1QLzZNSC9CcWpmT25JdFd3c0w3c2c1ZGR3U3BDR3YxV2dXZ1Q5?=
 =?utf-8?B?dGtmT2g5cWFxRjJBbXpxUUFkRFdEbjE4VDFHbXpGTTRhaDZBclhCYXhNamVr?=
 =?utf-8?B?Z0VLZmNES1U2c2dNaU1GZ2p3d1MzYnl4bzFZK3ljYXRvVzJHOE42N05EejlV?=
 =?utf-8?B?MkdOcjFBVFVINk1va21pZFpTL0pvUFlzNjkxdDdFdGlvamRqWDVvMXVGRktN?=
 =?utf-8?B?R1N3UHJoMU5tMldlNVBIWE43RklFaFBTZ0g2b1RFbTZtcVVnMjFuYVpIaDNl?=
 =?utf-8?B?NmRSNXBEUEIzcHVEUlJuWEM2ZnpqRzZLTWtoT1RaalhnaittUnVXcGVKclha?=
 =?utf-8?B?SkNxRkFCeHNGR1ZXNVVqYXk5MG40ejdMeXJjMW1iRUxlYjZZVmJhQk5BL0Vo?=
 =?utf-8?B?d2d2M3VEL21Mc3pKS2Q5NnVCZVVMdTB4SWZWMk1lMUMwQUhiN1l3a1hNeTg0?=
 =?utf-8?B?T28xTWlJNTFaWlM3enFJVkI2WGhqb01xa1hVMFRJNFNyQ3J1ZkZ4Y3dJTys2?=
 =?utf-8?B?SnpkcHUrTjJOSzhab0hYeUdMNjF3Z1JLNUpCNmNNVlJ5OXJtZEFkak9PV2F4?=
 =?utf-8?B?R2svV1dpNTgyQytGTjRsRmxEaDhhMzBrOEpDNFJoOWY4TzRiWURnbzhpY3BF?=
 =?utf-8?B?U2pZTE9MOS9wN3V4YTBmSmo5Y2dVU2JlWXZPWGRpTU5sNmdnYnR5dmVkWnF6?=
 =?utf-8?B?UG8zQmZFcy95SjJYMzR1aDdMT3NLUXBaYU9DbW9RekhNYkhnMURvQUNaL0ZN?=
 =?utf-8?B?OXZLUmUwb3Q4dWRPZndvenNEMHY3Z01VVjU2ZkZDL1RVeUx2b2xQL0h3OU8r?=
 =?utf-8?B?bjNzOUc1clJadmd3QUhDQTNzQkJIQ01sbXE0SnZvd1ExOTZSZ2R3QlpXT1NG?=
 =?utf-8?B?ZTVKVUd4QXhmZjNvdTZza1dSenB2UTI3ajN3aTB1RU5ZblN4SXJyUmYrWW8z?=
 =?utf-8?B?MWVyL25HMEpDcUowaTlkb0dqMWtDUit0TGQ0V05wck5BM1hNS21BL3A4aUdX?=
 =?utf-8?B?UzdXczlEanhXcVVTUEdIUDRlTmtudXc1djFRMDFWTnppV3hnTDhBT21LYzJV?=
 =?utf-8?B?VHh1RmFOMVZmZlhMQk1JUUU1bzNFc3oya05kYUxscUF2NjBLUGZTMkJnazEy?=
 =?utf-8?B?RTNjOHNUZkZnTUNMV0c0RFVucHpOc2lsNnBIS1BTRUpHYTlBSGVteUt6ZEc5?=
 =?utf-8?Q?duwP6xh0woOL7NqpQoNGYb9W8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T1RtQmErOEoveEw2WlBJdkx5ZWdaVmdNd2JOb0ZsenlUYWhlYTIzemZvMEhs?=
 =?utf-8?B?aURqRGxCRXErblJCWWZqWWloOFpJVE81eGRTSVBndFFHVHNWOUhiTkxkMVJ1?=
 =?utf-8?B?RkhNSVB0TERWQTZSNVZCV1ZKamR5SXFndkJjOGJVOFdmYlBhVkhLNG1WeXYy?=
 =?utf-8?B?Njk0R2p4YytOQXUzMGEwSzlnZk5pUWNVUmZwNVNnNGF2ZFZYMDk4dnpuMzdY?=
 =?utf-8?B?UnNvWjFSL2JMdWF6RnRNaHFkcHV2V01wMHl6SmFkTFFFOXY1aG1FUGZ5TkY3?=
 =?utf-8?B?eVNDNkx2aytuUjZDdkxMM0xIdWpHQVB5QjRRaUo5b3BrNEZkdUJvMDZweENs?=
 =?utf-8?B?NkY3NTZnekFuUDcvUjV0cnREMGQxcXhUbk42VVVXU2Y0T3ZITlh5dzc5UDcv?=
 =?utf-8?B?RzZpNVRIaWdlMitpcXdJbENROCtRemVtRW9heEhnd3M4OGFYUEJrbGRIUG42?=
 =?utf-8?B?NVRVSFloU3o0S1VaTEpQdFNQNjVDdzV0TC9ZQngzSmpWcEt5RXAxY1dnbzNI?=
 =?utf-8?B?RGhCWWVHOWlqbzVqc3RsSjMxSzlQNUhaWWtNRzdoUVVjTjIzNXo1b2oxUkNI?=
 =?utf-8?B?SzVtL0pkMG5QSmg1R1hlOVh1QTg0aURGZ25SZWFjY2JzVUU2T01hT2NJVlM2?=
 =?utf-8?B?dTNjRkQ3Mm9RT0NEcHhocnQvR2FNTWJ4d2NsdHRRZThoSmp4L2l3dEFCZmpi?=
 =?utf-8?B?YlJ2SkJDSjh0NFprWW9zSlo1UVhNY2EyZUFjTjFETmNNZzByb1krdjVzMUd6?=
 =?utf-8?B?b2xCeC9sS3dtdDdsUjF5OVRUVlhwTDlTVUMyU2xTZ3F4TGxtZVpZcHhaYzFq?=
 =?utf-8?B?eHNFeGVCT1h5b0RwZW51OEpUbUlxQjExdjBWbXU5UGlNbndRNWpiM0NsbjEr?=
 =?utf-8?B?K2Nab2Qyd2NVSDRoaTIvdUduTTNJSDB1QkhqbExMbU9tWlZyWjdGV3JMbm1q?=
 =?utf-8?B?anJvMGZlNjdSNEY5azBoaDFCQ1p6RGdZQ2dBUUpkS0hwRC82OG5DeGtmYXdT?=
 =?utf-8?B?bXZKQWowZ0JyOXFiZS82WjVmczF5bSt4L3NrMWx0SjdhK3VjK3BOcDF1MW51?=
 =?utf-8?B?bmdWREdOY3MvWnVCZkdhU3pxK3pVRCtwcGtYQng4VCtMbm1SeVQ3MmRjRDBS?=
 =?utf-8?B?L0J3SU4weFpIWmF0dTBUanpic3NhbGtwZlJNTUpuM3JTUytLMjFNK0wvMlIy?=
 =?utf-8?B?K3JLcXlUS3UzT2tFZkZRYnFUejFkcDFIY2FuUVlHWmlUZE1pdHpibGhDZGVG?=
 =?utf-8?B?Q3pGTnJ3ekJCSUNrbjBBQ1NOZURML1kxTW9iUHk2U00xeTNobnRzL21WWlhS?=
 =?utf-8?B?QWd1dmdueC9JNnorUWJnQVJGRlFwZUVlZjZ5MEt0dWdJeUw1dDhndk9TVjFi?=
 =?utf-8?B?MjVsM2cvc1E3bWNROWRzK2lmMDJ4dzh1eHlqMElaQ1lka3RIMmhsd3d2VnRC?=
 =?utf-8?B?aVp6QWs3MWhyU2VWNVIraWhZWXlVNDI2SEdJbE5nPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea836d40-90f9-45e9-9da0-08dbd0286237
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 22:20:06.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzHj0Q5PRjnrKVE6CsLVR4oddYSX3sOhISsRJNcHZnhSIgcixTXOiklEpZrsyRbDK3A9cs6YwJJMhXIZBKuBOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180184
X-Proofpoint-GUID: 9zBCfadJwG76NoY9DCp42QNI_YdN2N7e
X-Proofpoint-ORIG-GUID: 9zBCfadJwG76NoY9DCp42QNI_YdN2N7e
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 13:54, Nick Desaulniers wrote:
> On Fri, Oct 13, 2023 at 5:05 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 10/12/23 17:12, Mike Kravetz wrote:
> > > On 10/12/23 07:53, Mike Kravetz wrote:
> > > > On 10/11/23 17:03, Nathan Chancellor wrote:
> > > > > On Mon, Oct 09, 2023 at 06:23:45PM -0700, Mike Kravetz wrote:
> > > > > > On 10/09/23 15:56, Usama Arif wrote:
> > > >
> > > > Thank you Nathan!  That is very helpful.
> > > >
> > > > I will use this information to try and recreate.  If I can recreate, I
> > > > should be able to get to root cause.
> > >
> > > I could easily recreate the issue using the provided instructions.  First
> > > thing I did was add a few printk's to check/verify state.  The beginning
> > > of gather_bootmem_prealloc looked like this:
> >
> > Hi Nathan,
> >
> > This is looking more and more like a Clang issue to me.  I did a little
> > more problem isolation today.  Here is what I did:
> >
> > - Check out commit "hugetlb: restructure pool allocations" in linux-next
> > - Fix the known issue with early disable/enable IRQs via locking by
> >   applying:
> >
> > commit 266789498210dff6cf9a14b64fa3a5cb2fcc5858
> > Author: Mike Kravetz <mike.kravetz@oracle.com>
> > Date:   Fri Oct 13 13:14:15 2023 -0700
> >
> >     fix prep_and_add_allocated_folios locking
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index c843506654f8..d8ab2d9b391b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2246,15 +2246,16 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
> >  static void prep_and_add_allocated_folios(struct hstate *h,
> >                                         struct list_head *folio_list)
> >  {
> > +       unsigned long flags;
> >         struct folio *folio, *tmp_f;
> >
> >         /* Add all new pool pages to free lists in one lock cycle */
> > -       spin_lock_irq(&hugetlb_lock);
> > +       spin_lock_irqsave(&hugetlb_lock, flags);
> >         list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
> >                 __prep_account_new_huge_page(h, folio_nid(folio));
> >                 enqueue_hugetlb_folio(h, folio);
> >         }
> > -       spin_unlock_irq(&hugetlb_lock);
> > +       spin_unlock_irqrestore(&hugetlb_lock, flags);
> >  }
> >
> >  /*
> >
> > - Add the following code which would only trigger a BUG if we were to
> >   traverse an empty list; which should NEVER happen.
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d8ab2d9b391b..be234831b33f 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3294,11 +3294,21 @@ static void __init gather_bootmem_prealloc(void)
> >         LIST_HEAD(folio_list);
> >         struct huge_bootmem_page *m;
> >         struct hstate *h, *prev_h = NULL;
> > +       bool empty;
> > +
> > +       empty = list_empty(&huge_boot_pages);
> > +       if (empty)
> > +               printk("gather_bootmem_prealloc: huge_boot_pages list empty\n");
> >
> >         list_for_each_entry(m, &huge_boot_pages, list) {
> >                 struct page *page = virt_to_page(m);
> >                 struct folio *folio = (void *)page;
> >
> > +               if (empty) {
> > +                       printk("    Traversing an empty list as if not empty!!!\n");
> > +                       BUG();
> > +               }
> > +
> >                 h = m->hstate;
> >                 /*
> >                  * It is possible to have multiple huge page sizes (hstates)
> >
> > - As you have experienced, this will BUG if built with LLVM 17.0.2 and
> >   CONFIG_INIT_STACK_NONE
> >
> > - It will NOT BUG if built with LLVM 13.0.1 but will BUG if built with
> >   LLVM llvm-14.0.6-x86_64 and later.
> >
> > As mentioned in the previous email, the generated code for loop entry
> > looks wrong to my untrained eyes.  Can you or someone on the llvm team
> > take a look?
> 
> I think you need to initialize h, otherwise what value is passed to
> prep_and_add_bootmem_folios if the loop is not run because the list is
> empty.  The compiler sees `h` is only given a value in the loop, so
> the loop must be run.  That's obviously hazardous, but the compiler
> assumes there's no UB. At least that's my limited understanding
> looking at the IR diff Nathan got me in
> https://github.com/ClangBuiltLinux/linux/issues/1946.

Thanks for looking closer at this Nick and Nathan!

I think you are saying the compiler is running the loop because it wants
to initialize h before passing the value to another function.  It does
this even if the explicit loop entry condition is false.  Is that correct?

For me, that is unexpected.

Internally, someone brought up the possibility that this could have been
caused by h not be initialized.  However, I dismissed this.  Why?
If h is not initialized, then this means we did not enter the loop and
process any entries.  Hence, the list (folio_list) also passed to
prep_and_add_bootmem_folios is empty.  In this case, prep_and_add_bootmem_folios
does not use the passed value h.  h only applies to values in the list.

Sure, the coding is a little sloppy.  But, I really did not expect this
to result in making a run through the loop when the entry condition was
false.

I will verify that initializing h will address the issue and if so, send
another version of this series.
-- 
Mike Kravetz
