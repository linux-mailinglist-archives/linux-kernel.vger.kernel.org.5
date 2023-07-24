Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7432775EBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGXGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGXGwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:52:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0812A;
        Sun, 23 Jul 2023 23:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3SS1w8AavPO2Axe4pt3B6edsyZ6iGGEP2s60/Bn1EEohemXfZC2UKV2yb/KLoRaY1GkTW7DxEBLvUh2c/sZ0IWsCwbXDXBT/YjzhVYuddzgifYyzHtoVLB1j0OCM+zh/GC1em7wbbqEkWC8E+NV/tcfauue15qe3I0HW58geAPt7+D3C57n+jbY6d3Dj5a8igkcB9P8uBrlQ2/g12neBd9B38pLezqzas+Pfmt/4ax4GD5NY4j5hKu/9DBFhtWFsHC0hKHxFUEpoyI9rXTpAb/E977HA6Bxz/1cC7NHKzsO3Scb4KZcfn2GU0o04wfuLbSDz4hj7m/V9WFRNp6ZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54yKY+C8k4Miq8KeOUe7T2DpFtEBFBtlGA/kLMZHRvQ=;
 b=GXtTgC7ciErV5c11Jd1fl0YJwIatGjARQpbZqNYFFAM945dbvYHmI66hvwN3TQ/Gnad5Ls1Fi8kXmtq7PfL1/YZMkCX0FmOhpa+KIuvxYrEF5Vcc2CrIz9/cGlh+xVHd7R9JAOL0fB481iNWP3YzM0jPJBeJDc4h6DwCNHqiJzZQDo9aLFQCiW48flfNYXlubnyhtfrzXBorfyQsSsldiK+yG/4lqR9umQSThBlBnxuR4/8/g72qgP+x2oES0QCX/JBN1AZNlMjF74/QThBZQrXhvZSVazy12CIxXUZdqga3MnrzyLC7snVti90oDbML62+vyiD3QGSmCg9SN7XNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54yKY+C8k4Miq8KeOUe7T2DpFtEBFBtlGA/kLMZHRvQ=;
 b=cKnK/J7wf6VrmIfjfkaApmlbxETolVwxGPP8CZ3IxYXeZJxxzSdUOrn+Jc6FEAZdhcCJC8pc+2lMiF5jekC3LTrDr2jzg/SAGqP23yQQ75TCLU00al6A251Rxc+q+q8OJTeG4jOkSdlOlDTk7pJs921zHaRHm58fN2dsY6em5tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:52:44 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:52:44 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 0/2] Add power management support in CAAM driver 
