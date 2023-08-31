Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8197578EB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbjHaLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjHaLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:03:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2078.outbound.protection.outlook.com [40.92.89.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992F8CE4;
        Thu, 31 Aug 2023 04:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZDlSfZtt6BIvRUUV7acX0/IL6ehnHUkGAsV/+2gdoXXOE2MqAiSsYW7c3371SvwwHd2fng4QKFnSCYnkxAEy+wV2leqaRO7FZk74fSsxx3nhV8dopg6wgqMV05YeFmFvoaFGktMmllizF7GX/3bq1YpUQJ08Cne1JFP8LzR3rp+3ENJ2c/4IZn5IM76EeFVVhQXinqZjsGneZfEfnH0d2xxQk5nSl6RTI26hj/a08ucesksGRQpFLy0AGP1NvAVr6lg347SUk6nSqs/2F0rIKUz4kSvyskqUz79aUEQ1hNRJF5yfceMtu/jsb67hZKHjlYgASLFFvpG8xVa/8Am7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbml+PIJzFbsz4ivQzx98Ihpr6ku81G6puvqj8Ciq+I=;
 b=dRkvMJA1GeSajYV567jzaRUy5jqwpiOpUXtd1dO/cL0cWp0xH5iLbF2CENswEeHMq0MfIvG0EZfAaLCLz1TD0/cgrhZPNgXQvalRi1/m2coHCAs3g9TOjroQY7zR3/fbcLWVpgSdlKnbIrEPlS8S5ZMeiZgVgoUDpkL0ZKRlWMrRHt21aKP0QRnoSwSxaP+wmuzZS6Cob73xXknxa54lIkGtV/q4PC5pcFwdy8bojt748Qk8GUZ8EtdDN4h8PU40qImtWGX9pc28oCRPsvHlLw4oTJx3XTdRVx9LIC7SHQ45TkLu6xadwhaS7GqLiSF0Uv5Bm7UWCulDulSU6fy8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbml+PIJzFbsz4ivQzx98Ihpr6ku81G6puvqj8Ciq+I=;
 b=rVBQaTlD/qQFQBhkiFSfz4xI5kpJZSulKLjJwtjn2nCEC3VbBA4ncpQkVbBkBfzLsTf/wdQJprSXBQXlIjpnt3Is0qEUp7Iw2VpKG5W8qk+P4lASaGAj1z6F0iLwdo8KVWpVnDZSKzp52yQwZIkDEwnf7wnUF/0e365GoXjQ3jBoTRB85cozOVi/Elqpv3OBZd7tBndeubL3CnqUUi/mZE22Snhg/CDHw72zaJdYtr0sgLJ6D+qusp+2AiQAYP4IscokGFq2mQLUwgg+UEsjXnyDTyUHvC3wlgIyVgGFlCdH9cDnK6ydBzFr5lnNkHgzcsBIyZAXPMkqNdfuB5g0UA==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 DB3P189MB2380.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:439::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 11:02:58 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::818e:4d4e:535e:7d15]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::818e:4d4e:535e:7d15%5]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 11:02:58 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible cut'n'paste error in linux-6.5/drivers/thunderbolt/tmu.c
Thread-Topic: Possible cut'n'paste error in
 linux-6.5/drivers/thunderbolt/tmu.c
