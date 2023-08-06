Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9775771405
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHFIvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 04:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 04:51:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2105.outbound.protection.outlook.com [40.92.98.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A655131;
        Sun,  6 Aug 2023 01:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMCoS2YUyHPO20B7J0VIinFUUq+tL9ZBe4PTOHyfcAiKy3IbcjFiFagFwx4dv127z5yZgLXfbppDeVAbb7TkjZtMX7G/v11Osr9uMEX/iwXGxTntELVB4++klaJuf+xD8adPGtUIepj9tyaQIJtUmVM8/7oF26qkm09CmB5GtBmhTEYGIIBF1EcnVqwUozBzYdbkxE5WMmylC93tNc5kPnPfLPdiFb9oUafMjQfFx4wYHSP+vx/D3PWO1KdeWFBw0f5oeRksTxMBs1518spC5oBiTEzqdNMwWTyjDyfShZjpPsQ9P2MH+v4HRoQ7BMnNXRhc6fSnEMGr7/bLbrwmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fAAV749oBqfG8FSi7yTyE5WyLYPam1EoKf+/VLkjBE=;
 b=ijZLJnhtsr27WjJx56C6gv0Woruq+DXFSYxZ/TU3dq6/2r3X68Rqayrm2bUgxOuJuR0liL4hCFZ1aNwWD0I3fpS6+GDCXYq+lNydYDUroVyaN2rEcfj16mAoo1pkx1xxwCKdgGyjoY/UZBR+zKk0RCYC8LLDzbwJCqPk50RK6UAIAqmzQ7cQs0A0ZQ8AbgtF6eyktJkperijGhs52tq+MUYf3H2C4qZ7k5RwunXpY6BeTnh2Q8nY5ZdZ+FBmNORxjxamtj2V7ED4+T+aUZGeY4aQjntpORa//SaOihEW628xZ+P8WWcziT3RYDC35uSC/t8u/oSbR5SU2Nf7YyANlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fAAV749oBqfG8FSi7yTyE5WyLYPam1EoKf+/VLkjBE=;
 b=B9uefTLBz4FLcq4s77LaUOej43NtKmNJhkggDwYBTYrVkCYeaaAGba8FdyD2hg3irh9/Hg3KMKjF/Uhq6qZSamMSdKfporXRYwDI/w/fLR7S5zQd8HbnAMHQcqoVpRB6xTWjYCqElvyXCZZZtPxvbtQUxuXqN7FPvbzxjb4jnHB73W2KYVwk4Ab2NFKE+wiXSS0xZ1SHtBOjaq85k1BNZxMZx4+FFKYbhfCdHiq7P8OndYG06pGzRgBtTQCljn7bcAxjDCwVxuh3hgwSH4c26XiRGShH8u0fMR9ifLy603LIhmefBA3FjzrkLCoAUoImjC8PDZ0+wGWHklSYISjRRw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OS3P286MB2744.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 08:51:03 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::e67d:f61a:b248:f597%3]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 08:51:03 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 0/2] Some dts fixes for Beaglebone Black
