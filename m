Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32B37E3464
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjKGD4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjKGD4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:56:00 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE25D47;
        Mon,  6 Nov 2023 19:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVLzb8J3tkJ3UqXqLsfCQBBWFIoqXLGhCWY+e3NB5cYGeZ0mQYSzQrnw51dbtBMWzIKYSBbZPFDXgeJ64dXxqEDqornzc7P8GlgTMDTUPBv98pdcQ0YAM90XpXwHJILSwm2eNwIX9Vnfx45S2kAF7zhmgpsp53aKe0ry8kSMg2fmoTVubwWCItAMs+l/MfuoGbATBeL//kwUtc6t/uslIkuWFHM7xPy6x2B559Fd7wSEA7CKVtPwff9DTW+HsD7XNRKqYPJ3dZFJIhJ2S5oPK3A2Z2EE0NoLxKyISUGyDXGfqrOCAGo5zMuaojDAl5yx01vCXbZ/CDtb3o0z6zyZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkUEs96IigMvvwB3kVgDVdol58FZp5sCOOpxA27pf6I=;
 b=g/D2EZ38wdU8Z2AXe3PFJ9DlkJn+KjIpx4RU3UAMIxfuT82q4eNSN8/GzrIJevB3ASYP57DGKgoJJuJOjeWZ6YzFGiLVM3RAu3fFH5twXVE/RTLMBpJ8DTop2ITFUygTH1LkqqnuDNaXlI+pF99KbiGj0zxK0nDklXyIg9WlWnUU3bvnxGORgXwsa5HriSgjFIAxiPewefaf9nGoBRsAQP1web1dZAaU0q4XKogid8tM2r0RteFulVb43B+pDaw2XC2gsYeDeTlfObzF+30MHjg8I3K+Qz2xHEsv6X7LlmzyHx6Ehl8gqjZg/Q1Nd7ErlSLKwBnQlAtrwXBKfycS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkUEs96IigMvvwB3kVgDVdol58FZp5sCOOpxA27pf6I=;
 b=FAaB257293QG90ZoNAriWS98RScSPDSOI/7/rjIZhLUDu6vTmrlYWLD8ItdNoKueFe1lGTVDXGS7cG7ozqNkuGLtp9QL8YrUfLKJt9pDwN/F6tgF0oN/FvhgzoiVQ/zWSg5xJXisE6G2mAINisYJcAtsxVEenECtLfcLHbU6U5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4391.apcprd01.prod.exchangelabs.com
 (2603:1096:101:5f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:55:54 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72%3]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 03:55:54 +0000
Date:   Tue, 7 Nov 2023 11:55:48 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <ZUm1RD2icq+Vh6Cp@moxa-ThinkCentre-M90t>
References: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
 <0d203024-ba5c-4258-b549-b9304622978b@gmx.de>
 <ZUiTkyZSbbmTUGYQ@moxa-ThinkCentre-M90t>
 <3fc18b13-fef0-439e-abf0-1fe4e46b224a@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fc18b13-fef0-439e-abf0-1fe4e46b224a@gmx.de>
