Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298BF7EE53D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbjKPQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjKPQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:33:39 -0500
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA7AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1414; q=dns/txt; s=iport;
  t=1700152416; x=1701362016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eFAxG4/WJr++CtiX1rmGXrTGRWDhBBL7+JWVT6R2HKs=;
  b=GOVD50qPdznW5ANmSDNYnnhMyVfUGtPQoPfc46Cg2CQ6Nzh0FH/S2qiZ
   IAFBPDdPCHku2mFoUaU2dTQTV2xe8RU8cOHBVke/Ysw1AvHe+qOKiZH1+
   bWlrL4+IfzArBpnP78o4W9ii3myanKLEzEJsX6NN+slYu3Ykk9Xo2xiDx
   g=;
X-CSE-ConnectionGUID: a12N2I93Qfi7t1rHKvISYw==
X-CSE-MsgGUID: l8F0AX/oRj66POqY2+pewQ==
X-IPAS-Result: =?us-ascii?q?A0C7BABqQ1ZlmJNdJa1aHgEBCxIMQCWBHwuBZ1J4WyoSS?=
 =?us-ascii?q?IgeA4UthkGCJYV6jEMciyUUgREDVg8BAQENAQFEBAEBhQYChygCJjQJDgECA?=
 =?us-ascii?q?gIBAQEBAwIDAQEBAQEBAQIBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNh?=
 =?us-ascii?q?kUBAQEBAgESKAYBATcBDwIBCBIGHhAQIhcOAgQOJ4JegjwjAwGffAGBQAKKK?=
 =?us-ascii?q?HiBNIEBggkBAQYEBbJtCRiBMIgNAYoOJxuBSUSEPz6CYQKBRhqGQ4NthTgHg?=
 =?us-ascii?q?lWDUo4YXSJHcBsDBwN/DysHBDAbBwYJFBgVIwZRBCgkCRMSPgSDLgqBAj8PD?=
 =?us-ascii?q?hGCPSICBzY2GUiCWxUMNEp2ECoEFBeBEwRqGxUeNxESFw0DCHQdAhEjPAMFA?=
 =?us-ascii?q?wQzChINCyEFFEIDRQZJCwMCGgUDAwSBNgUNHgIQGgYNJwMDE00CEBQDHh0DA?=
 =?us-ascii?q?wYDCzEDMIEZDFADbh82CTwPDB8COQ0nJQIyVgUSAhYDJB04EQkLLQM9A0QdQ?=
 =?us-ascii?q?AN4PTUUGwZnonqCGIEgll8Brn0KhA2haalymECoKwIEAgQFAg4BAQaBYzqBW?=
 =?us-ascii?q?3AVgyJSGQ+OIBmDX495djsCBwsBAQMJimEBAQ?=
