Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D8784E83
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjHWCGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjHWCGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:06:20 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2E2E4E;
        Tue, 22 Aug 2023 19:06:17 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N0e3tK023538;
        Tue, 22 Aug 2023 19:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=2jKR44LDYcIkIFtp2oK8l4w9LBMuHApBPIu44CTfQ0k=;
 b=PQIUCTkyqMtUGAwVN+vu8G0qBmfz1xuuhXeFAyu0F6YeRcPRWalAI89jrrMfgfv3PkoN
 JU0k5tt2IOGA/q1eACrcGSNfEL66dNfvNOJydSLWgSYCjg8zS/I7AQg6KfxB+Zo8npet
 hqkGq78eQts/dnz6SGXGmmD4r2dwEd0WJrprwFx/ekCJzeScIkPAQb3vM8QP6VqDGJmo
 6/5ysZ+75GmEI1RhqnxsZO2tG6G6A2i+WbrgEHS6PlKR1HU3G0C66K7XQZgPS966cBZw
 2yEYPq+7Pxj0fVHD2o//Lc86+XuuAxqwY7UMr6UORtkV/4LgoAW3Ntcs1BwXxgOOIUL0 FA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3sn21q9t98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 19:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692756351; bh=2jKR44LDYcIkIFtp2oK8l4w9LBMuHApBPIu44CTfQ0k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=az834SEoWi6QO8/NQi7MEfj6T8ZPV/BEAM9P/zYqK0RF8A+PVhVt1iuHZV2wnlKeg
         hJ+0SDYDOc6paEiuZI2sMPT1S5OjIkfEcHdwb2+LGzuk9HGiMFeUxwqRd7Y8v+BGbD
         q0a4hji0CJWekocVHgBJ9vYkVWX/Ri7pbqZP1vw2sx4GaKq8PTM8lpBSR2edAT19yV
         JASGdunGAzwao7UFXy9izT3TfUpVlms2k4fQ11Y9oP1nMr1DnZJCW0i7GM/fhwhDSf
         l+5cHtRWI7nDm95srXlAadglYC5Gz8cmWbhkceR+/ovUWi5VJj9NTk4kt8h34ESvZD
         gx+3DKKiYmF2A==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 968D0401DA;
        Wed, 23 Aug 2023 02:05:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6BED6A0080;
        Wed, 23 Aug 2023 02:05:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Bfq7Xa6j;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0644640565;
        Wed, 23 Aug 2023 02:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PROEYEhVeaOggndPz9WNogKVaT0ebYWQFB4SfoqqZuy96sdzi4XZ06AUUawtrZfY0QM9inkKnYm493QA9mD0cyxLtPYNN+B1bmlXPx2vUzsmQl75QvcrwXJvERAI+W6ewlfbUAZtuwDbux0ECpqpRXbS/6olVY4M1NNTnU2D7Si/blws1kO6YjQF58YkpI+BeczP8udCOt7jxbCgg1DKWX5oR/itxIzX2WPwB0VIevNmgfPT+Lxd1XFS+D02GbNT9CpHT7KAXAzY6KR29sMi2mvCfKn37p37zOmaWJskw/3GmBGRmGDWAFWYVnd8iFrxY0P6UKokjuA5q3cHi+ulFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jKR44LDYcIkIFtp2oK8l4w9LBMuHApBPIu44CTfQ0k=;
 b=iyaQhkj4qRuSLkSxmGn/r5Wc5KjIWNjyg8S8u2pLHfZJfyBrqqUz5lNQxoQTX23SNrC/VCxQ/SEsOZDkqqUjiNOtYdTkZRerLo5fiv0cwixOuuA+k25zEDBVk1qbosjGtiOOq0m7SnxL7/vCMj+3Y9tBwviO/Ekw7lM/4kpbN2ZbJymlCDd54Pwy1ZieMYIOgabuYieikHVYhW4mYAFroPCFV4UKfvcgzaIU6/Xeg5PuZxhzVTlxeYcOwmAPGBq6FEEvthFJPjRMxa/wRN5zJ33nVowYjTpt5RD5sEewzrarqi2L0E6HXwfzYrCtJYmgd8QHHPapbugP9anVNE6+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jKR44LDYcIkIFtp2oK8l4w9LBMuHApBPIu44CTfQ0k=;
 b=Bfq7Xa6jWhhDYSxHB/HTapotZOMbPK3nVl2J8x1B33ndfne3WZkiWgHyMMV71iD9AaOlw89r1S7cVB5uRZAg77smoz2MvUlb6G+Z7JsvtYj3Z0yweGuMglrnx+Ercn+Fr0w9NFxFzUwwjDUxop4DWuIjICqIh8+TgfHlKq0gS0s=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 02:05:37 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::548c:ae3:537f:ca2f%5]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 02:05:37 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: dwc3: unusual handling of setup requests with wLength == 0