Thread-Index: AQHZ2/pHQEVyqjGBdEO6PfJf535FYA==
Date:   Thu, 31 Aug 2023 11:02:58 +0000
Message-ID: <DB6P189MB056829997A31D4B968AEA77C9CE5A@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [D3LkEyFRJSzcoy3be1Qi7Orhq6AfI5Kv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|DB3P189MB2380:EE_
x-ms-office365-filtering-correlation-id: 8d42f58f-1ec8-47f7-0b84-08dbaa11d62b
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9W2TH/7PvWvAE9NSZKrqpMLUZKDuoR5t6XDv79oh3hWMHZmVsh989XtURzz8HCvt101RW1NpVRY6M3H/7vZbLkt50dWG2HQEMUiht+3HHmiZ6zXUt8R/IaLP3FPWtqt3GnxOZhnxq+ZWmWLeOnfGIWpPXJBiQESp1KoJ6z7SJZGR0E6eYslUl545nqM45LWz2a8blP2pOgO9y7b8JHFPs9/aXuOixlWKhYg5yZP0CXPZGDIQ7QwqVKWwkxufxQGU292OjScPzmYcFhUd/VxhC7i2FANtP+zExhIeNcDKSo3RyfOmRaqWesfQuWa4O2vlHWaQ6x09uKQcvP6h9bgKDuyOkeD0gUVsUKp/S/fg4k3JB432h2gF3IWXmvd57BrybsLqyyhPigiFgiQ2WnLXTOACr5BDgd1hfkYd8zPGGaSXqkypPc6m32rbZEIhfn3VXCaiXLdWdDQSu+LSxRwLcwri3NFAQEnO8v3bnWFiP5CKinS6tg1QQlFn0bbLOEIJB6lhkb4HTGCIvYApi0GewvWOe0APBOPH0hEtfeX+BnEUNTdh8fzDn6u4YdY2K30g
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LXDXGt0lIO+vxhInYW/OqWLh6JfB0T+UefaPBahFgj2Ufq9yQi+sgh4X2v?=
 =?iso-8859-1?Q?sVRn4YW+VlsXKMF7hsg2igMbvIvqHaeO3TnS4KmAcW0VB+3oGCpSMGjj7Y?=
 =?iso-8859-1?Q?qGZJ/hFaQhcgkYuZOn4IPl2G7XtSpaRTA5i1ohQdyQmcprrLeESuywiUIp?=
 =?iso-8859-1?Q?B7kVj42Z0kPbCrfKmnJLlNjtXgb46ENwunFKGZq8wH6/614xcx8kvrfPcL?=
 =?iso-8859-1?Q?WxjI/bIm3FUSDVKSMyjB0v38+Yardpz0HVqoNzWPFn6E6ZacMm8gs/tJFN?=
 =?iso-8859-1?Q?IxbjVBThy8gnhpBlDWPWL8j8iumkKvR0YqAj/Zzr3i5g5sVnJqN2iiYR+V?=
 =?iso-8859-1?Q?JB9Rh80bHbiyX7RISOB2lFwyG7Us4AUxLZCDKEzemUjI7ceZO+wZLXfz/b?=
 =?iso-8859-1?Q?gAzr2J41hI7NVedj7jiUZ2pGUBnyESjND8a2hjLVwPM6cVXoLbHUKDUtnw?=
 =?iso-8859-1?Q?wULyHbKOqPPv+XrkfY9gsgC7r4B6BguyCgh4FZCoxnVa1h3rLXn3nYOyem?=
 =?iso-8859-1?Q?43pk7I8BMPene/fghMmXU3boETnpCAWJeiBGG6+4Fy7Wci1VtqKf03RRW7?=
 =?iso-8859-1?Q?jqHim1vPvH+h51xF//c2T4Zcna021uHPPiyDFoYkagSLtYWgewQ2kXoXqK?=
 =?iso-8859-1?Q?wSieaKURPeuPnlL+SQWY+pTS879Pbm76h6+1a3W3ObZNZYTK1Bfwdqk2k+?=
 =?iso-8859-1?Q?Z0TvvfLQkMbk0lRK6McUbrUoRuVFv5yr++fslUjiScDdPfPXd7mPhGA0YX?=
 =?iso-8859-1?Q?dWQvEcSZpfZUj2RWmr4vSYcHWfxj/ssHwwzEPEOlDxR5qDQA6kxqQSgluP?=
 =?iso-8859-1?Q?POeRjOED6DRHxavonn/Qd214Vr0uAY3faLd5+VaYjTnXkM95jn+lhrqODc?=
 =?iso-8859-1?Q?65ubQ8ntu8JdjAUnN4iW/i8RvtQV/25qaz+j85WPLOGSvK4IB3NIe1w8Bu?=
 =?iso-8859-1?Q?23o7JC3oz1xe1dLIS9Er/1lOk3t1RVKy2xiUgyxGcRIwP46jJMJN9Vc4E9?=
 =?iso-8859-1?Q?rh/OWiml2aXQJFrAzhWfOotkwk9018soF6kFEJYpnZPywIP95c0ssxRrnV?=
 =?iso-8859-1?Q?w0Qjjcu7WNa85YthLB/kZjg5FZ4QGyEV522n7tANHuemAqjg9eJTyA8ye8?=
 =?iso-8859-1?Q?lshLKvLz0xvZ09u2QDDUhjYLz4Nl/q33Hc+MpkYpvW7VZIaMGHfX2CRWS0?=
 =?iso-8859-1?Q?ztACpIrqM+oEhWGLakFhx5rXhym7vSNRgLkv4rkb3UaKtvwRJFR/qqwU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d42f58f-1ec8-47f7-0b84-08dbaa11d62b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 11:02:58.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P189MB2380
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,=0A=
=0A=
I just tried out static analyser cppcheck on linux-6.5. It said:=0A=
=0A=
linux-6.5/drivers/thunderbolt/tmu.c:385:50: style: Expression is always fal=
se because 'else if' condition matches previous condition at line 383. [mul=
tiCondition]=0A=
=0A=
Source code is=0A=
=0A=
            if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] =3D=3D rate)=0A=
                sw->tmu.mode =3D TB_SWITCH_TMU_MODE_LOWRES;=0A=
            else if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] =3D=3D rate)=0A=
                sw->tmu.mode =3D TB_SWITCH_TMU_MODE_HIFI_UNI;=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
