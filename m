Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE494752E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjGNAMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGNAMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:12:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2128.outbound.protection.outlook.com [40.107.113.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C812736
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXTvjhCMidj+PDUwLHi5rLtGL7GLLGssJTJl2r1GHCMz9guPWIEy4saRlR/r2AkPFOGrJSgDA9MwfAzHVl9FT9UPpuveXmXl9Eu19PPJ6q0H+yeVDrOfYYgFp1zMsLQoAenbQ81GUrLzNCignoW9w5Gldw6KQ/L9qrESq6DOMqWMDA5qxIyKsUTKYWD5W3GZVlFUmtq6JdEi4O0J3JGfh4zYk7CLw7SKQui8TW67ZQdEl9nCyQRMfCvzFrSjQ9hwNwAnA9yd00QHbct1u6Q+J+iDVr3lXRHo+t3AzVB8/xeqwqLGx2oLQm3MHcZlIJ7Zgai2pQpyZs/QBKFBVYQ5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65dvQURReZd5nOIbfP0cmbR3T5UNISYONMzV6ib/VP0=;
 b=mGCcOyw/wpWueqZ7TXxtLYO9xSL41IbY7sDJpafwqUkacYc1HDEMprSzc+dxX6WmurhQ+zQgdFHwcRe230MfXgjp4UF2it8/mM/JMttD6OR37m0oOafsEQDyX6pFuqcvXcVN5mEqsySJCIqSW5jFQ08c/DceBOMTwAuzgY0mh8jcF7bnAUCFWx2FWrykWpheV/er16FUYBmnWj9MVNk7uqaxzFXNuPKttWbQwtsOz/7T0z1ZlbzReOISC3eiaeGpsifL6uXLQoISW4Dy1WOOTtBYIHqGyYWD1H+Y8zACEW36cH9Z99DhReG+a6ar60Qacaf5T90LMXHx5FBppX440Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65dvQURReZd5nOIbfP0cmbR3T5UNISYONMzV6ib/VP0=;
 b=HOjjTE94AjmmfFhGwWN6x3i9G7V22ApALtW5rfL16sHFa7ou1uuT0QveRQwNkSYClw7Ot3TKgZGMhDcHszbZ/MeJk12wGep9yGEHW3yiRI4QctUZH2A68wdrW4diZX83EzdZmDvDvhP0DBeXrHY3XuJjGCNiNmEaCnqqolNObKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TY3PR01MB9793.jpnprd01.prod.outlook.com (2603:1096:400:22b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 00:12:11 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::7d35:d426:d4e5:6e5d]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::7d35:d426:d4e5:6e5d%6]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 00:12:10 +0000
