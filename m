Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8877C9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjHOI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjHOI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:58:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014D4210D;
        Tue, 15 Aug 2023 01:56:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOteP023680;
        Tue, 15 Aug 2023 08:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g9Ug5OS6yxC0VCLbrcWEpchqXaoacIphXZlcwlGdsu0=;
 b=zhN+VXthQQQheKnoJL15quHh0bnvAIxU+wjrBIpbP0eLORLzgQMFfUabwPKbBCqWTj6X
 1rNY6dI+MtNzCts3LvEmVRJeocQGBogA62mctnMdA/k92B8fZX34BC0OLLl31qrFh8p9
 Y5VmromExA3sOEps0pQ8/8E35p2DoU+fvLFjTprNHqLbSD47CiZcLlHRH0hPROycLjva
 OpVJN40lO3H1iV7hhGJPVNTgYoKQwW9gkXAJcDgP1QUTwqAVhkoeCeCMc9Um9RtHnWWB
 tTAyYByBTvmdxvq1sEoZ7/xLQRIZVmQvkNMdOvJdbbIi15yfLRppjGFBHCVX0kCp4Rlg tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5v9ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 08:56:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6A0GD039411;
        Tue, 15 Aug 2023 08:56:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey6yv3wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 08:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcjDi9mnsCQTDF6cxXJpOAejEWykjilbOyYnPaU53eoD7iO8MFdhLZ7kWYnQRX7xyi4D5mErK7pVesJpqZa97IAjrXuaeBczoRdnof08u/RZb5NqXCoh5NpvIfi4KO4bYOgTnitUoyTEbKerjsOS4Lygjcp1xwZhSNe3R0VNOuMyLzUMZSam1QuqjU1VQ95S7H9dHC4+PiOlZAhhqagu/kQhmYBi7l1cqsT3UrSdLaAvhRmwGuueeIjqZEUlpuPaNmyoX+xqSeGKjagAqP8v1OylNFiFZvgqpgXnl96fdo0pI6Ry3Sn1hOq/KSvLWmyCOWPITciTa4O1FEGamVFQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9Ug5OS6yxC0VCLbrcWEpchqXaoacIphXZlcwlGdsu0=;
 b=NdnYBBsQf/CdYwObhRKLcY41bMS1c+phAmXHV1iNr3F7Z7Jg3SRSAQ295qdlQOF4jh1LDrtLRxyJwePotLnIsntZZ5KRjKPsFT+9ulg7WxhuA0c7FuNVOoygYcg+zuZndHcd8B2siz+WVQJ8SpfOPEkrmzzjLDWy9XIwsb/rCVgHJt3RlnsgiYR1LOzA5pK/OavahSEDILrGAO8eJsiJZ4LRra8w5kK+oQaNdYaHBI21kzWDfbmZG4ylwpvXijqnG2JSUfd7YrbX3qyHbn8RxNsOk3qLx51fJ5O1EHdWUu0ReGSfFCnOuFxjkoTiJ2wonv9L4I2VGUo8JsEleEFVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9Ug5OS6yxC0VCLbrcWEpchqXaoacIphXZlcwlGdsu0=;
 b=WVl0XbWocHY+NddYgsS3um23uje9fhYh1XoEqiaztfJxQkKpGh64uYGAGPKd8XGHx9ryqNN6OWg5OPbxv8SYdxZ6y6GGmx29py/d9qv0sAn0kq3SJzZE2Ha294b46I7yWS+djivIM1hk6nEOUG+VLuI4AwdVrxWotACegi6sDBU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4431.namprd10.prod.outlook.com (2603:10b6:a03:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 08:56:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 08:56:33 +0000
Message-ID: <0e528710-c89b-1561-774b-fabc283e0e72@oracle.com>
Date:   Tue, 15 Aug 2023 09:56:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] perf pmus: Add scan that ignores duplicates, use
 for perf list
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230810214952.2934029-1-irogers@google.com>
 <20230810214952.2934029-3-irogers@google.com>
 <0111c4b3-174b-84cb-2749-a88342b80498@oracle.com>
 <CAP-5=fWPUxOkOorOEiNSWPVhSxi+ANSR=_2rEzF_7hyS=3hF0Q@mail.gmail.com>
 <CAP-5=fVOp-FcRR5oLvMVvb0R3sMgd=qnORwZGwdK1BbcqOBhHA@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fVOp-FcRR5oLvMVvb0R3sMgd=qnORwZGwdK1BbcqOBhHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a420ec-ff44-4598-a698-08db9d6d8678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIqUB97pPONI08HkvGGeGjCFIULFQKKuY9kVB2UkwU9MzjTh1jWnsxKHQZhu9C1jA7+1DKY81CBdvKZKeF2jfEyVKAfBHv1FCiusY+Z9DnThllUO0B8dOgr7IfqRPEXXb3pSvr3nXjByDLehpIMCKV7ZkAxzYhyyRi6Q7gIIxjVlX4S5pEv16i/F7fhHA5kHANC3G5CzR3E3KgcTsv/1mTny+JyeEj6Hi/govVCzrxtN2FOqtJoW3DIBASDi9TsF8yf4BSBl/cfljrdNpcP6HT1Kvmeh3VH3xWY+/ns5nIWYBHJbZSkXjNAJgd5Sne19I5144p+D2Q2QTtcTh1IP/+qtrTQRbLPQbBchqrYNsvJIzp1n/Y31uwU+NGgQjH9CI4zs1sFEfGFOBnFMB97ID4iw6n5bI0HyCf+qs8YposdBejkNWxJychokhWrt/BHTPzVLCtFlSNbfcjLIxKXdYfAhuWa60S/DV9fR8hzh4StbhuV/UVQ+mDf8MqXvaKyJOaxvDDwfG0pIlKTO8IEWsMJlXIFTUze8kGO74ar+nK63tC69yE05Mv4SngboFhNEcYv/Ze45Tw4kBZS8bsYKBDsrkpEc+iKeLCZ2yKOuxz62ycXbtPuHjfijn0qhKYShdcerzo/U4GgvQ/JhRzj43A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(41300700001)(38100700002)(66946007)(478600001)(6512007)(54906003)(66476007)(66556008)(6916009)(316002)(8936002)(8676002)(5660300002)(4326008)(2616005)(86362001)(26005)(31696002)(6486002)(7416002)(6666004)(2906002)(53546011)(6506007)(36916002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdSMGdTWEpJQ3R0b0srUlNWSVVLTTdiSlhsMlEwTzk0ZllpQWtSYStqY0Jp?=
 =?utf-8?B?RVhXdDdHMjUvZW5iNFYzdzhjUnI4MHJYQkl0QUVtS2R5bFp0YjlvMkNKc1ZP?=
 =?utf-8?B?UGtLL05JUFhGd1d2dkV3aURQcUJVa1IxZzEzMTdHVXQ2NUk3Y3dqK3Y5VUll?=
 =?utf-8?B?eTRVeloxQk9KTFBjcDRFdFRJMXpYMHdOdkdMNEw3Z1Z5bkYxdVlqNlJ5MDFz?=
 =?utf-8?B?Znp5K25LcDdNazA5T3JNSVBBb1hlZVZqcG9mUTgrRXRyVTJjU1BWWDFOeU1u?=
 =?utf-8?B?RFc3R3pHV3ZNUnhPbzc0Y2RDcktTNzZpU3ovTkp3VjF1MEgydzBkcWJrS0hz?=
 =?utf-8?B?Y0F2N3FqWEZwSnQvODEzSko3K1hZZEVyRkhUUkovbytYU0FPdit0bm54akE4?=
 =?utf-8?B?ZS9TMk40RkJxRGJGT1laZTlCS3JBdXJYd0lJUW9xZXBHWHJSeldFRms4RUxG?=
 =?utf-8?B?Sm9tVjdRV216WmY3YUdCL0p1OWVEczFnb09oNTlpbEVvL2tKbGJhSUhMdWJ5?=
 =?utf-8?B?aTlweElqQ2U1cVNSVDdSZjZVL2RlTGVIMW05WmF5NW1lTjNJZFJZOHR2bkhE?=
 =?utf-8?B?NGZNUWV3NWRQNkRPeFRUQlFNTFdFUXJidjR0Z0U4dWpZVDlUQTBHeDVocytT?=
 =?utf-8?B?SzhVUGlaZWFDTXU4MVV5ak5ob2xtTlpEbm43eDBLNWtNeWNNdkl0eFMwMkt2?=
 =?utf-8?B?NHJzRXhnWlpJV0xmVklXTlVaeG4vSlRkcVVXcWhsYWkxeGpDelVGdGpkQmpT?=
 =?utf-8?B?Qko4QlRnSC9JUEg5OWpNMi91UUdGNzREd0JTSlN0NEtHRlFtVUFNVVJyWWFz?=
 =?utf-8?B?V0ZvamZNbEJrQ1YxMVBybGdaUXVxZ2dPYWsxak1CdFdmMVIxanNLZGJtNi9P?=
 =?utf-8?B?MXpDb25jYi80QTlSOUpQa0ZQREw2TWpyZWZLS2EwYkRnQXdWeUZmakljaXZI?=
 =?utf-8?B?Njc0STh3ZEE4UlRla3NjUmV3RytEUWVJTEt0ckl3aHFiQk43VThaNUgzRWMw?=
 =?utf-8?B?U0ZRNWJ6OTFlQUtjUUJtS2hRR2hwMjJBbGNBZ0d3VjkrRVdCRzhkZDFMbUFx?=
 =?utf-8?B?NTdWbVI5dE9lVitPZHlKdXdaUW9DN1RoT3V5UXpUbWV2VkRkQVljbTJVQXRF?=
 =?utf-8?B?clVCTllyRmxKaXdIV1AwMnBzR0lGYlkxQWk3WVlyK0ZYR0x1elNrdG52TnVV?=
 =?utf-8?B?eUlYRS9pdEtaRWdYRlRRNWlCb0g5Z3VFVFl4dFJGaks2MnV0cVR5ZXV5UHZj?=
 =?utf-8?B?aVAzNnpXdDdNcndobGh3NWxDR24rdVVLanRna2N4ZjhrTHNTaVZuMW1renVa?=
 =?utf-8?B?QTkzc2JXeXZrTnpXdDA4c2I0c05rUFc1QWIwVGJIV25CNi9xMHM1UFZuK0d3?=
 =?utf-8?B?YlVxQU9odkZONHZGUVdsOUNIUXdKei9sbUNUbmJvV1F3ejJVMDlreXVlZVlr?=
 =?utf-8?B?bENCVDlQc1BIV2FtNjVMMVk5RzU3V1lCYkhsOXEydzFSb3pDZFVIWXBtL2ht?=
 =?utf-8?B?K01KUm9ETWw0K0YwTGFhNEtTMVJQVnlINENNeHg3Yjg3ODNMMWF2UGtjUysz?=
 =?utf-8?B?Rm1LM21NcHpMRnFPNzhBRTNtUUdJNEJwcmJlVUtQN1hXOGk5dkoxYkI0ZGRs?=
 =?utf-8?B?SHcrRmxSRVNHWUU3bE05RmFBRGlHRDFvclRsMkFMc0ZJMkExZW1ZZ1hkSWYx?=
 =?utf-8?B?NldxSjErc29HU0tBZjdsRWI5T0lVWHExeERqZ2hTR0J2TzRtdTVKRlY5c2ZM?=
 =?utf-8?B?a1pOYTVDNzdCd0EzVzB3eVZnWkZheU1aaVltZm03c3d3UWpMU3pRNTdTNmJS?=
 =?utf-8?B?Q1RHVU9LcG5nL3gyV3AxN0RuVWJKNk5lS016NE5pemRtVVlla1phQVR5bDAx?=
 =?utf-8?B?b2JEYlN0SzVRVlk2TExDdllsVVVhTTRSTnRpaGl6NWNmME9Md2VvbkwzVkZ1?=
 =?utf-8?B?L2IxenQ1K2ZJR3BOcFFQNEVOWERkWnZLM01NT1RETzkzWXBabE5zcVllQkNJ?=
 =?utf-8?B?L2JvQTNkQTVKMDlGTXNZeXZ4YkJnb0c4bk5yRGVXQ3BvN2hTR1hWSWlacERR?=
 =?utf-8?B?NnZkMHA5cHorNi8wUkdVWmdVMWpRNlJsVDZGQVBQeVZuN1pOSmNkbFNRYTVS?=
 =?utf-8?B?UDNhOERJaXBidGMxMmJxUTdBNmdiTkhOMU8rcGdHSDl3cE82Q0s4TUNEL0U4?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?b2M3bnhlZHkyV2g1VUZHdDJzU29wSi9jdERrWGhDNGR1bFNwMkpGL09VaDQr?=
 =?utf-8?B?OXB1OXovMkhLVFBMdExIREthaVFpYnVQMjdlQkVUNDl5andtTWRxUFZHbWFZ?=
 =?utf-8?B?WktLOGhldlQwUEVXRnVCZE9FQ0greGhRNlVjWXcvZ0tYZldmekMxc2dEd0NF?=
 =?utf-8?B?ZGZnU0tJdUR6eU8wMlBUcExubWNrNUJHcURyK1YrVnc3TzFIZFVzZGU1SUxo?=
 =?utf-8?B?YXVVUUVucDNmN1NQdDkzTWo5NDAyMk5BbjZ0N3JhYW9OK0d2Z2VGLzc2Q0xh?=
 =?utf-8?B?T1Q0ejdlaEQ1YWkzbkFmVjNFWmJMSnVNemlxMng1NlZBUlNtSjJ2REdMZjJo?=
 =?utf-8?B?VS9tQVcrSkx6YXNFWHpBaEhJM1Yrb05wRlhuZkg4aWgrQTJOSXNHczVIT3dx?=
 =?utf-8?B?cmxuZllvL1M0eGs5YkRiQnB0SXVMajRBUHZ6eEw1eHBkQjZvbnBjUXNXNmh1?=
 =?utf-8?B?RHhPQUlyZytPeUFVQ2VNRkxZQnFORi9tOVZYZ1JVZytadk8xeFhoRmNJQ3NB?=
 =?utf-8?B?elVNc2RmekRQeC81bUlVRTB1VlQzWS9DWGp6TEwxZ2psUWkxd3JacndTSlJC?=
 =?utf-8?B?UUQzQU0weVdtUDB1ZFl4b05waHZRbGpncFRKbmZWb2x2T3dCcFBmdHVVKy80?=
 =?utf-8?B?SUxTSVlyelNyOEdEUld1eCtjcWJZWEZuWFJDTEIwM1VNSm5UL1YvOWlUV0I0?=
 =?utf-8?B?L2JPQWFJRE9wNVFZUzVybXFwNDFZRnNvd2RidDVwWUx4WW5QZGFYcDZUWURt?=
 =?utf-8?B?enBEOGpHenJiMUZ3dkJ0cEdoS3ZPbUN6ZVg2WERSSVYveTNpTFd0ZmVSWU5W?=
 =?utf-8?B?QU9YYjhycWs0cG03b3RGcWN1ejZHZDRDa1VxRjlDSUhyQ28zNVZIVlRxRGNo?=
 =?utf-8?B?UkNrenVrK01EMDFwanF5S0FvV2psZzhzdVI0NmIzcVZNRkRSZWNKNTB0cGZQ?=
 =?utf-8?B?dkN6SDNQNnh2SEd6WktyT3lnaWprdzNldUtWaEtBYW56OGw0SXlRRnV0NHNU?=
 =?utf-8?B?VWkvSncraE9GR2V1U3VpUjduMjIwY2NMZTR6VEV0dUxxYWcwdUIzUlJ5OERB?=
 =?utf-8?B?dFRNM2VIdFZYOWFsNFFmV2FtdVlCeVoyU3ZzalhQd0tHd3N0elV4QWJRTDNp?=
 =?utf-8?B?c01POTZ6Ui9IeEJLVXlIaXJFcG92NTdML0JxME4yS09kY05abE1LdHQ1Q1Jz?=
 =?utf-8?B?ankwb1pzM0VXMU9GL3BLNHYyazNwWW9oWEQrL2RycnE4b1dqSDN4VkN4VExX?=
 =?utf-8?B?c1lBR1FuRnN1eGJlT01SbFNST3N3d0pPa3lYK2hDQ3ZhVzdjT296cjJNOU8v?=
 =?utf-8?B?VGUyOStYblFHVlRNVElnZUw0VnFOcTNuVnM2dXRBZzhZWmJITDZJbHFJTEpO?=
 =?utf-8?Q?FZpPs5DcO3JGDIRGGMI/j7hFE95p13ZY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a420ec-ff44-4598-a698-08db9d6d8678
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 08:56:33.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dgXpcpGB5GKfYt6pP2s3RFRghf6DX/kTXlu2zLD5Y0oWj546hbWA7bNb0atGWQx3ojOHgMxXzXsm8L+z4sGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_08,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150080
X-Proofpoint-ORIG-GUID: 7_V6_q0ahylIr6K7qKDFyxyPU3pFKrS1
X-Proofpoint-GUID: 7_V6_q0ahylIr6K7qKDFyxyPU3pFKrS1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 17:09, Ian Rogers wrote:
> On Mon, Aug 14, 2023 at 8:57 AM Ian Rogers<irogers@google.com>  wrote:
>> On Fri, Aug 11, 2023 at 8:51 AM John Garry<john.g.garry@oracle.com>  wrote:
>>> On 10/08/2023 22:49, Ian Rogers wrote:
>>>> When there are multiple PMUs that differ only by suffix, by default
>>>> just list the first one and skip all others. As the PMUs are sorted,
>>>> the scan routine checks that the PMU names match and the numbers are
>>>> consecutive. If "-v" is passed to "perf list" then list all PMUs.
>>> I really think that this should be merged with the next change. I don't
>>> like the intermediate step of by default only printing the first PMU.
>> Ack. I'll leave it as 3 patches and then leave it to Arnaldo squash as
>> quite often he wants more patches.

Why are more patches desirable? I do like the approach of taking a bite 
at a time, but we should also maintain ability to easily bisect and keep 
logical steps as one.

>>
>>>> Signed-off-by: Ian Rogers<irogers@google.com>
>>>> ---
>>>>    tools/perf/builtin-list.c      |  8 +++++
>>>>    tools/perf/util/pmus.c         | 54 ++++++++++++++++++++++++++++++++--
>>>>    tools/perf/util/print-events.h |  1 +
>>>>    3 files changed, 61 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
>>>> index 7fec2cca759f..8fe4ddf02c14 100644
>>>> --- a/tools/perf/builtin-list.c
>>>> +++ b/tools/perf/builtin-list.c
>>>> @@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
>>>>        strbuf_release(&buf);
>>>>    }
>>>>
>>>> +static bool default_skip_duplicate_pmus(void *ps)
>>>> +{
>>>> +     struct print_state *print_state = ps;
>>>> +
>>>> +     return !print_state->long_desc;
>>>> +}
>>>> +
>>>>    int cmd_list(int argc, const char **argv)
>>>>    {
>>>>        int i, ret = 0;
>>>> @@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
>>>>                .print_end = default_print_end,
>>>>                .print_event = default_print_event,
>>>>                .print_metric = default_print_metric,
>>>> +             .skip_duplicate_pmus = default_skip_duplicate_pmus,
>>>>        };
>>>>        const char *cputype = NULL;
>>>>        const char *unit_name = NULL;
>>>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>>>> index 3581710667b0..5073843aca19 100644
>>>> --- a/tools/perf/util/pmus.c
>>>> +++ b/tools/perf/util/pmus.c
>>>> @@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
>>>>        return NULL;
>>>>    }
>>>>
>>>> +static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>>>> +{
>>>> +     bool use_core_pmus = !pmu || pmu->is_core;
>>>> +     int last_pmu_name_len = 0;
>>>> +     unsigned long last_pmu_num = 0;
>>>> +     const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
>>>> +
>>>> +     if (!pmu) {
>>>> +             pmu_read_sysfs(/*core_only=*/false);
>>>> +             pmu = list_prepare_entry(pmu, &core_pmus, list);
>>>> +     } else
>>>> +             last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
>>>> +
>>>> +     if (use_core_pmus) {
>>>> +             list_for_each_entry_continue(pmu, &core_pmus, list) {
>>>> +                     unsigned long pmu_num = 0;
>>>> +                     int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
>>>> +
>>>> +                     if (last_pmu_name_len == pmu_name_len &&
>>>> +                         (last_pmu_num + 1 == pmu_num) &&
>>>> +                         !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
>>>> +                             last_pmu_num++;
>>>> +                             continue;
>>>> +                     }
>>>> +                     return pmu;
>>>> +             }
>>>> +             pmu = NULL;
>>> you assign pmu NULL
>>>
>>>> +             pmu = list_prepare_entry(pmu, &other_pmus, list);
>>> and then re-assign it. If list_prepare_entry() needs first arg = NULL,
>>> then can just use NULL explicitly?
>> Done.
> So because of the macro magic in list_prepare_entry you can't
> explicitly pass NULL here as doing so yields:
> tools/include/linux/kernel.h:36:33: error: request for member ‘list’
> in something not a structure or union
>    36 |         const typeof(((type *)0)->member) * __mptr = (ptr);     \
>        |                                 ^~

ok, fine, so maybe add a comment as the code looks odd..

Thanks,
John
