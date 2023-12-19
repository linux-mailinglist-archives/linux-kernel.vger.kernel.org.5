Return-Path: <linux-kernel+bounces-5610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD441818D14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED26286976
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2020DED;
	Tue, 19 Dec 2023 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sWv+OYQN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62121249F9;
	Tue, 19 Dec 2023 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuNH1GbDqdTWMpQe59DWr1dao/LgMl+MRw0xc2MeSY2T83Kw6sI1y22doCdxdrh09yeZ66orbMrthD5b8AmVfnk707YlBAm3SNjh9nDAE/swD1peSmRjfET2Jgbhdi6CbbPoEFyPxfKkwAdSyyipbFKZxE6MzY12UmfOICOY8WRBu0jUewuW8N/FZHb78Jj+QbTkEifhvI27PLKBXgUbedfYiLlrPzwF6TFhIGkXW5MvGci149XifVyNNvjBduy00EHgEPajAdmA6HqIbHectqjOL9nbVIR6TH//mvV566BqZzy0TB60x020oYEZzszXucSZ2LSqDQMFLy13hGxqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vViePV9G4IosgTX5H+xJYhC5vPNbjcdEJcbTwhhzwBY=;
 b=KShvgjQlpIRfaIV4nR/Cgr9j+PUAdumBhVPIqS6Z7c3D6KZYi3U8IIO2KTwm2oxAJvnXIhswv4Mx7lJeEqcI4ljp4cgaIkOzlHmISXJIR++mLYaPxMJKD0ZvT34buQsYamaHI4RyyrtQLnhnSSevlOoBD0VsYdAaePaINa7rgUqqK7Uy0aU/CE0xPlrWmpflaN96WIuKtEc42qJCp0Zjy0TluTVjFTVFh0ZnhkFcgkbF1e6I6PHMQQPDmC+oHOgO7Bs5AJZ2JKCYmr0BamJoDKwDr9hRgAiGhCN2J9fxDK2ZDY1DDWdXq0wa4zWlL4hYw+NF+eOh6uZAf/EpEJkhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vViePV9G4IosgTX5H+xJYhC5vPNbjcdEJcbTwhhzwBY=;
 b=sWv+OYQNBFrMvdD35Ms9k3CFC5c+ANpg1DQD2p2cCGrvCAHtTuH5+2bPybSc7J1pYzFdepPszHF2oUslu621PRGizyHwl6TaUGExV6eB81IA0Up+fk3d0c3yMZ9WwlEP0cEJvMquTyHzF4l1rkMn/31tJXfAXA0ABB1N+jnehk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9704.eurprd04.prod.outlook.com (2603:10a6:10:303::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 16:56:53 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 16:56:53 +0000
Date: Tue, 19 Dec 2023 18:56:50 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
Message-ID: <20231219165650.3amt4ftyt7gisz47@skbuf>
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: AS4P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 388cd63c-ae22-4094-60d7-08dc00b38064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mzqH9R/XU+tWYzO6I+fIKEODM8cKQSxN/xBvRlzTwIotBGsV9XPMhRj+gGgCTkI/BJVt83Xixip72b+cYMUrUb5iCZZbEezkRquGkNvwQavNUpceYRJ2o/5syQGXm0nb7N69w8h5KzyoES1yPkgnxnDMfgt6BOCbPzF4QceBCLv8+e6+Y00qgu6eEE95OwOtLHa4qNUrGNqCWILNYEhAvw0yXLKdwm6BXRkSWgIMQKwJyX15rHbLhNTln1dLWA8/nurE52QriIduAu4IK8FaKzaOYnheD6yJKAfi+xN6SPDi/RpVgIY1L0eMtC4VKmP2/D5f4iM45ZjpX/sjHD6Ir+qRc/1l0dSRQ2EbnDTOcYA2TTejVAv/BHYPCqYb0YtUGOFAdK0xObWaOLt3YZBgYEM3tSykZHyCBy0eCzB7cLSJZhTQdvp/QoyiOsqE7sRn8joPXGSzhq6Qs7OZqUWxvgX/lWjrBGUF9wFTeRDPEDCrZrKPxQtn/UhIDbp3iMeMcNF+yV6uhUxIRiHSpMwidLBn7N4OF6mi4QZA3RfhgVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(66556008)(66946007)(54906003)(66476007)(6916009)(478600001)(966005)(6486002)(26005)(6512007)(316002)(1076003)(4326008)(44832011)(8676002)(8936002)(38100700002)(6506007)(9686003)(7416002)(5660300002)(2906002)(86362001)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cGl4jMxiM+3mKipqCwqoBpvZ8CZ1W1xVWYatqopXSBC1cFUcXSOgfi2LVab9?=
 =?us-ascii?Q?puASuhfvepm6zplTMuw5tIZiyNMSid29vVz/5aGEafoe7w9vz51faSXdY5BO?=
 =?us-ascii?Q?WbwRk7lje+gpBxSHb+LRCY14gQ+TqOncPaZNOmt8Q7zrxrk5EFCjhQzGHvDe?=
 =?us-ascii?Q?lcnmUDDK88eg8jBF+luQlepR0QW0Ijirc/TEbumEGWAF4THBwqkb1dNOlBJP?=
 =?us-ascii?Q?NMxLN8hlxzmD6ZmBQtVH4T7PuXw5x1A/1bADu7VSN68yhfkEOYrEzMRY7G46?=
 =?us-ascii?Q?9Rr0OyeFi3iX79Gn1zkCmzPzOxEA3DHTBRqju8KjYugF7DuHVt2Kw3I5Ruc5?=
 =?us-ascii?Q?DuPLsEEB1jfd3cOZClLY+Dk8XlQjUuRYUuUsSmgZMx414WwT3jRV2boUDqwC?=
 =?us-ascii?Q?AHJylwxN9ohFER+mKD220N3GLu0tVdVLTZju+jfiaQ4WDfPDTr35NNGHMinD?=
 =?us-ascii?Q?vH4M1+I5GUjDFdEHg6UV5KKpjrt8iurYLP9kFzFVJI7EQAtYIcjd++DDiDGa?=
 =?us-ascii?Q?LMzCHda22/fBCTkg3znKdjee2UT9Dwlqq5KiiV7QrvgeNH8HCA3GRlN/Ase3?=
 =?us-ascii?Q?//I+o7mIcKtm7gMqo8Htvjoq1umyz27IvD3RKPwLRFdAN5O3DtBoZ9gm/R04?=
 =?us-ascii?Q?t+YAlhLNXcOps+UHseUnFy1USECQHZ5F3eUpG2zhuFnGOLUKAt7XJ1X04Ime?=
 =?us-ascii?Q?ZIUWqMGC6igt0VMPyGgSJXT/x0IMMRKqGSZy5Z2Fof/ciDYOWuF14iIeRfxs?=
 =?us-ascii?Q?nsdk3bghgOpYZEuVHmfeAA+BTJIonob77spQxeb9wYWPCPdMC/CkEYFLaWTT?=
 =?us-ascii?Q?EVwqyeD2kxR54ynEN7/yd3T0OYNCKu48caYthr2orSRPZ8N02+XWKm6ftbmv?=
 =?us-ascii?Q?g/rfyOOOXSCwTde2Xot1HtqOIdu7PD/L44jXPmyyCym/Ocu4mBf+7eciyfDi?=
 =?us-ascii?Q?puPkCh+9ZXdopkiGKV+x+Xpcg53aB/81VkOk5uIS9ldOKvXaJfLo7U1/h/1x?=
 =?us-ascii?Q?y2D5+y/n2stszPB3s8P4wjJy3d328HFpDkzNjbrUiqY4pQ25hBYQz7sEVqQ1?=
 =?us-ascii?Q?hjTquQkFHdgiJEkQKItRa6nyGM1hCdjCT5Q3y3oMShEM8fKRBbGvHUpIYrZT?=
 =?us-ascii?Q?My578tUG7DPFhfDndBFGING93pDzxpyPEQZAYOAwHDeznvQKHxGV9/ylHtpo?=
 =?us-ascii?Q?yUW/u7INAHARHLBjK4Ui1jDmso7kUzHKRNSgMdX5JdyqR2e6ZQ7ShRsON1ec?=
 =?us-ascii?Q?U2lO+GF8vIOjZCaVjiiuID/81i9UqV/XrZr4n8V9kmQRK40NSes5kTw0RKUb?=
 =?us-ascii?Q?jHSrLP9zoxTaRowj08mBHmnA/k9bHBqOHJyarTZ3Fq2gkAmCeTUeyxYSlJMY?=
 =?us-ascii?Q?85T2OJkNp++fh7h3rdepozSlabTysth9tonsAASXyRFnDPTULo8bsm16V92S?=
 =?us-ascii?Q?WRMOr2bxBlyzgEiIAuhqgD6w9yHUXs0DEaFy6m0VeY9BYO9o5ZVuUHUKNrgJ?=
 =?us-ascii?Q?YNJ4UaY+9rDSJa3VLPiIeVPMGyk1l8v+Q7y6IudXAyn/85BPmlntS7Bfo080?=
 =?us-ascii?Q?u26MSqOaE1b7IH0Vpt5EqgcuTDn4L7Nf6JYd5b/UZ90w+/3sXqto6ikraDbt?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388cd63c-ae22-4094-60d7-08dc00b38064
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:56:53.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qbb7DYKZVig/IjyHx6ySNrUq3Xru1h1SoBTcuNoOy2Fk8kZuoI0Txo3megeQKx/iBa4o3kXP20iugQJTjUQOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9704

On Tue, Dec 19, 2023 at 03:14:49AM -0500, Faizal Rahim wrote:
> According to IEEE Std. 802.1Q-2018 section Q.5 CycleTimeExtension,
> the Cycle Time Extension variable allows this extension of the last old
> cycle to be done in a defined way. If the last complete old cycle would
> normally end less than OperCycleTimeExtension nanoseconds before the new
> base time, then the last complete cycle before AdminBaseTime is reached
> is extended so that it ends at AdminBaseTime.
> 
> Changes in v3:
> - Removed the last 3 patches related to fixing cycle time adjustment
> for the "current entry". This is to simplify this patch series submission 
> which only covers cycle time adjustment for the "next entry".
> - Negative correction calculation in get_cycle_time_correction() is
>   guarded so that it doesn't exceed interval
> - Some rename (macro, function)
> - Transport commit message comments to the code comments 
> - Removed unnecessary null check
> - Reword commit message 
> 
> Changes in v2:
> - Added 's64 cycle_time_correction' in 'sched_gate_list struct'.
> - Removed sched_changed created in v1 since the new cycle_time_correction
>   field can also serve to indicate the need for a schedule change.
> - Added 'bool correction_active' in 'struct sched_entry' to represent
>   the correction state from the entry's perspective and return corrected
>   interval value when active.
> - Fix cycle time correction logics for the next entry in advance_sched()
> - Fix and implement proper cycle time correction logics for current
>   entry in taprio_start_sched()
> 
> v2 at:
> https://lore.kernel.org/lkml/20231107112023.676016-1-faizal.abdul.rahim@linux.intel.com/
> v1 at:
> https://lore.kernel.org/lkml/20230530082541.495-1-muhammad.husaini.zulkifli@intel.com/

I'm sorry that I stopped responding on your v2. I realized the discussion
reached a point where I couldn't figure out who is right without some
testing. I wanted to write a selftest to highlight the expected correct
behavior of the datapath during various schedule changes, and whether we
could ever end up with a negative interval after the correction. However,
writing that got quite complicated and that ended there.

How are you testing the behavior, and who reported the issues / what prompted
the changes? Honestly I'm not very confident in the changes we're
pushing down the linux-stable pipe. They don't look all that obvious, so
I still think that having selftests would help. If you don't have a
testing rig already assembled, and you don't want to start one, I might
want to give it a second try and cook something up myself.

Something really simple like:
- start schedule 1 with base-time A and cycle-time-extension B
- start schedule 2 with base-time C
- send one packet with isochron during the last cycle of schedule 1

By varying the parameters, we could check if the schedule is correctly
extended or truncated. We could configure the 2 schedules in such a way
that "extending" would mean that isochron's gate (from schedule 1) is
open (and thus, the packet will pass) and "truncating" would mean that
the packet is scheduled according to schedule 2 (where isochron's gate
will be always closed, so the packet will never pass).

We could then alter the cycle-time-extension relative to the base-times,
to force a truncation of 1, 2, 3 entries or more, and see that the
behavior is always correct.

