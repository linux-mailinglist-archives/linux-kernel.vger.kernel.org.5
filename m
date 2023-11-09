Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BED07E70F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbjKIR6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKIR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:57:59 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B1E3AA4;
        Thu,  9 Nov 2023 09:57:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C224E3200B2D;
        Thu,  9 Nov 2023 12:57:54 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Thu, 09 Nov 2023 12:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699552674; x=1699639074; bh=DiNtMHCvJlBRRcs2/MdFSEzoHFVrfsJaMw1
        wJMAOpZk=; b=G3VWv0Y9OSMHGJvQl6bnJxRC+tebRx8pnrMDdh175KCFmek4ggO
        AWFseQdJSeyGQfPHWd5qRK5Wv13RdvP7H5hD5prKKDvwZ9WSR0J/4IF1pm3CrkyP
        9ZzMBOUZk1NMKnkqS0XOIqyOgaqlgVNGh/wOhpZx4aA9jeu1oIkdw+P/NuVjcBj9
        g8W3m5M4Xjjr/1C9EnlipmUBlD44Za7331NYD2UZu28AFthnc/N2Kq5OH59zKHsx
        HCrUu9j8U/DLuUOaNzdTZiDzBwpVECGl8m/siWbCOoO3HcZHIdkf2/itb1V3loPO
        eQERe1/ryOuRWbcRxMsTtQriu4aAXsyBI8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699552674; x=1699639074; bh=DiNtMHCvJlBRRcs2/MdFSEzoHFVrfsJaMw1
        wJMAOpZk=; b=TButnu4I5d+rX4MhOPvEM38bOEtkUzCEoqhy0Sc5AQmM/m+HyOO
        4CDIMP6Z4iITCHCqofk3dsHQTErbYiqsCrSRxpbR3A0RrK7AjxBkWhKUatlnAPll
        Ixl4FodszVvolKrB755HaQaQZmW4ueyyFPLvmWRAdjlHrGbhmjpkPpQu9f38DxaO
        2GZ8Ic6Eb/53QD9dWfoSIEUqzb4WIdnRCxIgF+xG3Jxd+n8TKxoS/0ugyx0tna4+
        wvomgeB12OYQOMyUkGmlhVHMqGfuzCaANFfR/EgBeTA0IZ19q2GuzSccU/WBmkEw
        RRxbu6QjZk9hAkBMlE1lsvVALkyP9XW36Dw==
X-ME-Sender: <xms:oh1NZZeX1ddrEYo-ZKonttVS7qgdXOYOg_9MyVi__J_GQ6f3s61NLw>
    <xme:oh1NZXNRTcX-ST8yGvnb_rsINBbqS15vXUl_jLpjXfPpBOGpBMVihFFdo6k5M4lYe
    QGOoBMX0JO_5krcYRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpefhfeegudeftefgteelgfekgfdvjeelleev
    gffhjeffhfdtiedtjeefkedvuefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdr
    tggr
X-ME-Proxy: <xmx:oh1NZShYfUBC-7IlGLAwrgQAtoI8zLGeLXyWpT8OZCNIoJwkliXAEA>
    <xmx:oh1NZS_lVUzNGOG_7ZpFYddECLYgXw-II2xDedGZB4d-KMFuwN5Ebw>
    <xmx:oh1NZVuTEvLu5tE1zpiZf4il6ByDUylBOdJYrUiMWdgg-3JBMne-7Q>
    <xmx:oh1NZdKShoUxn__ZikJVILpTWbAiPuQ_CrfB1OIOFVX5_BpfvgLXzA>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F10DCC6008B; Thu,  9 Nov 2023 12:57:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <14312000-6369-4669-bcc9-4fa2abb5a98f@app.fastmail.com>
In-Reply-To: <8b29ab8-fef4-8a60-e6c5-447f31f144a7@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20231108162039.13737-1-mpearson-lenovo@squebb.ca>
 <8b29ab8-fef4-8a60-e6c5-447f31f144a7@linux.intel.com>
Date:   Thu, 09 Nov 2023 12:57:33 -0500
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: Add support for improved performance mode
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On Thu, Nov 9, 2023, at 5:10 AM, Ilpo J=C3=A4rvinen wrote:
> On Wed, 8 Nov 2023, Mark Pearson wrote:
>
>> Some new Thinkpads have a new improved performance mode available.
>> Add support to make this mode usable.
>>=20
>> To avoid having to create a new profile, just use the improved perfor=
mance
>> mode in place of the existing performance mode, when available.
>>=20
>> Tested on T14 AMD G4 AMD.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/platform/x86/thinkpad_acpi.c | 28 ++++++++++++++++++++++++++=
++
>>  1 file changed, 28 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/=
x86/thinkpad_acpi.c
>> index ad460417f901..eba701ab340e 100644
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
>> +#define DYTC_UP_SUPPORT_BIT    8  /* Bit 8 - 1 =3D supported, 0 =3D =
not */
>
> It would be preferrable to comment what is supported rather than have =
a=20
> comment like above which isn't particularly helpful.

OK - so  just have:
#define DYTC_UP_SUPPORT_BIT    8  /* Ultra-performance (TMS) mode suppor=
t */

Or...reading ahead in the review this should actually be
#define DYTC_UP_SUPPORT_BIT    BIT(8)  /* Ultra-performance (TMS) mode s=
upport */

>
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
>> +	dytc_ultraperf_cap =3D output & BIT(DYTC_UP_SUPPORT_BIT) ? true : f=
alse;
>
> It would be better to put this BIT() into the define itself and remove=20
> _BIT from the name because it doesn't really add that much information.
> Since you're assigning to bool, ? true : false construct is not requir=
ed=20
> but implicit cast will handle it for you. So in the end, this line wou=
ld=20
> be:
>
> 	dytc_ultraperf_cap =3D output & DYTC_UP_SUPPORT;

Agreed. I will make that change.
I'll wait and see if there is any more feedback and then do that with a =
v2 patch.

>
> Looking into the driver a bit more, there are a few other defines whic=
h=20
> could also move BIT() from the code into defines. Please tell if you'r=
e=20
> going to look at those because if not, I might try to make the patches.

Happy to look at doing that as I'm playing around with this driver anywa=
y.

Thanks for the review!
Mark

