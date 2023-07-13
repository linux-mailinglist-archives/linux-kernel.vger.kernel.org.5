Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CE752E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjGNASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjGNASc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:18:32 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A32D4E;
        Thu, 13 Jul 2023 17:18:31 -0700 (PDT)
Received: from pps.filterd (m0085765.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E0IIlD020758;
        Thu, 13 Jul 2023 17:18:18 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rtpvkr0ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 17:18:18 -0700
Received: from pps.reinject (m0085765.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36E0IHa1020750;
        Thu, 13 Jul 2023 17:18:17 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3rq6tmy20w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:45:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1689263151; bh=SsuqYmvhgOs5YQ+rd7b379rCKHKmilaEY7W+etlLTI0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ebe1gPMSwCvPf2jTxizt2+VROCxhyAMTCS3bVToRL1ea/TeIUDwcw0SLdSH6219e+
         q38zkDCsHQLa5mz40htJEzWAB6cWVQTlAChiMrcXyvpZn/CiP8uc3lsXjte6WDHapN
         /BXp2ss91JQ7A4Ma/T57Sgafg8lgy5cjJ3/Gocp6TaoXRMLwKJ5Hk4txW1JXkw5bi2
         aqLUHJqxsj7PBBjOUQjCoPoO7PkUNAQkl8PATzOJkouE/ADOqHWa+LXQ1NHgIx18Mr
         Ae+Kt6BAO2bGyKZ1WKQxfa5Fe/TIAj2hzY+XASD7iQZP21KiitWPS2/b3po4oBRgMP
         q4c7Vxip4OTcA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4B1BF40A84;
        Thu, 13 Jul 2023 15:45:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 24B4AA0073;
        Thu, 13 Jul 2023 15:45:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Junq820e;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 23991401CF;
        Thu, 13 Jul 2023 15:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLvseMeamyXrWebwLYN1rkgjhKmOS/IEmpmmAvbLzQTwtrn7Gd+rb63XkXP4t20W3L7XyLieQqCrqjSz+bdNk3GdonIBfV1kY4bAScR3gHD2OYRBLM81tHmLOnWqgxzmHIxArL1OyXt9OGunXFURwNLGHZqxcaDWFiB8nqHm//RIucax3XZIl4TYRDlK3QUG3Sc0WlnwhgGhdJXgUQ6cXfr4hX2mL4l2G58dQ+NiNx0aoQ8oCJxOGnY3c2lfhLw2pDCa2Mgs/EVzLxTF6K9DVJtXS5UW1ni2IqdBl44JC440Fsh9003Yt1nqHa5wJP6jnheLHRbUyEyby1jT665gvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsuqYmvhgOs5YQ+rd7b379rCKHKmilaEY7W+etlLTI0=;
 b=YshD6gTMSrWxAEdTGkcR647cKjiY7KqYn6xmEAZhrT2HbONwpvpQgZ6X0uSLruCCP1JI8dm106QgCzEp4v/y16dAtAe6vhKZjbgGs5/39P+wjYCYv+zZLtWQHwx74Gn2XOEIIE0ipnUz6vjQpbpEvQEmfhB8I1mS4o5FynNfQjIz+x23UvhfQ7RjpAeZy5c9Y7ux8SHfBnzQfS/8CyaxoJBPOC7D5TV2F0OPLNo/4x7Yl3jIvlC8elPl0cGwirH7LozFv1Iek3XFuH5Wq0altNksO3VluDyLcPCQGcTExHyuCxmuVgwQAbxVypX9S826vKb79GsdAZoYFlEy8MRrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsuqYmvhgOs5YQ+rd7b379rCKHKmilaEY7W+etlLTI0=;
 b=Junq820ewSDt0SrWkKahn8I2olnwBQhOFXfnBC7+cVr5fB69RIOG8rV333aGixbcXFUqfB/u3Jb8F80ccqn47usZcqdOSJ+0TXVgVFfHaDpW82VaiGDXDSTjYFFuRMhohp3886NSx4Ko/5zPtA18phbAFR9wluJKXwnflFE6hg4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 15:45:45 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::adba:1075:fd90:fe1d%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:45:45 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     William Wu <william.wu@rock-chips.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "jianwei.zheng@rock-chips.com" <jianwei.zheng@rock-chips.com>,
        "yangbin@rock-chips.com" <yangbin@rock-chips.com>
Thread-Topic: [PATCH] usb: dwc3: gadget: Properly handle miss isoc event
Thread-Index: AQHZtTUDkRoALjKKs02bijUQEK8Sma+317aA
Date:   Thu, 13 Jul 2023 15:45:44 +0000
Message-ID: <20230713154535.hsizn2e2fqenkslb@synopsys.com>
References: <20230713025149.24276-1-william.wu@rock-chips.com>
In-Reply-To: <20230713025149.24276-1-william.wu@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB8219:EE_
x-ms-office365-filtering-correlation-id: 03dc6ad2-20de-4b2e-a3ac-08db83b83891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgHb1wzX0omhJwyLlNY8hyMhy2dbJm33g4ZRziLD8aQjDCnzkLe/psTwA6LeGHrl5yLe/Ytb8FLc6TO8Jg14nPB+kDoE/uG09R2JMSl5/l44w1ZWEJPmrKc256xfhIpMr/XDLm36pJKpaRFelbfFN0h2hTHeDr/IOsj+3txCraDVwA8n8iQAUFYVYJIixTe88MXSKhluyXKxuLDalSTX5UnLNq9jLgJN8Oq3fhvBfmwy7jbAhIiVG8EIUajN1OwIoevmARrqZQmBH3zUxLLsC386efGys4Ea/31h7f5tEYB7+xpaE6hsY9EAB+hN+EU0rwPWZYm0jB781uYbKQrVHhJDmARgtuRk1X0GSxXCuezUYw87uv2XjHLmjy7zuVL/i/OBlQeI51jFUfQM3Fguew+B7oIhHd1W3sfTAcF3eR+23WYZR1yrq5sluhNP0IYZCTsP9qwyJ0kDZIfoq76GZZyqtiMY9t7ynnydjPtOM7XZ7yFebU+TmVwNE4mHNlPdUEMKGrWsPSSdHKxo+MC0gBIzR0TDEc+DXddMeR9II+nDOiwT9He/bHwtBIRxtHKE18efBY1m3iJsEwaUICVAH/8N4wWADGbgO6GR465bzJrdNILWvskAQQfIyg0oL4LM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(38100700002)(38070700005)(86362001)(186003)(36756003)(71200400001)(54906003)(122000001)(6486002)(6506007)(76116006)(26005)(5660300002)(2616005)(1076003)(6512007)(66946007)(66556008)(316002)(66476007)(8676002)(478600001)(83380400001)(66446008)(8936002)(2906002)(64756008)(6916009)(4326008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJhaFIyY0s0RklQUmFieDdpZGxkK3VFSWRKbC96L1F2OHR0NGQ2TkJoa0dS?=
 =?utf-8?B?SSt6S1R6bHUzUWg4RlBWMGI0NUV1cEFSc3pGbnVrUHF5VHozU05nbTN1dGFi?=
 =?utf-8?B?V3VPSVBuS0t4aGFHUGRHR0hlRTlNWmJySEFPeUFrVjVYbmhOOHloV3oybG5Q?=
 =?utf-8?B?bzJHU3BuWER3VERzMnNsa3VmMW52WWNwQlJkUDBnNUVTUEIzVC9TdElwTjNi?=
 =?utf-8?B?RVpFWTYreERBY3RwbkdFWmZ2bSt6dFJZODBIbVU1eXFyRFMwOUV1ZXlYZmMy?=
 =?utf-8?B?Q3VZZWpQSDBoekJmc0FqbWY4UjVsNTVOdWpWYUc1L2x5YWduVWxURHN1Vjkr?=
 =?utf-8?B?SW9rRFN3V2JWSWNaMnY5azlQTWhTWVQ5WmdkWjBqdDJocGxHOHIvQzJYdXJq?=
 =?utf-8?B?SEIvMHI1Mk4rVXpkTDhGVFoxbFpUTUdIYTNha1gzNU5MWDRqWWVVNVlBbnNO?=
 =?utf-8?B?RWF0ZU9PcHZNZG5hWkcrZHBSRG40WUFtRkpMa0tRTXdRTGxkcHhMQXYvem1z?=
 =?utf-8?B?N21QaXNyZVgvekZlT1QvU2lYTlVvS1BLb0JMVkNrNG92M1AxdkZlMG1GeHBy?=
 =?utf-8?B?eGlkTmtlQk9TRjM1N1pyVDBCQ3VibW0yZi94dmZaZjg0aWd4WVpldnphQUR0?=
 =?utf-8?B?aWc2OVhvV0pNbGFoYStRSVY4bHBkRHpIcVRwcW5kdFpTelZJZ0NpbmI3bSsv?=
 =?utf-8?B?d0t2RzhYR3RjMFV1T2VQaXNiT0Y4azZzS3R6SUs5cXIrU2RsdXZ0OVp2QWpC?=
 =?utf-8?B?N3MybDBWQXlQVHBVaUxkbTFnd0wvMmpmVUd2eHBCdnk1OUJ4d0o5bVpxUzJu?=
 =?utf-8?B?Tm5rblUxaHJiU1VGa2R4MmpFSW5Pd0w5Q29wbkpjOFpXSzhxUktVMkYzdGNL?=
 =?utf-8?B?UEpQUUo0ZU1icFhNTU9FaEVXbUpHNTFiR2Exd21TeXFkMmNiOUpRK1BHWjJK?=
 =?utf-8?B?ajZqczhmM1V2eit3S0tvM0VROERlcEdVNUhuT0t4MlJMVHlNNTU3blFVQkJw?=
 =?utf-8?B?bkhValYwWldiTm4xNUJWTytha3FwQWljODVBQmZBelgyMjYxVFBqNHBLWVMv?=
 =?utf-8?B?RUxodWhkOThZRHhGbmphRkdoTndRc2FRQWs4MzVRVGx2bjJrczVCUWx1OFYr?=
 =?utf-8?B?Slh2WWhXdTQweGNKRVpuWW9veE1CK1RaT1VaMnBqajJMOWZBMU4yREh1NjRh?=
 =?utf-8?B?QUw2ckp5M0xwUEx5SlR5VWNQQzE2T3ZiTmRJd3FRM203WHdiaGZHa0lzdFh6?=
 =?utf-8?B?ZTdPbXJyVjdsVEIzU3Y1d1E1R3h4ZCtxSlpJYkF4WGlHNnREbmY4NXRjb0ZI?=
 =?utf-8?B?UE52NTBwQ1AyR3c2Vkcwa05HUnZQVkZKNnE1Zjg1STZoWHNHaVZNcFpEOGsx?=
 =?utf-8?B?bFd3aHJqT251ZXRWcWdCL3MzcHBxZG9tZFlJdDJqWWtBWlk1alZKWkNhVm9p?=
 =?utf-8?B?S2pvTE9JdGpvWU9JQldxNU5icXVhKzVZMVlsYnhUUFpSbElrVWFsVUU2VWhQ?=
 =?utf-8?B?a2l5amIrVHdIdTFxKzJnd0pWTDJJbVZLY2M1bHFnSDJhdUtLbjVTOEFoZ1JI?=
 =?utf-8?B?dkljWFpXZ0Z2WTRkL2cvL1JucG1YaVJhNy9GOWhLWWJ6RGRJY2FiaUlhRmdF?=
 =?utf-8?B?MUtPNFpLbHJvTUV2QWh3T2lYYmh5bTYremdScXFNQmJuL0Z0djU5ajQzMmh0?=
 =?utf-8?B?b25zL002cGVVaFUraW90dndLUEVJREttNm56S0lnN2xKNWE2M1dEQjNSNC9X?=
 =?utf-8?B?cWFLKzVuYU0xd3l3ZmdpanZqU1BIWlVGNTkzTmZwZ0hwZ3JlVmhWY3lBUnlr?=
 =?utf-8?B?N2ZPdktORllDb0ZEZ1dnNVRiWnRPcTIrZkJnN3c2eDYvaWdDZlF2VktybEhN?=
 =?utf-8?B?NXFiTUl6RVRydERjZkRoZkQzQk5neldCWjBnZGNCekdaUUQrRGVMaXptV3hF?=
 =?utf-8?B?bUFFVWRMdHZmckVONHorb09OZkowYTdQNW51RVV3b2lHNk1VdDV4L2tSV3lS?=
 =?utf-8?B?c0l5bW1xcGxrd0VmemQyR09TUjJ2em9nQ0lWa1J2TXJkdUZETlUvMG4wQnA2?=
 =?utf-8?B?YzlDUTJwTFVDelJOMkdwWjZWdEJFc3BSSlg5eFdEWTZqY2REUEVMQUxtZ2RB?=
 =?utf-8?Q?CWDvnhfL+TKI160pX/0dwy4Ab?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6080331D20E30048A4C39450D7738A83@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qr8alieBSMfx+6ZSl3qxcYYitDv94XUOCkRwAQh0wxg5Z35VTCjkps75XGXmRgq5nPmuCjpgGEYFJorlWty+yGvVSw4FsJqXhmwTzKmr5yL5VXSPfAg9ypVUi0sd9N/tsD2QTAQjeOpIMb3Wq+s08OhbCdo4brI8aWX0zFffHocJW0yIwIrt4n1OgPHoztl+wvda88IMw/WxjuzoQACAKTLDvPHj8sEsxs1OMrOv4NfjVRwcadHjci73yzkuH2hkSbVxkEdqFCJcg83QVtyOfHvTglatyMEf1LKSTYjuaD082MoJhjxOLSBNsWvfLSunO0rIY+kryCg2YdJ7VD0i0Qg0CvEnNLSUNmChlCcR5C0eLXK7Np0NHnPYueIysqhxwx/EgmtDOavAcWF1qDn8UgB0mG1X7e85i8xmJbGdlDf72jGTBYWvSRtpFR9jF6G3URqvdS5twWRIaFWwbZAU85VAqy6E5c7/aJ5JeLDNb28KA1dIpb2nmQ4FDLp6JjyyUV9gMAXMhQERjz53EMI9ljfQwx8lXCXfg/TrYyde/N0dk8KvCJykNAg1AZrhS6+VycFY+qd3V8zETlW8zBLjyi0IQ3GQOc6f4phTVB/102L9VqcgzYhXQzdxeY3qQzLIJiznZflT0IyrOGWT5nbyRM4dqSBPnZzF4Z3gE4L0JTTzp5YEl2P2VUB6fbRoIQ+wZVS/e/t3OCS3GuXqqXevjAgL8JMbm951UggjPUdfsst4W2Z6VjVjcY4yEkDHttT2G7bZOzlvnnd6jCa0RJ/AjB9AeTCcw7TvZsUTkmki+M1YDoGWSBjdn75DMOZlxRJZa/WiIiykgDIUv6pkwdln3Wj69yHgtE9hpORfKCITyzPMjAQm7ArBRSH3ceHNCj8TylNA266xGNdYagwuAHEvmA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dc6ad2-20de-4b2e-a3ac-08db83b83891
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:45:44.9115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQlfnbzcpEbexsPD2vfvyec7F9x2lgQ5EQM32Jcz4KCondpUBqs8jDkIkIXT+m7S776yR3UJ/foavOqw5PwsYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
X-Proofpoint-ORIG-GUID: _uUjJ6YzWjMXKHDKaJF5UP7IpDePgtbv
X-Proofpoint-GUID: _uUjJ6YzWjMXKHDKaJF5UP7IpDePgtbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_spam policy=outbound_active_cloned score=98 malwarescore=0 mlxscore=98 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=-162 spamscore=98
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000 definitions=main-2307130139
subject: Re: [PATCH] usb: dwc3: gadget: Properly handle miss isoc event
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKdWwgMTMsIDIwMjMsIFdpbGxpYW0gV3Ugd3JvdGU6DQo+IElmIG1pc3MgaXNvYyBl
dmVudCBoYXBwZW5zLCB0aGUgY3VycmVudCBjb2RlIGp1c3Qgc2V0DQo+IHRoZSByZXEgc3RhdHVz
IHRvIC1FWERFViBhbmQgZ2l2ZWJhY2sgdGhlIHJlcSB0byB0aGUgdXNiDQo+IGdhZGdldCBkcml2
ZXIsIGFuZCB0aGVuIHN0b3AgdGhlIGFjdGl2ZSB0cmFuc2ZlciB3aXRoIHRoZQ0KPiBjbWQgRFdD
M19ERVBDTURfRU5EVFJBTlNGRVIgYW5kIHdhaXQgZm9yIGEgWGZlck5vdFJlYWR5DQo+IGV2ZW50
IHRvIHJlc3RhcnQgYSB0cmFuc2ZlciBhZ2Fpbi4gSG93ZXZlciwgZm9yIGlzb2MNCj4gZXAgaW4g
dHJhbnNmZXIsIGl0IGNhdXNlIHRvIGxvc3QgdGhlIGlzb2MgZGF0YSBvZiB0aGUNCj4gcmVxLg0K
DQpUaGF0J3MgaW50ZW50aW9uYWwgYW5kIGV4cGVjdGVkIGJlaGF2aW9yLg0KDQo+IA0KPiBUaGlz
IHBhdGNoIG1vdmVzIHRoZSBtaXNzIGlzb2MgcmVxIHRvIHBlbmRpbmdfbGlzdCBpbg0KPiBvcmRl
ciB0byByZXN0YXJ0IHRyYW5zZmVyIGltbWVkaWF0ZWx5IGluc3RlYWQgb2YgZ2l2ZQ0KPiBiYWNr
IHRoZSByZXEgdG8gdGhlIHVzYiBnYWRnZXQgZHJpdmVyLg0KDQpOby4gTm93IHlvdSdyZSBicmVh
a2luZyB0aGUgdXNhZ2Ugb2YgaXNvYyBlbmRwb2ludCBhbmQgYWxzbyByZS1vcmRlcmluZw0KdGhl
IHRyYW5zZmVyIHNlcXVlbmNlLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXaWxsaWFtIFd1IDx3
aWxsaWFtLnd1QHJvY2stY2hpcHMuY29tPg0KDQpSZWdhcmRsZXNzIG9mIGRpcmVjdGlvbiwgaXNv
YyBkYXRhIGlzIHRpbWUgc2Vuc2l0aXZlLiBJZiBhbiBpc29jIHJlcXVlc3QNCihvciBwYXJ0IG9m
IGl0KSBkb2VzIG5vdCBnbyBvdXQgYXQgYSBzY2hlZHVsZWQgaW50ZXJ2YWwsIHRoZW4gaXQncw0K
ZHJvcHBlZC4NCg0KWW91IHNob3VsZCBsb29rIGludG8gd2h5IGl0J3MgYmVpbmcgZHJvcHBlZCAo
d2hldGhlciBpdCdzIGR1ZSB0bw0Kc29mdHdhcmUgb3IgaGFyZHdhcmUgbGF0ZW5jeSkgYW5kIHNl
ZSBpZiB5b3UgY2FuIGhlbHAgaXQuDQoNCklmIHlvdXIgYXBwbGljYXRpb24gZG9lcyBub3QgY2Fy
ZSBhYm91dCB0aGUgdGltaW5nLCB0aGVuIHBlcmhhcHMgaXQNCnNob3VsZCB1c2UgYSBkaWZmZXJl
bnQgZW5kcG9pbnQgdHlwZS4NCg0KSWYgeW91ciBhcHBsaWNhdGlvbiBwcm90b2NvbCByZXF1aXJl
cyB0aGUgdXNlIG9mIGlzb2MgZW5kcG9pbnQgYW5kDQpzb21laG93IGFsc28gZGVtYW5kcyBubyBk
YXRhIGRyb3AgdG9sZXJhbmNlLCB0aGVuIHlvdSBjYW4gd29ya2Fyb3VuZA0KdGhhdCBmcm9tIHRo
ZSBnYWRnZXQgZHJpdmVyLiBIb3dldmVyIEkgZG91YnQgdGhpcyBpcyB0aGUgY2FzZS4NCg0KQlIs
DQpUaGluaA==
