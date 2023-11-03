Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CB7E01DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376960AbjKCKsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346763AbjKCKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:48:36 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05663D7;
        Fri,  3 Nov 2023 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699008510; x=1730544510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6dL1mbO6ttWujC54GhYIpCh9rUXhLAN7bgqf1q1rOMY=;
  b=JHE5jW+LkOXQf9SRrWUyJvqYy1iihA6B9ZfK58LoKaphX+UZYJXbossw
   OKta2jA5th+aVfjQAF2XupibKseyDDVsbDrHi7csiAoOS6rSbyQEFWM5m
   9L/8Xh3o50ZGply2Z/poe908s6NDXcKhxw83wDGRqEOuHyQhcMWR3PYWd
   cTwV2YXcWgPkWY5TDSdQVdW1ENaj5MMPpLb16OvuCQVZ91J+gbpSHm0nI
   uRAZ+GILa/I/OipoBhuCN+yzwzJLn0ghhb73GjkNEf8m7I34vdUMDf6Lo
   QLlNUWRJXEOMKuEZWvP8Xi8DtM0TtO3E6jr0zQ5W0SvZ3AOKouhsnlhFg
   Q==;
X-CSE-ConnectionGUID: zAKvdMjeRnyFs0I1mKEfwQ==
X-CSE-MsgGUID: 8ZvJPC2RS627jqWBYK7Smw==
X-IronPort-AV: E=Sophos;i="6.03,273,1694707200"; 
   d="scan'208";a="1374449"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2023 18:48:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBq9SkKPLYx9Xln4p4xFN6K2+gdk4ZHAzapWVGDtuHM+Kh/tJCfKyqd3zdUrUA53OYQsXvuj9EiHmI2KFJyNFwFejTnDLzRUnrriWrTX0ldF7De9a3rzsUArj9ERndXRGddlyGtr+qNohq9XcJjuX4LA88Vu8vobsOuSR+gc9wLcusjBvXBzMBSCeMMcrh0ss+xNVjSpDfYCgIBH/F7/fGF/kGeDbBDJaU/F7A8OnjIoX8Ldelsq9I7ydJ6eU7aVV/AkENfhBqUigSZPPYXGfdLK3yohZWjXP3sxShpvd1S+5tCPMsfu2X1cGC9eWce6CMhZM4TrtUo+D7K9peL0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5G4nyTTkXGthTsRF7/GN/h8ExW94s2okaFYzPnpcqM=;
 b=g5iXs3a3MXbIuZxVT74u7p05U7nQZ35Eiv52Bxph724j9OW7TunYDp/KsiMuZJqeS5qxhc+qhCEPV2ntP688jLgHeNgZ4/1O6DvjAwiIGKexrBdp59PA6O5/HQ1b80jvONRVabPCK5Oby9U+DUl9M6fJDHiFWq+Oe8XKHGhPFDeDupNJf9tSo7CoBY8rn696eodktrm3FlI5/++Vhf8X5RkrIrJ+fyCokxkOJYwh3jKNASCqc1qSQP8TjI2sSbJQuGTiI7Hu/7pHlub9mGjIbTqaMjgSGftv5t5Q0yk9pA+I+56gkm5J9BUZXYy44P7E8bs4v/kg07wTdf3dsyjTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5G4nyTTkXGthTsRF7/GN/h8ExW94s2okaFYzPnpcqM=;
 b=Hipc0856ZIT08yQl7VbGvfr3D1E1/M274iKVZfg0lFBkeagRFNSJzEY2Q9BlbVK+6TYUHe7PNKcgSx1Ngo6iST40mtEKGGa3hBqERNoOq3zjSdQFEXwbSzYa5gWKoBnCwWBvSwtZfDJMJH7EngLsggVoM0MVanje4IhxLi0QXqc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6393.namprd04.prod.outlook.com (2603:10b6:5:1eb::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 10:48:27 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 10:48:26 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-2?Q?Kornel_Dul=EAba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 3/6] mmc: block: Be sure to wait while busy in CQE
 error recovery
Thread-Topic: [PATCH V2 3/6] mmc: block: Be sure to wait while busy in CQE
 error recovery
