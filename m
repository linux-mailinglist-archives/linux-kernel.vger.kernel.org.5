Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972477FE76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354669AbjHQTVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354687AbjHQTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:21:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4BB30E1;
        Thu, 17 Aug 2023 12:20:57 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI5rn5025650;
        Thu, 17 Aug 2023 19:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=TJyMEYWLnVOUk34ktmWFxYvekW0p7kMJSmr+kKrpmYc=;
 b=mkTlM105alsRPINPqeDE4bgggN7vxaIwAM9n6sq2jAjbGQdgrLpJNDqwjFt8M78l594L
 k9r+A8SJZTx2+TnXvpVDdS+JaiCsG1axnqyAriLLX40qZ3K1v5DrCumaXoDE7ZBl7SWt
 tksGxi2UI1wHu1N79iKpbA0SFCNF3zmVQTSAmYBhGw9w+8JzxzDy5i8LDemgp3wHKPLW
 fyebnVfHFsKdd6s0Pz6HDzo2Q4y7r/vlQ+CPdG1kvRIUXWwZ3eYxJF/D3NuOXW1CA++c
 fDwxtp/5fBLEv4vq0RQl7DbSMGkxxwoKZjlCBHRJUFIj2qc2drkuLepApY6I7Vo40wBB Sg== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3shc0mqwmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 19:20:32 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D5605D2B7;
        Thu, 17 Aug 2023 19:20:29 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 17 Aug 2023 07:20:12 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 17 Aug 2023 07:20:12 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 17 Aug 2023 07:19:57 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiO6BQRedkhfsKqaZikuU+tAojp0lONIn748vpPvIfTTjZor0TmL7HStZyskPzokQJ041/41CqFt88b+e7Nzl4Xy76p7S+cHyUkZbeFY5vk+rAYgHWsonzwQQfy89SgcqsOyCN+E4l8dkNdmMsjAgZV2NVbHXTAGwRPQOlOqUO5t9UhFgDrlQHIDBGfiorGJbsEerQfgQ6qWkj+h7TgdMPIYaSyN9SE0g6VzIKbw3gTjYEuNaZ28chXBZmn4xqHunbmTSoPUEU0FbiyRz2zQunDWXfiIQspw+hHVbe45pzJ53lXBhOF26AENjWePOn5F0wWsuy+OV1iDL1J/BhW0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJyMEYWLnVOUk34ktmWFxYvekW0p7kMJSmr+kKrpmYc=;
 b=l63etH4jxub/1qeyfrddvJXpOvNcMIY4oxALkHXGdDzNL5elgFxO4HiXcsd8FDIbsPO+SBy4mh16/RAqfses87rXpjO2mxJ6/NBlP5SlQ/4N7MzhJfaL1g45HBycVYS5kszLxZTnmSNU1M9BNUmi6g3a4ADVF7M4PVmJVoMTLwi6d4YlJTgacH9we9I0mzR/znjtgqydBTK/T1/8aJ2Q3VNFv1/Gs7B6x7Y37sszPGnJP2Mu+zI00llD7z0k1zuDxf1hHv4FLN1DmjP5KyOKM5LrvZ0sAFPnSHnfdf6h6VAjlgqFnzRVzfFpwKxQEUPi4KpmZ4uWB4YPxhMQ7ARKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 LV8PR84MB3388.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 19:19:56 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 19:19:56 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Topic: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Thread-Index: AQHZ0Ixvto7vnAASrEiTAeghAafYu6/tuDUAgAEcAUA=
