Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765A479F5D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjINAMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjINAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:12:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2094.outbound.protection.outlook.com [40.107.237.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40283170B;
        Wed, 13 Sep 2023 17:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbpyeet2x8kkcCOv/fJ1jVZAsXHFhszdEkSAANcQTWMmYQT9EgTQytqp6zSOqS9i8Z13LRsH1/c+57/mBJGaELJdaKZTe5c0fpS7O7acYmdr3GahpkeHpFlvUb67N+KxmyJEIdZOJjw9mYtp4rybmoxLra+UdpGPMR/gVZqoNphYHX3hwynWx+XeHeYzAGjkhRf4w2T9dr1q1q+3icdfi/K+wmvTxghhlx13tRB358Hn3UVk1/N5ITT9I4hCmaKwN0QLTM34DydkHz3Q7zx3JMqT4qSSnvdPJnCWY0rd73MCjAMSrQVICOIPQ/JTIHcqZCSNOG7Focxngsh0eMEcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKAIBHscMlY786cttHb3gICiLKVejetkCx5DO5HmmPY=;
 b=An6jZEIr3djZ2qmOZZDofIaefvPaUhQythC4tRhRre6JY40dx/0t4IFr14S+LRHHsBKYdnMWZvnCA/wI/YQA85CSZ8NCbSXaNaRfDKKLQmLlzV10BvetSk2y+hPJinaVIIcrA21mEmbIb3hndMaNvp2KbAB7Uvv9m/cWexSoSBXi+JZQzVxsSZtf+lkDK+XQnIPy6NiCeQ/IvGQw6PwFrY6E3HVk5k/nMV2oZuAmrCJy++3nKyb8w9US1l9nJHSBecpdDqF6ao2KUjHkuifq+83pN29gSAjYoA7u8Z4wzIvvH6y8I9Zlxhe+6Y7yMgEh9gl55cNeDfljId0xbHBDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKAIBHscMlY786cttHb3gICiLKVejetkCx5DO5HmmPY=;
 b=CGTR1NJQBmKbYOEbhBkFMZG3IYvFQvmE0wkQcfVpranWXIDvLsuky8Q31nxfKYdPj+Oajk6tUAv70tneWkxFF9vfpHlhbUMQexWCEp4CFrxXe4CqDolqyRsbdXzSoPwA9CPQ6RmDnlhdn4/pz+3xD9yYzWIMFpCVGINEgIQfXcw=
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPWP152MB4410.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 00:12:09 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900%5]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 00:12:09 +0000
From:   "Fernando Eckhardt Valle (FIPT)" <fevalle@ipt.br>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Thread-Topic: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Thread-Index: AQHZ4Pumw8DKayDIfkWYOqHWnWVjYLAY9C2AgAAMNQCAAANfAIAAd8r0
Date:   Thu, 14 Sep 2023 00:12:09 +0000
Message-ID: <CPVP152MB505396FEC33D76B78586807FD8F7A@CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM>
References: <20230906195204.4478-1-fevalle@ipt.br>
 <d26d4b15-765b-a444-b740-97f95f2db58d@redhat.com>
 <c05afb18-bca5-4500-877d-d44ef3abc310@app.fastmail.com>
 <50da04e3-5e12-89d3-e3ad-f2ff4533a615@redhat.com>
