Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B3779386
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjHKPvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjHKPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:51:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B60211C;
        Fri, 11 Aug 2023 08:51:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDJgG7002268;
        Fri, 11 Aug 2023 15:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eQHxC7ePkY5kBmGcPwmemUJPsmVotB+oCXOOZOJLVbc=;
 b=hWk3LEF19p5xW2cDXiRXOW6qkAUrnlhU63Qnt0m/42kjctAKQ7lEtHr0+UoC0znYCdw8
 VY1HtIdOWp8PrpRybw68oupLZfbiscY0/bW3Hm5at60ExWP9o2/KLyp90aJc4Eth94vb
 Q42XxV4jxMCNALZE5sjiys0cJxQcjryoiUy9rQYqeuZaesaemEgZ1m/Lr2jrFai8RcR/
 YwEfjeg84ArSokUOk/8d4zj/AgwwZogrHhdljE25IJQkSH0HxtUv6oFiq6INNjC9wXYM
 kkWL9qFUDxG44snORNiRq9RQD1u60qx08/BQgJw3DC/M3b+hKdZHVs1wbpI+lzrIIkxi 8g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ychatp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 15:51:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BEXHop003116;
        Fri, 11 Aug 2023 15:51:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva95sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 15:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVgqEvKPxXlenTKp5wG4ZV43tYXodj3EDKQh2ZQA4sY36WDs7qjKzNyjVQXy6SILv7+tVCq6I25oRqYYCpHPJ5cKJBAw/0l+vLovrxJwl1wRF6muzqYiFN1VCFO5XwxhFHEDNKYubqy3WwzNWLOiw/Fq2cPsjLCcIBgGyp3FRZ3JRQHqaoPvmh90yyrPWF3Odf28lhtVBr2f7W8/g2SXdU77CR640c8gZRi64TDVIXWiJqHbdmozMpM5+m9lue+YO/OYquJ6oAKSSGswkOFYGk2XK00KcX/mA46rKiG6ogm+XH041IoolxCmOUETC8gCd1xWuJcWXVmZueO91PfRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQHxC7ePkY5kBmGcPwmemUJPsmVotB+oCXOOZOJLVbc=;
 b=ixYTVarDs1qZhESy4euWHuVgJzMCmxWINK99qq9DJJamx3qffJ3kUk/vPlzCRld9RtaPif9Tv2s5DT0GJmlkpEp28TNJVWoQxxnBNPm8kQ2yzPXPITY4SmuuD7pFrQMiFwlkagpyXiI+SMLozaXvz3vY9UFGw4w5c92O4VkefY5DhehmB2yUFUb+Bg8J1hwAW/fc4+kXoOSclUSCpjFnsESw/P96saYTE656atudjETnF89y8Ag6VAFkzu3pMw6/+2KLrSxfyvRDO4L527EWLtJL2MG0UMtcdzUsCg9e6BYpqzC0Otu984AuBbXNmxxBWlMlwwgrqVuvpMJKuBJsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQHxC7ePkY5kBmGcPwmemUJPsmVotB+oCXOOZOJLVbc=;
 b=iReYSmtBWsBwan7FSnyhQcqZ07kG2oeLkpB2DbwawT8RkAehKa9GF6vXAGOeWKbHo5Idt6D4W7gvt9StGj+pwklbo4i8/Ozn/aMi16kNvvNxISH4V3TdNJOSOY4N1VzV4w2JleDvvCbHkyr9OwOLyKWCj3VFd9N5l9ikZqPcNxM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 15:51:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:51:12 +0000
