Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57FF8128B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjLNHCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNHCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:02:37 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15291B9;
        Wed, 13 Dec 2023 23:02:43 -0800 (PST)
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE2KlG4006814;
        Wed, 13 Dec 2023 23:02:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint; bh=RtArAz8a8kRzmnSx50pHiaaBokwl6dygGUNrLUUg63M=; b=Z
        6WyeV/dBW7G5O51wpHlOnc6fLlLGmsSqW9qWfqSooOtMErnSp6vwkfEvqLu09N31
        +fyDj1LHecN+4ppQFjSsVe+N5ggzjoEo2PtxvsNmOq+Zha7q4OEiKhd8bJNTBBc+
        JO+VrOGbSvS6H40H2XcsTMnErOp5Sya1wwhNjemof1J1S0YYoEmIdIhh26eNvrhd
        PKJmZbjkarfmFzfaZRtkUrKs+mdWNUEs2VmMdyvhyBsvHSD4THugAWFIIeXFLAzk
        wyigH4XXHoHRF9DYgYYP89WokKRKDAoNfOue2VjWo6YeH7l9Tli+SXZ3J8FQ8UGb
        cpBv57Nr8zU3Isc+JXUJg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3uxqnmrdjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:02:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NU1gjGgBIjucbmw++qoOaQyu8RgCRp55IuQekVxNHXPrdON54pqCOC1UoAXmkRSLk+MHcu6kabGej4+aG+93LwfNRjyIINctsv55Ts/rPkd4AeW8goDpzp4gAOo8x9m2PRunRR0tbzLQuFhXKPxaVTRiwtuj5rg/hZPV1d9vsmNmB9eEJlYDDjBAv5g/oty/bK9BrjtZP7wgo4u+p7SJsmPFQs1xbF6UnfTpURIG1pUKm5VoAXVM7Su8GGe2b+qdagRRdUVZ6FqQjsj76YNKT5lMdYyONw4ZvL7+8DgFVRRx8Jskj3acB4uYSlkvbGuQKhsfaIIlGjvGrSgn0C6hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtArAz8a8kRzmnSx50pHiaaBokwl6dygGUNrLUUg63M=;
 b=aNuR2yngk3tG8qJDj+VE7HbK9FeaZ36pGUNVVi17JZMdtilYbfxb99ooDPodATHFPXXEDRr3bbE9yyaEcGlHNCQKluqUdr7TV8ETcF7ir1cvU2jdQy8GQtaP2tonrGq2rrBXPdvNgvSwTiiOWUEIxvbMNC+Ho97FR6cT7dqo+nKjk/7mWp9UotYnUwzuJlkivVFiQ772r0/Ne5FhkKeFM7spFhoUSkMfqeJVRe/VjxXUJL32thEORrKWenB2ZP7NBeuV92DEYtQru0febp5EFJ9kKUZr0PNOqj0wRRk78+CzfZUe3e4enGmXWoAhbPUIhVPWUa0rDDw4RA4f7gB8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtArAz8a8kRzmnSx50pHiaaBokwl6dygGUNrLUUg63M=;
 b=0CE3FW4c/w6HUAmRINssWBtapGc2DkmMWdCi3AIJRWSI9qn0VIQXRy59Rsq2J2spP2LK16K6Vt4j1ivqfmHST0nZb9JM0hh0mes5s4OCZN9gxDTPJRR+c0+/v/xN4WPfJmZD6kaOpEVGBHQbPLkLB+w2mS+qBbc76zFlfGTfQ50=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by CH2PR07MB7222.namprd07.prod.outlook.com (2603:10b6:610:ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:02:20 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::18e0:2af0:e596:d9ed]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::18e0:2af0:e596:d9ed%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:02:20 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "s-vadapalli@ti.com" <s-vadapalli@ti.com>
Subject: RE: [PATCH v2 1/5] dt-bindings: phy: cadence-torrent: Add optional
 input reference clock for PLL1
Thread-Topic: [PATCH v2 1/5] dt-bindings: phy: cadence-torrent: Add optional
 input reference clock for PLL1
