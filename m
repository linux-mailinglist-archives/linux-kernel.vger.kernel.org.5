Return-Path: <linux-kernel+bounces-8497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26C81B8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78151F26AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9E76DC6;
	Thu, 21 Dec 2023 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/qCbiFU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2C745E1;
	Thu, 21 Dec 2023 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSpjHq5v03FKAO2s1RkVJHHqgMX47ms79Os9LHKViaInGngDfhpctJOzrUnHnkOUcQd9QGq2CA9llAyhKWAoci1kJcG1OY6/xhmSqjLrz7OO7EDJbJiK2FUUV20chWR+qzRPRWy49HConArExTWJzOtzsdzXcD6rRHjOFIYolTrfP8k7OarkSGCaF4Zcwn2MeCnN34za3W51Tvf3cXTKB2/SMVgGqO1zqpztv6s7uOCJlAikbQ9na8OjmmEd1Za8n0nmdCbMSl0OyQTcm73NH1Hg6zxv7VkyXbSc/f4RKRuZjwhM9KcB0wXJEApKNgt9vf4oaZYsZLBBIRjcb0IznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un7DN+8SLop1TbxMisqKf7dXiDAHw0iiRbhk8/R66kY=;
 b=RwtSKDMGwG3eqaaAazvrFvkRP8mqc7EIo7G8tN8KbrEDyEhRdCF51W2lhgwPFB+RElC1BIaOj8Daf1HhcRZLByzWbfGH6nFel+9NEwdmY+XSKWWIfhyNUPH+8uKaJgDX1jtfS4nLDS3p5GvLgVH2S0swNFd7D5Hiu9kYPV4NYTlUgXL+oWCGJf6sPDiUr16H+c+nINJI0ab2ack+oY5tvKDXapYttZx2VmNTT6UVZi6OY4HpH38CSc37Ovxt3mwsiKaHAvq+0xcW7EAtae9UrLHUgUK9HL10Rma7QsH1DhhYuQVlAeAFSK89HpN0I6t7YU/Y7V4EzOGzEjtDepHikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un7DN+8SLop1TbxMisqKf7dXiDAHw0iiRbhk8/R66kY=;
 b=B/qCbiFUh1ZURI8XO0OrkfolbPb3wlxpIn6HOmRkV/dgcwjhlrt0N0daRV3GxizTnvy+nW9Ny5S6JuelG6Nu7erPcpeyGi/xrE3rvItTco+jPz7k4joxPWIlMjsu8rohki2a6hdnLBPS42hYFuvrKi1FYpnk+Rg56tMTHfNVv6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 13:35:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 13:35:33 +0000
