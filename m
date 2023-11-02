Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C27DF430
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376641AbjKBNpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376595AbjKBNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:45:00 -0400
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60719D7;
        Thu,  2 Nov 2023 06:44:55 -0700 (PDT)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A27up6l016247;
        Thu, 2 Nov 2023 09:44:22 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u47tyryq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 09:44:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUWY6YGwEh1vmv+8stLRax+Ugj0fqnmV+LqcO1YabnEFP9APgIrhyeQwub74UCi65GlEz+76eFxFZD0LdgQ+V34eF8wPy4CvbTX/rl/qeCe4f+tv0TE7QjZtfF9DbWr54L4+9G/noDFErh7KcU2cx7w7mI0lGvN9qfSJbF+RQiC9Amq/Wpd2OanUsH4OrHAWCHh8FzQQz2KRqj6AqdcSv9RUsxS4b27v3K4b7d5jfJ4h+1M/sO2Xz0ouSFEThcqHDd4IuPhJrCVB0jQpUI7fR2x9gKEQVwp/oScnltZTyoyumpe3JFI3e5dPihgdKdsAW3WNauEP8EawKQBUFk0rwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+V9hFSLmWwxJwD+Cud52dJ8dQbT7EMdsdfLOUdxnlA=;
 b=YODL2KZlbHcrpTa7O+6pdbDWeS+mI1i3T8JsMy7c2+okGXuTRmBFUDv6qVacJd5iZwzuuWm+Nk4yUY66/b0/Alj5lRE3B4xyooCuAMlw/9ljenY1fksvk0fohI9P2zMq89omKMtU05VgWQu2/zan8x1ejKwM31GUaurWia2K+RM5J2+TEJLDrbtVzOdQzWeqfqnuHoN97fmsHPX4XZX7NtqsgoFljv+6l5PiHAF7gt4RKQTyuvUqysi5LJJY2F73mhsI8fI9XpfFu9PaTPoEAYDJcifBFOcXurgGp2MCAUZQtWF3LOk3cV089ZuacSGces5alel0P907XeQcFxFGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+V9hFSLmWwxJwD+Cud52dJ8dQbT7EMdsdfLOUdxnlA=;
 b=7G1VZLhUUhcPo/Q71dn3SsLDhTBoaZgIwDG4nX0qYvnxrg3Lx5FD5BbrZVSHnfGk6NoZeXw77MMWJxZaaEc5sFcmN1cNAKxB3JJo8y+AKqhEDDlObuj75i3ntDKOrVdkvSeuCguj+F9vTCqGN1XfBhdkkJM+6Va8qmQe3EolZuI=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by DM6PR03MB5306.namprd03.prod.outlook.com (2603:10b6:5:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Thu, 2 Nov
 2023 13:44:16 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Thu, 2 Nov 2023
 13:44:16 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] rtc: max31335: add driver support
Thread-Topic: [PATCH v4 2/2] rtc: max31335: add driver support
Thread-Index: AQHaDMEKHQ+RJtDWgkKJJS24k84zJrBmCqEAgAD6otA=
Date:   Thu, 2 Nov 2023 13:44:16 +0000
Message-ID: <CY4PR03MB3399BAAA3A3F6FC4B9A7A9FB9BA6A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231101094835.51031-1-antoniu.miclaus@analog.com>
 <20231101094835.51031-2-antoniu.miclaus@analog.com>
 <202311012223422e3387b3@mail.local>