Thread-Index: AQHaLPErVNHufsY/DkSKW4VikCPlO7CmxveAgAGOr6A=
Date:   Thu, 14 Dec 2023 07:02:20 +0000
Message-ID: <DM6PR07MB61548DC520B4BA66D6FC625AC58CA@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20231212114840.1468903-1-sjakhade@cadence.com>
 <20231212114840.1468903-2-sjakhade@cadence.com>
 <e09e4df8-ec36-4953-9bb0-75a3ce0b535d@linaro.org>
In-Reply-To: <e09e4df8-ec36-4953-9bb0-75a3ce0b535d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iNjJjN2NiMi05YTRlLTExZWUtYmMwNi1lOTlhY2FjY2Q0OTNcYW1lLXRlc3RcYjYyYzdjYjMtOWE0ZS0xMWVlLWJjMDYtZTk5YWNhY2NkNDkzYm9keS50eHQiIHN6PSI1NTIwIiB0PSIxMzM0NzAxMDkzNjAxMzQwOTMiIGg9Ino2MFdFYTVWUmU4eFhQS3NUMFBxYjV2WnVxQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6154:EE_|CH2PR07MB7222:EE_
x-ms-office365-filtering-correlation-id: 9416a824-2fcd-456a-c57e-08dbfc729d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYjU2hVUZpE0Cpg9PDKXooIc74zw3vUxOTkesKT0q3n5k2bxCfGDRq0Bycqaa/tf/M7/vbjRHZizztU8a9IDM3smYuqheHoiRY3Ofq08a6YnPojoU1olbajNDtUfdfy/Yugk5pkCkeDWCqQ9etvDGrK1N/K/fwFYv9Hn1z9bvYi/m8+3ijLjlkBhFu+j9NYFWoUjULMnXDr5ZRru4ysZOam1X661ZVS8UZr+WQnW9DipT9mW+SKxWXFlp3T6/rWUuS1Smu/xi1miUDcLNtte/55tp8jt/x5AaqYwyjKxSp9g4z2YZwoMIhNLlf+NYSQ+Wkqmy09sVSZP0pXVVmA/N4RxiS9m9f5sl+/m6r4vsQGhs8u5CDH2JicWQROJ7AnKbMUpyso4piH7K6AhFsVFAuCMecXc+aA14Qd0WqQiBa06fgnKqGJASUgWbG2bik160+hKL+30arTQvJ57ZI14ryFVxHmQGx4TcxKw9/YUXedUr8G0SAg2oQMT7ztms0bpXaxAGOVkBTXJsh9+IHhHDtU0JQRvfUT4pkRUj7M9hx38H7RssTsn6tEchvbG8uqAreQq1kZD7PXQVlPiG7Be0W5F2H6s5EBDWuoTIcyGnQ1hK/GeLIqZpkxiY9xRQdHETtWl1X4Hiop0+y5Kef5/pLQRMDmkk13eSgZmhplYEHs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(55016003)(478600001)(122000001)(38100700002)(33656002)(71200400001)(2906002)(9686003)(4326008)(6506007)(5660300002)(86362001)(7696005)(7416002)(53546011)(52536014)(8676002)(8936002)(26005)(54906003)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(316002)(110136005)(41300700001)(38070700009)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bllYWHBLdkI3enlmOUZ5ZzdNV1BMZ2xOS2UrcFhoOXF4S2EzR1duemYzOU5K?=
 =?utf-8?B?Y0phSlpyTTFVR2IzQi84Znl6eXAxcC9XWlFMOWErUkJyWGJEOFl0L2U2Q0Nz?=
 =?utf-8?B?cjNXeGFSOTcvbGxUMTFaaW5OcnYxckh6NmNxcXF2NTAreHJOWlg1YzFnYS85?=
 =?utf-8?B?K3pmcTN1clBLTGJIKy9qdWtTMGFrT1UvYzcwbmtjQ2hlTHl5b1p6ZXpKT2RI?=
 =?utf-8?B?SzUzNXpqRE1SdU1GdWl0SEJYREVwNFJqN2FrZGw5WmZoVFdDcXBQeXBlak1y?=
 =?utf-8?B?YzJHNTFxcmJnMW12SGNWcHhUUkhIQ2w1UXIvN0JvaDluSFRyUUJWSE5pejBi?=
 =?utf-8?B?YWRUSk9BNVh3bFc2cmRmVis4OXN4WDBZcTN6aWcrMWtPZTdZbnA4cXhpSU0v?=
 =?utf-8?B?WDlVeU1ucE9ra1hYZnpPM292ZWQ2Wm4zQ0wvL3NHekIvc0lBL2ZYWFFkNHFS?=
 =?utf-8?B?UmZDNzV2MGl0UWtHZTFLKzlsZXlaTjAxTHNENUtXYUpaWWQzM0VpNHY0Y2t4?=
 =?utf-8?B?RzIwaUJrdjB0VXlTUUxQR0lPRDNjZDhsVUVnWUVDd3Z1aDFRbUVneHRXY3JF?=
 =?utf-8?B?VmFmVGNVZ1ZtdGF6d3VXazUrWGJ0K3lVbTVMOUd2aFhDVUwxTk5WVE1reGxL?=
 =?utf-8?B?eW83WFNOdXNyY1Excm0vOFpKSFdXUkd6UmIrNHU4Tk1BcFE0Mk1WaDFaNk1E?=
 =?utf-8?B?NlRvaUx6UGlUaHl2elp4M0NVMnArbzNMdlFDNmVZUy9pc3lhTkNlRzlyTmU0?=
 =?utf-8?B?d2NvUnJOVU8wU3RtZnc1WG15c0RIMEQwYVlKWjl0VEVGM0pTeElWaFY4U3J1?=
 =?utf-8?B?ZlVwNUVUZ2MyRHYzc3A3RnZNU2IwY1p4WWIzU3JYQS9jRmhzeHhZb1hvcmVo?=
 =?utf-8?B?YU56d3NaeVVrMVVMYTVsbGRaT1U5ZlZSam10cThCUW1VVEFMWFVJYnhrWElu?=
 =?utf-8?B?WFVSeExqWFN2WUxTSExkbVZGMEM1T2hYV25kUFVXeFlzb29QcmVXeUpoYjB5?=
 =?utf-8?B?WE5YOUd0UHdwT0p3L2xkZGpuMktaQzEwRlZ5a2tBZGVidDJyRzhYRTJ3RFJa?=
 =?utf-8?B?QnI1UGduWU96Yjh3Q203UGRjQ3MyTVp6RmhOclRqdFJBclE2V1FGZWliTkd5?=
 =?utf-8?B?NlV0cTI5L2U5UE9MQ1pPenJFb0JzRzdGQlNsYzB4bGFtak5sc3JpRDV5SUx2?=
 =?utf-8?B?TStnQXdKL3B4cElHdjAzYUxqS2NSeHo4NDdablQzQVg5MkNJQlhTQW9iRFpo?=
 =?utf-8?B?b2ZHQVBXM0xnZWVJMlp1QVdEd2xveHhrcUpSbVgwMmtwVC85Qzd1OGJiRURN?=
 =?utf-8?B?VVIzQ25zNXgyckZDQWFkSWJ5OUdQNnQvMDhPSVQ2YXZ0U05SVU03ZHRBSll2?=
 =?utf-8?B?ZTZqSHk4OEprV3Nlb2tlS25QKzFMdVJ1WFVuMWVxT0U3bnJtWUhIam1oM1kw?=
 =?utf-8?B?VFlINCtnNG9Xdkh6M1BkTmswR1lWdG9vQ2VTMFg4ZzBsY3lQZzRoekVHUVhk?=
 =?utf-8?B?N1crTEYrTDNMRWpSK2JVME15WVhWMWdOa1JQZmJYeGtGVEFCbFB3c1FTSDF2?=
 =?utf-8?B?bHFlUTR0emlTZWpBZWQ5aFV3MUJZQURKOU80a2hHTlV0RHl4TkUvWUpVcXNM?=
 =?utf-8?B?bVYvL0JHZ1hCaGhxLzJMZkl1eko4bDVVTWd3ek1mNGhmbjR6UExqclgrNmxV?=
 =?utf-8?B?aXJQdEtDZkRsK0kxSk81bEpSSi9PaDJzTWlOVWVUVndIZk9kbGNqUG1yeG5N?=
 =?utf-8?B?U0pXWkJ6VTA2U1ZrMlh4TU0xM1I4MGZjWXJpNTFqYXI1TG4rODFjWDZhY1J0?=
 =?utf-8?B?QWJzbUZ6VTdzQS82S3A5dzdzODl4NEw2a3dDMFZJak8rdVhhdDN4WXo5VHor?=
 =?utf-8?B?RWdGbFJKNVhONTNKcTJaT0NpbmFJNUg4eWl4Z09sSS8za3dCZHl4QzF3b0Nk?=
 =?utf-8?B?bjU2ZyttWkgwemtvYVJOaFRnWG9JQ3d4dUF1c2JWdXZRVXU1OFQyRlZ3VzFr?=
 =?utf-8?B?VXE5TGFIbG0rQkRKNDdCekhPMnZHQnBIU0FuRk93MEt6UWJYTTlpWENwOEN5?=
 =?utf-8?B?YWJybmR2M3BvSW5JWWsyTTVpWUpadGsxbG1XeitVanNha0ZFR2k5TWUzdlhw?=
 =?utf-8?Q?joQLfnvo+O19LHZD3fVfXfmMy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9416a824-2fcd-456a-c57e-08dbfc729d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 07:02:20.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnH8Lcy+PdK6+aNgWj0eq+yB17ok4agNTDxU/sqHd56Ih58TfCzwEqZ+2g1nWVV9D1X2svdt+7pRH2PvEDr9a990QtiERojjTOGUEJ9tKVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB7222
