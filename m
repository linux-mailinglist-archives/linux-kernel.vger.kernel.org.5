Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1D77938C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjHKPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjHKPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:54:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E83270F;
        Fri, 11 Aug 2023 08:54:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDcH44002201;
        Fri, 11 Aug 2023 15:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AkiLn5ulzNASEhOTU6Nv7tktkhkMP53Y3PV/ViTb/qY=;
 b=0Y+KB6NW4RxhgdN7Cx+KVWzNYEX0nmHx5ImWKzsZchO6KmykIREKGi+H4jY5tiTt2OOV
 EcRcasz+UM4fQ2l30gnit6TzDYN0hmPTeoqWvnveYo51i1B6TKhQblJyYhCRFbUBIL6S
 drp4z7s88zHAsXSXvNkvfXiFfpJay+q2Oc4YWEimGeeskAA/N3u/JQe8xpzoprYDnKTg
 LkKNwOrEwITd0U0ZKDYB6+GtFkXEZJ8/3gj3cjnyoDbuvOLd7qKMFgR580TvlN5eqM7Z
 2dphImNcAwYopOV9bLqwqLRVeqikWOEmhi4uxQEWYSkK2l6uDl6XErCbG2ZTKYNwxi4g Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ychb11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 15:54:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BEVDS0003104;
        Fri, 11 Aug 2023 15:54:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva98gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 15:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHlBaHPtbbWG5htwDUOm2SoZmlQeg7DpWwVmiZ7Qwhha9eAobGS648gm+ECQ6P+73pGzkUOWGJOuIcPADa5gfa/VoJrPBlug6CGZqsh8Yy8qj9N/iKhBXnmHNDy4FBh2x4Lc7ymw6bxek2NJB1q9ZtblhGtwXgCbPOYHlCA/PJS2m9AD2XRxOlxPUU5nuUoXIp1trXUfiyrZ9RzT+rBF2OhUDcfpzzOuk28ZSzJ2EIOXRGQ7MRaZMyYbmDuoXkYlinBzUbjDbeQXQC2ASB3St9jPCp3jjqDQKdyZzKSDMjFM/RBum+hI5ef63kNuEg3fuJSxA3MsPoPK3cZxtbF+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkiLn5ulzNASEhOTU6Nv7tktkhkMP53Y3PV/ViTb/qY=;
 b=aKGBZ5Z7NUn3eooX1qNOdjKAyO8BBFq2hAX11RxGfOS+PHDRQYpKC6TjLJlo/9mFGS3oA3FQng6MOxsMYUMotzfrEtcc2WhJzsOPR+CN9x20n3+6iPf8p5VQWH76KLPqqK89PrR8YzIAImTh01UdGx8ZXym8ZaRePBlmH4uKtuf/pw/Tur0/UeOvdCOnP9bAxOVrLeP23AsQtDGbVqaB1+HcZIiuEk6giyf6i9v9soRGJNvIRp7h8fArBIOLTgZ+D6LY8TzcN3nx2WQe9veTdX6lhRX5Fl7E6+7By6Y4IiG8C1lDjlRy+JkDuqGnFohnoxlDpHnRtJ/bSdBgipHW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkiLn5ulzNASEhOTU6Nv7tktkhkMP53Y3PV/ViTb/qY=;
 b=MDYgvNike1Brzql8ePOqEF0foRA6VLoy/e5+Jd4oXYyVCMc8Bd7+jZLvJmDhIFBP2nKaNED2jBgLMZbrHJn7KgS1ocTchO4peABEBVHtNkVqx9w34SkSf7Jimco7DnIzRkjrcTA0e+6jAZN2CJrgZF/we6UgZiGQSOojjwA9guY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7498.namprd10.prod.outlook.com (2603:10b6:610:18e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:54:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:53:59 +0000
Message-ID: <be3193b2-2c0c-6e67-e7a9-d04d63a18059@oracle.com>
Date:   Fri, 11 Aug 2023 16:53:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 3/3] perf pmus: Don't print duplicate PMU suffix in
 list by default
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <20230810214952.2934029-4-irogers@google.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230810214952.2934029-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: e6779d1f-c5ab-49d8-3af8-08db9a832d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGGdxhE3C8cEx7ZNs7PZqVMCPGfSatFGwFWfAUgCriGovFzldz011QEO8aCwCwo+yiWU6JxTlHhLAaLd7k3iyV7bFiV1qH3fXsM6dUxlDYCmTh4cz9KDO72telw46XkoF8fE26CD2Da4gOyW6D0D9QalPYLSBooJtY0+wM+F0kdx4YOOKfj2TpbYaLXK+GNWnSoTSzF23HpdayuiPU1HAQ5XmdSwf9gQsoGrwtIoq1r+L4/mDGDgDj6tZqJHlRyc/X6RKVqDAXqKXW6mUV6bdwa6Pb5XYN4JBOcJ+G3Sk/meOMUs4EXfuZ8dKcVvnD3jhNizZF+eLbA+/GzT4102yJkZD8zxcaPewVVQwRBGvaGkbKnOegrvqhGb66MhIODFImWXyiH4NxEHXMyku1FnNjsO8utU3nkx+pEVUf2NeU2EEL9HiijKeSWFt1Ecz+PuZAvMIHAzfpCuO+dUP3DCbOK+7S4YsqldhohHO2Fycw82SDM0D3F75YrCktnrzvIfkw1Fi1bWv5alE7wyOdKJnuf+lqpJRcpNdMiYpLLyDZLkAQ7+QnEeHaoBZiEoK7p9joNBaYWuHz0MhIhDabaWDxf8hkPJtF8ANpCeRsAskEZh/ZbA238CrGXlEdCiw3xG6eirg+RwjyWo4pme2oiQt9lQ9eBthYpqrpT7MowpRYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(186006)(1800799006)(451199021)(31686004)(66946007)(66556008)(26005)(478600001)(6666004)(110136005)(36756003)(31696002)(66476007)(53546011)(6506007)(83380400001)(2616005)(6512007)(41300700001)(7416002)(6486002)(36916002)(2906002)(316002)(86362001)(8936002)(8676002)(5660300002)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZDT29OMVZsOG1YUlVOVUMvSTE4S2NFM3FoVzY1UGZEWVZnV1Y5eEFXaldK?=
 =?utf-8?B?REhCZzdKREFnWXpwNFRNdXpSOFJ3NXpHVUpSNW8vN0xTdi9WejRuVnNGRTBn?=
 =?utf-8?B?NXU3aEYydTE1bW12cStLZU15a3RDQzgyU3FqRFpzSE5NZ0JQeWlYeDl1ZjBC?=
 =?utf-8?B?azRoZ2NobXBtSFlDa3VBQ2RKSnp4M0ZuK0xYbW10N2RDMlB1RjFRNGUvQ2hl?=
 =?utf-8?B?S2g0V0J1cHZ1alJRcFFlTFc3aEJVaDNMWHBmV0dheUFHRzhMbDlTVGVJMTln?=
 =?utf-8?B?TzNXN1E3Um5aVGxTVDh5VXc2REQvQ2g1ekFHMHp6YmRBenloM0Q2enhMZVY2?=
 =?utf-8?B?TkVFbmhaT3lQdC9ZUlRoSUJLcm5pT1lBUGUvZGlZR1k1UEdEMzFqTDkrNlZM?=
 =?utf-8?B?S2lIeE5INHh3WG5kUXlFLzNDYlZIeHRiZU1scXFMNy9rajNHUFowWmg5Nk1U?=
 =?utf-8?B?bzFWQWVkL1dDOHhkR2dKOS9XbEpqQlQ1Y05BMzgvbk9ac3l1RFVXTmZqN2ZJ?=
 =?utf-8?B?TDRkSjZBYTJheUUveHZDbGJuZUlDME9KcU9PUUV4eW82RG5oaC9oS2xlU0k3?=
 =?utf-8?B?Zm9LbzlaWUw4clhhdi9wSUUwVk4wZ25qeWh6Z3BKZFhOdTY0d2dCcGRHbjhM?=
 =?utf-8?B?YmgyRmRuTkRNcVMwNGNhc2xPc3lodDBjbEh3UmlRMFFiZzdMaStZRk1PLzRZ?=
 =?utf-8?B?SzA5cFNrRHBOSUhFV3dla2FISGtaWFptbFhsQXltcHNCd01QaVRMU0JGSVFK?=
 =?utf-8?B?dnBNNEk5ZWFPUVlEMmxwQkZJT2xkYVM2NzFNeEQ2eG56WjB2Y21xZ0U3TDM0?=
 =?utf-8?B?czVMVjExZ1ZGbDY3YlhCQzQ5b0lSMy9nTXo5R3lFUnNuVy91ZDBNb3BLWWhY?=
 =?utf-8?B?V2NrTGdEbzZUWkd6ZStxTDZzbTV2eGxiSnMwaHY1dDhnYXdQRW9hL1JFdkRK?=
 =?utf-8?B?UEtyeERkMVVacjVEVllidjdTQXNrSlBJM1FucHFzTDVYMVFSVEpOTk5UaTVz?=
 =?utf-8?B?U25WUHlEck1qRllaTGVqc1BPc1dmRHBKck9UWnVTY2VMcVpISkZNUFhNbkhJ?=
 =?utf-8?B?bFlpTkN5Y1hFNFBVUi9Id2k3Vm5SUUFJL3lTSnVwcVYyQ015WEM4eXd0ZXo4?=
 =?utf-8?B?dUFiRGxEN2M0amhKTVlwVkVNdElBR1praWRSZVFzb3pXenR2V002UWtZVWpR?=
 =?utf-8?B?VlpiN3l3Rk0xWDc4dnlINVFrb1QwUnVKemlmKytnb1VkSGFCZG45WE8zOUdq?=
 =?utf-8?B?TWdvaWFDVVoydEpWM0hSUXkyZkh5R3lDQUxLZlBDMHV1QXcvTGh6akRlQVBG?=
 =?utf-8?B?U2drUzJudjJXTlNhejQxKzdMTVpXYkFWd3FoaXVTWmxXOTI4MXgyRU9ybUlo?=
 =?utf-8?B?SjMrTW9CZS90SmVYbDJ5VHArSFJIdSt2K2lsYUd1bUVrUTlpZVdFdUJlZnJ4?=
 =?utf-8?B?S2dsZEJybnh2WGkzMTBCUFIxRVJCa2oyNEV2djJlNStERy9PbEt3YTNqSE5C?=
 =?utf-8?B?SG9ob2VsUENURDBkZlZpeGJGUnptMXdSbmNJNW40OW9UY21oWEtFNDdIcEtW?=
 =?utf-8?B?NGZNZmh3OTZET1NhSXpoUzFzU3BHNkFoZXVkajRmbzNTcmxJR2tVcXZ6Tlhy?=
 =?utf-8?B?QldXT0UyNkY0RXJhV3pKOFEvT0tXaG1xYW5zQzVTbnJTVmdpU3IycUdETlVY?=
 =?utf-8?B?cWZXNG1jNGZPMmlDT0RuRGE5cWVZWGpOSzF4MmJkbWxvVGhaSGpFTUhwYTBM?=
 =?utf-8?B?cld0MlNTeUwrdnpkaDdMU3RJY1kvNkpPVFloZzA1Tm5mek43R0c0cnBYenAr?=
 =?utf-8?B?Q256Ump0MHg1MllFQ0J1amE0QmNtZGdPclBBVDRzYkZCSlNOR1BPVThlb2Fr?=
 =?utf-8?B?TzA1b204Q2FHWTBBM0tjUFlhT0F4OXdLKyt5Nkhid1NEU2JRU2xTOG4zbnB5?=
 =?utf-8?B?aHdRU2tkbzdNWExjOU1ReW5wRDFoSUZ6TU5KRUFpaVZ1MUJheEFia0xhQWRS?=
 =?utf-8?B?YmV0NzFHTVlpRENldU1BaVpNdmJRWXBQN1BXU0hZSXFLVGZDUVQweWJrR1cv?=
 =?utf-8?B?UzZwVENGbFQ3NS9xcjYwYmFPWUk1MXRycCtSL29OZ1c1Uit2UmNGRXFkY3hN?=
 =?utf-8?Q?cFiz8RQbZ32+znzuhHZxA1Vji?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aytYbjYyL1hVVXBKWmdDWVFDdUtaREVNb01CTjAxUm16WFhwUW94cUwvOGxJ?=
 =?utf-8?B?dVp5YytXZFRsaUt2ZmFtcDQ1blp6MU95bVNpMkVaekc5MS9IOExGQTcvVFZY?=
 =?utf-8?B?MG52WDhlcEVyYjRYOVNPWHZDeCsvQzI2S2J4M09zdWZRNmRTOFRaKzFjOE5q?=
 =?utf-8?B?cjBsOHAxRXhiZ29aMDF1NVExTmVIbUdpbTcvQ1hzck9kU0ZNdkxWVzhFQ3hV?=
 =?utf-8?B?blFqN3AyaGZtUzJtaE10NmFhcWFybHF0eUhhaE9GeWUxQWNYMFVtRkJSTVdx?=
 =?utf-8?B?bTV6bmZ0a2htUytSNFlVYzY4cS9pZTdzZUpxWUZXU3hrSHJ3bWNTOFFIenIy?=
 =?utf-8?B?Y0x5dC9sZWpJMytSMW9uNm96YnJ3cVJxeEFZVE1ZdlBMM3lOQ0kxL1Q0UGI3?=
 =?utf-8?B?RDVXNG9WMWIrT1VSMlBhQStJaENQTTRXU0pLbXNHMlNzbkxGQjlCMFZnTjBE?=
 =?utf-8?B?S0tINytrM3pKZWpKZU1paXJmZjB4YkUyVGV1b3JqaXRic0tVZDdPLzAydElm?=
 =?utf-8?B?Z1hvRzJyTlhDeHN0QmwwOFZUVWtLVGlCMThlRmlQSWhNMGhTOW82eHhkUEZy?=
 =?utf-8?B?YktyVENwZnpPRFpwbTZNOWNCNzBWeko2MWEyRzFKQzE2empBNTRuR1FLdVFx?=
 =?utf-8?B?bVAwM3pTNU4xTWpjZUJZdWhpYjZrUjFWVW1jWHNoNHpzbzI4UktHT1FlTWJ5?=
 =?utf-8?B?ckhqcFdaZEl5OUR2VEFSaHp0OWxXTzNLZ1Y2K3RSQzlKNzFGUk9TQWdTMW92?=
 =?utf-8?B?TWN3aU9uWG8vM0pSb0JyeVFpM2dsM1dUV3lVcUhSTkQ4OXRFS0lzODljVENT?=
 =?utf-8?B?YldhVkh5bWJRUnhZS2x3cE1aYzZCK3NhS2gxNTlPcVlxS0VvMU9DRGcxRHZZ?=
 =?utf-8?B?dFpnblZONEJpcTYzblNIYjBZbDdSR2lMakNCdjJZQ04xTG5kRldRbEt6ZUto?=
 =?utf-8?B?c2FyQlA0ajhsVklweVY4R0hpaWRVTEdnc0FyOHBuU2F3bVcxTXY0NXhFN3V2?=
 =?utf-8?B?UzZKTnlDQ3NxamRTNHUzQVJpdUFHcERJdk42b1d5eEEzajgrUU9ySTIrU0xu?=
 =?utf-8?B?V0hUakYyVWJiVTBuYVoyUXJEc3ZxOHZnOC9qcFQvNWZkRUxzR2R4RCs0OGtv?=
 =?utf-8?B?ZzdsNzRrdks3RjJ2TTVyb3RlT0JhTTduemxNMGdaN3Z3YzNSdFl2R2loL3M0?=
 =?utf-8?B?YWdGSHA1b2pCSmhCaXVhR0RPYUpySVdlZzdMTWVaN3pUWjZZZ29nalpLNjVT?=
 =?utf-8?B?dTRadGhIMDhVSTlnQVR3bkZ4M21zVXpJUGJsMlBsQU40aE9UdDdiak41Zkdo?=
 =?utf-8?B?ek8ydjhlYWs5L3Bjb0dLWlFEZldKQ3ZxTzloM1g1bmFGbHVScUZKNVN6OWJk?=
 =?utf-8?Q?JqCn0rtgZW5jy+h1ywCAbDo9PJPteVXw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6779d1f-c5ab-49d8-3af8-08db9a832d6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:53:59.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9gQaYd++IXCxc8hUZMrp6cM0OFKJP5eVbd+A0OMxLAiTpUls4cx3e3mCyESXRy38i1m0NiAYoz5eBwHx/DYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7498
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110146
X-Proofpoint-GUID: OoFpZWO5p9b6XIx-qJGvfFPhBW2zixOP
X-Proofpoint-ORIG-GUID: OoFpZWO5p9b6XIx-qJGvfFPhBW2zixOP
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 22:49, Ian Rogers wrote:
> Duplicate PMUs are no longer printed by default but the suffix of the
> first is printed. When duplicate PMUs are being skipped avoid printing
> the suffix.
> 
> Before:
> ```
> $ perf list
> ...
>    uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>    uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>    uncore_imc_free_running_0/data_write/              [Kernel PMU event]
> ```
> 
> After:
> ```
> $ perf list
> ...
>    uncore_imc_free_running/data_read/                 [Kernel PMU event]
>    uncore_imc_free_running/data_total/                [Kernel PMU event]
>    uncore_imc_free_running/data_write/                [Kernel PMU event]
> ...
> $ perf list -v
>    uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>    uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>    uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>    uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>    uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>    uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> ...
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/pmus.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 5073843aca19..b0ecb2e5bdcc 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -440,10 +440,13 @@ static int sub_non_neg(int a, int b)
>   }
>   
>   static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
> -			  const struct perf_pmu_alias *alias)
> +			  const struct perf_pmu_alias *alias, bool skip_duplicate_pmus)
>   {
>   	struct parse_events_term *term;
> -	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
> +	int pmu_name_len = skip_duplicate_pmus
> +		? pmu_name_len_no_suffix(pmu->name, /*num=*/NULL)
> +		: (int)strlen(pmu->name);
> +	int used = snprintf(buf, len, "%.*s/%s", pmu_name_len, pmu->name, alias->name);
>   
>   	list_for_each_entry(term, &alias->terms, list) {
>   		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> @@ -473,9 +476,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   	int printed = 0;
>   	int len, j;
>   	struct sevent *aliases;
> +	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);

nit: that code could have been in the previous patch

>   	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
>   
> -	if (print_cb->skip_duplicate_pmus(print_state))
> +	if (skip_duplicate_pmus)
>   		scan_fn = perf_pmus__scan_skip_duplicates;
>   	else
>   		scan_fn = perf_pmus__scan;
> @@ -518,6 +522,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   			*desc = NULL, *long_desc = NULL,
>   			*encoding_desc = NULL, *topic = NULL,
>   			*pmu_name = NULL;
> +		int pmu_name_len;
>   		bool deprecated = false;
>   		size_t buf_used;
>   
> @@ -528,7 +533,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   		if (!aliases[j].event) {
>   			/* A selectable event. */
>   			pmu_name = aliases[j].pmu->name;
> -			buf_used = snprintf(buf, sizeof(buf), "%s//", pmu_name) + 1;
> +			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
> +			buf_used = snprintf(buf, sizeof(buf), "%.*s//", pmu_name_len, pmu_name) + 1;
>   			name = buf;
>   		} else {
>   			if (aliases[j].event->desc) {
> @@ -536,7 +542,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   				buf_used = 0;
>   			} else {
>   				name = format_alias(buf, sizeof(buf), aliases[j].pmu,
> -						    aliases[j].event);
> +						    aliases[j].event, skip_duplicate_pmus);
>   				if (aliases[j].is_cpu) {
>   					alias = name;
>   					name = aliases[j].event->name;
> @@ -554,8 +560,10 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   			long_desc = aliases[j].event->long_desc;
>   			topic = aliases[j].event->topic;
>   			encoding_desc = buf + buf_used;
> +			pmu_name_len = pmu_name_len_no_suffix(pmu_name, /*num=*/NULL);
>   			buf_used += snprintf(buf + buf_used, sizeof(buf) - buf_used,
> -					"%s/%s/", pmu_name, aliases[j].event->str) + 1;
> +					"%.*s/%s/", pmu_name_len, pmu_name,
> +					aliases[j].event->str) + 1;
>   			deprecated = aliases[j].event->deprecated;
>   		}
>   		print_cb->print_event(print_state,

