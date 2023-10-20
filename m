Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9E7D116B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377539AbjJTOVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377527AbjJTOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:21:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6D8D5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWLNbzFs1+wGN+QThyRPJr3fUSroZqjyK0w5ODsoL7NKegceC/D3bj038LtWD/6bL9CFEemiibrUIb3G6SNhx2dlSmYQkblOZ3LpnUHXOqJnJbxXUE295AwF49OIS/2g+U5Wp6B9jxVG60WKeesJlK9iWuAv1ucK5D9xOz/mf6D7USgc+1Z+ZjcLWsVP8yBrg4Nzt8tFVZqGZQ8w0TKcArwhpMlKbMz8JdrZF8evGkCEXn5W8p2HmgnLIe8MA9VTavDMhgBF0ptpecgzlF39vfZfCkqNpXNvxL95u8NltA5ILNJHodpBXd5PdH04mu2Ex7cK+NMQ9gX19rhznMteqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGTavYzMU6lqaWzOCOaheL+FHdUYizenARmC4f/D4L4=;
 b=D0S9MCImstWO2SqdWj1GB539TYNuQfWxD1IDVjL9h0drVYkR2ymc/RBh64Q4BN/gqh6pPuMqWBY28l4Ls14UDGkqNK7Y7TdA8cH9Y3hO8lbf4OpFEouY8jAr5WGda3SvhZtEAP6OZszhgS00RXHxCkB1FJylx9Sh5GOyaIQ3KGm3XaQRLKe5v4g3EYmJmqu1Nb0TVbla04WiY5lmwNpTZhlUTMb+0E3KIfBvb9QBGcOwd9K1tLvUZRBd4BISCnfP6U7t2qriuMFk8hEcEn1aK4CjpDR/z1lAPVM5OVNJjFINW9DEg3MX7Npl2mFYKhtcXCNgVDBtRmM/h1QVAFs2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGTavYzMU6lqaWzOCOaheL+FHdUYizenARmC4f/D4L4=;
 b=PY0nPHZN9CZjIMzV9LApSy42UqXFzeCnNJnr2w+TQreRTBvJsZ3UNzNvQnhgn1e9J/aqUxXqJgVOGHuM924E+31kU8odTZs//LM8Yd/PL37a4/nCuMUXAcCR2uUH7obGiFm1OFUWLLRzSse+YAN/DJBL4a8WuAUEluVBgvRXLTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.9; Fri, 20 Oct
 2023 14:21:04 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 14:21:04 +0000
Date:   Fri, 20 Oct 2023 10:20:57 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>,
        alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
 <20231018205929.3435110-2-Frank.Li@nxp.com>
 <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
 <20231020154528.2f5f68f5@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020154528.2f5f68f5@xps-13>
