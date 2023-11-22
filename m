Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4D7F4EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbjKVSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:07:09 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB51B3;
        Wed, 22 Nov 2023 10:07:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 12BDD3200AE3;
        Wed, 22 Nov 2023 13:07:03 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 22 Nov 2023 13:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700676423; x=1700762823; bh=D3ODkAsZ40xdTxpV02osQJ56S329xCPjg4P
        uzXonPT8=; b=rIMm0JKEtDtYeRFuAtCwmycbz4njOMNfIW23uySwhBBTcgmJR/r
        AR+UJCpo7Q9ur5wf8eoUFJNIahu1d+3HSwGuEtXzaKGrNZPi+xjiVpLpiQ2nk2nP
        C7U3mwoOQgrzIirWiY7JXIuQUG8+mrLSEekw5yUmlW9Nz+A8OA962yedsQAVoQbd
        jIAOv/uOjGqbFa5jdJcxf6nDEGXjDrNbh5dCsZmVEVlEb0PeyagLqNXZYuHRFbUv
        fpf32CfGsopjwIAozrGdK6iuYVrdqs5QdJBC/o62ixE1t+9vSvUn3PE5OxcYMKsZ
        qAk1nbIe9f7wTWZDjve1PbwovAxDQ8mx6Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700676423; x=1700762823; bh=D3ODkAsZ40xdTxpV02osQJ56S329xCPjg4P
        uzXonPT8=; b=JACtxRnkKYxyYX30Adu06DCNvVH2Mjyj6fpTSCGppQ79jB5Y3oC
        ctDQvIUUGx73Behb7A+QOPtNBaDC8rRE7ubGpBl3fJqlgt8WmNviswUFMoH/qYfo
        mcg0V9bWWfkZGvkN/c6W27IICta2VLxH61xyubvplK3T0+bDZBuX23aRSKShhT4a
        3YWBlq8iUnTlWg4R00iA+y2TgFqSWbY/FeonmG/lz8IY3bmVuagMwPQxYmsdSAp9
        1Ory5lgWR5dQsOJ8eYOSYv7FQcUmNvwOF+ZNffGvwhV/lHB6n4KQmTbzncjcTlZ7
        Tpk+eTVlmOM/i8DnFWm/ecXWhdC7G91i/5g==
X-ME-Sender: <xms:RkNeZSpFBrPPnTqDyY_Uy71xdp38iKlZyJZieUnxyh13SI7oJITpEA>
    <xme:RkNeZQpLfVKoQuqD7CAf0bWxcV4M9_DFJw3GQdG-d6na0JIEP4qEF0FfXn-c-ifjl
    eF8CTvZX_MGjjSl9HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpefhfeegudeftefgteelgfekgfdvjeelleev
    gffhjeffhfdtiedtjeefkedvuefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdr
    tggr
X-ME-Proxy: <xmx:RkNeZXNHXIFh6b6urMMVEvt-Ckhv7Dh0vpAgHbZDulWidyMAzVycJQ>
    <xmx:RkNeZR4qY9k00S4ioYA_h6mxfBzXbho-Tiny2iHEgmfaNWVhp_277w>
    <xmx:RkNeZR6n-7qqnpKuUxav7dBlOs9hFHe7nYtQKHjcPLnW9LqmeMR2cQ>
    <xmx:R0NeZbkIiCcbMNb-aV5MHw_uAqwJ4VjGsFDMXBtHQAnW11OZO_734g>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 629ADC6008B; Wed, 22 Nov 2023 13:07:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <ca976ed9-24c5-4c2f-95bf-3deaf1ad0dbc@app.fastmail.com>
In-Reply-To: <36bb8aaf-643c-4736-abe5-e5a911f24aa1@app.fastmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20231113165453.6335-1-mpearson-lenovo@squebb.ca>
 <c8a025e-2da2-693f-aa94-679aba79827b@linux.intel.com>
 <36bb8aaf-643c-4736-abe5-e5a911f24aa1@app.fastmail.com>
