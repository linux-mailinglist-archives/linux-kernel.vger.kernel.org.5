Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F07BF7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJJJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjJJJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:46:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE0AF;
        Tue, 10 Oct 2023 02:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtJe8sE7oYFUyRT7MLFArTCIHMNoDvT4TAGwxSa0xM4qpxVap77Sn8WtDm5de7rjs8NWRq4NXHeIbTUJMFEUqd5z7Mq9dU0jIfZxKGNGtbMTTSBDQUcQO7m7wV0b2svqxqWDWeQosr+wtbTAUTo4dOdtpaY+JhqZAO0tbghyKsk2rheJMuMGiQXen0sIzArVqEZKoF/HoGBjUP7Il50Jmb7Sz5VgtjJpoE91yAjnt8y5jurdkbKJK56q/L0zFpjrrA8p2hfn/caQsyeLlYuf/eMyipCOkE2p8yNTMPh1h5UFkNE59QqiCuFf5a+xuSB8gqPH95rZEYWBA5FnrZd0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ndB6Gn0D76TPfIf1pr/i6sWtuLnZw7jEDgyixerNT4=;
 b=a+SD2B2/mIE3LDcZ/uMtQNxGXycY7o7WUWtBnT2zEFKTISWbXa5hoc0S9m/fEwi+PX36apgYrV5oo8Byr9fqSwUtssJ++nn/WGAbTHPGKFmEaCJEZaKTCcUGvQif8Q975ENbC3VaB5wgV3rRVGL3kx4Fn6rh6n31zXZISQD8eepK0ZimmpU/5vsYhxGrHw5yeuXpQSXiKGTyOULhmw321n3mk5EYulqdxJ2C6QA26j44d/MbOuGIdORg7Ak4eIKOfbD1NWsW7ufDLe9JvtXsqhs38zRCx9MIqF/jPfKTmXBRSfLO0leG5E1yV+mtJph4kQFsiFur6QFBLMJJLg2SJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=piap.lukasiewicz.gov.pl; dmarc=pass action=none
 header.from=piap.pl; dkim=pass header.d=piap.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lukasiewiczgov.onmicrosoft.com; s=selector1-lukasiewiczgov-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ndB6Gn0D76TPfIf1pr/i6sWtuLnZw7jEDgyixerNT4=;
 b=IQD6DjXQXYde64E78mZCLTRggOuYUJi82lYCP3cOiySmlsKEgFyLjKlF9oBtP01792B6VG1rJCZn4tTEx2NiAsfCmUuKLynMZUI23QW63DOtpt1DLANGWxRItkX5igD5MqKIGdJQNR23xRqVPmXsD2OxtvBMPXrncRQ6iGN/ggU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=piap.pl;
Received: from DB8P193MB0680.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:15f::18)
 by AS8P193MB1239.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 09:46:27 +0000
Received: from DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 ([fe80::ee84:c935:8355:642d]) by DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 ([fe80::ee84:c935:8355:642d%5]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:46:27 +0000
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     linux-media <linux-media@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: Sony IMX290/462 image sensors I2C xfer peculiarity
References: <m3y1gpw8ri.fsf@t19.piap.pl>
        <CAPY8ntASwh3AcRqE+2zF4Df=u+=wJ5K9icAeOrXTMJGDd1+caw@mail.gmail.com>
        <m3o7hfx3ob.fsf@t19.piap.pl>
Date:   Tue, 10 Oct 2023 11:46:12 +0200
In-Reply-To: <m3o7hfx3ob.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
        "Tue, 03 Oct 2023 14:59:16 +0200")
