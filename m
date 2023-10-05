Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC61B7BA0AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbjJEOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJEOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B17624EAD;
        Thu,  5 Oct 2023 04:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANFpj4IULXdF8ImYyo9w7NI5ys0aC9w9O8uKbGpV8qt1ZzEG41OKjYpPxKQuVO3a/uDy1DBciO507fKJn/Bj3gR6TPIVqGFpNzB/NjMeZ6reGGJLIlRAkmQcwsRcz3fh8EVYHXOqoPIeQgramDE8SFf2ndS1HPDA/qAqElEONXa8I3N/1YPL0xf+py/EN5atbFCc8IMf2sgvNU7+12WbUirB5s9KRwvcnnuAlNVW4HozyOQlAfqDSBxGgc3GYYiFY1osRSHrl9i5AgAogadCu1vMj82DbC7GDvwQkRn2MD6hglnVT+e4onPIiEqzAP+aMGXe5+tLxHvXwJ6+PEorTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2om6Pqhpb5FBuR6EnrS8XYy7+AeZI92VMlG5M2Ul03E=;
 b=JKP/MxjDNuvGyWTvj8dCkIsUXok3buCMyEKKo37VCepzYeH1CqlSbZzi8N+07bNIUed3hfCq0h/EbeQ36JrcS+TH1OVPDKE2juxrwhno497kqiB8feiMCszVANjqWh1GCDPuvfBwm/mtDf47sFMXc4UBZb3IAC1ZwpOC6FnVboGM5ccqxnhVzTPWo7qGQavagqPSwMdlaZy9zpsM83wvVx69xKkHj/xUZOVn3TgmKa6PVBGircw1V0CNJq7O9B3BXeXZT7sb+Lfz+ELKOO0O2gx4gxkmJQkn2ERkBTm4Y6EGBjVEQ27f3H6wOpP8HxcY/h/qLlLEwf6M5a4nJk62mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2om6Pqhpb5FBuR6EnrS8XYy7+AeZI92VMlG5M2Ul03E=;
 b=xMo2oH45Uh99y9fKt6lReezE+dgqWAOZqFwJupDXMogfOPcxkEy+kXbOdsL2m7/3cfVQeEQk0WinPAofgDT6aq4YSaSfmVsITQr1sX8yMn4ZibihLin6x7ySWH2mlE7bgR/EcaKVhPe4y0GmAOekvicCz0F1Su+706kfUad2kNyViA4w38JqZv6TvDR/YY5Fu1HxdPd26YzLvtw2OFK4qrH6S6aCRXhnPPqI8FiIpu+yrCBFUMBhntATAJly5wMBXRXDcNhEH35ahWW6lcRhPKUS7cY6QLBPeLZ7FyKD9sN/wQvWOoMY/aWV7sQ1A9Qf89KPRvemDTXIj+aYpvdLug==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by PAWPR10MB6878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 11:38:27 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92%5]) with mapi id 15.20.6838.028; Thu, 5 Oct 2023
 11:38:27 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: RE: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Thread-Topic: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Thread-Index: AQHZ9hsms1Jp2Ee+x0K6pi4iDpsHIrA4XssAgADExJCAAeHBWoAADgKAgAABXnA=
Date:   Thu, 5 Oct 2023 11:38:27 +0000
Message-ID: <DB9PR10MB5881E8D3903C19EBAD9AF895E0CAA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <2023100320-immorally-outboard-573a@gregkh>
 <DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
 <2023100421-negotiate-stammer-1b35@gregkh> <20231004085720.GA9374@google.com>
 <2023100448-cotton-safehouse-aca2@gregkh> <20231004125704.GA83257@google.com>
 <2023100435-xerox-idiocy-5cf0@gregkh> <20231005090311.GD83257@google.com>
 <2023100528-directory-arrogant-2ca9@gregkh>
 <20231005104311.GG83257@google.com>
 <2023100512-charger-cherisher-9a3d@gregkh>
