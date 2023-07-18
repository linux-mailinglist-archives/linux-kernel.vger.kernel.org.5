Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9CD7583F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGRR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjGRR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:58:07 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B52DE8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:58:06 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IFW5PS022010;
        Tue, 18 Jul 2023 17:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=I7X5NeAfL1ta2j09Mm55hPE0Gczp9ofR0OlGx9XTii0=;
 b=JEnrhqeyp50nQ+DivNoOkVg9fo5zLiDaDuQn4qF4RrT3jlrxYhgtpKKVnyZzq1C8o6xS
 NTWXEXh54JZdkCvAmvu8rLypEBlisdAFP3r+FKvz4/RYC/2hl8Kf0Ona2AHO/6xH7ZQP
 W7rov97hmo/SG1+JrWG5saVSiF7mkKUM5jfsSWsV4PNEtZisArZCET4xq38ikZXaMTia
 fEAvf5lkLBw51L1S7IzkkIN67TziOVLu7KFV8yb4ev3v7sbiYvZy118icLZtlVbr2Czm
 XpRRSr8U0JN0LrKkp16aewcxkcSbd5Xol0/gHwKM3xfBOUr9WL8AA0o+ys1qLUs0fAZF kw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rwk2feas1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 17:56:16 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1C902D2E5;
        Tue, 18 Jul 2023 17:56:15 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Jul 2023 05:56:06 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 18 Jul 2023 05:56:06 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Jul 2023 05:56:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5QVAUAdFq6XpQu2fuI8cN2LmnO3XhwZaJORmSBAvM7QEDve07KfAnMVQAy4zr6SaRcUx6LVMH5IxkKO3hfmzT9HVPS4/D40froSBjewSamq653tnQy3aFIgZqOPQUkSYHKGLs9+o+3ZR9Or/E6/JDodxGJHg8ZzVSH2XjVPaxQLGGRFViaWlYrH/bujM/xBlICn+XuU7rW6hN75d6qEkVLZKYeFwhINOpaIx6o5Z0aWzOLkcexp2yDZy3DbWf5WmCYegEn+3A0dqIJ3mNkxPST8uzX4nDIR6H1ERrn4MPK01k9LLCmsxB/6pcFL/YxN+skVAGpMCWKGME3dUiR50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7X5NeAfL1ta2j09Mm55hPE0Gczp9ofR0OlGx9XTii0=;
 b=LWRkXWrh9Q7KL89jU/HAnwDJ+fPC6sjldAw3g/TQXeIBJudeWuCxzwvEggAiiD6L57f6B58LaDdwBsgxTXXU0o4XNLA19PXr4mIaAVNlsHvoiKcylYenBJI6LyXmUaDcZWcoxz7ZqNkfEfUtA3rADjbVsXW+8jJkYGTO5qj6eLyyjtVM9aBdg54oCLpxMthUi6cGArDsYHXMurTc5iCMsfaJJZITUpdXPvF1UiQk/NrQRlSQIEzClgg92KzCRkdvydytGRhM7uzvxiIDBbUeKhk76ELqZyUHeh2T69fJLKrbvlvs7/TYuM5dBDK3YTe8oeazy6QqfJWMZjvyoYlJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB3295.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 17:56:03 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 17:56:03 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Rob Herring <robh@kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: hpe: Drop unused includes
