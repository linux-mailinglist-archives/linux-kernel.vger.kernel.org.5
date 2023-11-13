Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6926D7EA1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjKMRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKMRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:15:45 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E23A99;
        Mon, 13 Nov 2023 09:15:42 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BFFFD5C0217;
        Mon, 13 Nov 2023 12:15:41 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 12:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699895741; x=1699982141; bh=Xjl3PNRx506qQQwOSRwtutB1hA6UYpeEKox
        JbO5Gnkw=; b=VVJnelt04xr7An3ZNx3CBH8DA55apBOBObvi4RSzti0koVspfE1
        qNbJpl06bYm8WqP24Y5eLizWnUoI+vGaVzSYPd9GRpCmkvpIL949ZPzIho0guXj0
        MQa/E1k0HBKCNyLLD0ITtbJ6XejDTATfhv/WManOXewwFdX1ErNUH+oqTQWPcMYr
        BBahN0bncWgKmOH1yP3Zn6q0J8i+J8OFt4ftwi+xc8jOWWR0FKQzLAIwAnZglAMs
        zufP2XOOlY0RDlrfMwYXCXpq+oDRQnGGaaN9dTw7XfCtggQpdfCQW2eMVa8qwl1n
        NysQ6xPUFiVRxZwhcqalvbbaYMVvWqKblDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699895741; x=1699982141; bh=Xjl3PNRx506qQQwOSRwtutB1hA6UYpeEKox
        JbO5Gnkw=; b=ZWod9TPuyH01dQsK7C6Old4FnZ9V4sTNrKGhmIdG6Rmdf1ixPMy
        fHyKQ6H+IrOr/oEdQhbLRX1aB019oSqyzD80r7SaHfqcXKcvdYHWYBYmx3DxrOw0
        fbvLizZMfrZagVqUeKe4M20Ffk1c3YdmcTRuLTQqMGW8iGzUfOgWfMaHoXMVa++Y
        U9342ROppG5YQ2bDv7GB8lQFvjghep8NWayx7ep8s6X1A7lVvqwaZBt2TRkxPWuA
        Nbz+qVorOtRLtphr94TZNtSOCOe1S5O1+FqNyuLsbzV8uX1Xp1UwU1vANtV9IUpi
        DquuK1AzIH395IFSlCkc5C54E07KMPNG9VA==
X-ME-Sender: <xms:vVlSZTBYjVGxdNmO0S4PYQjm2WpFuODVCMjfB8gUsN8fzv8ioNwm5A>
    <xme:vVlSZZjIn-o1XIlMoGv73gRaWPgTpnRDK__QbsQAZ5GqCFbXCdW-vA22tk1-ZAtJz
    Y99cSQ_cqnGeu3xp0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhephfefgedufeetgfetlefgkefgvdejleelvefg
    hfejfffhtdeitdejfeekvdeugfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:vVlSZelQwSe6UBOUu5fHM5coyocRTmri4TDlbjxeXSGubU2V2xJVuQ>
    <xmx:vVlSZVw1sIXRGWmhgXzVY-ulyippl2Yz8NqRQ9donS1_SG1CbgHpoA>
    <xmx:vVlSZYQkC3FaJycU9YnJkx4Jx5jQ9AhGwURM1SCC5wlETzyHWY_D9w>
    <xmx:vVlSZedwNdNuKwXvamJpeI4M47o05GDyJXn5NeUWmRjhAxaZRU7uaA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4CF54C6008B; Mon, 13 Nov 2023 12:15:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <36bb8aaf-643c-4736-abe5-e5a911f24aa1@app.fastmail.com>
In-Reply-To: <c8a025e-2da2-693f-aa94-679aba79827b@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
 <c8a025e-2da2-693f-aa94-679aba79827b@linux.intel.com>
Date:   Mon, 13 Nov 2023 12:15:20 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] platform/x86: Add support for improved performance mode
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

Thanks Ilpo,

On Mon, Nov 13, 2023, at 11:59 AM, Ilpo J=C3=A4rvinen wrote:
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
>> Changes in v3:=20
>>  - Add in missing BIT for define, somehow lost in previous commit
>>  - Cosmetic clean-ups
>>=20
>>  drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++=
++
>>  1 file changed, 28 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/=
x86/thinkpad_acpi.c
>> index ad460417f901..3a9d2cc71b6a 100644
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
>> +#define DYTC_UP_SUPPORT    BIT(8)  /* Ultra-performance (TMS) mode s=
upport */
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
>> +static bool dytc_ultraperf_cap;
>>  static bool dytc_mmc_get_available;
>>  static int profile_force;
>> =20
>> @@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform_=
profile_handler *pprof,
>>  	if (err)
>>  		goto unlock;
>> =20
>> +	/* Set TMS mode appropriately (enable for performance), if availabl=
e */
>> +	if (dytc_ultraperf_cap) {
>> +		int cmd;
>> +
>> +		cmd =3D DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
>> +				       profile =3D=3D PLATFORM_PROFILE_PERFORMANCE);
>> +		err =3D dytc_command(cmd, &output);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
>>  		if (profile =3D=3D PLATFORM_PROFILE_BALANCED) {
>>  			/*
>> @@ -10429,6 +10446,7 @@ static struct platform_profile_handler dytc_p=
rofile =3D {
>>  static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>>  {
>>  	int err, output;
>> +	int cmd;
>> =20
>>  	/* Setup supported modes */
>>  	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
>> @@ -10484,6 +10502,16 @@ static int tpacpi_dytc_profile_init(struct i=
bm_init_struct *iibm)
>>  		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
>>  		return -ENODEV;
>>  	}
>> +	err =3D dytc_command(DYTC_CMD_UP_CAP, &output);
>
> Hmm, are you missing error handling here?
>
Doh....yes, it should check that. My bad.

I'll hold off a day or two on the next patch so I'm not spamming the lis=
t in case there is other feedback, and do a fix for that.=20
I don't want the driver to error out on this - but it shouldn't check (a=
nd potentially enable) the feature if that register read fails. I will g=
o and double check on some older platforms too as a sanity check.

Thanks for the review.
Mark