Date: Thu, 21 Dec 2023 15:35:26 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
Message-ID: <20231221133526.n5tvtkm42lntg3xc@skbuf>
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
 <20231219165650.3amt4ftyt7gisz47@skbuf>
 <d76e2682-8763-49d0-b46a-5f874eb61985@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d76e2682-8763-49d0-b46a-5f874eb61985@linux.intel.com>
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4711cece-6158-4d0d-23f0-08dc0229b4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tvWkSQ9+YJuePtEzTSIIQxneo9CKfSxbw82ylaYPjPXP/SLbdJZ2fjfVIR/NqHVP66kW961ok0cq+gI9BD1Q1Pn6oKCXsuvx5ydEmPqyAUi8+5cR3Kclo1qVSPyjzHLUP8zRaNEzR/CbzmY7GZYydAww8hIBGKXo9YvuGx1ncQTrqtU/bbKI0M2cN5Wa6BqKRWJGGIF2d2iBZYoXPnl82O8ajbu6M4NHmGGKOnH3gi/1OjxIPE0TA0A4Ndnd8E6kKcW3oz6gKmMvosL+T+WUvYpEvc7Ohyr+5dOf2Ve16AyRuSD28WgS3W/Oskx5RqFk84lq6wq6iWNoaHQcvr0R6ZI9lefrlHrJi5FKZGCdYN3vDiEEssIADoTIg4nKx3e5H9X5YDtyChDZNPfUvFxg8cmjtbd5uCPktZ+2bXa0SSBdz5Ci5MLUfdAxsTR7Eib+p4NenYjueXF00rcvhMYomRJjNQvgQ6zfmEVxjhib7DJr0u+lIqXC7Qry10C3ZLZGSGmOWO+JZVo8Jc4ZZe3NUsXYEqT7sKdF4eCRaRgv+Oo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(966005)(86362001)(83380400001)(33716001)(41300700001)(6486002)(44832011)(5660300002)(66476007)(316002)(8936002)(9686003)(4326008)(66946007)(66556008)(6512007)(54906003)(6916009)(1076003)(26005)(478600001)(7416002)(8676002)(2906002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDNOeE5UN2ZrbkpSWTNzQ2VIeWlEcTBJcEV6SDZEMC8xUXdEWFBkSFIvSlp5?=
 =?utf-8?B?bUJubWlZUUM5QS9iWXRNcWpqZk0vK000blpEOGkvODFYY2hpT3JaVWtwUi9i?=
 =?utf-8?B?WWRGU0ZQNmg2TXNnTXV2TTZlRUZiWXU2NitxemNTcmhZcnpqNlJoZmJ2ajg1?=
 =?utf-8?B?c0ZsVC9hNWtoclZzSWFTZUtSM2lXYjB4QW1sMkIwd3pMVHpURkhXaXR1Rk1L?=
 =?utf-8?B?V21PaHpLRjJ4cVhrMnNQcm44OU90T2R1RENxM1kzREpGVlNMN080aG5hNzV2?=
 =?utf-8?B?UzJLVUVJMGtmUjlCUUVNcUdYQlFoS3huUXhBbW1lRlkyUFZuRWM1Tllna0Rq?=
 =?utf-8?B?Z3loVFg0Q0M5YjRKV0liakJyYnhjUWRYQUNpU3BIN1FadmFGVzVOd09Oa0tX?=
 =?utf-8?B?ZERmcDZTRFJ6QW1Od2VPN25YMEhvZ3dLWUozTGJITGxHdEFyektwRllZVEE4?=
 =?utf-8?B?MlFkNGlXK2V0c05VRzl3S2IyWG9RS3F0WkIrWkx1Uk16dnBnaDhaSjBnMWdP?=
 =?utf-8?B?NWM1YnowbG1OK0FBS1hQTWh5VkRlZmlxR2IzbTZQRVdSemVtSDhzd0VuOWlk?=
 =?utf-8?B?QUhUNnNpVW5hVDJLQUlMRGQrL3BoTWIrWWJWU1lhUkVBck5VZEttSnE3ZzlB?=
 =?utf-8?B?Vmh1VGlhekw3RGhLNXV5VkduWjZyNUpFc1ZYS1NOa2gzQU0yOVdLL0gxV0Ex?=
 =?utf-8?B?MjdkdmtkWlIrcS9ycFJwUG53SEsvT2htMWVqN1NoYW5TWkxSMC9wSjhjekd0?=
 =?utf-8?B?dnc1a2QwLzhCREIvdVpnY3owc1lYSXM0aWtsTmZQNmNvRkVlUm1TRGF0TXhq?=
 =?utf-8?B?eTFmWWVPa0Zma1MrR1BnOS9LR2FKMlpZSlNaZ1cyVEpJZkxGUVNQZ0U0SWhG?=
 =?utf-8?B?b3lhSFdXUFlKUmxkY1hudTlTbnBGQ0hLT3hseHpLTk0rK0pZMFZRaHAwVUFR?=
 =?utf-8?B?ZTVlcDJWZFpBdmFSVk13K1I4MjdYYUVEY3pPZXZOYUJNQzEvZStxNTZxTWJR?=
 =?utf-8?B?Y3pCZWJ2TUwwaXBiaEQ1bmU3U2Z5TUU5WXdkWGhkR1Y4a2M2dGRDOXh5bjk4?=
 =?utf-8?B?LzlHTHVlRTVzeG1TdEx5UG1xWDdYNVVDRzhTRE9iNDlQNlk5aWdCdzV5QjZZ?=
 =?utf-8?B?aTBGV2ZtbVBCUEEvZ2Q0R1h5OGV5elhGUktlUXlvczhhMHJQWnRQT3g2OE0y?=
 =?utf-8?B?Z1FEN0hSeGdGS3h4d2xnS3RoRVhUNC91MTlnYzhvcXkzaUNMMWlnQWtpNlI5?=
 =?utf-8?B?cVpSVWpGZ0xoYnFKQmFUdU4reTNZSk5mSnZUOU1GcHRZNGtBOFJRU0dJVEFy?=
 =?utf-8?B?amRRWU5STG1SWHJVcjBsc3B2U0UxTzRFK0dBSDBQSUZlVmx6Y3dmdE5udFVv?=
 =?utf-8?B?M25ZTVVLQkRNYkFpVTVacWpqdGpuNE9hSG10Y3NwN0gzcG9qcUxEck1uSSt6?=
 =?utf-8?B?WkdHU2gzYno2YXJHRkFDcjJMV3FMNkd6eVdwZFlTVXg3U2ZGcW1Eb0RockV4?=
 =?utf-8?B?SmljcXFyTUNRWlI3VGJnSHJ2UjBpMW50bEFUelNXUGdGSDZaZ0RDdU1SUm9x?=
 =?utf-8?B?b29jcGphSEs0S21jQTZLV2dZT1BHV0I3dG5UTDFHZkZWZ3pUS3M3ekRBZGs1?=
 =?utf-8?B?N0JCR3RlNEtBV21oVHc5bGJ6QU1YbGJPbFZYdGFxUFRqZ2F1aVFjNERWblcw?=
 =?utf-8?B?VWF1dnVrV0dNcU53dmpYaDl5MFpLZ0RIK3lIMm1NQUFobVB0U3B3S2tpSzJy?=
 =?utf-8?B?L1IyeTdNZnJwSExoTjZueVB4MlgyOUlBNXA1T2Rma0doVHZvTGQvSXhua09Y?=
 =?utf-8?B?cmR4OGZMNjdxWm5tZkpyeHFCbmIxRUdkM3EvU2pyeG5lTTA1eVd6S3N4RjBL?=
 =?utf-8?B?dXBPVzR5bDJ1dk1TUEQxcW5YQU5adjBUTGJoZmpjUXAzU3JLaTJwQUl1TG9R?=
 =?utf-8?B?Sk90Ly9JR1dVVDZCMWVmZkxmOUFEbmpSZ285aWFCUHNhckVyWWhsbVAyVUhQ?=
 =?utf-8?B?QjF0b2x0Nmt6VzRyQURqRmlqOVpFQVNvVVNDRmxaWjJyNlcvY2RTUVZ0ZnhP?=
 =?utf-8?B?OFVySThOYmcwYytWVnIyY2NIOWNqZktIVEkza1d3aXR4L3Nqd1VNdnllc1lW?=
 =?utf-8?B?T3dZRGZZZzZDOFZOZWViU2F5QjF1dHVCQXZtVkF3Wmw5M1ZqMC84cWk0QTN5?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4711cece-6158-4d0d-23f0-08dc0229b4c2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:35:33.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKWGK6ZVfj/4tEn0AZjA4lV7weRTsRsJPbOWQMllUDJkCGmRBaidEIlLC0PZe7N2uBqgHq0vpxyUk7yyrs7Xdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

(sorry, I started writing this email yesterday, I noticed the
conversation continued with Paolo)

On Wed, Dec 20, 2023 at 11:25:09AM +0800, Abdul Rahim, Faizal wrote:
> Hi Vladimir,
> 
> No worries, I truly appreciate the time you took to review and reply.
> 
> What prompted this in general is related to my project requirement to enable
> software QBV cycle time extension, so there's a validation team that created
> test cases to properly validate cycle time extension. Then I noticed the
> code doesn't handle truncation properly also, since it's the same code area,
> I just fixed it together.

We tend to do patch triage between 'net' and 'net-next' based on the
balance between the urgency/impact of the fix and its complexity.

While it's undoubtable that there are issues with taprio's handling of
dynamic schedules, you've mentioned yourself that you only hit those
issues as part of some new development work - they weren't noticed by
end users. And fixing them is not quite trivial, there are also FIXMEs
in taprio which suggest so. I'm worried that the fixes may also impact
the code from stable trees in unforeseen ways.

So I would recommend moving the development of these fixes to 'net-next',
if possible.

> Each time before sending the patch for upstream review, I normally will run
> our test cases that only validates cycle time extension. For truncation, I
> modify the test cases on my own and put logs to check if the
> cycle_time_correction negative value is within the correct range. I probably
> should have mentioned sooner that I have tested this myself, sorry about
> that.
> 
> Example of the test I run for cycle time extension:
> 1) 2 boards connected back-to-back with i226 NIC. Board A as sender, Board B
> as receiver
> 2) Time is sync between 2 boards with phc2sys and ptp4l
> 3) Run GCL1 on Board A with cycle time extension enabled:
>     tc qdisc replace dev $INTERFACE parent root handle 100 taprio \
>     num_tc 4 \
>     map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>     queues 1@0 1@1 1@2 1@3 \
>     base-time 0 \
>     cycle-time-extension 1000000 \
>     sched-entry S 09 500000 \
>     sched-entry S 0a 500000 \
>     clockid CLOCK_TAI

