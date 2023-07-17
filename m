Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2329A756055
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGQKXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGQKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:23:22 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F310C0;
        Mon, 17 Jul 2023 03:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNw8qYrc6Zk4g1ezYfP7QB5/dsALYEoGUTy2zvDBh0H2s26889sQhTYtXO8RO/SN7dR6cPTv9OBMrWVyQacMS8hPi22EZOCFR/wIZEGPLwn0mT8pSSnvCPR6FQ90TAp0USpBOb96/42fr3x3wkIFcAum1OOQYymJDtR/EyORQOHtD/8ZhGFmN+ZJDTG8GZl+sCuD62ZAFy9opOjGElsOyAetTSX9q64Il9IqoLd0supzhH7t2n9qbgET/kelU4hq8p86PVKcjZjf4Dsp+N/cW68RNNH15pwlkWYK6AeSMSg4HUPUc6KWNd4vET7ynkdpavB37ApqrOkIsmRxOUjyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UU5xZvvwqiPogyhaMxzJ30T81DbI4nlZJPe5NgWYtFE=;
 b=fbeMqXH1Aqhp0v0sIRymXtbk1g1RuMQJYt54/OaxeCch/a8S6euiKLc270tc3k0yR4769Z1fT7aXjPXb+A3/RVhsK/qYNVssJkyRqtOVuIb44R5PnvzqlhtCAprrI53SLnxUSobnFh3BGcSEWYiNwVBS0Q/Nm5JiaTmbvIv/5t5RQpzhMDiIHm/2subojt4qsmfGekMlYYOz9C2DohVgIKH45nJSNcIHDLYlQEpwj3QC7I3Xg3sAk0h6TNM4bHtHus7DogPra7QjWGI4Kae09OdQxGxDEvhh0cdh/xfBqukimBM+f0mzC1nUrEZIMspjEINghi8lYJ+CuRB8DWywtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UU5xZvvwqiPogyhaMxzJ30T81DbI4nlZJPe5NgWYtFE=;
 b=oPFYg1E7KRzcO/FvIT7oi0jlChl6GhH1esL67DGJ71dSoiQVy4eWrrpsyWF5MWQrhJkvI7THg3SwNSRdmnIEEl8GhULVsF0RxoGgwXpgf31oePKTiqGIsbwzB/HCKRH/IiY3W5Bs3pPx0h0hSTOFoNwuDg3BlyUC2H0erMbrtpVQ3d9ggEAbf6q73EVCdo4zUiRm8/nOmhiwI5rlGY+BgTSiDtN+rEcUhS3owzlVGAH3itivkkFiBy0IK8qCeHipDglmuVQGyaQjfYPBimUBVidJxsbZ8EuMgcym9qiFEmLI1XDHIxQWwWadpvQVLhqOY7pkbfSq9XllqQ4ttvtfzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM9PR04MB8414.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 10:23:17 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::2975:b06:eaaa:9361%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:23:17 +0000
Date:   Mon, 17 Jul 2023 18:23:10 +0800
From:   joeyli <jlee@suse.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Chun-Yi Lee <joeyli.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hci_event: Ignore NULL link key in
 hci_link_key_notify_evt()
