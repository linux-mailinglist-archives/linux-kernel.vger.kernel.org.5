Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5AB7DD05C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbjJaPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbjJaPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:19:50 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CFD171E;
        Tue, 31 Oct 2023 08:17:37 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39VF7tBe008084;
        Tue, 31 Oct 2023 11:16:40 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3u32ynrruy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 11:16:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcO/q4vAe8ZgczZRsjlW9Su5osSo8j4rTw2CmQ9cv4b1Us1wplWApR/S0arA+8CLguggF2TFkrPZ8EREJWAhuMQX9HbdlCrpXIzfCI4ZIhNgdPVfZBXlShH9mfN9GS2L9zU1slMF3wupZdtqlBcEnKAZ2hxBFT6ostsB43W9UeGV2+L12qHQtrAs5q6rsHDEQdyArP41/LZfHUnEebAGF8xDFNPeaMLPfvMxz1gao4HP9O9BQ+ejoq6Z71A5eAcrtE35I8jEDIEY8E0dOzHa0HXni+oZ2iQrjhRkWMpqbxWq1GHaxLa/6vwdcdai/aYLuGiPe17JWJ0dGqtyyCPSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4GDdVIrsH2XD6TgtlghAl34yHWNinJ/1RaQrYPpGgs=;
 b=NjBmYzp8YZ3fCW35mIa/sqNEbFspEkoE7P98i3mMzJbxZl8cjCjBDjusz15lmeE+ZvWQmbMKAFaZWS0Y/j9Oc27gDq9aEFbNmLz7GGB5D2KLIxCfErqRck/UOdS1/aZ40C42X2YGGLtg14GZ94QlNqBbSTjoPfM5n/fgH3ZMDFmusPDIlx3y+uFUpn7qT80xrsyAW7ZMDoe5c9ReGHXJKiKMwn5+NG+M1g6oJ/LWWmBo7nDu/TQpOBU9zoPSqHZaQFPwWgmvg82WhSh02NrZeVO8q2a/OcvUcECecLiOltj6RNkBOsaqnIcrt5yVcrph6F8rrErM4c5rW82i4sm8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4GDdVIrsH2XD6TgtlghAl34yHWNinJ/1RaQrYPpGgs=;
 b=Gyh0cjq8dSaRSDIDbx7EOiJRgsYram+Hs4AVVMLFKU2ZG1P7AD4uzKgAk0t4t9KFGpiOlUcSSJ5MSse6HxJFJXfoGNt4Aoky1b6jpwdD8N95/DfbaLHeVFkNQtK2zr8rQHej6LyM3B+f/Uv3uLNuZEjFjLjOK5YO7oBEffkZ6Ps=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SN4PR03MB6750.namprd03.prod.outlook.com (2603:10b6:806:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Tue, 31 Oct
 2023 14:43:24 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::26c3:a563:9b0a:3321%3]) with mapi id 15.20.6954.014; Tue, 31 Oct 2023
 14:43:24 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH 2/2] drivers: rtc: max31335: initial commit
Thread-Topic: [PATCH 2/2] drivers: rtc: max31335: initial commit
Thread-Index: AQHaCyeLjVRbnUBr8Uu9pZ9Nut/xb7BioqKAgAEesVCAACvqAIAADU+A
Date:   Tue, 31 Oct 2023 14:43:24 +0000
Message-ID: <CY4PR03MB3399C30F209B2061EFC804C49BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20231030115016.97823-1-antoniu.miclaus@analog.com>
 <20231030115016.97823-3-antoniu.miclaus@analog.com>
 <ce07d951-f492-4137-9588-1d55001e0003@roeck-us.net>
 <CY4PR03MB339979DBB7ADBFC3872156019BA0A@CY4PR03MB3399.namprd03.prod.outlook.com>
 <202310311354329a21a9d0@mail.local>
In-Reply-To: <202310311354329a21a9d0@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1kNWMwMDg1NS03N2ZiLTExZWUtYWU3OC1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcZDVjMDA4NTctNzdmYi0xMWVlLWFlNzgtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIxMzA4IiB0PSIxMzM0MzIzNzAwMTE5?=
 =?us-ascii?Q?MzQwMTUiIGg9InZiSFh3cEFCOHY5anRDRVlEanZxVmQzUUNFYz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QS9qUm1ZQ0F6YUFVbVhSeXVpZzBOWFNaZEhLNktEUTFjREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRU9wbE9nQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SN4PR03MB6750:EE_
