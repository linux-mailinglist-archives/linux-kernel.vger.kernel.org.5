Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDE7F3EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjKVHir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjKVHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:38:44 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A04B2;
        Tue, 21 Nov 2023 23:38:38 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM4TgGI026390;
        Tue, 21 Nov 2023 23:38:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=MrvNucn0usceRypKviS2Pg7KJTxJvc5Ws7x1Xc+u3Z8=;
 b=QWPRPvZTrg9cDLsjrSKj7UF3wIQCFTj+9yID6tdVR4Diu12VlClJxBk/8KQkhOWLAZy/
 1UsLry+Asodi7+KphdMSaGt14K2hbaltQYbT++Hp/VBYvWEiqCt5mrWMPM63imkdTxEd
 cTbgyQWQjKTaLFKoaniBxauIyZfvZsAOeVEIKKx2iMUFsqkkx6ca9g61aAiLv6P0OuDA
 +glWWIF0/2L1zJ8u+KkqFxyvAbSGqp526y2ymUmrBiUjHO6rvqiqCiE9l3F3Xh5XgtQF
 pLJfelB9Y9AmPJ5m5wkIqQuY81EA84RobI74K/WPPnKgr6/1H6JppiKI7UOtBz/vGFmF 3g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uew5wr9x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 23:38:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1700638681; bh=tcW0eCcCKrxpGKZV3ugenbyXAxLZCcLvS+oYTEAenDk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bg5KYHpt3qH12fs9yBkXzxPotVSn0rMZZ8bo8S1uFl+2IPagIz/Fq0O1HY+ibAjoZ
         NhPLP+/QztjbgtzRne8W9EGHT06Q0/N3RjRUmCCKsL9vWCRwmrdslCFNFjduvBJvzx
         z0CjGPn2DPGjLWb37tCEfduRU2MSdAqFlM2yaZd5wfEUmKFen948f2b73DOt2eigqn
         0fWDoTz4kI4+8Qsdh+ajDH7IZksjGCV2bRGNcsrhmkcZurqBEYTq015XNJ0TPPYhsb
         9Kbtkb4iSTibtFIL+w0bopzUNRY7Qrg/bKceiOc+5zFja82MxwvORYBC5gou9q8NCP
         AW0DVNj64nO9Q==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB786400A2;
        Wed, 22 Nov 2023 07:37:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id DDE74A0085;
        Wed, 22 Nov 2023 07:37:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wxwFgO5q;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B258A40364;
        Wed, 22 Nov 2023 07:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLN99Hvg/E5alK0DBe4QfsIq+ksfkeu++1IBBCA2rA264uQgDRcjwUQf+EG6byfAypC7pKh3VhZTYHCyUv9vBGKcyImfWjJE0skGDxwsZ3v5zBXbXIW0vGRJzSZWgc1cg6lf5uQSg1MXX1TorbAIr4E5eqk0v/CpMwUo9ZgqRJt2HLigaMtQIUja/1Z5hHRGqEiwNRG6JLx1WdaCIjjMSoPfVrv8IRQmKvxo/GlrduD6qOwUJHxP3ajgGjgcROHBvEYknqi/luygDBcjSu1gKzxlZWYeWmBWLpdu8pQHv51OKflSXfQd6wIZJu2jNVw9oPHvdupq0FIxGxj3LFz04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrvNucn0usceRypKviS2Pg7KJTxJvc5Ws7x1Xc+u3Z8=;
 b=g6G5asYbTbjQ2QD38AaNpm1vkq+TkrvCwl9TUA4AFH/RbwdlCKmbnTxvC/KLck07hN+u5lrrV0Neg2/hV9Pb+jQrF7iK1B9cFYqPHzu8zo6TYY1wxR2kzuOPlbbZ6xOiTO9dVcAlxMO7mJLiJFssWh7UVgDWcOMv70SbNXtXZeaNknnn+xoXfax3z4mkXdTBvS6zl1jO5Ze4Gj6GNI7BFQB1yU6SMokyJ8PnZWiToXZ2HOw5uaUFqz2L2gFNGpRLAPrxl51/f8D4dQEFsjTkWueY5SG0ubH/zrPKYW2y7KpgVYpdvYQYjQSgxj4/2ymGYduYUBDtSlq9zy0rCxpKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrvNucn0usceRypKviS2Pg7KJTxJvc5Ws7x1Xc+u3Z8=;
 b=wxwFgO5qi1yFKEOe++dCDppd1tObDIIAmT2tELZ4ggU9zmVU7VIMpepdZ62OujFzGiO5v+SKOnzpnklj7Cqnr99B2kB3DA0BJ0NpPBU4oDfMdhRfqcfV4Vqg8EQKr576eJz6VPoAsGuibleDIf6UqOeRjpGpTqGoKSFbZ4ESwXs=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Wed, 22 Nov 2023 07:37:53 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 07:37:52 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: RE: [PATCH] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH] net: stmmac: fix FPE events losing