Thread-Index: AQHaDjLdE0xH2Uhog0iwIpZyoLJPK7BoaZSg
Date:   Fri, 3 Nov 2023 10:48:26 +0000
Message-ID: <DM6PR04MB65753B3B797430DF05959210FCA5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231103084720.6886-1-adrian.hunter@intel.com>
 <20231103084720.6886-4-adrian.hunter@intel.com>
In-Reply-To: <20231103084720.6886-4-adrian.hunter@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6393:EE_
x-ms-office365-filtering-correlation-id: f88a6600-72fb-4481-1bc4-08dbdc5a68ee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4up6Go4jaPJ593Y0pRNwRGCnfZ9HiHQgadpbwjWd5TcX5/XAcx4U62V0vN6qDrJt80Fz13Jp+bcfyWmvMzHDgJc524boyO1wIPJzqcW2u3pzKDwYf0bnOJ49Se7ShZqW3Qc7Z1/QKkRn/h9RGiMWpTQ/7vEHWaUNIm4mG4QaigSkh4Xk1FBZalmuzr1JDx98i8LvkvlD78lzc2M68hMeVBpQJTwXNFRgSHgCwQEIvc6VgoQL4GOfH6DEdGLZO7PKeq5jf+BUaI/9ZfWkBNM/S43dBAczO3SEAVH6ldQAW5FEjt6IpWElLxxz5XMphgQ9sJtRKtfntme25p3LqI4zSwUnUCFmwa9omAuXNoRPleT+br7uPWz6WMtmDZjWXG3B9ku9Df2W7gwqs459xARuyWmalUZWcoMOK5pH9W6CoxhSDQ4UdvoUnU4I2yYBDUGmceuGwr8H1+xHKhMGw1VWQ6B4slzE3O26ZEasii35h3Syl0LLbx5fZL65X061dvIXGsGA3okoq3nR3UwARvKB8TN4xNGwyk9pTM0sR+fRLXeGYjbROCK9EQ1IGhKLUn2/pCCjuVkuVrZS8sj8nup6HqG+OfoxCzULn2Zxtpg+Jqk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7696005)(8936002)(38070700009)(7416002)(4326008)(8676002)(52536014)(55016003)(316002)(66446008)(64756008)(66556008)(76116006)(66946007)(66476007)(110136005)(26005)(41300700001)(38100700002)(5660300002)(9686003)(86362001)(6506007)(71200400001)(122000001)(82960400001)(83380400001)(54906003)(2906002)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?kKvcLmfE1+tC7Bv1s6qxgeWSQYjX/hq4OUwsJp5w8qkr4fjRRC4KRh9AjD?=
 =?iso-8859-2?Q?/ld3v0npTV/NKVPIB9GGOcdr0lsq5WFdfLWGm0uXskKzkd/0p2X2FfDYP7?=
 =?iso-8859-2?Q?HhtkwfGbPlH6IVRfU8cNB79eMxet7HpuQhezaFuAtiGI5ylED4PthV0Tip?=
 =?iso-8859-2?Q?NxAHuQ3izv4XU/4JRmg17hPNKbRavcs8V/DBoTP+M7COu730i2OZyaSVq5?=
 =?iso-8859-2?Q?ci5Mw/5DVY2WJlRLe/VMCT8pnTGhRN/Zn8PB1qTUtQdzCgv7NWR/OSzMpM?=
 =?iso-8859-2?Q?9/m+MArmOGX8kGhlUDfkkHx3vh2aIvJ2zMrdzYqxBl36MHo8VpKqnrxQ8V?=
 =?iso-8859-2?Q?6UCQx4dKIpfTFFNNSfBRdq/9lBac24Ll+o3Pe3LHfWerkQhs33Tpj4oCM5?=
 =?iso-8859-2?Q?kcXzfMnd3xsSqJj0OF1m9RDH5CkbA5Xxx+0WqxrFOGCaogbGSVEIE35RB7?=
 =?iso-8859-2?Q?d3rMeIvnWpJ1FDNsl46DrIh6lNxkqzJs4SwN3HGBNqI84pEfq+7fGSL6GE?=
 =?iso-8859-2?Q?Acrqs76B8aCJtZNO+AtD0lwoI4IOkJnHdSTnPDyrdPdPdIO5+MDjvELJXz?=
 =?iso-8859-2?Q?vV4hfunipvKgFLPoAG7UJFE2aXO9k7+YV78L/AT2paufy4EpAiGk4o4kwR?=
 =?iso-8859-2?Q?VE1SVm7oCsZimuV6kZJ49BFGyZ1gt5X1GyvpHwvVtoOT5SYT+rJi1lBCCR?=
 =?iso-8859-2?Q?vVHOpQRxZ66aVx0FRj5uiY+/TJifLxPDQveXElKVpTPNAkEBwodNdkRfyu?=
 =?iso-8859-2?Q?UwD2HzS6X4Gq6E3ynh6Y2gOGL0PJcSlppBnqm7Y+RntilhMHzfyTxWwNwV?=
 =?iso-8859-2?Q?fWRTy200wkbK4/xshGuQwXtNke7eyi0w5E+wkdtyHL+p85HL/IJ5Uw7L+k?=
 =?iso-8859-2?Q?HyVU/cUQdSVUC4iWwlLjeriKiN+298JZ1PqJlZDrc5/y+vW3HniiGDk/EE?=
 =?iso-8859-2?Q?kLr7IOh8gv6/speV2A3rx4E28oNVBjhPKnN4GgEx3cTQ4ngXXRSu+JP4p7?=
 =?iso-8859-2?Q?pNVfAUjkgd/bv+zrICqYtAMoYS/oWyGuOrjDx+UkreUb1kwNRafKhYdcug?=
 =?iso-8859-2?Q?qWFI7oyJ2Pm39f/+jhrt0IbYARiihvfEA5GrUdq3k4ITN0PGdcFH/FOg82?=
 =?iso-8859-2?Q?M/kGKN+Cms+J97Z8sFzKdbqoJ0DmsBF2S12I2k/sYYevzUSrdElmRbhnyk?=
 =?iso-8859-2?Q?MKFeKs2CrgDpvhiPWuTsNoTt0DgIH6p+26X6M97REUW2YR8KrWksfCTjzS?=
 =?iso-8859-2?Q?Cc2dMIbr0+sZAS/eVBbtn8c218dSztOcVowK5h9y2w16Ikj4qzPS+oRWGh?=
 =?iso-8859-2?Q?JkiwmczZ+94kHQwCxmOYFzjOjgkOD766Hn65dARiscV7MFmGhHtfZAgSjR?=
 =?iso-8859-2?Q?nzz+tDpxSTm3fVCZaOVNBPWgOOgLdSwekiA/RyYl4LCtlRqCjXlBVdFPH9?=
 =?iso-8859-2?Q?6WeITpIooQHzgeSIE+PYgNkPHwC++v7ZH7YrPOZJQuLADR2XZGNHqvtoy7?=
 =?iso-8859-2?Q?l5Ow9Mv7fsXLXTiuK2vctlEUmtQ064DR+vVYKPiA9I8bjphyb5Wn63v9HW?=
 =?iso-8859-2?Q?A9QBa3dVp9YTTmYWg2Dm0m1RwOjZFqjwjeEOVHdw3oWx30qca5f+qO9x+m?=
 =?iso-8859-2?Q?0hLEjtXbmNWLBUQu0sgSIli22hykSkAEEM?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?mDkJu2H3BGN2TS2SS3a1eBwOY9gcm/ZD7usYFMKdM/Op0ScylEjU0M7GMh?=
 =?iso-8859-2?Q?J8t5+q/vGa6suuf6CgAfURnENaYuJSfAa8QqnztmbpR1zT2/OsS+ZqMqLG?=
 =?iso-8859-2?Q?50O7Og1uMeDULRu6ZeZhMK+GRdvhD0psvUNwRNQYJAoOnHwruycau2Dqmo?=
 =?iso-8859-2?Q?da0zjM0r76iiIu3NdF5qDJ94tKILBTWfOSgTpheFMCkSuKI4DH0WUxUIyb?=
 =?iso-8859-2?Q?KzhxNc4JiTmd+NzaSx+tqAdbaXNS1byOZPIhVTNWHHeBfAzYlDXcx633R3?=
 =?iso-8859-2?Q?1Ed0sxPjSL8n1BpthA+rUA53PFQHfrL6xQU+NY/BwivBK7Vs4T5Ap0feSi?=
 =?iso-8859-2?Q?w7q4T+fIkGMagIMWk9uSW2kYeNIVkPytdsbj130Do9fY8fL4R9X8Rj01vG?=
 =?iso-8859-2?Q?sNdSoy07v1lu64PHbEps2O5ePPKfZ7Sy2AJtSURW5aHQ4TL0Jcwr+eJhxE?=
 =?iso-8859-2?Q?abHjWQL0yofxV+uAe0uYxR/mWiqcdLpRQ4shV3fjiQb3kl5xWpOXn+Db+v?=
 =?iso-8859-2?Q?Umd9pn24kkLRuJv98WA7+cPoCMSFFGmcNb4EMZeCSATFZEowVz7Y6MdBiY?=
 =?iso-8859-2?Q?Qk0RgRYUK56BIq4/uW0ml+B03H9FbHFKeJIJJKyayrKuAMP7+uINzlSrg9?=
 =?iso-8859-2?Q?tta/gCl70CXnqKXWCCNDIRynZWB/b+e0liUbecDX46fAvKwBmHGOZuOdtJ?=
 =?iso-8859-2?Q?yppc9YjyVgK9i01JRHFVyRt6ILPcNYceYpmpJi6KkgxZRrcXkiw4/gbZm7?=
 =?iso-8859-2?Q?F0S/DQ8iljxK7wQf2Y2I3MYJNHh0v/TmPznBsBmdJM8ey0lZ7dpX26Wkdb?=
 =?iso-8859-2?Q?aMqjKDWgsJgiuip4NYJEe2Qt/3vs12j6yLDzbI6le3U6m0sUbPzVlasSdS?=
 =?iso-8859-2?Q?Ros9a3jyHMxM3c44zDZbgL/vl8qB/jUChNEuyEuheKi3k7bauVqhGmTihT?=
 =?iso-8859-2?Q?1SzuAMIFhe+cIkTPW1eZzXD87bypyJVDqf3UTGjiJZrKDNaFVT1yWPlO6C?=
 =?iso-8859-2?Q?eUKN41QV6HHtqCC/nIvGDkwqi/1VykVRPnILQirLYel1zV3DRAk5b8zqkz?=
 =?iso-8859-2?Q?IQhLCFJRXG07TN/R/lOzBc5EJv3+Q8llvTGo5q7C8S+c13UIndjfN9AuIT?=
 =?iso-8859-2?Q?HCam1Uq9fDVo9OUhiQQJBeD+SkLyuLe46UkSE4IjK/xS+/IjcIzE67WAgz?=
 =?iso-8859-2?Q?9Nd/4IpePH1sHKlYNox9nDHn5ERLSt96WG8=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88a6600-72fb-4481-1bc4-08dbdc5a68ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 10:48:26.8126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbubLrysWUCFN38XWxxNaIM8BsbgI/J9vloJOYx1NUyqic4A7A7ZDCkLINIPTFr8Eae6wWRAVw2UdfYLDxBUyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6393
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> STOP command does not guarantee to wait while busy, but subsequent
> command MMC_CMDQ_TASK_MGMT to discard the queue will fail if the
> card is busy, so be sure to wait by employing mmc_poll_for_busy().
Doesn't the Task Discard Sequence expects you to check CQDPT[i]=3D=3D1
before sending MMC_CMDQ_TASK_MGMT to discard task id i?

Thanks,
Avri

>=20
> Fixes: 72a5af554df8 ("mmc: core: Add support for handling CQE requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> 3d3e0ca52614..befde2bd26d3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -553,6 +553,8 @@ int mmc_cqe_recovery(struct mmc_host *host)
>         cmd.busy_timeout =3D MMC_CQE_RECOVERY_TIMEOUT;
>         mmc_wait_for_cmd(host, &cmd, 0);
>=20
> +       mmc_poll_for_busy(host->card, MMC_CQE_RECOVERY_TIMEOUT,
> true,
> + MMC_BUSY_IO);
> +
>         memset(&cmd, 0, sizeof(cmd));
>         cmd.opcode       =3D MMC_CMDQ_TASK_MGMT;
>         cmd.arg          =3D 1; /* Discard entire queue */
> --
> 2.34.1