Date:   Sun,  6 Aug 2023 16:50:42 +0800
Message-ID: <TY3P286MB2611C75BE5C5C298CB5EA072980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [azVvs9p0icq3Nje3VI3ZD1SM9hx9Zcel]
X-ClientProxiedBy: TY2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:404:42::36) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230806085044.1917-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2744:EE_
X-MS-Office365-Filtering-Correlation-Id: fd049b56-6d70-4b82-072a-08db965a43b4
X-MS-Exchange-SLBlob-MailProps: znQPCv1HvwWEYzO0yr1K1PGnivzc09nIlRfHPgn+prZevr0lUD8Rsr+nBdhjWKOmHJpfCC27cbUshhm/TaWUAZQtCXxxp1ou14tlVDFjg6qwipXR/yozX/Q4A3qLd/tXku5ovvGeNfaX3iEZ6T40VlcijDE8vehJuTuoUDOkdRFjbMGLU/cTvJ+rG+18AFwNxpBxkV4HsBrmTMClLvU/aZ/8TxHqk/6n9oh2eEOTE1kc19N1YXzVJK6cDrBCMI+cRO9GudhJIwOauZ782YOO8iIyYowcYbVuIqaclfyJruPFXh+rX+DQA6I7N3gGUG1FDK+hG+9a2W/mg2pIx+vHGkMmyQBi2WtF6HqfSOqi6Htoekp9cIwi40/jeydZ+VY/GidANlDcR/ezJYp2j41RBJAKnm0sshdjlzDBPQ0/Pj2HIqEDMoewpsgIDIk7qzvoq6I7rDvABC3/1fw4T/wJKAJ8tL1zo0CqfCwJ78Cbm18VP1F4sHRZGrabpLy8YgDMp29Jd/cfS/Xd6wGEKbx/j58QMvrCC0AzwOVsu1z3Ddy4HVNNnKNovzqOEkF8Y6FZdv0O/tdSENnpHiLajZ+biRM2GEsI/TGIV4XyHF/pp5yRdyJ/d1o7d1KveoD58IHUGUBPbXLfI1vGj0jx4+R0Fwf9mIm2GzFc1cK4XoAEc0g/7Y+Y/90/eqZMcmS67sSpys3ljGX+LjtyLfIrRUcONlNRweXYvbs5wra5DgSTrAv3M9huR+K1ryDADri3D65vJlIRsTp0ajo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /o2HYWrUJHyHoWsf3GlzHFgyK4PjqeX3qN4FukKsByEMwEyUk/I6pmWxYd/VcPcB5pxn8ZyQ8z9/kNyda51ZFlWJasv2t5fVPU+dm1fpVQ6+nNsprZvl/XzYmfvtdFguAmepy+/lzEH+szyfB0g2/Pl+GTVWLCusUeR7NMjqF9DJHEH+vaOV7ms9NLg+bUm7MJilDffQH+Ox/1JZPUbQhPLVqPHRry/4H+twEqsXUUJb4XXAuXI24OOJp4erc3RASAjEvG/BfMVJduDexgez8Jn6lhaVBwTx7XOzdJfJAGzAfZjplXE3i7dJS09FWLEO7fVbk1mO6iKwyu1odLULQVCrdYTgC8eMlcpSqtn6XvrCyI2h8DM9e5GSf/UWw9ApGJjTKvy6ETHfXRfpS9wZsKyoNxCeHFjtDN+usemeCYXx/yVJhB7eihlCcdPIFT+pzibeheo+uZr6FW1YRumtXEmYzOVbwaWKz15ke5ntpkwOv0RV3qMCcpsr4tH4oij2spQHadSLL99999tuTCG7SPxGZ3/Jp3zJQuGyVbkTjDZ8rlI3p3ecxZebYlQTJhRSiETFQhlwAyn7gB3KJ8p6bGIKQBKVeSGo7YCw8r0NKu82tQCcPxluq8GR8bbwGCRG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?feP1Ve5+GKHXGdQtqwsqTNYOUir22z18QTxoFqB5edVgq0lW4PuQ2ofofHkX?=
 =?us-ascii?Q?qkVtFlhQVRgOXxYFCzswGesyWLrokNWK8Cs+pk5wkU20wC3cgaxP+LlanbCu?=
 =?us-ascii?Q?MdZbFighPNM+3/VpZfVEOfMb300vCRH1msZpfZTyRRT9rXL4Fo3d3KRFghbk?=
 =?us-ascii?Q?shV7T0dnc3NFBU/nfr84yqe4aPP1vGt199+YVZVCtqO7E8N/yp+QVZ/ivSvG?=
 =?us-ascii?Q?CwbRmYliTaooI+FrJfjk90Ogu3ChHx0k2G6bojuazi2U91MwApfSajvOt/Vj?=
 =?us-ascii?Q?F4fITIavggR4F7A/gThmJ3sP7akveZUTmdJQWxO9Tit7vEhVYt0xv/4vmyPX?=
 =?us-ascii?Q?SrjoZOlPOihH49MWwTiCJyMeTCFGBCe1CdJgprrw8UuJPbzg+m8HhJtfDieB?=
 =?us-ascii?Q?kuUNOzeyJZoaKHwinatTkHyfXjRU08bBIEd1jq5K2fvoV7HUt7YsTlO/3RSc?=
 =?us-ascii?Q?oP4c3EO8i4lK7DnecX2GY8IQsAOtkAYbh6ZDv1eeNi3aaWduorUeUX7G2z34?=
 =?us-ascii?Q?qMVGh5PKezW1EJXzHpLAMMK5do+vxEqi+7nV7nfJ1zoAK4RoPUtzHu698UC1?=
 =?us-ascii?Q?nSDjxEq/dgdFHnahGaZ/5jlH01ZLdS4IsJnFxiOPx4ScoltT+MZa5FdIqMPV?=
 =?us-ascii?Q?1xOPaO8s5KzeWet74QgUgQF1POY5foOukQeNR+2xsaI3ZI58TwbY2xpEvXRZ?=
 =?us-ascii?Q?UN133PKoQ+twd/pAGpiCGL4EwteS/UZGhuyHSfr2J2BkH6zLWKWnmXwuQye2?=
 =?us-ascii?Q?y+jZLyWeK7mT7k1/dUZiKe9S0sbh3+xO6tJwgTBHh1s1Rl41BXPZD7FpRC6v?=
 =?us-ascii?Q?DLn3tRfxA57tKfoJpRD+j+UQJbgrcgCOU2u6Iprmt+oa9PgSaDsSac0ODW1i?=
 =?us-ascii?Q?DTXWHR3Ysvnllf2T+9sNSH3zKtrtmM7a2YnoRheD8QqDyvfHSfXiNB+pxpAT?=
 =?us-ascii?Q?0/m51SjUIZbAF7JxznlpFX6Xu+NGo1/Z8iIt4umXnRw2IJ9pp8JuKj1yJyth?=
 =?us-ascii?Q?bBdPmnu0etQI3ZAIoY/wWQrfDCHEBBzhEsNonl92baLS7JQ7E0mLCMC7a0jR?=
 =?us-ascii?Q?jUu0uhq/lisz29EAm6wv4Zzra+k2nMmaKDb5n4coYP4VsyEXM3Sj+OBdsWSR?=
 =?us-ascii?Q?d18C01FSot2s82d59FaCjdD4RS51QIHhQ5wCPrpmBtIjfbPsd98ilDWgix/a?=
 =?us-ascii?Q?Waqv096P/kk5G5cIkqyXWUtd/+DXLh7Uof+6cQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd049b56-6d70-4b82-072a-08db965a43b4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 08:51:03.4477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2744
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has some dts fixes for Beaglebone Black. Patch 1 adds power
supply for on-board eeprom to reduce warnings in dmesg. Patch 2 enables
ethernet PHY reset pin of revision C3 boards to fix PHY random startup
failure.

Changes since v1:
 Patch 2:  Using /**/ rather than // to comment

Shengyu Qu (2):
  ARM: dts: am335x-bone-common: Add vcc-supply for on-board eeprom
  ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board

 arch/arm/boot/dts/ti/omap/am335x-bone-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.41.0