Thread-Index: AdoW3Xfb3QHiuCaqTA2ROZ4444S4MgAFJ5GAADdg94AAAqmPIAEgkfEQAAW/RAAAKGjdgA==
Date:   Wed, 22 Nov 2023 07:37:51 +0000
Message-ID: <CY5PR12MB637274F20E0AE776A315A79FBFBAA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB6372857133451464780FD6B7BFB2A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <xo4cbvc35zewabg4ite73trijy6fvbsaxsy6hag5qsr3dyharm@predjydxblsf>
 <ZVTU4TTFYSMLswTs@shell.armlinux.org.uk>
 <CY5PR12MB63727BAD92930CB04DE4DB52BFB1A@CY5PR12MB6372.namprd12.prod.outlook.com>
 <CY5PR12MB637235F27E5114CFB4DE1AD3BFBBA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <aicr2gv4aqsgam4nc4wahacyakwn744xx52uojfkn7fjtd26pt@6lxmiizwkrqk>
In-Reply-To: <aicr2gv4aqsgam4nc4wahacyakwn744xx52uojfkn7fjtd26pt@6lxmiizwkrqk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|IA1PR12MB8556:EE_
x-ms-office365-filtering-correlation-id: 39c9ef29-b742-4ef2-617e-08dbeb2deee7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3HfePVv/1exquW2SfuHO87sJaTYT7g5ikJIQ+BWBma0EvqodV5SPu/u2h0VspKpDdqPorFerdBK6IuAcjwESz8hpn7+x2buw2fMy8ubrndX1djbjtJFjVmA/NmptVmZyF0zF3xLHlEgSGPtjMVdOyAE02/H4AWXvxfZZ9H1stoC1LEA32iINPU2pim60adgXVDj5V119Ef3zvohDS6zy7OrsH5FV+ex5bXZ+oCNQqx+va/ysjGMCkksTdS9Ea8JlvlZ3qC8sunwt/vvc/KtGYjcE2ZluBhKM9y8kfdDPkFHdtuCDVKHMt0fqKx3h/P+7q6degt0xd6wfWrlfj6n6pF7XgKNX4MPTCj4LRWSrs+iaWPdf09P+FV+ydEQv8tR/wMotMXnQbu089+ExmJPp9mTKclPGTZ74PKX6ADqfPwSL7Lcqvzk4ooT3diG2IMGf+mnJ3PzQInghEdTJEh6+bx5G1bUyUeH9J0iuKwIdoIOYqSyW0bjIueLIppmGEAwg/2nequTmiqmq6+xVOv2H1BHmftolPm0Z8RubdcYbxYI+uCByJN52/4yqafXWvNlF4cKG9rQPOH1z0eYXb8QKAVr2qIyY65g6WSTPYqEw5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(30864003)(7416002)(5660300002)(2906002)(4326008)(52536014)(41300700001)(66556008)(66946007)(64756008)(6916009)(76116006)(8936002)(316002)(66446008)(8676002)(66476007)(55016003)(71200400001)(966005)(7696005)(6506007)(478600001)(53546011)(26005)(54906003)(9686003)(107886003)(83380400001)(38100700002)(38070700009)(122000001)(33656002)(86362001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v+7j3moPhRYL3olS9iI5PZ92AjPIuKNUMTbNhITLGOlV0AHWnuYqjglaKBZc?=
 =?us-ascii?Q?sTOulJ2K9pH8Us7rkP3/Yq01LjSJOMG8Bc4VDJO+RWeWTVOwt5dfnc3JjmCn?=
 =?us-ascii?Q?UU2T2QBk92YryQOYAJFzmaeqoy3IXQZ+ThEkzHLvb46pH8WNbq0fHOZ/D+Zi?=
 =?us-ascii?Q?gJOVNL5cSrYI2VBvDNp5R9eStxf/W6jIsHaIUhrTvhEtdik2VOcn7FFE+cqG?=
 =?us-ascii?Q?yXQJNntso6aX3AV7FDHFxyKJOGDbMAAAnHBPNpBmmi9UFx7E4lbJBDe7Kw9Y?=
 =?us-ascii?Q?/74lmsmScm+rKFA5Mc34ZoltW1y3g7uWjr9j7vsUeLZI3AkTH0bBNXSbkjdq?=
 =?us-ascii?Q?rfp29+33Zmsf+dV1qP4uSroFepHMJfz0Trnoi8lnZOc59YtzjseMoPC18Ku8?=
 =?us-ascii?Q?Xtg4Lg+CbgUwL8/qzAK7wz8+Pb9HLKhrCw12EOBsuS3+OhnX0a/uQEZM6tYU?=
 =?us-ascii?Q?tgNEEigINL5k375XK2lSYZVN9VSDZmG/hejIJPtCmEaqnleDwDOfRgYMY1n2?=
 =?us-ascii?Q?eBNFzDauWIa9pivwoq2v8pbO8uLMEuAx6EJEKFAKJ52KeApghc/SQOKnvB6s?=
 =?us-ascii?Q?PKYQCBmllYWVun8yYshCSu/s9JxkQI07YT64On5PDA6zDXSsNkTOBpC0qWYw?=
 =?us-ascii?Q?biM/VoYa76rMnLo4pfS69ntZ+JTjyYG27G+0K9lJeF0wNh279ufjqo7EcN9Q?=
 =?us-ascii?Q?ACAn4JwC1PzNzFkWfYYQolqtEzw2Fq7HaWvPsb4uwOa6hZTqFDsWrythHwtE?=
 =?us-ascii?Q?dvNHPrN6x7/ZUuA5cyetnoIkIAbBxmE9z6n4smuaX7cdYJD6F2ecqIPjtECf?=
 =?us-ascii?Q?yOVI0P/34DhBBFVuaFCdUBB+ub/Df3Uvwe/LiJ4hZN52YyXtCABP2ZQsjbqW?=
 =?us-ascii?Q?lkRk9WTmmiNiOijyU26Fv1Dqbc+0GRSM49I3hcfVHjFOMF1Yg3q51tp8IO15?=
 =?us-ascii?Q?2ltUI3+cqCk61k0dNTFcvNex3YyZzml32hCei6rGOy091UkYZNYE0QLan9dc?=
 =?us-ascii?Q?T1Yr9z6KJIkHxCqplzwJAc+zrg4YnceDSfTduf2hZIrl4dGNm5oh5TpOpY8s?=
 =?us-ascii?Q?uv+eC52JuCFzMt/DApF5gv0lHlFoE04PdkLZUbiB4ut3MjW4qdnJo1rEyyV0?=
 =?us-ascii?Q?3whapgOyzlbKFWRUiQ76I+Nvw+5jTXpjVoCCtndlse65B0g5GULA4PWx6aPb?=
 =?us-ascii?Q?XmllAat/CiSB8RKgMtIVj4uXCI5xG/SakHaJlCMiYXsiqfGPkGGmcpjeimf5?=
 =?us-ascii?Q?Y7NRcfA71iJGOlfpKm6+aHUUhKn2jdKHczuFzWwCvjCtjpqs27ghAWw1te7x?=
 =?us-ascii?Q?DcQw8zpYx+B48mt9xEpuIRsCU6GBJS7QJ6x5gUOvkqGRjkPl4Bw/D2YpVIEh?=
 =?us-ascii?Q?y7Y2yybweO4xIgzL6F5I3LVtAKZ2zL9z+JOIvGXN34Ve5MCiPnQQ0tXKUhjr?=
 =?us-ascii?Q?ePgomdfmnug56lbYYrnPfNmj15YCRGb3t+2356qaiQHZfOS8wvlC5oBBgt48?=
 =?us-ascii?Q?ULR35HjmrOAq3KTjfh0qoJhoockzS/NtGiP9XXkK9XcLOjJnGJ8ijGEsdLfq?=
 =?us-ascii?Q?XYY0fyWvnj/fAj/REdL0gFvbX6JEZBUlLIFmmacn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JqfdXfrQe+4WAb4VY8AIMEz3YG/PvU7xJVyq4uCc0DgdFt/gTIS/lmS0PMfm?=
 =?us-ascii?Q?ixskPuvegwgHIw7e/EWvMIiHsh6/bMemyRjCNLKpTb65YzZEAGYzR5zl6+ol?=
 =?us-ascii?Q?73JIy52IyXVjD/H/eaegZ+k+TSE1TY08ED+ftNSybbp//K3dJU6Lqc8rQ4TU?=
 =?us-ascii?Q?mYxHfGkKNNI8NM/QHF3picWcdIzq/fX+ZFRT9XoCDGM4weIDJlbrqa2MqjNh?=
 =?us-ascii?Q?fon6Ew5ajDf2dimi1PL1B7SE2oavKedcj8lATKFcTm2Ggx4mjQa2qZAIsSE3?=
 =?us-ascii?Q?8xq8PO5ge50MPtxByubbfdJJogqAKwiJRIUWT6/qgW0aOmS023bBr5sSyeKM?=
 =?us-ascii?Q?MJnmSFm4h33sZHCDZKHRpJGe6WzZS/ncIv95mAruE8bZ7ysowkWelnyEAWtT?=
 =?us-ascii?Q?NRXARyZWFYbNVX1BH22+l9CqUJgbOcZaVlfO76CcIM7G5954CGmdu90JcfIE?=
 =?us-ascii?Q?v7Jj+StFjlPGCsTMEQaQPmvMBm6eiW9q6WAyRx2SDJEGQYk/BzVXjkLmGjMS?=
 =?us-ascii?Q?sGmDHzBKvfkl7ELUw6hmEmCmcyKXns0ih4l+SuRNPARlqIowjRK1hN6Pep9I?=
 =?us-ascii?Q?lDWu5KDgwwNeGsjMf4CWzdMwmHJTxt4iR/33jP7BCH1ZgJ7bLnBXQl3fd2MT?=
 =?us-ascii?Q?IW+KP7pybg3Co17TxK1mW8JDGr4nlQV5jBwc651O5ogaCQkpggAttWDqzWIc?=
 =?us-ascii?Q?EE30F5GZ/YVMdZAUkC+cN/r0wYOb4C1Jw1JfcGwy84ef9qN8VnT6u0jPxIsF?=
 =?us-ascii?Q?NxB8KB77URjq4rS5X4pcqJ8akNdfACuXKWXHKFFGwR3vVZ2MSzL2HMQ8zEme?=
 =?us-ascii?Q?R9ujdK90qmR6BimEKnkSpPQCkCeJud2oyEwL081mXm2pSIfwgBjoOGDScg7I?=
 =?us-ascii?Q?dam4lLolzPW/Y/JDjOIANUIK7Q+ChFTbX2iluEME2/RyOPLwmsDBIqgXO/MJ?=
 =?us-ascii?Q?kxsrQmaKjEbF8wMrfhwaMjCF/twGVARgsO7cslgMyDRvGqQfkNFpAKg2Uu7N?=
 =?us-ascii?Q?NmqupktxYr38LTp3EzKbaxhGscqmMeJOMsFbH381sRwQeCffYi3Z1jaIajBa?=
 =?us-ascii?Q?S0tdAsGaBSsU16Fez81TqlB3hkXLS9CcwSSZyGP538TYw8j/u+Do03q1Vpnj?=
 =?us-ascii?Q?EKzrXUQIklUqVCXXXRHwEK/lPpuCZEoHwYdxGmhsvYF9L5zZdDUf6TztVOkB?=
 =?us-ascii?Q?2zSy2CUEXDkKHhTo?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c9ef29-b742-4ef2-617e-08dbeb2deee7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 07:37:51.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVEkGsQFOFxTEbMd6BXjlwONIF2AiALWLkMAOl8P7HIoz3qz6p6YY0kUl1bhYTtdX+0LWKPv1pzOiar48y2CrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
X-Proofpoint-GUID: cY1S8lv_ywMyBhIUt7if0kcMMdGm86PK
X-Proofpoint-ORIG-GUID: cY1S8lv_ywMyBhIUt7if0kcMMdGm86PK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Tuesday, November 21, 2023 8:09 PM
> To: Jianheng Zhang <jianheng@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>; Alexandre Torgue <alexandre.tor=
gue@foss.st.com>; Jose
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
> linux-kernel@vger.kernel.org; James Li <lijames@synopsys.com>
> Subject: Re: [PATCH] net: stmmac: fix FPE events losing
>=20
> On Tue, Nov 21, 2023 at 09:31:31AM +0000, Jianheng Zhang wrote:
> > > From: Jianheng Zhang
> > > Sent: Thursday, November 16, 2023 12:01 AM
> > > To: Russell King <linux@armlinux.org.uk>; Serge Semin <fancer.lancer@=
gmail.com>
> > > Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <joab=
reu@synopsys.com>; David
> S.
> > > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jak=
ub Kicinski
> > > <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
> > > <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.tan@intel.com>; Ong=
 Boon Leong
> > > <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.com>; Mo=
hammad Athari Bin
> Ismail
> > > <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infr=
adead.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH] net: stmmac: fix FPE events losing
> > >
> > >
> > > > -----Original Message-----
> > > > From: Russell King <linux@armlinux.org.uk>
> > > > Sent: Wednesday, November 15, 2023 10:26 PM
> > > > To: Serge Semin <fancer.lancer@gmail.com>
> > > > Cc: Jianheng Zhang <jianheng@synopsys.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>;
> > > Jose
> > > > Abreu <joabreu@synopsys.com>; David S. Miller <davem@davemloft.net>=
; Eric Dumazet
> > > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Aben=
i <pabeni@redhat.com>;
> > > > Maxime Coquelin <mcoquelin.stm32@gmail.com>; Tan Tee Min <tee.min.t=
an@intel.com>; Ong
> Boon
> > > > Leong <boon.leong.ong@intel.com>; Voon Weifeng <weifeng.voon@intel.=
com>; Mohammad
> Athari
> > > Bin
> > > > Ismail <mohammad.athari.ismail@intel.com>; netdev@vger.kernel.org;
> > > > linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.in=
fradead.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] net: stmmac: fix FPE events losing
> > > >
> > > > On Tue, Nov 14, 2023 at 02:59:57PM +0300, Serge Semin wrote:
> > > > > On Tue, Nov 14, 2023 at 11:07:34AM +0000, Jianheng Zhang wrote:
> > > > > > The 32-bit access of register MAC_FPE_CTRL_STS may clear the FP=
E status
> > > > > > bits unexpectedly. Use 8-bit access for MAC_FPE_CTRL_STS contro=
l bits to
> > > > > > avoid unexpected access of MAC_FPE_CTRL_STS status bits that ca=
n reduce
> > > > > > the FPE handshake retries.
> > > > > >
> > > > > > The bit[19:17] of register MAC_FPE_CTRL_STS are status register=
 bits.