Message-ID: <m37cnuvmhn.fsf@t19.piap.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:10:15f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P193MB0680:EE_|AS8P193MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8dcdee-e531-47d8-ab83-08dbc975c600
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KIVw6jholCwVQUvjgevn67ntHKia/7amwTceNdXgul12nm/gnNShiKFv2lXYfQy3CNmFsP6ysPVeNFbeyx5ZIv34a56MVdZtL9WPeIds9s/opvK6fDF1E6o85jE9fNYS+PnO6cKQKAFlF6FJo5+Wrah7HJS09EoybcqEZK3HejYdUWFuddgzqbs1+6Rdn0AX2SXmBanakBXRAUgnQ65yp0YsuI26qUouS77cYk4tiX4plyzYgL7ux9kf8VxTLPWa9tBdc3uPlmkpRx7kiSHcznvlXwP1zD46LjmpVCjlEwr5OgVSKGvHAve+NsXoMYLegHTf79iwm2e0hzm/eBx/qfaiOHLAb6hvN4Sh8CPt9fGW8fomLaFzfvqE+pwGOGUEXu99pCjn+V+yuyywaytDtHSyeCW51DKPQ4Nlp/8d6O9vf/MGzjjkPOG3pSUcMzSxhGbU3OeoEH6zC+jg3Q9DGzcDwWI3Za2kp/GeaK/a70EVjV1GiUt1309UAsAfiTUM5cV0JTEDw8u5CTOjv1cFjT5B1FMnRizwHmu/bS3x8919QNDKVfdatmEeBm/tbfMJ3bkMYqb2UGIIjD9U1594UjK7RXZ920zmQ/4+KJ6Xph3p35N0dlwIb91Y1L8ibOB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P193MB0680.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(1800799009)(186009)(64100799003)(451199024)(52116002)(6512007)(38350700002)(38100700002)(83170400001)(26005)(42882007)(2906002)(83380400001)(6486002)(6666004)(6506007)(478600001)(4326008)(8936002)(8676002)(786003)(41300700001)(5660300002)(110136005)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTk3TlJuV2szSDlIempBZnhHZVFJeE1MY1dmK1cxM3hFVWFMZlR3cTRNUHBx?=
 =?utf-8?B?SlFaZUs3SHFKdkZWQnlOUE81akwyNkw1S3Y3UlBwV1B3azFXMmo4dnFTdkIv?=
 =?utf-8?B?bVFPSnM5blRnbU5YY0VEdG1HTytTZGVmSWpDWWlMTnQ4QkxXUDNKMW15OWtQ?=
 =?utf-8?B?RUFFOGNBZmtUSGtmK1NGUWpMM1RGWUVrckw4Z3doVGVYU3dicnIvb05FMVZl?=
 =?utf-8?B?RVh4bnRyRndNWSs3Rm9mSDBtdUR2cHVnazhhU2gyNEZNbUZQam1ZdzlkdDZ1?=
 =?utf-8?B?bERqbjNIQVp6dHVuUGM2SCsvYU10SnZsRndML0tYUVc5TlJIa3BSOWsvVzk0?=
 =?utf-8?B?M05Ramx6ZmhnZkg4WHJUVGNUSWcxK1hJRUhINDdDVnc5U0NMNmQxWFpLRlJl?=
 =?utf-8?B?N2pBSm9wb09Ybk00N2wxbmtFRGE3WWpUdTlCZmk1cU9ZaWhyb2RuaVl0cjVR?=
 =?utf-8?B?THNiZ04veTl0UFhVdmhXZjk3SjFDWHI4d0V1bXhVVmRVNkRZMnNXd0l6aEFG?=
 =?utf-8?B?M1VOVVRtdWsvTEwwU0hSbnZWTzBTUHZIMXBtcHdNZC9pL3czWm5aRnA4T0Jw?=
 =?utf-8?B?RlRnREtWL0lZdnRnWkRsNk9ML3BLeUIwVVp0Uk5IdnFzRExmZi94Z2tSTkt4?=
 =?utf-8?B?WDhpbUJ6MEtNMUJUaUx3Tms5bDZOODdTUkFVa25tVk1OZ05kSTU5T2s0QkhI?=
 =?utf-8?B?WUZvZ0pqeG8rc1BwVmlUL2I1NCtuRGFLMmVCeEJjTjZpbUIzRGNBaktKKzRN?=
 =?utf-8?B?Y1cwaS92Y2Rub2JYMm1GeU5sQjlyZGE1VDBVTW5BbCtPZ2pJTVlEMktmbU1Y?=
 =?utf-8?B?YU40TlNPTE01S3dCalZmRkZSd1lKbGcyaUZraXlUQUN4VUN2d0Rqd0JzNFI5?=
 =?utf-8?B?blV6cS9mdGNnVG1UUTloWFJTdlZ0NEsvaXc5d3VobFlXM3d0Q1d2MlBESzN0?=
 =?utf-8?B?VzZOVDBwRTVPTGd2UWd1ZmtweW9PWktpYjJ1MGllMjVsZ2hCY2pIM2lONWt4?=
 =?utf-8?B?czZRR1BxMCtUQzhaaG1Nd2MwbmpsRXgzc043VVRYaTdtWE93UndGNkMvMUo3?=
 =?utf-8?B?VjFmVEJZbVRES2s1Uk5kTkZJYitmSHJlQjRZdE5oNDBhc3kyZGN3K2MydG1o?=
 =?utf-8?B?ZTBMd3NKM1ArdG5RYitpRTJxOWVZcVJleXVuOWZCekJxUXpncnlVUjYwQ2Ur?=
 =?utf-8?B?U29CVTJHdEpMdzMwQ0F1V3JyTkc3b3RsUCtFNU1BMmZjSkcwN2pBUUxRY28z?=
 =?utf-8?B?SVZZazRPMEZ5NDYxSmljRW5SdlJHR2ZqWEExSEgxdkpBOU1NbmpaK1lGYjhI?=
 =?utf-8?B?Z2ZWTFplQnpjTjdJd1JuMTc0bytVTDlXNE1kcEsvN0xJT054d1JRVjZjUG9t?=
 =?utf-8?B?M1BGUTVhZnA2c3FzZXcvVWNreThzeHNZWlUxdkFYTW4vRkh6THY0N2thSVNK?=
 =?utf-8?B?dlZzbThIZ044cUFaNU1oMEg4Z3pKNlN2ZU1PL2M1cEc5QmRTajRwVUNTSnc2?=
 =?utf-8?B?VHdIT2p4RFczSlQ3VjFmRFMwU044ZjZoSDQxcW14SmUyZncwdUFUZEtZYkFu?=
 =?utf-8?B?V2FsSWtFVEZXa1YyRzN6WmxaeEhaUk0ya2pVSERBOEFwRUFVMndVY0JxWC9F?=
 =?utf-8?B?NlFCWWhTWTY1NFRwVFNWbWozc1Ava211b2MxcU9SVDBOQmh5bmpxMkFUYmlM?=
 =?utf-8?B?eUd3K0JLMExGb1VlSXJxcVpvREo5dFRPU0NZSUtwR05DWlY3a2lPVk95ODhw?=
 =?utf-8?B?S1ZseWhyR3hxTmtPdEJnV3dXczhna2piTDM5L3ZxbUtzcWlkbXlHOC9OcVBB?=
 =?utf-8?B?SnppTm5TOUhQaTU3cGdnZkE5ak5vNFUveTBDcXFvbnFYVmZKUFp2RGt3dFVU?=
 =?utf-8?B?UkxOS1VWRndXMXZ4b1dFczhUdnpNYVNicURxc0FUcGROVGVSSERyN3VTZmdY?=
 =?utf-8?B?R3ZWWHJQWXZDQWwwUmE4K3BJcXAyVzB4aTNIUFFmT1NIY3hwYzlSS2RmM1Bu?=
 =?utf-8?B?YURNWWdhWWxaV0VROVVNZ1FxSEtqdFVSaTZWMldEQnJrbGx3bDhZR3hXalFP?=
 =?utf-8?B?YXEyUHJIL3JUMUhVak44YTlnazZacy9uK3Uxc3NLL2VTaEFIdHgySW9OM3Ev?=
 =?utf-8?B?aFZScnJyUE8rZXE1UUNzRmFuc1RyclpQWmVPcG8yOWRqQm96R2ZhelZFSTZz?=
 =?utf-8?Q?Jrzp43gzjj8lMkoPielveXgt6TxDRHfaCRc/j/ih08wr?=
