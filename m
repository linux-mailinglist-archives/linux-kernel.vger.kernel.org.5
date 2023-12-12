Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7444F80E4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbjLLHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjLLHay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:30:54 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACE2BE;
        Mon, 11 Dec 2023 23:31:00 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BC75FbO029571;
        Mon, 11 Dec 2023 23:30:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        pfptdkimsnps; bh=PEidMDKAjlKzZjDd1YNTGdjPqlwzqD+J7geT54HEZyU=; b=
        cD31LcrKVzUvGHSYb3dRNGgYI+hp6kmNIyxlZZGFFwIdp+rck9o9av9WgIygcBLD
        1CgrhubjyjlIfJ1PwHoKDZTYRHb043E7qk3LeL2tnSsRmiYaFr4tDH5hPrBM5jM8
        wjw3XTkQCbdXNT9VMXTo8ClgNGZOpUfhl7h0jpH/YVUCXVRqCOZ/Lqo4TXVa/C96
        Y8Rm+gKWE/NOvHiTxkN2yKe/LT1mkm1UKmT4vS1tBRlUqpoMmhyO3t4PaU/OWX0m
        pCreL9+nKwKu2E0MX/2lS3QuMMm44Ky3xVHHflgzCZZLucF/3lt3I0fE/O3oIt2g
        jTHzTTX7RNkgSAIkBXAw0Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uxcbrsttc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 23:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702366233; bh=sghrhUe0M6FeWJ++oEO0frldDF8GhNR3BYivubK+l14=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DMFGs9pDIFtGemm8Bs/9dDXDfdBmGG02e6Ashf2KQNx3s2zXKPAmvbVPX/gNN1z6e
         vx1OWbuHtTcC+XxLvkIONdGA1CC1WojOSORtTWXZktUa0yHi/1qocn2U244bXfc7s5
         qaYHm0aWPlLTmlqxzVqh7xYZ2DmUJS+WA3CCqBgbzjVciuCxbAEsRE0YyKsfPJyQiv
         eOGX+igsyH+T6g6myyhnBeujuaWQ5DLnmpDapxwALv/C5n4N4H8dhj0dXR3kkTSqEv
         ZxRDZ0VxEgHsWHwt8AvM5Cmv54PKaHxdcQivcg/VJdWRauXrYx82niTByuXL/XyGgE
         xS+BwUt7WsfGg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4C1C40234;
        Tue, 12 Dec 2023 07:30:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6726CA008D;
        Tue, 12 Dec 2023 07:30:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mUMFx3Z0;
        dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A28A8401C6;
        Tue, 12 Dec 2023 07:30:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEEhjli/dmApJ3EIOHu0wkrq9NfsjNzHYsGaRjNB+tpNVG5PBSIkLofkZBtm52hqY4mIVAdc3PDdrbOpZpRIoH3x625MV+QECqS0jkgZJynMJ6ky7hIQHY/E/jd3u8cVdDYf4T4wRxXmfshoQHOReb48ZWhSYeEkAlUzi6QorypXG61XBs8ePbO2WLJbIbDBT4HAQt0GyIPLbk/gE/TejLTzalN54p7w6RUvVF2rqY5sNgJJ9UbPYoT5zemZelIU0PCsa/wrxJEJfiWesiGulyW+VC4bhaC8LQD7rDYZ/rFbyZQJcgEKwt7bf5oeLlceOwBOa1eI9l9bqoCil2wypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEidMDKAjlKzZjDd1YNTGdjPqlwzqD+J7geT54HEZyU=;
 b=VB6n+h1TB46o9rHv5vM7Gs4KlpCAdqIOpOabF5w1RFCYJ+GEhly9m3Pz5xh5KIAb9UgXEN/x7O/86zDY9p891Y1fLB6ldbbUB/x2K1PLRUnbS9/S6LCWfM+kys7/TFQGvS3GWW7DhEzx4pue0Jfguqnlypo/DVYXnYjhhBWrCMBxaAk9ImcKERQo5h8mrHYxfFcqaNlq59kbRoV35oj6CWmCm+HohBZUREPvrb/62rV7WBH35XfxbVAJHMun6dosWDdHMKIxsp3PFjIwI9P1+3Qf0t/nFNGuRqKl4+DOuuVoP/37F4EIJqBvhOU230uzXhwTiujo4wD0YghBDqIUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEidMDKAjlKzZjDd1YNTGdjPqlwzqD+J7geT54HEZyU=;
 b=mUMFx3Z0J2j3KRaM/8g8G0u+6KJR66Q1qusBxRngDBzsDVGlGTcxMYhDIyuFjhxX6W+mQ8bY90C2tc+C7Nv8+8g5Preu14CLDN6uBNaYnrzq5DlldK4KVKRgcrW33mBHpQH2sCz6NldQcy3PEK0pwy1AwnwyX+q8QzYIPfTmvr4=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 07:30:25 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 07:30:25 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: RE: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Topic: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Thread-Index: Ador+H1+Z6wgRV0bTDW+VJMmnuYc6QAPxbGhACUYIhA=
