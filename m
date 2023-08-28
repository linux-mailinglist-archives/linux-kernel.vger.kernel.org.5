Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CBD78B21E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjH1Nk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjH1NkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:40:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2030.outbound.protection.outlook.com [40.92.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B7011D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFOihPed91P4oEf1TJ/zWX5bGfPunyNsqgnqx1oMkaPgNIyGDwcyO1bVBknybl/GLxpscjBbvfsWUljuMsoXwnIXSLBfEofIdFPbfd6XiaJqL3TtJjwpbb986/GK9NV23389HQW+KZm13+DLOF5Oz0C2xjdIp7n+b/oLMg4cH0GCvbIH22L7HtCPj3c0MkC83sK7SG2r4XQZFYxZ9Xe81HlEGAUPsXtNPuvUb0Sd/gGMluJWYETKtUFcAHT36VY+BS6sjVEZO7fTrcWD/ZmLxFctU50exzPpBr/YQiWpleVsscXVN6hJwJpXYg5P1XIleSpXXBNnD8b2QeVEC3S+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vFAyYmACdwnQjN0ROdZrMY17X1aWU+FwnZ23K+Q9Kc=;
 b=DeEFmc2BjERH+RsuM9asw9WcLLNp2VjjImVecZPkOCNqTldJorWbb2VB7l4ROeo4f6YOmIZap7JuqOWwzNYuCtO9LfASFkhKPCxnLyUJNtA+riCMs9wk9drxfuIP4M7Frkkv+xYMvXfdUMpPj1kWxFflAhuEhdWALuvvqmi9bPfpDk35kWfA2M2Z/m3IuMVVvhYntTB+uQN7oja3isZxHerN+SH3E/rXV7BSbxLZUYshJADt03a0ZPViafK89JOpqVuTou9LmnNtk2tr2S8sjnBIFFQNLo5+TYuUt23OAlAI59GxULTKSahLCyLkFjA45ISMOe/ekzpvsQ8Y+a1XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vFAyYmACdwnQjN0ROdZrMY17X1aWU+FwnZ23K+Q9Kc=;
 b=Tnlq0vL3FNgXNxS1SBmnjHlZKnuYE/Qf1WXJefLAp9vFLBbTdR7alYwGsZriiFisyM2yrz2s32VqY2R2uM3kvXyIhMVHl3ed94RsyQL9a17tIcyfods5VwFJlULNmVpc/j/DwrufET5EikbLAutpVeLAAznr1b1nHQW2kG8tCGcdQ2s7d9WfT6yzIZtTojHVkAXw4HDDyq63ImpDVlo2pyxN8ektSnj54mTZ2hJHLS0Sa2F8igLNWmFCiE1Hb2CgzuYqDHXHBqnXcI4cMpxtjxdVvljfJ4ePr+lcL6fdKtzuAfR4WySE5/oe/IiblOH3lT4/ZEEPVaSyZf1DKc4g5g==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:40:02 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:40:02 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 0/6] staging: octeon: clean up the octeon ethernet driver
