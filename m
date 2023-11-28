Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3377FB285
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbjK1HRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjK1HRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:17:31 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A13138;
        Mon, 27 Nov 2023 23:17:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IefYeqndIrmKb5hh+KEoHKrXIEaNT2lyp8C3MO571vtpffStJrv8H+VddRmg+3S6HVuWXwE0fVmebO5dq2SFnhXaMx4CbJhPCjtQEFVie5vvowUgf6+svNSrsWpiZzvC2Intc4/+TUQsmyziladaFH1ZPpmLQP5up3Ra3II0Z619QXvY4jjoYgHpvBrZmtT5qRhPu4fJObjX8zpz7iznpm+ZWGLEVEFK3+mySMLAhHpbKFMnNSOKxAcsmVQLevb1/EprnF5P+d7WzCF0nb6+FKfVGP3ZfEFT9GjH+1Wqi16PDtF4M/dI6D8aD3PZhHUzI84gVz1BMptx6kJkeVUHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnZNHj2r6Uxird22bPKD55JRjyZ+QO50VPDxLgFSTjU=;
 b=ezpP8v+T3dzLBp9dDor1RbpSveJSxBLSqHd7cSPuLgkeYY1Prr9N4r4dd3VOBEkX0/FENi45kLCwtiuXVls6pKlPn0Ro5p4najT5DQe+g+4iZUZduaTvFsN0PUGuNZowviPSzub4D2iGLsbxCEiCLU9ZmnfsR2+gPj165wXiE1JR9FABfnxiQdpAjJfpEu3c6gUOfptF/TaNaANKqH8Ap6/71dqKqF65o0XLgmaeaE5Amgt+nL5mXdWsdk0L9Z5YaCCWxXmAOb2nX8NfHWaiJ3m4uUbqRNwCoZEbwNdu5+MLK8DY0207BjgUxB5dnBNMhOY1K5iuoXvfQxMvtsSdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnZNHj2r6Uxird22bPKD55JRjyZ+QO50VPDxLgFSTjU=;
 b=ns1hJW7nTpauwkwQFkx2Fsy0ZGvvePZijd7H9ZaOpQ216jiA3pQ6QP4U4xEoo6l/ZA9dTzcL34Ucm9WEmrHVLUPHma1aCgInCgBritIWrxXpeHPe+eNTuGH0fbHi76uSPeD52n3xf1kkEuQJOX3Cw7hJ8wrmhtqC2hBpZLlgYnitfiynKbXtY+pqZ9hr3dxHfcvLcrasCaBDuHwF0Pctcd3gpG3ZCmVKcLNhoDQvVxFeZbYYm9IfBofoSKQSB0VdbbTEKf+uWeipb4qx+FF4M/vD/ukBELQbs2p77g/y9iEWg41/C3xiDlt1K878Lom/iPUF5G/sy7ji9n01IZGjPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 07:17:22 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::a075:b8bc:387a:c665]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::a075:b8bc:387a:c665%4]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 07:16:19 +0000
Date:   Tue, 28 Nov 2023 15:16:11 +0800
From:   joeyli <jlee@suse.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: What is the successor of /dev/rfcomm0 after the rfcomm tool be
 deprecated
