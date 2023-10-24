Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3847D48E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJXHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJXHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:48:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14310B7;
        Tue, 24 Oct 2023 00:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCAcKJSLpBXZj1XhbFuJK+JndP7OdyevKIgmMccfdjau4IuZKRHpCKAh+2Tr17yH5n0Lt4XlRNwnBfcUiUW0CVzDZXn6DETD9K5RZDoNkxSXZMmx0pa3KIrUzF4Omy9hTyAzPeCicFJMs5nPNYhrUfWOqaUgZ0yL+uDJrkHdqoI4Z5kGKgtmrjfDzOM1JUsJzjrL/nEWti1C6Wx7MOs4sVHye5/EUK+2+Lcgxx5H/2AbRvkMJz1RJCjP5MwPzl6hByXZtnfySl4nFFajd9gWamU0CF0j36mTEO+UJyZwRyJ6N2dTRTPIEEjBJzXGm4PX5WZ3eAvg29G3eNExfopQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWlumz2tMRZ/Zl5ztl1sZmd7Uwr7rofYT/RZYVxGLFQ=;
 b=k1Lf3LQfwy7UDL1sXoYG8BFGimtN4/Bct4Quk6vaoTZXcf8ggSZf0trrB43b/V8+y03aUEi8hNQh6zdtkAX0/D3Kcxk0FWezXZ+dZ4EkqgI1dHxGQQ9ho+ycV9Lx085joTOhoNzFdkZvENX0CBO2FxN03qKrdPk4QCUI38Sb7mas1c75LeopJ3T1rvg6gx3uStvJWtMjm6cog7JgijXhqqt06z64M1YSnr5qBIaKgeUOInw14NSNM2qlagHTUcQPoK0uwaF6Mh8yDfTsDrnR3EXYvqQeffOpsoQb03wjQZk0uiyrhDsJvXPdYOHXsLEKct64ue6VKPx8tac8miMg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWlumz2tMRZ/Zl5ztl1sZmd7Uwr7rofYT/RZYVxGLFQ=;
 b=MyMpmu3fBmATuybADnhWCmKJdpUbrmirzQ2oqrZN8Ck9MA7UxqQw5GnKIVSw9WJfIZ+3iJZwfxQm1eMyEmFeQJNYm2T34P+96jk+VvgGuMXAX+xD1YTOneojOEb0mmJkR/hqkcH5U4aBpMVpXz2aABwNAQMY1TbkK0e9gOC9m4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by PSAPR01MB3909.apcprd01.prod.exchangelabs.com
 (2603:1096:301:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 07:48:12 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d%5]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 07:48:12 +0000
Date:   Tue, 24 Oct 2023 15:48:07 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] tty: serial: 8250: Add support for MOXA PCIe
 boards to switch interface between RS422/RS485