Message-ID: <20230717102310.GS5866@linux-l9pv.suse>
References: <20230714161210.20969-1-jlee@suse.com>
 <8eeb958e-d947-2f6d-5942-d30746cf1268@web.de>
 <20230717055150.GO5866@linux-l9pv.suse>
 <7cae670e-b7c5-470b-536b-ab03513cd0a3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cae670e-b7c5-470b-536b-ab03513cd0a3@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: FR3P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::21) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM9PR04MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfeac40-9680-40f3-e914-08db86afd611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLtilyl9QVRuXZ73cRPpjegAGOKfqHNbARg/bG/ZJodXzs+EBqQeOCy0KgQzN5AaeJ4TdkKPgmOj5K5id/Eg9f8Dw68lvZAoMblIQR0jnnjTp7YwmxnE9NXpCMC7OUwdAHdXwCT/VJfPLTbLu5jtRmNg4Tm1f/2EA9QO1U9d3phbvqTcy6f/recgxMs4PMaNAnTMdvSS4JzxAI8ohRNJG+ZMULf4qtnvpZHqyh+FLg+2xJaB5F/pEYraB2APQxQmwuEjYhXofWyUXIZDuLA72b27gvIPkR6svR8FF5DuQQfaCGSDI060+/Ab6dhxVrL/Do28anXIymHEM7wRkXny+N2Yah624UlRWdr+WtcYWvopbYZD67Ap5xk/DnIbwg+IlXxV85XiQnJJtRr1QhK107ZeKpHv6ifBMutAGMptPf9dZQWedmvItvHnv1wSmWz4SN+iCvtL6nXjaYop6yMNcAkRyRO9rtR52XU3XjEW5O4TzQcs1vQneFo6RQyblExUxkOAGEWxk0PpH1LeZp12CRR4SRN8E9/OiwmVyjyYVjbTA4u6aAjyZbCDz0G6lCepAxUmeKZFGW7We4omgDEw5eeVAa3s3Yae6pOZsWJk1Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(54906003)(38100700002)(6666004)(6486002)(41300700001)(478600001)(5660300002)(8676002)(8936002)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(186003)(83380400001)(966005)(6512007)(9686003)(1076003)(6506007)(26005)(86362001)(36756003)(33656002)(4744005)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3dNbkRkdk4vV1FLQUJxa2xWbXJVVjYyK1BlSFR2TFRCcERBSERtSzVvVVpV?=
 =?utf-8?B?WWlWdWUxN3dzWFRzczFvVDBpZW8rRFZqL0pNSStXdGRqeHZ4VTdkdnJRdlY1?=
 =?utf-8?B?SjlsQS9VQytpcVlpTW81SnhUTDgweW1DN1RVWjlhNGlQSjNtU2JRSjUxVkJ4?=
 =?utf-8?B?WXlKelBVNGY1d3NKMm9CR3pVR1lMU3QybVRHZVp5UmdJQzRFT243OURDVXZE?=
 =?utf-8?B?WVhkak15NUdwZXFNczVXdlM1cmVrNyt4MFFJamtyZzJEeCs3QTR3VENJZHpx?=
 =?utf-8?B?M2pjYlI3dkJ2b21CSW9PdDNqNlRhL1VqTUNsZml6bTFTUVdmdjEwdFF3QllB?=
 =?utf-8?B?TkVkOXBZam9kMzRXOUpTb3BDTmdSc0EyQktINWZUc21nVG5zWlNKUmdYVzQ0?=
 =?utf-8?B?Wmk5Vk9xZm9xTE9KaW1KVVNuWURGRTFwb2RoQ1JzbTZiMzh1SFhuN01PbUZW?=
 =?utf-8?B?VjVta3pGM01maitkVDc5eWZtLzVQWWtKNXFhSXBIUUE2L2s5allYMHYvaHhH?=
 =?utf-8?B?bk1qODdjdnl0UHh0cWlSRWRTWjdYQktQTDBFczhUaGs2TnZiREVTUUNQWjRQ?=
 =?utf-8?B?NTMwcjZUV2RRaVJraDErWmZqTnpDbnhuSkwrbUwvQ3ErRWE2TE5MVjJuOWFZ?=
 =?utf-8?B?RGxsV0swUTdCRStkL0JVYVJscVBiaG1YRktTOVNhekpMUTZ4UzFqU1RhMHJn?=
 =?utf-8?B?ZGxjWVJMV1gyMlB0cTg2MUIwRDFaOElITXA0bjRRTWozejI3ekxEOGpxS2hO?=
 =?utf-8?B?NTd2K1hIc2o5b2FtNGgwSnNJbXJCTzdsV3BKSHJPRFdCdEFVM2YvcTVRcmVH?=
 =?utf-8?B?ZWMyVEQvQWNRQTA5bSs1YTR6S2laRFpXT2RrbE9YQ2FxZUNtTDFJYS9XNXhB?=
 =?utf-8?B?NlcyajA4V1RsSnJoYUNlVHlIUXhJd2FDNHBXUUZGeitISlNXT2JZYjZ0R1lX?=
 =?utf-8?B?YVVaL3MrQVduTXZ0dFE4Q0dTNmpvWGE3MUtETFB3cUFZQWJUVmtDV3BrU3h2?=
 =?utf-8?B?MGpQMnhtS2Z2Y3BwZVkwTW9oSjBnb05sNm8rR1VQZUlETUFFMytVU05tTGdu?=
 =?utf-8?B?QkttS1RQMHdEbEt6RTNvNERQMGpFMklkaTJmZWkrb1JMc3VOekFyc1hpbktt?=
 =?utf-8?B?ZTFmMllXR21WaERmUGk0Vk8wVjdPVGd6NXc1am13Q3hOcVBrcVZWb3hGN2tS?=
 =?utf-8?B?RGtQa0dURlBWSGZNVXc0bjJkQm80eDRWNjVqRDRKU1MvcHF0REhDYmhQSzFD?=
 =?utf-8?B?RHpybG5vbXFJR251dFBqYzJTeVRUOW8vaDBFdnpIK3UzcFo0REFiWEVpUndX?=
 =?utf-8?B?di9TU3JNZmpFc0JiM0tiRVBJQktZNjRENDlZS1h1RUNBWWNTeHFPQk9wTGhM?=
 =?utf-8?B?b2FWektBcVkrOVZGV0VBcURwb2FLclJSNXpWN2RYc2FKajdycVVYKy8zWEJu?=
 =?utf-8?B?WmVsYWJuUlZMTGFzSUs2N0tLVXRFL0xYL3M4TWwvSE55U1FwU2hCQWd4eFdS?=
 =?utf-8?B?cFRPalZXR3RRMW9nNGpCQmhWOHRJSUJwNHNIM0J5d05QanJnbHRNLzYyNlN4?=
 =?utf-8?B?MzVRaWlPM0sxYXdGZmdGLy9WaTd0cXh4VHhmVVovUUJDQnpjQ0pTYk1zMXI4?=
 =?utf-8?B?dkxRM1UvMWZWd2x0ZEdZdUFDTjFlSW1hL1lNb21ZWVlxSmUwYno3bE5udHZy?=
 =?utf-8?B?ZUJOb2hSZ3Q4QkZtcHF1RjVlTDllL1ZYLzNFVFVDVWltcnZoMWhkNGNkazVu?=
 =?utf-8?B?L3FlZ3NiMmxpbURBbTVoK2NMTU9tT3M4TWx2ajFXTDlBSXdIRURPWmdrYlhE?=
 =?utf-8?B?elJRdS84U2kyaGFIRUlmUUZSa3RKMlFGdlRPS0ZLd2d5d2RubUpTSlVSQmVx?=
 =?utf-8?B?bWljU2oxU21yTXp6N2ZSUEVaNVlsTGdaU2dwZkRBaDNXNzhFUXpYM2dBcDVy?=
 =?utf-8?B?dS9TcFVBaVB6c2pVUld1a0wyWUdZU2phZm1CSS9BR0djL3dnbWRYRHJUR3li?=
 =?utf-8?B?YmtHVURac1hVbGIreGJSVWFldFFxdUk4NlkvenpKZmZmTFlhWTRFc1c1Q0ds?=
 =?utf-8?B?akF4a3h3Vm1xanF0TVJjRFUzdGswbnBTYjNGRmtwdktiWGpVT1k0ZmdPWklB?=
 =?utf-8?Q?h4LM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfeac40-9680-40f3-e914-08db86afd611
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:23:17.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfCoWh33hbXm7sG54SisWpsJ/ghDOe6LVmGNI2eN6+Gj9Wo2pTnujNL//CAqiLDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On Mon, Jul 17, 2023 at 08:15:56AM +0200, Markus Elfring wrote:
> >> …
> >>> We can ignore null link key in the handler of "Link Key Notification
> >>> event" to relieve the attack. …
> …
> > Sorry for I didn't capture your point.
> 
> Did you provide sufficient justification for a possible addition of the tag “Fixes”?
>

This patch is against a CVE. The issue is not introduced by any old kernel
patch. So I think it doesn't need Fixes: tag.
 
> 
> > What should I change in my patch description?
> 
> I hope that corresponding imperative wordings can become more helpful
> also according to another Linux development requirement.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94
>

Thanks a lot!
Joey LEe 
