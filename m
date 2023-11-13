Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918187E9FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjKMPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:21:12 -0500
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB14D67;
        Mon, 13 Nov 2023 07:21:08 -0800 (PST)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ACLoGF3024955;
        Mon, 13 Nov 2023 07:20:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=proofpoint20171006; bh=JKJ1zJeogEHIcVOjkMkFryVKa+k18TTERjrVX+
        DrcgA=; b=v1qEpWh+DqBDuMItO4HgJSuBR+MwXo+9mLYX6hN7+eYulXEUZeFICg
        OT17QN+U2gXVy79kx29sGpPyPtdX14NhJOJ+YoUXJL+KS/7zVwYt/Pt07jmVNiJR
        cUbX6RLtxfqWrnbuxNwgUwwlzXMP4qT7nZfv2ETV62jzIqPZ7wpBNIB/WnqENMfj
        rnD3UnXqQNpKm3XJd0DVCV/7Dmwjgv3jKcfchciJNvlYZcSAA8Ds6DbJlIpdPOLm
        5tt1njJCrGkRGD3/5idjx/mvJC8c22UrMAuJie0oimf8HEQwNL7M4ECOsEvJ9l9r
        qPwfHXZYaf9h1K2YWCkCVqJEiwU7AadQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ua8kkb50q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 07:20:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCadAH7tvSXxlddvA/O28NOjLnM81pWANWhFJ760vtAoVKWg3q9k0Ztxhn3Mbcvpw3AXZbwE6wix1TEfMyHYslxbSZL7LsGUChPZBiv72IndP6g9SUWhxRSWB5L5HnhAyynWPD/n+hsDauBtED9jhyopkKJT7BsK3meoVPDloQDVaXbQ+IPiSrcaL81KODa5FtO6K+3d2ymD/VA49I/kF8K2QKP1g9LDxp15ecZVnq8k2b7Of2FfsCmhrNmnZsTPlAoqIzOimbeWMrqMTJIU1+3p2bzVvQsrTsAQiEHXTW83vEPB91h30pwOc4bYBlzDS2qZXNPxf/Aba01h62dZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKJ1zJeogEHIcVOjkMkFryVKa+k18TTERjrVX+DrcgA=;
 b=KsVb1hoYcO1bAUIhNvYHkPSpihQpwAAk6XCUeGnSrUtqqqUlGKwSp5Y4pqVJ92ZtEb87PDDU7MPM7D+oEXuk/LI0M/Ewa7nJU3X3Atmjr08oG9ydtKBjzBoe4afLaO6wo8s/cllI3/qTzucPxoKSyKfM7F5SVoJeBnxjs1gllxSm/SYh9YaxF6A1bXx1WpI1xhvtyIrwdrb1aV0fiHI5Z/eBoeVhvQNdPBc5jfNsA35JAHFwEdovPZ6NPiMHmr8NbtrWCwWyThy/vGo07jSwIU7n8qeyiCOmv/VWhAUiJOxGutuPMpctrsqls/74VAbSG1PXhiUMOHw8aKQJaXHHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKJ1zJeogEHIcVOjkMkFryVKa+k18TTERjrVX+DrcgA=;
 b=AlyNCmzfgzPsbL0W5RJSlqlW/Jxnl7JwixPDhrH/A5mpPwjf0Vh4XO7L/SHSx4pH2bgrHkW7+oR8DTuqffm43jQMvEhgV4lD/f+PIcgPFOT0wOEXwl8hLtpB7gUU59AFaPOYcdxlimAcOpodAXQTtuNQk6iDM8NK51jjHpo6jjNrrrE4Rtr6zOYU3rmwjqXFEhWfmZUSDPfT0HNNMiUOd3Jomdy8+VOUnI4IlzAjT15M1wlGqh8Pl8ycvW/8Z1WO7wpEh99u67rkOCR9YXAMqPc8kRBUmIDBQHwlW23TMJQRAko9A5LJvObnlpTnpJlyaDg9nSMfGBoaN0iOzT05lQ==
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by SJ2PR02MB9390.namprd02.prod.outlook.com (2603:10b6:a03:4c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 15:20:50 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::4881:9c9a:42b2:78d6]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::4881:9c9a:42b2:78d6%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 15:20:49 +0000
From:   Jon Kohler <jon@nutanix.com>
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and C1E
Thread-Topic: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and
 C1E