In-Reply-To: <202311012223422e3387b3@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-7?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-7?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-7?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1lN2ZkNWJmNy03OTg1LTExZWUtYWU3YS?=
 =?iso-8859-7?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcZTdmZDViZjgtNzk4NS0xMWVlLWFl?=
 =?iso-8859-7?Q?N2EtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIxMDczMCIgdD0iMTMzND?=
 =?iso-8859-7?Q?M0MDYyNTM4MzA3OTkxIiBoPSIzMXR3M1gxVmVDOVpGT204UU9odERiSzlm?=
 =?iso-8859-7?Q?VVE9IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVU?=
 =?iso-8859-7?Q?ZOQ2dVQUFFb0NBQUNYZVlpcWtnM2FBVmlJOGFDYzdhWGZXSWp4b0p6dHBk?=
 =?iso-8859-7?Q?OERBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQU?=
 =?iso-8859-7?Q?FBQUFBQUFBQUFBQUFBQUFBRUFBUUFCQUFBQUVPcGxPZ0FBQUFBQUFBQUFB?=
 =?iso-8859-7?Q?QUFBQUo0QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeU?=
 =?iso-8859-7?Q?FHOEFhZ0JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1B?=
 =?iso-8859-7?Q?YVFCMEFHa0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-7?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-7?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0?=
 =?iso-8859-7?Q?FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFH?=
 =?iso-8859-7?Q?VUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-7?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-7?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-7?Q?FBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJr?=
 =?iso-8859-7?Q?QUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUU?=
 =?iso-8859-7?Q?Fjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-7?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-7?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-7?Q?QUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D?=
 =?iso-8859-7?Q?=3D?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|DM6PR03MB5306:EE_
