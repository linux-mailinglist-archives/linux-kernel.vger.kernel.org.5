Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F1F785252
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjHWIIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjHWIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:07:34 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2115.outbound.protection.outlook.com [40.107.23.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E24BCD2;
        Wed, 23 Aug 2023 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdgxoO2u0IMcfvloYJh9/usbJ+ZoE9Fc8369eju3yck=;
 b=wwOdsUOKuHQefbyNaRXqUJIcpLU7xNRQdukFI6uAdl15Jpsp5rfTSaZyL9jxFHTYuxgyqqyEnjoO5M/Vztuj/8i2CYm3JYAIfrpnQAlAajphL3iqu/7vge3Ampp6VXW0aZk+AGT6o3OPratp/ZOl0DzcaofQUJQT67Vqj0xFdgw=
Received: from AS8PR04CA0167.eurprd04.prod.outlook.com (2603:10a6:20b:331::22)
 by GV0P278MB1159.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 08:07:24 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:331:cafe::8) by AS8PR04CA0167.outlook.office365.com
 (2603:10a6:20b:331::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 08:07:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 08:07:23 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4RVzMT3SQfzxpD;
        Wed, 23 Aug 2023 10:07:01 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2108.outbound.protection.outlook.com [104.47.22.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed, 23 Aug 2023 10:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdgxoO2u0IMcfvloYJh9/usbJ+ZoE9Fc8369eju3yck=;
 b=wwOdsUOKuHQefbyNaRXqUJIcpLU7xNRQdukFI6uAdl15Jpsp5rfTSaZyL9jxFHTYuxgyqqyEnjoO5M/Vztuj/8i2CYm3JYAIfrpnQAlAajphL3iqu/7vge3Ampp6VXW0aZk+AGT6o3OPratp/ZOl0DzcaofQUJQT67Vqj0xFdgw=
Received: from DB7PR03CA0077.eurprd03.prod.outlook.com (2603:10a6:10:72::18)
 by GV0P278MB1125.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 08:07:19 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:72:cafe::9b) by DB7PR03CA0077.outlook.office365.com
 (2603:10a6:10:72::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 08:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 08:07:19 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.112) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 23 Aug 2023 08:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my/fObJCxsBipvDA6lwP/P4Cu3He6LSNasRc5Cx6QCdKyvFoAHFpnIJYtun2gQRgR2s2ilHbhrmzzJ3mYshRe9MFH/25PWT1yGqY74d0cZ6FS/MKqbeg2eNKDM1eJWMZCeFs0XkHJKbi+2RaXWrIKpLoeeWn/HwIy+S7qjEllAnyyOnBhVK6tqgY2hqkzkVoFZcI43K8KsRi0DKFECwXaqZuYYC0moW2bBKIsc/YhnZNI+XEbf/4EOz7zWkfdHPihw+QCgZxTLHZ4Fb4752Xqqt5FHr8LZkjtIzppvHVkQtMIVYIB9owcLUvEvVamB7TjgSf0lpjgGYxH0E9Nnkq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdgxoO2u0IMcfvloYJh9/usbJ+ZoE9Fc8369eju3yck=;
 b=jO7JFS5RnlSFGjELCNyPCGxCjfjBhkbYGBSHjDRNikM51KFM/LT/I2OV3bYzaQFStSCdm17EQanQEBDkB5z90ZyNosuG4Dtx7x9M88ODq7rFztnFAY8i8lur5cOiuLkrXFDG4w+mGy4FxvTEgArfaSCvq8npm43MFSw0LALupU1iu+nSBlH4xp91BuKzdY1tTRa3+lTX4noqr8oZcPv6xEH4RGA0J1ycbfyGETm5Jo7HcVFxH3MTQs4VnRxdO2UPVyC3rLZWfOHWv8rSGVaMD6yVS1V0hchM/vpiURfaigWF2m2RDa346GUeXLtqWxrMYtWwtkConHk51Cxh3coXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdgxoO2u0IMcfvloYJh9/usbJ+ZoE9Fc8369eju3yck=;
 b=wwOdsUOKuHQefbyNaRXqUJIcpLU7xNRQdukFI6uAdl15Jpsp5rfTSaZyL9jxFHTYuxgyqqyEnjoO5M/Vztuj/8i2CYm3JYAIfrpnQAlAajphL3iqu/7vge3Ampp6VXW0aZk+AGT6o3OPratp/ZOl0DzcaofQUJQT67Vqj0xFdgw=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GVAP278MB0118.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 08:07:12 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b65e:7aa8:46f1:f3c5]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b65e:7aa8:46f1:f3c5%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 08:07:12 +0000
From:   =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?utf-8?B?Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kgSmF2aWVy?= 
        <JoseJavier.Rodriguez@duagon.com>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>
