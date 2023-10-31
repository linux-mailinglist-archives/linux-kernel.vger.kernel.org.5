Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D907DD0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjJaPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjJaPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:45:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B97C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:45:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e308a751so2886518b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698767121; x=1699371921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDMn6VjQF1k7WEkEuAu9u0mRYqpGZqXcaUxhATLOUVo=;
        b=RqzY5BowHT6hwKXvJRZ/VRFyEeyNne1UOC5N37WouLvluvEB18kPaCJLwNQF7nCpH4
         olETJ9Asu7rQKx+qNVX8czoWsSY7FCu+N0y+eXEaiLjObe6vMhODRMFciHHykpNC/EQd
         ssYLoz05upEnfbzMn1qwguSlD2Kj86l1VCl6RGuRiUvLVvbZsyzklfxMPGHuPnJaq+Mb
         pTcfB2Gl2hnxenbjBZaXK6awLWRKh3UtDTnmkk+umobjHNu3WU62AXDkJpyAqGb5uxKX
         slksRp89A+QoWIOY3BPEkTuOqcMmqQZjCgzkRCEXENMwS6Kmnh2hVhP9fN57lS4/+5yn
         jLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698767121; x=1699371921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDMn6VjQF1k7WEkEuAu9u0mRYqpGZqXcaUxhATLOUVo=;
        b=py/EbOoIg+aeRYGRSo6x1yp8fO5BdI9KaDOL5E4HZo9YekEShkwH/j7zzLNlqY1xkG
         8BO3uW1lqMVNkBEVA6r5+US4B2HWtY0+/98SxXrIZZQmZyfnwTCeuzyyPWcEKV4oR4mL
         h9NmiFAMnRwjbSJlUVxmA7xPsqikj3nJ0c0VMiCaa/0yxmznpi1sXdtcVLgZZhKnH/cu
         kLfFBQLSTLxSyB8cTWvDMv8KpbM99IxD6RG1Eis3K24zxNbeq/GyXw78BaqnJpta6FuR
         +3XyG3V0A9bn4dqlHYhv9FEGVeLSo4TiSoJn/ULwLc9i/G00zVlOrtfxrdKvuwYNpWlv
         zxJw==
X-Gm-Message-State: AOJu0YyAqtXM1wR78/YUsGZem/jXPuDFkYhfFnMIKaGdna19XV7KCjo1
        nF9d3aMM8k6ntVRdlnLL9mhqy0ovdzEdBorkec0=
X-Google-Smtp-Source: AGHT+IHG7PK187QxPia9RBD3b232OrcIdwtdBd3pcQsUPkb24rXqRS5iYbjs0lE7RyNpT9ixX33uKv6YztrDFL1Rcts=
X-Received: by 2002:a05:6808:1445:b0:3a8:6a40:7dc0 with SMTP id
 x5-20020a056808144500b003a86a407dc0mr1652348oiv.18.1698767121615; Tue, 31 Oct
 2023 08:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231027165841.71810-1-jose.pekkarinen@foxhound.fi>
 <BL1PR12MB5144FA51BCB5DFD9A9F88A5BF7DCA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <634f769b7f723795180d5bd2186943b9@foxhound.fi>