IronPort-PHdr: A9a23:7EiGghyD1IeKsW3XCzMRngc9DxPP853uNQITr50/hK0LLuKo/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YAZ8IOX4HpHbp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:7PV5N6105ICCyXd4gPbD5SZxkn2cJEfYwER7XKvMYLTBsI5bpzVWm
 2pKW2nUMvzYMGvxedAibYy0oUoP65LVzYVhHAo+3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ1yFjmE4E71btANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXV5
 bsen+WFYAX+gmctbDpPg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauG4ycbjG
 o4vZJnglo/o109F5uGNy94XQWVWKlLmBjViv1INM0SUbreukQRpukozHKJ0hU66EFxllfgpo
 DlGncTYpQvEosQglcxFOyS0HR2SMoVPoeXhe1nu6vWdzhLaKmHM4OtPN3ApaNhwFuZfWQmi9
 NQCIzwLKxuEne/zmev9Qeh3jcNlJ87uVG8dkig/lneCUrB3GtaaH/qiCdxwhF/cguhCFPDfa
 s4GYBJkbQ/LZFtEPVJ/5JcWxbf43iemLGwGwL6Tja5nzTD6/Et26rqzbuLyY+3QBt1YgX/N8
 woq+EygUk1Fa7Rz0wGt9nOqm/+Kni7hXo8WPKO3++Qsg1CJwGEXThoMWjOTrfSni0WzR8hSJ
 mQK9Sc066s/7kqmSp/6RRLQiHqFuAMMHt9RC/YS9g6A0OzX7hyfC2xCSSROAOHKr+csTjAsk
 1SOhd6sXGUpu7yOQnXb/bCRxd+vBcQLBWZbPwlebFpe2tfi/51qlDLsUPdYIbHg27UZBgrM6
 zyNqSE/gZAagsgKy7i38Dj7b9SE+8ahoukdu1i/Y4610u9qTNX/NtD3szA3+d4FfdjGFgPe1
 JQRs5LGhN3iG61hg8BkrA8lJrCi5/+fPCbbhzaD9LF+qmz9ohZPkW2siQySyW9zOcoCPDTue
 kKW4FoX755IN3zsZqhyC25QNyjI5fa8fTgGfqmJBjarXnSXXFPclM2JTRLIt10BaGB2zckC1
 W6zKK5A90oyB6V91yaRTOwAy7ItzS1W7TqMHcijkE//iufCNS79pVI53L2mMLhRAESs/l29z
 jqjH5fiJ+h3CbenOXCHreb/03hQfSRibXwJlyCnXrfTflU5cI3QI/TQ2rgmM5d0hLhYk/ygw
 51OchEw9bYLvlWecV/iQik6MNvHBM8jxVplZnZEFQjzhBAejXOHsf13m20fJ+d3rYSODJdcE
 pE4Ril3KqgXFGyepGxAMPEQbuVKLXyWuO5HBAL8CBAXdJ97TAuP8djhFjYDPgFXZsZrnaPSe
 4Gd6z4=
IronPort-HdrOrdr: A9a23:xgOkiKszS6uc3wExmJ7R5sOx7skCBIAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwSZVoIUmxyXZ0ibNhRItLxGHdySqVxfJZnPvfKlrbam3DH49mpO
 ldms1Feb/N5DdB/LvHCWWDYrEdKZy8gd6VbITlvjRQpGNRGt1dBm5CY27xfDwSNW177NgCZe
 WhD6F81kKdkAEsH76G7w4+LpP+TrPw5fTbiDc9dmwawTjLpwmFrJT9FB+V1AofVTRg/ZcOmF
 KuryXJoo+Yn7We0BHz60//hq46pDLm8LR+Lf3JrvJQBiTniw6uaogkcaaFpioJrOam70tvuM
 XQoj87Vv4Drk/5TyWQm1/AygPg2DEh5zvJ0lmDm0bupsT/WXYTF9dBv4REaRHUgnBQ+O2UkZ
 g7mF5xhaAnVC8orx6Nv+QgkCsazXZclEBS19L7SUYvC7f2JoUh8LD3t3klY6voVBiKnbzPVt
 MeTv01IJ1tAAynh7ezhBgy/PW8Gns0BRuIWU4Ep4ic1CVXhmlwyw8CyNUYhWpozuNxd3Bo3Z
 WODk1TrsAFcuYGKaZmQOsRS8q+DWLABRrKLWKJOFziUKUKIWjEpZL76Kg8oLjCQu1G8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBGGwRy7kxM1S74Vw/rf8WL3oOyueT01Gqbrtn9wPRsnAH/
 qjMpNfBPHuaWPoBIZSxgX7H4JfLHEPOfdl8urTm2j+6/4jBreawNAzKsyjUIYFOQxULV/CPg
 ==
