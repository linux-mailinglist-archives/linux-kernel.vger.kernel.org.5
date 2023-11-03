Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29B37E047A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbjKCOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKCOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:14:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2049.outbound.protection.outlook.com [40.92.74.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9461B9;
        Fri,  3 Nov 2023 07:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axD8LArIxeWyQW08Em0pZmAwtOKI2jPukNQ07bUcHIjEel9rKPO0/o0QNamzCdn/WRKOiB6Ms4RRWtKTOlW9kwwRN26J/q+0OwyMu242xIAWHCdjQyux65l1QiLp9kULbP5uqezPWhmg2RTlfv2D2wsA0iFvvbSU7MDuRP16mqhG2bnke/COiD2F5qjhFK1qjQmO6X2oVfq7rdnmbITY9zs/J9GFdXUYfq7q88KOXYKbHWuTVExzNY+bOu6KvRdihc2lQIhATlHeW6RcxjEv31r/WRxWS965DKMomPCs0g+Xq9NYLUumjVythoiYTkTtBJjU4IVpnG+QARoY31gzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+nXWJ9l2Nzvhb0DgkgpKphQ1eiIkENT9fRJZTinJT8=;
 b=LmDh8LKpZV6Vqw348CM1M1FZcCdjhnaV1h0L14979DGeAzTu+kBXtfnj7I7yrrYtsumecCTz6xUdhMqz6jTHazNrySohB0CCuDpifQsbF3TLkBCNm/2t0hTcOexAdpDIR2HpPkhC8bygJmrH/rTyZ+M6I18VEn+2Z4iYSzxWO6Yiwyli+qthuPl5AVBuM210B3baRqhCXTsYu5dtNjEGfHJKdp4mn+xGNkspfNYANID81PjZnntbMZ1zzhHu4YL2okyLMEYl8nDMJy3KmeIkVQSr169/6cqPauHoSlW7XsrzehhljH1hWjpOf+teRGfZp7EVE4C7W7l9KopIxTZMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+nXWJ9l2Nzvhb0DgkgpKphQ1eiIkENT9fRJZTinJT8=;
 b=B+YzI/aSIpxsiqATQWeusHPeAPb76oNqTwTgDUADRJo6Lfzyuwe8WdL/RzuMmx/lRGiG6KjOHtqkGlMMV41jpZEGjjEmw3mcYsUcwncGL0+LxDJd9UkLVJYoBNGbuLFg62RlB2QjjCe15mVK6UnPk/FmoNsCzyyJpjAPnJnz+kypbErWwQuC0zPYuuUkJVafxGPqxQyxAPB7Ib94Zsf5QPOTwi4ns7+D42qnkbHt6ZFsq7Ful4oqS1uZze5I00z13//7W0NUvUv2MNIph8uSeuiMk5FyHlx1eQAEKbA/ause/WyDyHGuwFHUY9EWCBY0BmVf+6SAssF7FogCBEVl+A==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AM7PR10MB3938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:14:29 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 14:14:29 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     gregkh@linuxfoundation.org, yuran.pereira@hotmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
        edumazet@google.com, florian.fainelli@broadcom.com,
        justin.chen@broadcom.com, kuba@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd and bcmasp_netfilt_wr
Date:   Fri,  3 Nov 2023 19:44:05 +0530
Message-ID: <DB3PR10MB6835D962C88C7E862CBDE659E8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB3PR10MB68352DF6CB458CCF97C416ECE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
References: <DB3PR10MB68352DF6CB458CCF97C416ECE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [n6ln9tYHJudKv1i+74YC2EWF4ygHTFlw]
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231103141405.1620527-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AM7PR10MB3938:EE_
X-MS-Office365-Filtering-Correlation-Id: bddc0aac-398d-4d20-560f-08dbdc7730f1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWyGL+9ZSiz0nBOn0Qemv0ABH+22oTVKog/Ah2zNuyynoDweW0IkUX95gD6NDb+/d2vizkYpso+tFa0ek/TbtgUKUfzwkVpm5IqNb6+ctrgmdc35s0ISylz3tgXlWORjggc8y4atRshQvEBh9ddlIenMF7MVZgLLKFs5IEZgr+AaokRSQ8m1dcfV+UNCK6nfc3OmPQhGMm9JyMqTx6McUnuU0MfeDpSKn71bHdgIF/+axSBIWG/4Z8S6CWZrvZmUwywBT7V0Ox+W6cHlSMqPvxLzi65jzoAMCfO31VOmsidFUB5ZMyao6Dk0AWQTmJXqR+NqxqYxZP8ukcYAqLXm56ejAywgY2JnDwJvfWU0lB92PUMxoOKlYYCI/Q6wJY/5UGukAKSk8BcOgLaF4qj/WZjfxiNXE/E8qkm/h+gwpy4tbJDbwHK8fzIt9vtiVRqxNG/gIIA01xR8Z3p9lwPn3OLkHNYP7Gr72yPtPosZvFYfgAuBE7yZ5ZC6Tv22wQ+mr1QOC1QDVA/FucCQPX9nfegYMxvZBUNxcdKTX0p3gU+fHJ+cDjbneHK2ovBMiirKoHUQquAATUgJvxh+y9vIjrDiDc8GU4mgDDfreI9I5p7YVtcvE7OU+QpD+0gfjkho
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jD0+3qHYkh/xb0Q/m4LUiy8I0NbzmKEBm0jSYUGoAEzkBt+oawIZBvpT0iBj?=
 =?us-ascii?Q?a4yGNCMTJjJTYa9Dmp3jvNjuGVdolWCMyhSdRUtiCG95CoBuQvSfsI3KKzYa?=
 =?us-ascii?Q?TGgONCMQ+gmiDBOl96kodiTpoAVsuV74MwV9tZ3r/fRKTTpd8lTYtA6FP1rn?=
 =?us-ascii?Q?xSkISP+hIxy9/To0VW8+4LhLatsbirwF9qnALhSakB9H+T18qIcTG21Mcn4A?=
 =?us-ascii?Q?61GAuf+5VZGH5nLemgaWtV08cMqaPr4+2Os9vb22z5bDOgdshPR6PknNofi4?=
 =?us-ascii?Q?sBkNaZ+4A2KsmMOSzKSfCaoSMtv3hmIfjlxQ3AOgogrTSq7NgIsX8+iwhp5m?=
 =?us-ascii?Q?SqfF0qDxEpSKYM6q5Jrcl9DoYBmBFdpqOYjkjuQmHnA2PPxIhCiOTlnqVlgQ?=
 =?us-ascii?Q?q4rpPmKOL/44II8FcnNVN8HSfcz98ZOPONYIuZmBUcQOuKBSeeJmh6NguaH6?=
 =?us-ascii?Q?pvBFIvCW/5pm/XAk2XtiweEEs1674lP5OV910UpFIF/kZg5NBtkz5X4PfY6b?=
 =?us-ascii?Q?fYAp+3qi6VCQ+6CwaBKL3rmv73G1VjWeBtszw2ydmNWK+DJVr46nXYDIK7cj?=
 =?us-ascii?Q?+w7JMyHMc3Esvh2fojZx3Oeo8rXw7CtQRYuZiijb8Afrp7t1vM+eRyG3nVPg?=
 =?us-ascii?Q?xs1Mu4j/e9+K9Lw8AjAfxx2jl4pB2KQHPHoxtSrk94oW0JASQc6BEXELLBJ5?=
 =?us-ascii?Q?KUzuBYap6l602AV7QognCG5BRVyBUw/tkqZQ/fUFYDEBPv6lFWV2Bw6FeMQ2?=
 =?us-ascii?Q?mNbSba5zs7kUhwk/1SdleCekp1eJoYoeMz6PLffHoAIzJZO21gaedWaiUVX4?=
 =?us-ascii?Q?SfQBUtx5bkd6ZbpWjyXxXo8F9QkRK4nrC8oR0zNzNkZqd6SsPSoMuFkSG5rk?=
 =?us-ascii?Q?5/Dlwg61TYnO/wH6ryuJgiSIH+9ljfqUTGLME640QkIipa6RaPpNHhMwLgWy?=
 =?us-ascii?Q?unJwDXkzNcaNNf+Y70umx9WGXEZXzn7ujJhygPWMeqhQR0bEghKyiRJMgEIx?=
 =?us-ascii?Q?yPmnK+FNfeAqZWNRpebBmO+6fhCk3b/mQlBvWYWTBCS3B3QOMx1epWnpXJVs?=
 =?us-ascii?Q?voSP2JmE54Bogwh+I7SxYKI2ihebs87hQwkpiZW5bwOdQOBpRSGfO9H/rDaW?=
 =?us-ascii?Q?wu9T6Q2XoJq/TQI7+m37pGie2cRAkFPN+/pwhZ0dMWvoMydQuxYHuh5n1n0j?=
 =?us-ascii?Q?hRGNu6EItFkMZw3Tq62pi/pDd7/hY4GRyXiuMpYqzJKAjK4tE/N7BBbjfNo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bddc0aac-398d-4d20-560f-08dbdc7730f1
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:14:28.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess that explains why the first check returns 0.

```
static int bcmasp_netfilt_wr_m_wake(struct bcmasp_priv *priv,
...
{
		...
        if (first_byte && (!IS_ALIGNED(offset, 4) || size < 3)) {
            match_val = bcmasp_netfilt_rd(priv, nfilt,
                              ASP_NETFILT_MATCH,
                              ALIGN_DOWN(offset, 4));
            mask_val = bcmasp_netfilt_rd(priv, nfilt,
                             ASP_NETFILT_MASK,
                             ALIGN_DOWN(offset, 4));
        }

        shift = (3 - (offset % 4)) * 8;
        match_val &= ~GENMASK(shift + 7, shift);
        mask_val &= ~GENMASK(shift + 7, shift);
        match_val |= (u32)(*((u8 *)match) << shift);
        mask_val |= (u32)(*((u8 *)mask) << shift);

```