> > > > > > Those bits are clear on read (or write of 1 when RCWE bit in
> > > > > > MAC_CSR_SW_Ctrl register is set). Using 32-bit access for
> > > > > > MAC_FPE_CTRL_STS control bits makes side effects that clear the=
 status
> > > > > > bits. Then the stmmac interrupt handler missing FPE event statu=
s and
> > > > > > leads to FPE handshake failure and retries.
> > > > > >
> > > > > > The bit[7:0] of register MAC_FPE_CTRL_STS are control bits or r=
eserved
> > > > > > that have no access side effects, so can use 8-bit access for
> > > > > > MAC_FPE_CTRL_STS control bits.
> > > > > >
> > > > > > Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner han=
d-shaking procedure")
> > > > > > Signed-off-by: jianheng <jianheng@synopsys.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 12 ++++++------
> > > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > index e95d35f..7333995 100644
> > > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > > > > > @@ -716,11 +716,11 @@ void dwmac5_fpe_configure(void __iomem *i=
oaddr, u32 num_txq,
> u32
> > > > num_rxq,
> > > > > >  	u32 value;
> > > > > >
> > > > > >  	if (!enable) {
> > > > >
> > > > > > -		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > > > > > +		value =3D readb(ioaddr + MAC_FPE_CTRL_STS);
> > > > >
> > > > > Note this may break the platforms which don't support non-32 MMIO=
s for
> > > > > some devices. None of the currently supported glue-drivers explic=
itly
> > > > > state they have such peculiarity, but at the same time the STMMAC=
-core
> > > > > driver at the present state uses the dword IO ops only. For insta=
nce
> > > > > the PCIe subsystem has the special accessors for such cases:
> > > > > pci_generic_config_read32()
> > > > > pci_generic_config_write32()
> > > > > which at the very least are utilized on the Tegra and Loongson
> > > > > platforms to access the host CSR spaces. These platforms are also
> > > > > equipped with the DW MACs. The problem might be irrelevant for al=
l the
> > > > > currently supported DW MAC controllers implementations though, bu=
t
> > > > > still it worth to draw an attention to the problem possibility an=
d in
> > > > > order to prevent it before ahead it would be better to just avoid
> > > > > using the byte-/word- IOs if it's possible.
> > > >
> > > > Yes, this exists for configuration accesses, and is damn annoying
> > > > because the read-modify-write of these can end up clearing PCI
> > > > status register bits that are W1C.
> > > >
> > > > I've never heard of that problem with MMIO though.
> > > >
> > > > --
> > > > RMK's Patch system:
> > > >
> > >
> https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches=
/__;!!A4F2R9G_pg!ZnsQc
> > > >
> > >
> 7LKbdCiIj_nLBkt44MRSL8W8YD4WvMmPNkHFlDMrjrVqEVOVA1-P-9BVE3Oa5bC1ymKXLNV5C=
9mJ_rfFtLW
> > > > Fg$
> > > > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> > > Thanks for all your mention about the potential risks of using readb =
and suggestions, I'll consider a
> new
> > > solution and update the patch.
> > >
> > > Best Regards,
> > > Jianheng
> >
> > Thanks for Andrew's suggestion. I consider the solution of set
> > MAC_CSR_SW_Ctrl.RCWE carefully and found that the MAC_CSR_SW_Ctrl.RCWE
> > is efficient for many other interrupt status registers, and some are us=
ed
> > in current stmmac driver (LPI PMT MMC etc). Those registers work fine i=
n
> > clear on read mode with current code. So, I think there is no need to
> > set MAC_CSR_SW_Ctrl.RCWE that will make a large impact to current
> > interrupt handler.
> >
> > I try adding a new member variable(staged_fpe_state) to stmmac_fpe_cfg
> > that is used to stage the MAC_FPE_CTRL_STS value read in
> > dwmac5_fpe_send_mpacket(). And in dwmac5_fpe_irq_status(), use this sta=
ged
> > value and current value of MAC_FPE_CTRL_STS to check FPE status. The
> > draft patch is below.
>=20
> Are the status flags in the MAC_FPE_CTRL_STS register cleared on
> _writes_? (I am asking because for some reason my DW QoS Eth v5.10a HW
> manual has the status MAC_FPE_CTRL_STS flags marked as R/W, which is
> weird access mode for the status flags.) If they turn to be _not_
> changeable on writes, then what about just converting the
> dwmac5_fpe_configure() and dwmac5_fpe_send_mpacket() methods to always
> writing to the MAC_FPE_CTRL_STS register, and if required preserve the
> shadow control MAC_FPE_CTRL_STS flags in the stmmac_fpe_cfg structure?
> AFAICS the only flag which needs to be preserved is EFPE - "enable
> FPE" flag.
>=20
> Such implementation (if it's possible) shall be free from the _status_
> flags race condition and won't require additional serializations. On
> the contrary your suggestion AFAICS causes unresolved race condition
> in here
>=20
> > +	value =3D readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_stat=
e;
> > +	fpe_cfg->staged_fpe_state =3D 0x0;
>=20
> and here
>=20
> >  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > +	cfg->staged_fpe_state =3D value;
>=20
> Depending on the IRQ handling and the task scheduling timing you may
> end up with loosing the status flags anyway.
>=20
> * Note I am not concerning here the MAC_FPE_CTRL_STS control flags
> * race condition which AFAICS already exist in the current frame
> * preemption code. See the configs performed in the open/close/suspend
> * methods, in the link state change callbacks, in the worker task and
> * in the FPE status IRQ handler. Control flag accesses don't look
> * coherent there.
>=20
> -Serge(y)
>=20
> >
> > Best Regards,
> > Jianheng
> >
> > [PATCH v2] net: stmmac: fix FPE events losing
> >
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.c      | 9 +++++++--
> >  drivers/net/ethernet/stmicro/stmmac/dwmac5.h      | 1 +
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h        | 1 +
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++++-
> >  include/linux/stmmac.h                            | 1 +
> >  5 files changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > index e95d35f..8917fd0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> > @@ -736,12 +736,15 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u=
32 num_txq, u32
> num_rxq,
> >
> >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev=
)
> >  {
> > +	struct stmmac_priv *priv =3D netdev_priv(dev);
> > +	struct stmmac_fpe_cfg *fpe_cfg =3D priv->plat->fpe_cfg;
> >  	u32 value;
> >  	int status;
> >
> >  	status =3D FPE_EVENT_UNKNOWN;
> >
> > -	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > +	value =3D readl(ioaddr + MAC_FPE_CTRL_STS) | fpe_cfg->staged_fpe_stat=
e;
> > +	fpe_cfg->staged_fpe_state =3D 0x0;
> >
> >  	if (value & TRSP) {
> >  		status |=3D FPE_EVENT_TRSP;
> > @@ -766,11 +769,13 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, s=
truct net_device *dev)
> >  	return status;
> >  }
> >
> > -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket=
_type type)
> > +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_c=
fg *cfg,
> > +			     enum stmmac_mpacket_type type)
> >  {
> >  	u32 value;
> >
> >  	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
> > +	cfg->staged_fpe_state =3D value;
> >
> >  	if (type =3D=3D MPACKET_VERIFY) {
> >  		value &=3D ~SRSP;
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > index 53c138d..022c1a2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> > @@ -156,6 +156,7 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, st=
ruct net_device *dev,
> >  void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_r=
xq,
> >  			  bool enable);
> >  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> > +				 struct stmmac_fpe_cfg *cfg,
> >  			     enum stmmac_mpacket_type type);
> >  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev=
);
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > index b95d3e1..5496781 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > @@ -415,6 +415,7 @@ struct stmmac_ops {
> >  	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> >  			      bool enable);
> >  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> > +				 struct stmmac_fpe_cfg *cfg,
> >  				 enum stmmac_mpacket_type type);
> >  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
> >  };
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 3e50fd5..6a29f55 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stm=
mac_priv *priv, bool
> is_up)
> >  	bool *hs_enable =3D &fpe_cfg->hs_enable;
> >
> >  	if (is_up && *hs_enable) {
> > -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> > +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> > +					MPACKET_VERIFY);
> >  	} else {
> >  		*lo_state =3D FPE_STATE_OFF;
> >  		*lp_state =3D FPE_STATE_OFF;
> > @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac=
_priv *priv, int status)
> >  		/* If user has requested FPE enable, quickly response */
> >  		if (*hs_enable)
> >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > +						fpe_cfg,
> >  						MPACKET_RESPONSE);
> >  	}
> >
> > @@ -7280,6 +7282,7 @@ static void stmmac_fpe_lp_task(struct work_struct=
 *work)