Message-ID: <877cr3tkpy.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: simple-card: add trigger-stop entry parser
In-Reply-To: <20230713193905.347588-1-fido_max@inbox.ru>
References: <20230713193905.347588-1-fido_max@inbox.ru>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Fri, 14 Jul 2023 00:12:10 +0000
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB8426:EE_|TY3PR01MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 084975d3-81b2-4561-bd2c-08db83fef7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWls1vL6FQ5Tvsg6QrIhVvdYcjiV6tfJYRwNGzODdv+NgZ692/H23HtYp23TY4aUauC9FHVXE3KNESqFrFTvMIk0NEaotfEECab0S6p6aJ0wZId6B1MvZyk5plgoWquKickEA6qEv9b3Wd9w6RoHk4EGTcYSj9AtsZTa1I3BPyiIhrh8bSQcI/5p8BxkReNjqTshUfElaW5IIvnP9z22njVVT7S0yHlVL39Gu2Ww4aGmqQSYeKnX15a52JzjcwTt5sZUqQconv6Z6Mu60PR6KvOMTwzOl7aSvIe6ygTfribXS6vQpmz2adOAT+WUbX5EtSN7aS6nptYabsfHoxqz0t+rkVKMB9yIUfRUMEKa75SAQnF8l8HFTrT47VrOPeX+MIhguBbVxcy6NcEf1NEfQGTTr612NOKyr3Y3HGwXwoSSB/8es7nOX/SBvEksGJzi1SEDU9nrPP4QjRcKXN8lFwkVgmeFGDa3m+ljVI7g41RztbSswC+AaauEHzCM7KpFruG/8QbdLzsn2AYqVnKluALxcucu4I7MPGkH3vcbn45cwIUPv2ZUbvyNUKQp6frjsXq+g6KKIDHGN2ZGhnrOoEIW4jMRMpOIxv7bnrgupo1rNFcS0ZVb+R/E/mUcVk+5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199021)(83380400001)(2906002)(4744005)(2616005)(66476007)(6486002)(6916009)(66556008)(66946007)(4326008)(316002)(52116002)(478600001)(54906003)(26005)(6506007)(186003)(7416002)(8676002)(41300700001)(5660300002)(8936002)(6512007)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ywf3+Fr3TvORWmniguTD/jKaK9hVavo9lpsyC7swudVAUgKHNjDTt2XhAfv8?=
 =?us-ascii?Q?MMAaEJuTvdlvbPV90frhE9LpmU1lAZ4AMsWAkdRjmckLcW9tQzI4Y1evKTtz?=
 =?us-ascii?Q?3kwGgdmsJI7FwMm+JBNJnaPcntcN1ct7Vv1LeyT3Aa1YyDa2RMxK53JWJ0wH?=
 =?us-ascii?Q?FoCeyPWjkvsPbqF2oke5ViOWb5q4SvIUN3oUGJidD8cKRTRCWikPHDDj5aHo?=
 =?us-ascii?Q?T2FDOzVpVAGqpvqhQMiJL6B2zm95g4Q6TJuf2ZwdvDGgMj+k7cMi1d0wwl4/?=
 =?us-ascii?Q?qVy+r06p09Z5tkrarnDgMXK3gOVh4HmrU50ZAJp8yQw9D9Ge9q9fglxjpbY0?=
 =?us-ascii?Q?GpghIPiIoHd5e5SIMCY1TBpG8hcTkFe1H6LI4CNsKCiUXzuILitZ3DO9K5rl?=
 =?us-ascii?Q?45/pNuEO5pce0CKJB5H/zaEqlmBMuZ73YTuwxUCpZeRMFWazCpYK2bWR/vQ1?=
 =?us-ascii?Q?Z+LvY50gKxFakIrDk6GUr/5I5l9ZRCQzEWEBvhfontuHWHwEHFtzG2VH+83W?=
 =?us-ascii?Q?wpubFLdkvv8/NpicJm+W9+7lFcM0TSQo4NoG2kivpnprg0OKKDvIiN+vfsTL?=
 =?us-ascii?Q?/Rpo6Arxv9nD8Cl57l9V/0AWHaouI+gjICI1StOoSkT+4siWWI9zCSWqNnaj?=
 =?us-ascii?Q?kjdCFMGZfc+TWnHQP0TQRty9bop/sLwrB+In5lx+oos6PL+M8aw+MgwyUwrY?=
 =?us-ascii?Q?Hv/NXS1rj0FopOukh7YWoUGULjUH+hZU+DfY7GMtdWhFXayuMluqnW3L3n7N?=
 =?us-ascii?Q?xtSyBkOcRjuSfhYWOi7czmyiMJOGwqikjSiVv91c33tWIOM1iOOHBfNsbMnr?=
 =?us-ascii?Q?4aRQpJUc4M5fD4+Tz250+dF4xoocUbPlpT9Bmo6Na43Gdl3sxsWU07WM5SL/?=
 =?us-ascii?Q?WCu3Ay6LxG7EAPfKjEPDG4FXirFtLKMZdwojUKld8x70tB0n/7T6O0NH2cei?=
 =?us-ascii?Q?b6Q5wDEFCVYJi08xX8KiCKDNhUNcMKhZ7DPn0tLCUQGnPKXGxixy29CidWOP?=
 =?us-ascii?Q?vJ82sfjpk65B6SSfTJnaEfPr3WYYKH5Up2L4ZLGVKY9RAnZZrUk5TD1pCjMt?=
 =?us-ascii?Q?BNqJgsMxxEbFUf2U4SbVbMbIkl0ubXo1bagz6E29DVbzwf+xLBJFkLG1qJKK?=
 =?us-ascii?Q?9YNCG/N51kQK+d4cDr+yBcrqXYX3oP1TlnTnaXFVQGD7bQBkiw70mir4ICSH?=
 =?us-ascii?Q?8opkkgsLOicQfJZeK0jZNo/tElY1BdpHLNltBTIYUDceR+AhnHWW/uInLxKn?=
 =?us-ascii?Q?teCrfr6/+Aclu5HuFcZzpR9Xpcz7YnxnfZ95HEe1E7RHX2QlGXiqb1FgdOzt?=
 =?us-ascii?Q?7N88MRITBcVX9Od4PxQ4YamhAcSTfah/PC4TGRUyGG1P0sthkdfe/z3+g2BT?=
 =?us-ascii?Q?t9IZsXyUFxGnxUvpMQHlHjcTdEBp/3GxtAxSR99KwHMp8+aR09oAsPhOKVqL?=
 =?us-ascii?Q?A1n6F1C+gWp0C55cDrZr5rnnjmWUt9DskjTxYi/Qr3vDOiBqF37XlHdrvyhp?=
 =?us-ascii?Q?KWSjkP++W8eoj3ct09jGo/BeneethM+hRnIYrz+cQ8Pwtb62mdubcasg20WE?=
 =?us-ascii?Q?mFg0yD9EgcWzfxg7NPposyecUWkD0Kydyn83D7m1/ZFUKl3WTY5j/t5+6mY2?=
 =?us-ascii?Q?zIrvJZbtHGv+K+jw6fqV3Ww=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084975d3-81b2-4561-bd2c-08db83fef7f2
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 00:12:10.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGhmV09VkUCUOVJ/31iY66FC6o+44kupxwNwSNEpiDeIekGIrnNyMhJs5WBVSWtftKVneImBLJRxgRwOpWNGUZi+YhDpJFU4T6oDKGms4yl1HSHBZrLbaAe7iknFDbGb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Maxim

Thank you for your patch

> It may be useful to specify trigger-stop for some DMA-based simple
> audio card. So add this "trigger-stop" device tree entry parser.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
(snip)
> +	const char *str;
> +	struct {
> +		char *name;
> +		unsigned int val;
> +	} of_trigger_table[] = {
> +		{ "default",	SND_SOC_TRIGGER_ORDER_DEFAULT },
> +		{ "ldc",	SND_SOC_TRIGGER_ORDER_LDC },
> +	};
(snip)
> +		ret = of_property_read_string(np, "trigger-stop", &str);

The name of "LDC" is from initials of "Link -> DAI -> Component".
Thus, people want to know what does it mean.
You need to update DT doc/yaml too :)

Or maybe like this ?

	// 0 : Link
	// 1 : DAI
	// 2 : Component
	trigger-stop = <0, 1, 2>; // default
	trigger-stop = <0, 2, 1>; // LDC

And please add paired "trigger-start" or add comment like
/* ADD .trigger-start here */ or something.
Unbalanced implementation is very confusable.


Thank you for your help !!

Best regards
---
Kuninori Morimoto
