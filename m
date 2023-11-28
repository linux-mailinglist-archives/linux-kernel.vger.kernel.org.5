Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF517FB0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjK1Dtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1Dti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:49:38 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C584137;
        Mon, 27 Nov 2023 19:49:45 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS1MmNj002863;
        Mon, 27 Nov 2023 19:48:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=rcgKfJdETh892fQ/ljCiVYDofaMoMAPX0Cc85BYWidM=;
 b=XpGIK+LVw+G3c50e9ibQBsjkf0pQ8KJI7dxwJFRoQ2uqVCrcvUyhPPR9tpPw2iAaFcKw
 IXTunrY7H4dts53JiLanoWQPpcSNUGztzsRW7u4WZA558/bbEw1QfMYoi1zhh2BA0pEX
 R1uDZA651PxxjI7OKOKJaKnW3I3X6bbClL9S7U8YpsOevCwIoSkPVNOtAvnyIsFbGOiw
 hyrwdte8vU7fxaVN7EqajJPJ9ye+I0ILUoCfmsFGh+io8Mhf6ui7o5Vt3CXTgr2GUY31
 RA3s97YwlCk8BPoPloE4UYRofdVj7k0gHEDFY9zd181jvVRXEfYuWGgtICKroOXjAYL8 hw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ukgtugk1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 19:48:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1701143329; bh=rcgKfJdETh892fQ/ljCiVYDofaMoMAPX0Cc85BYWidM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bqj4LEjEfjsQQ/dkUY4txXQVd7rongRId2B3ID2yT/CoheTZhyt3xE6QppbLHr3mi
         lmoLFCtW9cdPOPEltWO8UdDMmxVp5OyLtjIcfK+PP11sWKC4LosxzuLHH84+oKrmnO
         OIA4ooJc6CKPp/qj1UClF3tfJfGg3lr90/nCiVkW0p2UZPEJbF2qPtj1Uwgb/oLxLh
         4F0jscGnKVqQ5I/nMGTTwObA3gZk8Q97D/edJTiVXy29lLhb1YK7utDuTC2YEgtL4v
         5NTIA/KNvdOvaIgKpvwdAl+vwrLly5czh4ZS/6PiPYZyOKAKlO7rkkzS7JmdVQr/RY
         +X9h3v2sWOxvQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A74CE401C2;
        Tue, 28 Nov 2023 03:48:45 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EE85DA0082;
        Tue, 28 Nov 2023 03:48:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DEbZzE7W;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AD6624041D;
        Tue, 28 Nov 2023 03:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxrhIqZusOI2QL9dTcV2gd5MlTdeKuCWq2sY1KrIMVACgKJmkLKz08H6JQJlCavyqs9YMsQ/dStIhgFQcTct3a32OowIY+91dHYozvGB2uM6rAUvCFoEwVeEOP5ZZmrf91omTUF35NTCmG5prVj6Ny6N2cjgjGHta8taNmmOoLHibGb/z5xkqJEN28jmUyHURvzLthsjG148mRhfrg8ssu0KpVqposgMxgRF9JOqTS5g9CkBmOgKMahzGBrlMD5JhT9d/e6bK+MqzszfSufWD2CqrbMbkVMHKbF+OjxEx7U8d5K2cDkrMWr/RIPfcLYbCu+U8WmLgRYofs6OJMKmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcgKfJdETh892fQ/ljCiVYDofaMoMAPX0Cc85BYWidM=;
 b=lHylKJMRl44fOO6GzALkULdtWT6T5YxLTzU8thss68P0FGoa5mkJ332wm1Jr3tYe5JBFMRfB5uqwDUXrlYtcK7glpoY/d4Bo2GTxKA672oNRvnh9GigsQa5mvkq7muj42RypMgtMkTaHvl2o91JFyKlJ2pCELuTI0A7zv1JZQFB+kqE8ZZUKA0qIwKIiyyR8mETTRS3rPJoSkKJZCCJW2ieS/JDemHXQnLYR+RYQ2LzTIU3hQH28E09QhaM3AFE7M7YPpnyzREEsnUeJV2EYkEWBJPDcMIyH+wSBDWHX0r3YNLoVIEwHPLz1sSTR3yHF8w9ypHCcrIy1dPwhjshW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcgKfJdETh892fQ/ljCiVYDofaMoMAPX0Cc85BYWidM=;
 b=DEbZzE7WAxgjbVqu1qVQRw5/uuK0bqsZlPIbIbvPXTAuzmlhWjCisEAcuf4j1Qw0Ft0EKJKugd9m9f+59PPwo+pOpkaGrL4Wz6mGe1SZ20W1T4xN0GRNueqlKuNfrLFe3K3+IPri6o/weHLovMMSrQR/7ChYY9EosrKnmQ65Fl4=