> >  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
> >  				    *lo_state, *lp_state);
> >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > +						fpe_cfg,
> >  						MPACKET_VERIFY);
> >  		}
> >  		/* Sleep then retry */
> > @@ -7294,6 +7297,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *pri=
v, bool enable)
> >  	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
> >  		if (enable) {
> >  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> > +						priv->plat->fpe_cfg,
> >  						MPACKET_VERIFY);
> >  		} else {
> >  			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 0b4658a..1322c78 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
> >  	bool hs_enable;				/* FPE handshake enable */
> >  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> >  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> > +	u32 staged_fpe_state; /* Staged FPE state when read MAC_FPE_CTRL_STS =
*/
> >  };
> >
> >  struct stmmac_safety_feature_cfg {
> > --
> > 1.8.3.1
> >

Hi Serge,

Thanks for your suggestion.

> Are the status flags in the MAC_FPE_CTRL_STS register cleared on
> _writes_?
A write of 0 has no impact irrespective of the value programmed in RCWE bit=
.=20
This is safe option when writing the MAC_FPE_CTRL_STS register, which will
ensure that bits[19:16] are not modified unintentionally.=20
When RCWE bit is 0 and status bits[19:16] are read, those will be cleared, =
a write
of 0 or 1 do not have any impact in this mode.=20

> then what about just converting the
> dwmac5_fpe_configure() and dwmac5_fpe_send_mpacket() methods to always
> writing to the MAC_FPE_CTRL_STS register, and if required preserve the
> shadow control MAC_FPE_CTRL_STS flags in the stmmac_fpe_cfg structure?
> AFAICS the only flag which needs to be preserved is EFPE - "enable
> FPE" flag.
I think this is a good solution, pls check my draft patch below.

-Jianheng

[PATCH v2] net: stmmac: fix FPE events losing

---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 26 +++++++++---------=
----
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 ++-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 ++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
 include/linux/stmmac.h                             |  1 +
 7 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.c
index e95d35f..9575e84 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -710,17 +710,15 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, stru=
ct net_device *dev,
 	}
 }
