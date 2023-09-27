Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA997B043C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjI0MdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0MdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:33:10 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3FFC0;
        Wed, 27 Sep 2023 05:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD+outuWCL2hOK2cwbttkBY31T2WyIWie0R/k/1iBFyRoXh68ROm8yFIrRuCpZ/VwCBVkpQiT5ZfznLHt5apSEyf/rqid9Wc4MKZWuf7/qvBx6iM005Lu6e2aiuZJUcvt4thRqU1MESM1hlfbKPY5muEzK0ES5YZ1v6lr64c3fXNCJN8ZiB7TcH7AQuuVSnevlP6MuM/WkfbI7aXynqk3KyfahBEUc9sxY+mP/ey5IA3TZCRAd98/lnna6eNU+sKEV8AYyG1RzASmaa7jWi+qX8YgqD7qBC/YbZnlKs8hxlSOrAPczUL9umFND0/+6CwvEsUcJa54VT5MFrDSul6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05yPlB99e+g5fbnH1otluD8Xv7IJcgVOZt7PmzaxZKk=;
 b=aig7SB7MwVh5pdjYlNqkWOOKb3b6vUQGckLg2Shc3jLmGihPtrm3CTplCEV3DHHkH5SgWU3YMPBoE3mIlh2hh7mMoz2IvLp2i1SFK+0UMXmqHug3TRuLkgobCi7VUmbe3oFMa2hJaVkqEycBNAcZVf9b2HsiJneY3AZqwmEPChr4tY0ROnUKEuPWrmGbkNcxNRL51Hzlxw0QSgo3yM26bxSH58M9GKSKrEASP20LAse+9DiOo1orm5T77YMHhNLVI2B/WzMyxqXS8jz0E1X+rwsd28BdK+K53XdMdxiPkWCdw4qju5KdQLswtrUTM8EeLUW3HzsRpdzOahMoNkS9+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05yPlB99e+g5fbnH1otluD8Xv7IJcgVOZt7PmzaxZKk=;
 b=MsVpptkzeCgdCYNaIa+VQeWhitOCOZit+IaJOnxIfQWpjIad6ateWOyFk4swhmiS/H+Yor13gpIZ9//iocsDAL8knLtRVnE00O+bFXYbBHV6uE1LBYiKtRU5Zw//Ou0l2Mf7AoKap4kl8Hp4SmSB8qFMqdXBUqmyxSTkEVxoyW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:33:05 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 12:33:05 +0000
Message-ID: <9098b8dd-65d4-b629-d6ab-6e2fdd041148@oss.nxp.com>
Date:   Wed, 27 Sep 2023 15:33:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXT] Re: [PATCH net-next v5 3/7] net: macsec: indicate next pn
 update when offloading