Subject: Re: [PATCH v2 1/1] mcb: create dedicated bus_type for mcb_bus and
 mcb_device
Thread-Topic: [PATCH v2 1/1] mcb: create dedicated bus_type for mcb_bus and
 mcb_device
Thread-Index: AQHZ0cORLT2E58lKDEuD2mtcQf8uu6/xY1aAgAYqxYA=
Date:   Wed, 23 Aug 2023 08:07:12 +0000
Message-ID: <91ec4fb04e3e970073ec7c0c5aff4b1659d11880.camel@duagon.com>
References: <2023071044-deduct-cycle-a918@gregkh>
         <20230818110230.186700-1-JoseJavier.Rodriguez@duagon.com>
         <20230818110230.186700-2-JoseJavier.Rodriguez@duagon.com>
         <2023081913-trifocals-flagpole-cdf7@gregkh>
In-Reply-To: <2023081913-trifocals-flagpole-cdf7@gregkh>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0516:EE_|GVAP278MB0118:EE_|DU2PEPF0001E9C6:EE_|GV0P278MB1125:EE_|AM3PEPF0000A790:EE_|GV0P278MB1159:EE_
X-MS-Office365-Filtering-Correlation-Id: f28d3bfc-2103-431f-cf88-08dba3affbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: W8HIOALUPG0T+aGIIwdOVX2IbiyNaQZdNo0NLLE4ghmSAITujCLHZbG1Mq4HfxpjsmL1X7rlBfr+GREqOsXHWBebfyU4LyhYzQ/I9SqjRlPeIq20ptBqsMOEyHUAwiXV89Bm9nMaz5Zh0EbRTZftP6wQfELfeht/NnZQoaoQ22egc8UUBrnfsIEjFzcJrGlAGobrsFRJ3sTKPRJUl2OX0Nj4vZi9fuES8ihpKjyhnP0d7J/5BkFz22VgDtJcEibbIFHLT7sEQpad1CWCLkkfJq1p9tMXoIxspzIOC9RMBsfMPTVyM6D+TMIkek4De/1QSng+MICKGohiHTLZs1sPPPSNoUDmCLhxbUrfbdw/9FNOzwGkdc7bd3Iaj+ZhPdUgM5V68zgDKp4DKida5W0ost/PXMWsjWpHF9XzrNgtBcomeb6i7D6D493Rr2u/0d0Q1O0s7k2g++yf3gLZOvZ15Ucu57ZPMPH/EiKTxxqX0LB6ON6CftJAmqTNHwMs0NVddHYfNBb6DrgTc6Lwb0GOCV/rhr/OqVWlQcpqDmfuAJ9TJhQw5kfFkxGQCuiomKUFTzlXbrMFoQXAnkIbJlJ4QtaE808zgaXtq4IH6GBsaV7CtmhfDgK70mEovLlPeq2gc4+4e9i8Bxc9QqnjucgWiA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39850400004)(1590799021)(186009)(1800799009)(451199024)(66574015)(66476007)(6506007)(6486002)(66446008)(66556008)(64756008)(54906003)(110136005)(316002)(83380400001)(8676002)(1580799018)(8936002)(6512007)(2906002)(4326008)(41300700001)(86362001)(2616005)(38100700002)(122000001)(38070700005)(478600001)(26005)(85182001)(36756003)(85202003)(5660300002)(6636002)(91956017)(66946007)(76116006)(71200400001);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A8276F46DEB0445968D03C399ABB752@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0118
X-CodeTwo-MessageID: 2ad482e5-4205-4b23-a7f2-329cb5feef1f.20230823080713@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2d927d94-4635-419d-9035-08dba3aff4c9
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1RhL40zLVXFnSf1kRGXNEkl80wHSQSrEHGq00H0O1xhmaU2t8RSO7H5UGILqnW8GsIywZGI8BB2XB9Y4eW1rokJSpaRhuEWAUQpWv7WJIw0JlNdcgI4O24MxQ+o7JqJsdeiLG3HnFtAOPkdiuDmPMa4D5X46M4HfdhCdl35LVrIoyxrImL088foo4fGb9f+wnrlEwzEiTB8xTjCu5nW92gFiVBpi+zMW09X6W1ftcKUjUrh3H3M8cPds+WbmlhSlKrn3Jf5t7bCxMimfFQfwDEuUNG0p8W8wJNpwG2I96miJ1ABR9eExlmQUEBlkWljR1skEZrNRqxHnBqto4X4t7vdGCn+srby4FjPPqR1KyWQDXusrlvOCS3K/Xtc6VOUGxxJZbJatMBY5FINyMfVa50LieNasSflYBsQvWS9glaB2zU2Yp+DDuBhBfe8bLdM6VAEkWoTRTInuCHrLoi9I/+9PAhN0+DxgoARu6CY/SK2A8IfWemK9sITWcl5B9NbzqDLym7RfRZg/1OadgxgkWf2VABmeVAejfwBmiirrXvdozc6AXRB1DSmVT4MVgE4IdhDQhIQuMKA6SOxTcfGDNm/mV9fhTFkXJmCWeXPnXmbKLQTOFwLrOajqbkKe1SQj/gtSOXyQzOeUUZbOH8fLQz+BgNh4hqOTTyXS1v4I/9XC56pE978ue+6lWdJvOJFqPtRiJY5hMdw/yz6zg2yz9N9t8d6Gv32jf2jOxeVlDbQo6fO9KeHT8j1nspiLo5JR
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39850400004)(82310400011)(1590799021)(186009)(1800799009)(451199024)(46966006)(36840700001)(66574015)(6506007)(6486002)(54906003)(110136005)(316002)(83380400001)(8676002)(1580799018)(8936002)(6512007)(2906002)(4326008)(40480700001)(41300700001)(86362001)(82740400003)(7636003)(7596003)(2616005)(70206006)(356005)(478600001)(26005)(85182001)(36756003)(85202003)(5660300002)(336012)(47076005)(6636002)(70586007)(36860700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1125
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1e3cb4b4-9f7a-45f8-6e68-08dba3aff8f7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2A7rX+lm6lHVx/fLHqBvU+42rh2KyvdyrW/eUGDunUp0gR8jtX1OsNLE1XKqL+ys8yTnEMTn0FWCmZFuUCOyN3ocZnzZdYTsq//ikyAqItKTUqr+RQEcAPuV/HX1gpdNPVmExNAo/1L/Rq0ry9cNx+1HTOy9iiIuGiMqh8ONHgmr3Q/NJrLQ5gpE/MME7k8jc6lA1nj+RHtyUdgiRC13TWa67zw7BSGHdoWDpf+YhR+yXl3yCYKCZ/zVQ43Y3LPGNFFoBr4jV7uCpQqexUVLDSBVt0AJDE79sfAm3LUD5Z8xCi478sNNKLGV6ZiY4HBSGNBIOya+NH72X3ezs3IIGroz+79NHQFLwA8ug03XQ28WfGHSubi4XiER8ZLiSsh1YvkWLvk//zwTX2ZyDQpEE8pkxv0YSij8qgmKXgnb9F19HhLbwgDJ0YwdvMcJWLrLIHnlsp/QnOpw2MPfhlnesHzpZKJ5AKD5kuvcq9Wq1twXwfZWTASXCkI757gINOhlcBau0jh9gm54rYqzvFNdmrQmkak3kqcvS5YBUJjuGgjcfnAjm3YLh/B+3zvC8ZiyDV/p7EJ7QCYVRsAN866wKVFSjA5QzoIQs3arIXXvFbqqbSB0QAzqdvjnNH8u55U6BxASm8nQPJIarzz59JbE4qC59eK8+e/+0Z3jSGnXc9dAvh35BcTt6NDcKg9mrF8RFEeX/StQf/bPPOFtbXPC+twoW9gYH7lzObRi8S0ozr5WT9jDTmw5QrIghi4qiyx
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230031)(396003)(376002)(39850400004)(346002)(136003)(1590799021)(82310400011)(186009)(451199024)(1800799009)(46966006)(36840700001)(66574015)(6486002)(6506007)(54906003)(110136005)(316002)(83380400001)(8676002)(1580799018)(6512007)(8936002)(2906002)(4326008)(40480700001)(41300700001)(86362001)(82740400003)(2616005)(81166007)(70206006)(478600001)(26005)(85182001)(85202003)(36756003)(336012)(5660300002)(47076005)(6636002)(70586007)(36860700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 08:07:23.7270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28d3bfc-2103-431f-cf88-08dba3affbb1
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA4LTE5IGF0IDExOjU2ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gRnJpLCBBdWcgMTgsIDIwMjMgYXQgMTE6MDM6MDNBTSArMDAwMCwg
Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kNCj4gSmF2aWVyIHdyb3RlOg0KPiA+IFdoZW4gYWxs
b2NhdGluZyBhIG5ldyBtY2JfYnVzIHRoZSBidXNfdHlwZSBpcyBhZGRlZCB0byB0aGUgbWNiX2J1
cw0KPiA+IGl0c2VsZiwgY2F1c2luZyBhbiBpc3N1ZSB3aGVuIGNhbGxpbmcgbWNiX2J1c19hZGRf
ZGV2aWNlcygpLg0KPiA+IFRoaXMgZnVuY3Rpb24gaXMgbm90IG9ubHkgY2FsbGVkIGZvciBlYWNo
IG1jYl9kZXZpY2UgdW5kZXIgdGhlDQo+ID4gbWNiX2J1cyBidXQgZm9yIHRoZSBidXMgaXRzZWxm
Lg0KPiA+IA0KPiA+IFRoaXMgY2F1c2VzIGEgY3Jhc2ggd2hlbiBmcmVlaW5nIHRoZSBpZGEgcmVz
b3VyY2VzIGFzIHRoZSBidXMNCj4gPiBudW1iZXJpbmcNCj4gPiBnZXRzIGNvcnJ1cHRlZCBkdWUg
dG8gYSB3cm9uZyBjYXN0IG9mIHN0cnVjdHMgbWNiX2J1cyBhbmQNCj4gPiBtY2JfZGV2aWNlLg0K
PiANCj4gV2h5IG5vdCBqdXN0IGZpeCB0aGlzIHVwIGFuZCBkZXRlcm1pbmUgdGhlICJ0eXBlIiBv
ZiB0aGUgZGV2aWNlDQo+IGJlZm9yZQ0KPiB5b3UgY2FzdCBhbnl0aGluZz8NCg0KSGkgR3JlZywN
Cg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpXZSB3aWxsIHRyeSBhbmQgZml4IHRoZSByb290
IGNhdXNlIG9mIHRoaXMuIFRoZSBvbmx5IHJlYXNvbiB3ZQ0KbmVlZCB0aGlzIGNhc3QgZm9yIG1j
Yl9kZXZpY2Ugc3RydWN0IGluIF9fbWNiX2J1c19hZGRfZGV2aWNlcygpDQppcyB0byB1cGRhdGUg
YW4gaXNfYWRkZWQgZmxhZyB0byB0cmFjayB3aGV0aGVyIHRoZSBkZXZpY2UgaGFzDQphbHJlYWR5
IGJlZW4gYXR0YWNoZWQgdG8gYSBkcml2ZXIgb3Igbm90LiBIb3dldmVyLCB0aGlzIGlzDQphbHJl
YWR5IHJlcG9ydGVkIGluIHRoZSByZXR1cm4gdmFsdWUgb2YgZGV2aWNlX2F0dGFjaCgpIHNvIHdl
DQptYXkgYXZvaWQgdGhlIGNhc3RpbmcgaXNzdWVzIGJ5IGp1c3Qgbm90IGNhc3RpbmcgdG8gYW55
IG1jYl9mb2/CoA0Kc3RydWN0IHRoZXJlIGFuZCBqdXN0IHVzZSB0aGUgZGV2aWNlIHN0cnVjdC4N
Cg0KV2Ugd2lsbCB0cnkgdGhpcyBhcHByb2FjaCBhbmQgc2VuZCBhIFYzIHBhdGNoc2V0IGZvciBm
aXhpbmcgdGhpcw0KY3Jhc2ggd2hlbiByZWxlYXNpbmcgbWNiIGRldmljZXMuDQoNClJlZ2FyZHMs
DQpKb3JnZQ0KDQo+IA0KPiA+IE1ha2UgdGhlIHJlbGVhc2Ugb2YgdGhlIG1jYiBkZXZpY2VzIGFu
ZCB0aGVpciBtY2IgYnVzIGV4cGxpY2l0Lg0KPiANCj4gVGhhdCdzIGdvb2QsIGJ1dCBub3cgeW91
IGhhdmUgYSBuZXcgYnVzIHR5cGUgd2hpY2ggaXMgYSBiaXQgb2RkIGp1c3QNCj4gZm9yDQo+IHRo
ZSBidXMgY29udHJvbGxlci7CoCBJdCdzIG5vdCBuZWNlc3NhcmlseSBiYWQsIGJ1dCBub3QgZ2Vu
ZXJhbGx5IHdoYXQNCj4gb3RoZXIgYnVzc2VzIGRvLsKgIEFzIGFuIGV4YW1wbGUsIFVTQiBjb250
cm9sbGVycyBhcmUgbm90IHRoZWlyIG93bg0KPiBidXMNCj4gdHlwZSwgYnV0IHJhdGhlciwgYSBk
aWZmZXJlbnQgdHlwZSBvZiBkZXZpY2Ugb24gdGhlIHNhbWUgYnVzLsKgIFNhbWUNCj4gZ29lcw0K
PiBmb3IgZ3JleWJ1cyBkZXZpY2VzL2NvbnRyb2xsZXJzLg0KPiANCj4gU28gcGVyaGFwcyB0cnkg
ZG9pbmcgdGhhdCBpbnN0ZWFkIG9mIGNyZWF0aW5nIGEgd2hvbGUgbmV3IGJ1cyBoZXJlPw0KPiAN
Cj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K
