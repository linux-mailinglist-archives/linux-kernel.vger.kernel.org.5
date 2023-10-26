Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85877D831F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbjJZMsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbjJZMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:59 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D511713;
        Thu, 26 Oct 2023 05:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adZc8jhu5moSogYF9Q3A8q5Vlc75Tup3PqKhnBg1/hpQY/EJFClQtjrcbPrKu2i8tkjI7Xb/rlCatjFWtMEPzqKtl9pE7FvfcU35n585ypTmrNyz1aY7AxP0QThikU/kbFSuVjmlnx1cmbRUtvHE+Q1J4tpG9MdvsHQlpIB5s1umN62vA+DKavYRWhQKYxncAWJbkbrUoNtnOubtchoJuUgeOPGl+uYfAhb0ZQBtO3a64a8RsKw7hx9NmM+5uqeI6JOCDC8dtelaWmHglMoOczqKX21tFXwr+di2NHCE0jEcpXcxDyc3GDtId2yWeA6aipOk78GkwTdGbraYYKlbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z6pwYRocKwja7VpN79AVza0MnypHaquN4NIKcjtA7Q=;
 b=Qer3OXbU7hd5xCqhXOTkjWAQqSWAZgkcL8NBdZtxx7brA1J5pCpBJ/sAp8ZkcrzVgIK3PST575J9ZXFM5IQ1EUnFq0wQa1ta+XwOxof0ZyDe9T487BV2mo/dJ9EOcIGNCENzWZKFlwhioR2fK4mbSenjoyINCf7mi/z9XMrAQ2szykdxm9IRuJLvv3COya19CEVdTT3K6JxESuoS9n3WOJXmyBPNPXjT2EkJv01RwGsEcCvDVpUg/yAUux4TvDJOMoHs6GOcPBpsW9dRf7CwTpsDCjjdmupIWy4j9jsaHFVEiBtS2BxQJRf95ZX7foV0FHpu1CvkMqokYADCJSiYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z6pwYRocKwja7VpN79AVza0MnypHaquN4NIKcjtA7Q=;
 b=nBh+PzOmrUBHl21wBMfBB8g+2Iw3k855eYIt2ZF8XjHIUfllYJPA5hOEMpRFqhGx2EnNlHiExvSaNdd+chX0toKBFCrCz2hoUDC+Ma1HJ3Y5q/P9YSOIerEBKLdZ/PS12KSdNWrU15gfvTvmaY2oxauKB7ZR80s+EClHUmI2CE8=
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by SEZPR02MB6793.apcprd02.prod.outlook.com (2603:1096:101:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 26 Oct
 2023 12:47:30 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::e6c0:ad44:ccaa:789%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 12:47:29 +0000
From:   "Puliang Lu(Puliang)" <puliang.lu@fibocom.com>
To:     "johan@kernel.org" <johan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Thread-Topic: [PATCH] USB: serial: option: modify Fibocom to DELL custom modem
 FM101R-GL
Thread-Index: AdoICokA4ksn00QWS2SWjS8lLujw+A==
Date:   Thu, 26 Oct 2023 12:47:29 +0000
Message-ID: <TYZPR02MB50889E1282C90E3C6804B64889DDA@TYZPR02MB5088.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5088:EE_|SEZPR02MB6793:EE_
x-ms-office365-filtering-correlation-id: ebbbddfa-7200-4864-7ef2-08dbd621b704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tsg1YKK1GkqEFYbGZ7pU5n2biV1DymqSQBWMrfEnbWAx7gTE1IuEkx9ArlXPOFXj3Af3km+NV4eI07N9L1gsXE5usSllgDDkQGPUaWz6xITF+6EiArr8T4fZFqjHaKy5vOo/vSiUtdaH9QVJschKz8gNQvBMeiubLIntZwweFuHWQ43RvXq12vn0uNy70E2TDbhuXrl89n9QIiu1PFIFJHz01y3KQVE1KYCpZzreV1UYL6bpQViPPPqVZl9yrQpwhJL/+RrHPWLv0KJ7GqeIWI/O/T+kjK0fXv5oh2rtbKy4N2H9M8LmcSbC1xEwFxHiA5sXYfXq2jRVztHdIYZ4ZqKmuY/l687FgyioFdlRBMsEhbvyZcpfNMO0IHCC9iv/gKMl2kz7QnVLqwaoLOD0HcNail3A4jC22LIhOv2XwxRp+1lOSR9FMjvAXYQOVf95FTRrEV3euzUt8JE1EBd518KZZpRiI3t+jlCKBrv5Dhbxavrbwu9zSV3Uju/v8ajx9R3PQ0oRrqZLGPs87wgjfRmOVQKhWXzEfFoxJf6XhGYA7rqE487UW8yLJWlqoNIY6tpW1Ft45MXgWPiso1+ol8S1+ltNvYn6oKUn8Y9cQlevV1SGdRDGV6rif3Fqv5Rr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(376002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(52536014)(41300700001)(33656002)(26005)(38100700002)(9686003)(8676002)(8936002)(5660300002)(4326008)(54906003)(7696005)(38070700009)(66556008)(66946007)(76116006)(6506007)(66476007)(66446008)(64756008)(2906002)(6916009)(316002)(122000001)(86362001)(478600001)(55016003)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TjPErHFQqsxrb97du9V3t6UNtO3EN4vHTiSA6lYQM0kYynjhDHy5p5sfBwCX?=
 =?us-ascii?Q?M7wTYL1a5/wenA7iVvdLFug9DXd5Omakv06yu/TJBz4caCsspGsszaIP5rJq?=
 =?us-ascii?Q?xP8vQCmIQatiuEmHDLw/dkLw72E6ZqO/ATDavLOshnlEF/1yKSAi79T+DA9m?=
 =?us-ascii?Q?oessCZaxnSMJJUG9OwqBgEuUMB5jSerzwBgdshW4LOdkGuwX3U5iR/oCjjtQ?=
 =?us-ascii?Q?hmefJ3edFHjCimzo9qk1rPaBRqhU3/HTQZqEzL6h0fTSYgyTr/PuvMOeyRHq?=
 =?us-ascii?Q?GMW3Lh2XitYm73ufXnPffBVmpH6JeETT+NmGHImdN5w003zUFr7TplD/5bW5?=
 =?us-ascii?Q?fsJ6Nok55/KoVtRs5xVqZHVkVX1OlCvS5RKNhAgwgKickd2eBZY3sHoyxEt6?=
 =?us-ascii?Q?FnedNikFByDkja6PitUnUMf9CVBl3yreipPWlAj7NbypeeW+0NvQrn0sA0dD?=
 =?us-ascii?Q?QlhCk7mBlvcQgEWDQOamUvyW01fXilp9hnypeWW7WkrGHAYr736U9F6IdjHs?=
 =?us-ascii?Q?SGFJSsEJXZBVqtGxkoOkfbmj6GpkUZfOk9Lk/3tBhdtWUrWYFvOdBa7HOptI?=
 =?us-ascii?Q?on2rnMRYlhIuCj1ylLNaRI5WNiDjtVL8QgNBoAZNuhSx+cKMNNGrtR3lraft?=
 =?us-ascii?Q?HiL7rkYzBrKo3Ln8VE3grRPF/mY0XG4FKwcrTGC6Y6ee/b6fJ0ejP3DL+1U2?=
 =?us-ascii?Q?EyZXxYUU19vfYQvZ8WORcRej4CI/KsAL7+/UhCoqEhKW5HGXk8Pa8SgaGqMr?=
 =?us-ascii?Q?aRk69QvUhaBqRddOhL5EnUmvXd5aoUOKjRafjzDwssRqe26F2IMY4GujAuel?=
 =?us-ascii?Q?GI33kTu/zizI+8u8lWGhDqV3S3O2fzVy9lT4YiZPhdZXJev+UlM++ZRScSgg?=
 =?us-ascii?Q?qqvvB/pv99JAGX2bwCe9By3H66SjI69Wo+RUXCUBJ+Pj8YsjKzJU/cKM6vPw?=
 =?us-ascii?Q?LLc9amHXoQt6dJY+krpwA3zplhMvCQynIec/Y2924cg+zjDM/LOcmvOifXZc?=
 =?us-ascii?Q?csOm3we0GNnTog91CsIzmAs64l9uVwN4FHCUb7A3ZIyqbJKXMEh8gdUdtGz4?=
 =?us-ascii?Q?RqfkqOYkLuP6xfjLLsTuXaq3mIKJgvjNauNbmeHZRvjpYybG4V1L3JKDvfp6?=
 =?us-ascii?Q?VbhFOMcASQPbo9Q30QdabFx+jU6jQua89TB/iA4M0rDXZcxTBcnxMqNs/Y/T?=
 =?us-ascii?Q?NjAGlFcqHjqfLLrh8Fr1L5X7EnXJ5DaeZEI+f1L+dJ8pRrmObJdJfZPs8K4p?=
 =?us-ascii?Q?7mtqGeVIqtDxDpEpwN/AL9Jxn9PjhCZGtvOjVg0oQeAYKwjrpUfxiydxgd0g?=
 =?us-ascii?Q?s8XqB9Qt6vAC4JJjtVX1ECJgDcW8tXZPf0/AaazkUO9GkqpjCq4qtzNj7qAw?=
 =?us-ascii?Q?UVuAiYb3kFzu1aI7uP3XTAXKFqQ33ZPiIRfhBjne2hTIXoMBVll8Ax3aB1ww?=
 =?us-ascii?Q?fHCMSpLQyJJ/H6UNpV6/V83ZDRJMjIqgqO6ZzPgJdBPMqcoyZ5gmtAiXE9ud?=
 =?us-ascii?Q?7Luuv4AsnMfGV8l2funNR32cQILls6f7/rEi5dZ+AmqXdXVA/1CbhRO0wuwo?=
 =?us-ascii?Q?r5b/g8Vvi9sB/dbk5JgM12BbjCRk7BsIf5QsNCGB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbbddfa-7200-4864-7ef2-08dbd621b704
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 12:47:29.5666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPVp3FrckME6r9omIg9ctq68RDi1V7OEp5NSAww55kYbyQt0lFw8bS38kE+/dc+0SHaXHjuYdcChM1edROl5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6793
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Modify the definition of Fibocom USB serial option driver FM101R-GL diffe=
rent variants
>=20
> - VID:PID 413C:8213, FM101R-GL ESIM are laptop M.2 cards (with
>   MBIM interfaces for Linux)
>=20
> - VID:PID 413C:8215, FM101R-GL are laptop M.2 cards (with
>   MBIM interface for Linux)
>=20
> 0x8213: mbim, tty
> 0x8215: mbim, tty
>=20
> Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
> ---
>  drivers/usb/serial/option.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c in=
dex 45dcfaadaf98..3aa219275509 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -203,8 +203,8 @@ static void option_instat_callback(struct urb *urb);
>  #define DELL_PRODUCT_5829E_ESIM			0x81e4
>  #define DELL_PRODUCT_5829E			0x81e6
> =20
> -#define DELL_PRODUCT_FM101R			0x8213
> -#define DELL_PRODUCT_FM101R_ESIM		0x8215
> +#define DELL_PRODUCT_FM101R_ESIM		0x8213
> +#define DELL_PRODUCT_FM101R				0x8215
> =20
>  #define KYOCERA_VENDOR_ID			0x0c88
>  #define KYOCERA_PRODUCT_KPC650			0x17da
> --
> 2.34.1

Thank you for your feedback.  =20
We apologize for any mistake and have now submitted the=20
incremental fix. Your input is greatly appreciated.