Thread-Topic: [PATCH] ARM: hpe: Drop unused includes
Thread-Index: AQHZuQK6pUIFVBCk0kS76NinQKQkNK+/z54Q
Date:   Tue, 18 Jul 2023 17:56:03 +0000
Message-ID: <DM4PR84MB19270BF24AF43CDB9F5082318838A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230717225630.3214590-1-robh@kernel.org>
In-Reply-To: <20230717225630.3214590-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB3295:EE_
x-ms-office365-filtering-correlation-id: f77b0ec2-e120-465a-351e-08db87b840a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9609VDtMrHBzd30oTepLuRm8QvuiJ5ijMwX6NayTyiHYjhLRrJyMzMKtdIKrQT++Tk9tEeXP6vq1/kpH1xOkup4tyr+syhVaCQR5ULbs/qjV8Bkgi4L25+UxwuR84nJQFT6l9HOwPa5jkV5mqkLHjqeBluF5KcJWIPDYqjCaSfjDoPVu7WzWRPBL9RzvReTahorShqxqqpJlb/kojEpfYbT5knORyJV1MLo3OHR863i/ppfiZsHmhb7bQd9iGAu4+IpyDffrzuw7QycSGmDhUmWu5uAvwN2TWt5j9EPJy090W08ubz6/MUm6oHnyoBCrNHdXHfKxXK4kspq22F3iW6sHQwrJ8PKtatCkz6V+TZnOoe4dMCYDlzv3+NWuxj5krJNToYRvHp2pcSrfcuWumRdGYvlYNQwinhbct4ijhs5JnaKrm+FOi8hd3Rb5DR7VgBFU/8QPtQZANAGaoNc7Uxt1u5xME4bLaQX+Viww/gbXw4taTnGfBk5EJGla5lEh/ZbASjBu9C8ydaokscOXm4zntFNiprg/30+0NBGg4Nw60Gef2m3hD8AcZxJ/ZR/c13nqTAe3Ae6Nw8rh8fD+WrYt/c8s5GzfGjhEmt5oz1iH0JLb5/RE3RcfUloGAySU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(55016003)(122000001)(110136005)(82960400001)(7696005)(54906003)(71200400001)(41300700001)(478600001)(8676002)(5660300002)(8936002)(66556008)(66446008)(64756008)(4326008)(66476007)(76116006)(316002)(66946007)(186003)(55236004)(9686003)(6506007)(26005)(52536014)(38100700002)(86362001)(33656002)(38070700005)(2906002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VvxFB0VRU4rj+FpDNVcgrElXBYooCMlyCgsxgggA+pM5fgH2gHf5AeMaZbsI?=
 =?us-ascii?Q?bESpRqKDDrqMejjFZwk3VLyNWXyroYFSswzPgtnhWGhqCc+QSNTFXI6DvGOj?=
 =?us-ascii?Q?lu+b1WAGXPdSxOPGW4ZS4ffklRVeKJNlSSsG9uRH01quwB8pKFX1QCF4Pxjh?=
 =?us-ascii?Q?kStIECgDfHFgxKb6ER8Sfcx/oYPgexry+rXV6G5PkxyMJPQY884AXENn1j6i?=
 =?us-ascii?Q?hW/iXozC9oFJGyVSsOhk/jL6UVJB8o9ZdLag1ecuLdmQI/fOr/zypzr8PCxc?=
 =?us-ascii?Q?eN9Dx+wFehrzW1KL+Gg9G3YSgLJnTMgNutyGA2SP3xR2w1CrrIWJAVa1qNx5?=
 =?us-ascii?Q?EM4xfxEN7MTpXK9XiCgzpv8rgnsxBB/wJw6zFI4kuwkF68GBWw53tgHLJmCR?=
 =?us-ascii?Q?eDm+XR9SHosssr2+If7N/MpWwAr40KL3bXMfx1ZnCYCB0pLF9rjVxblGEQqM?=
 =?us-ascii?Q?Ra+qELpfMFpNRkkIH9jmDVMzx0+Odkwry+GE0d2deDcGAeDzg5cQL7br6ObD?=
 =?us-ascii?Q?m0AaTFMLS9694DGEr4NiPHHibnT5xIanl0zCP4ICR/hwB7qLUjI27ipM3ZmS?=
 =?us-ascii?Q?Yt4agtuViLz4y39ME7RakO98V6lXqamXvGbJDnmHXZQi7w2AhPV/TkqvCCPh?=
 =?us-ascii?Q?/OIbfsNHwFT6T6wEwa8E82n5JYjF35EAF44sL8k6+H7W8tursqa7WDhOSRSI?=
 =?us-ascii?Q?1OHoJNYWM69VjQ/w2Hqm2bgssksR0QogermOKqHxl8zyN9Af45nTH1bvbhqg?=
 =?us-ascii?Q?rrCFVgcTAhhEY2V6xgkCB/2vE8iFKtQCpJGkMpMTO996dm2C3QtYoTDCjC0f?=
 =?us-ascii?Q?SMMGgdvogWKJV4PuMjuP41RIYQpAWLQKwVUo6WpV7cb3LVqvH8RDX+Dq51b+?=
 =?us-ascii?Q?bpQC/tr4YbBVylwHN8Nz3qAHUxZ0R43TdAsPBsbDukeLvh6fuoNVzkLFwJFf?=
 =?us-ascii?Q?A0d92HpkvarQY3XvgRVBUa+UTgbXIxAXJCzOD5xk6/XlTzguaVQVS+7645Ou?=
 =?us-ascii?Q?bHu+Zdc/qmuyseuJOiuPH24LffWDEAOGamIRhCF4WwzQLHzGiXLvcs35OAGN?=
 =?us-ascii?Q?PW4V49pF2DNT4JUJq0iq6euM9re0E0SnLSSej5GV/XKUZL7dUIYyi7Touumt?=
 =?us-ascii?Q?7NLm3kffPiN4QCrMSTGB58bk+P3ZKkIsxGpQAnTJ77z+EQErPFMlzMk9jpOI?=
 =?us-ascii?Q?xi8jjq4fg12+EiAnWXCgDQFIu+qa5BBls41P4hmk22cfLyTNLw3rYM3f4GN0?=
 =?us-ascii?Q?IEpL877TOm6/6TcpT5Zd8oTPTxdhKIpTvCDo98GgPiioQyGWkxppJLZBzuGz?=
 =?us-ascii?Q?nsLJv7vKnJ8qQz8pgftC/J/VSXiK3bjv0gwKL4lMXGmoSqcnnt/RY0lHgran?=
 =?us-ascii?Q?SGvNj8KOsOijsvrwj+W+W+egm9aouwgM95TegoHYAf+cSc0SFObzHYU7T2ey?=
 =?us-ascii?Q?ZlZ5RsC7LrZOKJflIdzVibOK8aME5pW3UhhGLD4OYZL/scZ0VTKAUxtPUnLP?=
 =?us-ascii?Q?x7pGjD+ml8k3ln5WTY9Af7CqQokglhp1MbtAO7Yc2h3oytHFQJvJETCf/704?=
 =?us-ascii?Q?aX4fZ2/i80VvQAYYEtoxzd3ZGnf9eZCXBiZ5UD3+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f77b0ec2-e120-465a-351e-08db87b840a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 17:56:03.1084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpcpAwMfVGASPxCmRrRN1IIt1Io/zcLwDejFGt08pm6rROQtcApRZ+cy97USU5V9n2YmOw3u/8LQusZP/W3nzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB3295
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: JQPqcPkYqwGYS95T1afwLYkC9IoCSEjo
X-Proofpoint-ORIG-GUID: JQPqcPkYqwGYS95T1afwLYkC9IoCSEjo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_13,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=601 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180163
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> of_platform.h is not needed, so drop it.

> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nick Hawkins <nick.hawkins@hpe.com>