x-ms-office365-filtering-correlation-id: 33310a8c-d122-41ae-9ea7-08dbdba9ce5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88+dum8yQndDCqJ/734LoztibIrXuIkwkFMhi2gsU9S7rjaw/42NiUrReMss5/6kjC+7z3MruOHghAl2q/p0XVsPDkOjb0SdOZvM9EPw53inY652wTy0TzZ5FHu3DZYL0YFBI50gvy3PMjcS4uEabgHymsEdbDo2Uau/tw1pRQLASxlqJVXmOFsaPiSaTwSDT2k7v5L/DEiVoH1RbAEeJJmMK+LyJAi1TDZab/8AfDevBX2VYBfS+eIIIPg5BmvIL9I4KioZ9FiNMdiOzlMh2BkseLeip+4BTQyolCd6U9wt/ZY/HaNz9uUrCACuluoalG2xDZ5QfENQuICf38/uJUrLFXHKDdhq7lOCiKGO/6g4fKRLe735IqWAEMnRaCk5eOYqbXkvxJXUy2jzlxGzYKM4clcfiYJXhpReYzHvBQFV+e7YGZv8mTqn00BWUe7Ks/wxExlKwrNAUJ0Z1M+qN74kHjDGzMjCNdMDULucBOH0SawqxyAUvLcYchf+xo/KCj68F3VeRhVzsnD8ilbNYXPnwi0/OML5hIilfyHCN+aG1CpFc5804LIlFBUEl1DUra/ADqR8HrIxVOm5HznrdgFIEwCz0o6lm6HsTaoOZ5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(52536014)(4326008)(8676002)(8936002)(5660300002)(41300700001)(2906002)(30864003)(7416002)(83380400001)(55016003)(6506007)(71200400001)(33656002)(9686003)(7696005)(26005)(122000001)(66476007)(66446008)(64756008)(54906003)(6916009)(316002)(66556008)(66946007)(76116006)(966005)(86362001)(478600001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-7?Q?g68xqJZjkM9xlKd5gh1AtstPJIxCeX0dTzB7+gOc+1xOiquQ+htIrdajCk?=
 =?iso-8859-7?Q?tzYFYu4x/xBbOn4B2l78+ffURGw3cX/+nHrFCkRC8awMHkvxAbOQRkHwJx?=
 =?iso-8859-7?Q?rss1yQHcrUz5vJbxmdLhSC1/NGle5G1m0GOPYTYAHqsRDphHoZK0mU06Bx?=
 =?iso-8859-7?Q?1lcFD/1zBdOltOetgMy/uOE/e966wzEgwDpD5j72xpEa/e5n2YPhdDDrsX?=
 =?iso-8859-7?Q?ZpgvtLgfeL0OWD9egHp9hbx38NXUV25ui9YGIMFRo4R9c8Z/FwIMEn5kBi?=
 =?iso-8859-7?Q?+MInb4xFsC0LUY/6YHEw6QEqifKutFr0b+LYHESDZ7imcv8dLVvWoyX/vo?=
 =?iso-8859-7?Q?HV3vfO6JkCAwqxQRwOOvZO0euhBnKII91EgdFlW8zBr3MigdKSi4mO7NhK?=
 =?iso-8859-7?Q?LUzhB3gtTsArsk49TSQq9w+VmHSR9lfwZAApmnQGfSjHVH18rpf6r1afYz?=
 =?iso-8859-7?Q?tDcTqs73dJjT+UjOtEtHA26o2em+3rl4bTD9qo7aInGBbOj1X4XHG8gwZh?=
 =?iso-8859-7?Q?EONpaFMwd+L8mGVgVVkeY6KqvDIjbmNW0vMcNcKwU/PmyAQNamab7PnvXu?=
 =?iso-8859-7?Q?bYcQLeEo/Rb2qxmkQAtfF/VXyQc58ZusE39YJZGxAF8D69CuU0bHe0Iz5r?=
 =?iso-8859-7?Q?M4czCQf6mXGf/gue6ujnK5B+nDI1n+H5qAKip89y1iSi8W1UAxOnZqf0zn?=
 =?iso-8859-7?Q?2V2XsfwTH76DJLW7mvrkdMq1qYxSObbP7RJC67tXaWsbx21jdEyLvW3jG1?=
 =?iso-8859-7?Q?FVUVglKlZY9VAv5kirB/uAqUJhubIC03VeSJRqdg5Mq3caequbbFqdODxG?=
 =?iso-8859-7?Q?6N/Jmqz7XUNqJ0HRHafdPf44QlQII4wnvkL8N+e0OZk5PHgupvQWowHnbU?=
 =?iso-8859-7?Q?TvCtvLH61E8vAGkfoRo3yX5ny59CxxHYVcRKTuLOsUoTBj6UlVkyOVIzkd?=
 =?iso-8859-7?Q?PX0aAjNa8K5bmZesvvHyUih6rYki5Is8Ob3MfROW8j6uCgtEZKNgxW1Rv7?=
 =?iso-8859-7?Q?FxZmdoWK7VpVws4OZPtnVdc7HvgIGWjLdFEzyU0xMK9/ovDGWRMZQaEOex?=
 =?iso-8859-7?Q?+77sFFbZlWBa5mC5IhQt0Bw2TMJyVMYCE6P/8WQllTyJTZKxAyolVYwfMF?=
 =?iso-8859-7?Q?/tGXhw+9OTdHbEJxvuFjDuV9JLncPT8FUlPFZR6mgWLm+2pjuSM4IunmpE?=
 =?iso-8859-7?Q?V4Gi8D5YMNPvqVpsA2IMFq2mFRMtzEYBqycNdosFYIPwCZEBYASaJ+Tgng?=
 =?iso-8859-7?Q?MFmdd+rMyNl/s1pRUPNVOLVeLcxCnwmTC0U3YU/P275s1/HO6Yll/b0T+4?=
 =?iso-8859-7?Q?Y91XNxpN/vD6e1xs3ujHzQZLeEA9KJF1WOo/0CnPT/yZkahwH3CPtlGN1G?=
 =?iso-8859-7?Q?oWjC7DRzmc/6uGUBgzNOkxjKlP1fVQox17bz37eiHMf0cZRlaNv5qWHhZJ?=
 =?iso-8859-7?Q?R1Ak8o+sO99Uv6DhtYa1vWQHEU4G9jfh65tw+UtsbsW9aims/qkl5jhqJQ?=
 =?iso-8859-7?Q?9w8/Q3DGpSu4pustnnwUrl/JR3bvCUs+JHVvPz0UE+ICD3vnptFjK2mXX7?=
 =?iso-8859-7?Q?TmxuwFBYd4ris+IBLvAGwsWGNK1OJBpB9VsKo2SOvD8RyeafLY180Uahzd?=
 =?iso-8859-7?Q?VGJfiMAjBH+ruZDIHwaxf5q/vcsqpClip8QqUb3KnCVJHS1no2lOVWEw?=
 =?iso-8859-7?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33310a8c-d122-41ae-9ea7-08dbdba9ce5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 13:44:16.0677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIUF46M/F2tHJAvyxmNOQg8M080u9vOr0PyJi3VgowIdHdaXYK/ruU6BC3TSf9xPUecG58AnafTDHj47ScYL3Fjk0BpPRYFaye+2LWsTcPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5306
X-Proofpoint-ORIG-GUID: h2LMcV7-3ZHYiYQOSlt5J8Qjtz-nQjVh
X-Proofpoint-GUID: h2LMcV7-3ZHYiYQOSlt5J8Qjtz-nQjVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_03,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2311020110
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> On 01/11/2023 11:48:14+0200, Antoniu Miclaus wrote:
> > +static int max31335_get_hour(u8 hour_reg)
> > +{
> > +	int hour;
> > +
> > +	/* 24Hr mode */
> > +	if (!FIELD_GET(MAX31335_HOURS_F_24_12, hour_reg))
> > +		return bcd2bin(hour_reg & 0x3f);
> > +
> > +	/* 12Hr mode */
> > +	hour =3D bcd2bin(hour_reg & 0x1f);
> > +	if (hour =3D=3D 12)
> > +		hour =3D 0;
> > +
>=20
> Do you really need to support 12h mode?

Is is a feature supported by the part, so I think is nice to have.

>=20
> > +	if (FIELD_GET(MAX31335_HOURS_HR_20_AM_PM, hour_reg))
> > +		hour +=3D 12;
> > +
> > +	return hour;
> > +}
> > +
> > +static int max31335_read_offset(struct device *dev, long *offset)
> > +{
> > +	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
> > +	u32 value;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(max31335->regmap, MAX31335_AGING_OFFSET,
> &value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*offset =3D value;
>=20
> This is super dubious, what is the unit of MAX31335_AGING_OFFSET ?
>=20

There is not additional information on the AGING_OFFSET register (no
other offset registers).
I treated it as a raw value that user can write/read. Should I drop the=20
offset implementation?

> > +
> > +	return 0;
> > +}
> > +
> > +static int max31335_set_offset(struct device *dev, long offset)
> > +{
> > +	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
> > +
> > +	return regmap_write(max31335->regmap,
> MAX31335_AGING_OFFSET, offset);
> > +}
> > +
> > +static int max31335_read_alarm(struct device *dev, struct rtc_wkalrm
> *alrm)
> > +{
> > +	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
> > +	struct mutex *lock =3D &max31335->rtc->ops_lock;
> > +	int ret, ctrl, status;
> > +	struct rtc_time time;
> > +	u8 regs[6];
> > +
> > +	mutex_lock(lock);
>=20
> Use rtc_lock(), I'm not quite sure why you would need locking here
> though.
>=20
> > +
> > +	ret =3D regmap_bulk_read(max31335->regmap,
> MAX31335_ALM1_SEC, regs,
> > +			       sizeof(regs));
> > +	if (ret)
> > +		goto exit;
> > +
> > +	alrm->time.tm_sec  =3D bcd2bin(regs[0] & 0x7f);
> > +	alrm->time.tm_min  =3D bcd2bin(regs[1] & 0x7f);
> > +	alrm->time.tm_hour =3D bcd2bin(regs[2] & 0x3f);
> > +	alrm->time.tm_mday =3D bcd2bin(regs[3] & 0x3f);
> > +	alrm->time.tm_mon  =3D bcd2bin(regs[4] & 0x1f) - 1;
> > +	alrm->time.tm_year =3D bcd2bin(regs[5]) + 100;
> > +
> > +	ret =3D max31335_read_time(dev, &time);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	if (time.tm_year >=3D 200)
> > +		alrm->time.tm_year +=3D 100;
> > +
> > +	ret =3D regmap_read(max31335->regmap, MAX31335_INT_EN1, &ctrl);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D regmap_read(max31335->regmap, MAX31335_STATUS1,
> &status);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	alrm->enabled =3D FIELD_GET(MAX31335_INT_EN1_A1IE, ctrl);
> > +	alrm->pending =3D FIELD_GET(MAX31335_STATUS1_A1F, status);
> > +
> > +exit:
> > +	mutex_unlock(lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm
> *alrm)
> > +{
> > +	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
> > +	struct mutex *lock =3D &max31335->rtc->ops_lock;
> > +	unsigned int reg;
> > +	u8 regs[6];
> > +	int ret;
> > +
> > +	regs[0] =3D bin2bcd(alrm->time.tm_sec);
> > +	regs[1] =3D bin2bcd(alrm->time.tm_min);
> > +	regs[2] =3D bin2bcd(alrm->time.tm_hour);
> > +	regs[3] =3D bin2bcd(alrm->time.tm_mday);
> > +	regs[4] =3D bin2bcd(alrm->time.tm_mon + 1);
> > +	regs[5] =3D bin2bcd(alrm->time.tm_year % 100);
> > +
> > +	mutex_lock(lock);
>=20
> I'm not sure why you need locking here either, maybe you should simply
> disable the alarm first?
>=20
> > +
> > +	ret =3D regmap_bulk_write(max31335->regmap,
> MAX31335_ALM1_SEC,
> > +				regs, sizeof(regs));
> > +	if (ret)
> > +		goto exit;
> > +
> > +	reg =3D FIELD_PREP(MAX31335_INT_EN1_A1IE, alrm->enabled);
> > +	ret =3D regmap_update_bits(max31335->regmap,
> MAX31335_INT_EN1,
> > +				 MAX31335_INT_EN1_A1IE, reg);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	ret =3D regmap_update_bits(max31335->regmap,
> MAX31335_STATUS1,
> > +				 MAX31335_STATUS1_A1F, 0);
> > +
> > +exit:
> > +	mutex_unlock(lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int max31335_alarm_irq_enable(struct device *dev, unsigned int
> enabled)
> > +{
> > +	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
> > +
> > +	return regmap_update_bits(max31335->regmap,
> MAX31335_INT_EN1,
> > +				  MAX31335_INT_EN1_A1IE, enabled);
> > +}
> > +
>=20
>=20
> > +static int max31335_trickle_charger_setup(struct device *dev,
> > +					  struct max31335_data *max31335)
> > +{
> > +	u32 ohms, chargeable;
> > +	bool diode =3D false;
> > +	int i;
> > +
> > +	if (device_property_read_u32(dev, "trickle-resistor-ohms", &ohms))
> > +		return 0;
> > +
> > +	if (!device_property_read_u32(dev, "aux-voltage-chargeable",
> > +				      &chargeable)) {
> > +		switch (chargeable) {
> > +		case 0:
> > +			diode =3D false;
> > +			break;
> > +		case 1:
> > +			diode =3D true;
> > +			break;
> > +		default:
> > +			dev_warn(dev,
> > +				 "unsupported aux-voltage-chargeable
> value\n");
>=20
> I don't think the string is necessary, checking the DT should be done at
> compile time.
>=20
> > +			break;
> > +		}
> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(max31335_trickle_resistors); i++)
> > +		if (ohms =3D=3D max31335_trickle_resistors[i])
> > +			break;
> > +
> > +	if (i >=3D ARRAY_SIZE(max31335_trickle_resistors)) {
> > +		dev_warn(dev, "invalid trickle resistor value\n");
>=20
> Ditto.
>=20
> > +
> > +		return 0;
> > +	}
> > +
> > +	if (diode)
> > +		i =3D i + 4;
> > +	else
> > +		i =3D i + 1;
>=20
> Do you actually need to configure the trickle charger when there is
> nothing to charge?

These are the options for the trickle chager:
MAX31335_TRICKLE_REG_TRICKLE bits

0x0: 3K=D9 in series with a Schottky diode
0x1: 3K=D9 in series with a Schottky diode
0x2: 6K=D9 in series with a Schottky diode=20
0x3: 11K=D9 in series with a Schottky diode
0x4: 3K=D9 in series with a diode+Schottky diode
0x5: 3K=D9 in series with a diode+Schottky diode
0x6: 6K=D9 in series with a diode+Schottky diode
0x7: 11K=D9 in series with a diode+Schottky diode

>=20
> > +
> > +	return regmap_write(max31335->regmap, MAX31335_TRICKLE_REG,
> > +			    FIELD_PREP(MAX31335_TRICKLE_REG_TRICKLE, i) |
> > +				       MAX31335_TRICKLE_REG_EN_TRICKLE);
> > +}
> > +
> > +static int max31335_clkout_register(struct device *dev)
> > +{
> > +	struct max31335_data *max31335 =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (!device_property_present(dev, "#clock-cells"))
> > +		return 0;
>=20
> Is the clock output disabled by default?

No, I will disable it.

>=20
> > +
> > +static int max31335_probe(struct i2c_client *client)
> > +{
> > +	struct max31335_data *max31335;
> > +	struct device *hwmon;
> > +	int ret;
> > +
> > +	max31335 =3D devm_kzalloc(&client->dev, sizeof(*max31335),
> GFP_KERNEL);
> > +	if (!max31335)
> > +		return -ENOMEM;
> > +
> > +	max31335->regmap =3D devm_regmap_init_i2c(client,
> &regmap_config);
> > +	if (IS_ERR(max31335->regmap))
> > +		return PTR_ERR(max31335->regmap);
> > +
> > +	i2c_set_clientdata(client, max31335);
> > +
> > +	ret =3D regmap_write(max31335->regmap, MAX31335_RTC_RESET, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(max31335->regmap, MAX31335_RTC_RESET, 0);
> > +	if (ret)
> > +		return ret;
>=20
> What does this register do?
>=20

RTC Software Reset Register:=20
0x0: Device is in normal mode.
0x1: Resets the digital block and the I2C programmable registers except for
Timestamp/RAM registers and the SWRST bit. Oscillator is disabled.

The bit doesn't clear itself.

> > +
> > +	max31335->rtc =3D devm_rtc_allocate_device(&client->dev);
> > +	if (IS_ERR(max31335->rtc))
> > +		return PTR_ERR(max31335->rtc);
> > +
> > +	max31335->rtc->ops =3D &max31335_rtc_ops;
> > +	max31335->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> > +	max31335->rtc->range_max =3D RTC_TIMESTAMP_END_2199;
>=20
> Please set alarm_offset_max too.
>=20
> > +
> > +	ret =3D devm_rtc_register_device(max31335->rtc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D max31335_clkout_register(&client->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (client->irq > 0) {
> > +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> > +						NULL, max31335_handle_irq,
> > +						IRQF_ONESHOT,
> > +						"max31335", max31335);
> > +		if (ret) {
> > +			dev_warn(&client->dev,
> > +				 "unable to request IRQ, alarm max31335
> disabled\n");
> > +			client->irq =3D 0;
> > +		}
> > +	}
> > +
> > +	if (!client->irq)
> > +		clear_bit(RTC_FEATURE_ALARM, max31335->rtc->features);
> > +
> > +	max31335_nvmem_cfg.priv =3D max31335;
> > +	ret =3D devm_rtc_nvmem_register(max31335->rtc,
> &max31335_nvmem_cfg);
> > +	if (ret)
> > +		dev_err_probe(&client->dev, ret, "cannot register rtc
> nvmem\n");
> > +
> > +	hwmon =3D devm_hwmon_device_register_with_info(&client->dev,
> client->name,
> > +						     max31335,
> > +						     &max31335_chip_info,
> > +						     NULL);
> > +	if (IS_ERR(hwmon))
> > +		dev_err_probe(&client->dev, PTR_ERR(hwmon),
> > +			      "cannot register hwmon device\n");
> > +
> > +	return max31335_trickle_charger_setup(&client->dev, max31335);
>=20
> You must never fail probe after calling devm_rtc_register_device, else
> you are open to a race condition with userspace.
>=20
> > +}
> > +
> > +static const struct i2c_device_id max31335_id[] =3D {
> > +	{ "max31335", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, max31335_id);
> > +
> > +static const struct of_device_id max31335_of_match[] =3D {
> > +	{ .compatible =3D "adi,max31335" },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, max31335_of_match);
> > +
> > +static struct i2c_driver max31335_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "rtc-max31335",
> > +		.of_match_table =3D max31335_of_match,
> > +	},
> > +	.probe =3D max31335_probe,
> > +	.id_table =3D max31335_id,
> > +};
> > +module_i2c_driver(max31335_driver);
> > +
> > +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> > +MODULE_DESCRIPTION("MAX31335 RTC driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.42.0
> >
>=20
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://urldefense.com/v3/__https://bootlin.com__;!!A3Ni8CS0y2Y!9L5oCv
> HC0oT_FwMzkX2RA8fSIOBFPOxEQ_aycnNEcZqpwVS5HKLHl_s1Cji_iNKNHLFI
> Y37QpXsMZUPCyBmurhBxVvwaPVOU$
