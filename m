Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE517EBC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjKOELQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:11:13 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24B6B9;
        Tue, 14 Nov 2023 20:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB10c4LPw7RSrxVoY1wbINjxgHi4WCUAvbtU5lXtzzOQyCG5FOJcOnEuBLPpYWFaNpmyaukKY8Cquq+ULP0nAM2Z1r7vLICgH6XhnqjZE0Dqg6ScfWJ10FADgUgpSafIoPrTFy4yXvKLw+psi63fccCa0tQZ2EvkJ9KyhOJkAo1Nrf6O+ikKbrGr3qgUpyWRFA7jcBz9f0LU0bAbsDGVkhr4IupH5M48KKim+5pueSdTlkhs+OVywWgT4XH2O0aYxICI9Vv+/c18DR4fMYYGl+fMelJ2aLmmSjNaHmOabD0Q6LLzC993rIvlDd9rnb7YJsNO8uU6PaT6lmmjtLuxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXtfMfOPPAIZyRX4K0ha5FNXPpZceTlkv1sLNfIVAyc=;
 b=P7HqjMRuUz7nzyXkt66aw8CP+b0zhJzykRgpLUIcgK0e6hRoX2SW8sy1ButC8PAAw6hyskR6OD6ql6CbfaMi6ATDvHPYI3UoSVg2J5jnT+STzuBtJzFQi0o5jvASQzUw5RtRDll1h9spZ86BavctSs6itxXAapzCIAb3HYM08zTbrO6WKSh1aQ+qXOKSinCA4uIHAeKT+fT9HK1TYfTkEksc07QrWcWLWqQ0EWAMYvjIMTie34+BGJJt/5ocktm4ijGV7gjClQcQi7qFs7gL5VzgD5UctR29t9f8G2ki9+icpkpzEmyR2jE/U5e73PNEEYXiRJgKA37VQtdZ7MakEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXtfMfOPPAIZyRX4K0ha5FNXPpZceTlkv1sLNfIVAyc=;
 b=x2P1JAN/OVTj9LvA5+ceTeb5Pv4SBPQEELxRULXZ13zm/1Datzf687paNmVx4xBwEw5EFD99kHI8EUcc4uCRPu0P/KS8Z3iRC7H4CY8xhjD1f284arocC6BYLUEVVUVmjkqS75SxPboNjZ+PcWOpsiUnwysIlevXQbmanIyt44g=
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by JH0PR02MB6901.apcprd02.prod.outlook.com (2603:1096:990:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 04:11:02 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 04:11:02 +0000
From:   "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
To:     "johan@kernel.org" <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Thread-Topic: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Thread-Index: AdoXeUqyLhKr1ig4RFaPJIEz+0Snbw==
Date:   Wed, 15 Nov 2023 04:11:02 +0000
Message-ID: <TYZPR02MB5088D4550E1F4D9E4D66344B89B1A@TYZPR02MB5088.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5088:EE_|JH0PR02MB6901:EE_
x-ms-office365-filtering-correlation-id: 0ca284d0-2a50-40b6-7888-08dbe590e154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYC/gj37GKosh27metdeBHx32BHQAeBuoIDKjRYtD55gEmMAdg+2zpnCmJ0fLY5zHd+5BRK+ewIhXvDXHW6PQuli5x86cxFp+VXQNsJx8nXjHMkFewwVtuRbiysLz3eLp2Dr9w6oGUIwUYRCwEYNV7UxSNCGnizyctrbrGljlRX75YlxqEc8AKw7tgln8uKM6WXHbZAysVEBRFs5shRk2OEjx+tfww3oxvKbHjbD46HHO1YVeHUrt7Rz3TpeqFtSdTcr9AgITLuzSiwhdDYPVumNNCP2g0c+clOjkRtolqMHK/SSAEDAytivZyVGiG1HBe53TSNsziABjrEiv/Z4U2hprjdUVF7Ry0W7WmENI64d7pSRzcotyzKQIcvLNX9rylTgmvuj6emyGXJtmgpCtWjNMbtWW18vdhuGNO5Q781RJj78oLu0S7Ua/Y2xJi57ehWeBFnWEILrcHgvPaMRAYlMeg0gEjF51abey04ulg7dWONMTAHWmPQMHvfTO9WJXx2/o8CwVzAURg2NRriGTKV+x7ba9ClzO9pw2VImiCS99S6q6e1HoFrfrbQPrRaYaBBvcgk49hoEBSUTMYPPxIU2IoujArgPtOA6mV3F1PaBhe3V5BvoiUuvaEG7PhY8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39850400004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38100700002)(64756008)(122000001)(54906003)(66476007)(66946007)(66446008)(83380400001)(66556008)(6916009)(76116006)(316002)(38070700009)(4326008)(8676002)(8936002)(52536014)(5660300002)(2906002)(26005)(478600001)(7696005)(9686003)(55016003)(6506007)(86362001)(71200400001)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0W9K9z1h/0RW7jBbf8HcOThnP17jclT94xdxLLWwoUpESHu3FEy5HtCJrpU3?=
 =?us-ascii?Q?aw9q3y+AHE8J+b4Dv5kq7LvhTv9OIN/afIVcI6pTEQWqIguMEjPd35zX6VjF?=
 =?us-ascii?Q?OInuNib6iVJEf2+8aFggMCDafLd7Z2aOpR5BpguWT35L804X0ZcOVDoIkzRN?=
 =?us-ascii?Q?6KhRFQQY16QSr2BAqMz2JIJ//pYq/tq8ps9tWHQEjvIIYRXPfJKpYuibvDqB?=
 =?us-ascii?Q?WSVy6bKyaxu+lMLx13iRXbd5J8B3g5f559Pkaal3TdymPIr0krVKRMSHNKRW?=
 =?us-ascii?Q?VwJqx8Ub76CR8xNdnxPuEJvuQ/tKRVzrlMlpbVVN7hZbOqb1RVMDuaDsLogz?=
 =?us-ascii?Q?rfZCwdN3rdHWLLmOJ5WL3IpYXIQbZhBoMO/Z3GppBrV9ysNsySW8LURdWEgD?=
 =?us-ascii?Q?NfxM0kew+1r2lHa/SfoYJlzkMFjV1VndEr++nDlyBhBQxJi0FdHP2RE81vLl?=
 =?us-ascii?Q?/BhNhYPtw67Qe4RB/LZ6WuXbDQvwtKOnbXV45O9zr7p+Dx6ha/s1FZkcJMsn?=
 =?us-ascii?Q?t1He/bdYb1o6HRrDrVPMh2XCI5b4wpsJziWKKxm98aM2DTnnAtF5ioifhZuQ?=
 =?us-ascii?Q?Wk9YTIXp8ivS7mSxRnU+n3N167Sb4KEaVMCI4lXJO5iggb7eEgK1uyNlCzDL?=
 =?us-ascii?Q?YXZXCBePM62uTkOltnyTnSCgN4E9lTI8TJLD44BLqN1xj1jUTwvLyIqBZhDq?=
 =?us-ascii?Q?T5OcMN5OCjVGAojMqgRBBQ9FwhyqKa3hb6rgKxL1Kuw3fofs5rcwkgDVtqz7?=
 =?us-ascii?Q?MgduA36Oht/IDknFgZ1ipv6dAIhMZLDZidw7PMMyIkvlpCLiTlLSDCO+vfTU?=
 =?us-ascii?Q?lvh3vkptNxk7Nqr9RBr7Izc45tdCPeXbjAbBZ3I7KA6YCyxXvD1XUgTha9Pv?=
 =?us-ascii?Q?DE0bJ1VxXWA30JFVTr5POxwRTBLSlkoh2njo2bOg61szRs2/tztniSs9s8F3?=
 =?us-ascii?Q?c3AvkUWJ6ZnfFkqjokcAz7A9sQYZiVpEBzNV5O7NtzHC6pvHxqKow1ZtMLqD?=
 =?us-ascii?Q?hqPCH/EHdbbjCoD/h9rvNwKG4QR0QmPoFyfTkrin1NR8mYN1VHRYvbpYizEh?=
 =?us-ascii?Q?oJ9RCOTrHzqL47wnKDyo7nzvCL/hwbC4V1OQQvkeYiRYVo/bs4K3XOkEK0FM?=
 =?us-ascii?Q?oKH5swanLMq3fQwvPbxiZHrHTJrCvJE5TU135398/RKqilpnP5jiId+wbuiN?=
 =?us-ascii?Q?KhnoYcSoeqeImJTLjm/HEnFyOVnt7vF7Kb6ZM7yZ0AEtnvdhiRdbfeMMgNZk?=
 =?us-ascii?Q?H0ZkQ6QTRqn2IIVlexYM4wk8n3C89BfnfPEXwIR0Y0PXefJGjcU1KCvF1uw/?=
 =?us-ascii?Q?kAkmaL2sgUlKWrUfzweROhyNY1wPJQHNOuToIaKwKSLOEwVs1EWk09rZOKwr?=
 =?us-ascii?Q?E02BW++kHYnP/5WXYNobEyPWqInkXYFREeVPJqirSYqHov3aeRVrkPhjxOrk?=
 =?us-ascii?Q?Hw0+FIjEA3oblFPyItSs31xVpYQUF5av3JT27uvc/8SNThEKW1oIwwnoyMPt?=
 =?us-ascii?Q?FOxGOuacrfLPK1qAdb1pQMfypTXJ6Qp0fIqpDvo5HKpGBUBcwuhw3xjfYhrJ?=
 =?us-ascii?Q?iVxSdd8zKtV1HFpDvTQRk2MRrOBXmMe2m8QXu19o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca284d0-2a50-40b6-7888-08dbe590e154
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 04:11:02.1147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOtVW6ExSD4TRea0Jkw4mHxCPAoKmdTSmyKslDP4wm62NMNxg/qsYE4DLeZb/H06n3dvBdMNR07EMRLX/HWEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Modify the definition of Fibocom USB serial option driver FM101R-GL dif=
ferent variants
> >=20
> > - VID:PID 413C:8213, FM101R-GL ESIM are laptop M.2 cards (with
> >   MBIM interfaces for Linux)
> >=20
> > - VID:PID 413C:8215, FM101R-GL are laptop M.2 cards (with
> >   MBIM interface for Linux)
> >=20
> > 0x8213: mbim, tty
> > 0x8215: mbim, tty
> >=20
> > Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
> > ---
> >  drivers/usb/serial/option.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c =
index 45dcfaadaf98..3aa219275509 100644
> > --- a/drivers/usb/serial/option.c
> > +++ b/drivers/usb/serial/option.c
> > @@ -203,8 +203,8 @@ static void option_instat_callback(struct urb *urb)=
;
> >  #define DELL_PRODUCT_5829E_ESIM			0x81e4
> >  #define DELL_PRODUCT_5829E			0x81e6
> > =20
> > -#define DELL_PRODUCT_FM101R			0x8213
> > -#define DELL_PRODUCT_FM101R_ESIM		0x8215
> > +#define DELL_PRODUCT_FM101R_ESIM		0x8213
> > +#define DELL_PRODUCT_FM101R				0x8215
> > =20
> >  #define KYOCERA_VENDOR_ID			0x0c88
> >  #define KYOCERA_PRODUCT_KPC650			0x17da
> > --
> > 2.34.1
>=20
> Thank you for your feedback.  =20
> We apologize for any mistake and have now submitted the=20
> incremental fix. Your input is greatly appreciated.

Hi johan,

May I ask when this patch can be merged?