Date:   Mon, 24 Jul 2023 08:52:28 +0200
Message-Id: <20230724065230.83017-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e770ec-3c2e-44c8-1c26-08db8c129535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIhLaWXFPMPVRdhZFe+Wle2eMKQbh629qt8m0JZn76JGkqJQxS7Qn+jvl4X625iReZLOY6tb96Ef5EdwotjSwZ0pObAU75hmizdQN/Mqlx3sYZMunW/eEld+fcb5xndD96kWLzuJrs6RB8maHt/Vk+XPzI3+2qD1ggiclGjFMB700W/QPox4KVsJPK5qDjBGMC6fvft9Rt7xNeNy/8zwm3dV2VxG0Q8dWsLeGURwQbi4/VvUWp0oiO1pTlJ+5oKBlAeGUWY5YIDvW2Bw8O6jJI/1OVP4xNA4RvSf5SLCcsszGHTstxAT0AbyblV+ktE7i5NFYIFJjLKslbI9oC/oR/cEQCt+uFV8ENL/cDm3y0JMz6I+ve73fVnuFNJQbW1CuUYZD2Jy1ZCX4h3F/DgmT2qY3d7y0ZhAw6bPyNQcBzdhA0UdCatKBWbtZl4dh5pdpH0DLI70W/JBc9qAtOw6Mcyuoij6M2bON4GYJyAUwNAGawT2QXt2qlJ58Qb/O8DTDuxDOCC/CNxsqMKdocn90tmH75SSYvt0N+9VFk+GaSGI2W2mmJgk5xTU7VYx6uT7o2IPhNgsQ9SvUjmqIVYVyT/9LlZtD+m8g2ECLsnzyhKM2UOIjq+lABkP2HI9xTdi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199021)(36756003)(5660300002)(26005)(6506007)(186003)(1076003)(4743002)(66476007)(4326008)(316002)(66946007)(66556008)(41300700001)(52116002)(6486002)(2616005)(9686003)(4744005)(2906002)(6512007)(6666004)(8676002)(478600001)(8936002)(83380400001)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTgwSURtZVRBd3E0a0wrUklDb2FqV2FtTkJYT1pWdElDVEhyNGtrbjRrUUI1?=
 =?utf-8?B?aTY5TFU5aFhBMzFTTzdjRm52NUMrZWorKzFTL3c4bmlLOTlVcUl0USsyMHQx?=
 =?utf-8?B?QmpsWUg5Y0JKc1NoV2syWlAwaVNRcGJXbDNtb0N1Rzl5Y0dKbG1KNkpETko3?=
 =?utf-8?B?SWpaR2NESG9ISDhrNkZ2cVZsMHlGT3hkcmdwOWpEZUZHTWsrZllBZ0pYeUdy?=
 =?utf-8?B?dnBMZUNHOXJncmxKcDBtblZXWVJLK1N5ZDg2SFVDOXBER2dVNXJqd1BvS3p6?=
 =?utf-8?B?QlJ3dDZ3VWcwWjl5WTdnMnN4OElmamFjbE82YkIxMUhBY0dWS1RZNDJvSUww?=
 =?utf-8?B?TVBPbDdNQVdSMFdrcXZWUklrOXR1aWFQd2Q1d3pjdFp4eVhvNnVzMmptREhZ?=
 =?utf-8?B?UDFUckpJVWdEeTFDMVpleDkrRmZBWG1UZVJMRTBCalVTdk9tTmk2T2t6a1NX?=
 =?utf-8?B?Y083dVJ5UkhLWHI5Q3c3a2kzVzhMekhJditMb2dhTjJ3MzdXZVErMkZ5RUdU?=
 =?utf-8?B?bXlpei9XM2ZrNlRkYWhvUU9mMTFZV2dBM2FYZ2VmbWdHMWRBZ1V2MHhjWm5Q?=
 =?utf-8?B?dDVCYjZKWExncHNuc0Nhc2lTTGJWbi92MjJBd2hUenFyVVR5cjVsVFZrbVV0?=
 =?utf-8?B?MWw3R1RNa004eHJxZ3M1eFZLKzNFNmFFRmVta3pZaU9uck9lYWZFZldVa1o3?=
 =?utf-8?B?K3dqTlppK1BzSnBDbmFEWmtObThPME00NVphajBuNDI4akY1cDNrUGtUMTJV?=
 =?utf-8?B?UEwzTGllUGpFMG5TYWZ6Mk9LeGFyMHZ0WnlwN3V6YXdtTHl3Vk9pNTdUamYy?=
 =?utf-8?B?WGZVNjdJZ1lGWmN1M1NGbWVmYVRaekd5Wnh5ODZiR3RxMnpTYzlPeEY4Wkpj?=
 =?utf-8?B?K2MwU2NyOVpZTEVLRitvVWN3V05wOWVieExJeGZyV0FIZEIwMzNOckZwTEs4?=
 =?utf-8?B?UXNYYTEzMW1VUHpGQnRMR0JqaTl2a3N6T1pRK0ZRNVpaLzMzckZiS2UyM2wx?=
 =?utf-8?B?b2Job1dzd1A2d2JEVk51TUVkemNEVGx3U0t2aWw0RjY1dms0VUJNakVvZ3Nm?=
 =?utf-8?B?eG9WZFpNb1c2Y2oyamdQeGEzRjFYVUJwdGlHL1NEb2g1NmthUnNhSjBYWTRo?=
 =?utf-8?B?bmd3bTZ2TVhmZ0dJM0liOTB0TVBFUmxKd2Qwdk0waGZBaEthYzVON25TZ1E0?=
 =?utf-8?B?SVg0MHNMUDNpWWxNQUU2YWlhRjlEb3ZLR2tPU2ZGN3NTaklNY0xJNitncDNr?=
 =?utf-8?B?Rjk3M2xOTWlrejEzODErb3ZFSkIxQUdRbGt3aUIxcks2NnVWNVJlcldwS3No?=
 =?utf-8?B?QWoxYisrUlVleVg1ZjNnc3pQMTRyUXVIYlFjQVQ5VmJBeGFncjRoeDIzQU1J?=
 =?utf-8?B?OER1ekZzSGN2cERUcHZXS2F1SXpVTzlrQ0dHUG11SnRyMCswcjF0YnJyQWpr?=
 =?utf-8?B?UVNqRmVremEzSURySGgxMHZTUHNOVWF2THlEWlk5MW9yWVRuSThPdW41MTY1?=
 =?utf-8?B?NEVQTnJTSG01R1I2d0xxeVVJYVJGU3ovdWQwU0QvVXlmMGtVcGRvYUZ6OXU2?=
 =?utf-8?B?eGdhRlZoSWxaN0JJbEE2UWJUb3g1VmRrM1daU2lDOWMrOG94YkUzMWVBRmJZ?=
 =?utf-8?B?UFZBcGgrOWpZWjNaNjQvcC9MRXV5WkFJZ00xNVR0MjFjdDh6QXJnWDU3VS9z?=
 =?utf-8?B?SXRvbk1QTjhKWGVYR1A3ZCs2L1BBVHk0VWNNTVllQXM2TnNKN0lrbUxRbzBH?=
 =?utf-8?B?R0JVL0tkbmltc2wwelFxSEI3d0pNOExWUkIxOC9ROUFNNTBIWWQ1TFBJdVFv?=
 =?utf-8?B?LzZkL3c3OGNsZC80WmJsL1hlekJlMnEwbHdFT0ttdUFMMlpnS3BKeWt0Nzc2?=
 =?utf-8?B?RHF6UTVkWndnVU13eFFjUFBnbE5jQTVpZmVVajBoV1dwdVM5R0xKbEVhSExB?=
 =?utf-8?B?YkhSQTNjSndvZkJxZHA1NTdJOVplSjJlN0dIMkpyT21RNjBMejVsdE16Rllo?=
 =?utf-8?B?ZmFXeFc5ZmdwZ2t4a0ZmdDRTKzR1TG9aSDY2eGo1SWZPUzJoVHA2K1Z6RE1R?=
 =?utf-8?B?eUZwcEtNbVVRYk1zVlBzRHdtKy9JVlF0TVMxYzJMT2JZaHV4c3l0dGE3VG5O?=
 =?utf-8?B?S0RyWnY4TUVGV3JqUFRobHVDa2lBWXlrd1lRQnRYTmFkYUx2bmU5NlhjdWhP?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e770ec-3c2e-44c8-1c26-08db8c129535
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:52:44.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KNqEG/dtO6T44wgVnri4bsgupLdMjfux2MbLBjUG/i0fHNT80xouLCvif9sbeCJKCqh+X7utiUlejdnMo450veuEYyEFAPRhCctJYNqzS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This patch set add support of Power Management in CAAM driver

We are saving the state of the CAAM:
 - JRs MID
 - Address of input and output rings
in suspend function and getting same state in resume function
on platforms where power of CAAM is turned off.

Changes in v2:
	- not protecting PM code under macro CONFIG_PM_SLEEP
	as CONFIG_PM_SLEEP is on by default

Franck LENORMAND (1):
  crypto: caam - Change structure type representing DECO MID

Horia Geanta (1):
  crypto: caam - add power management support

 drivers/crypto/caam/ctrl.c   | 106 +++++++++++++++++++
 drivers/crypto/caam/intern.h |  25 ++++-
 drivers/crypto/caam/jr.c     | 193 +++++++++++++++++++++++++++++++----
 drivers/crypto/caam/regs.h   |   9 +-
 4 files changed, 306 insertions(+), 27 deletions(-)

-- 
2.25.1