Date:   Mon, 28 Aug 2023 09:39:13 -0400
Message-ID: <PH7PR11MB7643280D48E45D2B660F5B6CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [YaB+S+YWemEKnnb4AtLJjfR7kuCi90leSG017CQ9nsf+Py1BPE2vaoXYfm9u8le4]
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <cover.1693229582.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3db245-ae94-4e4f-1e70-08dba7cc476a
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKxNKrAJbXfMZAF33NU6xvg/8DREqQMpqqAvozYxKyyW/x2wtRpR8Ufz8PAcv0up/FLWrQyXIQPPn2208KGbgd0CT2F1WoCvNq0UZm8+rpnxfhDaVHkBsxsF36xfOMy61YmTKl+hMsLa+Xyfw7D2kIZpt4s8zaNArKBhJHJYMSMsaazoZkn8TEgBEqIJAcGAaybTSTDWvlH/V9F2g1mTPyku/C3zbG30Mj+lt+woAHm+z/gI6HFAUBSNpCrVm3vIB92GuhYLNmEPGQv52JabU9vddBuQpyMDWvCNDxNv3TRcps8LdTThl20Xn1HsAgfxR+U3W+O/4oD4QmvucVov15MHGUqxRlVsgWx58h+2FtYKaP1IjREQwzv6OOrlT8cpDCGzmxiYGo0ygaluyeWPVPvDRkdVnzNbjW4lugz19KU8/rnOSpNYFY4ww55EDhlCxPZR4fJ+f84sqtH8qq+2QqapWEUmMuw7oUvzLOiZZCSCGfg7Gd252zSFknA2lQANIGe1rFDpJIhBXNjMDgwjKk07M2wbkXtaZyBktRv8ujbzElhzI9UYruf3aRPMQgMm3LSzXzrPAeTeXx6LGr4qLgargWVhArUdGdjV56gTutLHHZmw9aasGN1uC40ow14K4zRqful66K8832/ymRxIzafGxdlmA/X/pOPUUjpMymkvo+r/QZ1FAzp6uHWmyC5lt76X2GCR6xfx3qOXqfT/AvGSDXsbdT8IELo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BsjYZ8Ta8W8WuCxlYEz+pHWh6llaejYXvpAbjkS5qH2RCfxh280V9Wnqbp6fKuBN/3U46pI3FVOf3KCsFaM8dNAgq4/vRh7An/iq03e/qjSIgLehS8CD96Lq+L6ILfizuo7mOucGsOvrFQekFs27iX19xA1kEgsGiFFYBlAPa3afpH0ocv2SWpwn7nTafkQZ4TsKlbqXAATLS3PFU4h/GhFANOQCc8znw5QI0B+LeBDhj/+iZp+wzJioxc4bdXblDqCOmFAUMhQeUFvlmnWieMsBQzGY8pXAe9qidHzJ9obZet441ex8+NQk3jy10LAyexAFf91ZDUekfUMqZrFTRjW/qR3N3na+0hBsoHcVK+MTYTO/I7AAA5vFbOYqZs5rFVI5gfIryPrxEaiNnGvCZPAHKcAr/QLz+WOY+894Uy5w9ns5G9qUwzDGxrj/+YicEbNwxo3p14W4Ed7OmiWe9HGdR4LK1PPIK/O/Xu3XH5TiiT458UqQUktVg+cK/KzsyMPGNFgG1xqmCaQt4u8tXcgRS5BICc009vmLd81Qqv57q8dulnLj5JmzkrR6FgOupOtmfzF1oJ1PMYC7MWVNe++eAzFAVIhaWQ/1dQwKNowsb/qB7Kk99bU6hveTPWU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWSjxXSyLzPBG/t8Ys/KFPqiBBvRAFpIfgQCK9J5e6foKwJssOsWU2dchk9b?=
 =?us-ascii?Q?oxdfN7CR5ZbdtScJNoMFfKrQhTyxqhsq652lJOZWy3PR0sGEbqF1AvtJ6eJt?=
 =?us-ascii?Q?zkmi50/AKXgxIcsd7obX3rnQdnTHBoWwlxcuXEJV4LDq/V9ZYI0IhUfQo4Yv?=
 =?us-ascii?Q?dWHNZyaovbqtt1dD4Uyk1Dwgm6zvSc4BOQp1egh60nMyl6BdA+Ovwhx+bF17?=
 =?us-ascii?Q?CigWPVN3WNjSEuyN5mPQ1qw4aWBXsDhpPOrMeVOLE753RepCae1YWmJwauAn?=
 =?us-ascii?Q?u4l3PjHHN+Z7MdpPOpD5bA1QhtvSDgFqmGsXraQBTmjTVcGwR4vCMuje1N9+?=
 =?us-ascii?Q?OalkXqCoD+wWfwn+injIYN7SCLApjWO4skwukgdQWGnYoRqTyPfMS0NNat0H?=
 =?us-ascii?Q?jtWhKOfHA+azRm8wNqfF+svPECD6DYTKhKNf0gxgIaoLZdggRmXavxnUn/vR?=
 =?us-ascii?Q?7SSzCLr223PPb3wfReFY+jeJIM3ZkVpODb3nf3sCTWQrQPOFg+liEyHmO88z?=
 =?us-ascii?Q?0y2dTwvdPIAopdlESph+S3SewEq70MM4XVVmEWMGE8qcjpulA3il832Jw6n1?=
 =?us-ascii?Q?+hPuRNpnBNSdjfNpPK4/EQnP3CBvDovnnO2O1pdo3lFuBSedImqh74XcCsjP?=
 =?us-ascii?Q?gVLLLuKKKBT8ojsFWTdzfnApX9eHUnHojcG6Y4in18IsaOSONHHxTOg/dwPe?=
 =?us-ascii?Q?j3Z4DDKogjLsB9gTkJyUF/rvCJdKynj74fdBB4b6QHoMNR1dvC1WO4Np7dxp?=
 =?us-ascii?Q?SdZBttt1f6ZQeSXv2cdjolo23rY+ClSM0/SgHfnFp6nsOXfZGDhRydsjAee3?=
 =?us-ascii?Q?cv2jjxWePttybEE/VlwUA58PD4elW3U33L+cPNPumx1CxKRd32xE8uZ018Zk?=
 =?us-ascii?Q?MLjmxy8fEYwjmRhKNk9DbQgFqvuSXDZ7lScPv31FKEtvdWVwGHPdh9itBGrk?=
 =?us-ascii?Q?Pk/CcVz+yCIDErYb5AhTXd1UbaTtF7t/+jdelGoGsQ64kW+lhvYO/jBw/8K5?=
 =?us-ascii?Q?3ZSZyXWFxUq6Hf+N+x8GoFKgJyU/LuA5ajc9tWkaedK8mKCngnUrOAxQmKSa?=
 =?us-ascii?Q?Ybgp5rJ4yXN4H1uR4FUUiL1ueU6AkjLnheNbYWLawTdCbQ/XJcpYetvSuYsZ?=
 =?us-ascii?Q?05W6AtvdHoraxIDhXuC3KXO1YTrhl6n/1mZKGKMEVUsNA2npC8IAQkExBzpt?=
 =?us-ascii?Q?N3QoqyU/Ss83CCvkRE0EKY7eXtPCDLulLgZBqayL1Do6m9IEDVZdmClwLGIo?=
 =?us-ascii?Q?tzVWjWmIGdNdkcFvqaGHeE02QhI0idmRTUSp3g8POQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3db245-ae94-4e4f-1e70-08dba7cc476a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:40:02.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better conform to the linux kernel coding standards

Oliver Crumrine (6):
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver
  staging: octeon: clean up the octeon ethernet driver

 drivers/staging/octeon/ethernet.c     |  6 ++--
 drivers/staging/octeon/octeon-stubs.h | 50 +++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.39.3

