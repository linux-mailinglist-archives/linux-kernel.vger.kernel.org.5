Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F837E9FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjKMPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKMPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:13:04 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E67132;
        Mon, 13 Nov 2023 07:13:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FC675C0191;
        Mon, 13 Nov 2023 10:12:58 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 10:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699888378; x=1699974778; bh=h5gaOu9/r6aDVdzTcY5rzq2g/nscqXBm93g
        9IH/eB1g=; b=Wr5KTRS2KYDrJQKU9/f8YOA8VDRMx3/+UdzMx3G/ZoeS9yAgWdC
        oDyroXRpYIHZMX+tNteCjBp7Sl1I2GAFxvAy4zXnbKrmuiF0ODRnsLV7C73kaffa
        Je5gLl5Uw4lDYNJrn07yHDKkdwnLKI68B1jAE8UJw5rypsSBBssgwavbxG5wpBA+
        9JkY9teH8nSW+RIXOeJIcI8dUUrYmFssucD8FC/WWCGEgq5t5ZZ5BfFfdiTWyAs0
        H17eRD2WGN7AXVGoVF3Wf53na6S84Ok0T6+xCbYLGZiTzIGRFtM3Gu6iLRpzsYKG
        kX4kT12mvfALgZ2869JsAyfzAzYZqbKGPrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699888378; x=1699974778; bh=h5gaOu9/r6aDVdzTcY5rzq2g/nscqXBm93g
        9IH/eB1g=; b=E34KAyv0E9BAx4q/E1QiunOy+cU/vAaPZwq2lk5Q9wKE9r5eSFc
        G+MHHuI4g3WvVAMmZ37Lo3PIX5fQU4WewY4uCnVze/IzBsAaB9vHPjPzgTuKvc6y
        lb8w09W8GWjnLVXHeIF+MW75dGQizKZ+PaPQEs69FLdzKq/iXddra4K0mowPsp+N
        SnoWrFcHJzoRtQnDfAD0bJt7MsE2HO+mhG8Unxq8EnEG6aAZNypB4upl4qda8wGH
        vGI0z/E/gM6PC63jiF5tQWEj3ng1XDjUbGeGDoTgiCV0kDTrs6m3W8ITcSVhJ1+M
        sOiDbdPqVvauzDWaCfRcCfVTkqif/sFpTqA==
X-ME-Sender: <xms:-TxSZY2tD1OZeLtSt0vEH9fMLlG_0sSkgZMYW7ngQDlA8aY13FB5BQ>
    <xme:-TxSZTGvi_8mT3W0xf6m8E5jH_7nmTw4ZemLpEVsP0fa3H7gpKrbY54z6gLfR-ZEp
    csaF4xArz7NF3Et5J0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:-TxSZQ72a0QiD_v3rYYW2emAs05rGEjIhAzBRAm-HLL2ez31Kf30Xg>
    <xmx:-TxSZR3E017XfD4gXqKAGdzT2CtrEIuBAQLtGrAUZJN_SF-6uBJJlg>
    <xmx:-TxSZbFSXM9U95fd-YZBDfgkPekkxJVE9E0oTmP-3bLXx_z4bcNu0w>
    <xmx:-jxSZTDkMGnavc8kNE1TzMRUsCxSBZBdWQK7sx1jnEno1Xj4wQWBQQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 73E67C6008B; Mon, 13 Nov 2023 10:12:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <46b4a4a2-2cf8-446c-b6d4-993697347e02@app.fastmail.com>
In-Reply-To: <17aa8729-11dd-c04a-fbcb-812121157ae@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20231113135741.4787-1-mpearson-lenovo@squebb.ca>
 <17aa8729-11dd-c04a-fbcb-812121157ae@linux.intel.com>
Date:   Mon, 13 Nov 2023 10:12:37 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: Add support for improved performance mode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 13, 2023, at 9:20 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 13 Nov 2023, Mark Pearson wrote:
>
>> Some new Thinkpads have a new improved performance mode available.
>> Add support to make this mode usable.
>>=20
>> To avoid having to create a new profile, just use the improved perfor=
mance
>> mode in place of the existing performance mode, when available.
>>=20
>> Tested on P14s AMD G4 AMD.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> Changes in v2: updated implementation for DYTC_UP_SUPPORT define
>>=20
>>  drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++=
++
>>  1 file changed, 28 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/=
x86/thinkpad_acpi.c
>> index ad460417f901..ed8860caa9c1 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -10136,6 +10136,7 @@ static struct ibm_struct proxsensor_driver_da=
ta =3D {
>> =20
>>  #define DYTC_CMD_SET          1 /* To enable/disable IC function mod=
e */
>>  #define DYTC_CMD_MMC_GET      8 /* To get current MMC function and m=
ode */
>> +#define DYTC_CMD_UP_CAP     0xA /* To get Ultra-performance capabili=
ty */
>>  #define DYTC_CMD_RESET    0x1ff /* To reset back to default */
>> =20
>>  #define DYTC_CMD_FUNC_CAP     3 /* To get DYTC capabilities */
>> @@ -10152,6 +10153,7 @@ static struct ibm_struct proxsensor_driver_da=
ta =3D {
>> =20
>>  #define DYTC_FUNCTION_STD     0  /* Function =3D 0, standard mode */
>>  #define DYTC_FUNCTION_CQL     1  /* Function =3D 1, lap mode */
>> +#define DYTC_FUNCTION_TMS     9  /* Function =3D 9, TMS mode */
>>  #define DYTC_FUNCTION_MMC     11 /* Function =3D 11, MMC mode */
>>  #define DYTC_FUNCTION_PSC     13 /* Function =3D 13, PSC mode */
>>  #define DYTC_FUNCTION_AMT     15 /* Function =3D 15, AMT mode */
>> @@ -10163,11 +10165,14 @@ static struct ibm_struct proxsensor_driver_=
data =3D {
>>  #define DYTC_MODE_MMC_LOWPOWER 3  /* Low power mode */
>>  #define DYTC_MODE_MMC_BALANCE  0xF  /* Default mode aka balanced */
>>  #define DYTC_MODE_MMC_DEFAULT  0  /* Default mode from MMC_GET, aka =
balanced */
>> +#define DYTC_NOMODE            0xF  /* When Function does not have a=
 mode */
>> =20
>>  #define DYTC_MODE_PSC_LOWPOWER 3  /* Low power mode */
>>  #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
>>  #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performance=
 */
>> =20
>> +#define DYTC_UP_SUPPORT        8  /* Ultra-performance (TMS) mode su=
pport */
>
> You forgot to add BIT() here. (But took it away from the other place=20
> so this patch is actually broken currently I think).
>
Oh....that's odd. I definitely added it (and tested it)...so I'm not sur=
e how I messed that up in the actual commit :(

Apologies - I'll re-post with it corrected.

>> +
>>  #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the e=
rror result */
>>  #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
>> =20
>> @@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_curr=
ent_profile;
>>  static atomic_t dytc_ignore_event =3D ATOMIC_INIT(0);
>>  static DEFINE_MUTEX(dytc_mutex);
>>  static int dytc_capabilities;
>> +static bool dytc_ultraperf_cap; /* ultra performance capable */
>
> I think the comment is repeating the same information already given in=
 the=20
> variable name so just drop the comment.
Ack

Mark