X-ClientProxiedBy: SJ0PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 0559ed9d-6a96-42c0-c349-08dbd177cadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKcyV3OHakdnnZ4Onj8347Lp7U70JX8YVRrXSsLfCYw8ZgKhhMx+l8x41VniouD4h7djvi23aYa2jl39j4NbXtPz0gZF1XEz4K0dAY8k0MZIgSfg2a2cHQBK14fOeZ3PQRDC9N5t0yFtEHZfV009uXWKQTmQ7O0AbeM1A6U1fNynSK80WAkdRHF7kTTTvtfn3VV6/03FtRVBftUahbJ3UV3bqWr/xU4kSg4REy1Q1K6HA1eeYZUXWv3W+mecEofXn/BIzFnUvsVWCyLQCzUyvbnDcgNH4IHEjytxVhx9ojtOWqsFwzFtGC/Wd/CgnPI940Kb6ovvvLof/82Ke5Sv4AiNy/qg689dBL1NZbJMlL2fq1IiZ2r7YUNZGqDiCau8B1AsShjLMWCJR6iTFb35oQmvw8FK+SdifzwlPl6aVlXXQkvUKLTSVXinf12lNa0ezB0JJiVYlUeR3IwKl37UJL2MjxwhhtVFxc2xvQFAFPWNB9XQAndEEtcSHLM5pOsIiUuA4DLLofmYbJ3Hen5+WUKd3Ku+c0gAPH5uQokal3bl3NQJHn0Yxeq0VLWmP9tBx3DEWWY+jXtWKdj8Ab9ZZmwAKjMWQPRYf+fIrD+99UkWgFYgn0rE2fYP61HMOlN4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6916009)(38350700005)(2906002)(6486002)(5660300002)(8936002)(8676002)(6666004)(4326008)(41300700001)(38100700002)(66556008)(26005)(86362001)(66946007)(33716001)(316002)(478600001)(6506007)(9686003)(53546011)(52116002)(66476007)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yVkOVRHy+/2Sum8oGpcgkYuortQ7JaCXegiwtbdVKb/A1ZK3WET/yFvQDr?=
 =?iso-8859-1?Q?EiHLb1SiHKIdc71YfeEJtCpyXfc6980Wc6aQ9rZZzCKKkN057tM4NDYIQM?=
 =?iso-8859-1?Q?68RRc2X+9MWizTtglV/+Wc61F23/9r0v30tgtGEeeWIMihM5gq4lgqoSPI?=
 =?iso-8859-1?Q?oetmiCVrn+ewJQZrmAj2WOGiIlWcnRGcWHO5Co3NTaQf4sZLOeNyMoEFWz?=
 =?iso-8859-1?Q?bwD4clhFASjMnPDE6yMTv4ubDQRziH5QCinAS/br8AkNej21TK97ixeEzw?=
 =?iso-8859-1?Q?RNyPtoN56y1fKvMilSACkXUbSzhrxVN5BV8W9L+ouO5aDYjrPaTQ/oTD5I?=
 =?iso-8859-1?Q?LA7kI3S+kWNgSRiXPRoBoG6/bMYwUl2t8Bex11pwMuu9qSeTaqEIHMjo0N?=
 =?iso-8859-1?Q?WUTF/MA9wH5UPM/DXdf4nSrzGPctIfWOcJTa1b/qEbD1Cw82w6w4V9xU84?=
 =?iso-8859-1?Q?7Klq0LukrYk1bqxV0n9n40dNE8uTd62lRhG1HDEv5TFA2Rr/dltzhrrZk+?=
 =?iso-8859-1?Q?AX3qF616AX0KkUvqt1aVHSlAIySdx4y1OlJv5jkge9t7GqGH3tB50NoxUm?=
 =?iso-8859-1?Q?oJBPaO1KOwwXD+Y/EzZcCqb9Dq1M/3MU9/l1eDY1sB01dZR+u+WBMVN7hU?=
 =?iso-8859-1?Q?7KD/6UCYZkVmjoDbMS1SpoVkUR6NQY389iqwHhC2Mx3HaKMB9gD0WpjBFJ?=
 =?iso-8859-1?Q?2AMsA8LAfAXMFpL+BAK7EdRTUWhCk0P2CPos9KgtBi9VV24byXclnx9oMZ?=
 =?iso-8859-1?Q?KahRe+T8h5CJnSClARbr1MileBf5uUGiw1i1mHfG+2AF1sKlJnW8ldy950?=
 =?iso-8859-1?Q?I4WPR3FE96Oisy1hzBgUcDHXutFaDlMBedihy/lTBJ04/m/GMxuNI8WsU+?=
 =?iso-8859-1?Q?QKWRrLR+1M14HRFxAdUGTSyA4NIjoKYydAF3kiHCTKbLO6VFZ33QFwEX7+?=
 =?iso-8859-1?Q?r8yfCKT4geR9eWTUrEx7yQXCBTFgETBOmDM2ri4fvhxvKH6ZbS0DxK2m41?=
 =?iso-8859-1?Q?qrRYhGHqM1ppAMTplHg4c2eRkjmcymGP0KUON3kLHW8qw0mKwji3ct5KcM?=
 =?iso-8859-1?Q?HUJ1Twow1SYGMoiyg6Ldf0+KeNte6PhG4vWolBseXELloa4Kx0Ax4zCcMj?=
 =?iso-8859-1?Q?t2xD6eBic1RHnhwRlYEPFT+rI00twzMuTYEmVLoH8shY/SIRLHkYpx/qcZ?=
 =?iso-8859-1?Q?Pn4W8mTbJgX7zDdP62Sc3adyfxUjRIefb375SJzaBnmzlcJz0KPFyuDB8P?=
 =?iso-8859-1?Q?+a2zkASlIxppN6yG3aceDxNRipgs/hVAd1Fs3qd6v4t4pZX/RMXp6vHUzK?=
 =?iso-8859-1?Q?XgFba87BtaOZSP9JlD91b2dKNJ0UlB6JrenGfIPReh2+nRBsIUO8HiekcO?=
 =?iso-8859-1?Q?v9VW6WsMAutvGoPKq+fHenjEU2kj6k4s+JA+A2hrARX4bOQMpL67ri0oxS?=
 =?iso-8859-1?Q?UyBFqUPlCmr6RQRyX4gbNjlOpzlQvgnW7buWI+CcQtMFWFe6nPDc8RGU7U?=
 =?iso-8859-1?Q?Z9nfYAjS6I8y6IGSGO4LECZy+T74oB7J34VQY1XIcRmevwbw2AIFQ9r+Hn?=
 =?iso-8859-1?Q?l3tvWW+Ml+w4I/1NbP69o/OjQw/o8jmvhsBywdLwr2PYnW/nTc8oXh45Ts?=
 =?iso-8859-1?Q?bMyv1GDnPYf4i+ee6Pb4Pyos0Ndiz+Hesx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0559ed9d-6a96-42c0-c349-08dbd177cadc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:21:04.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SCxUJzzXPYp/5XfN8ZbUDgFlTuTZ4Sl9iJOUFnKrAJ2TEtvWDWPmtp0LALt7yu5mgpTwDRWBAn7hdgTW8OGsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 03:45:28PM +0200, Miquel Raynal wrote:
> Hi Lukwinski,
> 
> zbigniew.lukwinski@linux.intel.com wrote on Fri, 20 Oct 2023 10:55:27
> +0200:
> 
> > On 10/18/2023 10:59 PM, Frank Li wrote:
> > > Add hotjoin entry in sys file system allow user enable/disable hotjoin
> > > feature.
> > >
> > > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > > Add api i3c_master_enable(disable)_hotjoin();  
> > 
> > What is the use case for having HJ enable knob in sysfs available for user space other than for debug stuff? In other words, does user space really need to enable/disable HJ in runtime for other reason but debug? If it is only for debug maybe it  could be move to debugFS?
> 
> I don't think hotjoin should be considered as a debug feature. The
> problem here is the power consumption which is higher if you enable
> this feature (you need to keep everything clocked and ready to handle
> an IBI) whereas if your design is "fixed" (more like an I2C bus) you
> may save power by disabling this feature.
> 
> A module parameter does not fit here because it's a per-bus
> configuration.

I agree. sys entry is more flexiable. and let controller choose better
power saving policy for difference user case.

Frank

> 
> Thanks,
> Miquèl
