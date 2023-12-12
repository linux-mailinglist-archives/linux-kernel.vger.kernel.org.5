Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEE380E97A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjLLKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:51:47 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F7EA0;
        Tue, 12 Dec 2023 02:51:53 -0800 (PST)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCAKYjj027719;
        Tue, 12 Dec 2023 02:51:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        pfptdkimsnps; bh=wMmWxkAoC2SDhXlT0wocv4z8LBgZHz2J0IEepSHevCA=; b=
        Xu7A6uuKlR+c2xAp4s+XV7SWk6c5VQnSwuCEkB1RImmvmqX3/8q7LrneIUeLx0yN
        cyHpbRRkHmWd8Jieknd3/K84X13p5TZJJYb6Hwyy50z8JqLmAm1iaAHp+tYJn8uY
        rmYaKWtFqD08vbmdQPQwt6TO3MPM6wAghObzW2KRvqwXf74qUrav31MawYiHdzkK
        vlIbGGsQGrf0/GrfwEIRuwdi8h93HbGkgVVGtNaojMKbmi9/nB8neBmosZMY/O8H
        KLI+rldHB+cGqOvJrsV3JPJD7cCQGJkQc1zp0AMo+TNuwVHYDFkzr68ie7OEkca+
        a16BFBgFUrquLlr9fGDtrQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3uxcr3tkpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 02:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1702378268; bh=wMmWxkAoC2SDhXlT0wocv4z8LBgZHz2J0IEepSHevCA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Z5yqDMU2KgnSwD8yXGINnxjzNzM4bhSiQvOi4zFcZ4eYJDMBeX5a3guuGgAp9QZF4
         nD5VVg9s+yV/Hlich84k/4ek7D76GtY5fY4NIinnd2Fpp8/rhWZClcI/9DDI/xWWix
         JVhj9y7sWzs4zVq5GoNzJa36NVKbNnSyeXV8jtXe5H355R+AtW1NigyUWU0PBY6bRX
         nKBUKZjhbiGMvWki2KqgIUKf1wrcgMqCHqdPgeVhkXXdMxoSR1VMbs/i50Me2QMtIN
         OCK0IDuryCtp10IdesxcSOaaxUDcrHv6p+8aIUYvcTnzCU2Q8J1GK0PhJXEUW2Ca1r
         x+fWjmAxwvO7g==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1698740362;
        Tue, 12 Dec 2023 10:51:04 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 80787A0073;
        Tue, 12 Dec 2023 10:51:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=szlUAxLy;
        dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 94404401C4;
        Tue, 12 Dec 2023 10:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXg6BTsrPQ4M+PZNSll1biMVnnX9SZ4cY0kg+Dy+/V47D3X8pKS70x3SFx1jXBVFlYNZzaRIYjWRADAFVbjZQFZIcIfq+IPzFJPjwxL1QLEDoUE8p1QCBwE+7LsK3BwbNhLTjDvIAi0h6s+88TvDsxd3F1u9M+RwxxSUXYMM248SKw3c5ni/IjgfC+Ekj//yvazGL2NL6fSw9y+x61MbMalQIXsivnArbX+tJF0ok270RhmQb6M/8o5yWyrEO12cM2UPMmf98HwArBnDONwSYm3Txaf5xJ+Fua+BFpwztI940cQKYyOdKr6JxItoV/z/IrFVf88C/pjiTyxUJQ066g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMmWxkAoC2SDhXlT0wocv4z8LBgZHz2J0IEepSHevCA=;
 b=f29sDch67uieWCVKxKpG/HkTYHEyd50i/EefHW7Wp/X17erqooAckNECg287KIFh5oAr3c24AW2hxXscxleOjqiGmheeU4x3PJxG828gzpn6MenAQ5t4j7xrZokaJCXu+mCkRWHLq4kj5BDc4zmXhdHES7ooh5C0CXr9toNhoo7wejcX7Y5HFsxx6o4EMbe8/RFNBJw0qPwMEKL1QSCl8fs+roqOSksB/Ymb7OVFz9dr92Tv8nKacPNcEwibNFt6j/uYhVSBO8h8Q6uEvYHZ2eBBQU5cixHZkzfWLJlGxKUsKBoIZ3YtuX0VBoQYsb7MGc8LsYP9ccnNI+R9Jof6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMmWxkAoC2SDhXlT0wocv4z8LBgZHz2J0IEepSHevCA=;
 b=szlUAxLyKRtvq1GzA0t646yOOZOlcNS8+jMHsClMmhTfWunbOtCYFJG70IJ8gYM9NrKGyaJmQN3dpKg9rQL5HGja8EHLzSb0J0wYSudaW2i4wysBMjIfVuhKwUFEVa/BiLdPW12O/da86oGHfLvjvH4PBaSxinNUPkydQPXjTuY=