In-Reply-To: <50da04e3-5e12-89d3-e3ad-f2ff4533a615@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPVP152MB5053:EE_|CPWP152MB4410:EE_
x-ms-office365-filtering-correlation-id: 3ebeb76c-644c-48d6-2e26-08dbb4b73c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6oaPMhsbVgWPh/fgeZ/pFubnIER/8h8VpMh3+BS2CLcklql3WZ99Nxw0oAX0Uf7a0ATa0R1BTszdL8U0bEgqsIDk82DaMoADz7UF9ccNDAOtIjSKZ2K+GS0a59OGTSci1EVQO7h+o3E7NHtot0k+Cdrf/qGgtsuWtXOT12H7AjpAcJ7X/skBTwxAKQOKepIzsUSKm0OdUG7Hv1kr7hYi4Z3zOU88Etw2/G/jhcvdBynbEQi3JITzuCtVyBHP7G9QcpMCTHydJpq6JouF9KOJo9TqoMWibVCYmNTxpEj8Jf3XabUx3dtvyhDmVTAl3Q71kMu7SNDbpzinCMsKdnTK1CT16wQifvzEmcIE9/p6R77CJ/jQ1gaLke3w2C2iGVNJG+3c1+rRQFEu1mDo4lgq/XLUo7l3Z7EQIz/gcwHINMYhSWil6K423X/8dN/RrDw6NKZHcxyYzIbPuU5SldrEvjnI8mYpbyrdMohLyAVdyCZponkz8vNzfrhZxGARNAfJ922AP+4CPxGp9r3yjIhhYCR0qi5yuiIkf69JEbngQaIeCYJGG3WWAxFsAu6rLM47dcVHsnSNpsv/595a5yRT19PEkB5nK7tB4uLkf3MeIs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(136003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(9686003)(6506007)(478600001)(53546011)(7696005)(71200400001)(966005)(83380400001)(2906002)(41320700001)(41300700001)(66556008)(66476007)(316002)(66946007)(786003)(64756008)(66446008)(76116006)(5660300002)(52536014)(8676002)(8936002)(86362001)(33656002)(122000001)(38070700005)(38100700002)(110136005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I4+firBRadvWVMsjteSxtXRalwKzLLbXiAH/y4Zcwciz7oC5cH1InGEozvMP?=
 =?us-ascii?Q?/M+yna4CpLjxFAiPz6/8UABcSKoDNn/KNcR4cnyW7jdjnge/HYfXI8hutPOH?=
 =?us-ascii?Q?elTq/2/+UokGT3VZf/DkNrAmc0VD1Gwgw7WUI0FWYXhM9YLF1QBn1oCbWta1?=
 =?us-ascii?Q?TlA+yNONBq22a9dWHjBlBnkb5fOb4QXvusn9MQPj5BtWIIYZynI/L+H0vIK0?=
 =?us-ascii?Q?IHM51gfCqQgykiXAggMDc1Tn9V/frDa/5RJ8MuMTOH5cf3SMS5hHXfU5D0Dl?=
 =?us-ascii?Q?aQpbSkrQv/m2rl+PqX5hrhZcRuxVJ725uQ139VlGvo2eUeUQBYtcR/52NBIR?=
 =?us-ascii?Q?gQ+TaNvodupMwfQY3R7DpRCfx9HGfoR+3B2maZlLNc1N6eRL8hX6wgAxiJ9E?=
 =?us-ascii?Q?ViEDg8ei9FBtllKVdg0rHUa5xawf8NAPBUWKftvOvfFMrOny+ahnRfkCBgPG?=
 =?us-ascii?Q?n4kzZwzyEHxGzwM8AW0meF4vzFafdyoLEYx33vVgrc3KjRe86ZoBhhvtmAui?=
 =?us-ascii?Q?7QGh+qa8g0402kIzmZlrP35QxSy3SvkrUXXcxSKwOWUSImgL0BwVJEOrKCFH?=
 =?us-ascii?Q?57n86NPgtorGqjNDJ+WttbMhduLrgsRiUotHDdV7URqCArboEzQ0abhPbsFl?=
 =?us-ascii?Q?7/PM76V/Ro8nmLKFZ5FLmAodyy5GL69f0L+WBc9pc7A5xHZdtkPLlMQgxWwk?=
 =?us-ascii?Q?xVzyG3C9Bm4+j97CULnu2DYmifWOXE2tEE+OSzTdIrS5Rh0Aev0j9xbUTC3s?=
 =?us-ascii?Q?61jJstLvMdmzvcKAgm9livlEw2CPyQWDPRbylwH/PJd9LXfCRiVffbqZ5eN/?=
 =?us-ascii?Q?mpGvj/nRBgOR5qaldD/zcS1vX86WXl3FUJirDqCMjYThVQmJsStkmG/s6uzj?=
 =?us-ascii?Q?w0LH5Jjh3BI19br02Qf3piiCv/FsfX/1CbRh+QqsuXJSGu+o9o9ihAwHawO2?=
 =?us-ascii?Q?DqHgYagt+hbNYVJ3+mGfkkhDJQB4iXUb2S0CeKo26fAwtQ/PiteVBid/J98+?=
 =?us-ascii?Q?L5yyBXEfU+YEI0DvbvgdlLXiVnUzxfLfcHaAUa2Sk2pU6CDhnw+JgjG+Es4Y?=
 =?us-ascii?Q?ciDwG74qGnPaD+y48g203huc5QyGtzwenUSX/TU6EnpGW18dIy3/c10ykZok?=
 =?us-ascii?Q?nd4mRajTAqEDQv7akg2o8sJbMvdLl0vzxBw4MxkN9neB18akRbgRPEc0n2j/?=
 =?us-ascii?Q?yiZF+jiBHVhhU8cDZSGaBN0t1uHJZJHuzVKgVF3safFdr7wDiVprSZbn8h+s?=
 =?us-ascii?Q?thfc6N/UXh6TTtpX0WqMemWfMN4X0hXiMiV9B28pbDeRN7SOeqN4DM+ccVnO?=
 =?us-ascii?Q?zzv4odvahbRvSMxPvieqZecSjMmvqtgbNW5AA0Ff2mHix01a7b8nOIzBoGVQ?=
 =?us-ascii?Q?El9MVrsK0WwZyg9cg68pbVPIA9S746SDhfFpQ2wq7rmTZdlTFchf7hxc6KeD?=
 =?us-ascii?Q?/QJi/fK9KJnIcliht4bftVO7f78V63ZQ08Q96u95iP3oOnsbomEz+z6Bw50v?=
 =?us-ascii?Q?NLgYXIAIXAy0nlYAjG2GPqj+w5Ed8DX0aH0i7HTfNkp7pKnujTySDHhjrtHh?=
 =?us-ascii?Q?XNJLMGTN10qjAzrXGm0fAEs6MbTqRo5ur1Py3LZoNADmh++/1dupeSAM7/Iq?=
 =?us-ascii?Q?tTZSoQ79IjFklLIPVcOqMWQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ebeb76c-644c-48d6-2e26-08dbb4b73c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 00:12:09.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbniwVwpx/WVr/8N5L6TMwT09MZ7dhoWsztHGOPt3+K2+obpL827IX5cY7LeYfAd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWP152MB4410
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, hi Hans,

All correct Mark, thanks!

Thanks for the review Hans, I'm already doing the v2.
Just a note: there are some Lenovo Thunderbolt 4 docks that have 2 ethernet=
 devices inside, an intel ethernet device (loads igc driver, works with CPU=
s with vPRO feature) and a realtek ethernet device (realtek driver, works w=
ith CPU without vPRO feature). At this moment mac addr pass through doesn't=
 work correctly in these docking station if the Thinkpad CPU has vPRO featu=
re, and as Mark said, the idea is to release an open source application to =
work with the mac addr pt correctly.

Regards,
Fernando

________________________________________
From: Hans de Goede <hdegoede@redhat.com>
Sent: Wednesday, September 13, 2023 1:53 PM
To: Mark Pearson; Fernando Eckhardt Valle (FIPT); Henrique de Moraes Holsch=
uh; markgross@kernel.org; ibm-acpi-devel@lists.sourceforge.net; platform-dr=
iver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac

Hi Mark, Fernando,

On 9/13/23 18:41, Mark Pearson wrote:
>
>
> On Wed, Sep 13, 2023, at 11:58 AM, Hans de Goede wrote:
>> Hi Fernando,
>>
>> On 9/6/23 21:52, Fernando Eckhardt Valle wrote:
>>> Newer Thinkpads have a feature called Mac Address Passthrough.
>>> This patch provides a sysfs interface that userspace can use
>>> to get this auxiliary mac address.
>>>
>>> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
>>
>> Thank you for your patch.
>>
>> At a minimum for this patch to be accepted you will need
>> to document the new sysfs interface in:
>>
>> Documentation/admin-guide/laptops/thinkpad-acpi.rst
>>
>> But I wonder if we should export this information to
>> userspace in this way ?
>>
>> The reason why I'm wondering is because mac-address passthrough
>> in case of using e.g. Lenovo Thunderbolt docks is already
>> supported by the kernel by code for this in drivers/net/usb/r8152.c :
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
drivers/net/usb/r8152.c#n1613
>>
>> So I'm wondering if we really need this, is there a planned
>> userspace API consumer of the new sysfs interface ?
>>
>> Or is this only intended as a way for a user to query this, iow
>> is this purely intended for informational purposes ?
>>
> Hi Hans,
>
> We've previously had strong pushback from the maintainers in the net tree=
 that the MAC passthru should not be done there and should be done in user-=
space. I'd have to dig up the threads, but there was a preference for it to=
 not be done in the kernel (and some frustrations at having vendor specific=
 changes in the net driver).
>
> We've also seen various timing issues (some related to ME FW doing it's t=
hing) that makes it tricky to handle in the kernel - with added delays bein=
g needed leading to patches that can't be accepted.
>
> This approach is one of the steps towards fixing this. Fernando did discu=
ss and review this with me beforehand (apologies - I meant to add a note sa=
ying I'd been involved). If you think there is a better approach please let=
 us know, but we figured as this is a Lenovo specific thing it made sense t=
o have it here in thinkpad_acpi.
>
> There will be a consumer (I think it's a script and udev rule) to update =
the MAC if a passthru-MAC address is provided via the BIOS. This will be op=
en-source, but we haven't really figured out how to release it yet.
>
> Fernando - please correct anything I've gotten wrong!

Ah that is all good to know. That pretty much takes care of
my objections / answers my questions.

Fernando can you please submit a v2 which:

1. Adds documentation as mentioned already
2. Moves the special handling of "XXXXXXXXXXXX" from show()
   to init() (writing to auxmac[] in show() is a bit weird,
   also we only need to do this once, so it is init code)

Regards,

Hans

