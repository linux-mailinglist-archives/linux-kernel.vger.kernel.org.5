Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66378E021
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbjH3Tcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbjH3SqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:46:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20717.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::717])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52810FF;
        Wed, 30 Aug 2023 11:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWo5iL27JgXkE/N1TcdMKa90qsDHvFiMS/UjMz1vJh0R3Jt5WtdptwFmOu80dZkxQ6ISzufdhc4l7xdNJi+aiiF7fUCqYkhIzYc5WnITWQBMroGdjpJjSPxT1OH4l41ISO4nCztanqGFAdfHTHDUdrM8saW5K1cYYt7hRw+KmVQTyHsxMb2PDAxF0//WAxCmCKV99jx5hkyNs824dcIkzgZCP/170RzT9gosFpOuXbmogMYjrR3+iPDkIxxmLEgYyRiKCmIxDWzh9kZOaUoozVISkqDQzBgGwP48LgNerzPsK5YBEJ952a06nUb6Fb1hkeakMt2WkCD9vFYvPdRQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY5rr4fRuR/W2E4IDh55cQDh8mYna2XnENKF1qQd2ho=;
 b=DET0hJf8oSzQIjJPJJ81RU/zVIzovHtpvXUKcySN67dVsjOUE64cE5Iu1rY6DXMapVsRESbNg+qf/acbNfTrc/+OG2E7xnsZy4QljwXMcfJoJSjxjqOJUldTyz+6E8qNFP7FNcY4v/iCdcjmE2QXIM3tY58pKAYOfctHtvhhIZAzrMND39IHi3Fks3oFt99615YkgP72LxYdLGqimabxF8e7ftv6xaHRzKR8kByUnvkeQglwwpngBR+pfCY8sfIdfP4fs5ksX5mhrvhMneeJBTbEp8iwa4PVHYlqFDOmlBs8P3U3up8e9X1Iwr30moXzr/Ayjq0gy2vyqruIue1hBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY5rr4fRuR/W2E4IDh55cQDh8mYna2XnENKF1qQd2ho=;
 b=N9QgHv9/XQ4NdT3NOlJynXFRe61XG/hR4k/d16nFvq+YyqdS/mDUqjSo9mciAr7tR45a1lyZvkQmqGNlmdeLIkqhqZmbjOOpkYeE1V+4VvtW4qLbduoRuifsbQBkM4n83zEOqPmEHN3ibugypaUPkDsQ3B4gweu6fB+9dGd4CqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 LV2PR01MB7599.prod.exchangelabs.com (2603:10b6:408:177::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Wed, 30 Aug 2023 18:43:04 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 18:43:04 +0000
Date:   Wed, 30 Aug 2023 11:42:47 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     James Clark <james.clark@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf vendor events arm64: Add AmpereOne metrics
In-Reply-To: <1299e1ff-2543-6ee5-dc32-bc098bd6bfe1@arm.com>
Message-ID: <e674954c-dc8-d961-8ff1-ebcde95813b7@os.amperecomputing.com>
References: <20230826192352.3043220-1-ilkka@os.amperecomputing.com> <1299e1ff-2543-6ee5-dc32-bc098bd6bfe1@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:610:b0::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|LV2PR01MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3f433d-2f1b-457b-3f18-08dba988f1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SisURiHUjzoTy/DdXAN5z/+7I6Cs0HXuJWyBWkObtvnbIZpmGi10t1e3zpQjgXFG7PMfpBybxrfRYUSx3vlykUyQvK4ZG44f+fhO+3fjR/l204DEs9hrIruXPNYxE/bnlN+L7qoCW+gpZwloHeCqKlD4jGMY7uKRGMUOWS5ZAO9Vy/egbjXHfNvL7egXih2srmqICKc60Pho+gaDubs8diPKxEHVstwNwqBX/C3BYC0ldfki50JxlqtJ8wZqEC/jMS9Na9DSxbFLHnWI0ZEavTDZcqTqsa8PAKPaJyYL7s6iDgzLC/EemIriKbQ0iY4aB92pZHoh+/xxz3G50yYpWk7/9s4LDf6Fbad02OK6B3pneqk+o7NG55Z9meC6Cra+pNFEmQeiZGeN+SbrFMtvjw2KkOAGtKjwMP4WfVdtZD65yUkFNcY/Eez8CA9DLqaxF8F5osBpXPxpKdiomKmsikT6JhrCOhqzhjWbSKehElOD4ywM91e2Yul8Yp13+lA+isd1ZDS2BcEPFAHRZ8JQ6tk5ATL0fAN+TCkP5RMJ9YOnZQpcecDyjBnIDt1EVRzExu552JMrl3Y/IsfjQzwt8NHqnLUtI0pCzmEkWUpZ/9cYy7MqdoY1hT9ZgO2yiKeG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(136003)(346002)(366004)(376002)(186009)(451199024)(1800799009)(2906002)(7416002)(54906003)(66556008)(66476007)(6916009)(66946007)(316002)(41300700001)(8936002)(4326008)(8676002)(5660300002)(53546011)(6506007)(38350700002)(2616005)(52116002)(6486002)(6512007)(38100700002)(86362001)(478600001)(26005)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NN39IHBb4NQFFIP518DWfinyFtuQ1PdXIPQdQHsSZsrYGEP12C/WJw3si/T7?=
 =?us-ascii?Q?kG9+ltaHFL2JDLzQA/RcnvKwsHrpc32NWmLEBOsRenz49zzaOBL48ByBq9zy?=
 =?us-ascii?Q?SAanT5P0hw1iuQ9DrOClaCVUwqFBBtcH86bq+VnOCzF2YvT9rwN3NjMbiDvL?=
 =?us-ascii?Q?9kQ1TBLeXXnPv3tG+IHx4G9oMzgRPXlZ5w2/NF8ARsDimGTJw6boFQyzWbrE?=
 =?us-ascii?Q?u3U/xV+I7q3UG8+TyhF4VkMECDZk57zoZxB6HuyJcVLQyRM8JK0HutjeZQ1V?=
 =?us-ascii?Q?QMOudY2oh33XSQXNdzs+4DGaNzltGxbKRfxS6ywsvjY0A7xNg51HHKJEHXvy?=
 =?us-ascii?Q?weWxaMr1hjVDaE/Zuzm3bVPKSY3XkUhTyZHqohUqCsdh4sU9q5IlhHhHjdYL?=
 =?us-ascii?Q?83CmgXl+o7fh+tDq6gDYW/txCp86cFf9tg/aQCFxyvKxLvn6fDTX0+E9Aj7z?=
 =?us-ascii?Q?HenZM4R/ngr+PcqYkWaVzTTUPpxPRTYEHff1osl/pl4shPFKRnhoXb3lq3Dx?=
 =?us-ascii?Q?UKJjsMPiFu7mgXkq8CyuX9QN09L1rJGDalhhrF7uKYmx73Ee+hnhtg6glyaH?=
 =?us-ascii?Q?M74uqalm5oomMNPfFpMTnL8HzTATpTD7s6UAIsavDa0vpK0m192P4VhcP3NF?=
 =?us-ascii?Q?Yj21b1V2gcrS22tKxQB26j3vpiiP4qsZHE+9P2CsS/pbCmnYn3dw80yYSsXz?=
 =?us-ascii?Q?T6zr0RwJOPDriivt5vxpHceqsXwoajn1eix/tsfiPpErmhZnu9c6aG76TpCz?=
 =?us-ascii?Q?/JbAV34UZ/u4sasj5LStLzqF5+LncdA0qVnduFwyf9gyTdQs8h9G6BLSfaHR?=
 =?us-ascii?Q?BHbRHC4BwcdDm2JLyBahwtoVaEUvy8ip3VvW26lpfL268h0cMSTMtIkRoUmF?=
 =?us-ascii?Q?ueT7pg+TsHX9P2dScgpaGLH+4PF8NiiTf3bfh81kb8QS8OGPGcyON6ROv6/x?=
 =?us-ascii?Q?kQqTGKtHjiVtGrQUIwPu4VsthMjw4A3ZiSaMJANfbIkI+EkUeLa36iJ5+8jd?=
 =?us-ascii?Q?Q0sC7oJYJE09LDbccLhPVW86vRL4Zprs6r4NkrcpeNzBXN6+219+ab1gcN+2?=
 =?us-ascii?Q?ioJvSX9+CNfW3GDNlPEszz9ocUUrQzSnz9eZ7wzVMhERorQMvISVMKz1DdKk?=
 =?us-ascii?Q?pLOG70P0Os6LjYdlLSZXjqXSEXvMhXV7RwlhMtXntxqBQo+cJjbOiFqX90ie?=
 =?us-ascii?Q?tmww/yK2FGNvP3G206hQnY+0kXENVk3voczZtBTqXRloy6C0yyIquDr2JzyL?=
 =?us-ascii?Q?yFrIc67rboGRGGIeaDMYqH5XQfO/EYvBYCO+mJrwGuN1TrYHepvH4VC8NsmA?=
 =?us-ascii?Q?4/h9nTFL/2Xx2XnhPQGN/D4x8wpn7i3vgHr0zq8P6FuJKu86sZ1ygPnYHr/I?=
 =?us-ascii?Q?iqZv2iiHsNnB42LVHKK0lf31V94hzbZ+tszyw0rALY5Tl+S4H25Wbyq/AAp4?=
 =?us-ascii?Q?RVed2JNHqoRxKT7K6diQz1USjhHMQSwv8MJVQ4TRCx/fnuJXGmsgmPOuEdW7?=
 =?us-ascii?Q?RLwBHwM+tTHAQC5QAAlNooP/c3oqCbYeFxoF/WMyKJPdstIxYpruCb4VcjcW?=
 =?us-ascii?Q?jOuj0ipry8bBiiRqV1snvKqYM/t82GqAeUnBj0hboOuBax+MGYCZH5H37HlU?=
 =?us-ascii?Q?ufsXuez7ToRKv4jf5Edr/Cw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f433d-2f1b-457b-3f18-08dba988f1aa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:43:04.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgpFu6VjxejL/sF0m4UcNymhcvAG6qt09/eJE7rVXhRVjd9XvkEwlSKVbfsUzhSkIJ+sfybugx+SVGBsMxgXrZIL4kfK1i5odspzeamB15ZlUVK2REKyFGHDWS8kLpeu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7599
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi James,

On Tue, 29 Aug 2023, James Clark wrote:
>
>
> On 26/08/2023 20:23, Ilkka Koskinen wrote:
>> This patch adds AmpereOne metrics. The metrics also work around
>> the issue related to some of the events.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  .../arch/arm64/ampere/ampereone/metrics.json  | 396 ++++++++++++++++++
>>  1 file changed, 396 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
>> new file mode 100644
>> index 000000000000..b623d8a9e3dc
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
>> @@ -0,0 +1,396 @@
>
> [...]
>
>> +    {
>> +        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
>> +        "BriefDescription": "Fraction of slots backend bound",
>> +        "MetricGroup": "Default;TopDownL1",
>> +        "MetricName": "backend_bound",
>> +        "ScaleUnit": "100%"
>> +    },
>
> Hi Ilkaa,
>
> For these topdown metrics, as long as they are the same as the standard
> one you can remove anything that is duplicated. This might make it
> easier to make changes across all the topdown metrics in the future and
> have consistent descriptions across CPUs. For example this backend_bound
> one could look like this:
>
>    {
>        "ArchStdEvent": "backend_bound",
>    }

Nice, basically the same way as architectured events.

>
> This assumes that you have the slots sysfs file available, otherwise you
> could leave only the formula in.
>
> We also decided to make the units for the topdown metrics "percent of
> slots" as we thought more specificity in the units was clearer.

I'll take a look at those and update the patch accordingly.

Cheers, Ilkka

>
> Thanks
> James
>
>> +    {
>> +        "MetricExpr": "1 - (retired_fraction + slots_lost_misspeculation_fraction + backend_bound)",
>> +        "BriefDescription": "Fraction of slots frontend bound",
>> +        "MetricGroup": "Default;TopDownL1",
>> +        "MetricName": "frontend_bound",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4)",
>> +        "BriefDescription": "Fraction of slots lost due to misspeculation",
>> +        "MetricGroup": "Default;TopDownL1",
>> +        "MetricName": "slots_lost_misspeculation_fraction",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * 4)",
>> +        "BriefDescription": "Fraction of slots retiring, useful work",
>> +        "MetricGroup": "Default;TopDownL1",
>> +        "MetricName": "retired_fraction",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>