Thread-Topic: dwc3: unusual handling of setup requests with wLength == 0
Thread-Index: AQHZ0WkxsEX2ZGMtZEmcF1gvP2WuTK/vPhuAgAAY0oCAAAlogIAACMGAgAEOQgCAADc1AIAAELKAgAKA6gCAAbHAgIAAFDOAgAIjqQA=
Date:   Wed, 23 Aug 2023 02:05:37 +0000
Message-ID: <20230823020532.txuz6ka2a34n5tt7@synopsys.com>
References: <20230818010815.4kcue67idma5yguf@synopsys.com>
 <bb470c47-c9dc-4dae-ae3f-c7d4736ee7e9@rowland.harvard.edu>
 <20230818031045.wovf5tj2un7nwf72@synopsys.com>
 <cfc7ae18-140b-4223-9cc2-7ee4b9ddea28@rowland.harvard.edu>
 <20230818194922.ys26zrqc4pocqq7q@synopsys.com>
 <45d9ef53-e2be-4740-a93a-d36f18a49b39@rowland.harvard.edu>
 <20230819000643.7mddkitzr4aqjsms@synopsys.com>
 <e63ba783-f5a4-4442-8736-987a3b134e7f@rowland.harvard.edu>
 <CA+fCnZcmb78DMaffb3cq2JeCNxcGBeyt8hxeJq3SaTTkbZ3ewA@mail.gmail.com>
 <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