Content-Language: en-US
To:     Igor Russkikh <irusskikh@marvell.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Dmitry Bezrukov <dbezrukov@marvell.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@oss.nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
 <20230920092237.121033-4-radu-nicolae.pirea@oss.nxp.com>
 <ZQxdLZJa0EpnxpCl@hog> <040a3ede-22f7-bed4-0dbf-10b68a9c7fe1@oss.nxp.com>
 <f8d79f01-38d6-9385-f213-b34779b8bb54@marvell.com>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <f8d79f01-38d6-9385-f213-b34779b8bb54@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c164182-c5f7-4356-8167-08dbbf55e5c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97k3R8XCIlY267Mthv0yHr7Gd4gZ4hr8Stmc5d7n37mfMr25etPgYTtj3ywlXsn8lzYtBvaEQknWPsO0ytLv5GPXm0OUU1R2zIHe1DwoCqJch5q5+fBqBUZ5kRGoKBvKjjjxQqpO37SvGjrVdt4Tyvhkail0Vhm0Hi4opDXqab5WQUhsk64S4UPMgP0iNj7h2Pf39BDvfKzkETrnon8FA1UJI45SAvvC1H5W+g4r/4QNjJPL3+oY7n3G6Rf8opgpBxGoQiXX4SP2lxUIotAif/JcCPrsZY8siHPkBlvgLODJILh7mDUFwyDoVnHwF+TyQqhqWlA83SKM7JbNruv3kWEPKs9KTpfo2DREXM1IrkfHWipSZd/qNtQPERlditzhT5UcWk0RMEyp1zrgZpO2qkzPm/xEPXvGJqyQ23J/NgY6mI8W1kl9J96MysJ7szbPoKr3jjc+KU6/Wt0Gfupbgi8dYdxYk8EY4umH3LB2LQ5c5wO+tYvnGZsqygPCuD3Tkz0VqQeFh8JkzCHuqRBHb0U6muWTMQLVLEQcGmv2sJTWL0C/GGpC7jvbsLPuRBZohPqGeIxVeEeAoe6CY7zjcQSTSVtAG54D+f3LbUHjRgOk3XMZ/S6+eeajAJ/MssCQ+nMdyPk5b30n2SenPTbVrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(2616005)(6506007)(6486002)(26005)(53546011)(6512007)(31696002)(38100700002)(86362001)(4326008)(83380400001)(8936002)(316002)(8676002)(41300700001)(66556008)(66476007)(66946007)(5660300002)(110136005)(2906002)(15650500001)(31686004)(7416002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZOem5QemphSVZ3eVdMWGtCM3paWlVFcmtRWFkxWVg3Yjh2bHFCRWc4a0x3?=
 =?utf-8?B?NmV5MCtJZTltME9EeW9ncFFTYTFWZXVPak54VWsvdVBQZTlQTkdJcUhaMTlR?=
 =?utf-8?B?dFFVbEt1NE5RUjNmUWZVbFdVZmFIaWFqOVRaWXBTTlRuOEFVMGdueFJ5UW1u?=
 =?utf-8?B?Tm1SMFhBcnhjSmMzL3hMZDEzYVpXdlJSd29iSVZHYXFlcXg2SXpOa3lBaVdn?=
 =?utf-8?B?UmdyWU1lOUFnWllwc2tJVDFFMXcxY3hzZ3NIZEJsQ1drenNOazd2bUxuUS81?=
 =?utf-8?B?MDZQeTdVN0hEbkszbEZ1MXJQc3J2WkwreXlVV0VjQW13S0JROHR4L1BYb1A0?=
 =?utf-8?B?cTAzWi83MEhqNkN1M0ZiZVhwS21PN3VtazdWcHZDVHpwOC90UzQ1cWFrVGxk?=
 =?utf-8?B?LzBrbkhFeWdnYkNmWUY3WDJHT1hobndTb1l3S29yZlczMVkveldTSmN2UTVn?=
 =?utf-8?B?bEhVT0dIaUhlKzhTNG9uQ2ZRMGVJbFNwN01NY1R0dElHTmRuc0hESkg1bmVD?=
 =?utf-8?B?ejEzY3A4UWJTSldzbExobVRlTlQ0a0J0QjVyNFR0ZmJLd1k0ZUVxaXd4Wk1I?=
 =?utf-8?B?clY0Tlo0cFUwVms1RnNQVlR4ZjVqMXVPMVZLSncrUHN5Wm5neUtlRm4wSnV5?=
 =?utf-8?B?Wm1LUGwyM1RHQkpBeTgreitpZVV2cnEvUnJpL3Mxa1lKOGRQVmdGNkRRTmRV?=
 =?utf-8?B?dTNPMGsrY2hPc2RpMm1iTHRTbHRNaWZESU4rY2xKTk1UeGxkUzhXWDVUKzFT?=
 =?utf-8?B?S0l6MmV4Y0lWeUcrbTh2VjU5OTk4MkFuNmp6UW5RenlOVDBMcTRHblRqQnVo?=
 =?utf-8?B?ekhRQ2JvenVYcFpZTjVUOXFhQW96Z2VMbTZhZHlnNTBqam8yU2ZoU09zeURO?=
 =?utf-8?B?eG5wT3F1K0dmMllvS2hneUdqT2wzTzB6My9pdzVpcU1nODNCaER6OWYvRThI?=
 =?utf-8?B?U01ablcyVHlMQ2RpTGs3NzBhQXdXalJUeVlVQlVYYmhiK0NQS0E3ckhiWVFT?=
 =?utf-8?B?dWZTMC9MUEQ3cjhJYjZDNUhMNGtxdlRNVDdBOHN4b01INmN3WmFmQVNabGFk?=
 =?utf-8?B?bWxqdlVwQTRHTWFuK2FRL0N2OXRrZDVwSzJMS1g1SjZuVi9Qck5TSGxKenAx?=
 =?utf-8?B?bG5EcThRaGNkU3QxajJkOU5nSXovOVJjdWxiS0FZSGM2TW1UN2ZDbm5VaGhE?=
 =?utf-8?B?ZDcrVTl5WE1ZNDdlczZkNzVXQnUzQ2dSMGx6bmYvUFFNakhoVHdudDZHQ1dJ?=
 =?utf-8?B?YmJHNFpxZ0c1MFF3ZXFDdXhUSHZqWWJXNHQrVzBGUmdmdUhzc28rU3NyMjBC?=
 =?utf-8?B?YzRGVjRLTTJMUkZsZzVCWndoNGs4Z3kxNE1GTnNiSjZLUzQ2SnlHeCsxNjdi?=
 =?utf-8?B?b3MyNXNFRFNXK004QVMxejYra0owL3diQ1puWGp2MUtXZ1o2ODVMWUh3U29w?=
 =?utf-8?B?UnhFVmpoT0tVYWxIMy9RejdTaktZRERZYnZoZ0RCdmZtRjcxZi9NZktUNFFv?=
 =?utf-8?B?WlZPVWF4NExvRGVlOERGaDNiK0F1Tzk4VE12NThWWFNnSDlMTFg3LytVZktw?=
 =?utf-8?B?WjBOeFlueE04WGFoL01jc3NDek9WL0hFV3p1WHR6WjZXdkpiZkJXNDZvRlow?=
 =?utf-8?B?QkE2YTF5ZHdOc0NwUGlwbHlHZVUwR3VCcnNtZFJoNm1sOWtxb0JkT3ZVR0lL?=
 =?utf-8?B?WWo4OS9uZmk5dnh2dXVUYzY4aE5BZ3MxTkU3N01LUzBUNXU3YVJiWjlwM2M4?=
 =?utf-8?B?eVFRV0kvS3ZSRFZBcVhMcGV4dE5WaHRPNUdEWDJBK3h5WmdMbFkrdlRlcmYv?=
 =?utf-8?B?Y20rMm5qV2hKUUtMblpGRE9FYWpVbGg3cjBiMjBRUFFZUEtURlVNWFIrWlNJ?=
 =?utf-8?B?QkVnQjZQMGJRWXdiM09tU3NLbG5aT0RuNk9MMXNOUndLQWFLL1lUbUY0NW5a?=
 =?utf-8?B?UTMxM1RoeG5uTHh0dGVRZXJrMGtIUXNtTkRpeWl5MXZGbVhFRERYZHNDZi8w?=
 =?utf-8?B?QzRZbzJKRHlrSTRRVFZxMWpkMjhzS1NIMDVTcXh6TXRpbVY2SWl6dGNiSDY4?=
 =?utf-8?B?Q1p2VG9UNHpQYUJrRlZ0U2RzRjdkVEs0MVQrMmIvL2xOWEcrT0d4QzJvZlFT?=
 =?utf-8?B?VE5EenhiNFdvV1U3d2hQbEE0T1dQREFzdHJrU0l0V3BlKzFNVW5ZVVk3c0lV?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c164182-c5f7-4356-8167-08dbbf55e5c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:33:05.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaH8PEs783Gv52WkM/qHYc9nGL4Vgx/lPlu5lpSqJMq0W7uMVjyJ9ctfDPBOFVhsWLvzMRbIBOLhvtgyky6nSLoQTt410y+iEMQCeXrvFR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.09.2023 15:16, Igor Russkikh wrote:
> Hi guys,
> 
>> On 21.09.2023 18:11, Sabrina Dubroca wrote:
>>> 2023-09-20, 12:22:33 +0300, Radu Pirea (NXP OSS) wrote:
>>>> Indicate next PN update using update_pn flag in macsec_context.
>>>> Offloaded MACsec implementations does not know whether or not the
>>>> MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
>>>> that next PN should always updated, but this is not always true.
>>>
>>> This should probably go through net so that we can fix some drivers
>>> that are currently doing the wrong thing. octeontx2 should be
>>> fixable. atlantic looks like it would reset the PN to whatever was
>>> read during the last dump, and it's unclear if that can be fixed
>>> (AFAIU set_egress_sa_record writes the whole config at once).  mscc
> 
> Thats correct, atlantic hardware requires full table to be in data buffer registers.
> I really doubt its possible to skip PN writing.
> 
>>> doesn't seem to modify the PN (even if requested -- should it should
>>> reject the update), and mlx5 doesn't allow PN update (by storing the
>>> initial value of next_pn on SA creation).
>>
>> I updated octeontx2, mssc and mlx5. Atlantic is unclear.
>>
>> Mark, Igor, in the atlantic MACsec driver, can the SAs be updated
>> without a PN update?
> 
> Reviewed the code and the docs I have - my view is it can not.
> All the packed record in macsec_api.c:set_egress_sa_record is expected by hardware in full.

Ok. I will not touch atlantic.

-- 
Radu P.