Date:   Thu, 17 Aug 2023 19:19:55 +0000
Message-ID: <DM4PR84MB1927C6684845A9AEBD9F934F881AA@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
In-Reply-To: <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|LV8PR84MB3388:EE_
x-ms-office365-filtering-correlation-id: a78055e0-6ac0-4651-ea4d-08db9f56f0e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDUvGCO8RvICxF9wy9T+x75foO1bdHcSoQHaNtZAHuTPNNv1A139NhBBy5z31Lir0tdRu7/Ms+t2gLnwB+3PPnd4MV+aiy3D2toJ9sWvp/dg8p9LSxmBgUhW/yJrqBxwHst96nlgRRMBwSwqs6PXS5bBxJYjlNxVVwlY7PYVNE0ekHeOEzOxO7nFKPk2Wthg6v2E9JZdJVI2oUxLDQhCjeqUHZWEqgAd5udY73o/ekwgddTOZ+VI87XuA+dlybStg4PeNy0QmLQS6fYMN4h7rujKj4WAR6X3tMEr8bwDclmh36YNOVIx9F5+qEMQkQBAoR3ycfL4QNuI5U2BIr0/l1pfbzan+B1cI5BcMg2AUvNGeH4Gy6F4VlGZA98kxahX5pAIKZuU/TgbwzzzVBmvVc5S1KmOHusjrhfw1TMj7pfRNWABsZpehoj+xama5goyDOSIDiegMy5CNUGdipmysMlayWhCoThNftsOFO7R7uoRhrfz3DcUZLH6cwC16akiN1TMhfk0gt3vJ1MXic2+OE0xfQC8TVnbSxY3XW92TjXsjOapWu89gLf8WrCfmjgw0uPJss+36hMAa/GtbPkR6Ofx9VHB61zcuAcMJBZf785UMORFHHIT9DAHcSIV/y9y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(316002)(54906003)(64756008)(76116006)(66476007)(66946007)(66556008)(6916009)(4326008)(8676002)(8936002)(82960400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V9NuoUyBoLjIcO5U45R7vz0xFaO30PXgbIFPY25fkvTsHwHF9tKGSdv9cp+f?=
 =?us-ascii?Q?OpkGDXmlFbU8Y3CR3iDHkS4yQlUm0QvQ8ZP9IgEfNKO0tpVepO0Ot1PLWNe7?=
 =?us-ascii?Q?xtzMFbMNBurMKU4gYuf0UVtgz56fFq/7nHal8xdANYVelLyeWpYR0vlONGA6?=
 =?us-ascii?Q?ZJc2v5Nfi+LgYeuKCkgEjO0xwo35UvCNX82TTLsQIfT8HX+9iCdi1Qgtcmto?=
 =?us-ascii?Q?eR7CnspEd+2mikhDhnF3WuKvnQkl/vuumsTF/b38M2eZlGiEpKRopaZCLigs?=
 =?us-ascii?Q?NICoSpduZMEp7p1PlBNtAe9WIDI5ggtuR4JtTCx+McV3VWyI6a/lFyfwLSfu?=
 =?us-ascii?Q?GJHfRaqduQczhTMEIh/46dFjdwMWPsHOftT3Hh5gXXXZcmX8rz7hvR9K4LLO?=
 =?us-ascii?Q?/zBuoBHqLeMpResVBxZ1VrUCQ7/v7KcMxvsDeQAnBqO0ryMY0zvtqSoLfARZ?=
 =?us-ascii?Q?DwJHVMEKcHqbNTXB5UOomKk3YBYTajkzh2Da9YT51sPA4YYU4mlUz446NjQm?=
 =?us-ascii?Q?TK8yb+bl52eYNmB8mC69dxcE8Vzs848p4cKAl3BPuTx/TDbMhICcddy9fRBA?=
 =?us-ascii?Q?IDELKFykkZKZMyQqXqmVvcgsZITTSXUcsZdg4thNKhjyXNP7BtJ7iwkh7yOD?=
 =?us-ascii?Q?bFOYbd51cdG6D4/P1s6MUplpOvWnwEJUuTCvA+DQJehhBbTvggzk04yT8YXz?=
 =?us-ascii?Q?t5CbtwQDXgiUgs9yCFruxYMfUarDMenqDCJvnpVP84ZqxyKhs77fXLWYm72e?=
 =?us-ascii?Q?jEGdQ+Vii/WxMcTvphpO1MczK6NX9kVuEvinYZxQAOaAA8Oi/SLZ4II9OtiD?=
 =?us-ascii?Q?+iMY4ZoSh1gDMjiy2S7yVzTf1IqvG8RbDEt6fKdgMyN9QS/asDnU0ByDCfVm?=
 =?us-ascii?Q?tcELq8jcLWjQSx14O0ewr+EVLiKN2CdeZKv6dXgc9+XUfr3csETvNM/mPqYp?=
 =?us-ascii?Q?zZjtfUIExq7KhFhJiz+K/bZjTDC39EicgiYmPZrQemJnNCbYjh4M+6xLyG5V?=
 =?us-ascii?Q?3mJuDcXrm3u8ACyIzyP2q4qEGeAf2XQ+9PAsI2vaJQPGRWLXu4c3Ukwn7qjT?=
 =?us-ascii?Q?EPfxbU7EnK/vw0bANL1DyO0dfJMOwjhm4WKNe1DGXpq9Kzp4kpfjEhsYap94?=
 =?us-ascii?Q?wOaDTMyy+3XQtNAXc6fPYPDqik4Hhv3eZCoHncyQb/DQVIai661iFhiPgaVS?=
 =?us-ascii?Q?Vd38TXUaiCUElegDK3nXCWD5fyKYsJnzo1FeHZPaNXXt4hiwCDHUPvr4R68H?=
 =?us-ascii?Q?xksxoZQ0qEr2Jbr72Vpi/PUB7iriN6p243l3zyrSRDwchjtpqy3aqERA+dJ2?=
 =?us-ascii?Q?mEFntAdLolTrhXqlYq7L2enQLgablfypetR0ebexfL3Y58EOQ1jQ2kw+Mzjs?=
 =?us-ascii?Q?LwdNuRfllnISVSOE+QG+cBq2ew+tZyXR/GWLSyJmOEGRbZ31PZO+YAMutra7?=
 =?us-ascii?Q?KpLSbOX3QtxtwtSjNAECm/SUIt/D2uTl5TVWouW2JvV1TSysFlNIyLf2CxZ3?=
 =?us-ascii?Q?L5TO4WhRI6W4ev+asIOXA10YIOjC5/c5oiOUOlF4kDQrnG+7gJEJltg3bxGu?=
 =?us-ascii?Q?tMaTv9f5n9aIcPJrrXRKUp07fPD8O3HcBau5oQ0j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a78055e0-6ac0-4651-ea4d-08db9f56f0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 19:19:55.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqc3afTGObYhXWjGrLRmCOGVgLDd6aMMryEG0caekWl1dTZEGoATwT3KxFr4QCEwFDfEwnneQEE2LP2cksLNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3388
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Cb3UGZZ9BVLtcYoMHvi1jH37WnIBV5uY
X-Proofpoint-GUID: Cb3UGZZ9BVLtcYoMHvi1jH37WnIBV5uY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_15,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=932 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308170174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> > +static int umac_init_hw(struct net_device *ndev)


> > +{
> > +	} else {
> > +		value |=3D UMAC_CFG_FULL_DUPLEX;
> > +
> > +		if (ndev->phydev->speed =3D=3D SPEED_1000) {

> I'm pretty sure i pointed this out once before. It is not safe to
> access phydev members outside of the adjust link callback.

My mistake I missed this phydev member access. I will rely on
the adjust link callback to configure it.

> > +static int umac_start_xmit(struct sk_buff *skb, struct net_device *nde=
v)
> > +{
> > +	struct umac_priv *umac =3D netdev_priv(ndev);
> > +	struct umac_tx_desc_entry *ptxdesc;
> > +	unsigned int length;
> > +	u8 *pframe;
> > +
> > +	ptxdesc =3D &umac->tx_descs->entrylist[umac->tx_cur];
> > +	pframe =3D umac->tx_descs->framelist[umac->tx_cur];
> > +
> > +	length =3D skb->len;
> > +	if (length > 1514) {
> > +		netdev_err(ndev, "send data %d bytes > 1514, clamp it to 1514\n",
> > +			   skb->len);

> Than should be rate limited.

How is this done? Is there a particular function to call that
will handle it in the backend?
I thought the rate limiting is happening in this
function already below at:

/* if current tx ring buffer is full, stop the queue */
        ptxdesc =3D &umac->tx_descs->entrylist[umac->tx_cur];
        if (ptxdesc->status & UMAC_RING_ENTRY_HW_OWN)
                netif_stop_queue(ndev);

> Also, if you chop the end of the packet, it is going to be useless. It
> is better to drop it, to improve your goodput.

I will drop it.

Thanks,

-Nick Hawkins