Message-ID: <0111c4b3-174b-84cb-2749-a88342b80498@oracle.com>
Date:   Fri, 11 Aug 2023 16:51:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] perf pmus: Add scan that ignores duplicates, use
 for perf list
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
 <20230810214952.2934029-3-irogers@google.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230810214952.2934029-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0609.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1b5e8e-9c9e-4e01-0f54-08db9a82c9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+PsYh9knElQk23kAI4vlxttoEu8iWaPymCal6c4UIUL6/SfLzKdWnPjSSLCzNya7xitRD45QkzSDqUC4ubkw4xjAw6GYSUqpUgPxB3C71F8FJHhEnIYNlLRRTCu9sMuPb1ooBtxVL7ozJ/tkfZSvk/xZLcaZlcsaq0//5Yg/kKwBvGCqaVUXctADMchmmKQC0uS+Bn8QJOdnwRxACZAE6VZZ+5U6dUHxZV/CPyjlXBBmLzGjIzwx5QxluTfKBWXCQTI/G3+VQayv5g+AJnfGGTePaw3FkVkE44gOg9jGCUiBxUFkB/qOUeZ1omadsYW6RJdx31RUToEXJwHd5ug+DtkxYevHnhStNH6NdVUku3+bs9+1qobYMZkEzF0S17eJwNs+gIkV5yI8sFQZ7u/KQMLmKXLL+kO83BdZbLp2tWlGdkpxIirwv942w0pgczXBg0yJgHb8v+ml6+GXMXB2Y7ibZB3yWYGhgCp3InSS4bNIQuS5sJ5M3aRfEDaOWWWOtGdukmlIKxy6GVO1TETBaPJqIQ/LQysMPZY7PU08kuFBY1B+0uzcQkOTOk4/oYGqBqJRJ4vLbX+3R7A/hZAdPENrwhgxjQ7Fp4xoeZiw2eJrXiuWRS0Eqx3wVagjTcpC/zfmeJMo0oB3Ijk/gB2hEhc7LQiEVMoBU/A4Cgk/3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(1800799006)(186006)(31686004)(2906002)(7416002)(8936002)(8676002)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(110136005)(6486002)(478600001)(36756003)(6666004)(36916002)(6512007)(83380400001)(26005)(2616005)(6506007)(53546011)(38100700002)(921005)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akVxZUdDT1JFY0ROS01UbXBQcVh1VFVVRnhwWW1IQWpIbnhaZS9vaHE4MTJl?=
 =?utf-8?B?Mjk1dVJ2azZKYnI2a3ZWMGdrUU9USTU2RUdJM0IwTUJrcnZWVmdublVxM3Bo?=
 =?utf-8?B?R1JLYU82SjlZK0ZhK2VpSGt2UkVkYzJFVmRDMXZDM21nRzgzYmd1aW1rL2xv?=
 =?utf-8?B?V3Q2Z2Fwd21Bc2lqUEJrQjFxTnIxby90bGlmdTQ2YXZmTjRCaFh0ZDl2Ull2?=
 =?utf-8?B?Q2w1NVVQM0krdmZGTklya3ZXdU9YOFlOWXoxbkhGR0laRG05MUJkc29iS2pD?=
 =?utf-8?B?N1BtNEoySks0Rm5rVVJ6Wms0Q2xnblJLcW1EUHJqeUVya3FqbFp2bmJYdUpj?=
 =?utf-8?B?QnhiMmNqNStidUlXTkF5S2ZSZ3lIUU1zWHlIdDNJMUdwZk0xdGttUitvdnpB?=
 =?utf-8?B?SXdNcG5RZldPdThJdkU3Y3N4MzZubE5uVTZBa2xDdzJVVnlveGFxMXJGYnoz?=
 =?utf-8?B?WmNxQ2NjOXFLcktZTWl1NXl3VmhyYkJXWHhmZ1MySEQ4S3E1YVZaS0R3VG5R?=
 =?utf-8?B?ditkeUJlVjZ3eVV0N1AvZ1JLcW80WGJrQjlZc3JlMkMybVo3ZTg5TVlsS1l2?=
 =?utf-8?B?eUlPdTgvcitEdjgzREJYNWFnVkpRZjBSK3EvSzhSTld3MnlKdW5scXAweGRV?=
 =?utf-8?B?b0lmTVNlZkF3UUdoUUdCRXRWWlRTZ2hvNVRDNmJQcllIV1RZS3RDeFM4M05k?=
 =?utf-8?B?Z1FKWjZYVkYvRDNBRHNYSmN4Tk40NzNpL3B1QW5PZitSK0FpdHREQXNxa2kz?=
 =?utf-8?B?aDVWU1cxNGdRTTVmUzkrRnAwM0hPWGJrNHZrUmllYWY0VTJ4emx5dk9xbUdl?=
 =?utf-8?B?cEZMTjgzam84ci95WFlPTmxOZGgxMHZ6d1B3YzczTTlHb0lpZHhJZVFtVGJ2?=
 =?utf-8?B?dmE3Z3oyRU4vUXdaaTBBbFNWUUluZ2F4N3gvRit0TUVJblNUeGh6OXJCVkdE?=
 =?utf-8?B?OFdQdHhkT2RYYmdYdHFWWHltWUxFSGN3K3BjS0ora2dyYTZ2WndJNEFOR0Ur?=
 =?utf-8?B?ZkhKQWt4YXpSdnArQWxDTk9Oclp0NmVvL3ZsOXk2cklFVUFXclRGc3RVTFRS?=
 =?utf-8?B?VHdONjBidlFTdTNxMk5GWEpTdVBjamJ2L2VZdWlWd2puNEFzYU9tM2JKWmlj?=
 =?utf-8?B?WUV5OGVKa2tFRzZrWjlST2k4NnFpUVRZOUVCWXpaeDUzaHhyZEZvRDJQOXNZ?=
 =?utf-8?B?MFRacXVicWZNSis2Ni90OHV2clZFekEzYXEwV29FMTZRQm5oZXVFQTFSWFR1?=
 =?utf-8?B?REFUQkt3d3BFNUJiTXF0SnM1b21ycEhTTmZVWUhieWUwMlBtRTg5a3RwYzdB?=
 =?utf-8?B?TExIYnJqeUNDNmd2UkpvRkNJYjJPeEE4Q0k4VXRiOTlialpyTEpLZ2cxSlVF?=
 =?utf-8?B?NTRFd1lsWXpGblpXa1FlTUZGckYzcWtqRS9BSEpYVGRnSzFJN3BmWjVFZVRv?=
 =?utf-8?B?Qm9MQnNLdGI4ZUlJWVc4NE5SYk9LVWN2dy9BeVBFQ0dIRUtFUy90OFJSMjV3?=
 =?utf-8?B?S1g0TElHWi83WW8yNXd1MXdPWlJkOHh1VGdENS9RZUI0Um9McVJPV3lNTk9X?=
 =?utf-8?B?NDBIMjQrUzM4ZzZKQUI3UFczWWh0RkJLZ0l5b3FzNlhSK0FoMEVmUysvTmc1?=
 =?utf-8?B?Y0kyVENUNHNvbk9Oa2hha3dWamZWbTkwc0lTRzF2c0tXOGswaENNOGxzckZR?=
 =?utf-8?B?T2l3cHNDTmk3TnVjalp0cE4zWmhJSDV0S0MvN2ZFa2s3Y3JXUnVZRjdnMlJZ?=
 =?utf-8?B?RWZhd2tuQ1A5OW05Z3hiY2xPelY2Y05haS9CV2I3MVdpaVBwMDJwRitJSDRv?=
 =?utf-8?B?cFVSbWkxVjhUK1BjL0hTZ0tIWG5GTmgwWkorVUZzcjFZekE5U2ZxUkpoTDRo?=
 =?utf-8?B?QTFPc2VTanBOSXE5OWNPQ05LNFNsMFUrK2pCK05MRlh1UUxESVZwb0NZQWwr?=
 =?utf-8?B?RUE2am1DUExqN2N3Q3dxZW9RRTZMSDdtSFdUZjY2Sk9DYTRuWGE4QWVBb2M0?=
 =?utf-8?B?aHRNREw1U0Q5Z0hxMHl4S3FLUUZSbU8wWGZhUTRmZ2FPSFc0elp4dmVzdTRa?=
 =?utf-8?B?cjlMNU5SbXRyc29ONE1hUlM5cEpieis3TzhBTTZsSFdNdFBGNHNaWkpocHIy?=
 =?utf-8?Q?1J78wxq1vMkP3d2bu27DwhuCS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZUxvbGFzQVlhbXhUNjljaGdRWllucmdhellzSnAvNVN6ckxNZ2wzamV6U2Yw?=
 =?utf-8?B?emFTWTVJUk5XZ1JGSWIzS25GcUpRL25LRVZZNTFmbGJ3Y25raDR4ckkrVW5Y?=
 =?utf-8?B?SG83WjNlSXk3SEFPU2ladWRuWXF2bzVqN3kvYkxPbXg2eVh1UitMY0dlb1I3?=
 =?utf-8?B?cnNTTXJGYnlEb3FINnlWNXc1RmRWZnRNSGhIb1NhcEdJSXpheGw1NmM3M2pK?=
 =?utf-8?B?cGtWNDVIT0JseDhmeDc2amhaTVZHc0JhYTVHSUZQVnYwSXNGVzdISkZQTFNM?=
 =?utf-8?B?SVhGSzdCWXIxZzBPbi9XaUhnSGRXd3AwbHZ4U3EzUzVYYi9HZnlJOWZrU0FL?=
 =?utf-8?B?NEZvWHlhOURYaWxIbEdOQTdhTDM4d3k2YloySW9sZ2trNUlVOVloM2J4Q09U?=
 =?utf-8?B?b2FtM1E3bGFkd0dadElrYktiZlExS285dnNMRHVRbWVZeVo1dW1hakpuN0E5?=
 =?utf-8?B?ZUpnODhYSG53aC83dEt3OVM5RDRwYnpCYkpzYTI2Y3o2ZFZpOFQ5akhPSmxT?=
 =?utf-8?B?T3VTWlY1RHliSUdEL2tWOEpIN2VQM2EzSldGZUgyZzZqcHp4V1JjdnFqL1Zl?=
 =?utf-8?B?UmRzVDZIYjdGVWxCRkQrWm9jNW01dWFGVmFhMjV4Z2dRZ2J5ejZjcjNDdFRH?=
 =?utf-8?B?Q3JIWUx1bWpPMDBIcXd5ZXpLaE1QMG5FYXhObFJYa0txS29uN1o3UXZkeHhJ?=
 =?utf-8?B?cW02SmdVK3BldEd1b0hOYzNyRzUwKzJySVBkSmVsZHVRT3dBS0gxMlVwTCsw?=
 =?utf-8?B?Tk5CRVV2OFJCZk9JVDJOV09JQ2xQNHROaWIwZnFIcjIwMm1UMTFKaHNiUDVJ?=
 =?utf-8?B?QTU1VEloOGNZZGl3ZWtKbThaOEx0ZTFvUU01UW4vZFJuR2ZFM2YrbzdzMmdL?=
 =?utf-8?B?OE1GbGR1ZEtJWVpDMHlMKzAxd3VLKzgzcG83UlU2NGVrNElLNlo3dVg1aEdN?=
 =?utf-8?B?TndablFxa0UwYjZDN3BPaGNwMk96cDJxbTBqc0VKUWFna2tuby91czAvN3hT?=
 =?utf-8?B?UE9yRWNVWGQwTnBpc0h4ZTA4M2VkVXpuM2JGVC9FeVpYdGRVeUF1N3B6OEl1?=
 =?utf-8?B?RGFiL096dE8zaWt5SXFDa1g5aXJCNFVGaVFJVTI5S3U1Q1ZrNXBtOWFHUDBt?=
 =?utf-8?B?ZXFHWHpGVGZOS3EzMThDOFF0QlR2dmlsVEp1TjVvdVZFVE55RFh1YnVDd3Nx?=
 =?utf-8?B?ZmpzSmRqSzExS3F1Y3B1MFdUaEY1cURzQnFlT1YwNmNOWHR2cFVwdEZvc0xt?=
 =?utf-8?B?aW9BVlVZMkZXSzZrNjd0Lys2a2Q0N3ZzaXVOME1DakZ1cnJqRFNBczMwWG1V?=
 =?utf-8?B?dk9VVFl0VEFrODB2NXNqSmcwb2RGbEdhMUUxKytEci9yRjFEc01QeGgvWjZi?=
 =?utf-8?Q?s83Os9dkL474QcyCErrHNK/XLhRkNK/c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1b5e8e-9c9e-4e01-0f54-08db9a82c9ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:51:12.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glTKhZ4gaHoh/36JKD/bMrtHoJ35BT1mhLG6SBtI9h3nlCt0pQIH6rfoT++TxJYvwPv0PmLGMdty226bOaKZCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110145
