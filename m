Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E128A755B00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGQFwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGQFwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:52:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A9E43;
        Sun, 16 Jul 2023 22:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e72QpklLlf+OqxdPTizjvomxJ/ltFEqpMWNauebMPv5BK3dpgV8+/6hVIa4roI9cRrsHCsfYoo+bkFuC8YioI1Pv8guZJ+zqv3gpQcvSSZ/7vefjU3a87szar9M9WXSdp2iESbsun9SBT3jYNZqCJPayBWYmnk2GMWo29Fy9Y69uFFgbjHUvVdiPyj0RMNKXrD0ZgBhSbBPs+JYlej4O77ufdwiP42eLY2QmnanKSVOAh/bN4XIcaSIgLj6bBSS+LfwuOpSjzCoQjemuZgWsinl0/PbDQ5H1m6gZzcWSTyWV08G33O72NE2/vuoS0bdChIbLkwQrcGWQsAUnPr6mAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53ENTW7IOiRjbllD+YZ/ZHt3ooDc8d/OQNuLOa9xGao=;
 b=bGhZDL6cwiD2A1CInkxXf1Ub0tKIu79g4F/K3/pI3ieC+t858s7Y3jopXQGERgasuysZ3akcqcLOxiAVXFzErayeYBhImAkDgalwxFT5qe0u92Grz/ifS6cz+HZA/UMR9E6c2+MZpwNgNXU+3vLsI6yvvuOxxNCDenxjU0TW/GRFtpa12sGSBTDVbblvRnaPOM5QQL0Z1Ftq9FWIxo9TAGseGoxVARM+XteNADJ12QUn6/5tGeHJgXVHzwo/qq4JzvyCHoxKat/CifiJwqdlDfZ5B1vCwzZr3FIY/HMXL6j3HsEWhywfy/7XjSesg4FJHb1topJIOieyha4+W37IYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53ENTW7IOiRjbllD+YZ/ZHt3ooDc8d/OQNuLOa9xGao=;
 b=diDkfzOYbusU0Df7XQ33003A1Q4KQz+TRhvpp24nunwpQ3HtRuluSyzxUG0FyW3qYN46CdRBfeZosYwxq8dfUu/OZGpS8cbL4NHjlaHSY9RacK7nwctjL85i70k1etOqvbgj9NKECSdIGOIp6VncGoC7BNFHqWsnlTO9XgmWWNdX8tH4hWoQXeILoYZmBZ22z3RN+ZSY9bmGNnsWLgTfqL1O1/ckEwi0kQR2+X3tNzSm5FUr+3sJYaSNWTGjI3L05ToS/PVgPPSXETxbsg5f9WwpOoJyH7NSEwCNnLQvM6gh+VtzZuuTLr2A2VLlY0yM8KOSRTvJ3769RoB8ifUS5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PAXPR04MB9595.eurprd04.prod.outlook.com (2603:10a6:102:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 05:52:01 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:52:01 +0000
Date:   Mon, 17 Jul 2023 13:51:50 +0800
From:   joeyli <jlee@suse.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chun-Yi Lee <joeyli.kernel@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Bluetooth: hci_event: Ignore NULL link key in
 hci_link_key_notify_evt()
Message-ID: <20230717055150.GO5866@linux-l9pv.suse>
References: <20230714161210.20969-1-jlee@suse.com>
 <8eeb958e-d947-2f6d-5942-d30746cf1268@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eeb958e-d947-2f6d-5942-d30746cf1268@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:404:56::36) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PAXPR04MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b740c5-17f6-4692-dd36-08db8689f0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsxUuJWWgE4HuXadZ4nf8+oGjPdrerhBq+tmPXqoU3jtSnAqzwdaG2aYPhwqi6GQcM8ZOJIQ+jMIYXv6VD8u3TDkORXkH7nneXLFf4pB+rOOiSKP7G6wHZT2lN40/MaVoBlOy+XSAnSBKyb7NHrTyQ2qZkGyX3xIxeRgVQtyQCz3KE5XPeNdkfKTsBz6mRgg0dam6mpdmX0ZsXYFoW5mutWNZMFYyojLtqiIMpLYfHFSsS+EnWTgrSpgzjvdnHi6QCNc6zsfZ3Vzbe+ulqm+5llqkVUKJIycsPna5AI0Fs6OkbzN39YTrS0SeB6BXTUHU48BX315AA2lv2hrXkhPQLOscB7J5SEffIe2daxKGHP+HgXMaGMvg25GTpq0eYotvXT8Q9oBe3ELqitCRfkd0aa79hNlfUMX/3otglqoLeJcYhFFdOG1OGnW6P79fzn7nGfxrLbGqg8hlWYqQuYxSy8DyGMSU+TxmHwGR7w7TJ2aCABaV8UizUfkSBPk3oq+L7wbQgnM+HcDB36MTueedKbhxpg3c0+riu66Lvas5A3j5S9IjXUMMYYFeV2KnArEzJGz9PCdd4/5/SUWD2oPSN9yL7yqlnBOrro23ZUn8+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(2906002)(38100700002)(6512007)(9686003)(966005)(83380400001)(186003)(26005)(1076003)(6506007)(5660300002)(86362001)(33656002)(8936002)(36756003)(8676002)(4744005)(478600001)(54906003)(6486002)(6666004)(316002)(41300700001)(4326008)(6916009)(66476007)(66556008)(66946007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjgxQjhrZ2xIVkI3WVRHMWh2SkRQN2xKZkswNTRhTVlwelUzdWVoblJiVW01?=
 =?utf-8?B?aDRYK3B3MFJRNTZFR0xvUTdNMnBrcjNKZW56dEswOFZmMnJoeHBKUUxBL3lB?=
 =?utf-8?B?K0p4d3BCcllIeE1qYmZMYTQ4bzg0MG0rSTZlSHBGYUdkdjE1R1pDOGVZakll?=
 =?utf-8?B?em5ON3JwbzVnQ2M3eDh4dXpmZ2ZhdUdGR0tKRy81UEJIS0FZKzBYRmFwRlVm?=
 =?utf-8?B?bzBWN0dVckczWFYwWjV1am43OFdRMnJFZDMxU1h2WHBocEtwM2VwOTNxQXJ1?=
 =?utf-8?B?a2lzdFd1cWhPMEtaMktkdWZuZk5ONHhKYWNkaDFRd1NpVUdmekNKV01BUmlk?=
 =?utf-8?B?VUtYc2dyb1JWa0UxdU9UTlM3K1VKM0dLTE03ak9wTUZVSzAvb2Jwd0xHWmpt?=
 =?utf-8?B?SnVIK0tUQkwxN0ozbUhuV3hNV3lKWG9Va2hiOENscFdMNFRDMnJUYkE4aWpU?=
 =?utf-8?B?VnMyRFZ4RnhOY3NiZkYyNmtjYjRQc0xIK0VOV1c5Y0tDcjh1ek9PR1grS1hl?=
 =?utf-8?B?SU9GK0JQNzRjcG5LdE1pZVpwdE9rV1M4Z3NTUktQektTdVUzL1RYMlVUb09z?=
 =?utf-8?B?ZUZQay9DcVpGV2NEeW1EaGxUWDg4cnZaNzF2MGkvelF0bkdacnF5UlFXeGFQ?=
 =?utf-8?B?SFVua3EyUlkxUUdvVDhYNU5QcjZEOFQyWlNUeFJ0b2Rqa1AwN1lld3NOVGJF?=
 =?utf-8?B?NzNZNTcxU2JsOFRqUDJLUXpBVnVTR1ZUUzhRMll4MjNPemVrR2FCZzJRRHpN?=
 =?utf-8?B?TngyOHRNR09KcXI1R0FOYTlwZ1pXZjBzOTkxYUFqUGI1VTJRN1RpNFA1VnJR?=
 =?utf-8?B?bzJoV21MNHB6UlF3T3F1WEJuL3Y2RjBUdnhSaFFseTNRdXZsdjdVSFg4VC9j?=
 =?utf-8?B?KyswQVlPTVRGUi9pNGtuTVY1dW1la3RIWlQ5RnVVdCtPdFd4TFVqaTI0NHoy?=
 =?utf-8?B?TGNGbWZjQUUyOEdRRUludEllL2dySTRGdEF6eHhlNURsa1psVTdnUEc0djVX?=
 =?utf-8?B?b0FEekZZcVZ1a29QOEJ3OE9BbkZQeGxqQnFyZTFxWFZkMUVKUVErMXprTS90?=
 =?utf-8?B?b0lIZzRCRW8vTVhkNjFmMHB3NDduc3JQMTJCWVpsdVl0L2dWcnFBdDRkUURa?=
 =?utf-8?B?Rk5MRENXR25IQ0ZFMVI2aExjYjE3cEVsakRKK01FdU5XNnA1MjhvSnU1YnJu?=
 =?utf-8?B?bVZGTmt0NTlUdW1JdWJxOVBEdjgwMFNBejdFM253TDlYRDNEd05aT2laK3do?=
 =?utf-8?B?SDJEajUxWXlkaU5kVWhFcUEwQ3R2bDNRQTRKRFBZVkpoak1lRG5kdkd1UjN0?=
 =?utf-8?B?UWpIdGtoaEVLS2pwMkExRzNzS2hmenp0QXVMeXdvVFBhTWdVdTNOL2Vrc0g0?=
 =?utf-8?B?VDNpQW5HZ2s5WFFMUUpFZUpmdHkvS2d1dGFXV0t6enVrckNjVE1rOXV2TGdy?=
 =?utf-8?B?L3BZMC9HTENSK3B0ZDVEa2pZcC9CRDY2QzhaWEk3WnArRXo1azR6eDdVT2du?=
 =?utf-8?B?VTd5bWtGclY0SGwraGVPelJEYncwc0JmN1lhQmVpa3JobU9tNVZ2UVhvNTFr?=
 =?utf-8?B?SXNmVUpMTk5VMXBzRFhnUGhIZGxsR240Y29Fa3docDFXcGpCWHVuZVBpN3dj?=
 =?utf-8?B?elE5R2lNQ0kyM2FVSXN3YmdRUHRkdUR3T2dlYkNwbnViSGNPWDhlbTVkTFMw?=
 =?utf-8?B?YXU2a1NCT3J4MGE5Z1ZZanRtSzk1dFlEdDRNOG5xeWtxRlpnQ1VyajZFQzhL?=
 =?utf-8?B?NTNDaEtNNE9XTWs1K0UzYmJtVVNpWGwwU3NTSk9uZlpJTDlLQ2Z3aVM0SndM?=
 =?utf-8?B?c3hvT29TRmI3TTNuMnV5QjZZa3NYZlBqNkx1UWNZaVEvU0Jxdzk3djU0N2d0?=
 =?utf-8?B?TkJQeFpjdFA4YmZCRURjd0p3aW45QU4yQUwrRXlRdTlkYUFmL0RnVjhRVWxP?=
 =?utf-8?B?SHVGYlEwVTVtQ083aVZVRW5kN0JGR0h5ZWFzUWRBWktTNzhGSS95dnBoUzFU?=
 =?utf-8?B?WVB3cEtpbUFoWWVMTGYveUdSOFhPZjY4TnhOYkRKbC9COEJIeGVrenZEamVq?=
 =?utf-8?B?OTAxekRVczVtR3ZpVTBNRWtBZDQ2dWVhWnBkQjd4VXJSMlFLV0JLcSs2bTc3?=
 =?utf-8?Q?RA7E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b740c5-17f6-4692-dd36-08db8689f0ff
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 05:52:01.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSuLLCVwMC3GyzRtiLrKFVnZAGKPRkPWClf04N+7n5UZ4iU7FciMEzA/8fEYMYw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9595
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thanks for your review!

On Fri, Jul 14, 2023 at 10:30:17PM +0200, Markus Elfring wrote:
> …
> > We can ignore null link key in the handler of "Link Key Notification
> > event" to relieve the attack. …
> 
> Are imperative change descriptions still preferred?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94
> 
> 
> How do you think about to add the tag “Fixes” because of
> an added case distinction?
>

Sorry for I didn't capture your point. The "Link Key Notification event" 
is a term in bluetooth-core spec. What should I change in my patch
description?

Thanks a lot!
Joey Le