In-Reply-To: <3f52eb94-1d8c-4233-86ac-bbc78d4efce7@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4901:EE_
x-ms-office365-filtering-correlation-id: 42e93437-d34a-4367-9511-08dba37d718e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Oc1UzyqZSXpk0IUE34+x+XkpLJIaEwLMeJ+ZILU+7uuw8Dwd+1m4qKcZhi2K/SmBKmIrzPj87OH6x47N5eKsiP6anpo8K7uv5n2RQz3Urgdh8CMNzOqGLwj8UR4VAUY+Bmz/KfhOgGWIOPJqd+yUIC4wbffOXHjTx1i1xXfYVtLksqkDvmYduwCzTYOLDUQam0YDCviJ5+f92J06Uqiomt8Twh38LvG5Qv52lvBX2Ze/6eBgEBFPa+gkVpyUj6hp17pawEw4YywfBX8dQP+ozfA5MotGkmZUVJeCHNyGdEcNdoYR4ng8n9+JcraVKLT6ZqbStM58j+zgABon8irR8f/+o9SU4S5xFtBqdgMUhObW9VFpTC1wYg24nR8vOqr/WnbiNXINTqnszyLpiSKJqiyTbHt8RxpAabKmDL8qX/qTE24yV5FGTyZYwhVnk9fIzfIIEpy5x+hp0M+vV2wtmg5y5JSzPrt9cFr8LDrw4vrINmxB5WldOFvgighB68mhz2ov8WFyMBr1mQcF9m/GAZMXWRUSmduA4so3tF4dbH2v5ZBajtUMBjq7XiyhH3tQuyL0kJE1Wrs8zppfmq38jGaG3ah39mcwjmmHDICjxGageF4PU5uwhiSUtFz8gLa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39850400004)(451199024)(1800799009)(186009)(2906002)(38070700005)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(64756008)(6512007)(66946007)(6916009)(76116006)(54906003)(66446008)(66556008)(66476007)(478600001)(122000001)(71200400001)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekhGbjd2QnlTekN3Y2hRM3o2U3BXRWsyM200Vm1wTXBPZVFsWDRZV0txKzBs?=
 =?utf-8?B?RFVxelVSNWVyc3ZVS3k5Q25LZzJNbnNTZlUrUURoUllnOVJheGxzNWVlVjdt?=
 =?utf-8?B?TkluQUJTSDVTeTFJNG4yUStyQmtpS2E1WDA1eGNrQktSVVpXaTV5aWN0Wm1a?=
 =?utf-8?B?bURxV0xXT1IxNVI4L0d4N21QK1BWMHhJSXBHdFdBSW43N3luQVpZYTVmTnpn?=
 =?utf-8?B?emxqYVhLTllNNnkwK3l4V0hEakRJNitQUzQvRHNJM2tYL0VYUEFtMW10VU82?=
 =?utf-8?B?MVUxRGRVMnNhQlc1a2s3SG5EL1lDaFpnSS9QQVpaMTZERXc5YXN0TXA1UUVH?=
 =?utf-8?B?c1RDQmgwb0kwblZVYjNNNXI0M2o5WlduR2tUdEpqdEE1QXJuMStVRzk5TkVs?=
 =?utf-8?B?UjJzbkkxbWUrQmRqN0RkOU5IcCtVaE0rTmthc091dEcvRmVHNUh3Z1lIcndY?=
 =?utf-8?B?azVSVDMvYTl3NlA2LzR0ZHJzNDlETnhiWXFSS0gxNlRNTTNRQWhsL3crM1d0?=
 =?utf-8?B?bmdMdlJsQU0wWWEySzVEblJyc0ZPVWRLbHYzR2xLU0FZeVMyQ0c0QkpIYW9F?=
 =?utf-8?B?SkVuMGFDTmxhRm1LRWowYzN0dHQ4ZzdLOGpFRWMzWlIwNWg4OERCWElyZE4z?=
 =?utf-8?B?azBOUmszS2VEV255UFVETE9raGp2b0FhVnNpellzSnBCNkFGcUNpQlU2UVM5?=
 =?utf-8?B?TUU4RDJidGNzdEcvckwvR0hUZFNmeFpKd1NTd1JSdVROUndWMEVxSzJmcklC?=
 =?utf-8?B?WjNvNzY0MVFJUjhBUzhvQUNhYkNiSFNxNUtFZGkvZndyZU5FTzM5S3orOW02?=
 =?utf-8?B?aEZ2eC92QUtnWkxQU0FqOEMxMThnQkJmL1FuV3dHUXVRMm9tUjB4VVJ0Q1U5?=
 =?utf-8?B?SHltUm9FZW9TWWZJdFVvTEphL2ZabmNGYXg0bGJZbERZUnA5NmIxSE9OVWRX?=
 =?utf-8?B?eWJxWHpjZXhTd3ZySmNLeFNDU1pJdVJVMnRJSmdtcXRvZXB2TS9TT3k4VXFS?=
 =?utf-8?B?UmlyaHBTUHN0NU94RUpFZjFsV0FIUnhkeEJWWVp0SE1aaDRUMHMrQk01RFNa?=
 =?utf-8?B?YTlKNW9KK0tMbU5vSWYxb3ArTkpTV3Rkc0dqNXhWdjArVWVYNFVOT1ZEb2RL?=
 =?utf-8?B?NWVJYnVHN2lPN1MzbmZRQzV1ZGxkbm9DWncvZzgyYlJMRWVYVC9Sa25xWm1p?=
 =?utf-8?B?Z29PRVhISmg2V21SQi9GNkN3cUFtaGhpZE1UMHk0aGhGVkRaNGpKdEpGTEJF?=
 =?utf-8?B?eFZaWThHYTBwMGYweXF3THQwVkE4L2xDdjIzWFR3M3lKb3AzRFRpL1dFOVdJ?=
 =?utf-8?B?WnZvYk5zZ214cHlONWVsNTBtWFJPUHVqdEJFT1IyK0p0VlRDWWNTeTE2bzJ6?=
 =?utf-8?B?M2Z1MGhjaVZ6RDRubFozaUxJTEo5WHVOZkZpMVZUZ0p3a2FDbkJvdFBNUVdy?=
 =?utf-8?B?dlAzYjNOWUh4SXQyalhXNGtJSVIrVkhMRklaK1lHZjlYVjRIOGFkcmFXNE4w?=
 =?utf-8?B?TkxYWWt5Q2pFbllYVEkxNlByeVUyeVcxUWRzeHhIMHFadXluMzdzZUdlcVV2?=
 =?utf-8?B?MEtNYStNMHBESlVHemYrKy92V1ZYZEtLU2k4SmtPd2VJYmRGTkNvQWhMakJ1?=
 =?utf-8?B?bEo1VDkzWFE2eUNneW5ZNWx1SXZjcURuSlJLdk1IN3dKWUljMTFSVjE2V0gz?=
 =?utf-8?B?MTR3S3UvR0YyN2c0U0tFZ29VeWRxOFdlTW1yMXJsL2NldElBeGkwdGVIVitk?=
 =?utf-8?B?dWhZeUtKeFZJNXFKMkF6K0Z3SEJkUGtUM05kVk5ZMEJGYSs1TndXTVJnQ3JI?=
 =?utf-8?B?R2tBOUEwK3pvaWptS2VJQS9OVmlXWEdxOXFnRGdEcG1RbExZMkVVTklzSUlu?=
 =?utf-8?B?WUNMWlJpOVg1VVFzMWNwZ1FuZWVNZ1BPMEllNzhGNVNBL0pLMUlZdjhKS1I2?=
 =?utf-8?B?eEJtc2l0ZWFHZUF2cTBEeGNjbkRoV1p6ZEtSaSsvenFEMDByUE5BTkl2eWVy?=
 =?utf-8?B?bGVVZlZNU2VMTVo0eFkwTzBGVGV6eDFKUVVNeHJOMWI5TkhxdmJibU5jMktV?=
 =?utf-8?B?Mll0RmNwM0dHSVB5cTJ0R0xPRWpQV0c2aFRMbk9DMzJLZHc3SDFSZHhvV3Vp?=
 =?utf-8?Q?PK2qgHw3I2pFtsLfz9j0Upt66?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B543CA3C003B04084A7AB7C37EF0C42@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Rk9nd2luTTZlWDBQSDY3NXVUYkxiSGRqRFFFU01rYjJhV0xwbUVtWDU4SnZG?=
 =?utf-8?B?RTN2ZGNFOC8ybEpBejlBVEQrVnlwNXRXQWdDQjI3ZjNLWnorSmNpU1o5QkpE?=
 =?utf-8?B?WUpjMUlVRDN2dVp0OVRucWQyN05sckJWU2d5Ly84S0dVVzVGMzkyZkZHYVBz?=
 =?utf-8?B?bG9RZUNDcDJRR2ZRelJwMlFPN3BXaWtHaFlNK1R5UEplNkUrM3hid3JGSE1Z?=
 =?utf-8?B?aEtpNE44KzVSRG5xMlBGRTlaVitqNGpOQkVMRUdiOW4zUnVpVzVlenEvcHVx?=
 =?utf-8?B?RDVBSTFNRkUrb205QjI1cmxOSERVMVJEOHBiZmhQbVNRd00rUWtSRWw3TThj?=
 =?utf-8?B?K21GSTVIckJjS1BLdXZwQTdLeFl0aERnZ1VKMWxVYTFzdk5MNnVET0F0eXY2?=
 =?utf-8?B?SHZZV1hBcmtSL0l6SVBBbjgzanlSZ0xFaGZhUkVOdkZGNEY4RFhFSmJ2YnY1?=
 =?utf-8?B?ODJTTFNGQXhTNllZZkwrcHFHZGtwdWFJK0VEM2RVN0hBLzRwRUVNS2QvdWkz?=
 =?utf-8?B?UDZ4dmMwWFloRUNKMWhodkZZUHphTW9UUzB1R3lZS0pPbnVudXExUGhDNkNu?=
 =?utf-8?B?U1ZnSmRrcnJ4OWNpL1kwVnpDSWVVb2laTTdJczZsZEh6NjFvbUZhVWwyTTN1?=
 =?utf-8?B?UmU2eXpuTVhpYVhZNXA0Q3pWRXJJMFgwdE1OT1ZDQUl5aTI4dFl1QWhOMTNh?=
 =?utf-8?B?MDhPZUd6bFVyckk2TnpCdnFCSENZVVQ3NDJ2ZEk1YVdlbXc0dXlLVm14RU90?=
 =?utf-8?B?Q29hRUtycDVoOGc0M1FTS25Selo4MjRMa1AyOVVYcEU0TzF6a0dFVWY3OVJv?=
 =?utf-8?B?S1R0TkFwaEhHcXljSmNTNjhZeTU4R1Q4S0ZHcTZkRVhQRVFoWk43Z2Q4dDFQ?=
 =?utf-8?B?R1FXOTZHUUs5MWthM2xGNGRtRXNnamZNVnZSMS9teU84cnI0NEd4UUtkNkwr?=
 =?utf-8?B?WG1BNnpNeC9xVFFQMUJWVTJBK0t5QkpOWTBqWERSZmRPREJwcGlJVE1EOFdQ?=
 =?utf-8?B?ajFaTjlJTHBiK2h1WEwvU0pmZWt6TmNxYXNvUVBlblhJNUNkRjZ5a2EzdlZC?=
 =?utf-8?B?UnJZSi9hUXFkUnJvYSthNllrbzhCbzFUQ3VoYXB2dVh4Z1owcU1TOWNjbHVk?=
 =?utf-8?B?Y2crMm9jd0pXT3oxK3NsbGRoM2YxaHl1eHl6aFRkNXUxNis2aVEzSkVlOWZq?=
 =?utf-8?B?WFBUSXVFV1lxT3dVeGZGWTlKRUNYb0ZaOVppR1l0NEFtTTRON3lXbW16KzNm?=
 =?utf-8?B?YndMRHZKd2EzL29Oa01uaXgzTytLRzRLeUFiSnhUYm1tTkF1elcwNG9lTExB?=
 =?utf-8?Q?gbsbS3h+8FYQDPRMO4n24luQ13BeHPxuzR?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e93437-d34a-4367-9511-08dba37d718e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 02:05:37.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtOnqj/1x1Vikdq90WcSqkPem2tVuKTXZdHIG3oFAQYJtsvJALmZD/I/EaBJ4jwxItEkLXU+L20LkEm1QS1+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
