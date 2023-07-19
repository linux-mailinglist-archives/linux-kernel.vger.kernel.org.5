Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C297599EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGSPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGSPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:38:50 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2069.outbound.protection.outlook.com [40.107.247.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF5BB7;
        Wed, 19 Jul 2023 08:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObLAIGHjF419sUTM6sh6qI1H1JkTkVtG41IOB2l+AKDEx4zkGY8pYEx/sS4ywpx0O1l9melgP/+smjRs3+XzHEftinJGCnhA0uW3WLyZvaBk209HX63OIdjeyfaoq5gHsxVIQzGl14iKQ9xhhB16YpW6iHzoEWpbWPP392KHrT12pOi3dVeFvB8CmPLKvjt41oNqwPwWqm362k/eK7dnOL0xO+KrXXYOMtYgCkw80C+/zs9+4x6AHdzK7s5NRLaWMN3KirZeURheCCl2Sp1R+0w/JhqQlRitXuUGUv2GOvC3giHXf9L+1tRB+kcQ+RVsjqbOqlCtErnRaGw0D8JG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzzyjmw0dmlLACVToXH4tsJWbUKDUZ635iEMzQZISB8=;
 b=mH3tgN3vOI1hf5b7/0RUq6EdKX2EZTAkyqXZdKysXS8nV5QJmtHXQfnm57Ntf+VbL7XAM/xcdfCytJzbXGEmlZ8SyBn/ce1JqAZY492viUHgCllXHBhwb1ZdbScr1WxKOnXrX80MurPI5eRP76X/yYNFo+GxPXBQR7QCehWTpWT87Z3X81IB+8ExHVK79gCUFrCe/Blvmt2wviFi4+DE7Rx2YqT7VJfC1VyLmuO5Nyi5hJbHJw5GiOsYgpfWLjPLenbiW2ocJdYdF9t15Yrd0+61a/eHes85MK06IZhU1c7yjclkcO/tFJdRGZYhPP1ya3tXWH6B9QjtXzsl4sMRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzzyjmw0dmlLACVToXH4tsJWbUKDUZ635iEMzQZISB8=;
 b=PaX9yCChwjdzHmP/7XnnzNMWgBiaeX7Y2FSSo/CRoXcnVaMpRk7Azn8cqWgkcaRHq3yCkk4DrqCTSPTJNqp9jW8AJflt++JyKi+24Un9eppcecPSi5laBfx3Wr1hV6yeHFeT/5yY8EYiEVzfdVbDYHbTtPL/f43Uv0pFge7aakdQYlcIsYCkTJXL58+IBc7Zo0wcezWFMyiqCEdpOLfLOCz41YtiArOWPIvnBi7z2OoQx7BGK2mUTsdVt3YIfSknnov//m5HnwPDi1dwrxwxFTKoSu77wK0WmZ5xINuFzYuuhUMU8ss3Svk6EuupxL6mK/qsnQ7tbkP2pxHMmZmL2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 15:38:46 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 15:38:45 +0000
Date:   Wed, 19 Jul 2023 23:38:33 +0800
From:   joeyli <jlee@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Chun-Yi Lee <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
Message-ID: <20230719153833.GH14791@linux-l9pv.suse>
References: <20230718034337.23502-1-jlee@suse.com>
 <41f91e8e-8038-22d8-baa6-91f98afe405d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41f91e8e-8038-22d8-baa6-91f98afe405d@molgen.mpg.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::18) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: d22b6794-b776-4bb5-8405-08db886e3d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvxc7KzYrl6Ui+Xl17qSQpN9Xra2wm3BtWl/Xfqid9kXteE4KEjQG56Gx6rhaz1o/y6DuWj0eolDiyskWCKPm/e4j8ZuXvOsGJxyoyYQ1VMKFpwQ4bEs2dvhO8ft3Ewd0XOuppKG6w5PXNy2nf6uTQLyeiDErQp5TpVFP1Xx8JYW30ZEcLJLcAvQkCA5UZnuR9FoSMIMFRGN85Koqnso9BPAZh2qljrHaRODQcc2ojXX9gQBsSnRj6Y3AZ4ynFmfbzrz1qC8FS6NHN4cNKccO4ufSCXsWDiZj/CpUTEJzlI7EKuQ1TEkNLbQANSlh74Tq96eOVkboZaPiAW9xmQ2D5YFjQLyFHjiwatXbruxQ0CKlOyAxy58f0Wu0+NFjjSDEdUYWDLjyXl06foApShx98uuyZ6J+GWvH1Gpq0D656XYJQZbLMOnfZMrKMkZs87g453G/oV90uajvPx6DJa1cak561FffofZVL6B1O3JILjsSkpQAIe5HX4LuB+woOMUTO2M97PqKcO9fqL8AQG3WdrZVINfKs2Fngun/kOX10AY0pFZX02+nJWHNhmhf4v5UOzWxi1nnXuN5qU2st8Sgu/tg86QMx984caqtyEnXJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(6512007)(9686003)(6506007)(26005)(1076003)(54906003)(36756003)(38100700002)(7416002)(66946007)(5660300002)(2906002)(316002)(4326008)(66476007)(66556008)(6916009)(8676002)(33656002)(41300700001)(8936002)(86362001)(6486002)(6666004)(478600001)(83380400001)(186003)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STliT0hvMkswN0lUSTNEckovYVlTNjJKREs2cXNCcjB5NzYyRHg2WUlQL2FG?=
 =?utf-8?B?QXRLbGNvSmpua1BoQVFzL1ZRSlQ1UlUzcllndWg5bThRUERHRW42QXNpbmdQ?=
 =?utf-8?B?Y2ErbmMvWVBocUw5NElKbGtPY2c0OWtJbUU1aWFqSVRLMjZDRVBrZTkvbnl5?=
 =?utf-8?B?c2VBUkxqdW5zTTRGVXAwS0ZzeGY3RjU5eUhSeUx6aG5SeVdycm1hcWNRUXhk?=
 =?utf-8?B?V3dENWhCSDlQajdxSUlvOUtISXVnZ09pUDF1NHB0NUUyYzdxb0hxbUJCVS9k?=
 =?utf-8?B?Vkt4ajRkcGdrMHAxcFFuWFROdXhtWnFQUnJtK2xGSWNhai9FRGxQRjk2d0ZI?=
 =?utf-8?B?c2tjL05WRlZaZmVEbGVyRjhQaXFjY3dDaFZUdVJ1YUE1L01rNisvVStuSlRw?=
 =?utf-8?B?a2dRaDluMmZ2dGJBUzhwWERST1JTOXlhNGhaYUNCLzAvVlplWUF5TmZXQlhq?=
 =?utf-8?B?OUdPMXlpVVlUTWQyT2pLL1QwRlB2cmdNaS9kcnJFSTVsNjVQOUNTT1ZEQWt4?=
 =?utf-8?B?bmp0d29OcHlITHF6eUpZVk80ajlXdUdrQ0U5TVhkZ1lQcld2S2pVejdLZldP?=
 =?utf-8?B?QWFkSnZVOGNDUmlTd2VqVzdlUXpWVGwzM3FQbm0xVFJ0UzQvcVNpVGRtV2ZR?=
 =?utf-8?B?QzRkcUJlbjlsTDVxN3BkbG9vQ2FQSWZ1Rm5HcjVsMkFUVEhrSXFyOURrWVAz?=
 =?utf-8?B?ci9vT3pEbHJMVVlnV2ZrcXBsMW9lQlhpSVBOdTFqaHlObytxZU1PQVlqQlVX?=
 =?utf-8?B?bVRsMDRacGk0dXMwWEJVZkk2N29BM2plemUvanFmTHltWHBTVmRzYXNKUHF4?=
 =?utf-8?B?enhzaVhZQ1FhcFZWdjc5bVZFK1Q3Z29UeDNPRHJZaVNrWHp5UStoRHNNY2Ix?=
 =?utf-8?B?ZStTUSszUWpxZlhyak93TjkzckdnREdzZWNLS2tvNFdFd2luY2J4enFzQVpa?=
 =?utf-8?B?RGx4ajFZMXRqR0RZSEYyelVmZW91NVAyL2lDZ20xelZYOFBacHEybHBiaUxi?=
 =?utf-8?B?V3NlOGVUc2NZVTZvN1ZqU1hnUWZSZExjTzhSN2N0bXpvT2dyb3pOQUhtakdn?=
 =?utf-8?B?WVhES1hCQkpHbTRQQy9CT1RUSzlXVC9qQmZCTEtGV2wzZmJ0Um9acDQrZTVV?=
 =?utf-8?B?N0ZCMm15Y2lkQVIvWjAwNFhNTWdnU2draDF0NGxYQUpVYUVyMGlpck5JcU4v?=
 =?utf-8?B?eWV6SUE1RDFHZ1dYbE44UDRucDY1SVFJOGNjUGVjQTI3ZzFsSTJDRGtMY25H?=
 =?utf-8?B?VFhvY1hUVzhFS0NycFJha0F3czd5TmhPM0l4N1Y1MEk5YmFpbVMxa2Y0UDZP?=
 =?utf-8?B?NEpBc0lvVXpnY0VNcjdCTGlWR3hPU3R0Sng3ZjU1MHhkUHhJb3BvK1ozNG9T?=
 =?utf-8?B?aEljUzdxZzFVbjFGM1IxQ2ZTbTFtZ3dKQ0dsNlMzWnFHNnF4VEFzdVpoSDBK?=
 =?utf-8?B?OW5LbVhHSlNPdHRWTGdGK094Q052RVorQUpDaFFlUVBtdUlBOXJiSXowdGgy?=
 =?utf-8?B?NG45WSt6TS9JcUNlUXFJVVVDd2RDNkhLb3NHY29yem10TTdYQVZvMHNZM1VU?=
 =?utf-8?B?SjFqM0tkQmVUT2htam9nSzZtL1cveFJ6Z1plaTNrMHNEZjJvKzk3NmFndjBs?=
 =?utf-8?B?aHBmUzZLZDVGZE5oMS9JVGR5bllqdFM3cGlsVk9WYU1wdXVRQ21mUzRORy94?=
 =?utf-8?B?TFRCcHpJbTJObzI0WXFQWFNjeE5jNm9la1ZVRGd0NXdzeGZjMTR0ZnFZRC83?=
 =?utf-8?B?SENwNEtjbzRCcStvRklLRUt2RWpSZzRUNlYzbkQ3VnNrQVRZam96dEJaRU9x?=
 =?utf-8?B?U2UrSlREZzBaTjkvd0JZOHRTQzlTMU5XTFl1aHZFZUExVVN0SlRrdW42SmJh?=
 =?utf-8?B?RkdxeUZ2dlI5bndacVdiTjVPQTl2QXJWVS9aL29JMEpiM0tEQ0ozT2RsY3VP?=
 =?utf-8?B?bTZYYlVEVjJjeFJKU25EMTdDNVAwU3dGTmRHQnliR3JrcnJOMDRBK0crN2RR?=
 =?utf-8?B?bGh0NXlyODJ3cjFVVkhoRkhWcU03UVc5YTlFQ1laenBlNUdIWVJCc3JIbzRz?=
 =?utf-8?B?cVFueUNyTWlCUm1XSHpHVnl0ZWlvYzlRYUlOM1NldkZib216RTYvUmNlZVd5?=
 =?utf-8?Q?2PlY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b6794-b776-4bb5-8405-08db886e3d31
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:38:45.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM5A82rfNmhQJBqV5hac6erNiuRIdh8jNtsAQWjUr9A4CBFouGQerf6XAYltWiMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, 

Thanks for your review!

On Tue, Jul 18, 2023 at 07:40:37AM +0200, Paul Menzel wrote:
> Dear Chun-Yi,
> 
> 
> Thank you for your patch.
> 
> Am 18.07.23 um 05:43 schrieb Lee, Chun-Yi <joeyli.kernel@gmail.com>:
> 
> […]
> 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> As checkpatch.pl also reports, please make sure the author and Signed-off-by
> entry match.
> 
>     $ git config --global user.name "Chun-Yi  Lee"
>     $ git commit --amend --author="Chun-Yi Lee <jlee@suse.com>" -s
> 
> (It’s also common to write the name in the order, so no comma is needed.)
> 
> `git format-patch` should not generate a patch with a dedicated `From:` at
> the beginning, so you can send it from a different email account. (No idea,
> why upstream Linux kernel development shouldn’t work with your SUSE
> address.)
>

I have set the from in .gitconfig and also tried git send-email --from "Lee, Chun-Yi <jlee@suse.com>".
But gmail always modified it to From: Lee, Chun-Yi <joeyli.kernel@gmail.com>. I have no idea why.

In next version, I will put Signed-off-by: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
to keep the From: to be sync with Signed-off-by.

Thanks a lot!
Joey Lee
