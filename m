Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0878B235
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjH1Nqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjH1NqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:46:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D391;
        Mon, 28 Aug 2023 06:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIfKmIFLdO5b9L4F6hqo20yatwWVVW0hSspdlh+ZWGwGt1zT8Gxmr/tt/l5yqhkIBqu1UvfDtttsqXbJjNNNOIDhbnanG7mQspxwQXOw4TUBb6j9jzaxj7OhkpoowpIuhV9mKioUvzA9fNCX26wN2B6qTHJGHA+oNt4wbGV9oMNZRs7zLb5TTFsxcCJ7gRJPJ0m6K8Wvrq8bIizyTbQ42zpdoQchq6CeTHKiU6TIA8tuw3vvFatGsWrqpfqfQzksxC19ERaMLRpmGm5VpBvMxTqSEjKCIPyoIzFqAmk65uafA72vUDLdcAhrdScGlwt2dzKN5E9DZArCoIXIawT1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8o1u+3DEcnTXGyjFF1mvOHn2Ne98C++00Dc5QFk5po=;
 b=bgj6NgFVRHnB5N/4UMKU5YixIjiIAc0MFP43+iSmaGouXxCAmu+iG7R64ActdUnG07DI97OOlziRQ9Z2fv5RMhAtZIgR3KbdnTY6JrK2E1WslxdHst95shFL5YKM6Yq3n+uEwk/3SKJFic63Ne5d5kOafssjfjgua+vhJ9Vo3MRTxP7tNrcGR3dZyK7NqCThvhnVWMkwboXjP2WGfx2v5rqDXLI42r07WTCfwD5kMmAhi4p3Krdc5U4X7k1pUqBr/AXBVLeVql4fk37nC+m25wiLemG2bntWQBA5W4mj/QVfWiylz59ex1kmUsHDNuf8zegj9rkY6lWL9ebfk7lkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8o1u+3DEcnTXGyjFF1mvOHn2Ne98C++00Dc5QFk5po=;
 b=V55SGFWtpAvdEqnTvdj28ngeFH+bJpVQqMJe0mKmvoVn8nhgufKNu68eb8iG+hY81OMnuziX5lSRH8mAnEFbIUaNJ1wzja84Ze3JUB+ItcLPcXWkIDUl2xTOVrsyYmU7v14GwrGD4II/L2ClHslLfUo4vpyTpE1a9SAlz5R8F3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB8656.eurprd04.prod.outlook.com (2603:10a6:102:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:46:15 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:46:15 +0000
Message-ID: <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
Date:   Mon, 28 Aug 2023 16:46:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Content-Language: en-US
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
In-Reply-To: <ZOx0L722xg5-J_he@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::15) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: c9533cc7-3d52-433b-5bdd-08dba7cd25a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gMo/nnAarupKtujNQ9FBynZV963EjeSzQt3H35Jz9RbiKuMK2fpVftX+uRpjnNsvsVMUyLtph/DM2sOt3iPCgHgRpGjP/oBRSRRq3GWkj//1Eylnd0JQfBoKsnTu3nllk4MaZc1hkRHFTzEzm7iNfVH2hNoNBjbvcAHAq9UNzyieBsT74s+W99vxtpUG9l/lOTpxQb4dvTrBWzBPRybKcv42db6SYnXBZmoRh42FIqv+/fwasT8sT5QOSMW9dBR4mcSOqWqFPnAUG/ZREgenfTXP1r682x1fKjSCv7z3qLTk8ox7q/3VcVKG5/jaoFqKoWnhMfOSpSV3g+08voEcPuQMQQ3aaEw8kBREmTWtPgGnTmkCYSFEXpC5CokI6MXZdVZbvIc3K91CMeu4lIG45sHQCkuYJB3Jw4RNv7QK3tcMIol0F57CzwNXtQ4+jUlLtylCMJ4zZV8P7B70hR6L2emmZZHHafB5bVe03NRjyS1I1OXNw5seSUdZmAw8OEWQvTnidUtjCksCP1E7A4a4RZdlsAW2mNOYF/e6l4lcBnF0w81MkXxmZ4QlwsThA5POYAqx4VzRzEjs8l1X+2VPqPY9h7m2hnRiH6QF/21gICoXkDEsI9nf+3bOSh/5qBXyqOa9YRgBTUU/jDTMOecgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6506007)(6486002)(86362001)(31696002)(26005)(2616005)(83380400001)(6512007)(7416002)(316002)(6916009)(5660300002)(53546011)(66946007)(66556008)(38100700002)(66476007)(41300700001)(31686004)(2906002)(478600001)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG8yMStJcnplVGVsZUQ2NlYyeW0vYTRTaTFPL0JwQmVVNGJvc2ZMSVQvZWpx?=
 =?utf-8?B?YnQvT0ZpY2hIYjlzTnRaSHhRVkpjMUNjdDNQY2pHNnY3Z1Q3bVgyYW9tdjRo?=
 =?utf-8?B?K1krQVRzeXJjVEpsanFJcC9WK0NSV2kwNUdvdUlNZjlIV1RLZGxaVDFSc0Z4?=
 =?utf-8?B?Zkd6aWhqUEgzRmN1Z2d2eDBteDJJTld4cEhTZzhxUXZ0ZzZNdC9pRWR3aThE?=
 =?utf-8?B?aEJ2VmRmVVNka0R5ajJDd1VxVUlyWnY0MHUveG9xbUdGVlFtY0p2NEFrY0Yx?=
 =?utf-8?B?dXByT3QrRjZOdkUrVUhGaWZmbU0zWnJtb0lFdEtMQ0ZuQ0JWWlN5VDFwNkFC?=
 =?utf-8?B?T0lmajNicGlndDdzM0g0RWFNY3NnWm8vL3JXdUZBQlJ0d1VHdEhIZWpCSHZT?=
 =?utf-8?B?TEJJbVdMTlpMYU56NzNQV01abEVRZjJ6TFQrdTdXNWpYVy9peEZtN3FwTERz?=
 =?utf-8?B?NE8zTzVxUUFwZlNPUU9tSUxqNFplVm56cTVnM2NiZ01rY01sa25yZnlMN3Fa?=
 =?utf-8?B?WjB0THZ3QTViYW50Vjd0b0dJS3pEdkpuQTZpUkM4aTVyZEZIcEZaQXBOSjE0?=
 =?utf-8?B?V1AybE9Vcm1OTEJiZ05YdVM5aWRlL3pSU0VFSHZCQ0pNcmViOW9zZEViUmUy?=
 =?utf-8?B?aXdFZHduVG1WS2M3TjBZaXZEbzNRSXVHR0hLRTVnYkFmZWJObFlNMVljVHkz?=
 =?utf-8?B?andRSmsyU29CaFQzRDJXZUxFNkpaSFdpM0gzdlArc0s1OVdUVVo3YmNuSTNs?=
 =?utf-8?B?cFZNNVRTRTQxc25vOXIxcFBYSVpoTThXSmtUQ0xzbVpudjZIdHRwN2VXVGYx?=
 =?utf-8?B?clJVaWdJRnUyT0VFSTRxNUZKOWRJb1hBMHk2eWVweUE3OHFHOTFMRThsRjUr?=
 =?utf-8?B?QzVLeXJ4Q05GUnVEc0JBK2RiTXozWnE3VitvdnlORHJSYVozR01SbE9MV3pK?=
 =?utf-8?B?VU82UFo2MGFHOEZkanE5VnpuanNSTk1UeXhjVTh2bS9rbkhCNDVSSVpaVlRw?=
 =?utf-8?B?QmVBS2d1anM3UXlPNjdUSFVvU3ZkcGlqcUtXdzhxM3lUdTdwRkk1dVNSZTY4?=
 =?utf-8?B?ZUJ5ZW5ZM1BjVndsR2NrcVBlOVQwZ3pXNnV2YmdkVzZQRlgzZ0g2Y2hwMGl5?=
 =?utf-8?B?YzFYNnVRTnhuUjF5V3lVNkNnOThsbzY5V0piaXVaMDkxZGxSSEZxOUZsZDA1?=
 =?utf-8?B?NDZMM2QxOWZJTy9FZkIzWDlkcUFxbHE4WGw0VnJza2JYQ1VWazUzTTh2WWNP?=
 =?utf-8?B?ZnJVNUZlcGE5dlljMXV6Wll2VzFOUFZnaXlPL2J6WTBrN3pwczVBYzFtdjB6?=
 =?utf-8?B?eHcvc3E1bmdCcFQ2RG9aYUU5L09nZGtUOVRJRGkybEp0NmRCbUZyOG9UWjV4?=
 =?utf-8?B?U1Z3YzJtcHpKS3k0clBUY2JMMjZzeWNmZXVGVDhFR2dDMCsxTGFQeEFNYlVK?=
 =?utf-8?B?MXVLRk1KTzFJWldMU1hWcjNWN3U1dDNwc2lEVWw0dExkdEVBeFdtTHRkcWpm?=
 =?utf-8?B?NXEyR3E3RDJybVVGWHN5dnM5VjAvdk5MRGNqTW1qa0FSZFpGOUQ1RFh5ZHox?=
 =?utf-8?B?TFlZZkUzT0RLSEJaRUVMTUdJcjBTYWF1OUVzZjhmdDBoeW81bHROQzJna3ZK?=
 =?utf-8?B?QnA4VktKNWE4SFpwYk5lakVkaG1Sa3RtQTgyQTRpMmU1cHVOUGZnc2NyMFFq?=
 =?utf-8?B?emN6SUh5eDBMZ0hxUjZWZCtqTHowZUJEcDRPRC96KzNoaFVVd1loaEhFYUY3?=
 =?utf-8?B?SGtWRnY3N2xpaTdxSXpxVnpUTXQxQmVPVGc4OGprVEo1RVhCTGx3RCtmYWJT?=
 =?utf-8?B?VkluR3dUdGVPZjVWaHdKdlN2MzM3OVE0b0tjbGNJdDFmbDRIdVoxbVJ3Z1RJ?=
 =?utf-8?B?QTJmUHpubEcxSXM1YVlWSy9qSzNjTWt4TVl0WFRLRzd6aE55QndQa0lwanZr?=
 =?utf-8?B?U1kvOThYL1UzT1lpN3NZTDU4ckd3SWRqdElObmFpSlJPajZtSEFWSlpxSVR0?=
 =?utf-8?B?a0t6Y3hqakFCUm1XOEVUYk0vdFhteGtsNkQ1eEQwbTZvNmVxeWFGcFdJRjBx?=
 =?utf-8?B?TjRVNXlrbitnVkZtNTVuYi9CU3hTUUV1S1RZU25xNlJuNS9INCtYd3hpUm96?=
 =?utf-8?B?Q2ZqMDl5ODRGZmtJc1Fsck5hcDNzVEFnalVxRUpZTUNvcnNTcmhZeHVxdXNY?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9533cc7-3d52-433b-5bdd-08dba7cd25a2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:46:15.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANfHbHHxx8q2r1dXd2Q8+n2O9MWvfx6M4A/Xim5fHy8hclUd2gLkNOcky2UHFNhSq/hmgg19+lbWS/zQUDK4eCUF1e7wnL4dnBfWQ0kliZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8656
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.08.2023 13:17, Sabrina Dubroca wrote:
> 2023-08-24, 12:16:15 +0300, Radu Pirea (NXP OSS) wrote:
>> Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
>> frame.
>>
>> If extscs parameter is set to 1, then the TLV header will contain the
>> TX SC that will be used to encrypt the frame, otherwise the TX SC will
>> be selected using the MAC source address.
> 
> In which case would a user choose not to use the SCI? Using the MAC
> address is probably fine in basic setups, but having to fiddle with a
> module parameter (so unloading and reloading the module, which means
> losing network connectivity) to make things work when the setup
> evolves is really not convenient.
> 
> Is there a drawback to always using the SCI?
> 

I see your concern. If the PHY driver is reloaded, then the offloaded 
MACsec configuration will vanish from the hardware. Actually, just a 
call to phy_disconnect is enough to break an offloaded MACsec iface and 
can be achieved by:
ip link set eth0 down && ip link set eth0 up

The only drawback is related to the PTP frames encryption. Due to 
hardware limitations, PHY timestamping + MACsec will not work if the 
custom header is inserted. The only way to get this work is by using the 
MAC SA selection and running PTP on the real netdev.


-- 
Radu P.