=20
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
 	u32 value;
=20
 	if (!enable) {
-		value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-
-		value &=3D ~EFPE;
-
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
+		writel(0x0, ioaddr + MAC_FPE_CTRL_STS);
+		cfg->fpe_ctrl_sts_shadow =3D 0x0;
 		return;
 	}
=20
@@ -729,9 +727,9 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num=
_txq, u32 num_rxq,
 	value |=3D (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
 	writel(value, ioaddr + GMAC_RXQ_CTRL1);
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
-	value |=3D EFPE;
+	value =3D EFPE;
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	cfg->fpe_ctrl_sts_shadow =3D EFPE;
 }
=20
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -766,19 +764,17 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struc=
t net_device *dev)
 	return status;
 }
=20
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_typ=
e type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *=
cfg,
+			     enum stmmac_mpacket_type type)
 {
 	u32 value;
=20
-	value =3D readl(ioaddr + MAC_FPE_CTRL_STS);
+	value =3D cfg->fpe_ctrl_sts_shadow;
=20
-	if (type =3D=3D MPACKET_VERIFY) {
-		value &=3D ~SRSP;
+	if (type =3D=3D MPACKET_VERIFY)
 		value |=3D SVER;
-	} else {
-		value &=3D ~SVER;
+	else
 		value |=3D SRSP;
-	}
=20
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/eth=
ernet/stmicro/stmmac/dwmac5.h
index 53c138d..aca846d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct =
stmmac_est *cfg,
 			 unsigned int ptp_rate);
 void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg=