X-Proofpoint-GUID: 7EVxYWRIIdPZGbEJPoS2AhICpD38LcVj
X-Proofpoint-ORIG-GUID: 7EVxYWRIIdPZGbEJPoS2AhICpD38LcVj
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
> When there are multiple PMUs that differ only by suffix, by default
> just list the first one and skip all others. As the PMUs are sorted,
> the scan routine checks that the PMU names match and the numbers are
> consecutive. If "-v" is passed to "perf list" then list all PMUs.

I really think that this should be merged with the next change. I don't 
like the intermediate step of by default only printing the first PMU.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/builtin-list.c      |  8 +++++
>   tools/perf/util/pmus.c         | 54 ++++++++++++++++++++++++++++++++--
>   tools/perf/util/print-events.h |  1 +
>   3 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 7fec2cca759f..8fe4ddf02c14 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
>   	strbuf_release(&buf);
>   }
>   
> +static bool default_skip_duplicate_pmus(void *ps)
> +{
> +	struct print_state *print_state = ps;
> +
> +	return !print_state->long_desc;
> +}
> +
>   int cmd_list(int argc, const char **argv)
>   {
>   	int i, ret = 0;
> @@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
>   		.print_end = default_print_end,
>   		.print_event = default_print_event,
>   		.print_metric = default_print_metric,
> +		.skip_duplicate_pmus = default_skip_duplicate_pmus,
>   	};
>   	const char *cputype = NULL;
>   	const char *unit_name = NULL;
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 3581710667b0..5073843aca19 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
>   	return NULL;
>   }
>   
> +static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
> +{
> +	bool use_core_pmus = !pmu || pmu->is_core;
> +	int last_pmu_name_len = 0;
> +	unsigned long last_pmu_num = 0;
> +	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
> +
> +	if (!pmu) {
> +		pmu_read_sysfs(/*core_only=*/false);
> +		pmu = list_prepare_entry(pmu, &core_pmus, list);
> +	} else
> +		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
> +
> +	if (use_core_pmus) {
> +		list_for_each_entry_continue(pmu, &core_pmus, list) {
> +			unsigned long pmu_num = 0;
> +			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
> +
> +			if (last_pmu_name_len == pmu_name_len &&
> +			    (last_pmu_num + 1 == pmu_num) &&
> +			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
> +				last_pmu_num++;
> +				continue;
> +			}
> +			return pmu;
> +		}
> +		pmu = NULL;

you assign pmu NULL

> +		pmu = list_prepare_entry(pmu, &other_pmus, list);

and then re-assign it. If list_prepare_entry() needs first arg = NULL, 
then can just use NULL explicitly?

> +	}
> +	list_for_each_entry_continue(pmu, &other_pmus, list) {
> +		unsigned long pmu_num = 0;
> +		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
> +
> +		if (last_pmu_name_len == pmu_name_len &&
> +		    (last_pmu_num + 1 == pmu_num) &&
> +		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
> +			last_pmu_num++;
> +			continue;

Can some of this code be factored out from the previous patch? It's 
doing something similar, right?

> +		}
> +		return pmu;
> +	}
> +	return NULL;
> +}
> +
>   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
>   {
>   	struct perf_pmu *pmu = NULL;
> @@ -429,10 +473,16 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   	int printed = 0;
>   	int len, j;
>   	struct sevent *aliases;
> +	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> +
> +	if (print_cb->skip_duplicate_pmus(print_state))
> +		scan_fn = perf_pmus__scan_skip_duplicates;
> +	else
> +		scan_fn = perf_pmus__scan;
>   
>   	pmu = NULL;
>   	len = 0;
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +	while ((pmu = scan_fn(pmu)) != NULL) {
>   		list_for_each_entry(event, &pmu->aliases, list)
>   			len++;
>   		if (pmu->selectable)
> @@ -445,7 +495,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
>   	}
>   	pmu = NULL;
>   	j = 0;
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +	while ((pmu = scan_fn(pmu)) != NULL) {
>   		bool is_cpu = pmu->is_core;
>   
>   		list_for_each_entry(event, &pmu->aliases, list) {
> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
> index d7fab411e75c..bf4290bef0cd 100644
> --- a/tools/perf/util/print-events.h
> +++ b/tools/perf/util/print-events.h
> @@ -26,6 +26,7 @@ struct print_callbacks {
>   			const char *expr,
>   			const char *threshold,
>   			const char *unit);
> +	bool (*skip_duplicate_pmus)(void *print_state);
>   };
>   
>   /** Print all events, the default when no options are specified. */

