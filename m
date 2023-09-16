Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC57A3339
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjIPWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIPWUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:20:55 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2102.outbound.protection.outlook.com [40.107.247.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D4C1BF;
        Sat, 16 Sep 2023 15:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLviDRwASAENPp2xnqTuuODlcfmFRyrjt2bPZiQMbad8zTKnhTtXHntRM2tpcQIqfEpEqjtURj8bCLHhm8z8ClFZ7t6kYBB76BnXYQF3AIfg6M8is21hZZBFhZA5BGt7DwfCLyqOs/k6kE2Rws+nT9pB3HVf4JJxdvVta0/54fHD7np7s74ydd5LgV28NDjwtYrxLCbU+KoGH2hBMaIVILt9lHVTQlbFv6AKnr02Woa2gj0ioTlaZFRJ8eDIjNUa6Eu35QVc3Sxm31P56LeCXvMEXaSu7CN7S5/vo1gHhcUr/cFqraCpwsRvL/qwZXYgYxNSFMZIgoGT4zNEgkdDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjloVZIP/s+fe9Z2CXwLSgW8kydhhQr0k/4sCN/Tzos=;
 b=I+l04U/fn1L+K9eLoSpcN1uzhP57MTiTiEjfjr/rUSxKNefh+BSHgjXCUq7NpSZn1VQDlcO8+NhazPj7dFQKbBkV3DZo8/FSwACbXnXHe7ixOVbful0Gv9pN2cP+85too6XIzxuTkqgpFrXtvRodwXyZ2Dly/1nuyss9vze/yImp5FgGvdLt/xIGk+xA8o8D7jPHSOabHoEDHQMz6McU8rxzXgP3Sk0UN7NIyiNauXQnrhc/9wNzWNmiGPMzjA3O/mJMqDa0Sl2DgmhowfoLo63xSOc1LHqeKSrThXzB8Aj7H0p6iFAHHHzhysBOzt31W6AuBSkU45B98bD7V/Paqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjloVZIP/s+fe9Z2CXwLSgW8kydhhQr0k/4sCN/Tzos=;
 b=oPjhzpW0m+wgTeXlale4vz1LWqxyEtZjZ86JRQY/RbBg7jKZoE/B+plJl554EJlhjoXu08rxLSfp4IC4y0vIT9gUBoc9vgE/zmmyIoUPbaRAnDIEH03VY0hbw+XWKYa185TRZNyE97R3iI9yBUeJAnVey2yx6TLj/2fCkWIz/FMqUL/yZmy7CfRKvoPgE+c8RHozc9HvOFkW/TpI3PHw2N/cq1At0lhqVxS+WSQdu7MT+nzQ2rr6OKaUd8dgcoi9cXoMYAQhn38ORF80u01TWANcaUKeDnrzrSCY37Qg6ogiMY1BcOqSdzVM+mZ2ffdPSxZO7uUNquemxSZBTcsoLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3298.eurprd08.prod.outlook.com (2603:10a6:208:5e::31)
 by DB9PR08MB7606.eurprd08.prod.outlook.com (2603:10a6:10:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sat, 16 Sep
 2023 22:20:45 +0000
Received: from AM0PR08MB3298.eurprd08.prod.outlook.com
 ([fe80::7ca3:ff75:8b46:deb9]) by AM0PR08MB3298.eurprd08.prod.outlook.com
 ([fe80::7ca3:ff75:8b46:deb9%6]) with mapi id 15.20.6792.024; Sat, 16 Sep 2023
 22:20:45 +0000
Message-ID: <40eecbdf-40d4-0fa2-6718-3875ed852104@virtuozzo.com>
Date:   Sun, 17 Sep 2023 01:20:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc:     Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <1694366957@msgid.manchmal.in-ulm.de> <ZQWUzwiKWLk79qbp@debian.me>
 <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
 <CAHk-=wjrEjaUw3oFVEYpF=AWAwrSM3sQTQHuPfFjFdQsvQxHeg@mail.gmail.com>
Content-Language: ru-RU, en-US
From:   Michael Labiuk <michael.labiuk@virtuozzo.com>
In-Reply-To: <CAHk-=wjrEjaUw3oFVEYpF=AWAwrSM3sQTQHuPfFjFdQsvQxHeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0033.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::22) To AM0PR08MB3298.eurprd08.prod.outlook.com
 (2603:10a6:208:5e::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB3298:EE_|DB9PR08MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1e7a87-7639-4136-053d-08dbb7032b90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9frdjV4Ay6yOc9i6J0eZ9O47cgd5fdEDxe1ruFvyKjISwZ0Z++MgvyfpoEM7G8plFNt+fJOCXUsrHaprv16KYfW78o40eKpnbMR2Fx1ezYtdZmNdc9iLS8I64JDoVRIJAiZF4jMlXgPoeSOJpgL/QYAn6myiMcAOtg22K5qqqisg8IjvNG4/OvXu03d+y9TP11+8fQqDnoVE99RibaRFzCdsho6xj1BNs4klRJQ8+1vNuqd3duxzghXRl+roan1WlyhE4O8gN/KK76exiR8DnGw+Pz8vhOgSmUsTI+JaPOnr2Fhy3BVbuu/U7MjD+elElZiE8BR6VSrWsPYxd6B0ywsrir5p0wO3OR9KaVip7URuZlrnL8cXhGXwxRi3ptkUalft1iV0frjr4m/xx0qZIb1o6lCq5KyulGK+kZmUKeL9BLa2pgQ6oYvO2oRPuA10neotnCPGepSntadOA/joc+TeWgll9CQqLsgl+bcGoc58A11rsy8Ne+o2pGhfYTcRvmt07iqe0YIWnygW1DTJJmCZB72MZ6V335jAIr7XSyy2Q0Mz2bg9va3pyTPEshF4MKoRcRRS94GLJrPyprT706CEG9dkicnwJ4oG7tSyy3EutDKtn/5FEMdU2/md7Oz08B3SBPhUM2l9STITYtryVpAVJ7IEiDdVAty3BC5shU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3298.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39840400004)(376002)(396003)(186009)(1800799009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(7416002)(558084003)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(6666004)(31686004)(316002)(54906003)(6512007)(110136005)(66946007)(66476007)(41300700001)(38100700002)(66556008)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0F4aG5jVVh5cXR4aVhIam40cDZRRFViRFo3SERNeTZMblo2b0szejBRMURm?=
 =?utf-8?B?UVJ2TFhnUEZ2ZkFhaGZ6R1BhSnlmenNPTEVYTCtUYld0blhNLzJBZkc4alFx?=
 =?utf-8?B?Tlc0WnA5cEJOTDBuZlpmVHhNUm41SGJKdGpYdG5wd1ZQWXRvaWU2ZFVkWURM?=
 =?utf-8?B?VCs0dStTZjF3T01zd2o4eURXQ0VZWklLN0lIbXhDOFJNU3ZmSVQxamdyb0E1?=
 =?utf-8?B?UFQ2ZTZRdHNFKzdhWUFwZmJ6RVhuZHd6NUFnbGhQSXBRQzdkdWZVYllvQVE0?=
 =?utf-8?B?bm9rWEs2Q0NRa290aUljYnVGZ2RDemwvV2dVV2w2L3ZKOFE3SnY5MEt1Y2dj?=
 =?utf-8?B?bUR1VFoycm5vQW5JOGFTelhEc2tLc1VsNE14bXpVcXZBR2tyYkhLTmpockZj?=
 =?utf-8?B?aGJCN1hJQjNocEpNQVBIUDZjaHBGWHhNRFVkbmFPZjhzczA1ektiYUZzTGNF?=
 =?utf-8?B?cUgzTHhBbkphSzViaEJRTlJkVWRNbEZNZ3Y3Z1JPeFhtWnYwNTJxWS81Vmw1?=
 =?utf-8?B?VExISHkzdzhEOC9ySGhWR1RvcTFwTjdvalhiZkIrUVlDTXAydFFGMWxDYTUz?=
 =?utf-8?B?WU9rNy93WHlLRkM5K0dYRzRTeTk5eHMwVXo3UkxJdCtjQUpuaVF4Yk10QTRm?=
 =?utf-8?B?MS8wOG50ZEVDbFo4eStySTlEUktLNlZEc2pIYytIN1JWTFRxZlQ3UGhPM2x3?=
 =?utf-8?B?TXYxS2JHMDNkcDRpSDVBL1NuY2JPUXdZY0x4WFprM0FHUFFqZzBOOWxTbTNK?=
 =?utf-8?B?Y1plMDN2cldDTmplTnAyZXJRSlRpeWFrRlhmNThleW14eVh5RFBsTmlwUUlD?=
 =?utf-8?B?Zk96RWhRRFJqcU5INVJMSDdCNzNIM3ZKZmY4bEtDZy81dExocjRKUGl3dHZF?=
 =?utf-8?B?eE9YZEwzYnNvVHVoQk1Ra2hPVGtqTDZOaEEraWRNUVJ6QXRuQlFkRldxZU5v?=
 =?utf-8?B?UTNjeGNVRytqdXBoNVFEZW1YNjZRTHUzZ3JUd2ZrOUcvTjN5WXk3WWJFc3I0?=
 =?utf-8?B?Z2NWTERRWmlGU3VZalpybURtZ2x0SU8zeEJqRyszaVAzdkZPS3F1VlE1cDZK?=
 =?utf-8?B?dzE0UllDV282WVRKdS9sd2owaG1CMlNqSGNoek1BMktNdGdmemdCSE0zaVRr?=
 =?utf-8?B?SnEvM2dMVmJLN21qcUtFTklWL1ErKy94b1hHdGI0UUFnVzFMenUyOU4wd0Rh?=
 =?utf-8?B?cjArdVVUUklvbnNxdTRaYWJHUG1YWkVOWkVPTkUrMWUvbGVuMjJYbm1iRlBn?=
 =?utf-8?B?NjVpeWtyUFpwU0ZHaUZWbkZiaXUvdGx4TTBLQ0lqWWo2TlRQL1dPZFAyZXBv?=
 =?utf-8?B?aXUzcXJzcG8rSlVjemw3OGdJVjJmVEY5WE1TSEppbkpOb3U4bHhHT2sybVZI?=
 =?utf-8?B?VlRXTU9scHdyQVlqUForT0pZZFdhdWF1QUY3aUhUT21PT0tUNFU4U1pBWXdC?=
 =?utf-8?B?Z1dtaDFXRnV1azhQZjlvRnpDMEs1UFllbERyODBicVk3ck9oemwvaUZvbWla?=
 =?utf-8?B?dG45ajc0d2FQNDQxWWtBenhkWDNHWkN2ZXo3VzJ1aXYxMEtXajN2OFJJR1Z5?=
 =?utf-8?B?dFRaWm9WQWFlSDJiMndtQm85YTV6Y28rSnJVaW94VCtlc0hDKy9SMEhwd3Ez?=
 =?utf-8?B?L1U4bUVNcEs2Q0VrZkFmRWNiQzJ1aEl3TmQ0MHUyUVdYZ0FjTko2Zk1PdTNx?=
 =?utf-8?B?NU5hcWQ5NjlkTWpwWlBXNEl4dUtnMlRhaHhuWGxGQWRUdFNmeCs3VFlZT1RY?=
 =?utf-8?B?RHNYUzFNdGZNckhlUy8rK1FPTDhCTVU5Ni95dVVPdFlLVkZzSjZkMnhEdVJt?=
 =?utf-8?B?TFVYQ1dTOVI1R0YvQWJhL0RHMVJ2SHZwL08rbkNIVldGSHdyc2hmNUxkb0Z4?=
 =?utf-8?B?Q081NFFsa09jdy9mZkp3cGZCSjlaY2JBVE10aGFXRVhoMkdRKzFoZEtQa0hp?=
 =?utf-8?B?RDhrOXppMkI0LzFRSDFFaGhvbWNKWmxVTm52ZlFaUzVPSGJSdHpTeHNPUlRw?=
 =?utf-8?B?OGZiMThrQm5OZFhRbk1OeWhRU0dDM2FJSlFiTWlkNXAxZUxEdnBkVTZQMXQ2?=
 =?utf-8?B?d3k1ZjJQRjBXR01DVlBSZkdhMHdJU0k2Q0JGUjNOeklDNWpsRkJFQjlMRi9I?=
 =?utf-8?B?S1U2b1hSWkJ5c0RkTGYwbnd6UDdWc05WTElNcnF1WThFWE92YnBaNERrK21N?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e7a87-7639-4136-053d-08dbb7032b90
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB3298.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 22:20:44.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj7iumeUvkWyjotuMqLWJKByobH+2DhcJ35Px0diYJ+GTOYoGxkxVpzs28hykde/zg7/OKRGu4oJFsVIfOWXH11JHeovQVBHUNzcalpp9m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7606
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.2023 00:17, Linus Torvalds wrote:

> On Sat, 16 Sept 2023 at 12:31, Linus Torvalds 
> <torvalds@linux-foundation.org> wrote:
>
>> Does the attached patch fix the problem?
>>
This patch fixes problem with counter for committed memory.

Thanks!