X-Proofpoint-ORIG-GUID: QpHRonMU9zY1XO8ppfvG32qDeBTnOgo9
X-Proofpoint-GUID: QpHRonMU9zY1XO8ppfvG32qDeBTnOgo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxlogscore=949
 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBEZWNlbWJlciAxMywgMjAyMyAxMjoxOSBQTQ0KPiBUbzogU3dhcG5pbCBL
YXNoaW5hdGggSmFraGFkZSA8c2pha2hhZGVAY2FkZW5jZS5jb20+OyB2a291bEBrZXJuZWwub3Jn
Ow0KPiBraXNob25Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296
bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LXBoeUBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1pbGluZCBQYXJhYiA8bXBhcmFiQGNhZGVu
Y2UuY29tPjsgcm9nZXJxQGtlcm5lbC5vcmc7IHMtDQo+IHZhZGFwYWxsaUB0aS5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAxLzVdIGR0LWJpbmRpbmdzOiBwaHk6IGNhZGVuY2UtdG9ycmVu
dDogQWRkIG9wdGlvbmFsDQo+IGlucHV0IHJlZmVyZW5jZSBjbG9jayBmb3IgUExMMQ0KPiANCj4g
RVhURVJOQUwgTUFJTA0KPiANCj4gDQo+IE9uIDEyLzEyLzIwMjMgMTI6NDgsIFN3YXBuaWwgSmFr
aGFkZSB3cm90ZToNCj4gPiBUb3JyZW50IFBIWSBjYW4gaGF2ZSB0d28gaW5wdXQgcmVmZXJlbmNl
IGNsb2Nrcy4gVXBkYXRlIGJpbmRpbmdzDQo+IA0KPiBJdCBhbHJlYWR5IHN1cHBvcnRzIHR3by4N
Cj4gDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCnJlZmNsayBhbmQgcGxsMV9yZWZjbGsg
YXJlIHRoZSB0d28gaW5wdXQgcmVmZXJlbmNlIGNsb2NrcyBmb3IgdGhlIFBMTHMuDQpwaHlfZW5f
cmVmY2xrIGlzIHVzZWQgdG8gZW5hYmxlIG91dHB1dCByZWZlcmVuY2UgY2xvY2sgaW4gc29tZSBj
YXNlcy4NCg0KPiA+IHRvIHN1cHBvcnQgZHVhbCByZWZlcmVuY2UgY2xvY2sgbXVsdGlsaW5rIGNv
bmZpZ3VyYXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3dhcG5pbCBKYWtoYWRlIDxz
amFraGFkZUBjYWRlbmNlLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L3BoeS1jYWRlbmNlLXRvcnJlbnQueWFtbCAgICAgICAgfCA2ICsrKy0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LWNh
ZGVuY2UtDQo+IHRvcnJlbnQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvcGh5LWNhZGVuY2UtDQo+IHRvcnJlbnQueWFtbA0KPiA+IGluZGV4IGRmYjMxMzE0ZmFj
ZS4uOTg5NDZmNTQ5ODk1IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvcGh5LWNhZGVuY2UtdG9ycmVudC55YW1sDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktY2FkZW5jZS10b3JyZW50LnlhbWwN
Cj4gPiBAQCAtMzUsMTQgKzM1LDE0IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBtaW5JdGVtczog
MQ0KPiA+ICAgICAgbWF4SXRlbXM6IDINCj4gPiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+IC0gICAg
ICBQSFkgcmVmZXJlbmNlIGNsb2NrIGZvciAxIGl0ZW0uIE11c3QgY29udGFpbiBhbiBlbnRyeSBp
biBjbG9jay1uYW1lcy4NCj4gPiAtICAgICAgT3B0aW9uYWwgUGFyZW50IHRvIGVuYWJsZSBvdXRw
dXQgcmVmZXJlbmNlIGNsb2NrLg0KPiA+ICsgICAgICBQSFkgaW5wdXQgcmVmZXJlbmNlIGNsb2Nr
cyAtIHJlZmNsayAmIHBsbDFfcmVmY2xrIChvcHRpb25hbCkuDQo+ID4gKyAgICAgIE9wdGlvbmFs
IFBhcmVudCB0byBlbmFibGUgb3V0cHV0IHJlZmVyZW5jZSBjbG9jayAocGh5X2VuX3JlZmNsayku
DQo+IA0KPiBTbyB0aGlyZCBjbG9jaz8gQnV0IHlvdSBhbGxvdyBvbmx5IHR3bz8gQ29uZnVzaW5n
Lg0KPg0KDQpZZXMsIGlmIGJvdGggcmVmY2xrIGFuZCBwbGwxX3JlZmNsayBhcmUgcHJlc2VudCwg
cGh5X2VuX3JlZmNsayBjYW4ndCBiZSB1c2VkLg0KDQo+ID4NCj4gPiAgICBjbG9jay1uYW1lczoN
Cj4gPiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBjb25z
dDogcmVmY2xrDQo+ID4gLSAgICAgIC0gY29uc3Q6IHBoeV9lbl9yZWZjbGsNCj4gPiArICAgICAg
LSBlbnVtOiBbIHBsbDFfcmVmY2xrLCBwaHlfZW5fcmVmY2xrIF0NCj4gDQo+IFRoaXMgZG9lcyBu
b3QgbWF0Y2ggeW91ciBjb21taXQgbXNnLiBZb3UgYWxyZWFkeSBoYWQgdHdvIGNsb2NrcyB0aGVy
ZS4NCj4gDQpZZXMsIGJ1dCByZWZjbGsgd2FzIHRoZSBzaW5nbGUgaW5wdXQgcmVmZXJlbmNlIGNs
b2NrIHVzZWQgZm9yIFBMTHMgZWFybGllci4NCkFzIHN0YXRlZCBpbiBjb21taXQgbWVzc2FnZSwg
YSBuZXcgaW5wdXQgcmVmZXJlbmNlIGNsb2NrIChwbGwxX3JlZmNsaykgaXMgYWRkZWQgaGVyZS4N
Cg0KVGhhbmtzICYgcmVnYXJkcywNClN3YXBuaWwNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQo=
