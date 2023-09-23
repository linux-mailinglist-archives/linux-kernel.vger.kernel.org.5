Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB1C7AC29D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjIWOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjIWOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:20:24 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875319A;
        Sat, 23 Sep 2023 07:20:18 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38NCSNtk027019;
        Sat, 23 Sep 2023 10:19:50 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t9sv4hq0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Sep 2023 10:19:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg8DA6zih02vyRUWtW0/sPvDNj+IP0NvE1Spf9gLhydvuUQ0blWolhnAQKjc9ZW5Md7uVacTdPUTMrUth9A57sUIoFvSQEyHatFYcqrJN2hIpl3EfySTIIs3Yo9fMMRhN0sV+mv//EEZ4uXStqtPs5YbcozP9IeVS2eChvjbYUFnuN/9wrHfsum7sq+2x26jjZme2QjBC0o+rlS/prXAGcLB5Frgd+o+rOWshdiMnqUfiqZpoDN1w1DOhFd6oNlHkDLGhxwxTvw3zEV7er9mHb6OCEkvz/qQECQpsWs8XfVT8HhtYJupdUQ3LmOmG+SdL/Y/4D8xJqN+JPtTuyyQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRPaXQGSCBQ8wHhkLq5orgD3PNtKE0kzl2q7BkRpJwU=;
 b=jtnS3iO6kJIq24ubc91KCa1FGmAZZBtxfcNRABBRjCRDUbDRtHOAU5X6Z5kHXJt8O+PRU1pZUBi56JMth0X4+ChFJMtdg7T4aN9RsSFUXg785ydFHnLS/Oz26NFKjmBv/rLz565ykkSMK7+Anr1oFwpIYSi7BYDmAljUqt+4jUsma/hGTblBRGhkuNyA9HunHt93Kkxw34lFQ+R0Bo9Xl8W/1bbLKN3BOBs7WodqviS4b+oTNoSKzCtcJdTX057dxqnz3TgQ56Z8qqaA/kwpOFwRFhFGKwBBOTHZVUCMmNLQ3W2pfk7yRpBg1ZDKmM/XG0sV0Hc6o4Vt3jb8kWmgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRPaXQGSCBQ8wHhkLq5orgD3PNtKE0kzl2q7BkRpJwU=;
 b=jIF5e3CiSF6mZMRzPnhts+uWVboK8sv8UB3VcBtXylBcXAVIqKLgysw/nlx929wtB3mFebGcoXkmRhU40TgCcFZS2J1BH8MvPPrlPjIgPcBx9SIL9ExVq2PitMKTO3zoS6hfM9IuZ8F/bO6MIK5NhLKW/yrAl2YC30YmcXdPLDk=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH0PR03MB5953.namprd03.prod.outlook.com (2603:10b6:610:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Sat, 23 Sep
 2023 14:19:46 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::ed02:8279:265d:e00f]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::ed02:8279:265d:e00f%3]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 14:19:46 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Matyas, Daniel" <Daniel.Matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: hwmon: max31827: use supply pin name
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: max31827: use supply pin name
Thread-Index: AQHZ7JbW8bVvOja/3EqvTv/jlHNtWLAnWa2AgAEcYAA=
Date:   Sat, 23 Sep 2023 14:19:45 +0000
Message-ID: <CY4PR03MB3399B818487F87D7297EC33F9BFEA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20230921142005.102263-1-antoniu.miclaus@analog.com>
 <20230922211201.GA3600661-robh@kernel.org>
In-Reply-To: <20230922211201.GA3600661-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0zZDkwNWY1ZC01YTFjLTExZWUtYWU1My00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcM2Q5MDVmNWUtNWExYy0xMWVlLWFlNTMtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIyNzU1IiB0PSIxMzMzOTk1MjM4NDY5?=
 =?us-ascii?Q?MDg5NjYiIGg9ImZ1QzRDOG1Ra29nVjEvcVZTU3J0QnVUSjdqWT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QW03QmtBS2U3WkFYS3kyZjRVa1p3RWNyTFovaFNSbkFRREFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH0PR03MB5953:EE_
