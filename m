Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B67EC812
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjKOQBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKOQBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:01:48 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D921B95;
        Wed, 15 Nov 2023 08:01:44 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFEn7DL019179;
        Wed, 15 Nov 2023 08:01:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=CqRioOeArEGAm7CBrnX5VwhXxtH0BwSS2x+zXb4iTqs=;
 b=o80DqNhwH7Gt/3Tpmu4FAQKLSHRYI1DI7ivscHRT/te4Iup9kGoCGhB8+4ZyAeEB6kOt
 0aiL9P/SxAH9w0NHz/wLxl5KMvVdQBV00t2FGWlal5ccaJv6kl6HelaRpdj+0r3WZh5M
 MHrxLi4z9y+oerJWyuU7qcU2H/4FQQFFZnB2PgzD8DeSiFxFq40ehwIIroXGKqhh/C/a
 PEWs8NsnfLbz7NiSMvXrgv7IffkZ0vf4YB6lgtixU3exBS3YLox7QsL19A9uvcPxQxEl
 iC36jTuaksCKn2o+jg2nc9uCOqSUHbQVk9h/b7n8ltzmsFFt6X34dd1Gf9vlCv2HKkfQ oA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ua9gs9y1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 08:01:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700064065; bh=4T6hlBdHKNTi/4ItNKrpU1JHBC8NteoHzh1QKrFzW7E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KYoGF2JQmIUjTHoYaW5E/BRBVebxzSdoXtaFT5kee6UZ3xGki/X1Tb5eQBnCxtVGx
         kF4ieeEou5XJfCwe9Hh2FNstyIxJLzStEe2SaBjuwJ1rqhBZEmW5BycqU9j3R9lH68
         enpIgKh/g5hblL7N0bvqkgtE6gGAIgJ7j3mHzdb82qxoxgkLvMzD9rlACVRLjyZtR3
         vw8f9GKJ7NiYKb7StEYZ4s2JNz1sXY2SCN/0/AycN0/9rvDYEMdOOGv0uKJcp5SwUd
         R8RmKqMT6QjX9vP0Aauj5sAoC9hWDFfC6fZNz8a0h1QYddkVSeCdA+dtKg9xLyby+6
         DDWyQZqy8DyJA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9FB4640087;
        Wed, 15 Nov 2023 16:01:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6A458A00BD;
        Wed, 15 Nov 2023 16:01:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TGRvVwU4;
        dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4749A40078;
        Wed, 15 Nov 2023 16:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiqNHi9TFfEFC/saQ5Uwr7A4GBtj6jO5FCCKelVgD56rmjax85SKnkX7LAfrGuDVKwFRPENk/+yU3OnKdRRrfU1rL/TW5pBZi5RQCMgj6l+Sb8lgtQeLcCCMfxxb3VcpROrr7gk15zCigmIXSOybJdT2hUcci6YwIGh0+QfDFqAENQMlYkBBhT0+2X1OMVqg0Ez0mbMp0brQUYh3qA3b0l9nbvTdZdmHZOKdNsfYDuAVURT+ydyIPtaIlzgORwWP6r5pugYkOAta4Pf2HJ3phifYc6WNFAegPlREA9Gz/NScjj004HB7iucsgO0ZVx6QizwrW751ln9aVmBEgCc9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqRioOeArEGAm7CBrnX5VwhXxtH0BwSS2x+zXb4iTqs=;
 b=gC6bDE0YLsO1BKjnao3EnuvHysfCODnScuZV6rKXOjDv6paqfFP4TnjMzHW5PFM3O8Hd03iFhvOgmiSMBtbGU7+D0u9CJFZdHLOeIvmdSIgUOv2N98wHho4JncS21ETrQzO8aqHBig6ESG3rbUjSuLBzmnxwfLffkAuj/1xkCJ1RLwMB1jea9ymCK0aPXObraE34IE0tGA1sJle3Q69AyTaJ6swn9Ai0T4BPQ35xEN1lAj6Q2jg4Sx8qnww0bidiQb0jgKfvmCaLPIjD+MlLt3H1jQnA6YjrLSYmKhkBoNS1eW2UwOY1y1yVGdHz3sjENuJIReYe3H1pO0s9/xN1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqRioOeArEGAm7CBrnX5VwhXxtH0BwSS2x+zXb4iTqs=;
 b=TGRvVwU4uXDNSh3adgPKKNO7wt8uJsCWogQeaTGSdSg+9fRQrVfuoXesDX2H/7XyHvfhOagm500nzDHbWgdsoyQIiKmI+1zKHN37iz9bypPly2sOwFlNNumVRlZADlCObMhK7cE/Z8uxOBvyEbjH0XFekRCU6vnyGQBo5JnIyb4=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Wed, 15 Nov 2023 16:00:43 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::45da:22ed:5900:420c]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::45da:22ed:5900:420c%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 16:00:42 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH] net: stmmac: fix FPE events losing