Message-ID: <20231128071611.GA5154@linux-l9pv.suse>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYAPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::35) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AM8PR04MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8ce22b-5aac-4482-e22b-08dbefe1eb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhCKrbbixZE51aCeTp1EUIsuB8eFgbsVC42Ux/yoPx+SuaMoDuSXbk8fdZllXNYFLJl4B0/td47uxzU6/AU0qLPIjoTirGq48iScIa8ZdDlF5ElaWrvUcvZCG9UGQXHZzHHlxgmP5gk+EIM5siK0zjAv57cly0uSzn8sCg+N2K31W9icZHKGguWp1FwfK28AU7lWHAAPGgZs6tHsg39HQr12hkfLDJPRY2r2uHtGdNLSLIHZgLLtblpr21gCb+yYCPiNIUM5jOgzuGZzj5zsxorByOLBrsUY34K61BLF3doyAeu0Hl+qh4EsWzvgKoYSDlkzLKnr11aw3/Qi8caW7PQeBNjzEfvSaOvmc6Qp2/1hcnYutY2Wu8dXW2EpiHqnUU+6ej1rEda5crLzJPmI4BnbPAZTebh8iEvaljP6RO8qxLweY3+XmmVedLoYmJiOOBa4tmAUfPGebusbFnQE80es41dXpCt2gJ7BSYcdRMQx8Ao2/siMZaFH7vw+6EqVkPTi94AGzra1Y2R0PUnh/Y5LnHjXjqdOh1WsebPfYKAE8ggSSaR3wqraYSOmRn+GfxV+IgvLDrfQ+hmsbMbmIt6l410gx3/Vp3ktukE5hXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(966005)(6512007)(478600001)(6506007)(6486002)(6666004)(1076003)(9686003)(83380400001)(4744005)(2906002)(41300700001)(66946007)(4326008)(8676002)(6916009)(316002)(450100002)(8936002)(66556008)(66476007)(38100700002)(33656002)(36756003)(5660300002)(86362001)(26005)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFlcbdqMkBJ58HRKGR5s6J1olr1UfkpJDJ4rMDNCJiPmBYEqFtx+vWgW7jxZ?=
 =?us-ascii?Q?qrvIj5E+Cu83aDDVxnIZdMPLlUIbKU9KN35aq8aLtBBmn4lhgqt6y71RjMG1?=
 =?us-ascii?Q?8XyS7VhQzuzJTdI3+kBOnghnnYD28wziUIf8sK69GYtNz87nZApWFCsdWsrs?=
 =?us-ascii?Q?77aoXIEepRQZm/OGDsmrnZ5wmq84awuN6Nf61InqSf1WWvi/sZ0NZ5CC5MME?=
 =?us-ascii?Q?uA3tgYjO5XnYfoIBmUv0ObUuoSKV69qgycqJKE5WrshWJ5lY5EIfxKzCTMyn?=
 =?us-ascii?Q?d5j0z6vcXDr+CYaNWrtNz4tEIwGMYKJqiwSsAEVYljkc+Q2iiCfK2nnIjjzh?=
 =?us-ascii?Q?14auC1T5NSZtnAPtb9yR5E6FsKf8glrTztM5cw5FEewslKn2kthBPYSv3HHA?=
 =?us-ascii?Q?Ta7cAu0Q47HF9boBmyTAXmTAOhkBeUvo5Mdp7xq/3MSriA1CrNJQYDAfDr9g?=
 =?us-ascii?Q?19VrUIT4wAVamAkvPx5G0YfS+G9jhvyyZh8oEFxPdnNNySl3/a/DrIV5ytLc?=
 =?us-ascii?Q?1e1yQjwJM2fNk3h1HH9IIDC6jnOsrp27Z3MvUZ62XHT4YL9p8B2S6hVPJSda?=
 =?us-ascii?Q?OdzrMFQ96JtYB6PNTIIr4wIm63rK+Vh8EK6xtcV+Qh889i8slIurgHX54WTE?=
 =?us-ascii?Q?JXO3u2RCjjtY8BiptBqfXnDPXpbXhqWdQdqISTqBRJoFDioyrDXp3bA1+8kk?=
 =?us-ascii?Q?psopC0OJCn2RCTrCDaJQJrWEaHBKlGkr9v8pTWt2Hj1tBmRq4hANpzISnMCe?=
 =?us-ascii?Q?WN6/v8j7D3mSxwA0h2ZKr1KvuMKZgAmC+uslqGg1kPniHSADw5yyc32m9jp4?=
 =?us-ascii?Q?ARE+kCcjPidHQNSYzs3K+A8s9G4+w54sB98Aoh3VwkjYqpr3mgB6KOJottn6?=
 =?us-ascii?Q?mIp8lAwVIrWIlFeFF68SCzV4nhrRB4BKQzb+FhjCIfw6UXMBr06WUQBZSNPk?=
 =?us-ascii?Q?vLUBAOtKJ0AKA4zFyE7rqNkP7LC50HXfqIW3EbDJiae2VwSMWc/1P0xp21dX?=
 =?us-ascii?Q?QvVX0kJ/9m91dUTRqenWnNTFDDiw6CooPJ3buFKTrHmQ45ssbxvnMTO+kCVe?=
 =?us-ascii?Q?+eRFIBUFlhw6hjyhqzXoY1k+sC5IAeDYPdoRKVqQ8LWh3S8THlRpR/l/Rka0?=
 =?us-ascii?Q?JPR7JUEYSToDHeGhSpRwUCS+//VjxeS50Fbpgq/kUkshr3zGssz+CLFnIBfy?=
 =?us-ascii?Q?SO2+Q1IysMCP1VJtlI4+GPup1ikTnqGFvDg1BwLTyeUT2loB2WGsKGxMmHmk?=
 =?us-ascii?Q?bLqNqVSI+gtmpHrZqAdidMLvW091dgQxqhNyTx4gGqVdCHI4XFC1/l4hkvX6?=
 =?us-ascii?Q?C5UP7AfDMM+gUHcgTccoI0j770qIF4f9T/NlszFhUpKWaqJOZWhXcGAsH6hY?=
 =?us-ascii?Q?v82UE+ynStb3E3mkI6hu1LuoMkwwIoX+c74p7I7jS0y1o8Qkqj/7qCGWvyCv?=
 =?us-ascii?Q?K9v5IW+7q7dfW/4pi61mjGUEdsui9+BCL2oRpqntzEVWC4ruvNhrV7LvB5WN?=
 =?us-ascii?Q?rO54c9klW4LE0sAnNEb/RLJk+SavvPsriN9GE1tnnXlzK/98aYmzksgIanEP?=
 =?us-ascii?Q?2W/AIUtwuB/WJg+FN7M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ce22b-5aac-4482-e22b-08dbefe1eb22
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 07:16:19.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0jmkmel0JwrovwP7dAFHP22QfmI5cWgSfy3bLnxKlbALJlRtc+TruSH6FuU2wtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi bluetooth experts, 

I am learning user space programming for bluetooth. I have tried
a simple python script as a socket client for access /dev/rfcomm0 success.
I created the /dev/rfcomm0 device by "rfcomm bind" command. It works fine.

But after the rfcomm tool be deprecated in bluez. I didn't see any
successor of /dev/rfcomm0 or rfcomm tool. I read this article:

http://www.bluez.org/the-management-interface/  

Does that mean all scripts/applications base on rfcomm tool and /dev/rfcomm0
need to be rewritten by using bluetoothd-dbus API? Do we have any solution
to keep those old socket scripts work as is? For example: Forwarding socket
request of /dev/rfcomm0 to bluetoothd?

Thanks a lot!
Joey Lee