X-OriginatorOrg: piap.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8dcdee-e531-47d8-ab83-08dbc975c600
X-MS-Exchange-CrossTenant-AuthSource: DB8P193MB0680.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:46:27.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e05b101-c6fe-47e5-82e1-c6a410bb95c0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9XTF5tQghuJlkzP6S9yemTPZWZc4mEAwbw+xdCFZ9u1Mok78hvkApPCFaPhbYHe9O5InJv5no7L+pmOiorjgE5xk/9py3kt2RzE8Tmby84/KWhHhqX/o2mHdUd+G/P072+FsfQRRBx/ItLbaJlyWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1239
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm back to IMX290 and IMX462 sensors running on i.MX8MP (and not on
some nonexistent sort of i.MX6 as I previously wrote). The timeout thing
happens at circa 2^18 + 8 or + 9 master clocks after the regular START
(not repeated START). With MCLK =3D 37.125 MHz this amounts to ca. 7 ms.

Using imx290.c and the i2c-imx.c I2C driver (NXP's version 5.15, but it
doesn't seem to differ significantly from mainstream):

wait_queue_head_t queue;

i2c_imx_trx_complete()
	wait_event_timeout(queue, ..., HZ / 10);

i2c_imx_master_isr()
	wake_up(&queue);

Sensor register write example, I've added a couple of obvious printk()
calls in the interrupt handler.

First adding some load to each CPU core:
for n in 1 2 3 4; do while :; do :; done & done

Then the actual sensor register write:
Sending I2C DEVSEL byte:
[86.968267] <i2c_imx_write> write slave address: addr=3D0x34

Completed:
[86.968306] <i2c_imx_isr> 0xA2 0xF8 <<<<<< ACK
[86.968311] <i2c_imx_master_isr> 0xA2
[86.980361] <i2c_imx_trx_complete> TRX complete

It took 12 ms to wake up, way too long for IMX462 to remain on the I2C
bus, so the following byte TX fails.

The question is: what can be done about it?
- should I make the camera control thread real time?
- or maybe the I2C driver should be modified?
- or maybe imx290 register accesses should be somehow atomic?
--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