X-Proofpoint-ORIG-GUID: cfxzbXqJqqVZyyvYmzVKREdLEIrvT8lv
X-Proofpoint-GUID: cfxzbXqJqqVZyyvYmzVKREdLEIrvT8lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_22,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjEsIDIwMjMsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIE1vbiwgQXVnIDIx
LCAyMDIzIGF0IDA2OjEzOjA1UE0gKzAyMDAsIEFuZHJleSBLb25vdmFsb3Ygd3JvdGU6DQo+ID4g
T3V0IG9mIGN1cmlvc2l0eSwgSSBhbHNvIGRpZCBzb21lIGRpZ2dpbmcgYXJvdW5kIFVTQl9HQURH
RVRfREVMQVlFRF9TVEFUVVMuDQo+ID4gDQo+ID4gMS4gVVNCX0dBREdFVF9ERUxBWUVEX1NUQVRV
UyB3YXMgaW50cm9kdWNlZCBpbiAxYjliYTAwMDE3NyAoInVzYjoNCj4gPiBnYWRnZXQ6IGNvbXBv
c2l0ZTogQWxsb3cgZnVuY3Rpb24gZHJpdmVycyB0byBwYXVzZSBjb250cm9sDQo+ID4gdHJhbnNm
ZXJzIikuIEl0IGxvb2tzIGxpa2UgaXQgd2FzIGluZGVlZCBpbml0aWFsbHkgaW50ZW5kZWQgZm9y
IHRoZQ0KPiA+IGNvbXBvc2l0ZSBmcmFtZXdvcmssIGFzIG5vciB0aGF0IGNvbW1pdCBub3IgdGhl
IGRpcmVjdGx5IGZvbGxvd2luZw0KPiA+IGNvbW1pdHMgdXNlIFVTQl9HQURHRVRfREVMQVlFRF9T
VEFUVVMgaW4gYW55IFVEQyBkcml2ZXJzLiBIb3dldmVyLA0KPiA+IHRoaXMgY29tbWl0IGhhZCBh
biB1bmludGVuZGVkICg/KSBzaWRlLWVmZmVjdCBvZiByZXR1cm5pbmcNCj4gPiBVU0JfR0FER0VU
X0RFTEFZRURfU1RBVFVTIGZyb20gdGhlIC0+c2V0dXAoKSBjYWxsIG9mIHRoZSBjb21wb3NpdGUN
Cj4gPiBmcmFtZXdvcmsgZ2FkZ2V0IGRyaXZlci4NCj4gPiANCj4gPiAyLiBJbiA1YmRiMWRjYzYz
MzAgKCJ1c2I6IGR3YzM6IGVwMDogaGFuZGxlIGRlbGF5ZWRfc3RhdHVzIGFnYWluIiksDQo+ID4g
dGhlIGR3YzMgZHJpdmVyIHdhcyB0aGUgZmlyc3Qgb25lIHRvIHN0YXJ0IHJlbHlpbmcgb24NCj4g
PiBVU0JfR0FER0VUX0RFTEFZRURfU1RBVFVTIHRvIGRlY2lkZSB3aGVuIHRvIGF2b2lkIGF1dG8t
Y29tcGxldGluZyB0aGUNCj4gPiBTdGF0dXMgc3RhZ2UgKCtTZWJhc3RpYW4pLiBUaGUgY29tbWl0
IGRlc2NyaXB0aW9uIG1lbnRpb25zIHNvbWUNCj4gPiBwcmV2aW91cyByZXdvcmsgb2YgdGhlIGRy
aXZlciB0aGF0IG1hZGUgaXQgbG9zZSB0aGUgYWJpbGl0eSBvZiBoYW5kbGUNCj4gPiBkZWxheWVk
IFN0YXR1cyBzdGFnZSBoYW5kbGluZywgYnV0IEkgY291bGRuJ3QgZmlndXJlIG91dCB0aGUgZXhh
Y3QNCj4gPiBjb21taXQgaXQgcmVmZXJzIHRvLg0KPiA+IA0KPiA+IDMuIEZvbGxvd2luZyB0aGF0
LCBhIGZldyBvdGhlciBVREMgZHJpdmVycyBhbHNvIHN0YXJ0ZWQgdXNpbmcNCj4gPiBVU0JfR0FE
R0VUX0RFTEFZRURfU1RBVFVTLCBwb3RlbnRpYWxseSB1c2luZyB0aGUgZHdjMyBiZWhhdmlvciBh
cyBhDQo+ID4gcmVmZXJlbmNlLg0KPiA+IA0KPiA+IEludGVyZXN0aW5nbHksIGluIDk0NmVmNjhh
ZDRlNCAoInVzYjogZ2FkZ2V0OiBmZnM6IExldCBzZXR1cCgpIHJldHVybg0KPiA+IFVTQl9HQURH
RVRfREVMQVlFRF9TVEFUVVMiKSwgdGhlIEZ1bmN0aW9uRlMgY29tcG9zaXRlIGRyaXZlciBoYWQg
dG8NCj4gPiBhZGQgVVNCX0dBREdFVF9ERUxBWUVEX1NUQVRVUyB0byBzcGVjaWZpY2FsbHkgYXZv
aWQgZmFpbHVyZXMgd2hlbiBkd2MzDQo+ID4gaXMgdXNlZC4gVGhpcyBpcyB0aGUgc2FtZSAiZml4
IiB0aGF0IHdvcmtlZCBmb3IgbWUgd2l0aCBSYXcgR2FkZ2V0Lg0KPiA+IA0KPiA+IFJpZ2h0IG5v
dyBkd2MyLCBkd2MzLCBtdHUzLCBjZG5zMywgYmRjLCBhbmQgcmVuZXNhcyBoYXZlIHNwZWNpYWwN
Cj4gPiBoYW5kbGluZyBmb3IgVVNCX0dBREdFVF9ERUxBWUVEX1NUQVRVUy4gU3VycHJpc2luZ2x5
LCBkd2MyIHdvcmtzIHdpdGgNCj4gPiBSYXcgR2FkZ2V0IGFzIGlzIG5ldmVydGhlbGVzcy4gZHdj
MyBmYWlscyBhcyBJIGRlc2NyaWJlZC4gRm9yIHRoZQ0KPiA+IG90aGVycywgSSBkb24ndCBoYXZl
IHRoZSBoYXJkd2FyZSB0byB0ZXN0IHRoZW0uDQo+ID4gDQo+ID4gSSBndWVzcyB0aGUgcHJvcGVy
IHNvbHV0aW9uIHdvdWxkIGJlIHRvIGNvbnRhaW4NCj4gPiBVU0JfR0FER0VUX0RFTEFZRURfU1RB
VFVTIHdpdGhpbiB0aGUgY29tcG9zaXRlIGZyYW1ld29yayBhbmQgbWFrZSBhbGwNCj4gPiBVRENz
IG5vdCB0byBoYW5kbGUgdGhlIFN0YXR1cyBzdGFnZSBvbiB0aGVpciBvd24uIEhvd2V2ZXIsIHRo
aXMgd291bGQNCj4gPiByZXF1aXJlIGEgY29sbGFib3JhdGl2ZSBlZmZvcnQgZnJvbSB0aGUgbWFp
bnRhaW5lcnMgb2YgdGhlIFVEQyBkcml2ZXJzDQo+ID4gSSBtZW50aW9uZWQuDQo+IA0KPiBNb3N0
IGlmIG5vdCBhbGwgb2YgdGhlIFVEQyBkcml2ZXJzIHlvdSBsaXN0ZWQgYXJlIGFjdGl2ZWx5IG1h
aW50YWluZWQuICANCj4gSXQgc2hvdWxkbid0IGJlIHRvbyBoYXJkIHRvIGdldCBwZW9wbGUgdG8g
cmVtb3ZlIHRoZSBzcGVjaWFsIHRyZWF0bWVudCANCj4gb2YgVVNCX0dBREdFVF9ERUxBWUVEX1NU
QVRVUyBpbiB0aGVtLg0KPiANCj4gVGhlIG5lY2Vzc2FyeSBjaGFuZ2VzIHNob3VsZCBiZSBwcmV0
dHkgc21hbGw6IFdoZW5ldmVyIHdMZW5ndGggaXMgMCwgDQo+IHRyZWF0IGFueSBub24tbmVnYXRp
dmUgcmV0dXJuIHZhbHVlIGZyb20gLT5zZXR1cCgpIGFzIGlmIGl0IHdlcmUgDQo+IFVTQl9HQURH
RVRfREVMQVlFRF9TVEFUVVMuICBUaGlzIHdvdWxkIHByb2JhYmx5IGVuZCB1cCBzaHJpbmtpbmcg
dGhlIA0KPiBVREMgZHJpdmVyIGNvZGUgYSBsaXR0bGUuICA6LSkNCg0KSSBkb24ndCB0aGluayBh
IHNpbXBsZSByZW1vdmFsIG9mIGEgZmV3IGxpbmVzIGluIGR3YzMgYW5kIGFsbCB3aWxsIGJlDQpm
aW5lLiBUaGlzIHdpbGwgaW1wYWN0IHNvbWUgdXNlcnMgKGluY2x1ZGluZyB1cyBhbmQgdGhlIHRv
b2xzIHdlIHVzZSBmb3INCnZhbGlkYXRpb24pLiBBbHNvLCB0aGlzIHdpbGwgcmVxdWlyZSBxdWl0
ZSBhIGJpdCBvZiByZXZpZXdpbmcgYW5kDQp0ZXN0aW5nLg0KDQpOb25ldGhlbGVzcywgdGhpcyBp
cyBub3RlZC4NCg0KPiANCj4gPiBBbiBhbHRlcm5hdGl2ZSB3b3VsZCB0byBkZWNsYXJlIFVTQl9H
QURHRVRfREVMQVlFRF9TVEFUVVMgdG8gYmUgdXNhYmxlDQo+ID4gb3V0c2lkZSBvZiB0aGUgY29t
cG9zaXRlIGZyYW1ld29yayBhbmQgbGVhdmUgZXZlcnl0aGluZyBhcyBpcw0KPiA+IG90aGVyd2lz
ZSAoYnV0IGNoYW5nZSBSYXcgR2FkZ2V0IHRvIHJldHVybiBVU0JfR0FER0VUX0RFTEFZRURfU1RB
VFVTKS4NCj4gPiBUaGUgZG93bnNpZGUgaXMgdGhlIGRpc2NyZXBhbmN5IGluIHRoZSBpbnRlcmZh
Y2Ugb2YgZGlmZmVyZW50IFVEQ3MNCj4gPiAoc29tZSByZXF1aXJlIFVTQl9HQURHRVRfREVMQVlF
RF9TVEFUVVMsIG90aGVycyBpbXBseSksIGJ1dCBwZXJoYXBzDQo+ID4gaXQncyBub3QgdGhhdCBi
YWQgcHJvdmlkZWQgdGhhdCB0aGlzIGRpc2NyZXBhbmN5IGlzIGRvY3VtZW50ZWQuDQo+IA0KPiBU
aGlzIGFsdGVybmF0aXZlIGlzIGxlc3MgZGVzaXJhYmxlLCBiZWNhdXNlIHRoZSBsZWdhY3kgZ2Fk
Z2V0cyAoc29tZSBvZiANCj4gd2hpY2ggZG9uJ3QgdXNlIHRoZSBjb21wb3NpdGUgZnJhbWV3b3Jr
KSBtYXkgbm90IGJlIGNvbXBhdGlibGUgd2l0aCBpdC4NCj4gDQo+IEFuZCBhcyBhIG1hdHRlciBv
ZiBnZW5lcmFsIHByaW5jaXBsZSwgYWxsb3dpbmcgVURDIGRyaXZlcnMgdG8gc3RhcnQgDQo+IGF1
dG9tYXRpY2FsbHkgc2VuZCBTdGF0dXMgcmVwbGllcyB0byAwLWxlbmd0aCBjb250cm9sIHRyYW5z
ZmVycyBpcyBhIA0KPiBzdGVwIGluIHRoZSB3cm9uZyBkaXJlY3Rpb24uICBXaGF0IHdlIHJlYWxs
eSBzaG91bGQgZm9jdXMgb3VyIGVuZXJneSBvbiANCj4gaXMgZ2V0dGluZyB0aGVtIHRvIF9zdG9w
XyBzZW5kaW5nIGF1dG9tYXRpYyBTdGF0dXMgcmVwbGllcyB0byANCj4gbm9uLXplcm8tbGVuZ3Ro
IGNvbnRyb2wgdHJhbnNmZXJzIQ0KPiANCg0KVGhhbmtzLA0KVGhpbmg=