Thread-Index: AQHYjLmyfZe8FiABAE6d6qT19cbe9a1pg+iAgAAKQYCDDXl9AIACnD4AgAHMkgA=
Date:   Mon, 13 Nov 2023 15:20:49 +0000
Message-ID: <4B2A75D1-84BB-4BA6-B72E-386ED7E483E0@nutanix.com>
References: <20220630194309.40465-1-jon@nutanix.com>
 <b35cf10b03b441a95704648e816ff1acc150f38b.camel@linux.intel.com>
 <20B0D65B-CB72-4F56-BF8F-7B212D04A7EA@nutanix.com>
 <22D82855-259A-425A-B401-2F51EEC3C746@nutanix.com>
 <e0869b55706915821a6aa1ba0140a784d263b01e.camel@linux.intel.com>
In-Reply-To: <e0869b55706915821a6aa1ba0140a784d263b01e.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4579:EE_|SJ2PR02MB9390:EE_
x-ms-office365-filtering-correlation-id: 4be475ca-955b-4a14-01ce-08dbe45c1de6
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIXw9/5COGG7s++rnFy6tRgXCLJ4CZyWW4O+5WR135zWPgKiqWO5qF0hkQJiQxi0ulpLHs2YBsw/7UiCGrjxvZOOunmnLWpWnHhTI4cXZRDApEH4x+qqOdcXb/TO20gPhtImZYstUlhYLLSnCPvpltMWJIkbH9UEs4p1TpPypyzYwv1Xzw5KSZdSTZ53Cf24m/YW0gdGujYSx/PvSIti+dpHUkYaa+4NXTvqTWNfx+xaP46kPFQR8o5KmydwQCIM9ybyOUfvyIeImu+B6nhwsmC011m1yVZvBzAoCTccMn74xoNIaOWcwGOz5iJP9N8LPokMDxiobqt5vCaO3oaxkPf+l6ex3QjrG91xbgssOV+QPA6si9ZbmAKgPu7KoFU7iI7rRjEeziaD1Gt/raiCDeft+aHS5dV5+qeAEYsqAPVKWQwlY/2bRyShrvCKEFTg+rJStTrlmRq6KI3vXcnS+oJE7kyEYDWHWWl+29I2saXc2cFbd9YIuqhWZRvjb/FO2ZA585UI0Qy+pVObwJ3vodjHz+UV0SGKU7k/JX+PLM8GUUtcTP1ok6NVw+W0aoblkwz6EWHBMpeNOsIMVF3TsWlRmuRveSboaBbO+dpE8a3MIJPKMqgOBDortagwHdAuSuVDEwuFC2whRkAObvurfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(2906002)(71200400001)(4001150100001)(38070700009)(6486002)(38100700002)(86362001)(122000001)(478600001)(316002)(41300700001)(6916009)(76116006)(36756003)(66946007)(54906003)(66446008)(66476007)(66556008)(33656002)(64756008)(4326008)(8676002)(8936002)(2616005)(5660300002)(6506007)(53546011)(6512007)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dyi72ze+aE9R267nC3f75K4AN49tLFKieaL/wLsaemWy6CNhmauh1a3oO5B7?=
 =?us-ascii?Q?YvSPHUKwsmOZG/1aowOoc6mq89PmSlIM0MeGIqq1Ex6X8LIgWsg3t/WustDO?=
 =?us-ascii?Q?9+6+iM8ek14JxYxnZNMW6rw5z/UxlTmUd43w4UxBMgL5c2lteLPlgnGZ2yc+?=
 =?us-ascii?Q?ruX61jD7/ytZzpHvwWFjWKpFGP65/Qjt7fI9cK8KYt61rRcumg6WuJ+0ob2z?=
 =?us-ascii?Q?TFqP4fftRdGPXR6ovEmMPARmCw+zkV84bRzeW0/z6mYpU2oxOSpnHcah1pcm?=
 =?us-ascii?Q?Yf3SvE3KFFyTI7Io++rrf+J+SErX0xgoV1XxVCdS5LgTym/Tmo104spoEhyb?=
 =?us-ascii?Q?anrdc1qvCCVGmjPxsh2d988kLbqKDF9Ux7U1f7IIPJt8aCJTX+ht0lRPAo2H?=
 =?us-ascii?Q?gOh4sR1MTUL1tP0PVsSQFrmA3rDgoG1T3iJz/wDEcHiL5M848l2YoAWHqf9v?=
 =?us-ascii?Q?c5mSLzOkC/TUPGi2wQ3MzK9Z33jbetGFOxSVozFhZ3fN/PFtDjuMUrcy8vYN?=
 =?us-ascii?Q?8VbiuPSBVgciXZ83GeE7jvVpj8TdOTGy61UV/Mn30iljSoQMtLYJxgutmvhT?=
 =?us-ascii?Q?hr6/So3Ykflna8tGqr1Z1qbsPZ8jL/tTp5wteBUhfIdfQ3sdbWgSA0QZlA6o?=
 =?us-ascii?Q?2WdR6cB8X7qE/FQsYuZj6rjDTwj/0UnJS51NKsAycTtoCKnnbS9ioQKXYek6?=
 =?us-ascii?Q?6WV/vaDnt+N3S51EPRcraV2V7W8vFtYDVyYNxvYYNfJawZv8xoxMgeZiJsnK?=
 =?us-ascii?Q?GTN/XI5qXa7eICucnRRLAzIt1BupYToWajFIuQAdqKcLGcq9BZ1pu/s7lRJH?=
 =?us-ascii?Q?7tBzNdAvRXA8GWDpSKjPbFj3X1NxTd4I1xYvdOsQ03VB0cQrFH1jTi7itD+l?=
 =?us-ascii?Q?yI5j9ElgOx7aodJO40zY+zGhHj03L+FXuB1vM4baqk76YgFAvjMxxFMoBU5K?=
 =?us-ascii?Q?yRtI++Z1raCRsxdB0BJ8lOyJdGgTzfnRT5VezJ9zFQnboemQViDsDTORUY68?=
 =?us-ascii?Q?oX1/OZGmDGgAh2P+9tq2+qbDP1f/d358Xkg2nNpsOJz2kb6bAd0c08519I/n?=
 =?us-ascii?Q?lk3v/BPnp/LmyRWX7+FmJEoEhSmSh1UjJRO8KCwjjorImwTvqnRVNZA4Y8Ua?=
 =?us-ascii?Q?j3hO2GJIxlqPbsmW9HFY+2U4H7H8c0rXoBLF6zYpT7hxDs7PzPqCRlsIVgaw?=
 =?us-ascii?Q?Vpk4q5RPio5e+t4Mh+Fh16RUhCAFAXR1KGqvBG9TcUwuVYrIdMRRCIz7qi7w?=
 =?us-ascii?Q?IkO2a92i3TRiOF0VrPeiILAjO467ZukRWSpoIm9tAVcgUl8esxAbFWfTzZuC?=
 =?us-ascii?Q?ue7yqFxoksavZadUh2kRRquGDTme9QUdgilgARMhW1NJGvXFXjcrLUViJpgD?=
 =?us-ascii?Q?Sog+MGAITuNbe/4PEPHz8hV6TRxG4FCgW2Of2fh/g3Ne1FHz+459G4jVRwXP?=
 =?us-ascii?Q?N7Ngo6flqWE1v7GLc8GrWJCQkZ/v0CijJPRTlh+7RYFPTIx/A16djOc+9J0F?=
 =?us-ascii?Q?+IE+ty9M+wUy96rknv/i2C6jm/I+c6+wCKsTpcBYT7oRwGG//D6Trw2ksqVb?=
 =?us-ascii?Q?MmDa5WKQlKh8xC5KAMwLiQJ5k+wSNEMwyvSTNnzlMlSaCoBYpi5b6/OgQqHA?=
 =?us-ascii?Q?sIpvZmLixatWFamVkKBzXeAaa2fS8hIPxgXkyNMRJ8RhuY6jeaqbpjRVu1bg?=
 =?us-ascii?Q?0tE39Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E45FF93537DE914B9673B17F5D7BA30B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be475ca-955b-4a14-01ce-08dbe45c1de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 15:20:49.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vg4GlG0INt7Avc+VndYp5x6ua6JRCsWRQhUYo1xOZA4sYvxdnmC4MExhwkwvuIyYNbSQtywQD+wLW/10IK/dyRVtsJbgOtw+/aWVDQ26sGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9390
X-Proofpoint-GUID: drfPwXnXhmpyV_3ciNz8DTTMgdWa5xus
X-Proofpoint-ORIG-GUID: drfPwXnXhmpyV_3ciNz8DTTMgdWa5xus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 12, 2023, at 6:52 AM, Artem Bityutskiy <artem.bityutskiy@linux.int=
el.com> wrote:
>=20
> On Fri, 2023-11-10 at 20:00 +0000, Jon Kohler wrote:
>> CPUIDLE_FLAG_IRQ_ENABLE
>=20
> Hi, yes, I did run several experiments, and found that this change would =
make
> some micro benchmarks give worse score. I did a lot of repetitions assumi=
ng I
> was mixing noise with signal, but every time confirmed that enabling inte=
rrupts
> in C1 made the score worse (like 1%).
>=20
> I do not have explanation for this phenomena, but decided to not pursue t=
his
> idea.
>=20
> Artem.=20

Thanks for the follow up. Indeed that is strange on why it would make it wo=
rse, but it
is good to know that the shipping configuration is going to work out best.

Thanks,
Jon