,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,=20
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/=
net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 453e88b..a74e71d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioadd=
r, struct stmmac_est *cfg,
 	return 0;
 }
=20
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe=
_cfg *cfg,
+				   u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ether=
net/stmicro/stmmac/hwif.h
index b95d3e1..68aa2d5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -412,9 +412,11 @@ struct stmmac_ops {
 			     unsigned int ptp_rate);
 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
 			       struct stmmac_extra_stats *x, u32 txqcnt);
-	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			      u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index 3e50fd5..7791e9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_=
priv *priv, bool is_up)
 	bool *hs_enable =3D &fpe_cfg->hs_enable;
=20
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state =3D FPE_STATE_OFF;
 		*lp_state =3D FPE_STATE_OFF;
@@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_pri=
v *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
=20
@@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 		if (*lo_state =3D=3D FPE_STATE_ENTERING_ON &&
 		    *lp_state =3D=3D FPE_STATE_ENTERING_ON) {
 			stmmac_fpe_configure(priv, priv->ioaddr,
+					     fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *wo=
rk)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, b=
ool enable)
 	if (priv->plat->fpe_cfg->hs_enable !=3D enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state =3D FPE_STATE_OFF;
@@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
+				     priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
=20
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/=
ethernet/stmicro/stmmac/stmmac_tc.c
index ac41ef4..6ad3e0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
=20
 	priv->plat->fpe_cfg->enable =3D false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
+			     priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 0b4658a..48385c7 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_ctrl_sts_shadow;		/* shadow of MAC_FPE_CTRL_STS */
 };
=20
 struct stmmac_safety_feature_cfg {
--=20
1.8.3.1