Date:   Wed, 22 Nov 2023 13:06:42 -0500
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Nov 13, 2023, at 12:15 PM, Mark Pearson wrote:
> Thanks Ilpo,
>
> On Mon, Nov 13, 2023, at 11:59 AM, Ilpo J=C3=A4rvinen wrote:
>> On Mon, 13 Nov 2023, Mark Pearson wrote:
>>
>>> Some new Thinkpads have a new improved performance mode available.
>>> Add support to make this mode usable.
>>>=20
>>> To avoid having to create a new profile, just use the improved perfo=
rmance
>>> mode in place of the existing performance mode, when available.
>>>=20
>>> Tested on P14s AMD G4 AMD.
>>>=20
>>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>> ---
>>> Changes in v2: updated implementation for DYTC_UP_SUPPORT define
>>> Changes in v3:=20
>>>  - Add in missing BIT for define, somehow lost in previous commit
>>>  - Cosmetic clean-ups
>>>=20
>>>  drivers/platform/x86/thinkpad_acpi.c | 28 +++++++++++++++++++++++++=
+++
>>>  1 file changed, 28 insertions(+)
>>>=20
>>> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform=
/x86/thinkpad_acpi.c
>>> index ad460417f901..3a9d2cc71b6a 100644
>>> --- a/drivers/platform/x86/thinkpad_acpi.c
>>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>>> @@ -10136,6 +10136,7 @@ static struct ibm_struct proxsensor_driver_d=
ata =3D {
>>> =20
>>>  #define DYTC_CMD_SET          1 /* To enable/disable IC function mo=
de */
>>>  #define DYTC_CMD_MMC_GET      8 /* To get current MMC function and =
mode */
>>> +#define DYTC_CMD_UP_CAP     0xA /* To get Ultra-performance capabil=
ity */
>>>  #define DYTC_CMD_RESET    0x1ff /* To reset back to default */
>>> =20
>>>  #define DYTC_CMD_FUNC_CAP     3 /* To get DYTC capabilities */
>>> @@ -10152,6 +10153,7 @@ static struct ibm_struct proxsensor_driver_d=
ata =3D {
>>> =20
>>>  #define DYTC_FUNCTION_STD     0  /* Function =3D 0, standard mode */
>>>  #define DYTC_FUNCTION_CQL     1  /* Function =3D 1, lap mode */
>>> +#define DYTC_FUNCTION_TMS     9  /* Function =3D 9, TMS mode */
>>>  #define DYTC_FUNCTION_MMC     11 /* Function =3D 11, MMC mode */
>>>  #define DYTC_FUNCTION_PSC     13 /* Function =3D 13, PSC mode */
>>>  #define DYTC_FUNCTION_AMT     15 /* Function =3D 15, AMT mode */
>>> @@ -10163,11 +10165,14 @@ static struct ibm_struct proxsensor_driver=
_data =3D {
>>>  #define DYTC_MODE_MMC_LOWPOWER 3  /* Low power mode */
>>>  #define DYTC_MODE_MMC_BALANCE  0xF  /* Default mode aka balanced */
>>>  #define DYTC_MODE_MMC_DEFAULT  0  /* Default mode from MMC_GET, aka=
 balanced */
>>> +#define DYTC_NOMODE            0xF  /* When Function does not have =
a mode */
>>> =20
>>>  #define DYTC_MODE_PSC_LOWPOWER 3  /* Low power mode */
>>>  #define DYTC_MODE_PSC_BALANCE  5  /* Default mode aka balanced */
>>>  #define DYTC_MODE_PSC_PERFORM  7  /* High power mode aka performanc=
e */
>>> =20
>>> +#define DYTC_UP_SUPPORT    BIT(8)  /* Ultra-performance (TMS) mode =
support */
>>> +
>>>  #define DYTC_ERR_MASK       0xF  /* Bits 0-3 in cmd result are the =
error result */
>>>  #define DYTC_ERR_SUCCESS      1  /* CMD completed successful */
>>> =20
>>> @@ -10185,6 +10190,7 @@ static enum platform_profile_option dytc_cur=
rent_profile;
>>>  static atomic_t dytc_ignore_event =3D ATOMIC_INIT(0);
>>>  static DEFINE_MUTEX(dytc_mutex);
>>>  static int dytc_capabilities;
>>> +static bool dytc_ultraperf_cap;
>>>  static bool dytc_mmc_get_available;
>>>  static int profile_force;
>>> =20
>>> @@ -10355,6 +10361,17 @@ static int dytc_profile_set(struct platform=
_profile_handler *pprof,
>>>  	if (err)
>>>  		goto unlock;
>>> =20
>>> +	/* Set TMS mode appropriately (enable for performance), if availab=
le */
>>> +	if (dytc_ultraperf_cap) {
>>> +		int cmd;
>>> +
>>> +		cmd =3D DYTC_SET_COMMAND(DYTC_FUNCTION_TMS, DYTC_NOMODE,
>>> +				       profile =3D=3D PLATFORM_PROFILE_PERFORMANCE);
>>> +		err =3D dytc_command(cmd, &output);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> +
>>>  	if (dytc_capabilities & BIT(DYTC_FC_MMC)) {
>>>  		if (profile =3D=3D PLATFORM_PROFILE_BALANCED) {
>>>  			/*
>>> @@ -10429,6 +10446,7 @@ static struct platform_profile_handler dytc_=
profile =3D {
>>>  static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
>>>  {
>>>  	int err, output;
>>> +	int cmd;
>>> =20
>>>  	/* Setup supported modes */
>>>  	set_bit(PLATFORM_PROFILE_LOW_POWER, dytc_profile.choices);
>>> @@ -10484,6 +10502,16 @@ static int tpacpi_dytc_profile_init(struct =
ibm_init_struct *iibm)
>>>  		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
>>>  		return -ENODEV;
>>>  	}
>>> +	err =3D dytc_command(DYTC_CMD_UP_CAP, &output);
>>
>> Hmm, are you missing error handling here?
>>
> Doh....yes, it should check that. My bad.
>
> I'll hold off a day or two on the next patch so I'm not spamming the=20
> list in case there is other feedback, and do a fix for that.=20
> I don't want the driver to error out on this - but it shouldn't check=20
> (and potentially enable) the feature if that register read fails. I=20
> will go and double check on some older platforms too as a sanity check.
>
> Thanks for the review.

Just an update, as it's taking me longer to get what I thought would be =
the final version of this patch done.

I did some regression testing on other platforms, as a sanity check, and=
 found on the Z16 G1 that it is reporting this feature as supported, but=
 unfortunately it doesn't work (it switches to low power mode)

This is a FW issue so I'm asking the FW team for clarification on why I'=
m seeing this, why it isn't working, and how to fix it.=20
This is going to take some time unfortunately, so this patch will be del=
ayed a bit. Apologies to anybody waiting for this improvement.

Thanks
Mark