Message-ID: <ZTd2t9nsBx9pZKD9@moxa-ThinkCentre-M90t>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
 <20231018091739.10125-7-crescentcy.hsieh@moxa.com>
 <f49feb43-e255-43bb-4271-8a13db2859fc@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f49feb43-e255-43bb-4271-8a13db2859fc@linux.intel.com>
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|PSAPR01MB3909:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abfe152-8d04-413b-5b5c-08dbd465928c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ln0rXhjKkb6+lRDfwCmqB3mhM4f6n+euoPxNXTcsS7uU2HGPDNAt2cxInITtmdv6n+FO4cvQ4/v+lhTURgnBenvrV+4UTIJf6faNonILkccXZHpvZC3Wadso3wy6iRS0BhUiam4Dy5/yrBj8rhTy/a39QEbXqh0KuYi8N+ck0UYATlFG6WyztVud8s8ikNA68XSFgo7pwEIgXzGrejyDrH5X91Xyj6goRkfFe7V3lVfg51eb0IWcib39OeYB2b9xWIIcmmHZSlAUN2KiwApGNrHj47vb6KLA/XH1KcyXYO6JUMysU4UGxksoMs4RqTEuNtqp0WeycN0yV/LddGCEcBNC6+SHMlFHm39n6LPNq1/A7jgdfNnjfLAaBAiMXr8eKxnHDJVx5MVh9hLdKAOT4Ln9njz1dwkhRDu5t+cm53UkUsFJozPEckOnlm0bynPc/fJmIiiAHYeuHgrn1PBIYcZNVdwexUgx7KFMxh+TXdcjhopjlIdaUjmMnj1tKwBnvObM0dtw6qJ+B/QfGV2P7ASlrMWveDu+tNiYXT6MixvRieDxIFE8menRDkK91rKsKTbXxDWe40kLqlimWYfFnytP3BRgnDHusPBlrkf8tQ0dO9F4aCjTdOE2bjDkNHTW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(366004)(39850400004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(33716001)(26005)(38100700002)(2906002)(4744005)(41300700001)(5660300002)(86362001)(8936002)(4326008)(8676002)(38350700005)(478600001)(6506007)(316002)(66476007)(66946007)(6916009)(66556008)(54906003)(66574015)(52116002)(6486002)(6512007)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O1TTBCWgBqjZ6QKhDV4whnpsZ9pmRNkLWyAXMlhWtxHMhNpf0IMt5AX7sp?=
 =?iso-8859-1?Q?nnTohcMMxzoj/P/XZpb3aPcxJM1hwm2jYju+RMlRGEd7+Ek2Q4ys5Jtygc?=
 =?iso-8859-1?Q?5yOP+lF5W1WUz+DgZ/Bd8EkRIOEX+9N/iLcbLuVCYBHrZ6w93w36rnYWSR?=
 =?iso-8859-1?Q?4STzhwERXSKFydb6tlx3vGZ9Ee7ahNCnDcj7uF/QtPJjA8OoHLbL8WJavO?=
 =?iso-8859-1?Q?PEKx8eURm7GitXX0wo7q22au9ndhHV4JtleWityS3gikLr8AxnHD9QttXB?=
 =?iso-8859-1?Q?BpilQDyzUKsO66iPl3C6082mZzsc6G1H8xPO8/4GohqY3Y6V4q8jfKB30i?=
 =?iso-8859-1?Q?FgOkGMgJKypaLe4vM/zux3UYr/tFU1Yv+5Mncs6l96oHUrZQ/PPFQolSyn?=
 =?iso-8859-1?Q?s1nIbbuB+wRY1OchDz0UUHjK9eM8HQgYCbbdWdH1KkihbljL9iLQqSNtb1?=
 =?iso-8859-1?Q?2oqb4OfxMPGMUCj2GQtl3yA6VydTha+3EKbTtWIW4cO+3OMB5guFDjxO3L?=
 =?iso-8859-1?Q?5gCkN/FbpynFBO9u/elmA7cccfzM5HHsfcHY31iPcbJHsyWT7Z74BEvezh?=
 =?iso-8859-1?Q?b6dz3FTP8qeAu0Dbj9tUnkVD3xZu8LWwech80CM7hVknJEBO/vJQacG0h2?=
 =?iso-8859-1?Q?Y0eLPP9G1BJ1ZDWQA+0smZ+HbFdtx2x8WoDpmwgz3Q1X1Yf7046ENq/7lb?=
 =?iso-8859-1?Q?lmFknyLVsPuxMlzH5NkKDMENGm7Fk7eprWc+QK+w5KP2u/unN3ESwhD1HF?=
 =?iso-8859-1?Q?pFfUfamrG2wdggtz/kEwGp+ypwdeRzlCQnADgkvMpYE+OUzUXDNU93Kmdc?=
 =?iso-8859-1?Q?64DZ4clbwsXkS3bqql06Q02SEQ99wcQWKLFGiJyyW3xcbDaY5meUeU1HcL?=
 =?iso-8859-1?Q?zWdsPRLBd8i3V+H5bn81OLUrdSCIoAdBEei3tc56fP24dR4e6yBQoI/9tz?=
 =?iso-8859-1?Q?EuVs6Dz1c3zeqfqrEUx8se7BWVtzISrhUacW2DeEt3KHIe/AAu5afJEAHw?=
 =?iso-8859-1?Q?hNyjOo6D2YMKyNV7vEPt6GseZLbThvw6h9u6jzbiP7cbFpXTBc1MrKacGr?=
 =?iso-8859-1?Q?A91k4eJRyxhAIF+PC0hnuY8DrnN48SlArezXnUbM3ysyZx8MdPsE3SHGOo?=
 =?iso-8859-1?Q?S2f3YebWirOw3R2/i2g1E5vJJHhHYDjUBp9hghWWPoFSvzUErnq0SyefTc?=
 =?iso-8859-1?Q?ZHBK18gAmul3KhCerbQnkpafLgCNRdMFEY57VB2aIrqPUrWDK5jEsGzDZi?=
 =?iso-8859-1?Q?94GjS8+1KQf7W4+usN03k9ZOtLlQsYyYsnB+0ZxQgkCxTlyfeFsjaLiLXU?=
 =?iso-8859-1?Q?eNYcYFLQdupba5j//PXvoS6zcv0AgKR4hqgyeu//2jeodTbtH43S8+bDq3?=
 =?iso-8859-1?Q?XmuodisbTn9h7ZAL04A+cvCTquhQ+AAfzjUSbmiJ8wLwt2sekc+zbq6twi?=
 =?iso-8859-1?Q?HvOD4hjE0PP2F7eTxgGq/dPqi2LZd6D9Ly3dDdvaYwY7DT3lrnGC6baYcL?=
 =?iso-8859-1?Q?AQSS6uuQkIIVNGpOvW1xaLwjaofQBmgsEr98YC1067N6gaupqwWjiz8AOw?=
 =?iso-8859-1?Q?A41cYNON1nIytdM1HMhjwovjpd3xs3+ZHe/FvKn8Fqsl37jXVDoKojOn3f?=
 =?iso-8859-1?Q?kf4ddiKTi3utCwA+ffjWzhvh/wD36RTNZ3qu0tU0YjxjK+DEX2A2qv4w?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abfe152-8d04-413b-5b5c-08dbd465928c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 07:48:11.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smEYsqG+jzZROrNDUz1iR+Ez+gcwY5MW9dVI3fCyoSppTqWULk0SKvUN6xBubv00g6Iam2jNNWU38UZXUEgT1XOKF842YCyu+BeOD5CZI9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB3909
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 12:25:18PM +0300, Ilpo Järvinen wrote:
> On Wed, 18 Oct 2023, Crescent CY Hsieh wrote:
> > +		/*
> > +		 * RS232 is not supported for MOXA PCIe boards with device IDs
> > +		 * matching the pattern 0x*3**.
> > +		 */
> > +		if (pci_moxa_match_second_digit(device, 0x0300))
> > +			return -EOPNOTSUPP;
> 
> This is not the correct error code I think. Maybe return -ENXIO instead.

I think EOPNOTSUPP or ENOTSUPP would be more reasonable, they directly
indicates "operation is not supported".

However, EOPNOTSUPP is used for network-related and ENOTSUPP is used for
NFSv3 protocol, even though they are already been used throughout the
kernel.

Maybe add a new one stand for serial, or clean them up into a general
one, or use EOPNOTSUPP and ENOTSUPP just for now?

---
Sincerely,
Crescent CY Hsieh