Received: from SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 10:50:55 +0000
Received: from SA0PR12MB4413.namprd12.prod.outlook.com
 ([fe80::12ba:707d:284:a4de]) by SA0PR12MB4413.namprd12.prod.outlook.com
 ([fe80::12ba:707d:284:a4de%7]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 10:50:54 +0000
X-SNPS-Relay: synopsys.com
From:   Jiangfeng Ma <Jiangfeng.Ma@synopsys.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG5ldDpzdG1tYWM6c3RtbWFjX3BsYXRmb3JtOkFk?=
 =?utf-8?Q?d_snps,xpcs_devicetree_parsing?=
Thread-Topic: [PATCH] net:stmmac:stmmac_platform:Add snps,xpcs devicetree
 parsing
Thread-Index: AdopoV2G4U4p6KhERnimGhWz15HefgADSasAAA0RnAAAt6TJAA==
Date:   Tue, 12 Dec 2023 10:50:53 +0000
Message-ID: <SA0PR12MB4413305305D47CAAAFEAD528D98EA@SA0PR12MB4413.namprd12.prod.outlook.com>
References: <SA0PR12MB44138E48A245378CF54D2F9ED98AA@SA0PR12MB4413.namprd12.prod.outlook.com>
 <20231208091408.071680db@device.home>
 <uzss3af2cklc5bx5apszoegafeaaiv7o7iwgrgrml4grkyev6p@6tme4hdb4mkn>
In-Reply-To: <uzss3af2cklc5bx5apszoegafeaaiv7o7iwgrgrml4grkyev6p@6tme4hdb4mkn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcamlhbWFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00Zjc4M2Y4Mi05OGRjLTExZWUtYmFhMy1jYzk2ZTU2NGY4OGJcYW1lLXRlc3RcNGY3ODNmODQtOThkYy0xMWVlLWJhYTMtY2M5NmU1NjRmODhiYm9keS50eHQiIHN6PSI5Njg2IiB0PSIxMzM0Njg1MTg0OTg4NzEzODgiIGg9InJwTnN6OG5wWWFrdS9aOEY0QUZ1WE5uelUvWT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4413:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: ecc451f9-039b-4333-216c-08dbfb0036b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20pvaX8Uknqx/NhU1PxA8hgPh7eDoQWiF+BaG/5/Ax7ZLWx422Fz2oc7fDMzLXF6g1A8oynMfshe7988d/iR+AvLmPdMsEv4hdpy1hccGEqNetYz/636+Wax6BcHFx+Pf/LRXN5GlIaWJ5BIZGokWYjw1Rxsq9x2JYdjfFMvp+CdJoBj6DrXGJhvjfMSpvyTvaRJ79Id5sm1YOx0j3AHDcg4g8rfm9O46KPFoMz6YqasWhnS4m2Naz9qYkeiASZ62R+qWZhzU2FqxmSrtXrwAwP2IK2r6tC8/Uh7v77BtljCUh/3ad/aoYa+R1LFdNkMQwamvw7Ho2A33x15oNkKhLtCsk4AgdcvHnHiQjkMk38hFxsEacnjJdVJpSY4CCVzXHNqBNc3+LhF3mTXoICT8/2g7mWd1F8z5b33B4zEDx0qBuTaYofecQKhKqY/3Et278KO0kPGJEtuIX+FDJ812Irov09yj6chJRrbC3VlsgYmtqFqeXKE4lIXK0iLMF94l+5642iX/kBzcB5jEQwalN2jsytWKde4H08WQrXpuZ2uj5xXqPObCir74zLHnb2XtMMhTz3M+NcEmOsb08Wvl7dinG2DIzLTqm9mcKdcMaM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4413.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(86362001)(7696005)(6506007)(2906002)(7416002)(66556008)(110136005)(66446008)(66946007)(66476007)(64756008)(54906003)(52536014)(9686003)(71200400001)(122000001)(33656002)(38100700002)(4326008)(8936002)(5660300002)(224303003)(316002)(55016003)(76116006)(478600001)(966005)(41300700001)(107886003)(38070700009)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWxJQTFBVDlSRlEzcjFDY0VNUWtPRGIrYjJzZlA5NzcxTXNZenkyekE4Zi90?=
 =?utf-8?B?V081OFhYVlJ6Q0JiQW5paUY3MHh6R1JvaDhWT0RVdlVDS3lIVndyVmdNUSs1?=
 =?utf-8?B?aWVnYlBBRkVRK1pIZzZmengvWUNrM0xPbG1CS29LQ0JoZnE0Z3dqMFg4bVZN?=
 =?utf-8?B?SVVzanI4VDdyMitJT0lTc3pkRThGY0NHSVEySkRoSlFmOXQvaWZOOXkvbzc0?=
 =?utf-8?B?Vk9TZ2FuSEdjTnpoeXdYWXlLMStFbmRFRTNaQWdnOWc3UG45OWxTVWZQdkJs?=
 =?utf-8?B?Tjl4ZjR5Y2NpNEFmbW96YzlxQVh6ejNsMmgrKyt3bFQ1eFJGN2IzZGpXdlFV?=
 =?utf-8?B?TWl1S0NpZzVPZkMwNENMQWRpVGo5eXVxOTVSMmNJUFNiS2dOK2c2c2tmT1c2?=
 =?utf-8?B?czNCOWJtYzMxdmhsZG5xbFQ5MjlrUGZhakZUYU1JMENhd1AvSEZmK3JxQ0pC?=
 =?utf-8?B?UFJPa09XbmcxZm55eTM0SXFBQmtoWUUxeEZmTWphSFJKM0FzYXJpdWJ0NUFm?=
 =?utf-8?B?T0JyVzQ4Y29TalE0cmR5cjIxbWpjazM3UUpjM1gzbHNqOHBoYzBGRzcwaFJr?=
 =?utf-8?B?MmFCRjBRWk11ZGhnL2dESHVaNEtaYnZpM1YyT3FCT1hUdWdxUFM4TjIxV3hr?=
 =?utf-8?B?enFlUEF1UnZwTHJWUGYyY1ZoWnhCNjZnZEZwZm4wa3J5T0N3cWVUNUltSUVm?=
 =?utf-8?B?WnlBTXY4dlpxWjE2RWZKNXVqdktLS2NwWXZvQ3gzVzEzZC9INytuWWtuTTgx?=
 =?utf-8?B?ajRkRDF2K3Fmb0hFTk9XUklNSjc2SExUVEhkY2FYZjNsRnpHejdiK1l6ekc1?=
 =?utf-8?B?QWNGVzd2WkoyNElVR0k4eEVocGdSazVBQ0phSXI4NXNieUpuMVBUeVZKcStV?=
 =?utf-8?B?eDhLMmZ6UTlPSTlKWTBDaml1TGpPOGJRaHFFTzhLZjJyTnF2RXZ0b1RjNW5G?=
 =?utf-8?B?QkcrT3pmeXVibTJmcG15emUvYis2LzdqRzJsVUJscVZ5VlhoSnJoSzNQODdo?=
 =?utf-8?B?dm4zYW9lQkNPcmc1eFI0K0VpR21VSklNNFIwWkE2bE9DNHFObGUvV1BVckoy?=
 =?utf-8?B?Nmtrb2MxeHNndFFKTWVwY1V1VlpXN01JbkdKWnViMjg2b2JpdGZkNWpTVTBH?=
 =?utf-8?B?cThRd1FUeXc3aklZUGErWTdHY203elg5ZkoxZlBNS2FLcGI5ZnN2bi82Rlhv?=
 =?utf-8?B?cmEwU3dtQWwvcThhSVB4ZWJib1dXWDdBcDdFazhCa2o3MHQyS2FVZlBkeW9l?=
 =?utf-8?B?SWxsTmkrdHVkV1o3U1RWVzVLUTYwVmNEdG5pUFkybTZlaUpqN3pMQXVEUjJq?=
 =?utf-8?B?QjlET3c2c2hlQVcvUi8ySXoySm9NeEtVcEhCOFdOdDk0Yy84V0xNRElVei82?=
 =?utf-8?B?cVVRYTNKOXZ4S0grWStxenQ3eDVCTmg3VVJGdE8zMVpuc0lZM1VyUmlJYUJT?=
 =?utf-8?B?c2xJU1czSjR2NW15QUVJRjNKSzNPN2lUWnNQVkQ4dVdnRmpPdFhkbzJaU3FN?=
 =?utf-8?B?b0Q1Yk9qZ3hETU1EbFpxMkowT2VxZzArVVNyRnZDRWpSNGxXaHF6NXB6V2pp?=
 =?utf-8?B?c1FHQVhwM0h6TmdUK0lGT0VFU3MzRDMvdndTMHV4QXRQUmhNbnhHOXVkUE45?=
 =?utf-8?B?MjlObFdCU1JGZGZGQUVOUExXYm12dUhIcUVUQTFiNWZuK1B6VnJkZ1diNTF0?=
 =?utf-8?B?UVhBOGd3UllBSnlNUDNLV1psTmVGdGowTkVRQVdHQ3pCN2V6bEpOUytoZ3pw?=
 =?utf-8?B?MzdvMUgxM0xESXUyUDNNTmI3bENsQkk3MTBvcEs3cjIzOVVoNU1aZzNOWlVp?=
 =?utf-8?B?VWc5Tlg4aFNmM0JqbkZhaWwvZ1VSc3VYRXlhbi96Q3FqUlhQTlZKaUlKWWtH?=
 =?utf-8?B?M0ZnYU8zUkV5K1hyWVZxbmRIQW1oNzkzT2NvWTFlcmtSSWhobmcvK1FPMW8z?=
 =?utf-8?B?VnU5M1dtK0dYZFFxUTJjRUFDb3V5dTA5ODgvR2pJZ0VkM0F3bTd1RkVyd28x?=
 =?utf-8?B?K1ExbVRXZ2ZkWXFLRXNiWGRxRldHR3NJbTBWNU1LQ216bmpQU1p4eVBwb214?=
 =?utf-8?B?VFFPVzB3ZGFOcVRRL0FsRkJOQ1F1SUp6dDNxUVZzUGZsVXR2YndzaUdJaWJL?=
 =?utf-8?Q?6sus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SjU3bk12QmYzQzI1VGtoallxT3FRNHRob09PYThZaFdGcTcrd0pzUHYxN2Q3?=
 =?utf-8?B?RS9DQVUwZ2RuVEpSdkJ4eStOaWlLZlQ0U3JXKzZ1ZEg5aWxoMUVDV2ZsWExV?=
 =?utf-8?B?eENJWCtHMXdKbmRGRGdFcG5uT3R4eEJjWSt6Q1lWTHZ0YWNPek1qUzRGNEpk?=
 =?utf-8?B?bzZZYVJFSnVPQmxYNWQwMXlzd1JpMm9hb0lDOGRRY2xPbmQ5UTBvelEvODBS?=
 =?utf-8?B?NjQ0eEhPeTFUbXI2d3N1SysvSU5OMmxHZVJ0eGkrbHRtNFA3alRnNmRWZVYx?=
 =?utf-8?B?Z2JpdDdmYUQ5Uk5mVUZhd0E1Y3lzNmtSYktEOElQRHRLejVBM1BJMmwzUkxm?=
 =?utf-8?B?MjVXRUNOSFI4dlNLWXNQZkMxbGNJbWNGd2lJNnZVNFVmajIzQWZFaGFVQzRD?=
 =?utf-8?B?aVllRzByc1VPbEJZVFEvRUhNS1Y3cmU4UWJMT3RFM1JmUzMybmNXSmNjSWVX?=
 =?utf-8?B?VDBUS2JIQ0FaVmFEMkloczdMcDVMdlJZU2VFcXJ1WGxhK2RZTWI4N1Fpa1Rm?=
 =?utf-8?B?Z0w4T01Sa3IwN2FSSVNkYWs4NWNkTDhGaWJLZlM2WW1UQ3JQU2VVOXc5Zkdq?=
 =?utf-8?B?QVE2Skdnc0RiUzJkdnhxelZ4eXRENjA0bklnL2t3c21COUlFaFZnd25FK1ZR?=
 =?utf-8?B?emxDQnBreDZzTUwzZ0tpTWxuVTNJRkU2NlNRUUdZdTkwY21Ca2tFS0xrZklh?=
 =?utf-8?B?TFFvUkhRSFc2RlR6RUJuZGUzaHFZS01NdTZxb2plUTg1NlAwTWRWby9tOU0r?=
 =?utf-8?B?S3lmMVBIRlNqNFgvTFgxdFFpV3hYRzBiZHFURVhxcHpvaFRaRm5pcmVVM2hD?=
 =?utf-8?B?T0c4VElINk1OUWE2TS9vMG9GQmRtRmVBR1JsOXBwTDY1cjd6MVR3ZjE5d2RH?=
 =?utf-8?B?NGI0YUpxNjNDKzdlcmxWRVdmcFh4MUl0NXhsZ09oUE1YU0VHS21RR0d3cTVu?=
 =?utf-8?B?NUI5NTVzMWh1aW1udUdkeFFrRmF4RnRyVU40clhXQ0FTQUwwRXdIRm0vMjNI?=
 =?utf-8?B?SEtZdnBFb2FqbGtkcHhLZGlQWEFFR0FKR1hEeHhsUVNvNElDUSsvRTBjS3JW?=
 =?utf-8?B?MEhLZThyZHJKVEVMMUJyZ0pDeVJUTWdLQnNCVmJ0Z2N0dFRnVSszUTZPQzFx?=
 =?utf-8?B?NUU3eCtJY3luSDAvMmhmcldGRWtoT0VLSGJYTHRGRnpvSFhhUVJ2eXA2S21L?=
 =?utf-8?B?YmlhRVVaNno5amZqUHdFZzREZVI2R0RoNWpld1Y3UUp4dm9GdDdwUTlaNkhy?=
 =?utf-8?B?RjdNZWdOZVEvalVBd05xNjJQV0ljYnRtQmY2aWl0NGpjaVc4Y0xZNklFeDY4?=
 =?utf-8?B?R3YvSzFMQWV2bE01T0NsaWN0b3BVMjU5OWwvTmFBem5saGI3TEw4eEdxb3Va?=
 =?utf-8?B?blU2MTZPY3YzeVl2RS90amRneWpwdU1pd2NZWFhjQ2Q2ZkNsdUpyZHRxRTB6?=
 =?utf-8?B?d0RwS1BRZnN3WXB3OWkvdzJKNzZ6RUpRT2JHbzE4S0pYbHdRK1RRaDRjMUp6?=
 =?utf-8?B?anlmMEthcjJmOVJJenkzNE54alYvTmh3NytrU1lLOVJ4bHpRWHhpZG9oWXFY?=
 =?utf-8?B?K0ZlZVdjRngxMldUbk1rbWVPYW1oN08wdGZ5MlNjQldsWEgxR0h5NkZ5MEhJ?=
 =?utf-8?B?RVBxQ3BVT21ML3g4cmwxT3U3UldJdWRYOWQ0UDluTTArdzllbmJua0FRTFBk?=
 =?utf-8?B?L2dtdzM5S3dSdmo1QmUzc2pYUTJJM01PKzZNNWltWnpPUjB2R2txa3cya0NR?=
 =?utf-8?B?WWE5dU9vM3daNGh3Q3V3QlRKcElkMkhtNEhvbGNXYmdBZk1mUGcwQXVydTI0?=
 =?utf-8?Q?ILnOWK3vOEIMTqiB/Dxi2kdR4orff6lMAfo90=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc451f9-039b-4333-216c-08dbfb0036b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 10:50:53.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+XBMT8Oio4t6oqKDMzIv4c5V5xT2AGFxDAXRKCUY9znYv3CrRa8yPk7YLUKbxLOf6ncYmo6hWUzYc9fFtKlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-Proofpoint-ORIG-GUID: YMRiRQVBERzf_K6FMyttcifBnrvmOMou
X-Proofpoint-GUID: YMRiRQVBERzf_K6FMyttcifBnrvmOMou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312120087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFNlcmdlIFNlbWluIDxm
YW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiBGcmlkYXksIERlY2VtYmVy
IDgsIDIwMjMgMTA6MjggUE0NCj4g5pS25Lu25Lq6OiBNYXhpbWUgQ2hldmFsbGllciA8bWF4aW1l
LmNoZXZhbGxpZXJAYm9vdGxpbi5jb20+OyBKaWFuZ2ZlbmcgTWEgPGppYW1hQHN5bm9wc3lzLmNv
bT4NCj4g5oqE6YCBOiBKaWFuZ2ZlbmcgTWEgPGppYW1hQHN5bm9wc3lzLmNvbT47IEFsZXhhbmRy
ZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb20+OyBKb3NlDQo+IEFicmV1IDxq
b2FicmV1QHN5bm9wc3lzLmNvbT47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tp
IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+Ow0KPiBN
YXhpbWUgQ29xdWVsaW4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+OyBTaW1vbiBIb3JtYW4g
PGhvcm1zQGtlcm5lbC5vcmc+OyBBbmRyZXcNCj4gSGFsYW5leSA8YWhhbGFuZXlAcmVkaGF0LmNv
bT47IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz47
IFNoZW53ZWkNCj4gV2FuZyA8c2hlbndlaS53YW5nQG54cC5jb20+OyBKb2hhbm5lcyBaaW5rIDxq
LnppbmtAcGVuZ3V0cm9uaXguZGU+OyBSdXNzZWxsIEtpbmcgKE9yYWNsZQ0KPiA8cm1rK2tlcm5l
bEBhcm1saW51eC5vcmcudWs+OyBKb2NoZW4gSGVubmViZXJnIDxqaEBoZW5uZWJlcmctc3lzdGVt
ZGVzaWduLmNvbT47IG9wZW4NCj4gbGlzdDpTVE1NQUMgRVRIRVJORVQgRFJJVkVSIDxuZXRkZXZA
dmdlci5rZXJuZWwub3JnPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL1NUTTMyDQo+IEFSQ0hJVEVDVFVS
RSA8bGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbT47IG1vZGVyYXRlZCBs
aXN0OkFSTS9TVE0zMg0KPiBBUkNISVRFQ1RVUkUgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZz47IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEph
bWVzDQo+IExpIDxsaWphbWVzQHN5bm9wc3lzLmNvbT47IE1hcnRpbiBNY0tlbm55IDxtbWNrZW5u
eUBzeW5vcHN5cy5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSF0gbmV0OnN0bW1hYzpzdG1tYWNf
cGxhdGZvcm06QWRkIHNucHMseHBjcyBkZXZpY2V0cmVlIHBhcnNpbmcNCj4gDQpIaSBNYXhpbWUs
IFNlcmdlDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IEhpIE1heGltZSwgSmlhbmdmZW5n
DQo+IA0KPiBPbiBGcmksIERlYyAwOCwgMjAyMyBhdCAwOToxNDowOEFNICswMTAwLCBNYXhpbWUg
Q2hldmFsbGllciB3cm90ZToNCj4gPiBIZWxsbywNCj4gPg0KPiA+IE9uIEZyaSwgOCBEZWMgMjAy
MyAwNzowMjoxOSArMDAwMA0KPiA+IEppYW5nZmVuZyBNYSA8SmlhbmdmZW5nLk1hQHN5bm9wc3lz
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEluIG9yZGVyIHRvIHNldHVwIHhwY3MsIGhhc194cGNz
IG11c3QgYmUgc2V0IHRvIGEgbm9uLXplcm8gdmFsdWUuDQo+ID4gPiBBZGQgbmV3IG9wdGlvbmFs
IGRldmljZXRyZWUgcHJvcGVydGllcyByZXByZXNlbnRpbmcgdGhpcy4NCj4gPiA+DQo+ID4gPiBJ
ZiBoYXNfeHBjcyBpcyBzZXQgdG8gdHJ1ZSwgdGhlbiB4cGNzX2FuX2luYmFuZCBzaG91bGQgcHJl
ZmVyYWJseSBiZQ0KPiA+ID4gY29uc2lzdGVudCB3aXRoIGl0LCBPdGhlcndpc2UsIHNvbWUgZXJy
b3JzIG1heSBvY2N1ciB3aGVuIHN0YXJ0aW5nDQo+ID4gPiB0aGUgbmV0d29yaywgRm9yIGV4YW1w
bGUsIHRoZSBwaHkgaW50ZXJmYWNlIHRoYXQgeHBjcyBhbHJlYWR5IHN1cHBvcnRzLA0KPiA+ID4g
YnV0IGxpbmsgdXAgZmFpbHMuDQo+ID4NCj4gPiBDYW4geW91IGVsYWJvcmF0ZSBvbiB3aHkgeW91
IG5lZWQgdGhpcywgYW5kIG9uIHdoaWNoIHBsYXRmb3JtDQo+ID4gZXNwZWNpYWxseSA/IFVzdWFs
bHkgZHJpdmVycyBmb3IgdGhlIHZhcmlvdXMgc3RtbWFjIHZhcmlhbnRzIGtub3cgaWYNCj4gPiB0
aGV5IGhhdmUgWFBDUyBvciBub3QsIG9yIGNhbiBndWVzcyBpdCBiYXNlZCBvbiBzb21lIGluZm8g
c3VjaCBhcyB0aGUNCj4gPiBjb25maWd1cmVkIFBIWSBtb2RlIChkd21hYy1pbnRlbCkuDQoNClRo
ZXJlIGlzIG5vIHNwZWNpZmljIHBsYXRmb3JtIGhlcmUuIEkgdXRpbGl6ZSB0aGUgZHdtY2FjLWdl
bmVyaWMgcGxhdGZvcm0sDQphbmQgeHBjcyBpcyB1dGlsaXplZCBhcyB0aGUgTURJTyBkZXZpY2Ug
b3IgaXQgY2FuIGJlIHNlZW4gYXMgYSBDNDUgUEhZLg0KV2hpbGUgaXQncyBzb21ldGltZXMgcG9z
c2libGUgdG8gZGVkdWNlIHRoZSBwcmVzZW5jZSBvZiB4cGNzIGJhc2VkIG9uIGluZm9ybWF0aW9u
DQpzdWNoIGFzIHRoZSBwaHkgbW9kZSAoZHdtYWMtaW50ZWwpLCB0aGlzIGlzIG5vdCBhbHdheXMg
YSBkZWZpbml0aXZlIGluZGljYXRvci4NCkZvciBpbnN0YW5jZSwgdGhlIHN1cHBvcnQgb2YgU0dN
SUkgYnkgWFBDUyBkb2Vzbid0IGltcGx5DQp0aGF0IGFsbCBTR01JSS1zdXBwb3J0aW5nIFBIWXMg
aW5jbHVkZSBYUENTLiBCdXQgYXMgU2VyZ2UgbWVudGlvbmVkLCB1c2luZyBwY3MtaGFuZGxlLA0K
b3IgcGNzLWhhbmRsZS1uYW1lIG1pZ2h0IGJlIGEgbW9yZSBlZmZlY3RpdmUgYXBwcm9hY2guDQo+
ID4NCj4gPiBCZXNpZGVzIHRoYXQsIHRoZXJlIGFyZSBhIGZldyBpc3N1ZXMgd2l0aCB5b3VyIHN1
Ym1pc3Npb24uIElmIERUIGlzIHRoZQ0KPiA+IHdheSB0byBnbyAoYW5kIEkgZG9uJ3Qgc2F5IGl0
IGlzKSwgeW91IHdvdWxkIGFsc28gbmVlZCB0byB1cGRhdGUgdGhlDQo+ID4gYmluZGluZ3MgdG8g
ZG9jdW1lbnQgdGhhdCBwcm9wZXJ0eS4NCj4gPg0KPiA+ID4gVGhlIHR5cGVzIG9mIGhhc194cGNz
IGFuZCB4cGNzX2FuX2luYmFuZCBhcmUgdW5zaWduZWQgaW50LA0KPiA+ID4gYW5kIGdlbmVyYWxs
eSB1c2VkIGFzIGZsYWdzLiBTbyBpdCBtYXkgYmUgbW9yZSByZWFzb25hYmxlIHRvIHNldCB0aGVt
IHRvDQo+ID4gPiBib29sIHR5cGUuIFRoaXMgY2FuIGFsc28gYmUgY29uZmlybWVkIGZyb20gdGhl
IHR5cGUgb2YgQG92cl9hbl9pbmJhbmQuDQo+ID4NCj4gPiBBbmQgdGhpcyBwYXJ0IHdvdWxkIGdv
IGludG8gYSBzZXBhcmF0ZSBwYXRjaC4NClNvcnJ5IGZvciB0aGlzIGlzc3VlLCBJIHdpbGwgY3Jl
YXRlIHRoZSBwYXRjaCBzZXBhcmF0ZWx5IGxhdGVyLg0KPiANCj4gSW4gYWRkaXRpb24gdG8gd2hh
dCBNYXhpbWUgYWxyZWFkeSBzYWlkIGhhdmluZyBEVC1iaW5kaW5ncyBhZGp1c3RlZCB0bw0KPiBm
aXQgdG8gdGhlIHBhdHRlcm4gaW1wbGVtZW50ZWQgaW4gdGhlIHNvZnR3YXJlIHBhcnQgaXMgYSB3
cm9uZyB3YXkgdG8NCj4gZ28uIFRoZSBiZXN0IGNob2ljZSBpbiB0aGlzIGNhc2UgaXMgdG8gYWRk
IHRoZSBEVyBYUENTIERULW5vZGUgdG8gdGhlDQo+IERXIE1BQyBNRElPL01JIGJ1cyBhbmQgdGhl
biB1c2UgdGhlICJwY3MtaGFuZGxlIiB0byBpbmZvcm0gdGhlIE1BQw0KPiAobWFpbmx5IGl0J3Mg
ZHJpdmVyKSBvZiB3aGF0IFBDUy1kZXZpY2UgaXMgYWN0dWFsbHkgYXR0YWNoZWQgdG8gaXQuDQo+
IFRoZSBzZXJpZXMgSSBzdWJtaXR0ZWQgb24gdGhpcyB3ZWVrIGlzIGV4YWN0bHkgYWJvdXQgdGhh
dDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L25ldGRldi8yMDIzMTIwNTEwMzU1OS45NjA1LTEtZmFuY2VyLmxhbmNlckBnDQo+IG1haWwuY29t
L19fOyEhQTRGMlI5R19wZyFZNlIzV1pXSGVCZHJrWmtsYnFyQVFBUmJIblEtZ19UYmI2cjVJcWNz
U0hNUV9sNHJPekxMZ1p2TFBsNllQDQo+IEJZZmVyYmpyYmpaQTZfWHZTU1N2a1YzNWVvMmpXUHok
DQo+IEkgZ3Vlc3MgSSdsbCBuZWVkIGFib3V0IGEgbW9udGggb3Igc28gdG8gc2V0dGxlIGFsbCB0
aGUgY29tbWVudHMsIGJ1dA0KPiB0aGUgc29sdXRpb24gaW1wbGVtZW50ZWQgdGhlcmUgd2lsbCBi
ZSBiZXR0ZXIgdGhhbiB0aGlzIG9uZSByZWFsbHkuDQo+DQpZZXMsIEkgYWdyZWUgdGhhdCBiaW5k
aW5nIHRoZSB4cGNzIHZpYSB0aGUgInBjcy1oYW5kbGUiIERUIGZpcm13YXJlIG5vZGUgDQppcyBh
IGJldHRlciB3YXkuIGJ1dCB0aGUgY3VycmVudCBtZXRob2Qgb2YgYmluZGluZyB4cGNzIHRocm91
Z2ggc2Nhbm5pbmcgDQphZGRyZXNzZXMgc3RpbGwgcmVsaWVzIG9uIG1kaW9fYnVzX2RhdGEtPmhh
c194cGNzLiANClRoZSAxNnRoIHBhdGNoIGluIHlvdXIgcGF0Y2hzZXQgYWxzbyBtZW50aW9ucyB0
aGUgZGlmZmljdWx0eSBvZiANCm9idGFpbmluZyBoYXNfeHBjcy4gVGhlcmVmb3JlLCBjYW4gd2Ug
YWRkIHBhcnNpbmcgb2YgcGNzLWhhbmRsZS1uYW1lcyANCmluIHRoZSBwbGF0Zm9ybSB0byBkZXRl
cm1pbmUgaWYgdGhlIHhwY3MgZXhpc3RzLCBsaWtlIHRoaXM6DQoNCmlmIChwbGF0LT5tZGlvX2J1
c19kYXRhKSB7DQoJcmMgPSBvZl9wcm9wZXJ0eV9tYXRjaF9zdHJpbmcobnAsICJwY3MtaGFuZGxl
LW5hbWVzIiwgImR3LXhwY3MiKTsNCglpZiAocmMgPj0gMCkgew0KCQlwbGF0LT5tZGlvX2J1c19k
YXRhLT5oYXNfeHBjcyA9IHRydWU7DQoJCXBsYXQtPm1kaW9fYnVzX2RhdGEtPnhwY3NfYW5faW5i
YW5kID0gdHJ1ZTsNCgl9DQp9DQoNClRoYW5rcywNCkppYW5nZmVuZw0KDQo+IC1TZXJnZSh5KQ0K
PiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IE1heGltZQ0KPiA+DQo=