Why do you need PTP sync? Cannot this test run between 2 veth ports?

> 4) capture tcp dump on Board B
> 5) Send packets from Board A to Board B with 200us interval via UDP Tai

What is udp_tai? This program?
https://gist.github.com/jeez/bd3afeff081ba64a695008dd8215866f

> 6) When packets reached Board B, trigger GCL2 to Board A:
>    CYCLETIME=1000000
>    APPLYTIME=1000000000 # 1s
>    CURRENT=$(date +%s%N)
>    BASE=$(( (CURRENT + APPLYTIME + (2*CYCLETIME)) - ((CURRENT + APPLYTIME)
>          % CYCLETIME) + ((CYCLETIME*3)/5) ))
>     tc qdisc replace dev $INTERFACE parent root handle 100 taprio \
>     num_tc 4 \
>     map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
>     queues 1@0 1@1 1@2 1@3 \
>     base-time $BASE \
>     cycle-time-extension 1000000 \
>     sched-entry S oc 500000 \
>     sched-entry S 08 500000 \
>     clockid CLOCK_TAI
> 7) Analyze tcp dump data on Board B using wireshark, will observe packets
> receive pattern changed.
> 
> Note that I've hidden "Best Effort (default) 7001 → 7001" data from the
> wireshark log so that it's easier to see the pattern.
> 
>      TIMESTAMP               PRIORITY             PRIORITY    NOTES
> 
> 1702896645.925014509	Critical Applications	7004 → 7004   GCL1
> 1702896645.925014893	Critical Applications	7004 → 7004   GCL1
> 1702896645.925514454	Excellent Effort	7003 → 7003   GCL1
> 1702896645.925514835	Excellent Effort	7003 → 7003   GCL1
> 1702896645.926014371	Critical Applications	7004 → 7004   GCL1
> 1702896645.926014755	Critical Applications	7004 → 7004   GCL1
> 1702896645.926514620	Excellent Effort	7003 → 7003   GCL1
> 1702896645.926515004	Excellent Effort	7003 → 7003   GCL1
> 1702896645.927014408	Critical Applications	7004 → 7004   GCL1
> 1702896645.927014792	Critical Applications	7004 → 7004   GCL1
> 1702896645.927514789	Excellent Effort	7003 → 7003   GCL1
> 1702896645.927515173	Excellent Effort	7003 → 7003   GCL1
> 1702896645.928168304	Excellent Effort	7003 → 7003   Extended
> 1702896645.928368780	Excellent Effort	7003 → 7003   Extended
> 1702896645.928569406	Excellent Effort	7003 → 7003   Extended
> 1702896645.929614835	Background	        7002 → 7002   GCL2
> 1702896645.929615219	Background	        7002 → 7002   GCL2
> 1702896645.930614643	Background	        7002 → 7002   GCL2
> 1702896645.930615027	Background	        7002 → 7002   GCL2
> 1702896645.931614604	Background	        7002 → 7002   GCL2
> 1702896645.931614991	Background	        7002 → 7002   GCL2
> 
> The extended packets only will happen if cycle_time and interval fields
> are updated using cycle_time_correction. Without that patch, the extended
> packets are not received.
> 
> 
> As for the negative truncation case, I just make the interval quite long,
> and experimented with GCL2 base-time value so that it hits the "next entry"
> in advance_sched(). Then I checked my logs in get_cycle_time_correction() to
> see the truncation case and its values.
> 
> Based on your feedback of the test required, I think that my existing
> truncation test is not enough, but the extension test case part should be
> good right ?
> 
> Do let me know then, I'm more than willing to do more test for the
> truncation case as per your suggestion, well basically, anything to help
> speed up the patches series review process :)
> 
> 
> Appreciate your suggestion and help a lot, thank you.

Do you think you could automate a test suite which only measures software
TX timestamps and works on veth?

I prepared this very small patch set just to give you a head start
(the skeleton). You'll still have to add the logic for individual tests.
https://lore.kernel.org/netdev/20231221132521.2314811-1-vladimir.oltean@nxp.com/
I'm terribly sorry, but this is the most I can do due to my current lack
of spare time, unfortunately.

If you've never run kselftests before, you'll need some kernel options
to enable VRF support. From my notes I have this list below, but there
may be more missing options.

CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_VRF=y

Let me know if you face any trouble or if I can help in some way.
Thanks for doing this.

