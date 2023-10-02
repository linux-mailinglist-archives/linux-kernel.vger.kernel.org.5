Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829407B5BEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJBUXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:23:51 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5FB7;
        Mon,  2 Oct 2023 13:23:47 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 392IRgL2030101;
        Mon, 2 Oct 2023 16:23:39 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3tfpccc705-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Oct 2023 16:23:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apcvwC/+miDW5H7x7M5YYIi8cxIxmuk8m6sLwiMK8DbjjP3Cwcjjlu8dP90FIsKFW4XKX89SKcCzURAQv9Q82nQLI2pnOojyEVyvAVjGwCAzUvnIQm2GDYDa7/nGgNq8XZ6WDnbOFh7It/vkGrpRPUcwLfhI/+UZj3+fvG3FkthNDLj/Z7SbgF/z1VrgTq2MIiKXcvWCnItEeyNVJPXO+jC2MfbAscCNAHHJvFLHagRc47NPk+fVT6mj5UiNG0lKNd2JP8UmnYsjrw/8BXHgp2mrMjqhHSgEBBkBOlprxMmRQe7NXQxfoPXi9sen1sU7akRra3XA8yIGBOfWN4UeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfnsJ2UOCuutYORiKgssUQ8dkoSHDXaCvLmkNfdcwL4=;
 b=aWh65WKB30pJJaNmFcoWbLuOmkuhEhdvBd0dHqnt4Wdth/ZVGwHSFyPLpWkleTw3I0XNy+mZnzi20XdceZufSn/0rlar0uBMm/xftzZHDnrxvKQrEH9dC07aMG6OZ7ZtYa+ChXld2JOxYL3lZNSuxk0CZtyqx+Lh9WnWCLgfgBgihnQ6L+rR+5dQ5o5poMGCfnEnJctw7kXFAfW71YJGZW/5qjJFObOrqExv5v8PIwapPMi6JAhndiQdAr087wLj+XHzbzqwyxtWCb9JcXhiGlqOyH8btnW5CeKZ3L5YbdIXxP8ZN+w/Tr+vV7H70nrqSe/3ywkx/1C8zEFYWS2HDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfnsJ2UOCuutYORiKgssUQ8dkoSHDXaCvLmkNfdcwL4=;
 b=HYwFREISvqFp+J6TUboYc+8v7RkZ0xpVhLLYkv9Qx9hl98yuj7kEDNJVLYo1meJ/xYokJIvzW6DXYXTrz06+BwAj4mGTK9YrUYPeNDuoYyKQlTeHnlSxJ3IZAD7NiZvrjx4DKSQEmKzsuGxyKA89E2INs10aKDhz2b9fkKcee2Y=