In-Reply-To: <634f769b7f723795180d5bd2186943b9@foxhound.fi>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 31 Oct 2023 11:45:10 -0400
Message-ID: <CADnq5_M237bNMn=RZvBvPm4vymmUO07Xum7OQehhtAq2Yz55oA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: replace 1-element arrays with flexible-array members
To:     =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        skhan@linuxfoundation.org,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 8:05=E2=80=AFAM Jos=C3=A9 Pekkarinen
<jose.pekkarinen@foxhound.fi> wrote:
>
> On 2023-10-27 20:55, Deucher, Alexander wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> >> Sent: Friday, October 27, 2023 12:59 PM
> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> >> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> >> skhan@linuxfoundation.org
> >> Cc: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>; airlied@gmail.=
com;
> >> daniel@ffwll.ch; amd-gfx@lists.freedesktop.org; dri-
> >> devel@lists.freedesktop.org; linux-kernel@vger.kernel.org;
> >> linux-kernel-
> >> mentees@lists.linuxfoundation.org
> >> Subject: [PATCH] drm/radeon: replace 1-element arrays with
> >> flexible-array
> >> members
> >>
> >> Reported by coccinelle, the following patch will move the following 1
> >> element
> >> arrays to flexible arrays.
> >>
> >> drivers/gpu/drm/radeon/atombios.h:5523:32-48: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:5545:32-48: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:5461:34-44: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4447:30-40: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4236:30-41: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7044:24-37: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7054:24-37: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7095:28-45: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7553:8-17: WARNING use
> >> flexible-array
> >> member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7559:8-17: WARNING use
> >> flexible-array
> >> member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:3896:27-37: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:5443:16-25: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:5454:34-43: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4603:21-32: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:6299:32-44: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4628:32-46: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:6285:29-39: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4296:30-36: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4756:28-36: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:4064:22-35: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7327:9-24: WARNING use
> >> flexible-array
> >> member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7332:32-53: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:6030:8-17: WARNING use
> >> flexible-array
> >> member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7362:26-41: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7369:29-44: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7349:24-32: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >> drivers/gpu/drm/radeon/atombios.h:7355:27-35: WARNING use flexible-
> >> array member instead
> >> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-
> >> length-and-one-element-arrays)
> >>
> >> Signed-off-by: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> >
> > Please verify that changing these to variable sized arrays does not
> > break any calculations based on the old size in the driver.  More
> > below.
> >
> >> ---
> >>  drivers/gpu/drm/radeon/atombios.h | 54
> >> +++++++++++++++----------------
> >>  1 file changed, 27 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/atombios.h
> >> b/drivers/gpu/drm/radeon/atombios.h
> >> index 8a6621f1e82c..7fa1606be92c 100644
> >> --- a/drivers/gpu/drm/radeon/atombios.h
> >> +++ b/drivers/gpu/drm/radeon/atombios.h
> >> @@ -3893,7 +3893,7 @@ typedef struct _ATOM_GPIO_PIN_ASSIGNMENT
> >> typedef struct _ATOM_GPIO_PIN_LUT  {
> >>    ATOM_COMMON_TABLE_HEADER  sHeader;
> >> -  ATOM_GPIO_PIN_ASSIGNMENT   asGPIO_Pin[1];
> >> +  ATOM_GPIO_PIN_ASSIGNMENT   asGPIO_Pin[];
> >>  }ATOM_GPIO_PIN_LUT;
> >>
> >>
> >> /******************************************************************
> >> **********/
> >> @@ -4061,7 +4061,7 @@ typedef struct
> >> _ATOM_SRC_DST_TABLE_FOR_ONE_OBJECT         //usSrcDstTableOffset
> >>    UCHAR               ucNumberOfSrc;
> >>    USHORT              usSrcObjectID[1];
> >>    UCHAR               ucNumberOfDst;
> >> -  USHORT              usDstObjectID[1];
> >> +  USHORT              usDstObjectID[];
> >>  }ATOM_SRC_DST_TABLE_FOR_ONE_OBJECT;
> >>
> >>
> >> @@ -4233,7 +4233,7 @@ typedef struct
> >> _ATOM_CONNECTOR_DEVICE_TAG_RECORD
> >>    ATOM_COMMON_RECORD_HEADER   sheader;
> >>    UCHAR                       ucNumberOfDevice;
> >>    UCHAR                       ucReserved;
> >> -  ATOM_CONNECTOR_DEVICE_TAG   asDeviceTag[1];         //This Id is
> >> same as
> >> "ATOM_DEVICE_XXX_SUPPORT", 1 is only for allocation
> >> +  ATOM_CONNECTOR_DEVICE_TAG   asDeviceTag[];          //This Id is
> >> same as
> >> "ATOM_DEVICE_XXX_SUPPORT", 1 is only for allocation
> >>  }ATOM_CONNECTOR_DEVICE_TAG_RECORD;
> >>
> >>
> >> @@ -4293,7 +4293,7 @@ typedef struct
> >> _ATOM_OBJECT_GPIO_CNTL_RECORD
> >>    ATOM_COMMON_RECORD_HEADER   sheader;
> >>    UCHAR                       ucFlags;                // Future
> >> expnadibility
> >>    UCHAR                       ucNumberOfPins;         // Number of
> >> GPIO pins used to
> >> control the object
> >> -  ATOM_GPIO_PIN_CONTROL_PAIR  asGpio[1];              // the real
> >> gpio pin pair
> >> determined by number of pins ucNumberOfPins
> >> +  ATOM_GPIO_PIN_CONTROL_PAIR  asGpio[];               // the real
> >> gpio pin pair
> >> determined by number of pins ucNumberOfPins
> >>  }ATOM_OBJECT_GPIO_CNTL_RECORD;
> >>
> >>  //Definitions for GPIO pin state
> >> @@ -4444,7 +4444,7 @@ typedef struct
> >> _ATOM_BRACKET_LAYOUT_RECORD
> >>    UCHAR                       ucWidth;
> >>    UCHAR                       ucConnNum;
> >>    UCHAR                       ucReserved;
> >> -  ATOM_CONNECTOR_LAYOUT_INFO  asConnInfo[1];
> >> +  ATOM_CONNECTOR_LAYOUT_INFO  asConnInfo[];
> >>  }ATOM_BRACKET_LAYOUT_RECORD;
> >>
> >>
> >> /******************************************************************
> >> **********/
> >> @@ -4600,7 +4600,7 @@ typedef struct  _ATOM_I2C_VOLTAGE_OBJECT_V3
> >>     UCHAR    ucVoltageControlAddress;
> >>     UCHAR    ucVoltageControlOffset;
> >>     ULONG    ulReserved;
> >> -   VOLTAGE_LUT_ENTRY asVolI2cLut[1];        // end with 0xff
> >> +   VOLTAGE_LUT_ENTRY asVolI2cLut[];         // end with 0xff
> >>  }ATOM_I2C_VOLTAGE_OBJECT_V3;
> >>
> >>  // ATOM_I2C_VOLTAGE_OBJECT_V3.ucVoltageControlFlag
> >> @@ -4625,7 +4625,7 @@ typedef struct
> >> _ATOM_LEAKAGE_VOLTAGE_OBJECT_V3
> >>     UCHAR    ucLeakageEntryNum;           // indicate the entry number
> >> of
> >> LeakageId/Voltage Lut table
> >>     UCHAR    ucReserved[2];
> >>     ULONG    ulMaxVoltageLevel;
> >> -   LEAKAGE_VOLTAGE_LUT_ENTRY_V2 asLeakageIdLut[1];
> >> +   LEAKAGE_VOLTAGE_LUT_ENTRY_V2 asLeakageIdLut[];
> >>  }ATOM_LEAKAGE_VOLTAGE_OBJECT_V3;
> >>
> >>
> >> @@ -4753,7 +4753,7 @@ typedef struct _ATOM_POWER_SOURCE_INFO  {
> >>               ATOM_COMMON_TABLE_HEADER                asHeader;
> >>               UCHAR
> >>                                       asPwrbehave[16];
> >> -             ATOM_POWER_SOURCE_OBJECT                asPwrObj[1];
> >> +             ATOM_POWER_SOURCE_OBJECT                asPwrObj[];
> >>  }ATOM_POWER_SOURCE_INFO;
> >>
> >>
> >> @@ -5440,7 +5440,7 @@ typedef struct _ATOM_FUSION_SYSTEM_INFO_V2
> >> typedef struct _ATOM_I2C_DATA_RECORD  {
> >>    UCHAR         ucNunberOfBytes;
> >>         //Indicates how many
> >> bytes SW needs to write to the external ASIC for one block, besides to
> >> "Start"
> >> and "Stop"
> >> -  UCHAR         ucI2CData[1];
> >>         //I2C data in bytes,
> >> should be less than 16 bytes usually
> >> +  UCHAR         ucI2CData[];
> >>         //I2C data in bytes, should
> >> be less than 16 bytes usually
> >>  }ATOM_I2C_DATA_RECORD;
> >>
> >>
> >> @@ -5451,14 +5451,14 @@ typedef struct
> >> _ATOM_I2C_DEVICE_SETUP_INFO
> >>    UCHAR                                      ucSSChipID;
> >> //SS chip being used
> >>    UCHAR                                      ucSSChipSlaveAddr;
> >> //Slave Address to
> >> set up this SS chip
> >>    UCHAR                           ucNumOfI2CDataRecords;  //number of
> >> data block
> >> -  ATOM_I2C_DATA_RECORD            asI2CData[1];
> >> +  ATOM_I2C_DATA_RECORD            asI2CData[];
> >>  }ATOM_I2C_DEVICE_SETUP_INFO;
> >>
> >>
> >> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>  typedef struct  _ATOM_ASIC_MVDD_INFO
> >>  {
> >>    ATOM_COMMON_TABLE_HEADER         sHeader;
> >> -  ATOM_I2C_DEVICE_SETUP_INFO      asI2CSetup[1];
> >> +  ATOM_I2C_DEVICE_SETUP_INFO      asI2CSetup[];
> >>  }ATOM_ASIC_MVDD_INFO;
> >>
> >>
> >> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >> @@ -5520,7 +5520,7 @@ typedef struct _ATOM_ASIC_INTERNAL_SS_INFO
> >> typedef struct _ATOM_ASIC_INTERNAL_SS_INFO_V2  {
> >>    ATOM_COMMON_TABLE_HEADER         sHeader;
> >> -  ATOM_ASIC_SS_ASSIGNMENT_V2           asSpreadSpectrum[1];
> >> //this is point only.
> >> +  ATOM_ASIC_SS_ASSIGNMENT_V2           asSpreadSpectrum[];
> >> //this is point only.
> >>  }ATOM_ASIC_INTERNAL_SS_INFO_V2;
> >>
> >>  typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3 @@ -5542,7 +5542,7 @@
> >> typedef struct _ATOM_ASIC_SS_ASSIGNMENT_V3  typedef struct
> >> _ATOM_ASIC_INTERNAL_SS_INFO_V3  {
> >>    ATOM_COMMON_TABLE_HEADER         sHeader;
> >> -  ATOM_ASIC_SS_ASSIGNMENT_V3           asSpreadSpectrum[1];
> >> //this is pointer only.
> >> +  ATOM_ASIC_SS_ASSIGNMENT_V3           asSpreadSpectrum[];
> >> //this is pointer only.
> >>  }ATOM_ASIC_INTERNAL_SS_INFO_V3;
> >>
> >>
> >> @@ -6027,7 +6027,7 @@ typedef struct _ENABLE_SCALER_PARAMETERS
> >>    UCHAR ucScaler;            // ATOM_SCALER1, ATOM_SCALER2
> >>    UCHAR ucEnable;            // ATOM_SCALER_DISABLE or
> >> ATOM_SCALER_CENTER or ATOM_SCALER_EXPANSION
> >>    UCHAR ucTVStandard;        //
> >> -  UCHAR ucPadding[1];
> >> +  UCHAR ucPadding[];
> >
> > This may actually be a 1 element array.  It=E2=80=99s just padding at t=
he end
> > of the table.
> >
> >>  }ENABLE_SCALER_PARAMETERS;
> >>  #define ENABLE_SCALER_PS_ALLOCATION ENABLE_SCALER_PARAMETERS
> >>
> >> @@ -6282,7 +6282,7 @@ typedef union
> >> _ATOM_MEMORY_SETTING_ID_CONFIG_ACCESS
> >>
> >>  typedef struct _ATOM_MEMORY_SETTING_DATA_BLOCK{
> >>       ATOM_MEMORY_SETTING_ID_CONFIG_ACCESS
> >>       ulMemoryID;
> >> -     ULONG
> >>
> >> aulMemData[1];
> >> +     ULONG
> >>
> >> aulMemData[];
> >>  }ATOM_MEMORY_SETTING_DATA_BLOCK;
> >>
> >>
> >> @@ -6296,7 +6296,7 @@ typedef struct _ATOM_INIT_REG_BLOCK{
> >>       USHORT
> >>                                               usRegIndexTblSize;
> >>
> >>                       //size of asRegIndexBuf
> >>       USHORT
> >>                                               usRegDataBlkSize;
> >>
> >>                               //size of
> >> ATOM_MEMORY_SETTING_DATA_BLOCK
> >>       ATOM_INIT_REG_INDEX_FORMAT
> >>       asRegIndexBuf[1];
> >> -     ATOM_MEMORY_SETTING_DATA_BLOCK  asRegDataBuf[1];
> >> +     ATOM_MEMORY_SETTING_DATA_BLOCK  asRegDataBuf[];
> >>  }ATOM_INIT_REG_BLOCK;
> >>
> >
> > This one needs special handling as you have multiple variable sized
> > arrays.
>
>      I'm happy to add any special handling in v2, though
> I may need to understand what that special handling would
> be. Would you mind to elaborate? Otherwise I can just leave
> the sensitive cases and the paddings untouched and resend
> the patch with the rest of cases converted.