Thread-Index: AdoW3Xfb3QHiuCaqTA2ROZ4444S4MgAFJ5GAADdg94AAAqmPIA==
Date:   Wed, 15 Nov 2023 16:00:42 +0000
Message-ID: <CY5PR12MB63727BAD92930CB04DE4DB52BFB1A@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
 <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
In-Reply-To: <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|CY5PR12MB6299:EE_
x-ms-office365-filtering-correlation-id: 9adf4928-1b2f-40a0-e01d-08dbe5f40555
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PB/Y24vsftZM+Pa9PyuBJuembcrbH1YVWOStnxsJsD7pmT1qYgHVF4qTsNnUSJl3CSyrb+cl/03puVEPNR8JcGUCHNofuUOm2Xa7YTCo8z8ibograanT7olzqwj6mqx3ZF6UXX9LyrbVYcuUOQwjyOpL2zKZyBAQsMEpt97LQIdXorWYra1R8GEhQNOi4Q0AUoGgNjp54Y5xAnyjD/hf522XEvVDHLBWdXXKbOeBX96m9S79ocY+3nAPORzdWQBEN1Kba6aqdScNhvMzoTjSfQeZ0i7fJEZ1kbBzxtZeZDQ4bIG7s9cchGp6Q6hcN/aqoozHpiAkZypKUDOeFBhwdz7mmyeoeE38AM6Vjnta92QgtAF8ak1lkCU3JMUOIc+oT6sCuV9lAaETXxmOKVie5afj3yAMyFIwdNAUzPSdEspGpPXGYAvxYtYWlw1PO0cFp7DCQEThKPX6moiDUBkFq/G5oMnEFjY0xidZDmgzR8XMiHyaSJF+aui0A8js2I7u0XKofSP7s8+QvzqCYNDe89aQ5Cvt8nGozEAIyBsxGxHXpdfTDeugtLkA8Te1UOj2vla2GLkpISYbfyLRl9Xk1hOBkb2KltRr3mJWOZNrqps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38070700009)(55016003)(86362001)(38100700002)(7416002)(53546011)(2906002)(33656002)(9686003)(83380400001)(122000001)(7696005)(6506007)(5660300002)(26005)(41300700001)(316002)(966005)(66446008)(71200400001)(54906003)(8676002)(110136005)(4326008)(66476007)(52536014)(478600001)(64756008)(66946007)(8936002)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E7VvxtUeALaCxIusTPcL0wSfWXpoZQ9zbGXcrvRLqIq3bvWXyr6Lej+RBs4g?=
 =?us-ascii?Q?mPv563ldab1qwJJGS1mk32j/cu0QPUBm4P5uAUdZGnoKZRFcVBEWUrg7fZ7E?=
 =?us-ascii?Q?L3t47M6LdRdQEeLL/jK91dAnOd4pv8sqyj6OlAkJaJ3eal/LyXhrsG6jXlA2?=
 =?us-ascii?Q?3V6JXU8W2ratCjKbbd9A42V3eoraiwSWpX0ZigUob6dMT+yRmz7G6KZbxTpg?=
 =?us-ascii?Q?5NpqcEB86PIBFR1R+9fCLdHlTwJTS95oMbo5OOtw7wECo2O1Mtvclz7Tw0vb?=
 =?us-ascii?Q?FSrG4vhhDeqPePNDBXLuInt0+goJLLi56vYYw4YhPGC0j91BPZqS7GBZorJm?=
 =?us-ascii?Q?u7onUGU484xGdHXYwzVREQ2xhyKmwHgj4vQ5xj73BwgXok6yIrVUHyKOT+p9?=
 =?us-ascii?Q?+EZSDT485jXJb/ryFq+l/XEXHwsMZaOrNEBOqTw3hCaYaPPUFpo2NE26begc?=
 =?us-ascii?Q?7E1/z3+R6IP0+ZzVs63G7X0t3OPvLWQTsodssE5N51zws84+6mx7D3ostOOj?=
 =?us-ascii?Q?mwHkiLnjJZtmPurE5FZllR8EMoPHx9DzlchpSPYpB697n8kYjS2hif2VpNJI?=
 =?us-ascii?Q?j/kwxW2F8RabNXPv/U3XJO71mxn1tv4Dq2veu8PRlT2/SbZASY3L+7yPtX0w?=
 =?us-ascii?Q?jO3IAGn2/iye72Q7pfcKjkdyFUijTUTdK2B5pzWQifaeldZSvTWOyZvqMhld?=
 =?us-ascii?Q?C9nRs8sWHpS5r+wYb6qCQHKP8G8Y57aflp4eB4zA/rJ7WVKgQULlVyviuZoe?=
 =?us-ascii?Q?eZSJX7wlL4ra4iDF1pV5R2Y4Sdgs+zshHFqTKCHQDpRT1Wqsq/k7x1pTFirV?=
 =?us-ascii?Q?woSKA7XE7aPwtV7LDRasZpDRUgiyTOW31SOwOx+J5CXbMJRIYmRXTcLH/7Dz?=
 =?us-ascii?Q?GEMXwKNXJR4lQgTYXWQ1P/+TFhklRGU98PpL111LZgFbHCvokucOeCzS4G/1?=
 =?us-ascii?Q?lrFvKN8CEtMm8JMRHoM8HJm47EhY6K8KIoZoBL5tzTihOK2A3m3PGhvQ3eBI?=
 =?us-ascii?Q?BFpG9bR3DbC0x0VkkhSVcJE90RlXAB8nEdObfZXk81CZPQy2Sfkv/oVj8DaQ?=
 =?us-ascii?Q?Ycw1Opp7mAwAEtjmLpLPW0QOGDtIz+gdKUdp7oMK+pNdkeA2YPFOjNSTANKX?=
 =?us-ascii?Q?geuZxi+W9JE00QmhuVIapwIjuUzMgynzIxae42yoXgTzuwQYwQMZHkhBI1aE?=
 =?us-ascii?Q?p+6kxf5nLPT+H1DfC50AhnkQXTbTfvieRTJAvkx+og17QjXhQbZ2qcu/K+11?=
 =?us-ascii?Q?MoDbvFatxQ0RbZzB0PS62QlvEblDAi94dMdypLl7trMXwxnsDXns6LuwE7lA?=
 =?us-ascii?Q?U2LMpHMRlf0x1nVj/XFJlSwTbHnAqz1ZJhW97/BoPKUN3vDMycIDUc3xRAtD?=
 =?us-ascii?Q?YYyP7dmEshvpRSP3r6YlHT2karz6KkIj/7YJSQCtG9y/SMxNUVQMn1SMa0qj?=
 =?us-ascii?Q?j41ECydlOwUlbcqaIhEqdIUgV0eR62x/LlliozE/D8VAjpeOsCSDNXiEgRwH?=
 =?us-ascii?Q?fLTVf0xGO7WlGq+RoOyf3017DiL2LdPSOhigScnbcYlpDu9+RyHEY1t7WzSE?=
 =?us-ascii?Q?dkjZX9rTOVKx2YgDuGUT0uKbxiDIlEAxmCu12Kgm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TQODgumNoHHQpAxtiYY6l2LvCO5tVsQW13aAyS5ky6ciymMejTsKSWsnoIDm?=
 =?us-ascii?Q?1GvKPMYpxV90ov/c5GsPR6dQorPZcECFKaJTzo0KZuDugSvwnHu3siL1OdIY?=
 =?us-ascii?Q?ElcW4gbOWCFcHDUtJ8H7kcAxKoPJ6AjLoW0GZX4XcLvEZ06Ec4V9ep+zSbKQ?=
 =?us-ascii?Q?nGrFDy8maj1rC0ODcGKBZo3mZuBLIgOj00BHCuj0yTiE4dMjjMOf6qbmjF67?=
 =?us-ascii?Q?QijKlfSqwVa7ZpSamV5GmW+5zRVbJvC62h4w1RvFuIzbfp1uJZwU8f3yCrcE?=
 =?us-ascii?Q?IyVWtEXQ08dYjv1CkgxXq9rgZQlTYLGd/jdxdo1ejn1i6//Y/gt2rodaG/xt?=
 =?us-ascii?Q?rq4S9x6qQg+HOyx9QtDS+8KMNcr9PGCq5xMtDl0Mk/pSzRZ2p5W5aDYVx+aB?=
 =?us-ascii?Q?ao7Z1l8c8Pp3+s2Co2nX3NmostcP5TiuINQKKMFqnWhXKRDY8S4R3THJOtj/?=
 =?us-ascii?Q?hjbmIMl9VDTitoRslZmBSq3X8om42tTMng2md8OR53DSw94XXkRlMf94CXQI?=
 =?us-ascii?Q?15g1/PJ1kEHAutTnAgj1djZ8CnZeXPSpjjPbFvMdKouTCOsR784msyQxgPyG?=
 =?us-ascii?Q?8G24O5LiMaT1wFU6m9jbAdScsTKbnlbJPp3/vZEvv6Hdi6VSRlr9/+ndQlp1?=
 =?us-ascii?Q?21wcpq70I76rw+A4uEajADQrBK2q6l4PU6hMowPj1se4pQYgubf6+G8TbMoS?=
 =?us-ascii?Q?lXjM6HC8pTX/bP4TAYa91rvKkfbsbhYz3kgMskQ1ApjEauThrFs2CJ0EFmI9?=
 =?us-ascii?Q?FfBx44+LSO+yKSuScICa/ymWJuqV/ikBVD8xqUmNul9kKQzdCHssrtz4vDNa?=
 =?us-ascii?Q?f2ChOMNzq4so1/lB6t2aCW2DeNtDUdym2lk0NWqSHb2GjMYAS6viqFZbe1Mw?=
 =?us-ascii?Q?yLEU0lps5I+C/pJ2LKwv9ym+PXb94KE66wb2AWvxesn4LQvnkU1w4GZsE6h6?=
 =?us-ascii?Q?n3PbnfeT2GUtQEDdm8Q2UvHsJjCtK6s61pPqsZ5sGEV2NoWSI3US1IZY47Lo?=
 =?us-ascii?Q?wieRmiLiyQThEaF/kx6GzDVqiTz81XNBdHU0cm9RMqUIlZtZFUUUDqug9Rk1?=
 =?us-ascii?Q?GPZ10S6e/9Jur+/VFR89OkRA7dbBpXHvFCwdeH3xrB/pB1ctr0pfaXcvMPiX?=
 =?us-ascii?Q?Ih4xNZr04ahWLQjOb1eJhJp8iXZ44CNf1p/mqpNHNOawDrG6ZM/ILTyWcIeo?=
 =?us-ascii?Q?PxC/EeI7E2FTMtTe?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adf4928-1b2f-40a0-e01d-08dbe5f40555
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 16:00:42.6799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipTOJ/xVUyhdWax3on4FCuBqOp1WBgwcv1SiuvMMbK22KJI4xbm6UgccNvSMyBTsQA5pfIco6+x1ZYF/AiB7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
X-Proofpoint-GUID: gwkuafP5yrBfNW-kGVJp3B-9IOvO4sp0
X-Proofpoint-ORIG-GUID: gwkuafP5yrBfNW-kGVJp3B-9IOvO4sp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_15,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, November 15, 2023 10:26 PM
> To: Serge Semin <fancer.lancer@gmail.com>
> Cc: Jianheng Zhang <jianheng@synopsys.com>; Alexandre Torgue <alexandre.t=
orgue@foss.st.com>; Jose
> Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>; Eric=
 Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pab=