X-Talos-CUID: 9a23:iZHXL21EqMsxBjXOxpOWcbxfE5l/VCf8nSzpLU7nFT9zaJ6LaGSh5/Yx
X-Talos-MUID: 9a23:tPf/uAoE5dsbACXelJ4ezzUyGp9B0+OpMkJTz60hovjedjR9JA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:33:35 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 3AGGXYno031189
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:33:35 GMT
X-CSE-ConnectionGUID: 33fZnu+cRa+4LqhiY8FZ1g==
X-CSE-MsgGUID: xQxCZZzPSHOeJ7bylbehmA==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=danielwa@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.04,204,1695686400"; 
   d="scan'208";a="8667584"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:33:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6+PlBa+H1COpu683iGQhxccnnFn+yFIRx9Oc42Z6OOA6FaPf3//uNx1a7tOpttR0hwtFlS/9TaEflFqU/V/5CdbEmBRizfwz2Qvv78A8/deqlO3/WwzorBmNT5QWkso1wOwwbzU0HMsGgBQbwOQFp7dGFbSxDERtdujg0WtQlMQ4DGodNn7zkSZzi9s+Dxmpudbr5AQSTlxNjyPsW+ed6dTNOgChyNFZ6MUh3YrbcjP+kv/LPuR73ghSJZJ/H6raHvGxeFl+ZYRoqBKsMwj/yFbcZcu0ZEjppAAVVU4rdo86Um3QFW9lJO6rzlNzJr6RRWUzYKoC1LcBGN9rExOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFAxG4/WJr++CtiX1rmGXrTGRWDhBBL7+JWVT6R2HKs=;
 b=BOhWtbChg3wJ/lgqEv91bZ4Qc862RXOs9OasPw9fymGeTQV1p2eIVuEwk6t9vQhB6jCztpvIzWVl2aD6hwy9pEY1qZJX+cL8cHaTUp66MJdtPIfv/+ScTwnY2v6WCXQn2Q4K11VpHkRSuMS11ds/7hSaxPRsQXXMNMHRqhrHrpl3xLI4ka71ca+tVT4++7oCJs2Jb6L/ec0fV8mq+7/XmvHYSSo5mg12DrJpgTjdTiOtI1w9XqQYhVQw2bhJoZB3uZj33IRjnvs0hpYnpFEUMEWP3FT/qX1N2B5UHYsFuI5eQB2DJVWyuUEokBBwS+DdZQYnA5QzqcKGCW/vsC5/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFAxG4/WJr++CtiX1rmGXrTGRWDhBBL7+JWVT6R2HKs=;
 b=W9bqD0LtH86VVATcYs4emZtrk2Gxws/LceimluuPQL6AKftFxpJhd97poYsI3uhAAYhlWVqpU4ZT49RSLNyBHCZUSAC2+8/4Gtj5cgEVaOI6Yq97rs+cftVXDP28uM2LS2xAzxcZafx7k8dj/K4Dvwz/vw434Wea3JRA+uqmlAQ=
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com (2603:10b6:a03:422::15)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 16:33:30 +0000
Received: from SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::a59:2fb9:3446:4f8]) by SJ0PR11MB5790.namprd11.prod.outlook.com
 ([fe80::a59:2fb9:3446:4f8%6]) with mapi id 15.20.6977.018; Thu, 16 Nov 2023
 16:33:30 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Rob Herring <robh@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>,
        Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        Sean Anderson <sean.anderson@seco.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] of: replace command line handling
Thread-Topic: [PATCH 7/8] of: replace command line handling
Thread-Index: AQHaGKqimZTUK+RlrEOBqmo5AZNg8g==
Date:   Thu, 16 Nov 2023 16:33:30 +0000
Message-ID: <ZVZEWrUKh8N/a7SL@goliath>
References: <20231110013817.2378507-1-danielwa@cisco.com>
 <20231110013817.2378507-8-danielwa@cisco.com>
 <20231116160936.GA2376455-robh@kernel.org>
