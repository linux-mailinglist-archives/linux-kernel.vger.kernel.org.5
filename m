Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C497CCE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjJQUoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbjJQUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:43:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F79F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvgn7yJB+D2MhdKQgA7eVqTYJs58XM5iWHOYiE+FubBMXUUmRGT+EW9eZIEY6x9SsnQy5/opQ48USxq+EqKeS2Itb0S2FQGM3oSeOtjmbSDyx4ZEU6BKSh59x/NpyLWqVddAzhdr2xqJ1GVMIkkiFRMboPMZvXizQmQcBMfuRBd1khgrFh5jR6e7TcatoOUZrUlKKlh7ilz5rvMsvDC38X0ZASdi2piIiV8PUNF1TaOEBy7aKVzGRNYCXmdR1gn/JNANJYZxP/JLP9g7QTwFQhrJASs/df1EbchdfTnD2y8oxGBKQK5HzGQQn200C2wQ0PS1To7H1YfVKBFXBeF2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2M/ox0Qo8eKJQJkgSwtPtsr8FbERbPzAUXwxFErjsw=;
 b=V4O1j4fzPQeXHB8Q0GZ5MaCSJNvIrqw9l1uM29Tdk+vo8zLA+knNRuObvSZV6X9QUFI0S11C+cj/QbgsabLLBkAaiUIYrhJ1uznI+8BZkjjKMMKZjo5A14NXbZ4qLSc0tUP+R1QpbveYIW/unSsv0Icj9nr8HuGZbM7qZhB4wpnG6/dwDrTP2BgixyC4RyHSa9cXpSVtZDoe88BQ7/XJ65QGSdh/1FVgswf5/AMYENS40XeLNFutoPq3V0AlQnwxsokns5ZoRN5lUETSApYNkTZDzu86xMByXvJpV1Qt1G+GCkFEOf75CwohROKnxz1Wt60CEKgogSY7szC8dI+W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2M/ox0Qo8eKJQJkgSwtPtsr8FbERbPzAUXwxFErjsw=;
 b=HU5o4sPV12V5xvoDK/QSZ1LPQ1+59S3d9FUQe4rvEY5FHl6aI7zzRONPYXUdljsqSwCAAs79QfMQq5rckVmQyiTUhUY9YAFLKgZ9y95vSyZP1Z4VryIW7IyuwVKUz5o3+a4yxN7cx3HmBrWaklQWF0807Z1K12T/86o5I/PtF+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9218.eurprd04.prod.outlook.com (2603:10a6:102:221::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 20:43:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 20:43:53 +0000
Date:   Tue, 17 Oct 2023 16:43:45 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/5] i3c: svc: rename read_len as actual_len
Message-ID: <ZS7yATy4RmLVFohO@lizhi-Precision-Tower-5810>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-4-Frank.Li@nxp.com>
 <20231017160729.58984467@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017160729.58984467@xps-13>
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3f00bb-70f7-440b-b1a7-08dbcf51c626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXbHH5AuGCUSE6nX4Ppv/Csp/z53yoB8Fzm6U6nZsM/x6UEi3P13PUHpqa0TygDu3N7+tUjfwpPaLPNXFwEv8Dy9UIr/4FvGcT5iOt66nNgq/PpeEsjeeBCJLmxN7scjEhsJx5SgqCaqL2hQjzTbTFqBYCnKUa37S59BZ4OYSXFnFXrssR9WzjPdHJbHSxmHf0h5KmQJ74gQhBNOQiSHgvcZKjt9I86zpqQzVokx2UvQlF9/4LFIn43XZyQB7RILSNXJnPYbwziTnTzqSzHGDDtXi4kCuOYmsN+FQM1ox+1fm86d7YwB6TBdoU1SegnCdytv9Uw3uznjV/6L/7G5DJveBWhhVX4WxGV3ElkGHiIe6kKM6FJTMTpxRQ4jjJrImwic/r/hvEMGQQhSdxerbTk3npyMTkN0RenJuM2EXVGDP7Uh5F678Xm+5kdMTzLqpzaUiYt1mhXDKUx8qfEqy3JhrlAf1yaKbduewowJpE/Nv9IKt/XFNLW+pIaov1ZHM4v6AjViHqw4U+7Y+3tRw4G3eghEuaKd7WTLno6DeZUh9goQ0NYSWXMHCo7prjEw2Jy8IRQftefiQ+4OrbPh1CEZ7+hLCmc6QOqTqZJt25xmqYvT3qtEX6rr6al847rC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66574015)(26005)(41300700001)(83380400001)(6512007)(9686003)(86362001)(38350700005)(38100700002)(2906002)(6506007)(52116002)(33716001)(6666004)(4744005)(5660300002)(6916009)(66946007)(66476007)(66556008)(316002)(8936002)(6486002)(478600001)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Vf2fnbE6+1gsj738R5b0bQf39CjEO+qLRhkxUfOlI0Sim+yQmGrv7NIPTE?=
 =?iso-8859-1?Q?6RyXZW+jzqm/Nv1MpkG589kO8+PfT2URdy/D7BLdrrVGdip2RFZnU/7oBt?=
 =?iso-8859-1?Q?WZ14RzXIcSMlM4LxJ8TGJO4FVxUZbr8KVbXXocYvyl7X+yDYfuHrZDD9vj?=
 =?iso-8859-1?Q?UmjHqxrb0DNeRL8znO5NwCPPEHuNG9e62/vXmy6cKYGmlOVrbsOFBp/C3Z?=
 =?iso-8859-1?Q?Eg7kXNwzbwdsva+dy8BJkYDyCqYJeFWGyjOsH3lsVH+C8d4UaZbw5JEUpP?=
 =?iso-8859-1?Q?mzMjTNCHF6U6nr0OFdamTjdZn5vuD8a3eeakXH2dROrSQZYAddGwp0WiiH?=
 =?iso-8859-1?Q?ttHtHde2onM+KFv799oF3Q5DR1fdW/frRG8wrEwF05VVF2TiV1pavyot3/?=
 =?iso-8859-1?Q?etSATfW9rlcf6HVnrEdi7sbhAWxhHN9ubUhaBABZJKw8jwLDHjIPHooSmW?=
 =?iso-8859-1?Q?2TmhMggjQdZ8C0L4IWlSC210/yoDFXnLMtPzI8oBVZZbt9OjNF1GRK5EXY?=
 =?iso-8859-1?Q?HHuAY5D3gU+NY8aQOxpU48UfdiEiokHd+ZGoLtdiislaVED65yo5utXY9k?=
 =?iso-8859-1?Q?6WQH+U4If3Ze9DsWyiU4Fj5qdcKhD12W7ZPutISJyI6D5RPhADe4c0TrrU?=
 =?iso-8859-1?Q?ExSeJUa0SlBZSjOxZ/ZWTeL/BI8NkyFVgNYVpW6if44m7PGLTpUbCCBS3v?=
 =?iso-8859-1?Q?1eFJ3ajb2FpqrVc90OhHy9yPROGKyjSgE2b2xHOcHnUOnKG8DoqPddm2kT?=
 =?iso-8859-1?Q?ZiQ2o7nJWFoWfy0GyNscRPS5v6DQPaSJ6cdWDQrBiS1q6JMOKysu8RM+E9?=
 =?iso-8859-1?Q?39/CFa7qkzCiujL3WJyXE6kC+Eznr18jYIYY4Ww2qM8Apk/vzZSXCHTL+k?=
 =?iso-8859-1?Q?lFc4xyMrmkYh8Ty1IAqYMGBjyNXV2fcS+OR88cu1+cU9IE7KcE/m1BwiMO?=
 =?iso-8859-1?Q?R70+O841zWgVa2UcWPdfgQwSWE8GA/pEXdyeIzem0TLUgwNyteZhGPgtDb?=
 =?iso-8859-1?Q?yh0kP6asNGPJZJAqqJ3BsKvbpnzvSsbUCJdxC35j7kSqPSTD+7pFgSEBO2?=
 =?iso-8859-1?Q?Kz/OR35ni07uaC6s6mg7Ph3pezNfXvIhFpkFGs+cVWIPBJq6OEsrKjxx5o?=
 =?iso-8859-1?Q?P2ZSztwG++mNzPVVVOXLC2sWboNkeiOSglzwQfL0thny7ThymEUfo7/20X?=
 =?iso-8859-1?Q?qMcvbv1QhkuHBGCB15tUsgjolVAVlZObqW/2nzdCdH8WmggO47uOENbDIi?=
 =?iso-8859-1?Q?ivqLRQlSBB65FyoeHaYmWAQU3/lNa92KV7TMBF4wpPc7xmqhtF857Xv8UL?=
 =?iso-8859-1?Q?wSeKzr8LeEjyGKxIptXRpSG55IFCeBnEBnutfSDAkGMlXCXJOrVII+2cXY?=
 =?iso-8859-1?Q?aIfT2dMVRsM/PQWXZ3j4kaDCSQZ1oCMonT3MSWwhmGVl+IZnQaQjCFjAZD?=
 =?iso-8859-1?Q?6oucFx5eK5ViQf+9dae5bL3XT3rb00o9iqCnUq527cs6Gv/nilx5RDYc1P?=
 =?iso-8859-1?Q?HAhZjPlZN8MureACt0pPlwU21FmneZWmRNBv0uwf43hQZ1a13puxKPEi6d?=
 =?iso-8859-1?Q?Quoh0Ahgt6iXjgZ4IjQ+iwVfB56CBEUU1hfovuutXi7anjOHefRzoFxA2R?=
 =?iso-8859-1?Q?oEhFtOaElVXFXvUrW9QDDBB4DeBz2wpjlL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3f00bb-70f7-440b-b1a7-08dbcf51c626
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 20:43:52.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WB2i2/KjBf2XV3novEdKYIQcuZ45Qf8T3aQVa+UE/5j/kiHxZBfBlLe+duwNQ9qhyFVuGFyOWMd1uRHa5xptBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9218
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:07:29PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:30 -0400:
> 
> > I3C transfer, target can early terminate transfer.
> > I2C transfer, target can NACK write transfer.
> > 
> > 'actual_len' is better name than 'read_len'.
> 
> I don't find read_len confusing because it may mean "how much bytes
> were actually read" rather than "how much we need to read". But if
> actual_len sounds better, I'm fine.

Another reason: According to i3c spec. 5.2.2.3.6 line 6090.
Target ends or continues the write transfer.

in HDR mode, target can end write transfer. So use 'actual_len'

Do you think I need add it to commit message

Frank

> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Thanks,
> Miquèl