In-Reply-To: <2023100512-charger-cherisher-9a3d@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=cd53cfc0-f0ab-48f7-8496-12dc0a54646c;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-10-05T11:34:24Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|PAWPR10MB6878:EE_
x-ms-office365-filtering-correlation-id: 30fcbdb8-a1ff-497a-9fc5-08dbc5979736
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4PEnTY4b7B9qXi3WUc5KfluhourXXFwSogzzIX/ffuDVr/xrJmpDFNvM0kDt4xMeCw+VA7+PvtYRMCemrGaRVetRB/RHcpxFn9qePnkdNIRkOujKwVihZtkBM2AYg5F4maynTc9+Lz1sHYnRsqsRV4SFMwJo1GVtqzjCoSuaKqwa6s05ud5T9+GMKrfW0J3KUtzVmjZteRUJvP3FA4VKwGaKpcgc3Fdf/6HzR81/1SkuXlgLwsU0Q/MUN3dA1PGd/jYu4VF29VlHGkwmhPLSAfb9bI4lcfiBeBLLkHpAD/DV+T0qiQ1Du2q3qN1ID6fMPYmjpbFiH/RX4ahiagXgbfBB3uEuX0/9BAnaAB8slUaWB6+SAjzVXCxIFumzET7aNNkkLarA2WiBsniguwPqqerwvG2LmOJYLWuaWYHhuJKpN+r6I81oS57OQqUhtnp2j3NxBaE4d26Z6RiTCfvhqMV1RshGRcb/GfxxcLzvXiw+kcmZwMJTYQmekgXJoyLXWYvj1Nnl+5IEUQwXgCzum75xMvNe6nfpqnV+xqo36kijIyrSI1juH6cdp1IHb6B570NXsWEAUylL3r9W5pYfLo93xaVEgduLnhc/WAxu+Ea14ZmxLIe4sYMEYIlYPm5h7qhq0/r/IL1kOutwqa6cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(2906002)(76116006)(8676002)(5660300002)(66446008)(316002)(8936002)(54906003)(64756008)(4326008)(66556008)(4744005)(110136005)(52536014)(66476007)(41300700001)(478600001)(9686003)(6506007)(7696005)(71200400001)(38100700002)(55016003)(26005)(122000001)(38070700005)(82960400001)(33656002)(86362001)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+JWk2GTVirY6U7vnpVmW9/LjRNGNcWuaKyw0WZlqyju4hi6Dt19RNG5tb83X?=
 =?us-ascii?Q?Rx9b/Sb5l48B/b9pvJKXHMix+p4rgQbFWBmUoryldMa+J9fB6/+lUBeOjndy?=
 =?us-ascii?Q?M3J9ghwnwbilfHfPIvSknrNPflYum6luQ8r15JvMsrKMKOHgAffWHDStQz35?=
 =?us-ascii?Q?SjbBOay8rvuPoOYaqLO1iohB8BnYeJ5WDd9DwUiItIXifoku5tzucxrN6Mru?=
 =?us-ascii?Q?cbndn/JAPNO1d4vxYjjM7UUibLLNAwbx46Dtviek0lotbflvNP/sMnJcvGoJ?=
 =?us-ascii?Q?StFxDxV3/2DWJwoTQyGViN+U2rUr86r2Z3Nan0Q123OWoLpk5EHTKu233eeX?=
 =?us-ascii?Q?wHs0ZYgAwhoDAC6UAlZKQahIomoAdbQPHy5BrMAOqwys/EDRugoegOf96jfW?=
 =?us-ascii?Q?EKP/Os7MEw4oG/Ar0ygUBqjziinyB+C2/ZVcZ96kSpt4oQivU3lmXxPeWQSW?=
 =?us-ascii?Q?eRS8mXXZ+7HIHIvDhTb0yBvQLML+nLDWM0/qy5yd7jsEOg/w85W6qf8cX9Y8?=
 =?us-ascii?Q?u2q3ji+Kfwa5Y4XlDOfyxSOEw1SMzNhKRgVXsxClPMR0PeM9frYouM4v9OzI?=
 =?us-ascii?Q?r1TvF/RQllzIYuKMlXVbApG7wwE1uF8nhV0LpnAmrwibhUhk6kHXs+o6UwIH?=
 =?us-ascii?Q?ss698kOo1fdUehOzmG8VxraGkqzBjUCeHXZT6LBX2s2/Hm4iVTfxAIawPW3R?=
 =?us-ascii?Q?wIZ20cBwvmxvMsNimng3cHz5z7qz83yR5twqMR9hPV5e5Dv9JrRLEAaFkWUo?=
 =?us-ascii?Q?JaHni/c7OfczsZLF1bUMm1YhcPzpjdU9eLPGReiF+XgGQZH5DTR0sJ+hukwJ?=
 =?us-ascii?Q?K8/41x4ZmVOaE1bHAyoN03HkwHAxvLrbM+o9cREIqKk10WrCZSzjcvbVPK1F?=
 =?us-ascii?Q?OCg3WRg6xqVk6YGya4SQliiCXXAjmPNHaIKoXH/2ooXJP/t3eJE93aNjskrZ?=
 =?us-ascii?Q?S1uTQnmrJlwuKxNMB7q5lfNknkDgeNWigSriMIDY6qlStXSShnZmrL5pD8Du?=
 =?us-ascii?Q?dMxHbq7VIDxUKPwG4mjojiZaprYtdBnwu13RnwwSyLhgRYjm91BC204qMw7f?=
 =?us-ascii?Q?7HT9hFpNA6C742dgO2qU9cY4TXAnT4HfOZobZZBEVDRRUqR/9FplWGtRqPml?=
 =?us-ascii?Q?9Lwzdt+SYzFcx7f/Xued/6+0KFf0bynJJIUZNPrnsrRuqcxi//e/9UOMl6ce?=
 =?us-ascii?Q?G3QjKIfIiuS1POSfICYxuqi3SDHqQk3kaxMdgYtfcyZM6xjTiK0zy34G5DwS?=
 =?us-ascii?Q?UC77WCFT6fzK9D9mXftb/dxSYFE1alro6CSPYEJEY6KuZlWS3kKesy4iX/lO?=
 =?us-ascii?Q?dCGq2E2F8PacceuF8bMqtx8wlbLK303pBMcne9CnkdBO97JVmVvEXFexkbkd?=
 =?us-ascii?Q?zLnWK8qxiaiuVVIsIT2MLIPMv9etQTkOnK+bRC0AcClJzHLW7PqHenbdcks/?=
 =?us-ascii?Q?3HVMfkHj/Fv9ZhwOlF/5dbvkd6CZ6yNFc1HoXwEEIiqhKwGZPCYKtFEHkHMQ?=
 =?us-ascii?Q?aibZmG9ClnGePYe8CZn3hfCyL1fB+J3BOo2nxoIq4AGJlDbRPvLip4oGOBhs?=
 =?us-ascii?Q?sdP0a/nQ2aqhW8YYbgbssFehr10OLVSkytT3z2rY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fcbdb8-a1ff-497a-9fc5-08dbc5979736
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 11:38:27.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFwYFnmflurvsv08pga6+YdGv1uKJBSiqPBDmOWw4VRUsWhgLz+XCA6kftKP4n9eHVy2I2IxVnUB2bZW0U2EGwzjOkgttPIIZgdXPp4Jk50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6878
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Would something like this tick that box?
> >=20
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c index=20
> > 1f3aba607cd51..5c1d2fcd5d9e2 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -3716,6 +3716,10 @@ static ssize_t gsmld_write(struct tty_struct *tt=
y, struct file *file,
> >         if (!gsm)
> >                 return -ENODEV;
> > =20
> > +       /* The GSM line discipline does not support binding to console =
*/
> > +       if (strncmp(tty->name, "tty", 3))
> > +               return -EINVAL;
>=20
> No, that's not going to work, some consoles do not start with "tty" :(

Also, I would recommend exiting as early as possible. E.g. in gsmld_open().
And please retain support for real serial devices (e.g. ttyS, ttyUSB,
ttyACM, ...).

Best regards,
Daniel Starke