In-Reply-To: <20231116160936.GA2376455-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5790:EE_|PH0PR11MB5142:EE_
x-ms-office365-filtering-correlation-id: c8f209d5-b50b-4462-5b57-08dbe6c1c4cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qiSNVa3w9N//VzXPf2FT9Q+0RKoCxknpv2ksPkGpXPD2RDg3SYKYOaxTMT8OwqijyXSQXTtkuoDj+81p+CAK0Yj49N8u25X2eBlzj2Dr4LI3V5ao/wA1t/nVlltam8j1cl/c7aQQBdFIIIplrkY/OAPgJNfd0fQIKv7HtfCxmiDYW6AsLJJqHjYaE1muTxGsHJWj4qi+GGeTewCSnKKd0PzO4Qr+jNBmJgVLvTmqcQfVH03161PD5vCVbnwY/+TJayGkRPjyWXnfKmt/LyVsUSW8214GMk8FfmzmGZqaAPSgdiE2mRajLf6LfPULfjpHTQhkumkzebhbrhRhGL7iavhe5cF/e0qI55FIKx4fyBRyR7o5Po+rxt21hXLNZlW0EvRQyq34SwCORrZKdiCvwEE+PoxnjTp8o9Bz9pqS64UxwsUJunnkKrRReH/ds3eGbuaGPSOfFNsIo/uvySx9nUPbhyGXH+l7to08cg0spLTbF8iiGOWwmpDfEMvp/kesGffrx0n244WhqUyiAzL3ZIDh1hMC0yGHy953AAVIomPc20IlZNjVSeW0V12Q88dGpxNEUXwht40+5Xhw46OvYealsjF5txOXKPMImBov4wxFFPLPfQPDqMRwjXrs1JJz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(71200400001)(122000001)(9686003)(6506007)(6512007)(2906002)(41300700001)(7416002)(76116006)(4326008)(66446008)(8676002)(5660300002)(8936002)(86362001)(66946007)(38070700009)(316002)(66556008)(64756008)(66476007)(6916009)(33716001)(54906003)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Iv9noZjdTO+6KCpTjwc++wQPPEhMtQ3l9xsnkmGdhD36iEZMTxmxsJE4U6xM?=
 =?us-ascii?Q?CSUrSZUC54AV0/8DmDj5n060BurmjKMkTIm6WYG2PMTNTg0A2MJXURoIB4Kl?=
 =?us-ascii?Q?EsUGu/Sppw9alVwYw8xRdilyevY+GR+Y+lSkiz1wSWvkNo7LPuFf0NGFyTrc?=
 =?us-ascii?Q?n9mx0xWqNr5ESVLIbJZs7w6ykpxJQnZAuTCI5rsRC8b9e3AltLjHIP2NCFYF?=
 =?us-ascii?Q?O+iDJb14pzxRUHfgzKdLsnzd3Kog0zNUFIefI+MjQN4IKplwb6QtZ829wGOq?=
 =?us-ascii?Q?ePYN5lTPQr2zvQ5MkOtLS5nhUJPv4riqhblijR08+zC/FLhazSh1DXjxBORe?=
 =?us-ascii?Q?mrkt1p9LTcdlDPs1vuHennpYGbVjJKWye+5iABTD5MqJw/TsTAVvP6P5IIdD?=
 =?us-ascii?Q?UMv/UWVG++6chor+QzbaON9lCgdzuEDswNT/ZxhwY8FA/I/ghSW76vs8d1Im?=
 =?us-ascii?Q?FUELzF7xki62V8S5ELF+HT+X60auQOvV3krDEYskylsNjVQnnAaBC2jt0kIa?=
 =?us-ascii?Q?5n8oCvEDpa4bFmceSVbEZVy1PweZHgY5Kjn8qr5ZZ3Setq8GnhKDiZVZPJrJ?=
 =?us-ascii?Q?CxsZIbputJ5WIYGrH2XJvvyCckkzkkfatnf40syOZq52967XFsFr+XvYZ2fK?=
 =?us-ascii?Q?8Y675CJ9KzxvKFmo+kbGF7iATHl7k1ebeyGGIQN9HzkYEUlQlqQgf2DJEDmZ?=
 =?us-ascii?Q?bamwGSCMpGYeOjVbLPxCiCtRLpPCylQggmzB5mb4MIS29t0hxTK596oXiNN1?=
 =?us-ascii?Q?z4Xeke08h+DKrQcKE8eURn6ve85UhuTUk+FAkEfKoBL4K2rwQokYoWdEcIMy?=
 =?us-ascii?Q?nE4LeMJkOJkPU1p3E+Wb3+NeJrvlvokNC6ZSUos5xZyUaoS/BJ24vTCJCzSU?=
 =?us-ascii?Q?5P6yQEFTnLeAsRKEaqAeAGRCVBJHebbBZAQ4KUn6y+4px45/yAdlK6p2xaPO?=
 =?us-ascii?Q?vnz/r6H0VU3mysba5uS3l3miasLh0Y6tn/VTjj4BbB1eyZPk0zluvW0NT5w5?=
 =?us-ascii?Q?3+2aYL15XDB7aBSQ1PD7fyo1OCEyfx48nLOKi2KLgL8SNYosr5gv4OPtoiM6?=
 =?us-ascii?Q?z7cyj/PiTpvv71quuPD+CIjw4QtKvrQUUIyJIySJgiueZFqEAmHCN65i1XSk?=
 =?us-ascii?Q?Vcpl/5QQPSElMOTL8+E+dqP4iUgCLH8MOip7XnhH9QEnENfgHUywqRPNpDUd?=
 =?us-ascii?Q?kA8Tf3sh94RuBa7sGx+PWSyNTKv/PP8G89grVK77dqcX+swWTGlINi8zS5i5?=
 =?us-ascii?Q?YFJ5yuzpWlWncdpfaXWeK+Wg3iuIdNCdF1cUAV116QBszqKsgmAVMkdAODZe?=
 =?us-ascii?Q?ufcFEIQPygjP99yd1DFJ/sBvlyUHkV/c2BnXv4pXI8XokPNM3ub7RpljD7a2?=
 =?us-ascii?Q?tqFoATlrApn8XRKeJqqDE4Wxz5M4PSE2zsCs0KrVbSV1ojzwKuWB7bgOxJSa?=
 =?us-ascii?Q?PIIW87cdz3pCrZVD0h6YUiM638sNQzRxnEqynPux69VEt6ZBFFAeALEPnKkw?=
 =?us-ascii?Q?ISh/pNnAq1NXRDtYFeiq9KKG4iLXs+u2w3ilnfQtIy8+zLLR75v2h22ZHdkb?=
 =?us-ascii?Q?I2AtSk41RwQ2RvmAif39K0Pf9TDUR5d94UOEum5U?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <405AF74430C7C942B5D4E2C47414D4F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f209d5-b50b-4462-5b57-08dbe6c1c4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 16:33:30.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lRKbfiUnd7kxx2S/D3MOjE6RhSdHvBIndWCTFBOKm8V/EGRKtJzk2ZQzVhWpWaTJeXhwpwFuU5WtOiTGo4QRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:09:36AM -0600, Rob Herring wrote:
> On Thu, Nov 09, 2023 at 05:38:11PM -0800, Daniel Walker wrote:
> > Rob Herring has complained about this section of code. I removed the
> > command line handling code to the cmdline.h header. This hopefully make=
s
> > it easier for Rob to maintain it (at least he doesn't have to look at i=
t
> > directly anymore).
>=20
> Well, my goal is to eliminate drivers/of/, but no.
>=20
> > I would like to add a Kconfig option called
> > OF_DEPRECATED_CMDLINE which an architecture would set if it uses this c=
ode.
>=20
> Which architecture needs this code? Do we wait and see who complains=20
> their platform broke and then go set this option? In the meantime, new=20
> platforms started depending on the new behavior and setting the option=20
> may break them. So we can't have a kconfig option.
=20
 I think you misunderstood the comments. The objective is,

 1) Remove the code in drivers/of/
 2) Remove platform specific command line handling

> > This would allow a platform to use the cmdline.h and the added function
> > directly and remove the Kconfig option. This change would be in a subse=
quent
> > patch.
>=20
> Per platform code handling the cmdline is completely the wrong=20
> direction. Per arch behavior is bad enough.

This code unifies the handling into generic code outside drivers/of/ .

Daniel=