x-ms-office365-filtering-correlation-id: c83a3c4f-313a-4db4-8a85-08dbbc402357
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IEXJcQ2fOM2+u77dCnNPEz+dKduyHfEmgeAFxJCW5k6NN0wdzbsJ0O1FBZXdk/vb1tkahsIXEu2TvszFLKgJOUxUCJ8QXSZWezSyaOdbNYmW1YALU7ATiVgIXI6NV5mRXyJiapq5D3iC4w9VmOxgp115UDbp3wQb/7AIssX/sHjMOIWkO05gmnVePEiyCxc6L+/CKp48OLQFNpSuZrGngq6TxHYmmOwqaVbmVK+kyC4y38YrmyyvhgDrq6XAlErsOWSOCSUQlMqnUe96cTPPBR+EhlV+5L7ANEihmp8afXQgGdbGTrWDY994Kx6WFqIgZwdbmN2yTUfkQVgisi14XEJlI9yPGU60jLF6QM+CxuDhWon3EbSxnw7iFyG5RdbamLPPr53+iKLJ5fwVGeNN/CZuSWK6+/knEABE5Q168C5zNSfK1Sad4LjrKx4bgTjTccAFL6w/JJjVRx2tm8IP+quh3GFyRK8OssPsea2SXT/HCXB5+ux3LZQPNGGbpc3xQxH4kMr1mVa1CRYOt6uOJnR+zEqI0abcbtMbulhIUsUbNbIsRMqtOWxFXNC0DUhycKatib+E7b0wiMrSZV7Cv3FOtmm2XbF68VC3bPlfrKmai/3uArOpKdtAPtICPi7Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(38100700002)(6506007)(7696005)(38070700005)(33656002)(86362001)(8936002)(8676002)(2906002)(4326008)(478600001)(83380400001)(9686003)(66446008)(71200400001)(52536014)(5660300002)(41300700001)(55016003)(122000001)(6916009)(76116006)(66476007)(66946007)(64756008)(66556008)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wMkRZ+TAbDIIfTZK+bbMgLyDNOGnMkDRbM4ku190aK65POPH/M9rm50KVWlp?=
 =?us-ascii?Q?Wi9IhL0ihCtjU9UW97tFPQQABp5a3j4pqjU68AukhIeB7bshbiOXacCgfxGn?=
 =?us-ascii?Q?/n9/tACVXhmjJuc9ajukJ9cTCzeF+HpcLPCVtXbaWigwGg5HOhqezXDNFoC/?=
 =?us-ascii?Q?RpE3iSECZ/uRAxqwCVnhxkBJ3MrCxrhKcPG1gR3UFAFmRKto/3GzbkbIcJsX?=
 =?us-ascii?Q?+LpX1sLTjW2cuyfluBvjpHsNlJNofWwy5bAChaTXr2AvpPHU7Xyj7kZoM6h9?=
 =?us-ascii?Q?5Ud8oXZ8tNTgHc88Pm79U/Wxy2OQJtORIu5ZwkiugEZhnQsT+Gc9sCTsDhoE?=
 =?us-ascii?Q?L2gaYp0ZmWChhvQIW5zYpqTVGrYWOie6bHpQ5B4nnEaALHbJ1IP+Th1DXtHx?=
 =?us-ascii?Q?rfX9JDNXHihUjcHUhlGP89ljQ2n/1f7mYvohwXlhrSp9sdM4+IodBk37dCdn?=
 =?us-ascii?Q?cDZr+Y5hR9MtOk4QlRwe0S2hhFFmPPkjlq5IAb6crlV21YcZWTZx8vW2Tise?=
 =?us-ascii?Q?eLC4fjUZEWxswqz5MQyQE4qCENZW0KX6LJrLARDK0ny7mj9Okt/ANZ6tWrJ7?=
 =?us-ascii?Q?7c/mYljG0ersDWGllfjxiqwMFJwYihou+39HaSE910Qt+p21LAfUTlislpIm?=
 =?us-ascii?Q?6xK3QwRi3AmemQ6yFq2Uhcb7PbBwUVU140bewnLbrTyK2zUCb6JJ77Urka6u?=
 =?us-ascii?Q?j1gi2BERM1CiyDD8et5RLfnqhVjy0Dd2aW37JUyUGGyM8+ezzWBKWcXOfVvH?=
 =?us-ascii?Q?SJIESNpOKjntLn9hkExMsfS9lldp/T7FvDHQ2DmAUutlN5RqRs5eTEHutf4H?=
 =?us-ascii?Q?slZtMY2zAlSpFog4k2KjIu1prA5OtRXbFtUGxFDbJ+3MzR2oevGtomFR5bRo?=
 =?us-ascii?Q?JqFhkG5DKvSIGnqxV37KhFqui8Dx+qeBDq5YMWa3ZdsDDDbv2EcEzahMI/76?=
 =?us-ascii?Q?klE6nztxgtJ8ni/sPAk119pQaA1OmZdy2pgtBc//YZmQXO738b3SETy0SLOL?=
 =?us-ascii?Q?edVWk+lHNzVZGtsFHf0YMee7uNWfc0S7bSu1hiMALJZVYYol29dtabiy5YqS?=
 =?us-ascii?Q?koYNEywH4u7Q+YltKqscJJvAZoTb28WfJ/5s02k0/m6gdG9m3E/Xv8hqPBs8?=
 =?us-ascii?Q?3YzbCgdlzNFcj/rsZntPVzMiHqKR8KKSvkM4FHQEz57Lt/R/z2ojc3i5Cp0d?=
 =?us-ascii?Q?+rHEjXiIMIL00fUZg6eM5sXoOAHy8UFI6MWEs+jSsXqUuvMOrdggtc/SF870?=
 =?us-ascii?Q?klbBoG+vM5g0cR+jMOsvZQhT3szHK/kGGoApSNvrUju10uhBcrqNV5mTAAUG?=
 =?us-ascii?Q?5KkinX+pZfePhQ9HKQNb3Q/9qwFVdUF6NRMjXz0LmHpAhK68XxN12PDche/b?=
 =?us-ascii?Q?okzTPytvYS0bLZJ2gq37mybtODXmY+z/RbNmzDgqEiFsWWvuOoU/02OQ/Nxk?=
 =?us-ascii?Q?TY6SWm1mab+o2KMlX/P9BOMgtXabhARWesUGKX6LwGXkaxhxpK/K32r95BT5?=
 =?us-ascii?Q?hUf6AeYz1mnBZXUmKIhYXN+eLiPcKKbiJdR46IpZxbkIpBgHll+K2R5JVjuc?=
 =?us-ascii?Q?BDYrpxlUrtEYw2zYnCXpQbcU5mN2+Tmgs2oiW7CbsJx8aU2hvkSOsiQ+sWmb?=
 =?us-ascii?Q?lEf9iF9ClaCAk/ahnqueZ7woeRtTDsENR3zTtXon+Gc3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83a3c4f-313a-4db4-8a85-08dbbc402357
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2023 14:19:45.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZoxgGKT5OaE2mibNyzlO8rlNxGS91b8kJ7iZobJklOMM5Puf0hd/zq6ywpzjZdQ6HLwSftLhBrXc3rS7Delw22Qk+9DTGt3HOPMwkLx4+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5953
X-Proofpoint-ORIG-GUID: TGC7QV6jlwMHs6QelDgeysT-UZWCg4Cn
X-Proofpoint-GUID: TGC7QV6jlwMHs6QelDgeysT-UZWCg4Cn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_12,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2309180000 definitions=main-2309230119
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Thu, Sep 21, 2023 at 05:20:03PM +0300, Antoniu Miclaus wrote:
> > The actual hardware pin name for the supply of max31827 is vdd.
> > Update the dt-binding to reflect the hardware properties accordingly.
>=20
> Changing this breaks the ABI. I see the old one wasn't used by the
> driver, but that's just one driver potentially. You need some
> justification here why it's okay to break the ABI.
>=20
As I mentioned also in the commit description, the supply should match the
actual hardware pin name. Otherwise it might create confusion. Usually vref
refers to an external voltage reference pin used for ADC/DACs which is not
exactly the case for this part, taking into account that there is no "refer=
ence"
word mentioned in the datasheet at all. VREF and VDD are usually separate
hardware pins. There is a hint indeed in the dts example that the vref-supp=
ly=20
might be referenced to a vdd regulator node, but from my point of view
that is not enough. Moreover the current vref-supply is not handled at all =
in
the driver, it is only mentioned in the dt-binding (That's why I added a se=
cond
patch in the series handling the supply).

If the justification is not enough to apply this change, then I can keep on=
ly the
second patch, which handles the regulator in the driver and use the  old `v=
ref`
naming which currently appears only in the dt-binding.

Antoniu
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  Documentation/devicetree/bindings/hwmon/adi,max31827.yaml | 6 +++--
> -
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git
> a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > index 2dc8b07b4d3b..21f2d350373b 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> > @@ -27,7 +27,7 @@ properties:
> >    reg:
> >      maxItems: 1
> >
> > -  vref-supply:
> > +  vdd-supply:
> >      description:
> >        Must have values in the interval (1.6V; 3.6V) in order for the d=
evice to
> >        function correctly.
> > @@ -35,7 +35,7 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - vref-supply
> > +  - vdd-supply
> >
> >  additionalProperties: false
> >
> > @@ -48,7 +48,7 @@ examples:
> >          temperature-sensor@42 {
> >              compatible =3D "adi,max31827";
> >              reg =3D <0x42>;
> > -            vref-supply =3D <&reg_vdd>;
> > +            vdd-supply =3D <&reg_vdd>;
> >          };
> >      };
> >  ...
> > --
> > 2.42.0
> >