Received: from CY5PR12MB6372.namprd12.prod.outlook.com (2603:10b6:930:e::5) by
 CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.29; Tue, 28 Nov 2023 03:48:39 +0000
Received: from CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a]) by CY5PR12MB6372.namprd12.prod.outlook.com
 ([fe80::dd25:e93d:e181:929a%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 03:48:39 +0000
X-SNPS-Relay: synopsys.com
From:   Jianheng Zhang <Jianheng.Zhang@synopsys.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        James Li <James.Li1@synopsys.com>
Subject: RE: [PATCH v2] net: stmmac: fix FPE events losing
Thread-Topic: [PATCH v2] net: stmmac: fix FPE events losing
Thread-Index: AdohAAc1mE7NHpFkT9GQaksVD24B5AAp50MAAAFe6FA=
Date:   Tue, 28 Nov 2023 03:48:39 +0000
Message-ID: <CY5PR12MB63727F5A7C65FFCBF05D3328BFBCA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <20231127190446.58f14db6@kernel.org>
In-Reply-To: <20231127190446.58f14db6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6372:EE_|CY8PR12MB7635:EE_
x-ms-office365-filtering-correlation-id: 3dfa0a84-357f-4219-513a-08dbefc4e85b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmn6OiYqFpwBEJhT4AnyxHmEvAjl/ZXFeua+OMQ2Sbas+f1uzDN6CELmskm9mYMVb/hax0IVhEGvQbN220gDThnj4FAXaIKBcr/JvyuIuXmL1CI30x+Nmv/FzkSKVgxln1M5zG2jEXVBkqjbLdthVpbjiTjFoWcBjZKBuKkp3VV7nOdQF1+BQIFm3OdAeca0uH5S2fnFuHiG4wjKv4/P977fZH8eZKsuKy4C8U1ynS7Z5le4gJXqRUAFZI/NKn+My6IQi8QW/kJd5XlU3LZyPYVQL/gdOQo6rujWCrRl1d6sRN4dhountqejvrOjZ3IqImcVLSUXji4whpVegfWyEX2/x2yXiS9kWf1jYNbRHP1A78Msjs/eBVPmnp0Jy+/ZWnn9rTRbCfGX1FXemNYHDVD+6U12PhYsomaJjqy04CNkV9wUqanR4+p5gQRjeBA4rqiWfQGfLle8Bm6meyHVOxntTsfO/uWTdTyWfMJ6BnA0TOtDd0k94InRGEQPdSFxhAidV/NNOJ3ShD8OjR4gBFeoSu1nnvsmcE31PBrCtJGRoLjdnoph8MKADJZz1kzg4haYyTekf8aaJvZ4BxrJ09j9vIz8mnc+Bdt86jyd4L2qd9C9CPURssLq01oD3c47
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6372.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(33656002)(38070700009)(122000001)(86362001)(6916009)(64756008)(54906003)(8936002)(316002)(66556008)(66476007)(66446008)(8676002)(76116006)(66946007)(41300700001)(9686003)(55016003)(53546011)(71200400001)(6506007)(7696005)(478600001)(4326008)(5660300002)(7416002)(2906002)(4744005)(52536014)(26005)(107886003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?loCIC1QOPClVEyTHyNYQC4Rssf6D1Xml35dsuuMjM/dsOdUl54cDYcE9ZLjJ?=
 =?us-ascii?Q?iCvZpMDWd56nvaxo1hYpPgaRi2tvOM17KZR+OrroNQDGkxqXnUZQfc4R85y8?=
 =?us-ascii?Q?nyLhJ5Q/rk6hYvfJe2MSaL/g1H2zZtxYDoFMw4+amgSCWMW0pAse4xKHhbhq?=
 =?us-ascii?Q?61QKDFYh7nnGZP6Ud8eoP/0FBXPEpfd6MspR1OVj6m2lPysh3FDYO7u1JaHm?=
 =?us-ascii?Q?PCQubf0jZx5Bfhn0Qr4Xw3TY+ofv08uBE7sOY2q9qXniDuhG3HkCxl9VJ5WV?=
 =?us-ascii?Q?ltl6uac5JbyQ+shLmBM3ljgbwHfYJCvuz46NFnoTGUMXR1cU+zo6rA4t3iyI?=
 =?us-ascii?Q?tAOwwrM4vlfPUV/7AIssOoul5rRcu3RyhBDlWqmrch/a5dl3N8/Rb2z4iJdv?=
 =?us-ascii?Q?2tbpDtYqp7Q9yYwMXbrDaZRUrHT6oexe0t5DK9iKcSyiDBkHd7rbUFN2njxY?=
 =?us-ascii?Q?c/V8+EyjbnyR9iQyx21HrYVe8hJi6BQMk9gAhP4kWJESyXs1WOtPb1HZUqxB?=
 =?us-ascii?Q?YNP0DQesf9glrowNXq5qfOZtCQWdR03SSSfMMbM9cDO5PXYLECHr84Nu82n6?=
 =?us-ascii?Q?HLX42ceg+KznHU3jCPhfg3d5qfAgZyiFHUAiC6vUue24Zc+JG3hEWrQKPsZm?=
 =?us-ascii?Q?83gFSlgTYBQRe0nLw5z9otHTFaO8BU5Awr157abtCuaCtKfwDhev9cWMeiMC?=
 =?us-ascii?Q?4L+lmjxDnhFgJG4Uyc+5IpQU4+jznDlvrkSazxPHK22+BzWrd0zQ9PsUaM4m?=
 =?us-ascii?Q?Kb1k7/5+TRiRwWCAQS8qWHxS4nJQwQoDL2Lahkq83qo3u7VTo4FjyZlRwvKB?=
 =?us-ascii?Q?8jo5k76wf/stFCaaz0IOyh8MFaWZ6xclWIkJTxC29oFNn12FlDtAr/kEf1Du?=
 =?us-ascii?Q?vd37PAzW9t1NHlQm/aCBPX0mNmQYdNeHJnj/h4zqv0aN164G3tSOiksolgCq?=
 =?us-ascii?Q?NTot111LnFPqZdYsHJcbYFbga+C5fR1Jzz2UHIHrqpNrn2jXVOmGUqmUH5jE?=
 =?us-ascii?Q?zAwiXstjGSGjF9YLIjr4Fhmv3YIDMqJ9GlDRDclSJKQt/Fm/eHEPtTyeZZXh?=
 =?us-ascii?Q?gi1ODqzxBu9X5Vt8X4VepYzesHkr19k4bvy955lEzY6QT2Gs212bHOpfp7Mc?=
 =?us-ascii?Q?n+15IOiU2fdDSVxzLxfo14RCM1rD9EmjZRnRSWPqapVNIfnUMzAB3WquHoS+?=
 =?us-ascii?Q?lpNfoZeDTX0v6c4G4q8ryLpBYRcb76hzXCdU8cGjXLv6amZ2E5muehcHOPyr?=
 =?us-ascii?Q?2CF1MoFKBvIIt25EYLd6k1j0SGuSPQV3sD6CIzGgNbczVcnwOjO9z4LHshm5?=
 =?us-ascii?Q?ZQCc1MiKTIvhVqlTH7VazSCpTeXOVpdOX9BhmQfQrLHGucx+Teggqn1IukUB?=
 =?us-ascii?Q?ZJ+Ljn4SbAXTrbQ6D71Hz0wRbUaS+MoYzOCGoDXLpHf9i2blzZTBoXD80RdG?=
 =?us-ascii?Q?uqsUX8oZMs0bxV+qfW2Mb1sQ7ZC6CQpNLhlTJ0ZdoR7s8hpxV+x+gF79KQ1e?=
 =?us-ascii?Q?dA2ajvzzAMRBepJrKs2M4yBqJFs49SWF0NALWuxFLpHIj8Us7PN8+xF5qN3C?=
 =?us-ascii?Q?ms8Q8rnZI0i4DLL53/H6wZZPVfHOuK3cMqoabFd1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dF81Q9D2p52ZCwzp9buO4HDr2i61eQD+gNxQifZi8icTyrpvkQgEQ5E/zPvu?=
 =?us-ascii?Q?km2AlnW0PZP13cUS/6vA9V0W6TlF3qengAm3tv/UsWkJNSecXoR1OFrLnJXh?=
 =?us-ascii?Q?cXQCJeYrtJ8r3t7R3Y9Q4mfUeFRjB9zEoX+TK1YtdF99wW9xMOk8h7453yE6?=
 =?us-ascii?Q?YgSnAgxpfadUeyt3Xg4/SEnrU3aQxxgGrnULxF6qNGfAO/ysobPBpS6UwiX2?=
 =?us-ascii?Q?FXmzQv6Y3zryhiQqDpu0vk0tVn2QJ6KWzqQ77eajQAsJd8RID+8jU3cv4X0I?=
 =?us-ascii?Q?B0oP1k3+M3ry1EzVRvptu5ahm5jee0twgL6B68yy7jvQSuc6yMs/ND44MLRu?=
 =?us-ascii?Q?qhc5wQ438mR5CGr+QLVxYUJK61f7TKQPnsQxuKSTTQupP2EOyVHuK3ybXfWx?=
 =?us-ascii?Q?wzF+f0zfiSh24qMSlsTaH7++9AjQOrMKqy0BxNtyUfmwK6BdpXoapDsxIDLq?=
 =?us-ascii?Q?nu4sSwj9n+d51ZYkZtlTXZsow3Mu0vff2f45Z4DdMqfHw0Cblgz1ubi2KsZ7?=
 =?us-ascii?Q?LTejFPKqJI70BL57wG6QOrYX8Nq/05nZiDRKOtHXQ1ThFrOyi9r4rdAlFEAl?=
 =?us-ascii?Q?/T5Np+7YaVrT3rrqk8qPJpsIB2cwAj/+IOuzOWXvKTEstajn6tD/CESxy21a?=
 =?us-ascii?Q?LLcnkGZmz6QnaFG1xvbHu6JC41QXIT7BrI9AFZ7YmxcFxWsuI2ePTFD0k7Bm?=
 =?us-ascii?Q?Pt44UoKomPUWiAKdqkBA6TdUgnN4ia6YvkpVzZmQXlSyrmhqIVLPL+q7QYN4?=
 =?us-ascii?Q?BF+7ybGty5PgSVRg4+YQc/IxRVS5riC+FNrrOtxDztMBpbriQB5r4VfW5XP0?=
 =?us-ascii?Q?csF28qpXxmxAe+8Yv53Mp63KfCz7j3i9oznPiT0AGZeq4ruHNx+1Qc8kK+FS?=
 =?us-ascii?Q?YmITCkRPONlJPYFvS7BnK3KshNdSx/7SCQUz6/DF5IVMtiqF69nek7UXL8sW?=
 =?us-ascii?Q?GSveTeaTSXkzI8PJJBLifUGrVJgH72s/OE8C3O/2GxfkQ/2tzI61ejLtQBc/?=
 =?us-ascii?Q?+0/J+MPldDiUmslRH8YlTC8moFqgIyTTzhqh/Ov5dQUHxsSClzpWbFtUMBT6?=
 =?us-ascii?Q?YcnFreEQ9u/nlKNpuSmM5W7pvecYv5Ci9ljbttZ/TiQidpOAWBzz7HbstLdC?=
 =?us-ascii?Q?iEe9DmW+TVE8M06Z7SkWLKmG7MspcDQ5KpcpyJvN4vCkW7ElXvXcKUHGg9e0?=
 =?us-ascii?Q?0EsCDTVtszj1QTsAne1p8UiU+UHCYqeCna5/A0XvbBRYXubyWxdURvLRxhPn?=
 =?us-ascii?Q?5u6+NGMbpfvl+b/KwH/Cr7awzO1mLx6fZExRAiENSJmm1aj3ZB5HaqkPPqtD?=
 =?us-ascii?Q?I2CSdShTyxJBUZXEXuHxXLU7hoj/ArMQ6RRFNo6vlo4GxQ=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfa0a84-357f-4219-513a-08dbefc4e85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 03:48:39.3883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVx/hff6QGpd0K4kl1qMfqdF5Vqpw8qJCvlbjL/dXmfvniQOkJosF0V/6EDS/lsorwiXwOcZtH4iFrbvJX68Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
X-Proofpoint-ORIG-GUID: poKpclch8l_SeJxG5ZUyz18hJphASsAg
X-Proofpoint-GUID: poKpclch8l_SeJxG5ZUyz18hJphASsAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 mlxscore=0 mlxlogscore=971 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280029
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
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, November 28, 2023 11:05 AM
> To: Jianheng Zhang <jianheng@synopsys.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@=
synopsys.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo A=
beni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>; Simon H=
orman
> <horms@kernel.org>; Andrew Halaney <ahalaney@redhat.com>; Bartosz Golasze=
wski
> <bartosz.golaszewski@linaro.org>; Shenwei Wang <shenwei.wang@nxp.com>; Jo=
hannes Zink
> <j.zink@pengutronix.de>; Russell King (Oracle <rmk+kernel@armlinux.org.uk=
>; Jochen Henneberg
> <jh@henneberg-systemdesign.com>; Voon Weifeng <weifeng.voon@intel.com>; M=
ohammad Athari Bin
> Ismail <mohammad.athari.ismail@intel.com>; Ong Boon Leong <boon.leong.ong=
@intel.com>; Tan Tee
> Min <tee.min.tan@intel.com>; open list:STMMAC ETHERNET DRIVER <netdev@vge=
r.kernel.org>;
> moderated list:ARM/STM32 ARCHITECTURE <linux-stm32@st-md-mailman.stormrep=
ly.com>;
> moderated list:ARM/STM32 ARCHITECTURE <linux-arm-kernel@lists.infradead.o=
rg>; open list
> <linux-kernel@vger.kernel.org>; Martin McKenny <mmckenny@synopsys.com>; J=
ames Li
> <lijames@synopsys.com>
> Subject: Re: [PATCH v2] net: stmmac: fix FPE events losing
>=20
> On Mon, 27 Nov 2023 07:08:17 +0000 Jianheng Zhang wrote:
> > Signed-off-by: jianheng <jianheng@synopsys.com>
>=20
> Your name and email addr in From are both different than the form used
> in the Signed-off-by tag. Please fix that and repost (keep Serge's
> review tag).

Sorry, I will correct it and resend the patch.

Best Regards,
Jianheng
> --
> pw-bot: cr