eni@redhat.com>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@int=
el.com>; Ong Boon
> Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; =
Mohammad Athari Bin
> Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradea=
d.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] net: stmmac: fix FPE events losing
>=20
> On Tue, Nov 14, 2023 at 02:59:57PM +0300, Serge Semin wrote:
> > On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> > > The 32-bit access of register MAC_FPE_CTRL_STS may clear the FPE stat=
us
> > > bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS control bits=
 to
> > > avoid unexpected access of MAC_FPE_CTRL_STS status bits that can redu=
ce
> > > the FPE handshake retries.
> > >
> > > The bit[19:17] of register MAC_FPE_CTRL_STS are status register bits.
> > > Those bits are clear on read (or write of 1 when RCWE bit in
> > > MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> > > MAC_FPE_CTRL_STS control bits makes side effects that clear the statu=
s
> > > bits. Then the stmmac interrupt handler missing FPE event status and
> > > leads to FPE handshake failure and retries.
> > >
> > > The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or reserve=
d
> > > that have no access side effects, so can use 8-bit access for
> > > MAC_FPE_CTRL_STS control bits.
> > >
> > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shak=
ing procedure")
> > > Signed-off-by: jianheng <jianheng@synopsys.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > index e95d35f..7333995 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *ioaddr,=
 u32 num_txq, u32
> num_rxq,
> > >  	u32 value;
> > >
> > >  	if (!enable) {
> >
> > > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > +		value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
> >
> > Note this may break the platforms which don't support non-32 MMIOs for
> > some devices. None of the currently supported glue-drivers explicitly
> > state they have such peculiarity, but at the same time the STMMAC-core
> > driver at the present state uses the dword IO ops only. For instance
> > the PCIe subsystem has the special accessors for such cases:
> > pci_generic_config_read32()
> > pci_generic_config_write32()
> > which at the very least are utilized on the Tegra and Loongson
> > platforms to access the host CSR spaces. These platforms are also
> > equipped with the DW MACs. The problem might be irrelevant for all the
> > currently supported DW MAC controllers implementations though, but
> > still it worth to draw an attention to the problem possibility and in
> > order to prevent it before ahead it would be better to just avoid
> > using the byte-/word- IOs if it's possible.
>=20
> Yes, this exists for configuration accesses, and is damn annoying
> because the read-modify-write of these can end up clearing PCI
> status register bits that are W1C.
>=20
> I've never heard of that problem with MMIO though.
>=20
> --
> RMK's Patch system:
> https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches=
/__;!!A4F2R9G_pg!ZnsQc
> 7LKbdCiIj_nLBkt44MRSL8W8YD4WvMmPNkHFlDMrjrVqEVOVA1-P-9BVE3Oa5bC1ymKXLNV5C=
9mJ_rfFtLW
> Fg$
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
Thanks for all your mention about the potential risks of using readb and su=
ggestions, I'll consider a new solution and update the patch.

Best Regards,
Jianheng