I'm not sure how we want to handle back to back variable sized arrays.
I'd say just skip these cases for now.

Alex

>
> >
> >>  #define END_OF_REG_INDEX_BLOCK  0x0ffff @@ -7041,7 +7041,7 @@
> >> typedef struct _ATOM_DISP_OUT_INFO
> >>       USHORT ptrTransmitterInfo;
> >>       USHORT ptrEncoderInfo;
> >>       ASIC_TRANSMITTER_INFO  asTransmitterInfo[1];
> >> -     ASIC_ENCODER_INFO      asEncoderInfo[1];
> >> +     ASIC_ENCODER_INFO      asEncoderInfo[];
> >
> > Same here.
> >
> >>  }ATOM_DISP_OUT_INFO;
> >>
> >>  typedef struct _ATOM_DISP_OUT_INFO_V2
> >> @@ -7051,7 +7051,7 @@ typedef struct _ATOM_DISP_OUT_INFO_V2
> >>       USHORT ptrEncoderInfo;
> >>    USHORT ptrMainCallParserFar;                  // direct address of
> >> main parser call
> >> in VBIOS binary.
> >>       ASIC_TRANSMITTER_INFO  asTransmitterInfo[1];
> >> -     ASIC_ENCODER_INFO      asEncoderInfo[1];
> >> +     ASIC_ENCODER_INFO      asEncoderInfo[];
> >
> > Same here.
> >
> >>  }ATOM_DISP_OUT_INFO_V2;
> >>
> >>
> >> @@ -7092,7 +7092,7 @@ typedef struct _ATOM_DISP_OUT_INFO_V3
> >>    UCHAR  ucCoreRefClkSource;                    // value of
> >> CORE_REF_CLK_SOURCE
> >>    UCHAR  ucDispCaps;
> >>    UCHAR  ucReserved[2];
> >> -  ASIC_TRANSMITTER_INFO_V2  asTransmitterInfo[1];     // for
> >> alligment only
> >> +  ASIC_TRANSMITTER_INFO_V2  asTransmitterInfo[];      // for
> >> alligment only
> >>  }ATOM_DISP_OUT_INFO_V3;
> >>
> >>  //ucDispCaps
> >> @@ -7324,12 +7324,12 @@ typedef struct
> >> _CLOCK_CONDITION_SETTING_ENTRY{
> >>    USHORT usMaxClockFreq;
> >>    UCHAR  ucEncodeMode;
> >>    UCHAR  ucPhySel;
> >> -  ULONG  ulAnalogSetting[1];
> >> +  ULONG  ulAnalogSetting[];
> >>  }CLOCK_CONDITION_SETTING_ENTRY;
> >>
> >>  typedef struct _CLOCK_CONDITION_SETTING_INFO{
> >>    USHORT usEntrySize;
> >> -  CLOCK_CONDITION_SETTING_ENTRY asClkCondSettingEntry[1];
> >> +  CLOCK_CONDITION_SETTING_ENTRY asClkCondSettingEntry[];
> >>  }CLOCK_CONDITION_SETTING_INFO;
> >>
> >>  typedef struct _PHY_CONDITION_REG_VAL{
> >> @@ -7346,27 +7346,27 @@ typedef struct _PHY_CONDITION_REG_VAL_V2{
> >> typedef struct _PHY_CONDITION_REG_INFO{
> >>    USHORT usRegIndex;
> >>    USHORT usSize;
> >> -  PHY_CONDITION_REG_VAL asRegVal[1];
> >> +  PHY_CONDITION_REG_VAL asRegVal[];
> >>  }PHY_CONDITION_REG_INFO;
> >>
> >>  typedef struct _PHY_CONDITION_REG_INFO_V2{
> >>    USHORT usRegIndex;
> >>    USHORT usSize;
> >> -  PHY_CONDITION_REG_VAL_V2 asRegVal[1];
> >> +  PHY_CONDITION_REG_VAL_V2 asRegVal[];
> >>  }PHY_CONDITION_REG_INFO_V2;
> >>
> >>  typedef struct _PHY_ANALOG_SETTING_INFO{
> >>    UCHAR  ucEncodeMode;
> >>    UCHAR  ucPhySel;
> >>    USHORT usSize;
> >> -  PHY_CONDITION_REG_INFO  asAnalogSetting[1];
> >> +  PHY_CONDITION_REG_INFO  asAnalogSetting[];
> >>  }PHY_ANALOG_SETTING_INFO;
> >>
> >>  typedef struct _PHY_ANALOG_SETTING_INFO_V2{
> >>    UCHAR  ucEncodeMode;
> >>    UCHAR  ucPhySel;
> >>    USHORT usSize;
> >> -  PHY_CONDITION_REG_INFO_V2  asAnalogSetting[1];
> >> +  PHY_CONDITION_REG_INFO_V2  asAnalogSetting[];
> >>  }PHY_ANALOG_SETTING_INFO_V2;
> >>
> >>  typedef struct _GFX_HAVESTING_PARAMETERS { @@ -7550,13 +7550,13
> >> @@ typedef struct _ATOM_TMDS_INFO  typedef struct
> >> _ATOM_ENCODER_ANALOG_ATTRIBUTE  {
> >>    UCHAR ucTVStandard;     //Same as TV standards defined above,
> >> -  UCHAR ucPadding[1];
> >> +  UCHAR ucPadding[];
> >
> > This may actually be a 1 element array.  It=E2=80=99s just padding at t=
he end
> > of the table.
> >
> >>  }ATOM_ENCODER_ANALOG_ATTRIBUTE;
> >>
> >>  typedef struct _ATOM_ENCODER_DIGITAL_ATTRIBUTE  {
> >>    UCHAR ucAttribute;      //Same as other digital encoder attributes
> >> defined
> >> above
> >> -  UCHAR ucPadding[1];
> >> +  UCHAR ucPadding[];
> >
> > Same here.
> >
> > Alex
> >
> >>  }ATOM_ENCODER_DIGITAL_ATTRIBUTE;
> >>
> >>  typedef union _ATOM_ENCODER_ATTRIBUTE
> >> --
> >> 2.39.2
>
>      Thanks for the comments!
>
>      Jos=C3=A9.