x-ms-office365-filtering-correlation-id: dca74c4a-c3c4-42a5-6159-08dbda1fbc9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNP2J09SjabhgyOac9JA9uVsMLYmpwwMerT6Lisx73IA5jbL4Cw7bX/s1NHC2Ct7EN7JuioI1XGUwxONJcuIbD2juD8F8NLDMDP4tpPxkoicFPQ1suBTXs/GZ0/tlTK3G5syQSGWND+/wnV5Hv6GicJThhFHcLRlcTUPIH+qWpZpIQIyq5BNdqIBRBKZWjs+vQECWUzd7h5G2vG0aHIL9fzxq17eZdv0uloVRD8Yry2yrk2s0LZkyLEIAgknalJ5WzN7GAj4Rz4Dh/lkTfWFzN9O9o/BEqz/HxX5ExsvIWA55/LdOZO5jbITc7RYk9hO7J/ehZQli2biW4ehwSWdFA1KlPu/Ewum21D2LgaOrzN04MD8nTVoKKJOO9rQZbZfMBFFm4Fi1DHpE2wznFpTsuAEMJRY8lVNTaSyzR4+y530fps5pNYVqC+zEhiRjLCqChRp7pRNOqYj1+SQOU8wFSGlUO8A3z4sc8aqRqaShgTOW1/lCfB3vg9Rj+W9HQnpReykp0Z8JxaME3aODFg0/yW1rKhOypTEyuAAj2qzJrOeYLf/457OqtF4NWnPa10x9IhtYYZNbSVjvtc9n5iCB72uAT0F8I6WGmMHwyXpjgw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(122000001)(38070700009)(7696005)(966005)(478600001)(9686003)(66446008)(4326008)(8676002)(66556008)(54906003)(64756008)(66476007)(76116006)(66946007)(8936002)(6916009)(6506007)(316002)(52536014)(7416002)(2906002)(5660300002)(41300700001)(83380400001)(71200400001)(26005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q7HAkNgSjMKaNmRpWaEGiPaL2T7vJc2KA1ewk8foXkDzK+qkHRG5kOBgw+X7?=
 =?us-ascii?Q?UIh0I9a2T+cv1T8ThhhEGKCPUzTj9cY/fUKxB9AMoSNPc3IUgnB7sFu2mnlR?=
 =?us-ascii?Q?a+Zvx8wupdMgdcaId7chKSLiBghzaByVB2R3DWX72sX/NguLih8aP2tiXCJW?=
 =?us-ascii?Q?ErhDw04grrT2xVLWyfHhCVxjAVTw5Vtww7cJBRoEPKtDdkQUe0tQ1Vlc381z?=
 =?us-ascii?Q?mHk+/VfQJEsoeUebo5YV4Y/I8DbMuwVpVGvEGFow+fpzdA+nKsD+pUgjaHxJ?=
 =?us-ascii?Q?vLPE81eASUepj0Nzz/hnvvZF3Eup59tT6XB5y2hdDA5KpWztdZDXrDuof94L?=
 =?us-ascii?Q?jhMfZnYX9DV20tq2ip1FH+tp3frTKtb9G3LYyT26TBC3Rk2vF62dc2InU1DT?=
 =?us-ascii?Q?oHdjREnERF9O1CMzEDKEreGVID3/n78M/gCu0tPosJLQ56SkLin+5eHNGoyF?=
 =?us-ascii?Q?098zui+EZ+2yXCnHApVA0A+6g7YMbUrU3KGQD+P6RuCVpQ21QGv/z2TuiRss?=
 =?us-ascii?Q?SHQziC41ubOVpi/1NKF9M8auApnUafyOTj/cqPsLwvREUgKiFENiw/hnVUCX?=
 =?us-ascii?Q?dX9xVDaUaZR9OR3YSmTd2wkIBIQFrfdf15r+Z3F3bGr2Gxk02wqT1l4wwDNi?=
 =?us-ascii?Q?6FfBFEpIIJJwESQhVUDtMlFh4CaYEPJTvqIAlg7Fvd5C752WEcgQmlqbDB5G?=
 =?us-ascii?Q?tPb27QZBl0HV7Ch1MwMPZSFafzf6gdhI3TnDZIhYOigL3Nroo/SE4ihG6vD7?=
 =?us-ascii?Q?ccFNRO4f2SFR25csbLStoG7O6vFpn/ykVdqgSr6vRnZV57/x2TCBXx5lnXyN?=
 =?us-ascii?Q?ZIKElBpWHha+Fgp21saXEqaT9KxWtGwCoUOPn4thiCOGOzqKmfmqd/zXeEos?=
 =?us-ascii?Q?LhGhMzzcHH/VnfcsE3rPgGl5TH0kOoksLGA80l5lOaV6NqUZULVjnW0iGp/H?=
 =?us-ascii?Q?whkHC9NzSDiEtCRcOpHfFlW95/vfMnP134W0UgzEycvk6NnHSWQOwjodeTM8?=
 =?us-ascii?Q?9fK7iOOrUsTtEQcJf+VaxZOzF2E18YgwsCJKzTeJt8Q6NVrBUvAWfSaln+jP?=
 =?us-ascii?Q?Aw+u3FRkozq4FBum7tBRRcHcKTg+UmWw4A19z9vjQ8k1sE6MFt4UgmTWrAV6?=
 =?us-ascii?Q?l34Y14q7QYxyLX5vMLB6syPWAxMNUBOMz7BSZ6qWj6+dWOvyWttGqHI7LsKA?=
 =?us-ascii?Q?jh0n1tt0px2lV254nU5Lao8DZbMIyRfNOUFiGdTH+EDUOMho/rHXICD5vzzM?=
 =?us-ascii?Q?jKKSDgCBPHRTvutcs+ZrybE2Xh61t6ccTjBznzkKmDFAq5wcIBw69CAFgsHZ?=
 =?us-ascii?Q?2xRR1FgKxOMHykEIfkhhKRa+1hJaLs6Gt+DW/Wvok94Q4A2niIpdQRUzO+ET?=
 =?us-ascii?Q?bLyqED91fweaUgqYkJEJUEBa9EJOlYGgoUzhClJ1rkeL0Y572tk77nUa8/WE?=
 =?us-ascii?Q?A3cpD0H0D+jMnNF5eogorH9wP5yXfxVSHwk/GTcjYUtWosJJbKWm2ewMQVGC?=
 =?us-ascii?Q?Oe/aIkPWn8GyyuJsFS2ZKPwfuog5Xtz6vRSgDYLFpOKM0UAU8YYitZ2bTh+y?=
 =?us-ascii?Q?MKf0fmay4lzc8GNhuFxVuRVQPYue8dw5Py4W3OWIwdOaSo3YBwMZGLmp0HVP?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca74c4a-c3c4-42a5-6159-08dbda1fbc9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 14:43:24.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pd0lX3yz/i1ugxMtuL4CSdbC1rLEkEKpaqHRNMDlzt65qJruBlJcuJ+0UzbS1f118QYDUBq7Eb0XG5W/Es0HuaY5/Vwpc975S2+x5+iVZog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6750
X-Proofpoint-GUID: eO4ssr_kcYR3acBc0e-FLF_H2ZOiMWp0
X-Proofpoint-ORIG-GUID: eO4ssr_kcYR3acBc0e-FLF_H2ZOiMWp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 31/10/2023 11:23:49+0000, Miclaus, Antoniu wrote:
> > > > +	if (status !=3D MAX31335_STATUS1_DEFAULT)
> > > > +		dev_err_probe(&client->dev, -EINVAL,
> > > > +			      "Unable to read from device.\n");
> > > > +
> > >
> > > That is misleading. The device returned an unexpected status.
> > > I don't know if this really reflects a problem, but it is not
> > > "Unable to read from device".
> > >
> >
> > Since the device lacks an ID register, I found this as a suitable
> > replacement for checking that the communication with the
> > device actually works before the probe function finishes
> > successfully.
> >
> > I will be more specific in the dev_err_probe message in the
> > upcoming patch version.
> >
>=20
> What if this is a transient bus error and the device is actually present
> and working?
>  don't like this kind of check, they are not usually useful.
>=20

Got it. Will drop the check in the next patch version.

> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://urldefense.com/v3/__https://bootlin.com__;!!A3Ni8CS0y2Y!9HB62f
> 1sSispWlqUtpamRif0eXxFGCqLzQD3KSwVl9t97YNev9s6akJCbWJ71dcIettiLkqz
> xyFpR_e8H_tCWl82OcBdHjBG$