Date:   Tue, 12 Dec 2023 07:30:25 +0000
Message-ID: <CY5PR12MB63726B47863B27B04CD01073BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <20231211134008.lbtm6pjtufkhtvfj@skbuf>
In-Reply-To: <20231211134008.lbtm6pjtufkhtvfj@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|PH7PR12MB6905:EE_
x-ms-office365-filtering-correlation-id: 4144d2f7-e3fa-4861-f665-08dbfae434fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TuacGQtmBsoKwjgHLXH+0zgV8Pm3808tuiOXrZO0yOjrbXvae87yJOfjBTl11jx5H5i6szGZ9aa5Jq/PgX/S2gkNn/DD8m2/ZF3uNwKFwm6XrLFOCbQHRwjjzUqTfjSoEKyO/EU3UX+lVHe4EevDVTUJNM0NQi+/rkMTrKSw6WxkgeqSjuvCBOqnTSb+2gsY6VFZZbxfvA0yYY2pXCsk0cMZGvH+yhhuMXPLJ6xmTXbP0QanKrSagVrUF4j/iyq7UDnYHZgVf5mb6l6EvBK5VJuG4w21L4ZQzwSQE5kxP9pif2Key+OodF6vCbcmU252QAFjz46aN/4WWezPg/Rq0kx7YdNkTXtBtSJztKe0g2410Xs89DxvE0i/O4d+UgMAFxNjPX1FPxLuPQbj6LBbRLmm2IHXkv8SBJXa4Hd8dWEF2Da+OAx9m5PUuX0l72SRYpKrRHsVcpbNFsAnk1eShiFhBhM4jpuelS2jJ6k76xf446NPh3J+D6yBy83VS03C9eUeTnB+Fn0dZ/dNbi1Z4pMWjwh/1XTkegVSHPP4RpAOLOmBpRZucY7YtoyXesFqIjnpsu8wqCbDoIJgM9TZJvgUYAEm7mQwr4Z4xcgBkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(83380400001)(6506007)(53546011)(7696005)(107886003)(9686003)(122000001)(5660300002)(8676002)(4326008)(52536014)(8936002)(41300700001)(7416002)(2906002)(966005)(71200400001)(478600001)(38100700002)(316002)(6916009)(66556008)(54906003)(64756008)(66446008)(66476007)(66946007)(76116006)(33656002)(86362001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SGKASsktzo5aDI7ohP0nQyUT7St01+7l37r7RvdxjRBsh6CD0r7Abptlvs5v?=
 =?us-ascii?Q?mrzpf7+mVq+FDXoloMkvXomD/XMVgWBvDYfw72dCqS5XUtcCJCVrXPESUthg?=
 =?us-ascii?Q?JZwpE6+i0n73r/SG2YHerzPgsRUySO6nW/1Bed/47se/XFwGeDilr9KilLWW?=
 =?us-ascii?Q?1TyeOVI1FdIss8wYdh/ABa7jA6yApNBz8vJLRrNLhvS0wAbqDQr6PSWMa/Je?=
 =?us-ascii?Q?7b0nIrOsPGL1qx4FXRbuxE5iNunOcDPuH3mRh+2l7hJVmaMR8V5FgM7E1whI?=
 =?us-ascii?Q?f0m9t+NSevARsJ0YRDzzQipG043ss0r7HaK25K201+cXK5/wLCFajnCq/KA+?=
 =?us-ascii?Q?97QX3wcN7JQYfJe5YIglQRu8oA20YzYPpEeoyso/uhP71+NoO9MACm5HazlK?=
 =?us-ascii?Q?FJ/bIJGVoBQIrOh7WK4Jfd4/4CNQpSKjs/XAtoyPxdQs87oClHiLSUXTbNry?=
 =?us-ascii?Q?sz/VSg/hLvuU5ppFkGyqH059SDytkVV7RrMtunPa8mGNQ2O7KZuSVYXB+YXC?=
 =?us-ascii?Q?tt0LIApk08Cg1xfnLXmznDJpkyXqyBa7DKP5OPtdY/MN7t5hOjzsfMZK45TO?=
 =?us-ascii?Q?M/himvWfbkT3zE9KxOP/ISYderFs/TuG9G5VHWxVB8+OoYApo87l7zxAQWf7?=
 =?us-ascii?Q?O+U4azrVNQ9Bp4TBm/xtuhAjbBsGHeF99PeGfla4ysnwMrST5vF0y1ux5BzR?=
 =?us-ascii?Q?KN4Sjn9pgjaiCkYCtIIpcEoSE/6WrXo/npxjPmRQeXu05eLqswwuorn+xS2a?=
 =?us-ascii?Q?BhkugYyrQttQazfi/8E0yz9kwqFbv6DjY02GOEfwzjSw+Eidr6TE6z6CeEXR?=
 =?us-ascii?Q?YwPoJ1h0m+VDrnQpi6NlHNGeTXQiNJ6MJLPCuOqFh67rD1x3yLVaHFeAqEv1?=
 =?us-ascii?Q?F6WHtkfYi3MYMf9xFZl0+xnWhfASq+qY8Sx4UbC3IffeP7H7kaXJOFA8cajj?=
 =?us-ascii?Q?S1dw/hQQgaLL1WcsIEzjaW8sdEJCci30lUrwl/YotlFaQOuslvneK6e/9/KI?=
 =?us-ascii?Q?/fOI2Y1h1bXeULJHyAI/C+HEIPS6dBvOIq7PseYLf5scB6dfHhfiv8FtBDJJ?=
 =?us-ascii?Q?PM27oCjTVhSOch6Pto+LDvxXQYbNHwMzhrwaC66Yq74iUc9hCuCHhU4JtAUs?=
 =?us-ascii?Q?GAXM/jnx58LsUND0+v1FAq99eUxmYZ50n6wZ6ZqutrTEV96YRZTjThI3rW8c?=
 =?us-ascii?Q?08lPg0DpKVVZLiMWCaOKu6P8tl13HHE5xjRro38Xg3gRvJoRJ+yObcr9gOvz?=
 =?us-ascii?Q?9PLEca5gj9dmV8TaP2p8zWEG2zKaOjuQOFL20MrdV5Do2xxeKfPvsw9TOoYx?=
 =?us-ascii?Q?K4yQp7LyUmM3TmDg9LbkgkHCJHXPTCwwgFTqIKjVzUVVOUXnJEFHw/5p0PXx?=
 =?us-ascii?Q?b8l7oUsSFMRQD6FjgJ3lWYtmr0349fTvuQnQVcnHmLwevjB66PwqjCZbQyHE?=
 =?us-ascii?Q?3Gi6u+7ZClXWk2NEAnMVVIHuI3dhrmayK9RH7qTZCr0SvbkVNoHjJARzbIJT?=
 =?us-ascii?Q?E7gTST8y3z0beOj6y/JBugZhwTB7oyZr0rLh1Lj467WOnCVPHpQdUJdDSVYJ?=
 =?us-ascii?Q?WwP74WGI6xiwnal9XDaJI1kxQbiRamEOKfZtszHp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?amLNi5s063JKWVuzfiLI/F0t3ULAhFcWmx0DWH9Ir0gmN/8WVOBr4uKobYoa?=
 =?us-ascii?Q?yToPUBbmdCuJo70tnFihLkh/pGS36AmUADaJgoEKBXUA8qsvLF3AB1/13lPr?=
 =?us-ascii?Q?Bf0fOvZVhczJejxrcLj03BKKvV+8tvjDVvCGUpdX6x5HXEPCq0j356gZFG7r?=
 =?us-ascii?Q?pS+hFWZ3xIuDW+C3pr1Zzp7jYftFtoZw4ClsoWcJ5PfiLBg7e69NdRY4RwfA?=
 =?us-ascii?Q?LkSXuyaqcbOoliLOG405i3wf+ROGxkmIB4l0Nnt8ECIXbWo9fYSeVoIEcv4k?=
 =?us-ascii?Q?kq4BbEinIT9WbtgZVrhP/Uyv0xYfQMYLkAf1GEIVgxGuyomhc/oZiLnnaPk7?=
 =?us-ascii?Q?82ZY5GE9RL4WbO8D0zv8gPPf0mnazY4/7bfVvMzAvQ5KYGrlxHpZClxDKPf7?=
 =?us-ascii?Q?jtOUkbw5y1tE5QX/d+xe+Po+A/utdzzkG59HKdpNQcqZJx6t5Wvh5ToekgZF?=
 =?us-ascii?Q?ix1ihXwgg98ADOsCkcO46HmOgq1O7c0i3oXnmL7C8q56y+jQOBhXt+9iv6kB?=
 =?us-ascii?Q?40Yju8egDFUgQLFP8sNdGTryR7a9DunVsizVWevXJuGl8SSfg1vnzOdJEWYk?=
 =?us-ascii?Q?XgHopNzSUj1dBaluC9rKxsCvFH8fu+wCMnbDumND4p+pGMq3d4g4mkBd+Fi/?=
 =?us-ascii?Q?vXFVQPPmUUh81JXCQCQ3ze61vvqSxjExcIUvRsyWRB9LSZpe7TtPqpcEK8H1?=
 =?us-ascii?Q?r54PoHyA1m8v1S9+CzuAZLTTxlQTVD/nBLuczzaY14YF7FsVFwmDSOzQE+Ou?=
 =?us-ascii?Q?WeOexd0MsrRFgOPhxu4odMRG7gp4XSMYq7DCkhX+neT0Eaf/Eu6yMl+0g4/i?=
 =?us-ascii?Q?sBYs2M8kHQotxsZGNnlxNkSW+mu50ayq1VkWNqm1ADLvv33Hel/pPX2G73si?=
 =?us-ascii?Q?zyO/nhYrb/mqu+CPkSmvHkL0b/xjrTEr2dWh4A+4VgxQiixfueoRVTf6tiO5?=
 =?us-ascii?Q?teZ31RldOgQ9X4zYUosRl/0s4WVM/T+IIIa5fJanASagtB6upeQeYfB+0GFS?=
 =?us-ascii?Q?tKDsSS6rr3D5C8dC6ua5qRptHD7R70cR45EAS/tcMghqmVAfSDuHMP0payby?=
 =?us-ascii?Q?K+LKCZtrsVUMs8DPd4TnPX39+83QvUaoIA0adrWW16mFk6Nic1xmRfN0fLQG?=
 =?us-ascii?Q?atnJyWnqTKHg?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4144d2f7-e3fa-4861-f665-08dbfae434fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 07:30:25.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIhuAWvNPAFpJU+8tb+KFjiR2fGzbCh2WfnXB5gwmmcU4yS80DX3T2mJZP2X0p9W5nnCNycryrbXcfKAwKT1VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
X-Proofpoint-ORIG-GUID: cjhU7AYOyhWJ5ekS1AW_Qi1Lnqsx5tpr
X-Proofpoint-GUID: cjhU7AYOyhWJ5ekS1AW_Qi1Lnqsx5tpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=932 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312120057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Monday, December 11, 2023 9:40 PM
> To: Jianheng Zhang <jianheng@synopsys.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@=
synopsys.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub K=
icinski
> <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; open list:STMMAC ETHERNET DRIVER <netdev@vge=
r.kernel.org>;
> moderated list:ARM/STM32 ARCHITECTURE <linux-stm32@st-md-mailman.stormrep=
ly.com>;
> moderated list:ARM/STM32 ARCHITECTURE <linux-arm-kernel@lists.infradead.o=
rg>; open list
> <linux-kernel@vger.kernel.org>; James Li <lijames@synopsys.com>; Martin M=
cKenny
> <mmckenny@synopsys.com>
> Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking s=
upport
>=20
> Hi Jianheng,
>=20
> On Mon, Dec 11, 2023 at 06:13:21AM +0000, Jianheng Zhang wrote:
> > Adds the HW specific support for Frame Preemption handshaking on XGMAC3=
+
> > cores.
> >
> > Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>
> > ---
>=20
> It's nice to see contributions from Synopsys!
>=20
> Have you seen the (relatively newly introduced) common framework for
> Frame Preemption and the MAC Merge layer?
> https://urldefense.com/v3/__https://docs.kernel.org/networking/ethtool-ne=
tlink.html*mm-get__;Iw!!A
> 4F2R9G_pg!Z461fiVMBqXVlpgdD8t9ey1qGp6_hZg9jNlY__TljPgVHZcYbqtzqQhbI9IpjDo=
HBoOCX14vZOf2J
> hZgsW_fnQ$
> https://urldefense.com/v3/__https://man7.org/linux/man-pages/man8/ethtool=
.8.html__;!!A4F2R9G_pg
> !Z461fiVMBqXVlpgdD8t9ey1qGp6_hZg9jNlY__TljPgVHZcYbqtzqQhbI9IpjDoHBoOCX14v=
ZOf2JhbkJXuqTA$
> https://urldefense.com/v3/__https://man7.org/linux/man-pages/man8/tc-mqpr=
io.8.html__;!!A4F2R9G_
> pg!Z461fiVMBqXVlpgdD8t9ey1qGp6_hZg9jNlY__TljPgVHZcYbqtzqQhbI9IpjDoHBoOCX1=
4vZOf2JhbEBQbq
> ZQ$  # "fp" option
> https://urldefense.com/v3/__https://man7.org/linux/man-pages/man8/tc-tapr=
io.8.html__;!!A4F2R9G_p
> g!Z461fiVMBqXVlpgdD8t9ey1qGp6_hZg9jNlY__TljPgVHZcYbqtzqQhbI9IpjDoHBoOCX14=
vZOf2JhbOMeXO
> UQ$  # "fp" option
>=20
> I think it would be valuable if the stmmac driver would also use it, so
> it could support openlldp and pass the selftest at
> https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master=
/tools/testing/selftests/net/f
> orwarding/ethtool_mm.sh__;!!A4F2R9G_pg!Z461fiVMBqXVlpgdD8t9ey1qGp6_hZg9jN=
lY__TljPgVHZcYb
> qtzqQhbI9IpjDoHBoOCX14vZOf2JhasMiyt2w$

Thanks for mentioning the common framework for Frame Preemption and the MAC=
=20
Merge layer. I think it is essential to let the stmmac driver support it ne=
xt.
And it is also needed to avoid the code duplication mentioned by Serge.

Jianheng