X-ClientProxiedBy: TYCPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:405:3::33) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a31937c-3840-4003-a568-08dbdf4570dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnxLal53P0a/4vrzJjVO7Or7MFSrOLvzOibmjWsp0oEwOgzOETfpt6lK3CO1jHOglt6VAum+xP/DPj8/w8Iq8Pbm+ucegSayKEE2DCNutIe5Ao/nq7ouQ3tGtQdTMmN6DexPS+ZP2S1CPeV5iZUBoOoG+EVa3JryfXg8frcHkvsQU4LW6dPpxojRre7C3uuQxtdvI8+g4OQG/0p8OeXXpg+4S5vu/00qGOT2Oyai592w9QZBK7QxoRa+dlwIzydCoa9KRP+iZ6tDjVsjb/yYXSLiwmoz38rj75xEvtW/PPcWztpWDiFtiPGK93Rv/8ah6ez+e1ItWt/y1Ay25k6tRP8g0fRoOIh+mhaEwYnJUrqFtbOn3gd2Tf2vPc56Ak1Q3OrpHDsBJC7t3RKQBKY/h55GFrOwlMLtLBh09JF39CAivJByufDk1wekJcAyLHV7RZb9o2kg/YV8kHTZjm0Y7LjiFMLptrhhSsAM/jaiJbnUTix2Ae0PBnDkpzp6w3oZKbatPsc8UocLA/uzuO13FfxqROPvycDYlhUBUQpFH/BTcIJErA6f08WwgeAAEhsu5RiJhZtbPL/PxnOBk3G7UXzRBeu5w25iT0r7LlP7dPN1zPC2MZw4wIMo/o602XIr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39850400004)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(5660300002)(4326008)(8676002)(86362001)(38100700002)(41300700001)(6512007)(9686003)(8936002)(66946007)(316002)(66556008)(66476007)(54906003)(38350700005)(6916009)(6666004)(6506007)(53546011)(52116002)(33716001)(6486002)(26005)(478600001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDzMchdir3S7zaDZFyOcL/oLBFmEO/lIOksQUoKPgcLW5GC5iS5Edmx+qLX0?=
 =?us-ascii?Q?n3U19IrHp5IouprQAbg3+GaiZWjrqFxgFJib+ybYx/U281Neuvmby6Euk8vv?=
 =?us-ascii?Q?QE/+ZG0AY4Jazr4gw55FB3mEfsaDy1SUshLYF/fnr/CR6vm1csO403wGUn8C?=
 =?us-ascii?Q?qcYriuw/iyJKgq9w0fvcNx9R1+25Dj/Sr8ZjizL3yzpLFBdLFWpNbjHkjwSh?=
 =?us-ascii?Q?qpDh05J0UvEWHf//nYHVumOyhjk8jcmRZfUMSXmP5zPy+SBWImGRWn84aJGJ?=
 =?us-ascii?Q?KHtWuLT4qaGVB2kxmCZiRILDAD/LZnRR+0G4/ol1saZUpVybpnWqrOzFaZD5?=
 =?us-ascii?Q?FAtfezaqJlXQQRt1xL+a5TB1VcWlFyYo28mYuiZTLk/DPz5z6ZPIDfg6v5rN?=
 =?us-ascii?Q?Z2EY/2+sIv5qW4/KfpZzYj0RYV/IblB8EyzeNB7maJ9MO2UaoeYM+26tyHco?=
 =?us-ascii?Q?2A/NUhjd7KAvi7+n9/dp9UrlzE8s2uhzORUQW0HdUdd0lwMiV3gDPd+GJFSJ?=
 =?us-ascii?Q?XGdWL7nq/z6bm42w7PuWRM1HPHGPjIl0uXQdCsT1YzVjCHCX3yTUG71Vm4R2?=
 =?us-ascii?Q?n+tDmTI67pDjvXbM8HqXD4Od4P/Q/WKuSJD/cB3H3M+laMYLjZTzdR8IH91K?=
 =?us-ascii?Q?zqeYPTQ3J1ZHsPms280yuRVUvqLwaFU/DeNL3kD08SmM5sfYgylpaUFbrp1h?=
 =?us-ascii?Q?QAY4bkbuJhfNdoukbBoERqrkp1EzYp0/pOLoxao+9ZjBfuOLF+Cb9GOPlxOP?=
 =?us-ascii?Q?g/FksmYRIa67hpgdePMdPUhTGhR+oMrXJFl5aAszOs/7+IATTxLyNsJwK/iB?=
 =?us-ascii?Q?TWcUkPoLAr+EjcYtzcd77uIvTOiOAZFTlrUuia2rwTa4dmt4cJ6vK8SVmEXp?=
 =?us-ascii?Q?iv6mKBRxI2ee3ftFMC3YYjybnOoHUJQ5ddNIsqRzsJZcacpZiaTN8ip7xJV8?=
 =?us-ascii?Q?LjA2FsAP3N+VTQGaOu0XvrP6WbinHKFqu/1tTV6Xv+7pI2myamcNEHrBqawF?=
 =?us-ascii?Q?Jw6y1W9k5iar9NmoeI0Ft9MErYXDAvUAN0Sxaf4ql1l6/h8vrMyP4l3tR4v4?=
 =?us-ascii?Q?oFBv030J38Mm6Kf/m7qvM38+xN/oZOLKXduC5F8ZwZTn1QTJdspVsoIRzHcB?=
 =?us-ascii?Q?iqtXSU5EBH0MejXjp0kqAvw13Xn2WfFL0QiU6JlN/xf7a8wq72FhNxmGsNwU?=
 =?us-ascii?Q?en1NVCIYWTNrmFpjZWTdTqqdy1ydj++XF6phM1GA3Ty8YqqMZVi/ZaOixyoL?=
 =?us-ascii?Q?c4EgaU1QRJmr5G+ifMnrTrnktqpJUSnFXzuQk7xPd6AVf5ZR9MbJN6cCSxhf?=
 =?us-ascii?Q?Cc6lZZJfnNKKIk9LHvcxK8NJlhDvktGiklbSIC/dMpPTaccf8CErzkfuVjxe?=
 =?us-ascii?Q?XRYX4eVj8z2kIr1r+n/VMLR+nIenDnnyunUNZe7mvL1aE86gJx5iTg4kqPGy?=
 =?us-ascii?Q?TLuT2wWhflG+AtrBdLPY3P2XMmp+PasmVU0GhlQQZ5DNB1EaoX65uRWuxKpA?=
 =?us-ascii?Q?obHyYvCcVqCp96u9Pzc1ST3oShC1VM1BESXAMRDVqJQs2fCMrRF3Ta59xxWF?=
 =?us-ascii?Q?VxgM+FCY0K03zGDFktQyYubmf8cvH81JI0HH/p5qTaDgfGACXkeVHsTNzrGN?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a31937c-3840-4003-a568-08dbdf4570dc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:55:54.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOJBG8msjFZD8PTScWW9anGzxc/F9jKDlTYCNqlyRBOhd5A0Ciz1/U/aK3tB1zj2HTaFVNTo4o5paQNwtBcKAhJos0yXxMn/yqQmeIx0H2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 03:43:49PM +0100, Lino Sanfilippo wrote:
> On 06.11.23 08:19, Crescent CY Hsieh wrote:
> > On Sat, Nov 04, 2023 at 08:53:18PM +0100, Lino Sanfilippo wrote:
> > > 
> > > Maybe it would be better to change the meaning of the flag: Instead of being a substitution for
> > > SER_RS485_ENABLED, it could be used to mark a special mode.
> > > So if both SER_RS485_ENABLED and SER_RS485_MODE_RS422 are set it would mean that we have RS422.
> > 
> > RS422 is not a mode of RS485, so I think using two flags to represent
> > them is much more reasonable, even though they are both included in the
> > "struct serial_rs485".
> 
> Yes, RS422 is not a mode of RS485, but you are already using the rs485 (and not a rs422) structure.
> And treating RS422 as a different mode in the existing code would make things much easier and keep the code
> clean. For example you would not have to alter all the code places that check for SER_RS485_ENABLED.
> Also SER_RS485_ENABLED and SER_RS422_ENABLED would have the exact same effect, so why use two
> different flags, when the effect is the same?

Agree, by treating RS422 as a mode, it would make things easier.

However, I think, eventually, RS422 might add some configuration flags
and should be distinguished from RS485 (Perhaps by adding RS422
structure or revising the name of RS485 structure...) But this should be
a future work and require more discussion.

Anyway, I will see RS422 as a mode in the next patch. Thanks for the
suggestion.

---
Sincerely,
Crescent CY Hsieh