Received: from BN7PR03MB4545.namprd03.prod.outlook.com (2603:10b6:408:e::31)
 by DS7PR03MB5509.namprd03.prod.outlook.com (2603:10b6:5:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 20:23:35 +0000
Received: from BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81]) by BN7PR03MB4545.namprd03.prod.outlook.com
 ([fe80::e1d5:636a:bda7:1c81%2]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 20:23:35 +0000
From:   "Balas, Eliza" <Eliza.Balas@analog.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Topic: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Thread-Index: AQHZ8e6/zUxp0vYDHECkHhwPalTB6rA2uEYAgAABCqCAAC37AIAAA+iAgAAI/ACAAALAMA==
Date:   Mon, 2 Oct 2023 20:23:35 +0000
Message-ID: <BN7PR03MB4545715CBC44232EEA81FF7697C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-2-eliza.balas@analog.com>
 <20231002163244.GA1886905-robh@kernel.org>
 <BN7PR03MB454508AF350D2DC96FE1743A97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <20231002-aggregate-scanner-3ca2ae69cf0c@spud>
 <BN7PR03MB4545090CC2F859333E9C3AB297C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <20231002-carnivore-clapped-33140a07ff67@spud>
In-Reply-To: <20231002-carnivore-clapped-33140a07ff67@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZWJhbGFzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOGRmZjgzMWUtNjE2MS0xMWVlLThkYjMtNzQwNGYx?=
 =?us-ascii?Q?NTcwNWY3XGFtZS10ZXN0XDhkZmY4MzFmLTYxNjEtMTFlZS04ZGIzLTc0MDRm?=
 =?us-ascii?Q?MTU3MDVmN2JvZHkudHh0IiBzej0iMTYxOTgiIHQ9IjEzMzQwNzUxODEyOTc2?=
 =?us-ascii?Q?OTM1MCIgaD0ibk04Qi9CUkxZVFRjbG5TQ0RZUC9OMm1DR2g0PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFD?=
 =?us-ascii?Q?R3kzMVFidlhaQVg4eHJRKzJHd0VuZnpHdEQ3WWJBU2NEQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFsR1RHVmdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFR?=
 =?us-ascii?Q?QmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4?=
 =?us-ascii?Q?QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFC?=
 =?us-ascii?Q?eUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0?=
 =?us-ascii?Q?YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4545:EE_|DS7PR03MB5509:EE_
x-ms-office365-filtering-correlation-id: 6634390d-855d-4ed3-35ff-08dbc3857492
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jk0S8iO5ENAx9mUZozSlbcyLYvI42PLCegu9v5nAlJXfrUwLFdYJTO8PClxQVytvOGoWsGVwCXOtW4YaVT4gbCUzx2WoYF1Z4FipAjBg8D86V88AqZTkjD/6iYOYOKT6paFozqBlMVHJaAl4Uc/UV4rCOycGvhveOxs5/cUeG2nNtc2fifgYBg7pDZluOFFG1D402Z5Y0oXmtz2NRfSKcZiLRDgVEZZ8X/NlR3s3ggeR4cizSUyqnmRwc9ySQ7EEVDfzrghF9gB2jIX+8D5zHeqxm18paVMITbtVckHek8AOU928adzy+AO3h+osREk571yYspjJwC/AuH5PnIPPFBsEmUc4Q092AwAxkX63KYdrVTDFnOMQVe7iDUTfGWdbheczrEMSA7/0EFCDdMwhBeqHieFuVOHjkDWkI6i/0QWI/X6QVMK77Gpty+EdWqCvvaLs9xYYOnMH6yGxq0IVwNXD0NxH+jOmJXQ8L6Y2MzRyHQBZnDHQ/kxob0/EXliEK32TBlNqQP7JJ2XKrwfAUBH/wKHUHKtA/+5zwxaSphtV5zsdtVcHelnWfONJcRwax6DOT+KCVZuFozgaMAPLmfTIZAbe7AwAdlRsjAPT3Xi1lxuSaNiDFpOtM0VHUs1iKEfwVxSafmp6A76jGDlHzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4545.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(52536014)(7696005)(5660300002)(8936002)(2906002)(6916009)(8676002)(7416002)(6506007)(41300700001)(64756008)(76116006)(9686003)(478600001)(66476007)(966005)(66946007)(316002)(66446008)(4326008)(66556008)(53546011)(54906003)(71200400001)(26005)(83380400001)(38070700005)(38100700002)(86362001)(33656002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wULEzZeFloAd8j5fRbcXTzWszlQKNCKs8S6OktvxSj/oROjohy+nig9PONNd?=
 =?us-ascii?Q?G92bnm18268rXvZI0EHQreDt0OxGFFcDQ0thrqeoAUo4c8YZQzDI1ysHYEIv?=
 =?us-ascii?Q?pRYYacawfN8Zx46aSy9zNLFx5nW7XipCGYchmCE0LLzGH3v00SteOaUSS7nN?=
 =?us-ascii?Q?SjaC/uY6hC2YuILSAvPbbtOC1ZOBh9PPpBG8j5bugSGSvXnbnVoH/QJZ7v9P?=
 =?us-ascii?Q?edxDGHaRVy5TC+mgNmCuWbB8bGEnWrfGLiBofY7n23Tua9905wksnylbkf8g?=
 =?us-ascii?Q?N7B477stLxC06eTkskJWwn+n44WB//NEGgJx3lcl0hm3kxN8xGX/xiA1NYcl?=
 =?us-ascii?Q?Sny0alXsSAXXfvpaYmFNUsn/zd9LCi2YwsNlBT72LoYgyl5imZORj+0gO4uu?=
 =?us-ascii?Q?oifnMUwjXT6ZysEiR+ct1XsOPf1ZmBXdV3fhMMOsGTPUx/y5V0ho9i7Emrms?=
 =?us-ascii?Q?MlDk2zHe1B/IDbK5GGl9rPmjvv78R89PlYOz0Y1ncgnOZ6mqy4dH9yYVqgQq?=
 =?us-ascii?Q?/rgdruaoaES5oijX7EBiF5i5IjlMDKV/7kSa002mdA0Fy3IrgNuKWI9WrBN7?=
 =?us-ascii?Q?trswxHLj1XVOiy6yejAcnRBZITftfTM3088jnlro9mEPXuxbkXNk1eZtqfCQ?=
 =?us-ascii?Q?Qojkxm8B7DL8JLl1et3P6/zZ2pHS08L5eLvFs81iU/FT0coYNVLaSXa6EwH9?=
 =?us-ascii?Q?0XleLhsdIGZk+VkWjpLBoucmGhE8lPGcvf6aQafR/mz1yrMuM8nvlARDrhlz?=
 =?us-ascii?Q?GIkHiAp8B65Z3JJ6pz39vwZo8DikLlSANdpTgBxu7aJACp7BI9oQkF4/ljrO?=
 =?us-ascii?Q?CC4qKHlt9tXwPkFr+Pj7aA1lm22FtWPgGru+pLcSFWn18TLVPpESKwv5Q99e?=
 =?us-ascii?Q?8hTdQExqlzdv8UR1IlKXC+FsNzu5kSCdzEJi72E68NPsRu2TDNMsZ2goImmh?=
 =?us-ascii?Q?QTMIM6uS2LiOxHFULoHZ36VpnxlDfnjEtd8Hd2xLg7nRvvQsMtPHNFj4XfFB?=
 =?us-ascii?Q?mIj40m1RviWphZ/JU+oWR5T6iKVQ9eXgkspGzmq6weSTOLGQ+v3MIDmeQi/L?=
 =?us-ascii?Q?TMsRAR2NmIrG+0KraewF9u7jJoR5suVJm8dceLjZOwrsX9yaVoAvI+26acxM?=
 =?us-ascii?Q?mseIyjOcQdeKEqETq8N/TH+GHmiCADnz1MN5EpHC/UaS3YPXpytW6VOMpyH7?=
 =?us-ascii?Q?kYLa+sH0DGgRCucq/H+dWz+nuax5AAZsedk+ktwTitRQIfHaP7PuirShMVEq?=
 =?us-ascii?Q?/+OrTUFZwWWpO8xStFO8z1jaT1OTHOzRkkxCuJbbyf7GPNMcLVRe1oojOY+i?=
 =?us-ascii?Q?acJShTGWhlpilS0d9MHWtyvvWFXC/3xAEytJ9piOQalyM9gYDKivlgy4atnz?=
 =?us-ascii?Q?qmxqlxRGogAh4WnxAfqaRb9X9iAvXDrVE0hUYcDs2piBDrfOuREUWwYhrObD?=
 =?us-ascii?Q?OjaXym1u+UN9TX82RLrbfD/WeK659fVTe1R8arr1KOhKEoootce8xq7s1H1F?=
 =?us-ascii?Q?Xi2Fp8vct4xGixDafSGuzZm3jmHlDgxJkzT2ugPRLNbNW/AWHxo4wBbLbcqm?=
 =?us-ascii?Q?QrTq8CiyJlzIqU512htJnqMtYonFWAItkJnjgk1/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4545.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6634390d-855d-4ed3-35ff-08dbc3857492
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 20:23:35.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcNRAN7diml6euYAjf5KoJmEesK54MigcbiW28Q1ciOJFME9/wYv3V1n8C7WSDhrmJ84181zyN3HedJxr3HFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5509
X-Proofpoint-GUID: zFGki6lHDycCWqKdi88wLAcTcOaI9eFj
X-Proofpoint-ORIG-GUID: zFGki6lHDycCWqKdi88wLAcTcOaI9eFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_15,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2310020157
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, October 2, 2023 23:07
> To: Balas, Eliza <Eliza.Balas@analog.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.kozlows=
ki+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Derek Kiernan <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.c=
om>; Arnd Bergmann <arnd@arndb.de>; Greg
> Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;=
 devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tr=
ee binding for TDD engine
>=20
> [External]
>=20
> On Mon, Oct 02, 2023 at 07:48:42PM +0000, Balas, Eliza wrote:
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Monday, October 2, 2023 22:21
> > > To: Balas, Eliza <Eliza.Balas@analog.com>
> > > Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzysztof.koz=
lowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>;
> > > Derek Kiernan <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@a=
md.com>; Arnd Bergmann <arnd@arndb.de>; Greg
> > > Kroah-Hartman <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.=
org; devicetree@vger.kernel.org
> > > Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add devic=
e-tree binding for TDD engine
> > >
> > > [External]
> > >
> > > On Mon, Oct 02, 2023 at 04:46:26PM +0000, Balas, Eliza wrote:
> > > > > -----Original Message-----
> > > > > From: Rob Herring <robh@kernel.org>
> > > > > Sent: Monday, October 2, 2023 19:33
> > > > > To: Balas, Eliza <Eliza.Balas@analog.com>
> > > > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Cono=
r Dooley <conor+dt@kernel.org>; Derek Kiernan
> > > > > <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.com>; A=
rnd Bergmann <arnd@arndb.de>; Greg Kroah-
> Hartman
> > > > > <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; devic=
etree@vger.kernel.org
> > > > > Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add d=
evice-tree binding for TDD engine
> > > > >
> > > > > [External]
> > > > >
> > > > > On Thu, Sep 28, 2023 at 12:28:03PM +0300, Eliza Balas wrote:
> > > > > > Add device tree documentation for the AXI TDD Core.
> > > > > > The generic TDD controller is in essence a waveform generator
> > > > > > capable of addressing RF applications which require Time Divisi=
on
> > > > > > Duplexing, as well as controlling other modules of general
> > > > > > applications through its dedicated 32 channel outputs.
> > > > > >
> > > > > > The reason of creating the generic TDD controller was to reduce
> > > > > > the naming confusion around the existing repurposed TDD core
> > > > > > built for AD9361, as well as expanding its number of output
> > > > > > channels for systems which require more than six controlling si=
gnals.
> > > > > >
> > > > > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++=
++++++++
> > > > > >  MAINTAINERS                                   |  7 ++
> > > > > >  2 files changed, 72 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/misc/adi,=
axi-tdd.yaml
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd=
.yaml b/Documentation/devicetree/bindings/misc/adi,axi-
> > > tdd.yaml
> > > > > > new file mode 100644
> > > > > > index 000000000000..8938da801b95
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > > > > @@ -0,0 +1,65 @@
> > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > +# Copyright 2023 Analog Devices Inc.
> > > > > > +%YAML 1.2
> > > > > > +---
> > > > > > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas=
/misc/adi,axi-
> > > > > tdd.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS9=
J1yt0xgjp9g3Y1N5PbZ7pAcIkKU4WPbS_TR9yjTKw$
> > > > > > +$schema: https://urldefense.com/v3/__http://devicetree.org/met=
a-
> > > > >
> > >
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS=
9J1yt0xgjp9g3Y1N5PbZ7pAcIkKU4WPbS_RK8aQ9xw$
> > > > > > +
> > > > > > +title: Analog Devices AXI TDD Core
> > > > > > +
> > > > > > +maintainers:
> > > > > > +  - Eliza Balas <eliza.balas@analog.com>
> > > > > > +
> > > > > > +description: |
> > > > > > +  The TDD controller is a waveform generator capable of addres=
sing RF
> > > > > > +  applications which require Time Division Duplexing, as well =
as controlling
> > > > > > +  other modules of general applications through its dedicated =
32 channel
> > > > > > +  outputs. It solves the synchronization issue when transmitti=
ng and receiving
> > > > > > +  multiple frames of data through multiple buffers.
> > > > > > +  The TDD IP core is part of the Analog Devices hdl reference =
designs and has
> > > > > > +  the following features:
> > > > > > +    * Up to 32 independent output channels
> > > > > > +    * Start/stop time values per channel
> > > > > > +    * Enable and polarity bit values per channel
> > > > > > +    * 32 bit-max internal reference counter
> > > > > > +    * Initial startup delay before waveform generation
> > > > > > +    * Configurable frame length and number of frames per burst
> > > > > > +    * 3 sources of synchronization: external, internal and sof=
tware generated
> > > > > > +  For more information see the wiki:
> > > > > > +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> > > > > > +
> > > > > > +properties:
> > > > > > +  compatible:
> > > > > > +    enum:
> > > > > > +      - adi,axi-tdd-2.00.a
> > > > >
> > > > > Where does this version number come from? I looked at the above l=
ink and
> > > > > see versions such as '2021_R2', '2019_r2', etc. I didn't dig deep=
er
> > > > > whether there's some per IP version.
> > > > >
> > > > > If you want to use version numbers, please document the versionin=
g
> > > > > scheme. For example, see
> > > > > Documentation/devicetree/bindings/sifive/sifive-blocks-ip-version=
ing.txt.
> > > > >
> > > > > Rob
> > > >
> > > > The version refers to the IP version. The version of the IP is also
> > > > specified in its VERSION register (there is a drop down to expand t=
he
> > > > register map on the wiki page) which is verified by the driver duri=
ng
> > > > probe. "2021_R2" refers to the compatible tool version used for
> > > > creating the FPGAIP Core.
> > >
> > > If you have version registers in these IPs, what benefit does version
> > > numbers in the compatible string bring?
> > > Rather than using the version numbers to validate what the DT gave yo=
u,
> > > which not the kernel's job IMO, why not just use the information from
> > > the register to determine the version?
> > >
> > > Cheers,
> > > Conor.
> >
> > As the description of this patch says, we want to resolve the naming co=
nfusion around the existing repurposed TDD core
> (https://wiki.analog.com/resources/eval/user-guides/ad-pzsdr2400tdd-eb/re=
ference_hdl#tdd_controller)
> > built for AD9361 and this TDD Engine IP core (https://wiki.analog.com/r=
esources/fpga/docs/axi_tdd) which is a similar core, with
> more output channels and some extra features. The version numbers in the =
compatible string are used to differentiate between the
> two IPs.
>=20
> Firstly, please fix your mail client to wrap text at a sane width :)
> Secondly, where is the binding for that TDD ad9361 specific core that
> calling this generic one "adi,axi-tdd" would conflict with?
> Grepping the bindings directory of the kernel tree for "adi.*tdd" returns
> nothing. If there is an ad9361 specific tdd, I would expect it to have a
> compatible like "adi,ad9361-tdd".

We didn't upstream the ad9361 tdd driver, but we are using it
in our internal kernel. If this is an issue, I will change the=20
compatible string to "adi,axi-tdd".

